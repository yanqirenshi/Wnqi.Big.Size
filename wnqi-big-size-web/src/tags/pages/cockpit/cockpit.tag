<cockpit>
    <section class="hero">
        <div class="hero-body" style="padding:8px;">
            <div class="container">
                <h1 class="title">
                    Cockpit
                </h1>
            </div>
        </div>
    </section>

    <!-- tab selector -->
    <div class="tabs">
        <ul>
            <li each={this.state().tabs}
                class="{display ? 'is-active' : ''}">
                <a href={href}>{label}</a>
            </li>
        </ul>
    </div>

    <!-- tab contents -->
    <cockpit-main class="tab-contents {this.inActive('main')}"
                  actions={this.state().actions}
                  activities={this.state().activities}
                  wbs={this.state().wbs}
                  projects={this.state().projects}
                  buckets={this.state().buckets}
                  data={this.state()}></cockpit-main>

    <cockpit-actions class="tab-contents {this.inActive('actions')}"
                     actions={this.state().actions}
                     action-histories={this.state().actionHistories}></cockpit-actions>

    <cockpit-activities class="tab-contents {this.inActive('activities')}"
                        activities={this.state().activities}></cockpit-activities>

    <cockpit-wbs class="tab-contents {this.inActive('wbs')}"
                 wbs={this.state().wbs}></cockpit-wbs>

    <cockpit-projects class="tab-contents {this.inActive('projects')}"
                      projects={this.state().projects}></cockpit-projects>

    <style>
     :scope .tab-contents.in-active {
         display: none;
     }
    </style>

    <script>
     this.state = function () {
         return STORE.state().pages.cockpit;
     }.bind(this);

     this.on('mount', function() {
         ACTIONS.loadPageCockpit();
     });

     STORE.subscribe(function(action) {
         let targets = ['LOADED-PAGE-COCKPIT',
                        'SELECT-BUCKET'];
         if (targets.find(function (v) {
             return v==action.type;
         }))
             this.update();
     }.bind(this));

     this.inActive = function (code) {
         let tab = this.state().tabs.find(function (tab) {
             return tab.code==code;
         });
         return tab.display ? '' : 'in-active';
     }.bind(this)
    </script>
</cockpit>
