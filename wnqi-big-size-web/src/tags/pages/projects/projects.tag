<projects>
    <projects-list class="{inActive('list')}"
                   projects={this.state()}></projects-list>
    <projects-unit class="{inActive('unit')}"></projects-unit>

    <wbs-unit>
    </wbs-unit>

    <style>
     :scope .in-active {
         display: none;
     }
    </style>

    <script>
     this.state = function () {
         return STORE.state().pages.projects;
     }.bind(this);

     this.on('mount', function(){
         ACTIONS.loadPageProjectsList();

         if (this.state().unit.PROJECT && this.state().unit.PROJECT.project_code)
             ACTIONS.loadPageProjectsUnit(this.state().unit.PROJECT.project_code);
     }.bind(this));

     STORE.subscribe(function(action) {
         let targets = ['LOADED-PAGE-PROJECTS-LIST',
                        'LOADED-PAGE-PROJECTS-UNIT'];
         if (targets.find(function (v) {
             return v==action.type;
         }))
             this.update();
     }.bind(this));

     this.inActive = function (name) {
         if (this.state().unit.PROJECT) {
             return (name=='list') ? 'in-active' : '';
         } else {
             return (name=='unit') ? 'in-active' : '';
         }
         return (STORE.state().route.page==name) ? 'active' : 'in-active';
     }.bind(this);
    </script>
</projects>
