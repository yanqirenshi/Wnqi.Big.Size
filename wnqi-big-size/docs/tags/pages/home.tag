<home>
    <app-header></app-header>

    <div class="tabs">
        <ul>
            <li each={this.tabs()}
                class="{display ? 'is-active' : ''}">
                <a href="#{code}">{label}</a>
            </li>
        </ul>
    </div>

    <home-readme class="tab-contents {this.hidden('readme')}"></home-readme>
    <home-wbs class="tab-contents {this.hidden('wbs')}"></home-wbs>
    <home-gtd class="tab-contents {this.hidden('gtd')}"></home-gtd>
    <home-organization class="tab-contents {this.hidden('organization')}"></home-organization>
    <home-accunt class="tab-contents {this.hidden('account')}"></home-accunt>
    <home-database class="tab-contents {this.hidden('database')}"></home-database>

    <app-footer></app-footer>

    <style>
     home .tab-contents.hidden {
         display: none;
     }
    </style>

    <script>
     STORE.subscribe(function (action) {
         this.update();
     }.bind(this));

     this.tabs = function () {
         let out = [];
         let tabs = STORE.state().pages.home.tabs;

         for (var k in tabs)
             out.push(tabs[k]);

         return out.sort(function (a, b) {
             return a.seq < b.seq ? -1 : 1;
         });
     }
     this.hidden = function (code) {
         let tabs = STORE.state().pages.home.tabs;
         return tabs[code].display ? '' : 'hidden';
     };
    </script>
</home>
