<example-list_page_tab_readme>

    <section class="section">
        <div class="container">
            <h1 class="title">概要</h1>

            <div class="contents">
                <p>WBS Tree とは WBS を表形式で表示する機能です。</p>
                <p>HTML の Table タグで WBS の階層を表示します。</p>
                <br/>
                <p>このページでは WBS Tree の利用方法を説明します。</p>
            </div>

            <section class="section inner" style="">
                <div class="container">
                    <h1 class="title is-4">このページ(タブ)の構成</h1>

                    <div class="contents">
                        <table class="table is-bordered is-striped is-narrow is-hoverable" style="font-size:14px;">
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Description</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr each={tab in tabs}>
                                    <td>{tab.name}</td>
                                    <td>{tab.description}</td>
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
            <h1 class="title">ファイル構成</h1>

            <div class="contents">
                <p>WBS Tree は以下のファイルで構成されます。</p>
                <ol style="margin-left:33px;">
                    <li each={file in files}>
                        <a href={file.href}>{file.name}</a>
                    </li>
                </ol>
            </div>
        </div>
    </section>

    <script>
     this.tabs = [
         { name: 'Code',     description: '' },
         { name: 'Data',     description: '' },
         { name: 'Option',   description: '' },
         { name: 'WBS Tree', description: '' },
     ];
     this.files = [
         { name: './web/js/Wbs.js', href: 'https://github.com/yanqirenshi/Wnqi-Big-Size/blob/master/web/js/Wbs.js' },
         { name: './web/tags/wbs-tree-list.tag', href: 'https://github.com/yanqirenshi/Wnqi-Big-Size/blob/master/web/tags/wbs-tree-list.tag' },
     ]
    </script>
</example-list_page_tab_readme>
