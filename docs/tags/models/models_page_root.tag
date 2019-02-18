<models_page_root>
    <section-header title="Models"></section-header>

    <page-tabs core={page_tabs} callback={clickTab}></page-tabs>

    <div>
        <models_page_tab_project     class="hide"></models_page_tab_project>
        <models_page_tab_wbs         class="hide"></models_page_tab_wbs>
        <models_page_tab_workpackage class="hide"></models_page_tab_workpackage>
        <models_page_tab_edge        class="hide"></models_page_tab_edge>
    </div>

    <section-footer></section-footer>

    <script>
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
    </script>
</models_page_root>
