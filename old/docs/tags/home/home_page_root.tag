<home_page_root>
    <section-header title="Wnqi Big Size" subtitle="WBS ってデッカイう○ちみたいじゃね。"></section-header>

    <div style="margin-top:22px;"></div>

    <page-tabs core={page_tabs} callback={clickTab}></page-tabs>

    <div>
        <home_page_root-readme    class="hide"></home_page_root-readme>
        <home_page_root-functions class="hide"></home_page_root-functions>
    </div>

    <script>
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
    </script>
</home_page_root>
