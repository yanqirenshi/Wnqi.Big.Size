<home_page_root>
    <section-header title="Wnqi Big Size" subtitle="WBS ってデッカイう○ちみたいじゃね。"></section-header>

    <section class="section">
        <div class="container">
            <h1 class="title">概要</h1>
            <h2 class="subtitle"></h2>

            <div class="contents">
                <p>WBSを描画するためのライブラリです。</p>
                <p>以下のもので出来ています。</p>
                <ol>
                    <li><a-d3yabane></a-d3yabane> / <a-d3js></a-d3js></li>
                    <li><a-riotjs></a-riotjs></li>
                    <li><a-vanillajs></a-vanillajs></li>
                </ol>
                <p>描画出来るのは以下のものです。</p>
                <ol>
                    <li>WBS のテーブル</li>
                    <li>Guntt Chart</li>
                </ol>
            </div>

            <section class="section">
                <div class="container">
                    <h1 class="title is-4">CDN</h1>

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
                                        rowspan={cell.span.row}>{cell.value}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                </div>
            </section>

        </div>
    </section>

    <section class="section">
        <div class="container">
            <h1 class="title">やっていること</h1>
            <h2 class="subtitle"></h2>

            <div class="contents">
                <p>project, wbs, workpackage, edge のデータを元に、描画するための階層構造データを作成します。</p>
                <p>その階層構造データを元に描画処理を行います。</p>
                <p>「<a href="/wbs/docs/#example">T:階</a>」のページでどのような階層が出力されるのかを確認することが出来ます。</p>
                <p>「<a href="/wbs/docs/#models">T:型</a>」のページで各データがどのように階層構造データのノードに変換されるかを確認することが出来ます。</p>
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
                 { value: version.files[0], span: { row: 1, col: 1 } },
             ]);

             let files = version.files.slice(1);
             for (let file of files)
                 recs.push([{ value: file, span: { row: 1, col: 1 } }]);
         }
         dump(recs)
         return recs;
     };
    </script>

    <style>
     home_page_root .contents ol {
         margin-left:33px;
     }
    </style>
</home_page_root>
