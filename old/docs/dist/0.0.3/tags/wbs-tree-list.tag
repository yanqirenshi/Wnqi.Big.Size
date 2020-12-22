<wbs-tree-list>
    <table class="table is-bordered is-narrow is-hoverable is-fullwidth">
        <thead>
            <tr>
                <th rowspan="2" class={isHideCol('code')}>Code</th>
                <th rowspan="2" class={isHideCol('name')}>Name</th>
                <th colspan="4" class={isHideCol('schedule')}>Schedule</th>
                <th colspan="4" class={isHideCol('result')}>Result</th>
                <th rowspan="2"
                    class="{isHideCol('operators')} {hideOperators()}">
                    操作
                </th>
                <th rowspan="2" class={isHideCol('description')}>Description</th>
            </tr>
            <tr>
                <th colspan="2" class={isHideCol('schedule')}>start</th>
                <th colspan="2" class={isHideCol('schedule')}>end</th>
                <th colspan="2" class={isHideCol('result')}>start</th>
                <th colspan="2" class={isHideCol('result')}>end</th>
            </tr>
        </thead>
        <tbody>
            <tr each={tableData()} class={tool.projectClass(_core._class)}>
                <td nowrap class="{isHideCol('code')}">
                    <a href="{pageLinkUrl(_core)}">{_core._id}</a>
                </td>

                <td nowrap class="{isHideCol('name')}">
                    <span class="tree-mergin">{tool.margin(_level)}</span>
                    <span>{_core.name}</span>
                </td>

                <td class="{_class} {isHideCol('schedule')}" nowrap>
                    {tool.date2str(term(_core,'schedule','start'))}
                </td>

                <td class="week {_class} {isHideCol('schedule')}" nowrap>
                    {tool.date2week(term(_core,'schedule','start'))}
                </td>

                <td class="{_class} {isHideCol('schedule')}" nowrap>
                    {tool.date2str(term(_core,'schedule','end'))}
                </td>

                <td class="week {_class} {isHideCol('schedule')}" nowrap>
                    {tool.date2week(term(_core,'schedule','end'))}
                </td>

                <td class="{_class} {isHideCol('result')}" nowrap>
                    {tool.date2str(term(_core,'result','start'))}
                </td>

                <td class="week {_class} {isHideCol('result')}" nowrap>
                    {tool.date2week(term(_core,'result','start'))}
                </td>

                <td class="{_class} {isHideCol('result')}" nowrap>
                    {tool.date2str(term(_core,'result','end'))}
                </td>

                <td class="week {_class} {isHideCol('result')}" nowrap>
                    {tool.date2week(term(_core,'result','end'))}
                </td>

                <td class="operators {isHideCol('operators')} {hideOperators()}">
                    <button class="button is-small add-child {hideAddChildOperator(this)}"
                            onclick={clickAddChild}
                            node_id={_core._id}>
                        子を追加
                    </button>
                    <button class="button is-small delete-node {hideDeleteOperator(this)}"
                            onclick={clickDeleteWp}
                            node_id={_core._id}>
                        削除
                    </button>
                </td>

                <td nowrap class="{isHideCol('description')}">
                    <span>{_core.description}</span>
                </td>

            </tr>
        </tbody>
    </table>

    <script>
     this.tool = new Wbs();
    </script>

    <!-- ---------- -->
    <!--   added    -->
    <!-- ---------- -->
    <script>
     this.pageLinkUrl = (record) => {
         let keys = "options.rows.operators.pageLink"
         let func = keys.split('.').reduce((a, b) => {
             if (!a || !a[b])
                 return null;

             return a[b];
         }, this.opts);

         if (func)
             return func(record);

         return this.tool.hashWbsPage(record._id, record._class);
     };
    </script>

     <!-- ---------- -->
     <!--   Events   -->
     <!-- ---------- -->
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
     STORE.subscribe((action) => {
         if (action.type=='FETCHED-PROJECT-TREE')
             this.update();

         if (action.type=='MOVE-PAGE')
             this.update();
     });
    </script>

    <!-- -------- -->
    <!--   Hide   -->
    <!-- -------- -->
    <script>
     this.options = { columns: this.opts.options.columns };
     this.isHideCol = (keys_str) => {
         if (!this.options.columns)
             return '';

         let keys = keys_str.split('.');
         let options = { children: this.options.columns };

         for (let key of keys) {
             let next = options.children[key]

             if (!next)
                 return '';

             options = next;
         }

         return options.hide ? 'hide' : '';
     };
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

    <!-- -------- -->
    <!--   Data   -->
    <!-- -------- -->
    <script>
     this.term = (data, key, type) => {
         if (!data || !data[key]) return null;

         return data[key][type];
     };
     this.tableData = () => {
         let data = this.opts.data;

         if (!data)
             return [];

         // TODO: 暫定クソコード
         let options = this.opts.options;
         if (options.rows && options.rows.workpackage)
             if (options.rows.workpackage.hide)
                 return data.filter((d) => {
                     return d._class != "WORKPACKAGE"
                 });

         return data;
     };
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
