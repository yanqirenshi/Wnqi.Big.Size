<wbs-guntt-chat>
    <div style="overflow:auto;">
        <svg class="chart-yabane"></svg>
    </div>

    <script>
     this.on('update', (action) => {
         let tree = this.opts.data ? this.opts.data : [];

         let now   = moment().millisecond(0).second(0).minute(0).hour(0);
         let start = moment(now).add(-4, 'w').day(0);
         let end   = moment(now).add( 3, 'M').day(-7);
         let selector = 'svg.chart-yabane';
         let d3yabane = new D3jsYabane()
             .config(selector, start, end)
             .setScale()
             .makeStage()
             .data(tree) // with sizing and positioning
             .draw();
     });
    </script>
</wbs-guntt-chat>
