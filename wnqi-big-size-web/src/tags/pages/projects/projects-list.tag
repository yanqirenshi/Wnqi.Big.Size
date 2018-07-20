<projects-list>
    <section class="section" style="padding: 3px 22px;">
        <div class="container">
            <nav class="breadcrumb" aria-label="breadcrumbs">
                <ul>
                    <li><a href="#">Projects</a></li>
                </ul>
            </nav>
        </div>
    </section>

    <section class="section">
        <div class="container">
            <project-list projects={STORE.state().pages.projects.data}></project-list>
        </div>
    </section>

    <script>
     STORE.subscribe(function (action) {
         if (action.type=='LOADED-PAGE-PROJECTS-LIST') {
             this.update();
         }
     }.bind(this));

     this.on('mount', function() {
         ACTIONS.loadPageProjectsList();
     }.bind(this));
    </script>
</projects-list>
