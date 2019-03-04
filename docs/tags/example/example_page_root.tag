<example_page_root>
    <section-header title="Example"></section-header>

    <page-tabs core={page_tabs} callback={clickTab}></page-tabs>

    <div>
        <example_page_tab_code  class="hide"></example_page_tab_code>
        <example_page_tab_data  class="hide"></example_page_tab_data>
        <example_page_tab_list  class="hide"></example_page_tab_list>
        <example_page_tab_guntt class="hide"></example_page_tab_guntt>
    </div>

    <section-footer></section-footer>

    <script>
     this.page_tabs = new PageTabs([
         {code: 'code', label: 'Code',        tag: 'example_page_tab_code' },
         {code: 'data', label: 'Data',        tag: 'example_page_tab_data' },
         {code: 'tab1', label: 'WBS Table',   tag: 'example_page_tab_list' },
         {code: 'tab2', label: 'Guntt Chart', tag: 'example_page_tab_guntt' },
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
</example_page_root>
