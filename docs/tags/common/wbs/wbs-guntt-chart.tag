<wbs-guntt-chart>
    <div style="overflow:auto;">
        <svg class="chart-yabane"></svg>
    </div>

    <script>
     this.on('update', (action) => {
         let tree = this.opts.data ? this.opts.data : [];
         let selector = 'svg.chart-yabane';

         let options = {
             stage: {
                 selector: selector,
                 padding: 11,
             },
             scale: this.opts.options.scale,
         };

         let d3yabane = new D3jsYabane({ callback: this.opts.callback })
             .config(options)
             .setScale()
             .makeStage()
             .data(tree) // with sizing and positioning
             .draw();
     });
    </script>
</wbs-guntt-chart>
