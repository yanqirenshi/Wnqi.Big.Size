<wbs-guntt-chart>
    <div style="overflow:auto;">
        <svg class="chart-yabane"></svg>
    </div>

    <script>
     this.on('update', (action) => {
         let tree = this.opts.data ? this.opts.data : [];
         let selector = 'svg.chart-yabane';

         let d3yabane = new D3jsYabane({ callback: this.opts.callback })
             .config(selector, this.opts.start, this.opts.end)
             .setScale()
             .makeStage()
             .data(tree) // with sizing and positioning
             .draw();
     });
    </script>
</wbs-guntt-chart>
