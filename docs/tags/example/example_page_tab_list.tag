<example_page_tab_list>
    <section class="section">
        <div class="container">
            <div class="contents">
                <wbs-tree-list data={data()}
                               options={wbs_list_options}></wbs-tree-list>
            </div>
        </div>
    </section>

    <script>
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
    </script>
</example_page_tab_list>
