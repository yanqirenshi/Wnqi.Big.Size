<home_page_root-readme-dependencies>

    <section class="section">
        <div class="container">
            <h1 class="title">Dependencies</h1>

            <div class="contents">
                <table class="table is-bordered is-striped is-narrow is-hoverable">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Description</th>
                        </tr>
                    </thead>

                    <tbody>
                        <tr each={obj in list}>
                            <td>
                                <a-target-blank label={obj.name} href={obj.uri}></a-target-blank>
                            </td>
                            <td>{obj.description}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </section>

    <script>
     this.list = [
         {
             name: 'D3.js',
             description: '',
             uri: 'https://d3js.org/',
         },
         {
             name: 'Riot.js',
             description: '',
             uri: 'https://riot.js.org/ja/',
         },
         {
             name: 'D3.Yabne',
             description: '',
             uri: 'https://github.com/yanqirenshi/D3.Yabane',
         },
         {
             name: 'Vanilla.js',
             description: '',
             uri: 'http://vanilla-js.com/',
         },
     ];
    </script>
</home_page_root-readme-dependencies>
