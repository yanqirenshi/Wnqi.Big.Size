<wbs-tree-list>
    <table class="table is-bordered is-narrow is-hoverable is-fullwidth">
        <thead>
            <tr>
                <th rowspan="2">Code</th>
                <th rowspan="2">Name</th>
                <th colspan="4">Schedule</th>
                <th colspan="4">Result</th>
                <th class={hideOperators()}
                    rowspan="2">操作</th>
            </tr>
            <tr>
                <th colspan="2">start</th>
                <th colspan="2">end</th>
                <th colspan="2">start</th>
                <th colspan="2">end</th>
            </tr>
        </thead>
        <tbody>
            <tr each={tableData()} class={tool.projectClass(core._class)}>
                <td nowrap><a href="{tool.hashWbsPage(core._id, core._class)}">{core._id}</a></td>
                <td nowrap>
                    <span class="tree-mergin">{tool.margin(_level)}</span>
                    <span>{core.name}</span>
                </td>
                <td class="{_class}" nowrap>{tool.date2str(term(core,'schedule','start'))}</td>
                <td class="week {_class}" nowrap>{tool.date2week(term(core,'schedule','start'))}</td>

                <td class="{_class}" nowrap>{tool.date2str(term(core,'schedule','end'))}</td>
                <td class="week {_class}" nowrap>{tool.date2week(term(core,'schedule','end'))}</td>

                <td class="{_class}" nowrap>{tool.date2str(term(core,'result','start'))}</td>
                <td class="week {_class}" nowrap>{tool.date2week(term(core,'result','start'))}</td>

                <td class="{_class}" nowrap>{tool.date2str(term(core,'result','end'))}</td>
                <td class="week {_class}" nowrap>{tool.date2week(term(core,'result','end'))}</td>
                <td class="operators {hideOperators()}">
                    <button class="button is-small add-child   {hideAddChildOperator(this)}"
                            onclick={clickAddChild}
                            node_id={core._id}>
                        子を追加
                    </button>
                    <button class="button is-small delete-node {hideDeleteOperator(this)}"
                            onclick={clickDeleteWp}
                            node_id={core._id}>
                        削除
                    </button>
                </td>
            </tr>
        </tbody>
    </table>

    <script>
     this.clickAddChild = (e) => {
         this.opts.callback('open-add-child', {
             _id: e.target.getAttribute('node_id')
         });
     };
     this.clickDeleteWp = (e) => {
         this.opts.callback('open-delete-workpackage', {
             _id: e.target.getAttribute('node_id')
         });
     };
    </script>


    <script>
     this.hideOperators = () => {
         if (!this.opts.options ||
             !this.opts.options.security)
             return '';

         let v = (this.opts.options.security.create || this.opts.options.security.delete);

         return v ? '' : 'hide';
     };
     this.hideAddChildOperator = (data) => {
         return data._class=='WBS' ? '' : 'hide';
     };
     this.hideDeleteOperator = (data) => {
         return data._class=='WORKPACKAGE' ? '' : 'hide';
     };
    </script>

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

    <style>
     wbs-tree-list .table th {
         background: #EAE2D6;
         color: #867666;
         font-size: 12px;
         vertical-align: middle;
         text-align: center;
     }
     wbs-tree-list .table td {
         font-size: 12px;
         vertical-align: middle;
     }
     wbs-tree-list .table tr.project td {
         font-size: 16px;
         font-weight: bold;
     }
     wbs-tree-list .table tr.wbs td {
         font-size: 14px;
         font-weight: bold;
     }
     wbs-tree-list td.WBS {
         color: #888888;
     }
     wbs-tree-list td.PROJECT {
         color: #666666;
     }
     wbs-tree-list td.operators {
         text-align: center;
     }
     wbs-tree-list td.operators > button.button {
         width: 100%;
     }
     wbs-tree-list td.operators > button.button.add-child:hover {
         background: #89c3eb;
         color: #ffffff;
         font-weight: bold;
     }
     wbs-tree-list td.operators > button.button.delete-node:hover {
         background: #ec6d71;
         color: #ffffff;
         font-weight: bold;
     }
     wbs-tree-list span.tree-mergin {
         font-size: 12px;
         font-weight: normal;
     }
     wbs-tree-list .table td.week {
         font-size: 12px;
         padding-left: 1px;
         padding-right: 1px;
         text-align: center;
     }
    </style>
</wbs-tree-list>
