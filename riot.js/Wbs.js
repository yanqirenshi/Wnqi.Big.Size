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

        for (var i in tree) {
            let node = tree[i];

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

            let children = this.flatten(node.children, level + 1, options);
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
        return location.hash + '/' + cls.toLowerCase() + '/' +code;
    };
}
