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

riot.tag2('classes', '', '', '', function(opts) {
     this.mixin(MIXINS.page);

     this.on('mount', () => { this.draw(); });
     this.on('update', () => { this.draw(); });
});

riot.tag2('classes_page_root', '<section-header title="Classes"></section-header> <div style="margin-top:22px;"></div> <page-tabs core="{page_tabs}" callback="{clickTab}"></page-tabs> <div> <classes_page_tab_readme class="hide"></classes_page_tab_readme> <classes_page_tab_class000 class="hide"></classes_page_tab_class000> <classes_page_tab_class003 class="hide"></classes_page_tab_class003> <classes_page_tab_class001 class="hide"></classes_page_tab_class001> <classes_page_tab_class002 class="hide"></classes_page_tab_class002> </div> <section-footer></section-footer>', '', '', function(opts) {
     this.page_tabs = new PageTabs([
         {code: 'readme',   label: 'Readme',      tag: 'classes_page_tab_readme' },
         {code: 'class000', label: 'Wnqi',        tag: 'classes_page_tab_class000' },
         {code: 'class003', label: 'Wbs',         tag: 'classes_page_tab_class003' },
         {code: 'class001', label: 'WbsNode',     tag: 'classes_page_tab_class001' },
         {code: 'class002', label: 'WbsNodeTerm', tag: 'classes_page_tab_class002' },
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

riot.tag2('classes_page_tab_class000', '<section class="section"> <div class="container"> <div class="contents"> <svg id="scketchbook"></svg> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('classes_page_tab_class001', '<section class="section"> <div class="container"> <div class="contents"> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('classes_page_tab_class002', '<section class="section"> <div class="container"> <div class="contents"> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('classes_page_tab_class003', '<section class="section"> <div class="container"> <div class="contents"> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('classes_page_tab_readme', '<section class="section"> <div class="container"> <h1 class="title">概要</h1> <div class="contents"> <p>構成するデータについて説明します。</p> <p>他のタブでは、入力がどのようにシステムで利用するデータに変換されるかが確認できます。</p> </div> </div> </section>', '', '', function(opts) {
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

riot.tag2('section-header', '<section class="section"> <div class="container"> <h1 class="title is-{opts.no ? opts.no : 3}"> {opts.title} </h1> <h2 class="subtitle">{opts.subtitle}</h2> <yield></yield> </div> </section>', 'section-header > .section { background: #F8F3E6; }', '', function(opts) {
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

riot.tag2('wbs-tree-list', '<table class="table is-bordered is-narrow is-hoverable is-fullwidth"> <thead> <tr> <th rowspan="2" class="{isHideCol(\'code\')}">Code</th> <th rowspan="2" class="{isHideCol(\'name\')}">Name</th> <th colspan="4" class="{isHideCol(\'schedule\')}">Schedule</th> <th colspan="4" class="{isHideCol(\'result\')}">Result</th> <th rowspan="2" class="{isHideCol(\'operators\')} {hideOperators()}"> 操作 </th> <th rowspan="2" class="{isHideCol(\'description\')}">Description</th> </tr> <tr> <th colspan="2" class="{isHideCol(\'schedule\')}">start</th> <th colspan="2" class="{isHideCol(\'schedule\')}">end</th> <th colspan="2" class="{isHideCol(\'result\')}">start</th> <th colspan="2" class="{isHideCol(\'result\')}">end</th> </tr> </thead> <tbody> <tr each="{tableData()}" class="{tool.projectClass(_core._class)}"> <td nowrap class="{isHideCol(\'code\')}"> <a href="{tool.hashWbsPage(_core._id, _core._class)}">{_core._id}</a> </td> <td nowrap class="{isHideCol(\'name\')}"> <span class="tree-mergin">{tool.margin(_level)}</span> <span>{_core.name}</span> </td> <td class="{_class} {isHideCol(\'schedule\')}" nowrap> {tool.date2str(term(_core,\'schedule\',\'start\'))} </td> <td class="week {_class} {isHideCol(\'schedule\')}" nowrap> {tool.date2week(term(_core,\'schedule\',\'start\'))} </td> <td class="{_class} {isHideCol(\'schedule\')}" nowrap> {tool.date2str(term(_core,\'schedule\',\'end\'))} </td> <td class="week {_class} {isHideCol(\'schedule\')}" nowrap> {tool.date2week(term(_core,\'schedule\',\'end\'))} </td> <td class="{_class} {isHideCol(\'result\')}" nowrap> {tool.date2str(term(_core,\'result\',\'start\'))} </td> <td class="week {_class} {isHideCol(\'result\')}" nowrap> {tool.date2week(term(_core,\'result\',\'start\'))} </td> <td class="{_class} {isHideCol(\'result\')}" nowrap> {tool.date2str(term(_core,\'result\',\'end\'))} </td> <td class="week {_class} {isHideCol(\'result\')}" nowrap> {tool.date2week(term(_core,\'result\',\'end\'))} </td> <td class="operators {isHideCol(\'operators\')} {hideOperators()}"> <button class="button is-small add-child {hideAddChildOperator(this)}" onclick="{clickAddChild}" node_id="{_core._id}"> 子を追加 </button> <button class="button is-small delete-node {hideDeleteOperator(this)}" onclick="{clickDeleteWp}" node_id="{_core._id}"> 削除 </button> </td> <td nowrap class="{isHideCol(\'description\')}"> <span>{_core.description}</span> </td> </tr> </tbody> </table>', 'wbs-tree-list .table th { background: #EAE2D6; color: #867666; font-size: 12px; vertical-align: middle; text-align: center; } wbs-tree-list .table td { font-size: 12px; vertical-align: middle; } wbs-tree-list .table tr.project td { font-size: 16px; font-weight: bold; } wbs-tree-list .table tr.wbs td { font-size: 14px; font-weight: bold; } wbs-tree-list td.WBS { color: #888888; } wbs-tree-list td.PROJECT { color: #666666; } wbs-tree-list td.operators { text-align: center; } wbs-tree-list td.operators > button.button { width: 100%; } wbs-tree-list td.operators > button.button.add-child:hover { background: #89c3eb; color: #ffffff; font-weight: bold; } wbs-tree-list td.operators > button.button.delete-node:hover { background: #ec6d71; color: #ffffff; font-weight: bold; } wbs-tree-list span.tree-mergin { font-size: 12px; font-weight: normal; } wbs-tree-list .table td.week { font-size: 12px; padding-left: 1px; padding-right: 1px; text-align: center; }', '', function(opts) {
     this.tool = new Wbs();

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
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-PROJECT-TREE')
             this.update();

         if (action.type=='MOVE-PAGE')
             this.update();
     });

     this.options = { columns: this.opts.options.columns };
     this.isHideCol = (keys_str) => {
         if (!this.options.columns)
             return '';

         let keys = keys_str.split('.');
         let options = { children: this.options.columns };

         for (let key of keys) {
             let next = options.children[key]

             if (!next)
                 return '';

             options = next;
         }

         return options.hide ? 'hide' : '';
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

     this.term = (data, key, type) => {
         if (!data || !data[key]) return null;

         return data[key][type];
     };
     this.tableData = () => {
         let data = this.opts.data;

         if (!data)
             return [];

         return data;
     };
});

riot.tag2('sections-list', '<table class="table"> <tbody> <tr each="{opts.data}"> <td><a href="{hash}">{name}</a></td> </tr> </tbody> </table>', '', '', function(opts) {
});

riot.tag2('examples', '', '', '', function(opts) {
     this.mixin(MIXINS.page);

     this.on('mount', () => { this.draw(); });
     this.on('update', () => { this.draw(); });
});

riot.tag2('examples_page_root-example-list', '<section class="section"> <div class="container"> <div class="contents"> <wbs-tree-list data="{data()}" options="{wbs_list_options}"></wbs-tree-list> </div> </div> </section>', '', '', function(opts) {
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

riot.tag2('examples_page_root-example-tree', '<section class="section"> <div class="container"> <div class="contents"> <wbs-guntt-chart data="{data()}" start="{start}" end="{end}" options="{options}"></wbs-guntt-chart> </div> </div> </section>', '', '', function(opts) {
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

riot.tag2('examples_page_root', '<section-header title="Wnqi Big Size" subtitle="WBS ってデッカイう○ちみたいじゃね。"></section-header> <div style="margin-top:22px;"></div> <page-tabs core="{page_tabs}" callback="{clickTab}"></page-tabs> <div> <examples_page_root-example-list class="hide"></examples_page_root-example-list> <examples_page_root-example-tree class="hide"></examples_page_root-example-tree> </div>', '', '', function(opts) {
     this.page_tabs = new PageTabs([
         {code: 'example-list', label: 'Example: WBS List', tag: 'examples_page_root-example-list' },
         {code: 'example-tree', label: 'Example: WBS Tree', tag: 'examples_page_root-example-tree' },
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

riot.tag2('home_page_root-author', '<section class="section"> <div class="container"> <h1 class="title">Author</h1> <div class="contents"> Renshi (yanqirenshi@gmail.com) </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('home_page_root-readme-cdn', '<section class="section"> <div class="container"> <h1 class="title">CDN</h1> <div class="contents"> <table class="table is-bordered is-striped is-narrow is-hoverable"> <thead> <tr> <th>Version</th> <th>File</th> </tr> </thead> <tbody> <tr each="{rec in versiontsBody()}"> <td each="{cell in rec}" colspan="{cell.span.col}" rowspan="{cell.span.row}"> <span if="{!cell.link}">{cell.value}</span> <a-target-blank if="{cell.link}" label="{cell.value}" href="{cell.value}"></a-target-blank> </td> </tr> </tbody> </table> </div> </div> </section>', '', '', function(opts) {
     this.versions = {
         "beta": {
             seq: 0,
             files: [
                 "https://yanqirenshi.github.io/Wnqi-Big-Size/dist/beta/js/Wbs.js",
                 "https://yanqirenshi.github.io/Wnqi-Big-Size/dist/beta/tags/wbs-guntt-chart.tag",
                 "https://yanqirenshi.github.io/Wnqi-Big-Size/dist/beta/tags/wbs-tree-list.tag",
             ],
         },
         "0.0.2": {
             seq: 9,
             files: [
                 "https://yanqirenshi.github.io/Wnqi-Big-Size/dist/0.0.2/js/Wbs.js",
                 "https://yanqirenshi.github.io/Wnqi-Big-Size/dist/0.0.2/tags/wbs-guntt-chart.tag",
                 "https://yanqirenshi.github.io/Wnqi-Big-Size/dist/0.0.2/tags/wbs-tree-list.tag",
             ],
         },
         "0.0.1": {
             seq: 9,
             files: [
                 "https://yanqirenshi.github.io/Wnqi-Big-Size/dist/0.0.1/js/Wbs.js",
                 "https://yanqirenshi.github.io/Wnqi-Big-Size/dist/0.0.1/tags/wbs-guntt-chart.tag",
                 "https://yanqirenshi.github.io/Wnqi-Big-Size/dist/0.0.1/tags/wbs-tree-list.tag",
             ],
         },
     };
     this.versiontsBody = () => {
         let tmp = [];
         for (let k in this.versions) {
             this.versions[k].code = k;
             tmp.push(this.versions[k]);
         }

         tmp = tmp.sort((a, b) => {
             return a.seq < b.seq;
         });

         let recs = [];
         for (let version of tmp) {
             recs.push([
                 { value: version.code,     span: { row: 3, col: 1 } },
                 { value: version.files[0], span: { row: 1, col: 1 }, link: true },
             ]);

             let files = version.files.slice(1);
             for (let file of files)
                 recs.push([{ value: file, span: { row: 1, col: 1 }, link: true }]);
         }

         return recs;
     };
});

riot.tag2('home_page_root-copyright', '<section class="section"> <div class="container"> <h1 class="title">Copyright</h1> <div class="contents"> <p>Copyright (c) 2014 Satoshi Iwasaki (yanqirenshi@gmail.com)</p> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('home_page_root-readme-dependencies', '<section class="section"> <div class="container"> <h1 class="title">Dependencies</h1> <div class="contents"> <table class="table is-bordered is-striped is-narrow is-hoverable"> <thead> <tr> <th>Name</th> <th>Description</th> </tr> </thead> <tbody> <tr each="{obj in list}"> <td> <a-target-blank label="{obj.name}" href="{obj.uri}"></a-target-blank> </td> <td>{obj.description}</td> </tr> </tbody> </table> </div> </div> </section>', '', '', function(opts) {
     this.list = [
         {
             name: 'D3.js',
             description: '',
             uri: 'https://d3js.org/',
         },
         {
             name: 'Riot.js',
             description: '',
             uri: 'https://riot.js.org/ja/',
         },
         {
             name: 'D3.Yabne',
             description: '',
             uri: 'https://github.com/yanqirenshi/D3.Yabane',
         },
         {
             name: 'Vanilla.js',
             description: '',
             uri: 'http://vanilla-js.com/',
         },
     ];
});

riot.tag2('home_page_root-functions', '<section class="section"> <div class="container"> <div class="contents"> <wbs-tree-list data="{data()}" options="{wbs_list_options}"></wbs-tree-list> </div> </div> </section>', '', '', function(opts) {
     this.projects = { _id: 1, name: 'Wnqi Big Size' };
     this.wbs = [
         { _id:  10, name: 'Core',        seq: 0 },
         { _id:  11, name: 'Web',         seq: 0 },
         { _id: 100, name: 'Model',       seq: 0 },
         { _id: 101, name: 'Controller',  seq: 0 },
         { _id: 102, name: 'Riot.js Tag', seq: 0 },
     ];
     this.wps = [

     ];
     this.structures = [
         { from:  1, to:  10 },
         { from:  1, to:  11 },
         { from: 11, to: 100 },
         { from: 11, to: 101 },
         { from: 11, to: 102 },
     ];
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

         let wnqi = new Wnqi()

     };
});

riot.tag2('home_page_root-license', '<section class="section"> <div class="container"> <h1 class="title">License</h1> <div class="contents"> <p>Licensed under the LLGPL License.</p> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('home_page_root-readme', '<section class="section"> <div class="container"> <h1 class="title">概要</h1> <h2 class="subtitle"></h2> <div class="contents"> <p>WBSを描画するためのライブラリです。</p> <p>描画出来るのは以下のものです。</p> <ol> <li>WBS のテーブル</li> <li>Guntt Chart</li> </ol> </div> <section class="section inner"> <div class="container"> <h1 class="title is-4">やっていること</h1> <h2 class="subtitle"></h2> <div class="contents"> <p>project, wbs, workpackage, edge のデータを元に、描画するための階層構造データを作成します。</p> <p>その階層構造データを元に描画処理を行います。</p> <p>「<a href="/wbs/docs/#example">T:階</a>」のページでどのような階層が出力されるのかを確認することが出来ます。</p> <p>「<a href="/wbs/docs/#models">T:型</a>」のページで各データがどのように階層構造データのノードに変換されるかを確認することが出来ます。</p> </div> </div> </section> </div> </section> <home_page_root-readme-cdn></home_page_root-readme-cdn> <home_page_root-readme-dependencies></home_page_root-readme-dependencies> <home_page_root-author></home_page_root-author> <home_page_root-copyright></home_page_root-copyright> <home_page_root-license></home_page_root-license>', '', '', function(opts) {
});

riot.tag2('home_page_root', '<section-header title="Wnqi Big Size" subtitle="WBS ってデッカイう○ちみたいじゃね。"></section-header> <div style="margin-top:22px;"></div> <page-tabs core="{page_tabs}" callback="{clickTab}"></page-tabs> <div> <home_page_root-readme class="hide"></home_page_root-readme> <home_page_root-functions class="hide"></home_page_root-functions> </div>', '', '', function(opts) {
     this.page_tabs = new PageTabs([
         {code: 'readme',       label: 'Readme', tag: 'home_page_root-readme' },
         {code: 'example-list', label: '機能',   tag: 'home_page_root-functions' },
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

riot.tag2('example-tree', '', '', '', function(opts) {
     this.mixin(MIXINS.page);

     this.on('mount', () => { this.draw(); });
     this.on('update', () => { this.draw(); });
});

riot.tag2('example-tree_page_root', '<section-header title="Usage: WBS Tree"></section-header> <div style="margin-top:22px;"></div> <page-tabs core="{page_tabs}" callback="{clickTab}"></page-tabs> <div> <example-tree_page_tab_readme class="hide"></example-tree_page_tab_readme> <example-tree_page_tab_code class="hide"></example-tree_page_tab_code> <example-tree_page_tab_data class="hide"></example-tree_page_tab_data> <example-tree_page_tab_option class="hide"></example-tree_page_tab_option> <example-tree_page_tab_guntt class="hide"></example-tree_page_tab_guntt> </div> <section-footer></section-footer>', '', '', function(opts) {
     this.page_tabs = new PageTabs([
         {code: 'readme', label: 'Readme',      tag: 'example-tree_page_tab_readme' },
         {code: 'code',   label: 'Code',        tag: 'example-tree_page_tab_code' },
         {code: 'data',   label: 'Data',        tag: 'example-tree_page_tab_data' },
         {code: 'option', label: 'Option',      tag: 'example-tree_page_tab_option' },
         {code: 'guntt',  label: 'Wbs Tree',    tag: 'example-tree_page_tab_guntt' },
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

riot.tag2('example-tree_page_tab_code', '<section class="section"> <div class="container"> <div class="contents"> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('example-tree_page_tab_data', '<section class="section"> <div class="container"> <div class="contents"> <div style="display:flex;"> <div style="display:flex; flex-direction:column;"> <button each="{datakey in datakeys}" class="button {isActive(datakey.code)}" code="{datakey.code}" onclick="{clickDatakeyButton}"> {datakey.name} </button> </div> <div style="flex-grow:1; margin-left:11px;"> <textarea class="textarea" style="height: calc(100vh - 333px); max-height:none;">{getJsonData()}</textarea> <div style="margin-top:11px;"> <button class="button">Commit</button> </div> </div> </div> </div> </div> </section>', 'example-tree_page_tab_data .button { margin-bottom: 11px; border-radius: 0px; }', '', function(opts) {
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

riot.tag2('example-tree_page_tab_guntt', '<section class="section"> <div class="container"> <div class="contents"> <wbs-guntt-chart data="{data()}" start="{start}" end="{end}" options="{options}"></wbs-guntt-chart> </div> </div> </section>', '', '', function(opts) {
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

riot.tag2('example-tree_page_tab_option', '<section class="section"> <div class="container"> <div class="contents"> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('example-tree_page_tab_readme', '<section class="section"> <div class="container"> <h1 class="title">Usage: WBS Tree</h1> <div class="contents"> <p>WBS を表示させるために必要なことを説明します。</p> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('example-list', '', '', '', function(opts) {
     this.mixin(MIXINS.page);

     this.on('mount', () => { this.draw(); });
     this.on('update', () => { this.draw(); });
});

riot.tag2('example-list_page_root', '<section-header title="Usage: WBS List"></section-header> <div style="margin-top:22px;"></div> <page-tabs core="{page_tabs}" callback="{clickTab}"></page-tabs> <div> <example-list_page_tab_readme class="hide"></example-list_page_tab_readme> <example-list_page_tab_code class="hide"></example-list_page_tab_code> <example-list_page_tab_data class="hide"></example-list_page_tab_data> <example-list_page_tab_option class="hide"></example-list_page_tab_option> <example-list_page_tab_list class="hide"></example-list_page_tab_list> </div> <section-footer></section-footer>', '', '', function(opts) {
     this.page_tabs = new PageTabs([
         {code: 'readme', label: 'Readme',      tag: 'example-list_page_tab_readme' },
         {code: 'code',   label: 'Code',        tag: 'example-list_page_tab_code' },
         {code: 'data',   label: 'Data',        tag: 'example-list_page_tab_data' },
         {code: 'option', label: 'Option',      tag: 'example-list_page_tab_option' },
         {code: 'list',   label: 'WBS Table',   tag: 'example-list_page_tab_list' },
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

riot.tag2('example-list_page_tab_code', '<section class="section"> <div class="container"> <div class="contents"> </div> </div> </section>', '', '', function(opts) {
});

riot.tag2('example-list_page_tab_data', '<section class="section"> <div class="container"> <div class="contents"> <div style="display:flex;"> <div style="display:flex; flex-direction:column;"> <button each="{datakey in datakeys}" class="button {isActive(datakey.code)}" code="{datakey.code}" onclick="{clickDatakeyButton}"> {datakey.name} </button> </div> <div style="flex-grow:1; margin-left:11px;"> <textarea class="textarea" style="height: calc(100vh - 333px); max-height:none;">{getJsonData()}</textarea> <div style="margin-top:11px;"> <button class="button">Commit</button> </div> </div> </div> </div> </div> </section>', 'example-list_page_tab_data .button { margin-bottom: 11px; border-radius: 0px; }', '', function(opts) {
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

riot.tag2('example-list_page_tab_list', '<section class="section"> <div class="container"> <div class="contents"> <wbs-tree-list data="{data()}" options="{wbs_list_options}"></wbs-tree-list> </div> </div> </section> <section class="section"> <div class="container"> <div class="contents"> <h1 class="title">Code</h1> <section class="section"> <div class="container"> <h1 class="title is-4">HTML</h1> <div class="contents"> <p><pre>{html_example}</pre></p> </div> </div> </section> <section class="section"> <div class="container"> <h1 class="title is-4">Javascript</h1> <div class="contents"> <p><pre>{js_example}</pre></p> </div> </div> </section> </div> </div> </section>', '', '', function(opts) {
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

     this.html_example = '<wbs-tree-list data={data()} options={wbs_list_options}></wbs-tree-list>'
     this.js_example = [
         'this.wbs_list_options = {',
         '    hide: {',
         '        wbs: {',
         '            finished: false',
         '        },',
         '        workpackage: {',
         '            finished: false',
         '        }',
         '    }',
         '};',
         'this.data = () => {',
         '    let state = STORE.get("example");',
         '    let options = this.wbs_list_options;',
         '',
         '    if (state.projects.list.length==0)',
         '        return [];',
         '',
         '    let wbs = new Wbs()',
         '    return wbs.composeTreeFlat(',
         '        state.projects.list[0],',
         '        state.wbs,',
         '        state.workpackages,',
         '        state.edges,',
         '        options);',
         '};',
     ].join('\n');
});

riot.tag2('example_page_tab_option-left', '<div class="indicator"> <h1 class="title is-4"><code>hide</code></h1> <div class="contents"> <p>データの状態による表示/非表示を管理します。</p> <p>2019-06-27 (Thu) 時点では <code>rows</code> に移行予定です。</p> </div> </div> <div class="indicator"> <h1 class="title is-4"><code>term</code></h1> <div class="contents"> </div> </div> <div class="indicator"> <h1 class="title is-4"><code>columns</code></h1> <div class="contents"> <p>主に以下の設定を管理します。</p> <ol style="margin-left:33px;"> <li>列の表示/非表示、</li> <li>列のヘッダの表示形式</li> <li>列の値の表示形式</li> </ol> </div> </div> <div class="indicator"> <h1 class="title is-4"><code>rows</code></h1> <div class="contents"> <p>主に以下の設定を管理します。</p> <ol style="margin-left:33px;"> <li>行の表示/非表示、</li> </ol> <p>※ この機能は実装中です。</p> </div> </div>', 'example_page_tab_option-left { flex-grow: 1; margin-left: 22px; display: flex; flex-direction: column; } example_page_tab_option-left > .indicator { margin-bottom: 33px; } example_page_tab_option-left > .indicator > .contents { padding-left: 22px; }', '', function(opts) {
});

riot.tag2('example_page_tab_option-right', '<div> <p> <pre style="width:344px; fonts-size:12px;line-height:14px;">{JSON.stringify(this.options, null, 4)}</pre> </p> </div>', 'example_page_tab_option-right example_page_tab_option-left,[data-is="example_page_tab_option-right"] example_page_tab_option-left{ display: flex; }', '', function(opts) {
     this.options = {
         hide: {
             wbs: {
                 finished: false,
             },
             workpackage: {
                 finished: false,
             }
         },
         term: {
             start: null,
             end: null,
         },
         columns: {
             code: {
                 code: "code",
                 hide: false,
             },
             name: {
                 code: "name",
                 hide: false,
             },
             schedule: {
                 code: "schedule",
                 hide: true,
                 children: {
                     start: {
                         hide: null,
                     },
                     end: {
                         hide: null,
                     },
                 }
             },
             result: {
                 code: "result",
                 hide: true,
                 children: {
                     start: {
                         hide: null,
                     },
                     end: {
                         hide: null,
                     },
                 }
             },
             operators: {
                 code: "operators",
                 hide: true,
             },
             description: {
                 code: "description",
                 hide: false,
             },
         },
         rows: {
             workpackage: {
                 hide: false,
             }
         }
     };
});

riot.tag2('example-list_page_tab_option', '<section class="section"> <div class="container"> <div class="flex-root"> <example_page_tab_option-right></example_page_tab_option-right> <example_page_tab_option-left></example_page_tab_option-left> </div> </div> </section>', 'example-list_page_tab_option > .section > .container > .flex-root { display: flex; }', '', function(opts) {
});

riot.tag2('example-list_page_tab_readme', '<section class="section"> <div class="container"> <h1 class="title">概要</h1> <div class="contents"> <p>WBS Tree とは WBS を表形式で表示する機能です。</p> <p>HTML の Table タグで WBS の階層を表示します。</p> <br> <p>このページでは WBS Tree の利用方法を説明します。</p> </div> <section class="section inner" style=""> <div class="container"> <h1 class="title is-4">このページ(タブ)の構成</h1> <div class="contents"> <table class="table is-bordered is-striped is-narrow is-hoverable" style="font-size:14px;"> <thead> <tr> <th>Name</th> <th>Description</th> </tr> </thead> <tbody> <tr each="{tab in tabs}"> <td>{tab.name}</td> <td>{tab.description}</td> </tr> </tbody> </table> </div> </div> </section> </div> </section> <section class="section"> <div class="container"> <h1 class="title">ファイル構成</h1> <div class="contents"> <p>WBS Tree は以下のファイルで構成されます。</p> <ol style="margin-left:33px;"> <li each="{file in files}"> <a href="{file.href}">{file.name}</a> </li> </ol> </div> </div> </section>', '', '', function(opts) {
     this.tabs = [
         { name: 'Code',     description: '' },
         { name: 'Data',     description: '' },
         { name: 'Option',   description: '' },
         { name: 'WBS Tree', description: '' },
     ];
     this.files = [
         { name: './web/js/Wbs.js', href: 'https://github.com/yanqirenshi/Wnqi-Big-Size/blob/master/web/js/Wbs.js' },
         { name: './web/tags/wbs-tree-list.tag', href: 'https://github.com/yanqirenshi/Wnqi-Big-Size/blob/master/web/tags/wbs-tree-list.tag' },
     ]
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

riot.tag2('models_page_root', '<section-header title="Usage: Data Model"></section-header> <div style="margin-top:22px;"></div> <page-tabs core="{page_tabs}" callback="{clickTab}"></page-tabs> <div> <models_page_tab_readme class="hide"></models_page_tab_readme> <models_page_tab_project class="hide"></models_page_tab_project> <models_page_tab_wbs class="hide"></models_page_tab_wbs> <models_page_tab_workpackage class="hide"></models_page_tab_workpackage> <models_page_tab_edge class="hide"></models_page_tab_edge> </div> <section-footer></section-footer>', '', '', function(opts) {
     this.page_tabs = new PageTabs([
         {code: 'readme',      label: 'Readme',      tag: 'models_page_tab_readme' },
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

riot.tag2('models_page_tab_readme', '<section class="section"> <div class="container"> <h1 class="title">概要</h1> <div class="contents"> <p>構成するデータについて説明します。</p> <p>他のタブでは、入力がどのようにシステムで利用するデータに変換されるかが確認できます。</p> </div> </div> </section> <section class="section"> <div class="container"> <h1 class="title">Data Model</h1> <div class="contents"> <div style="width;100%; height: 444px; border:1px solid #eeeeee;"> <svg id="scketchbook"></svg> </div> </div> </div> </section>', '', '', function(opts) {
     this.docs = null
     this.nodes = [
         { _id:  1, label: 'Project',       x: 100, y: 200 },
         { _id:  2, label: 'WBS',           x: 300, y: 200 },
         { _id:  3, label: 'Workpackage',   x: 500, y: 200 },
         { _id:  4, label: 'Schedule',      x: 700, y: 200 },
         { _id:  5, label: 'Result',        x: 700, y: 300 },
         { _id:  6, label: 'Airtifact',     x: 700, y: 100 },
         { _id:  7, label: 'Product',       x: 100, y: 300 },
         { _id:  8, label: 'Estimate',      x: 200, y: 300 },
         { _id:  9, label: 'Resource',      x: 900, y: 200 },
         { _id: 10, label: 'Project Owner', x: 900, y: 300 },
     ];
     this.edges = [
         { from: 1, to: 2 },
         { from: 2, to: 3 },
         { from: 3, to: 4 },
         { from: 3, to: 5 },
         { from: 3, to: 6 },
         { from: 1, to: 7 },
         { from: 1, to: 8 },
         { from: 2, to: 8 },
     ];
     this.on('mount', () => {
         this.docs = new Docs('models_page_tab_readme svg');

         this.docs.draw(
             {list: this.docs.makeNodes(this.nodes)},
             {list: this.docs.makeEdges(this.edges)},
             null
         );
     });
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
