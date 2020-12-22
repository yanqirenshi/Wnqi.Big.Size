class Docs {
    constructor (selector) {
        this._selector = selector;
        this._svg = null;

        this.d3svg = this.makeD3Svg(selector);
        this.simulator = new D3Simulator().make();

        this.getSvgElement();
    }
    getSvgElement () {
        if (this._svg)
            return this._svg;

        this._svg = document.querySelector(this._selector);

        return this._svg;
    }
    getSize () {
        let parent = this.getSvgElement().parentNode;

        return {
            h: parent.clientHeight,
            w: parent.clientWidth,
        };
    }
    makeD3Svg (selector) {

        let svg_tag = this.getSvgElement();

        let size = this.getSize();

        let h = size.h;
        let w = size.w;

        svg_tag.setAttribute('height', h);
        svg_tag.setAttribute('width', w);

        let d3svg = new D3Svg({
            d3: d3,
            svg: d3.select(selector),
            x: 10,
            y: 10,
            w: w,
            h: h,
            scale: 1
        });

        this.makeBases(d3svg);
        this.drawBackground(d3svg);

        return d3svg;
    }
    drawBackground (d3svg) {
        let length = 8800;
        let start = length * -1;
        let end   = length;
        let x_data = [];
        let y_data = [];
        let _id = 100;

        let axis = [
            { _id: _id++, x1: start, x2: end, y1: 0, y2: 0},
            { _id: _id++, x1: 0, x2: 0, y1: start, y2: end},
        ];

        for (var i=start ; i < end ; i+=100)
            x_data.push({ _id: _id++,
                          x1:i,
                          y1:start,
                          x2:i,
                          y2: end});

        for (var i=start ; i < end ; i+=100)
            y_data.push({ _id: _id++,
                          x1:start,
                          y1:i,
                          x2:end,
                          y2: i});

        let data = [].concat(x_data).concat(y_data);

        let svg = d3svg.Svg();
        let background = svg.selectAll('g.base.background');

        background.selectAll('line.grid')
            .data(data, (d) => { return d._id; })
            .enter()
            .append('line')
            .attr('class', 'grid')
            .attr('x1', (d) => { return d.x1;})
            .attr('y1', (d) => { return d.y1;})
            .attr('x2', (d) => { return d.x2;})
            .attr('y2', (d) => { return d.y2;})
            .attr('stroke', '#888888')
            .attr('stroke-width', 0.3)
            .attr('stroke-dasharray', 3);

        background.selectAll('line.axis')
            .data(axis, (d) => { return d._id; })
            .enter()
            .append('line')
            .attr('class', 'axis')
            .attr('x1', (d) => { return d.x1;})
            .attr('y1', (d) => { return d.y1;})
            .attr('x2', (d) => { return d.x2;})
            .attr('y2', (d) => { return d.y2;})
            .attr('stroke', '#333333')
            .attr('stroke-width', 3);
    }
    makeBases (d3svg) {
        let svg = d3svg.Svg();

        let base = [
            { _id: -10, code: 'background' },
            { _id: -15, code: 'forground' },
        ];

        svg.selectAll('g.base')
            .data(base, (d) => { return d._id; })
            .enter()
            .append('g')
            .attr('class', (d) => {
                return 'base ' + d.code;
            });
    }
    refreshSvgSize () {
        let svg_element = this.getSvgElement();

        let size = this.getSize();
        svg_element.setAttribute('width',  size.w);
        svg_element.setAttribute('height', size.h);
    }
    draw (nodes, edges, rules) {
        if (!this.d3svg)
            return;

        let d3svg = this.d3svg;

        new D3Base().draw(d3svg);
        new D3Nodes().draw(d3svg,
                           nodes,
                           this.simulator,
                           (type, data) => { return; });
        new D3Edges().draw(d3svg, edges, this.simulator);
    }
    makeNode (data) {
        return {
            x: data.x || Math.floor(Math.random() * Math.floor(500)),
            y: data.y || Math.floor(Math.random() * Math.floor(500)),
            fx: data.x || Math.floor(Math.random() * Math.floor(500)),
            fy: data.y || Math.floor(Math.random() * Math.floor(500)),
            label: {
                text: data.label + '(' + data._id + ')',
                font: {
                    size: 12
                }
            },
            circle: {
                r: 33,
                fill: '#eeeeee',
                stroke: {
                    color: '#888888',
                    width: 1
                }
            },
            _id: data._id,
            _class: data.label,
        };
    }
    makeNodes (list) {
        let nodes = [];
        for (let data of list)
            nodes.push(this.makeNode(data));

        return nodes;
    }
    makeEdge (data) {
        return {
            source: data.from,
            target: data.to
        };
    }
    makeEdges (list) {
        let edges = [];
        for (let data of list)
            edges.push(this.makeEdge(data));

        return edges;
    }
}

class DocsFunctions {
}
