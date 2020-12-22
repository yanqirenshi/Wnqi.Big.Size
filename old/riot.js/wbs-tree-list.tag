<wbs-tree-list>
    <table class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth">
        <thead>
            <tr>
                <th rowspan="2">Code</th>
                <th rowspan="2">Name</th>
                <th rowspan="2">Description</th>
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
            <tr each={tableData()} class={tool.projectClass(_class)}>
                <td nowrap><a href="{tool.hashWbsPage(code, _class)}">{code}</a></td>
                <td>{tool.margin(_level) + name}</td>
                <td>{description}</td>
                <td class="{_class}" nowrap>{tool.date2str(schedule.start)}</td>
                <td class="{_class}" nowrap>{tool.date2str(schedule.end)}</td>
                <td class="{_class}" nowrap>{tool.date2str(result.start)}</td>
                <td class="{_class}" nowrap>{tool.date2str(result.end)}</td>
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
     this.tableData = () => {
         let x = this.opts.data;

         if (!x) return [];

         return this.tool.flatten(x, 1, this.opts.options);
     };

     STORE.subscribe((action) => {
         if (action.type!='FETCHED-PROJECT-TREE')
             return;

         this.update();
     });
    </script>
</wbs-tree-list>
