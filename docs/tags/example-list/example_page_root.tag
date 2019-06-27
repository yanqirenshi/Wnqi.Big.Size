<example-list_page_root>
    <section-header title="Usage: WBS List"></section-header>

    <div style="margin-top:22px;"></div>

    <page-tabs core={page_tabs} callback={clickTab}></page-tabs>

    <div>
        <example-list_page_tab_readme class="hide"></example-list_page_tab_readme>
        <example-list_page_tab_code   class="hide"></example-list_page_tab_code>
        <example-list_page_tab_data   class="hide"></example-list_page_tab_data>
        <example-list_page_tab_option class="hide"></example-list_page_tab_option>
        <example-list_page_tab_list   class="hide"></example-list_page_tab_list>
    </div>

    <section-footer></section-footer>

    <script>
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
    </script>
</example-list_page_root>
