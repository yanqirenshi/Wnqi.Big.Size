/*

  `/` の時はセッション情報の有無でページを移動する。
  セッション情報があるとき ⇒ `#cockpit/main` に移動する。
  セッション情報がないとき ⇒ `#sign-in` に移動する。

*/
let routingRoot = function (len, page) {
    if (len==1 && page=='') {
        location.hash='#sign-in';
        return;
    }
};
let routingCockpit = function (new_pages, tab_code) {
    if (!tab_code || tab_code=='')
        location.hash='#cockpit/main';

    let tabs = new_pages.cockpit.tabs;
    for (var i in tabs)
        tabs[i].display=(tabs[i].code==tab_code);

    return new_pages;
};
let routingProject = function (new_pages, project_code, tab_code) {
    let projects = new_pages.projects;

    if (project_code && project_code!='') {
        projects.unit.PROJECT = {project_code: project_code};
        projects.unit.WBS = [];

        if (!tab_code || tab_code!='')
            ACTIONS.loadPageProjectsUnit(project_code);

        if (tab_code) {
            for (var i in projects.unit.tabs) {
                let tab = projects.unit.tabs[i];
                tab.active = (tab.code==tab_code);
            }
        }
    }

    new_pages.projects = projects;

    return new_pages;
};
let routingWbs = function (new_pages, wbs_code, tab_code) {
    let page = new_pages.wbs;

    if (wbs_code && wbs_code!='') {
        page.wbs = {wbs_code: wbs_code};

        // if (!tab_code || tab_code!='')
        //    ACTIONS.loadPageWbs(wbs_code);

        if (tab_code) {
            for (var i in page.tabs) {
                let tab = page.tabs[i];
                tab.active = (tab.code==tab_code);
            }
        }
    }

    new_pages.wbs = page;

    return new_pages;
};

route(function (a) {
    let len = arguments.length;
    let page = arguments[0];
    let new_pages = STORE.state().pages;

    routingRoot(len, page);

    for (var k in new_pages)
        new_pages[k].display = (k==page);

    if (page=='cockpit')
        routingCockpit(new_pages, arguments[1]);

    if (page=='projects')
        routingProject(new_pages, arguments[1], arguments[2]);

    if (page=='wbs')
        routingWbs(new_pages, arguments[1], arguments[2]);

    STORE.dispatch(ACTIONS.movePage({
        pages: new_pages
    }));
});
