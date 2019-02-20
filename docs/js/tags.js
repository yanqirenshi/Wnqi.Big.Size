riot.tag2('app', '<menu-bar brand="{{label:\'RT\'}}" site="{site()}" moves="{[]}"></menu-bar> <div ref="page-area"></div>', 'app > .page { width: 100vw; height: 100vh; overflow: hidden; display: block; } app .hide,[data-is="app"] .hide{ display: none; }', '', function(opts) {
     this.site = () => {
         return STORE.state().get('site');
     };

     STORE.subscribe((action)=>{
         if (action.type!='MOVE-PAGE')
             return;

         let tags= this.tags;

         tags['menu-bar'].update();
         ROUTER.switchPage(this, this.refs['page-area'], this.site());
     })

     window.addEventListener('resize', (event) => {
         this.update();
     });

     if (location.hash=='')
         location.hash=STORE.get('site.active_page');
});

riot.tag2('markdown-preview', '', 'markdown-preview h1 { font-weight: bold; font-size: 20px; margin-top: 11px; margin-bottom: 6px; } markdown-preview h2 { font-weight: bold; font-size: 18px; margin-top: 8px; margin-bottom: 4px; } markdown-preview h3 { font-weight: bold; font-size: 16px; margin-top: 6px; margin-bottom: 3px; } markdown-preview h4 { font-weight: bold; font-size: 14px; margin-top: 6px; margin-bottom: 3px; } markdown-preview h5 { font-weight: bold; font-size: 12px; margin-bottom: 4px; } markdown-preview * { font-size: 12px; } markdown-preview table { border-collapse: collapse; } markdown-preview td { border: solid 0.6px #888888; padding: 2px 5px; } markdown-preview th { border: solid 0.6px #888888; padding: 2px 5px; background: #eeeeee; }', '', function(opts) {
     this.on('update', () => {
         this.root.innerHTML = this.opts.data;
     });

    this.root.innerHTML = opts.data

});

riot.tag2('menu-bar', '<aside class="menu"> <p ref="brand" class="menu-label" onclick="{clickBrand}"> {opts.brand.label} </p> <ul class="menu-list"> <li each="{opts.site.pages}"> <a class="{opts.site.active_page==code ? \'is-active\' : \'\'}" href="{\'#\' + code}"> {menu_label} </a> </li> </ul> </aside> <div class="move-page-menu hide" ref="move-panel"> <p each="{moves()}"> <a href="{href}">{label}</a> </p> </div>', 'menu-bar .move-page-menu { z-index: 666665; background: #ffffff; position: fixed; left: 55px; top: 0px; min-width: 111px; height: 100vh; box-shadow: 2px 0px 8px 0px #e0e0e0; padding: 22px 55px 22px 22px; } menu-bar .move-page-menu.hide { display: none; } menu-bar .move-page-menu > p { margin-bottom: 11px; } menu-bar > .menu { z-index: 666666; height: 100vh; width: 55px; padding: 11px 0px 11px 11px; position: fixed; left: 0px; top: 0px; background: #c89932; } menu-bar .menu-label, menu-bar .menu-list a { padding: 0; width: 33px; height: 33px; text-align: center; margin-top: 8px; border-radius: 3px; background: none; color: #ffffff; font-weight: bold; padding-top: 7px; font-size: 14px; } menu-bar .menu-label,[data-is="menu-bar"] .menu-label{ background: #ffffff; color: #c89932; } menu-bar .menu-label.open,[data-is="menu-bar"] .menu-label.open{ background: #ffffff; color: #c89932; width: 45px; border-radius: 3px 0px 0px 3px; text-shadow: 0px 0px 1px #eee; padding-right: 11px; } menu-bar .menu-list a.is-active { width: 45px; padding-right: 11px; border-radius: 3px 0px 0px 3px; background: #ffffff; color: #333333; }', '', function(opts) {
     this.moves = () => {
         let moves = [
             { code: 'link-a', href: '', label: 'Link A' },
             { code: 'link-b', href: '', label: 'Link B' },
             { code: 'link-c', href: '', label: 'Link C' },
         ]
         return moves.filter((d)=>{
             return d.code != this.opts.current;
         });
     };

     this.brandStatus = (status) => {
         let brand = this.refs['brand'];
         let classes = brand.getAttribute('class').trim().split(' ');

         if (status=='open') {
             if (classes.find((d)=>{ return d!='open'; }))
                 classes.push('open')
         } else {
             if (classes.find((d)=>{ return d=='open'; }))
                 classes = classes.filter((d)=>{ return d!='open'; });
         }
         brand.setAttribute('class', classes.join(' '));
     }

     this.clickBrand = () => {
         let panel = this.refs['move-panel'];
         let classes = panel.getAttribute('class').trim().split(' ');

         if (classes.find((d)=>{ return d=='hide'; })) {
             classes = classes.filter((d)=>{ return d!='hide'; });
             this.brandStatus('open');
         } else {
             classes.push('hide');
             this.brandStatus('close');
         }
         panel.setAttribute('class', classes.join(' '));
     };
});

riot.tag2('modal-description-editor', '<div class="modal {isActive()}"> <div class="modal-background"></div> <div class="modal-content" style="width: 88vw;"> <div class="card"> <div class="card-content" style="height: 88vh;"> <div style="display:flex; height: 100%; width: 100%;flex-direction: column;"> <div style="margin-bottom:11px;"> <h1 class="title is-4">{title()} の Description の変更</h1> </div> <div style="display:flex; flex-grow: 1"> <div style="flex-grow: 1;margin-right: 8px;"> <div class="element-container"> <h1 class="title is-5">Markdown</h1> <textarea class="input" ref="description" onkeyup="{inputDescription}">{description()}</textarea> </div> </div> <div style=";flex-grow: 1;margin-left: 8px;"> <div class="element-container"> <h1 class="title is-5">Preview</h1> <div class="preview" style="padding: 0px 11px 11px 11px;"> <markdown-preview data="{marked(markdown)}"></markdown-preview> </div> </div> </div> </div> <div style="margin-top:11px;"> <button class="button is-warning" onclick="{clickCancel}">Cancel</button> <button class="button is-danger" style="float:right;" onclick="{clickSave}">Save</button> </div> </div> </div> </div> </div> </div>', 'modal-description-editor .element-container { display:flex; height: 100%; width: 100%; flex-direction: column; } modal-description-editor .element-container .title{ margin-bottom:6px; } modal-description-editor .input { border: 1px solid #eeeeee; padding: 11px; box-shadow: none; height: 100%; width: 100%; } modal-description-editor .preview { border: 1px solid #eeeeee; flex-grow:1; }', '', function(opts) {
     this.markdown = null;

     this.clickCancel = () => {
         this.opts.callback('close-modal-description-editor');
     };
     this.clickSave = () => {
         this.opts.callback('save-column-instance-description', {
             object: this.opts.data,
             value: this.refs['description'].value,
         });
     };
     this.inputDescription = () => {
         this.markdown = this.refs['description'].value;

         this.tags['markdown-preview'].update();
     };

     this.description = () => {
         if (!this.markdown) {
             let obj = this.opts.data;

             this.markdown = !obj ? '' : obj.description;
         }

         return this.markdown;
     };
     this.title = () => {
         if (!this.opts.data)
             return '';

         let obj = this.opts.data;
         return obj._class + ':' + obj.name;
     };
     this.isActive = () => {
         return this.opts.data ? 'is-active' : '';
     };
});

riot.tag2('page-tabs', '<div class="tabs is-boxed" style="padding-left:55px;"> <ul> <li each="{opts.core.tabs}" class="{opts.core.active_tab==code ? \'is-active\' : \'\'}"> <a code="{code}" onclick="{clickTab}">{label}</a> </li> </ul> </div>', 'page-tabs li:first-child { margin-left: 55px; }', '', function(opts) {
     this.clickTab = (e) => {
         let code = e.target.getAttribute('code');
         this.opts.callback(e, 'CLICK-TAB', { code: code });
     };
});

riot.tag2('section-breadcrumb', '<section-container data="{path()}"> <nav class="breadcrumb" aria-label="breadcrumbs"> <ul> <li each="{opts.data}"> <a class="{active ? \'is-active\' : \'\'}" href="{href}" aria-current="page">{label}</a> </li> </ul> </nav> </section-container>', 'section-breadcrumb section-container > .section,[data-is="section-breadcrumb"] section-container > .section{ padding-top: 3px; }', '', function(opts) {
     this.path = () => {
         let hash = location.hash;
         let path = hash.split('/');

         if (path[0] && path[0].substr(0,1)=='#')
             path[0] = path[0].substr(1);

         let out = [];
         let len = path.length;
         let href = null;
         for (var i in path) {
             href = href ? href + '/' + path[i] : '#' + path[i];

             if (i==len-1)
                 out.push({
                     label: path[i],
                     href: hash,
                     active: true
                 });

             else
                 out.push({
                     label: path[i],
                     href: href,
                     active: false
                 });
         }
         return out;
     }
});

riot.tag2('section-container', '<section class="section"> <div class="container"> <h1 class="title is-{opts.no ? opts.no : 3}"> {opts.title} </h1> <h2 class="subtitle">{opts.subtitle}</h2> <yield></yield> </div> </section>', '', '', function(opts) {
});

riot.tag2('section-contents', '<section class="section"> <div class="container"> <h1 class="title is-{opts.no ? opts.no : 3}"> {opts.title} </h1> <h2 class="subtitle">{opts.subtitle}</h2> <div class="contents"> <yield></yield> </div> </div> </section>', 'section-contents > section.section { padding: 0.0rem 1.5rem 2.0rem 1.5rem; }', '', function(opts) {
});

riot.tag2('section-footer', '<footer class="footer"> <div class="container"> <div class="content has-text-centered"> <p> </p> </div> </div> </footer>', 'section-footer > .footer { background: #ffffff; padding-top: 13px; padding-bottom: 13px; }', '', function(opts) {
});

riot.tag2('section-header-with-breadcrumb', '<section-header title="{opts.title}"></section-header> <section-breadcrumb></section-breadcrumb>', 'section-header-with-breadcrumb section-header > .section,[data-is="section-header-with-breadcrumb"] section-header > .section{ margin-bottom: 3px; }', '', function(opts) {
});

riot.tag2('section-header', '<section class="section"> <div class="container"> <h1 class="title is-{opts.no ? opts.no : 3}"> {opts.title} </h1> <h2 class="subtitle">{opts.subtitle}</h2> <yield></yield> </div> </section>', 'section-header > .section { background: #ffffff; }', '', function(opts) {
});

riot.tag2('section-list', '<table class="table is-bordered is-striped is-narrow is-hoverable"> <thead> <tr> <th>機能</th> <th>概要</th> </tr> </thead> <tbody> <tr each="{data()}"> <td><a href="{hash}">{title}</a></td> <td>{description}</td> </tr> </tbody> </table>', '', '', function(opts) {
     this.data = () => {
         return opts.data.filter((d) => {
             if (d.code=='root') return false;

             let len = d.code.length;
             let suffix = d.code.substr(len-5);
             if (suffix=='_root' || suffix=='-root')
                 return false;

             return true;
         });
     };
});

riot.tag2('wbs-guntt-chart', '<div style="overflow:auto;"> <svg class="chart-yabane"></svg> </div>', '', '', function(opts) {
     this.on('update', (action) => {
         let tree = this.opts.data ? this.opts.data : [];
         let selector = 'svg.chart-yabane';

         let options = {
             stage: {
                 selector: selector,
                 padding: 11,
             },
             scale: this.opts.options.scale,
         };

         let d3yabane = new D3jsYabane({ callback: this.opts.callback })
             .config(options)
             .setScale()
             .makeStage()
             .data(tree)
             .draw();
     });
});

riot.tag2('wbs-tree-list', '<table class="table is-bordered is-narrow is-hoverable is-fullwidth"> <thead> <tr> <th rowspan="2">Code</th> <th rowspan="2">Name</th> <th colspan="4">Schedule</th> <th colspan="4">Result</th> <th class="{hideOperators()}" rowspan="2">操作</th> </tr> <tr> <th colspan="2">start</th> <th colspan="2">end</th> <th colspan="2">start</th> <th colspan="2">end</th> </tr> </thead> <tbody> <tr each="{tableData()}" class="{tool.projectClass(_core._class)}"> <td nowrap> <a href="{tool.hashWbsPage(_core._id, _core._class)}">{_core._id}</a> </td> <td nowrap> <span class="tree-mergin">{tool.margin(_level)}</span> <span>{_core.name}</span> </td> <td class="{_class}" nowrap> {tool.date2str(term(_core,\'schedule\',\'start\'))} </td> <td class="week {_class}" nowrap> {tool.date2week(term(_core,\'schedule\',\'start\'))} </td> <td class="{_class}" nowrap> {tool.date2str(term(_core,\'schedule\',\'end\'))} </td> <td class="week {_class}" nowrap> {tool.date2week(term(_core,\'schedule\',\'end\'))} </td> <td class="{_class}" nowrap> {tool.date2str(term(_core,\'result\',\'start\'))} </td> <td class="week {_class}" nowrap> {tool.date2week(term(_core,\'result\',\'start\'))} </td> <td class="{_class}" nowrap> {tool.date2str(term(_core,\'result\',\'end\'))} </td> <td class="week {_class}" nowrap> {tool.date2week(term(_core,\'result\',\'end\'))} </td> <td class="operators {hideOperators()}"> <button class="button is-small add-child {hideAddChildOperator(this)}" onclick="{clickAddChild}" node_id="{_core._id}"> 子を追加 </button> <button class="button is-small delete-node {hideDeleteOperator(this)}" onclick="{clickDeleteWp}" node_id="{_core._id}"> 削除 </button> </td> </tr> </tbody> </table>', 'wbs-tree-list .table th { background: #EAE2D6; color: #867666; font-size: 12px; vertical-align: middle; text-align: center; } wbs-tree-list .table td { font-size: 12px; vertical-align: middle; } wbs-tree-list .table tr.project td { font-size: 16px; font-weight: bold; } wbs-tree-list .table tr.wbs td { font-size: 14px; font-weight: bold; } wbs-tree-list td.WBS { color: #888888; } wbs-tree-list td.PROJECT { color: #666666; } wbs-tree-list td.operators { text-align: center; } wbs-tree-list td.operators > button.button { width: 100%; } wbs-tree-list td.operators > button.button.add-child:hover { background: #89c3eb; color: #ffffff; font-weight: bold; } wbs-tree-list td.operators > button.button.delete-node:hover { background: #ec6d71; color: #ffffff; font-weight: bold; } wbs-tree-list span.tree-mergin { font-size: 12px; font-weight: normal; } wbs-tree-list .table td.week { font-size: 12px; padding-left: 1px; padding-right: 1px; text-align: center; }', '', function(opts) {
     this.clickAddChild = (e) => {
         this.opts.callback('open-add-child', {
             _id: e.target.getAttribute('node_id')
         });
     };
     this.clickDeleteWp = (e) => {
         this.opts.callback('open-delete-workpackage', {
             _id: e.target.getAttribute('node_id')
         });
     };

     this.hideOperators = () => {
         if (!this.opts.options ||
             !this.opts.options.security)
             return '';

         let v = (this.opts.options.security.create || this.opts.options.security.delete);

         return v ? '' : 'hide';
     };
     this.hideAddChildOperator = (data) => {
         return data._class=='WBS' ? '' : 'hide';
     };
     this.hideDeleteOperator = (data) => {
         return data._class=='WORKPACKAGE' ? '' : 'hide';
     };

     this.tool = new Wbs();
     this.term = (data, key, type) => {
         if (!data || !data[key]) return null;

         return data[key][type];
     };
     this.tableData = () => {
         let data = this.opts.data;

         if (!data) return [];

         return data;
     };
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-PROJECT-TREE')
             this.update();

         if (action.type=='MOVE-PAGE')
             this.update();
     });
});

riot.tag2('sections-list', '<table class="table"> <tbody> <tr each="{opts.data}"> <td><a href="{hash}">{name}</a></td> </tr> </tbody> </table>', '', '', function(opts) {
});

riot.tag2('example', '', '', '', function(opts) {
     this.mixin(MIXINS.page);

     this.on('mount', () => { this.draw(); });
     this.on('update', () => { this.draw(); });
});

riot.tag2('example_page_root', '<section-header title="Example"></section-header> <page-tabs core="{page_tabs}" callback="{clickTab}"></page-tabs> <div> <example_page_tab_readme class="hide"></example_page_tab_readme> <example_page_tab_list class="hide"></example_page_tab_list> <example_page_tab_guntt class="hide"></example_page_tab_guntt> </div> <section-footer></section-footer>', '', '', function(opts) {
     this.page_tabs = new PageTabs([
         {code: 'readme',   label: 'Data',               tag: 'example_page_tab_readme' },
         {code: 'tab1',     label: 'WBS Table',          tag: 'example_page_tab_list' },
         {code: 'tab2',     label: 'Guntt Chart',        tag: 'example_page_tab_guntt' },
     ]);

     this.on('mount', () => {
         this.page_tabs.switchTab(this.tags)
         this.update();
     });

     this.clickTab = (e, action, data) => {
         if (this.page_tabs.switchTab(this.tags, data.code))
             this.update();
     };
});

riot.tag2('example_page_tab_guntt', '<section class="section"> <div class="container"> <div class="contents"> <wbs-guntt-chart data="{data()}" start="{start}" end="{end}" options="{options}"></wbs-guntt-chart> </div> </div> </section>', '', '', function(opts) {
     let now   = moment().millisecond(0).second(0).minute(0).hour(0);

     this.options = {
         scale: {
             x: {
                 cycle: 'days',
                 tick: 88,
                 start: moment(now).add(-3, 'd'),
                 end:   moment(now).add( 3, 'w'),
             }
         },
     };

     this.data = () => {
         let state = STORE.get('example');
         let options = {}

         if (state.projects.list.length==0)
             return [];

         let wbs = new Wbs();
         let x = state.projects.list.map((project) => {
             return wbs.composeTree(
                 project,
                 state.wbs,
                 state.workpackages,
                 state.edges)
         });

         return x;
     };
});

riot.tag2('example_page_tab_list', '<section class="section"> <div class="container"> <div class="contents"> <wbs-tree-list data="{data()}" options="{wbs_list_options}"></wbs-tree-list> </div> </div> </section>', '', '', function(opts) {
     this.wbs_list_options = {
         hide: {
             wbs: {
                 finished: false
             },
             workpackage: {
                 finished: false
             }
         }
     };

     this.data = () => {
         let state = STORE.get('example');
         let options = this.wbs_list_options;

         if (state.projects.list.length==0)
             return [];

         let wbs = new Wbs()
         return wbs.composeTreeFlat(
             state.projects.list[0],
             state.wbs,
             state.workpackages,
             state.edges,
             options);
     };
});

riot.tag2('example_page_tab_readme', '<section class="section"> <div class="container"> <div class="contents"> <div style="display:flex;"> <div style="display:flex; flex-direction:column;"> <button each="{datakey in datakeys}" class="button {isActive(datakey.code)}" code="{datakey.code}" onclick="{clickDatakeyButton}"> {datakey.name} </button> </div> <div style="flex-grow:1; margin-left:11px;"> <textarea class="textarea" style="height: calc(100vh - 333px); max-height:none;">{getJsonData()}</textarea> <div style="margin-top:11px;"> <button class="button">Commit</button> </div> </div> </div> </div> </div> </section>', 'example_page_tab_readme .button { margin-bottom: 11px; border-radius: 0px; }', '', function(opts) {
     this.datakeys = [
         { code: 'projects',     name: 'Projects' },
         { code: 'wbs',          name: 'Wbs' },
         { code: 'workpackages', name: 'Workpackage' },
         { code: 'edges',        name: 'Edges' },
         { code: 'tree',         name: 'Tree' },
     ];
     this.selected = this.datakeys[0].code;
     this.clickDatakeyButton = (e) => {
         this.selected = e.target.getAttribute('code');
         this.update();
     };
     this.getJsonData = () => {

         if (this.selected=='tree')
             return '';

         let label = 'example.' + this.selected + '.list';

         let state = STORE.get(label);

         return JSON.stringify(state, null, "   ");
     };
     this.isActive = (code) => {
         if (code==this.selected)
             return 'is-danger';
         return '';
     };
});

riot.tag2('a-d3js', '<a-target-blank href="https://d3js.org/" label="D3.js"> </a-target-blank>', '', '', function(opts) {
});

riot.tag2('a-d3yabane', '<a-target-blank href="https://github.com/yanqirenshi/D3.Yabane" label="D3.Yabne"> </a-target-blank>', '', '', function(opts) {
});

riot.tag2('a-riotjs', '<a-target-blank href="https://riot.js.org/ja/" label="Riot.js"> </a-target-blank>', '', '', function(opts) {
});

riot.tag2('a-target-blank', '<a href="{opts.href}" target="_blank" rel="noopener noreferrer">{opts.label}</a>', '', '', function(opts) {
});

riot.tag2('a-vanillajs', '<a-target-blank href="http://vanilla-js.com/" label="Vanilla.js"> </a-target-blank>', '', '', function(opts) {
});

riot.tag2('home', '', '', '', function(opts) {
     this.mixin(MIXINS.page);

     this.on('mount', () => { this.draw(); });
     this.on('update', () => { this.draw(); });
});

riot.tag2('home_page_root', '<div class="hero-body"> <div class="container"> <h1 class="title">Wnqi Big Size</h1> <h2 class="subtitle">WBS ってデッカイう○ちみたいじゃね。</h2> <section class="section"> <div class="container"> <h1 class="title">概要</h1> <h2 class="subtitle"></h2> <div class="contents"> <p>WBSを描画するためのライブラリです。</p> <p>以下のもので出来ています。</p> <ol> <li><a-d3yabane></a-d3yabane> / <a-d3js></a-d3js></li> <li><a-riotjs></a-riotjs></li> <li><a-vanillajs></a-vanillajs></li> </ol> <p>描画出来るのは以下のものです。</p> <ol> <li>WBS のテーブル</li> <li>Guntt Chart</li> </ol> </div> </div> </section> <section class="section"> <div class="container"> <h1 class="title">やっていること</h1> <h2 class="subtitle"></h2> <div class="contents"> <p>project, wbs, workpackage, edge のデータを元に、描画するための階層構造データを作成します。</p> <p>その階層構造データを元に描画処理を行います。</p> <p>「<a href="/wbs/docs/#example">T:階</a>」のページでどのような階層が出力されるのかを確認することが出来ます。</p> <p>「<a href="/wbs/docs/#models">T:型</a>」のページで各データがどのように階層構造データのノードに変換されるかを確認することが出来ます。</p> </div> </div> </section> </div> </div>', 'home_page_root .contents ol { margin-left:33px; }', '', function(opts) {
});

riot.tag2('models', '', '', '', function(opts) {
     this.mixin(MIXINS.page);

     this.on('mount', () => { this.draw(); });
     this.on('update', () => { this.draw(); });
});

riot.tag2('models_converter', '<div style="display:flex;"> <div style="flex-grow:1;"> <textarea class="textarea">{source()}</textarea> </div> <div> <button class="button" onclick="{clickConvertButton}">変換</button> </div> <div style="flex-grow:1;"> <textarea class="textarea">{target()}</textarea> </div> </div>', 'models_converter .button { margin-left:11px; margin-right:11px; height:100%; } models_converter .textarea { height: 555px; }', '', function(opts) {
     this.node_json = null;
     this.clickConvertButton = () => {
         this.node_json = new Wbs().makeTreeNode(opts.source);
         this.update();
     };

     this.target = () => {
         if (!this.node_json)
             return '';

         return JSON.stringify(this.node_json, null, "   ");
     };
     this.source = () => {
         return JSON.stringify(opts.source, null, "   ");
     };
});

riot.tag2('models_page_root', '<section-header title="Models"></section-header> <page-tabs core="{page_tabs}" callback="{clickTab}"></page-tabs> <div> <models_page_tab_project class="hide"></models_page_tab_project> <models_page_tab_wbs class="hide"></models_page_tab_wbs> <models_page_tab_workpackage class="hide"></models_page_tab_workpackage> <models_page_tab_edge class="hide"></models_page_tab_edge> </div> <section-footer></section-footer>', '', '', function(opts) {
     this.page_tabs = new PageTabs([
         {code: 'project',     label: 'project',     tag: 'models_page_tab_project' },
         {code: 'wbs',         label: 'wbs',         tag: 'models_page_tab_wbs' },
         {code: 'workpackage', label: 'workpackage', tag: 'models_page_tab_workpackage' },
         {code: 'edge',        label: 'edge',        tag: 'models_page_tab_edge' },
     ]);

     this.on('mount', () => {
         this.page_tabs.switchTab(this.tags)
         this.update();
     });

     this.clickTab = (e, action, data) => {
         if (this.page_tabs.switchTab(this.tags, data.code))
             this.update();
     };
});

riot.tag2('models_page_tab_edge', '<section class="section"> <div class="container"> <h1 class="title"></h1> <div class="contents"> <models_converter source="{model()}"></models_converter> </div> </div> </section>', '', '', function(opts) {
     this.model = () => {
         return STORE.get('models.edge');
     };
});

riot.tag2('models_page_tab_project', '<section class="section"> <div class="container"> <h1 class="title"></h1> <div class="contents"> <models_converter source="{model()}"></models_converter> </div> </div> </section>', '', '', function(opts) {
     this.model = () => {
         return STORE.get('models.project');
     };
});

riot.tag2('models_page_tab_wbs', '<section class="section"> <div class="container"> <h1 class="title"></h1> <div class="contents"> <models_converter source="{model()}"></models_converter> </div> </div> </section>', '', '', function(opts) {
     this.model = () => {
         return STORE.get('models.wbs');
     };
});

riot.tag2('models_page_tab_workpackage', '<section class="section"> <div class="container"> <h1 class="title"></h1> <div class="contents"> <models_converter source="{model()}"></models_converter> </div> </div> </section>', '', '', function(opts) {
     this.model = () => {
         return STORE.get('models.workpackage');
     };
});
