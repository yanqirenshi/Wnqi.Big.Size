<page-maneger>
    <sign-in  ref="sign-in"></sign-in>
    <cockpit  ref="cockpit"></cockpit>
    <parsons  ref="parsons"></parsons>
    <projects ref="projects"></projects>
    <wbs      ref="wbs"></wbs>

    <script>
     STORE.subscribe(function(action) {
         if (action.type!='MOVE-PAGE')
             return;

         this.routing();
         this.update();
     }.bind(this));

     this.routing = function () {
         let pages = STORE.state().pages;
         let displays = [];
         let hidden = [];
         for (var key in pages) {
             let code = key;
             let page = pages[code];
             let tag = this.refs[page.code];
             if (page.display)
                 displays.push(page);
             if (!page.display && tag)
                 hidden.push(tag);
         }
         for (var i in hidden)
             hidden[i].unmount()

         for(var i in displays) {
             let code = displays[i].code;

             if (this.refs[code])
                 continue;

             this.mount(this.refs.pages,
                        code,
                        {
                            ref: code,
                            data: STORE.state().pages[code]
                        });
         }
     }.bind(this);
    </script>
</page-maneger>
