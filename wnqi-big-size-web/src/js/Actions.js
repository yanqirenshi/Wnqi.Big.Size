class Actions extends Simple_Redux_Actions {
    movePage (data) {
        return {
            type: 'MOVE-PAGE',
            data: data
        };
    }
    signIn (user_code) {
        API.post(
            '/api/v1/sign/in',
            { user_code: user_code },
            function (response) {
                this.signInCompleted(response);
            }.bind(this)
        );
    }
    signInCompleted (user_code) {
        location.hash='#cockpit/main';
    }
    signOut (user_code) {
        API.post(
            '/api/v1/sign/out',
            {},
            function (response) {
                this.signOutCompleted(response);
            }.bind(this)
        );
    }
    signOutCompleted (user_code) {
        location.hash='/';
    }
    loadProjects () {
        API.get('/api/v1/projects', function (response) {
            this.loadedProjects(response);
        }.bind(this));
    }
    loadedProjects (projects) {
        STORE.dispatch({
            type: 'LOADED-PROJECTS',
            data: {projects:projects}
        });
    }
    loadProject (code) {
        API.get('/api/v1/projects/' + code , function (response) {
            this.loadedProject(response);
        }.bind(this));
    }
    loadedProject (project) {
        STORE.dispatch({
            type: 'LOADED-PROJECT',
            data: {projects:project}
        });
    }
    loadWbs () {
        API.get('/api/v1/wbs', function (response) {
            this.loadedWbs(response);
        }.bind(this));
    }
    loadedWbs (projects) {
        STORE.dispatch({
            type: 'LOADED-WBS',
            data: {wbs:projects}
        });
    }
    loadActivities () {
        API.get('/api/v1/activities', function (response) {
            this.loadedActivities(response);
        }.bind(this));
    }
    loadedActivities (activities) {
        STORE.dispatch({
            type: 'LOADED-ACTIVITIES',
            data: {activities:activities}
        });
    }
    loadActions () {
        API.get('/api/v1/actions', function (response) {
            this.loadedActions(response);
        }.bind(this));
    }
    loadedActions (actions) {
        STORE.dispatch({
            type: 'LOADED-ACTIONS',
            data: {actions:actions}
        });
    }
    archiveAction (action_code, success) {
        let path ='/api/v1/actions/' + action_code + '/archive';
        let data = {};
        API.post(path, data, function (response) {
            if (success)
                success(response);
        }.bind(this));
    }
    startAction (action_code, success) {
        let path ='/api/v1/actions/' + action_code + '/start';
        let data = {};
        API.post(path, data, function (response) {
            if (success)
                success(response);
        }.bind(this));
    }
    stopAction (action_code, success) {
        let path ='/api/v1/actions/' + action_code + '/stop';
        let data = {};
        API.post(path, data, function (response) {
            if (success)
                success(response);
        }.bind(this));
    }
    moveBucketAction (action_code, bucket_code, success) {
        let path = '/api/v1/buckets/' + bucket_code + '/actions';
        let data = {
            action_code: action_code * 1
        };
        API.post(path, data, function (response) {
            if (success)
                success(response);
        }.bind(this));
    }
    selectBucket (page, bucket_code) {
        let pages = {};
        pages[page] = {
            selected: {
                bucket: bucket_code
            }
        };
        return {
            type: 'SELECT-BUCKET',
            data: {
                pages: pages
            }
        };

    }
    /* **************************************************************** */
    /* Page                                                             */
    /* **************************************************************** */
    loadPageCockpit () {
        API.get('/api/v1/pages/cockpit', function (response) {
            this.loadedPageCockpit(response);
        }.bind(this));
    }
    loadedPageCockpit (res) {
        let response = res ? res : {};

        STORE.dispatch({
            type: 'LOADED-PAGE-COCKPIT',
            data: {
                pages: {
                    cockpit: {
                        buckets: response.BUCKETS,
                        actions: response.ACTIONS,
                        actionHistories: response['ACTION-HISTORIES'],
                        actionStart: response['ACTION-START'],
                        activities: response.ACTIVITIES,
                        projects: response.PROJECTS,
                        wbs: response.WBS
                    }
                }
            }
        });
    }

    loadPageProjectsList () {
        API.get('/api/v1/pages/projects', function (response) {
            this.loadedPageProjectsList(response);
        }.bind(this));
    }
    loadedPageProjectsList (response) {
        STORE.dispatch({
            type: 'LOADED-PAGE-PROJECTS-LIST',
            data: {
                pages: {
                    projects: {
                        data: (response ? response : [])
                    }
                }
            }
        });
    }

    loadPageProjectsUnit (project_code) {
        API.get('/api/v1/pages/projects/' + project_code, function (response) {
            this.loadedPageProjectsUnit(response);
        }.bind(this));
    }
    loadedPageProjectsUnit (response) {
        STORE.dispatch({
            type: 'LOADED-PAGE-PROJECTS-UNIT',
            data: {
                pages: {
                    projects: {
                        unit: (response ? response : [])
                    }
                }
            }
        });
    }

    loadPageWBS (wbs_code) {
        API.get('/api/v1/pages/wbs/' + wbs_code, function (response) {
            this.loadedPageWBS(response);
        }.bind(this));
    }
    loadedPageWBS (res) {
        let response = res ? res : {};
        STORE.dispatch({
            type: 'LOADED-PAGE-WBS',
            data: {
                pages: {
                    wbs : {
                        activities: response.ACTIVITIES,
                        project: response.PROJECT,
                        wbs: response.WBS
                    }
                }
            }
        });
    }

    loadPageParsons () {
        API.get('/api/v1/pages/parsons', function (response) {
            this.loadedPageParsons(response);
        }.bind(this));
    }
    loadedPageParsons (res) {
        let response = res ? res : {};
        STORE.dispatch({
            type: 'LOADED-PAGE-PARSONS',
            data: {
                pages: {
                    parsons : {
                        parsons: response.PARSONS
                    }
                }
            }
        });
    }
    /* **************************************************************** */
    /* Groval menu                                                      */
    /* **************************************************************** */
    toggleGlobalMenuGroup (group_code) {
        let menus = this.copy_array(STORE.state().menus);
        for (var i in menus) {
            if (menus[i].group==group_code)
                menus[i].display = !menus[i].display;
        }
        STORE.dispatch({
            type: 'TOGGLE-GLOBAL-MENU-GROUP',
            data: {
                menus: menus
            }
        });
    }
    /* **************************************************************** */
    /* form                                                             */
    /* **************************************************************** */
    openForm (form_code) {
        let forms = Object.assign({},STORE.state().forms);
        forms[form_code].display = true;

        STORE.dispatch({
            type: 'OPEN-FORM',
            data: {
                forms : forms
            }
        });
    }
    closeForm (form_code) {
        let forms = Object.assign({},STORE.state().forms);

        if (!forms[form_code])
            return;

        forms[form_code].display = false;

        STORE.dispatch({
            type: 'CLOSE-FORM',
            data: {
                forms : forms
            }
        });
    }
    createAction (description, success) {
        API.post(
            '/api/v1/actions',
            { description: description },
            function (response) {
                success(response);
            }.bind(this)
        );
    }
    /* **************************************************************** */
    /* util                                                             */
    /* **************************************************************** */
    copy_array(arr) {
        let out = [];
        for (var i in arr)
            out.push(Object.assign({},arr[i]));
        return out;
    };
}
