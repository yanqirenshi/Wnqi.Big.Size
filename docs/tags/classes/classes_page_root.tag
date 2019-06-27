<classes_page_root>
    <section-header title="Classes"></section-header>

    <div style="margin-top:22px;"></div>

    <page-tabs core={page_tabs} callback={clickTab}></page-tabs>

    <div>
        <classes_page_tab_readme   class="hide"></classes_page_tab_readme>
        <classes_page_tab_class001 class="hide"></classes_page_tab_class001>
        <classes_page_tab_class002 class="hide"></classes_page_tab_class002>
        <classes_page_tab_class003 class="hide"></classes_page_tab_class003>
    </div>

    <section-footer></section-footer>

    <script>
     this.page_tabs = new PageTabs([
         {code: 'readme',   label: 'Readme',      tag: 'classes_page_tab_readme' },
         {code: 'class001', label: 'WbsNode',     tag: 'classes_page_tab_class001' },
         {code: 'class002', label: 'WbsNodeTerm', tag: 'classes_page_tab_class002' },
         {code: 'class003', label: 'Wbs',         tag: 'classes_page_tab_class003' },
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
</classes_page_root>
