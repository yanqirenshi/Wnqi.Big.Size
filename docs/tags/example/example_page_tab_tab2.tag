<example_page_tab_tab2>
    <section class="section">
        <div class="container">
            <div class="contents">
                <wbs-guntt-chart data={data()}
                                 start={start}
                                 end={end}
                                 options={options}></wbs-guntt-chart>
            </div>
        </div>
    </section>

    <section class="section">
        <div class="container">
            <h1 class="title is-6">Data</h1>
            <div class="contents">
            </div>
        </div>
    </section>

    <script>
     let now   = moment().millisecond(0).second(0).minute(0).hour(0);

     this.options = {
         scale: {
             x: {
                 cycle: 'days',
                 tick: 88,
                 start: moment(now).add(-3, 'd'),
                 end:   moment(now).add( 3, 'w'),
             }
         },
     };

     this.data = () => {
         let state = STORE.get('example');
         let options = {}

         if (state.projects.list.length==0)
             return [];

         let wbs = new Wbs();
         let x = state.projects.list.map((project) => {
             return wbs.composeTree(
                 project,
                 state.wbs,
                 state.workpackages,
                 state.edges)
         });

         return x;
     };
    </script>
</example_page_tab_tab2>
