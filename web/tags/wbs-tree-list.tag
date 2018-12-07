<wbs-tree-list>
    <table class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth">
        <thead>
            <tr>
                <th rowspan="2">Code</th>
                <th rowspan="2">Name</th>
                <th colspan="2">Schedule</th>
                <th colspan="2">Result</th>
            </tr>
            <tr>
                <th>start</th>
                <th>end</th>
                <th>start</th>
                <th>end</th>
            </tr>
        </thead>
        <tbody>
            <tr each={tableData()} class={tool.projectClass(core._class)}>
                <td nowrap><a href="{tool.hashWbsPage(core._id, core._class)}">{core._id}</a></td>
                <td nowrap>{tool.margin(_level) + core.name}</td>
                <td class="{_class}" nowrap>{tool.date2str(term(core,'schedule','start'))}</td>
                <td class="{_class}" nowrap>{tool.date2str(term(core,'schedule','end'))}</td>
                <td class="{_class}" nowrap>{tool.date2str(term(core,'result','start'))}</td>
                <td class="{_class}" nowrap>{tool.date2str(term(core,'result','end'))}</td>
            </tr>
        </tbody>
    </table>

    <style>
     wbs-tree-list .table th {
         background: #EAE2D6;
         color: #867666;
         font-size: 12px;
     }
     wbs-tree-list .table td {
         font-size: 12px;
     }
     wbs-tree-list .table tr.project td {
         font-size: 16px;
         font-weight: bold;
     }
     wbs-tree-list .table tr.wbs td {
         font-weight: bold;
     }
     wbs-tree-list td.WBS {
         color: #888888;
     }
     wbs-tree-list td.PROJECT {
         color: #666666;
     }
    </style>

    <script>
     this.tool = new Wbs();
     this.term = (data, key, type) => {
         if (!data || !data[key]) return null;

         return data[key][type];
     };
     this.tableData = () => {
         let data = this.opts.data;

         if (!data) return [];

         return data;
     };
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-PROJECT-TREE')
             this.update();

         if (action.type=='MOVE-PAGE')
             this.update();
     });
    </script>
</wbs-tree-list>
