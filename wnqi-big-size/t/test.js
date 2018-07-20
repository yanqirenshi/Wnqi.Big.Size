var Chart = null;
var rest  = null;
var request = null;
var Html = new yzrHtml();
$(function(){
    var model = new GunttchartModel();
    Chart = new Gunttchart( $('#guntt-chart'), {model:model});
    Chart.calendar(new yzrCalendar()
                   .gen(moment().add('y',-1).format('YYYY-MM-DD'),
                        moment().add('y',1).format('YYYY-MM-DD')));
    //
    request = new yzrRequestCounter()
        .addCallback('start','end',function(){
            loadWbs();
        })
        .addCallback('all','end',function(){
            Chart.refresh();
        });

    // setting rest
    rest = new yzrAjax();
    rest.addPlace('lh','http://localhost:44444/rsc');

    loadItil();

    $('#itil-resources').change(function(){
        Chart.clear();
        loadWbs();
    });

});


function loadItil(){
    var select = $('#itil-resources');
    select.empty();

    request.incf('start');
    rest.get('lh','/itil',
             {done:function(d){
                 var stmt = [];
                 $.each(d.data,function(){
                     stmt.push({tag:'option',attr:{'value':this.id},con:this.title});
                 });
                 select.append(Html.gen(stmt));
             },always:function(){
                 request.decf('start');
             }});
};
function loadWbs(){
    var select = $('#itil-resources');

    request.incf('all');
    rest.get('lh','/wbs/top',{done:function(d){
        $.each(d.data,function(){
            var wbs = Chart.rsc2wbs(this);

            // 子供WBS を追加する。
            loadWbsChilds(wbs);

            // チャートにルート WBS を追加する。
            Chart.addWbs(wbs);
            Chart.addWbs(wbs);
        });
    },always:function(){
        request.decf('all');
    }},{wbs:select.val()});
};
function loadWbsChilds(wbs){
    request.incf('all');
    rest.get('lh','/wbs/childs',
             {done:function(d){

                 if(d.data==null)
                     return;

                 $.each(d.data,function(){
                     var child = Chart.rsc2wbs(this);
                     loadWbsChilds(child);
                     wbs.addChild(child);
                 });

             },fail:function(d){
                 dump(d.responseJSON.message);
             },always:function(){
                 request.decf('all');
             }},{wbs:wbs.id()});
};
