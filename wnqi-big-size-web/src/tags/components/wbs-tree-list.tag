<wbs-tree-list>
    <table class="table is-bordered is-striped is-narrow is-hoverable ">
        <thead>
            <tr>
                <th>level</th>
                <th>parent</th>
                <th>code</th>
                <th>title</th>
                <th>create</th>
                <th>update</th>
                <th>PV</th>
                <th>EV</th>
                <th>AC</th>
                <th>CV</th>
                <th>SV</th>
            </tr>
        </thead>
        <tbody>
            <tr each={this.sortedWbs()}>
                <td>{level}</td>
                <td class="wbs-code parent"><a href="#wbs/{wbs_code_parent}">{this.display(wbs_code_parent)}</a></td>
                <td class="wbs-code"><a href="#wbs/{wbs_code}">{wbs_code}</a></td>
                <td>{displayWbsTitle(level, title)}</td>
                <td>{this.displayTimestamp(created_at)}</td>
                <td>{this.displayTimestamp(updated_at)}</td>
                <td>--</td>
                <td>--</td>
                <td>--</td>
                <td>--</td>
                <td>--</td>
            </tr>
        </tbody>
    </table>

    <style>
     wbs-tree-list td.wbs-code {
         font-weight:bold;
         text-align:right;
     }
     wbs-tree-list td.wbs-code.parent {
         font-weight:normal;
     }
    </style>

    <script>
     this.displayWbsTitle = function (level, title) {
         let l = level * 1 - 1;
         let prefix = '';
         for (var i=0 ; i<l ; i++ )
             prefix += '　';

         return prefix + title;
     }
     this.tree2list = function (wbs) {
         if (!wbs) return [];

         let childs = wbs.childs
         let result = [];
         for (var i in childs)
             result = result.concat(this.tree2list(childs[i]));

         return [wbs].concat(result);
     };

     this.sortedWbs = function () {
         let ht = {};
         let wbs = this.opts.wbs;
         for (var i in wbs) {
             wbs[i].childs = [];
             ht[wbs[i].wbs_code] = wbs[i];
         }

         let root = null;
         for (var i in wbs) {
             let parent_code = wbs[i].wbs_code_parent;
             if (!parent_code) {
                 root = wbs[i];
             } else {
                 ht[parent_code].childs.push(wbs[i]);
             }
         }

         return this.tree2list(root);
     };
     this.display = function (v) {
         return v;
     }

     this.displayTimestamp = function (t) {
         if (!t) return '(null)';
         return moment(new Date(t)).format("YYYY-MM-DD HH:mm");
     }
    </script>
</wbs-tree-list>
