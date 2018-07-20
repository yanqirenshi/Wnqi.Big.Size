<projects-unit>
    <section class="hero" style="background: rgba(137, 91, 138, 0.33);">
        <div class="hero-body" style="padding:33px 0px;">
            <div class="container">
                <h1 class="title">
                    {this.project_name()}
                </h1>
                <h2 class="subtitle">
                    {this.project_code()}
                </h2>
            </div>
        </div>
    </section>

    <projects-unit-tabs tabs={this.state().tabs}
                        project_code={this.projectCode()}></projects-unit-tabs>

    <projects-unit-overview display={tabActive('overview')}></projects-unit-overview>
    <projects-unit-gunnt display={tabActive('gunnt')}></projects-unit-gunnt>
    <projects-unit-evm display={tabActive('evm')}></projects-unit-evm>
    <projects-unit-wbs display={tabActive('wbs')}></projects-unit-wbs>
    <projects-unit-basic display={tabActive('basic')}></projects-unit-basic>

    <script>
     this.state = function () { return STORE.state().pages.projects.unit; }
     this.projectCode = function () {
         return this.state().PROJECT ?
                this.state().PROJECT.project_code : null;
     }
     this.tabActive = function (code) {
         return this.state().tabs.find(function (v) {
             return v.code==code;
         }).active;
     };

     this.project_code = function () {
         let out;
         try {
             out = STORE.state().pages.projects.unit.PROJECT.project_code
         } catch (e) {
             out = '???';
         }
         return out;

     };

     this.project_name = function () {
         let out;
         try {
             out = STORE.state().pages.projects.unit.PROJECT.name
         } catch (e) {
             out = '???';
         }
         return out;
     }

     STORE.subscribe(function(action) {
         if (action.type=='LOADED-PAGE-PROJECTS-UNIT')
             this.update();
     }.bind(this));
    </script>
</projects-unit>
