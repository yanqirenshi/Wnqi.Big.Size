<example-tree_page_tab_data>

    <section class="section">
        <div class="container">
            <div class="contents">
                <div style="display:flex;">
                    <div style="display:flex; flex-direction:column;">
                        <button each={datakey in datakeys}
                                class="button {isActive(datakey.code)}"
                                code={datakey.code}
                                onclick={clickDatakeyButton}>
                            {datakey.name}
                        </button>
                    </div>
                    <div style="flex-grow:1; margin-left:11px;">
                        <textarea class="textarea" style="height: calc(100vh - 333px); max-height:none;">{getJsonData()}</textarea>
                        <div style="margin-top:11px;">
                            <button class="button">Commit</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <script>
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
         // TODO: きちんとしよう。
         if (this.selected=='tree')
             return '';

         let label = 'example.' + this.selected + '.list';

         let state = STORE.get(label);

         // Ref: https://shimz.me/blog/javascript/3783
         return JSON.stringify(state, null, "   ");
     };
     this.isActive = (code) => {
         if (code==this.selected)
             return 'is-danger';
         return '';
     };
    </script>

    <style>
     example-tree_page_tab_data .button {
         margin-bottom: 11px;
         border-radius: 0px;
     }
    </style>
</example-tree_page_tab_data>
