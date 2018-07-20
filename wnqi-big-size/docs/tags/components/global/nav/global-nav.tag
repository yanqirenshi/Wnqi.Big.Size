<global-nav>
    <nav>
        <ul>
            <li each={this.displayMenus()}>
                <a href="#{code}">
                    {name}
                </a>
            </li>
        </ul>
    </nav>

    <style>
     global-nav {
         z-index: 88888888;
         position: fixed;
         bottom: 0;
         right: 0;
         margin-right: 22px;
         margin-bottom: 22px;
     }
    </style>

    <script>
     this.displayMenus = function () {
         var out = [];
         for (var i in this.opts.menus)
             if (this.opts.menus[i].display)
                 out.push(this.opts.menus[i]);
         return out;
     }.bind(this);
    </script>
</global-nav>
