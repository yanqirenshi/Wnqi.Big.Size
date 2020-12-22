<home_page_root-functions>

    <section class="section">
        <div class="container">

            <div class="contents">
                <wbs-tree-list data={data()}
                               options={wbs_list_options}></wbs-tree-list>
            </div>

        </div>
    </section>

    <script>
     this.projects = { _id: 1, name: 'Wnqi Big Size' };
     this.wbs = [
         { _id:  10, name: 'Core',        seq: 0 },
         { _id:  11, name: 'Web',         seq: 0 },
         { _id: 100, name: 'Model',       seq: 0 },
         { _id: 101, name: 'Controller',  seq: 0 },
         { _id: 102, name: 'Riot.js Tag', seq: 0 },
     ];
     this.wps = [
         //{ _id: 0, name: '', seq: 0 },
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
         /* return wbs.composeTreeFlat(
          *     this.project,
          *     this.wbs,
          *     this.wps,
          *     this.structures,
          *     options); */
     };
    </script>

</home_page_root-functions>
