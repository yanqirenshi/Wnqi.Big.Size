<app>
    <!-- gloval tag -->
    <github-link></github-link>

    <global-nav menus={STORE.state().menus}></global-nav>

    <message-area></message-area>

    <page-maneger></page-maneger>
    <form-maneger></form-maneger>

    <script>
     window.addEventListener('resize', function (event) {
         this.update();
     }.bind(this));
    </script>
</app>
