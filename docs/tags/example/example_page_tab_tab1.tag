<example_page_tab_tab1>
    <section class="section">
        <div class="container">
            <div class="contents">
                <wbs-tree-list></wbs-tree-list>
            </div>
        </div>
    </section>

    <section class="section">
        <div class="container">
            <h1 class="title is-4">Data</h1>
            <div class="contents">
            </div>
        </div>
    </section>

    <script>
     this.data = () => {
         let state = {
             projects:     { ht: {}, list: [] },
             wbs:          { ht: {}, list: [] },
             workpackages: { ht: {}, list: [] },
             edges:        { ht: {}, list: [] },
         }
         let options = {
         }

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
</example_page_tab_tab1>
