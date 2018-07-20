<wbs>
    <section class="hero" style="background: rgba(137, 91, 138, 0.33);">
        <div class="hero-body" style="padding:33px 0px;">
            <div class="container">
                <h1 class="title">
                    {this.wbsTitle()}
                </h1>
                <h2 class="subtitle">
                    Project: 
                    <a href={this.projectUriHash()}>
                        {this.projectName()}
                    </a>
                </h2>
            </div>
        </div>
    </section>

    <wbs-tabs tabs={this.state().tabs}
              wbs={this.state().wbs}></wbs-tabs>

    <wbs-overview class="tab-contents {this.isHidden('overview')}">
    </wbs-overview>

    <wbs-activities class="tab-contents {this.isHidden('activity')}"
                    data={this.state().activities}>
    </wbs-activities>

    <wbs-evm class="tab-contents {this.isHidden('evm')}">
    </wbs-evm>

    <style>
     wbs >  .tab-contents.hidden {
         display: none;
     }
    </style>

    <script>
     this.state = function () {
         return STORE.state().pages.wbs;
     };

     STORE.subscribe(function(action) {
         let targets = ['LOADED-PAGE-WBS'];
         if (targets.find(function (v) {
             return v==action.type;
         }))
             this.update();
     }.bind(this));

     this.wbsTitle = function () {
         let wbs = this.state().wbs;
         return wbs ? wbs.title : '???'
     }.bind(this);

     this.projectUriHash = function () {
         let project = this.state().project;
         return project ? '#projects/'+ project.project_code : location.hash;
     }.bind(this);

     this.projectName = function () {
         let project = this.state().project;

         return project ? project.name : '???'
     }.bind(this);

     this.isHidden = function (name) {
         let tab = this.state().tabs.find(function (v) {
             return v.code == name;
         });
         return tab.active ? '' : 'hidden';
     }.bind(this)

     this.on('mount', function(){
         let wbs = this.state().wbs;

         this.wbs = wbs;
         if (this.wbs && this.wbs.wbs_code)
             ACTIONS.loadPageWBS(wbs.wbs_code);
     }.bind(this));

     this.on('update', function(){
         let get_wbs_code = function (wbs) { return wbs ? wbs.wbs_code : -1 }

         let wbs_code_now = get_wbs_code(this.state().wbs);
         let wbs_code_old = get_wbs_code(this.wbs);

         if (wbs_code_now == wbs_code_old)
             return;

         this.wbs = this.state().wbs
         ACTIONS.loadPageWBS(wbs_code_now);
     }.bind(this));


     STORE.subscribe(function(action) {
         if (action.type!='LOADED-PAGE-WBS')
             return;
         this.update();
     }.bind(this));

    </script>
</wbs>
