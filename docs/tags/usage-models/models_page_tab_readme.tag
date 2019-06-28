<models_page_tab_readme>

    <section class="section">
        <div class="container">
            <h1 class="title">概要</h1>

            <div class="contents">
                <p>構成するデータについて説明します。</p>
                <p>他のタブでは、入力がどのようにシステムで利用するデータに変換されるかが確認できます。</p>
            </div>
        </div>
    </section>

    <section class="section">
        <div class="container">
            <h1 class="title">Data Model</h1>

            <div class="contents">
                <div style="width;100%; height: 444px; border:1px solid #eeeeee;">
                    <svg id="scketchbook"></svg>
                </div>
            </div>
        </div>
    </section>

    <script>
     this.docs = null
     this.nodes = [
         { _id:  1, label: 'Project',       x: 100, y: 200 },
         { _id:  2, label: 'WBS',           x: 300, y: 200 },
         { _id:  3, label: 'Workpackage',   x: 500, y: 200 },
         { _id:  4, label: 'Schedule',      x: 700, y: 200 },
         { _id:  5, label: 'Result',        x: 700, y: 300 },
         { _id:  6, label: 'Airtifact',     x: 700, y: 100 },
         { _id:  7, label: 'Product',       x: 100, y: 300 },
         { _id:  8, label: 'Estimate',      x: 200, y: 300 },
         { _id:  9, label: 'Resource',      x: 900, y: 200 },
         { _id: 10, label: 'Project Owner', x: 900, y: 300 },
     ];
     this.edges = [
         { from: 1, to: 2 },
         { from: 2, to: 3 },
         { from: 3, to: 4 },
         { from: 3, to: 5 },
         { from: 3, to: 6 },
         { from: 1, to: 7 },
         { from: 1, to: 8 },
         { from: 2, to: 8 },
     ];
     this.on('mount', () => {
         this.docs = new Docs('models_page_tab_readme svg');

         this.docs.draw(
             {list: this.docs.makeNodes(this.nodes)},
             {list: this.docs.makeEdges(this.edges)},
             null
         );
     });
    </script>
</models_page_tab_readme>
