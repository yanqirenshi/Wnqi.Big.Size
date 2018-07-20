var Request = new Ajax('http', 'localhost', '');
var ACTIONS = new Actions();
var REDUCER = new Reducer();
var STORE = new Simple_Redux_Store (REDUCER, {
    pages: {
        home: {
            tabs: {
                readme: {
                    code: 'readme',
                    label: 'README',
                    seq: 1,
                    display: true
                },
                wbs: {
                    code: 'wbs',
                    label: 'WBS',
                    seq: 2,
                    display: false
                },
                gtd: {
                    code: 'gtd',
                    label: 'GTD',
                    seq: 3,
                    display: false
                },
                organization: {
                    code: 'organization',
                    label: '組織',
                    seq: 4,
                    display: false
                },
                account: {
                    code: 'account',
                    label: 'アカウント',
                    seq: 5,
                    display: false
                },
                database: {
                    code: 'database',
                    label: 'データベース',
                    seq: 6,
                    display: false
                }
            }
        }
    }
});

route(function (a) {
    let len = arguments.length;
    let page = arguments[0];

    if (page=='') {
        location.hash = '#readme';
        return;
    }

    let pages = STORE.state().pages;
    let tabs = pages.home.tabs;
    for (var k in tabs)
        tabs[k].display = (tabs[k].code==page);

    STORE.dispatch(ACTIONS.movePage({
        pages: {
            home: {
                tabs: tabs
            }
        }
    }));
});
route.start(function () {
    let hash = location.hash;
    let len = hash.length;
    if (len==0)
        return '/';
    return hash.substring(1);
}());

riot.mount('app');
