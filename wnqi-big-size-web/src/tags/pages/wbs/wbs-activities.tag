<wbs-activities>
    <section class="section">
        <div class="container">
            <div class="graph" ref="graph">
                <activity-graph callbacks={this.callbacks}
                                nodes={_NODES}
                                edges={_LINKS}
                                width={this.refs.graph.clientWidth}
                                height={this.refs.graph.clientHeight}></activity-graph>
            </div>
        </div>
    </section>

    <section class="section">
        <div class="container">
            <table class="table is-bordered is-striped is-narrow is-hoverable">
                <thead>
                    <th>id</th>
                    <th>name</th>
                    <th>description</th>
                </thead>
                <tbody>
                    <td>id</td>
                    <td>name</td>
                    <td>description</td>
                </tbody>
            </table>
        </div>
    </section>

    <style>
     wbs-activities div.graph {
         width: 100%;
         height: 333px;
         overflow:auto;
         border: 1px solid #eeeeee;
     }
    </style>

    <script>
     this.callbacks = {
         saveNodePosition: function () {
             console.log('saveNodePosition!');
         }
     };
    </script>
</wbs-activities>
