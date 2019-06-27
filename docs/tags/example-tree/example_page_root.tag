<example-tree_page_root>
    <section-header title="Usage: WBS Tree"></section-header>

    <div style="margin-top:22px;"></div>

    <page-tabs core={page_tabs} callback={clickTab}></page-tabs>

    <div>
        <example-tree_page_tab_readme class="hide"></example-tree_page_tab_readme>
        <example-tree_page_tab_code   class="hide"></example-tree_page_tab_code>
        <example-tree_page_tab_data   class="hide"></example-tree_page_tab_data>
        <example-tree_page_tab_option class="hide"></example-tree_page_tab_option>
        <example-tree_page_tab_guntt  class="hide"></example-tree_page_tab_guntt>
    </div>

    <section-footer></section-footer>

    <script>
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
    </script>
</example-tree_page_root>
