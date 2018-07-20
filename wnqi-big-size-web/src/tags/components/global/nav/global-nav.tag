<global-nav style="z-index:88888888;">
    <nav>
        <ul>
            <global-nav-item each={menu in this.opts.menus}
                             menu={menu}
                             onclick={this.click}></global-nav-item>
        </ul>
    </nav>

    <script>
     STORE.subscribe(function(action) {
         if (action.type!='TOGGLE-GLOBAL-MENU-GROUP')
             return;
         this.update();
     }.bind(this));

     this.findParentTag =function (startTag, tagName) {
         let tag = startTag;
         if (tag.tagName!=tagName) {
             do {
                 tag = tag.parentNode
             } while (tag.tagName!='GLOBAL-NAV-ITEM')
         }
         return tag;
     };

     this.click = function (e) {
         let tag = this.findParentTag(e.target, 'GLOBAL-NAV-ITEM');
         let action_type = tag.getAttribute('action-type');

         if (action_type=='TOGGLE-GROUP') {
             let group_code = tag.getAttribute('action-data');
             ACTIONS.toggleGlobalMenuGroup(group_code);
             return;
         }

         if (action_type=='MOVE-PAGE') {
             let hash = tag.getAttribute('action-data');
             location.hash = hash;
             return;
         }

         if (action_type=='OPEN-FORM') {
             let form_code = tag.getAttribute('action-data');
             ACTIONS.openForm(form_code);
             return;
         }

         if (action_type=='SIGN-OUT') {
             ACTIONS.signOut();
         }

     }.bind(this)
    </script>
</global-nav>
