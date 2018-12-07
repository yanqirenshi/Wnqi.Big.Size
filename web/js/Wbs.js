class Wbs {
    /* **************************************************************** *
        Action
     * **************************************************************** */
    fixWorkpackageTerm (data) {
        if (data.schedule.start) data.schedule.start = new Date(data.schedule.start);
        if (data.schedule.end)   data.schedule.end   = new Date(data.schedule.end);
        if (data.result.start)   data.result.start   = new Date(data.result.start);
        if (data.result.end)     data.result.end     = new Date(data.result.end);

        let children = data.children;
        for (var i in children)
            this.fixWorkpackageTerm(children[i]);
    }
    fixSchedules(list) {
        let term = {start:null, end:null};

        for (var i in list) {
            let node = list[i];
            if (node.children.length!=0) {
                let term_children = this.fixSchedules(node.children);

                node.schedule.start = term_children.start;
                node.schedule.end   = term_children.end;
            }
            let schedule = node.schedule;
            if (!term.start && schedule.start) term.start = schedule.start;
            if (!term.end   && schedule.end)   term.end   = schedule.end;
            if (term.start  && schedule.start && (term.start > schedule.start)) term.start = schedule.start;
            if (term.end    && schedule.end   && (term.end   < schedule.end))   term.end   = schedule.end;
        }
        return term;
    }
    fixResults(list) {
        let term = {start:null, end:null};

        let exist_not_finished = false;
        for (var i in list) {
            let node = list[i];
            let result = node.result;

            if (node.children.length!=0) {
                let term_children = this.fixResults(node.children);

                result.start = term_children.start;
                result.end   = term_children.end;
            }

            // start
            if (!term.start && result.start) term.start = result.start;
            if (term.start  && result.start && (term.start > result.start)) term.start = result.start;

            // end
            if (!result.end) {
                exist_not_finished = true;
            } else {
                if (!term.end && result.end)
                    term.end   = result.end;
                if (term.end  && result.end && (term.end   < result.end))
                    term.end   = result.end;
            }
        }

        if (exist_not_finished)
            term.end = null;

        return term;
    }
    /* **************************************************************** *
        View
     * **************************************************************** */
    flattenInitOptions (options_in) {
        if (options_in) return options_in;

        return {
            hide: {
                wbs: {
                    finished: true
                },
                workpackage: {
                    finished: true
                }
            }
        };
    }
    flatten (tree, level, options_in) {
        let options = this.flattenInitOptions(options_in);
        let out = [];

        for (let node of tree) {
            node._level = level;

            if (node._class=="WBS") {
                if (options.hide.wbs.finished) {
                    if (!node.result.end)
                        out.push(node);
                } else {
                    out.push(node);
                }
            } else if (node._class=="WORKPACKAGE") {
                if (options.hide.workpackage.finished) {
                    if (!node.result.end)
                        out.push(node);
                } else {
                    out.push(node);
                }
            } else {
                out.push(node);
            }

            if (!node.children || node.children.length==0)
                continue;

            if (node._class=="WBS" && options.hide.wbs.finished && node.result.end)
                continue;

            let children = this.flatten(node.children.list, level + 1, options);
            out = out.concat(children);
        }

        return out;
    }
    date2str (date) {
        if (!date)
            return '---';

        return moment(date).format('YYYY-MM-DD (ddd)');
    }
    margin (level) {
        let out = "";

        for (let i=0; i<level ;i++)
            out += "　";

        return out;
    }
    projectClass (str) {
        return str.toLowerCase();
    };
    hashWbsPage (code, cls) {
        return location.hash.split('/')[0] + '/' + cls.toLowerCase() + '/' +code;
    };
    /* **************************************************************** *
        New
     * **************************************************************** */
    treeNodeLabel (core) {
        if (core.name)
            return core.name;
        return '???';
    }
    makeTreeNode (core) {
        return {
            label: this.treeNodeLabel(core),
            core: core,
            children: { ht:{}, list: [] },
            _id: core._id,
            _class: core._class,
        };
    };
    getEdgeChildNodePoolKey (_class) {
        switch (_class) {
        case 'PROJECT':     return 'projects';
        case 'WBS':         return 'wbs';
        case 'WORKPACKAGE': return 'workpackages';
        }
        return null;
    }
    getEdgeChildNode (edge, pool) {
        let _id = edge.to_id;
        let poolkey = this.getEdgeChildNodePoolKey(edge.to_class);
        let children_ht  = pool[poolkey].ht;

        return children_ht[_id];
    }
    mergeSchedule(type, old_term, new_term) {
        let old_val = old_term ? old_term[type] : null;
        let new_val = new_term ? new_term[type] : null;

        if (!old_val) return new_val;
        if (!new_val) return old_val;

        if (type=='start' && new_val.isBefore(old_val))
            return new_val;

        if (type=='end' && new_val.isAfter(old_val))
            return new_val;

        return old_val;
    }
    mergeResult(type, old_term, new_term) {
        let old_val = old_term ? old_term[type] : null;
        let new_val = new_term ? new_term[type] : null;

        if (!old_val) return new_val;
        if (!new_val) return old_val;

        if (type=='start' && new_val.isBefore(old_val))
            return new_val;

        if (type=='end' && new_val.isAfter(old_val))
            return new_val;

        return old_val;
    }
    setTerms (parent_node, children) {
        let schedule = { start: null, end: null };
        let result = { start: null, end: null };
        let result_null_exist = false;

        for (let child of children) {
            let child_schedule = child.core.schedule;

            schedule.start = this.mergeSchedule('start', schedule, child_schedule);
            schedule.end   = this.mergeSchedule('end',   schedule, child_schedule);

            let child_result = child.core.result;
            result.start = this.mergeResult('start', result, child_result);
            result.end   = this.mergeResult('end',   result, child_result);

            if (!child_result.end)
                result_null_exist = true;
        }

        if (result_null_exist)
            result.end = null;

        return { schedule: schedule, result: result };
    }
    addChildren(parent_node, pool) {
        let parent = parent_node.core;
        let children = parent_node.children;

        for (let edge of pool.edges.list)
            if (edge.from_id==parent._id && edge.from_class==parent._class) {
                let child = this.getEdgeChildNode(edge, pool);
                let child_node = this.makeTreeNode(child);

                this.addChildren(child_node, pool);

                children.list.push(child_node);
                children.ht[child_node.core._id] = child_node;
            }

        if (parent._class!='WORKPACKAGE') {
            let terms = this.setTerms(parent_node, children.list);

            parent.schedule = terms.schedule;
            parent.result   = terms.result;

            parent_node.schedule = terms.schedule;
            parent_node.result   = terms.result;
        } else {
            parent_node.schedule = parent.schedule;
            parent_node.result   = parent.result;
        }

        return parent_node;
    }
    composeTree (project, wbs, workpackages, edges) {
        let out = [];
        let pool = {
            wbs: wbs,
            workpackages: workpackages,
            edges: edges
        };

        let project_node = this.makeTreeNode(project);

        return this.addChildren(project_node, pool);
    }
    composeTreeFlat (project, wbs, workpackages, edges) {
        let tree = this.composeTree(project, wbs, workpackages, edges);
        let flat_tree = this.flatten([tree], 0);

        return flat_tree;
    }
}
