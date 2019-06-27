<home_page_root-readme-cdn>

    <section class="section">
        <div class="container">
            <h1 class="title">CDN</h1>

            <div class="contents">
                <table class="table is-bordered is-striped is-narrow is-hoverable">
                    <thead>
                        <tr>
                            <th>Version</th>
                            <th>File</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr each={rec in versiontsBody()}>
                            <td each={cell in rec}
                                colspan={cell.span.col}
                                rowspan={cell.span.row}>
                                <span if={!cell.link}>{cell.value}</span>
                                <a-target-blank if={cell.link}
                                                label={cell.value}
                                                href={cell.value}></a-target-blank>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </section>

    <script>
     this.versions = {
         "beta": {
             seq: 0,
             files: [
                 "https://yanqirenshi.github.io/Wnqi-Big-Size/dist/beta/js/Wbs.js",
                 "https://yanqirenshi.github.io/Wnqi-Big-Size/dist/beta/tags/wbs-guntt-chart.tag",
                 "https://yanqirenshi.github.io/Wnqi-Big-Size/dist/beta/tags/wbs-tree-list.tag",
             ],
         },
         "0.0.1": {
             seq: 9,
             files: [
                 "https://yanqirenshi.github.io/Wnqi-Big-Size/dist/0.0.1/js/Wbs.js",
                 "https://yanqirenshi.github.io/Wnqi-Big-Size/dist/0.0.1/tags/wbs-guntt-chart.tag",
                 "https://yanqirenshi.github.io/Wnqi-Big-Size/dist/0.0.1/tags/wbs-tree-list.tag",
             ],
         },
     };
     this.versiontsBody = () => {
         let tmp = [];
         for (let k in this.versions) {
             this.versions[k].code = k;
             tmp.push(this.versions[k]);
         }

         tmp = tmp.sort((a, b) => {
             return a.seq < b.seq;
         });

         let recs = [];
         for (let version of tmp) {
             recs.push([
                 { value: version.code,     span: { row: 3, col: 1 } },
                 { value: version.files[0], span: { row: 1, col: 1 }, link: true },
             ]);

             let files = version.files.slice(1);
             for (let file of files)
                 recs.push([{ value: file, span: { row: 1, col: 1 }, link: true }]);
         }

         return recs;
     };
    </script>

</home_page_root-readme-cdn>
