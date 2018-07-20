<activity-graph>
    <svg ref="svg">
    </svg>

    <script>
     this.graph = new NetworkGraph();

     this.resize  = function () {
         let w = this.opts.width
         let h = this.opts.height

         this.graph.setSize(w,h);

         let svg = this.refs.svg;

         if (!svg) return;

         svg.setAttribute('width', w + 'px');
         svg.setAttribute('height', h + 'px');
     }

     this.on('mount', function () {
         var svg = d3.select("activity-graph svg");

         if (!svg) return;

         this.graph.setSvg(svg);
         this.graph.setCallbacks(this.opts.callbacks);
         this.graph.setNodes(this.opts.nodes);
         this.graph.setEdges(this.opts.edges);
         this.graph.draw();
         this.resize();

     }.bind(this));

     this.on('update', function () {
         this.resize();
     }.bind(this));
    </script>
</activity-graph>
