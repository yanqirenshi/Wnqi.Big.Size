class Store extends Vanilla_Redux_Store {
    constructor(reducer) {
        super(reducer, Immutable.Map({}));
    }
    pages() {
        return [
            {
                code: "home", menu_label: '家',
                active_section: 'root', home_section: 'root',
                children: [
                    { code: 'root', tag: 'home_page_root' },
                ],
                stye: {
                    color: { 1: '#fdeff2', 2: '#e0e0e0', 3: '#e198b4', 4: '#ffffff', 5: '#eeeeee', 5: '#333333' }
                }
            },
            {
                code: "example", menu_label: '試',
                active_section: 'root', home_section: 'root',
                children: [{ code: 'root', tag: 'example_page_root' }],
                stye: {
                    color: { 1: '#fdeff2', 2: '#e0e0e0', 3: '#e198b4', 4: '#ffffff', 5: '#eeeeee', 5: '#333333' }
                }
            },
            {
                code: "models", menu_label: '型',
                active_section: 'root', home_section: 'root',
                children: [{ code: 'root', tag: 'models_page_root' }],
                stye: {
                    color: { 1: '#fdeff2', 2: '#e0e0e0', 3: '#e198b4', 4: '#ffffff', 5: '#eeeeee', 5: '#333333' }
                }
            },
        ];
    }
    makePool (list) {
        let ht = {};
        for (let obj of list)
            ht[obj._id] = obj;

        return { ht: ht, list: list };
    }
    // ////////////////////////////////////////////////////////////////
    //   Example
    // ////////////////////////////////////////////////////////////////
    intiExampleProjects () {
        return [
            {
                _class: "PROJECT",
                _id: 1,
                description: "",
                name: "Project 1",
                result: null,
                schedule: null,
            }
        ];
    }
    initExampleWbs () {
        return [
            {
                _class: "WBS",
                _id: this._id_counter++,
                description: "",
                name: "WBS 1",
                result: null,
                schedule: null,
            },
            {
                _class: "WBS",
                _id: this._id_counter++,
                description: "",
                name: "WBS 2",
                result: null,
                schedule: null,
            }
        ];
    }
    initExampleWorkpackage () {
        return [
            {
                _class: "WORKPACKAGE",
                _id: 10,
                description: "",
                name: "Workpackage 1",
                result:   {_id: 461, start: new Date(), end: new Date(), _class: "RESULT"},
                schedule: {_id: 459, start: new Date(), end: new Date(), _class: "SCHEDULE"},
            },
        ];
    }
    initExampleEdges () {
        return [
            {
                _class: "EDGE",
                _id: 100,
                from_class: "PROJECT",
                from_id: 1,
                start: [],
                to_class: "WBS",
                to_id: 2,
            },
            {
                _class: "EDGE",
                _id: 101,
                from_class: "PROJECT",
                from_id: 1,
                start: [],
                to_class: "WBS",
                to_id: 3,
            },
            {
                _class: "EDGE",
                _id: 101,
                from_class: "WBS",
                from_id: 3,
                start: [],
                to_class: "WORKPACKAGE",
                to_id: 10,
            },
        ];
    }
    // ////////////////////////////////////////////////////////////////
    //   Models
    // ////////////////////////////////////////////////////////////////
    initModelsProject () {
        return {
            _class: "PROJECT",
            _id: 1,
            description: "",
            name: "Project 1",
            result: null,
            schedule: null,
        };
    }
    initModelsWbs () {
        return {
            _class: "WBS",
            _id: 2,
            description: "",
            name: "WBS 1",
            result: null,
            schedule: null,
        };
    }
    initModelsWorkpackage () {
        return {
            _class: "WORKPACKAGE",
            _id: 10,
            description: "",
            name: "Workpackage 1",
            result:   {_id: 461, start: new Date(), end: new Date(), _class: "RESULT"},
            schedule: {_id: 459, start: new Date(), end: new Date(), _class: "SCHEDULE"},
        };
    }
    initModelsEdge () {
        return {
            _class: "EDGE",
            _id: 100,
            from_class: "PROJECT",
            from_id: 1,
            to_class: "WBS",
            to_id: 2,
        };
    }
    // ////////////////////////////////////////////////////////////////
    //   Models
    // ////////////////////////////////////////////////////////////////
    init () {
        let data = {
            site: {
                active_page: 'home',
                home_page: 'home',
                pages: this.pages(),
            },
            example: {
                projects:     this.makePool(this.intiExampleProjects()),
                wbs:          this.makePool(this.initExampleWbs()),
                workpackages: this.makePool(this.initExampleWorkpackage()),
                edges:        this.makePool(this.initExampleEdges()),
            },
            models: {
                project:     this.initModelsProject(),
                wbs:         this.initModelsWbs(),
                workpackage: this.initModelsWorkpackage(),
                edge:        this.initModelsEdge(),
            },
        };

        for (var i in data.site.pages) {
            let page = data.site.pages[i];

            for (var k in page.children) {
                let section = page.children[k];
                let hash = '#' + page.code;

                if (section.code!='root')
                    hash += '/' + section.code;

                section.hash = hash;
            }
        }

        this._contents = Immutable.Map(data);
        return this;
    }
}
