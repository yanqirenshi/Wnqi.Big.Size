class Store extends Simple_Redux_Store {
    constructor(reducer) {
        super(reducer, {});
    }
    init () {
        this._contents = {
            pages: this.initPages(),
            forms: this.initForms(),
            menus: this.initMenus()
        };
        return this;
    }
    initPages () {
        return {
            cockpit:    this.initPagesCockpit(),
            projects:   this.initPagesProjecs(),
            wbs:        this.initPagesWBS(),
            parsons:    { code: 'parsons',    name: 'Parsons',    display: false },
            activities: { code: 'activities', name: 'Activities', display: false },
            'sign-in':  { code: 'sign-in',    name: 'Sign in',    display: false }
        };
    }
    initPagesCockpit () {
        return {
            code: 'cockpit',
            name: 'Cockpit',
            display: false,
            tabs: [
                { code: 'main',       label: 'メイン',         href: '#cockpit/main',       display: false },
                { code: 'actions',    label: 'アクション',     href: '#cockpit/actions',    display: false },
                { code: 'activities', label: 'アクティビティ', href: '#cockpit/activities', display: false },
                { code: 'wbs',        label: 'WBS',            href: '#cockpit/wbs',        display: false },
                { code: 'projects',   label: 'プロジェクト',   href: '#cockpit/projects',   display: false }
            ],
            selected: {
                bucket: null,
                card: null
            }
        };
    }
    initPagesProjecs () {
        return {
            code: 'projects',
            name: 'Projects',
            display: false,
            unit: {
                PROJECT: null,
                WBS: [],
                tabs: [
                    {code:'overview', label: 'Overview', active: true},
                    {code:'gunnt',    label: 'Gunnt',    active: false},
                    {code:'evm',      label: 'Evm',      active: false},
                    {code:'wbs',      label: 'WBS',      active: false},
                    {code:'org',      label: 'Org',      active: false},
                    {code:'basic',    label: 'Basic',    active: false}
                ]
            }
        };
    }
    initPagesWBS () {
        return {
            code: 'wbs',
            name: 'WBS',
            display: false,
            wbs: null,
            project: null,
            activities: {
                vertex: _NODES,
                edge: _LINKS
            },
            tabs: [
                {code:'overview', label: 'Overview', active: true},
                {code:'activity', label: 'Activity', active: false},
                {code:'evm',      label: 'Evm',      active: false}
            ]
        };
    }
    initForms () {
        return {
            'create-action': {
                display: false
            }
        };
    }
    initMenus () {
        return _MENUS;
    }
}
