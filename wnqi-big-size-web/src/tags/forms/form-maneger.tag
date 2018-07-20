<form-maneger>
    <form-create-action display={STORE.state().forms['create-action'].display}></form-create-action>

    <script>
     STORE.subscribe(function(action) {
         let targets = ['CLOSE-FORM', 'OPEN-FORM'];
         if (targets.find(function (v) { return action.type==v }))
             this.update();
     }.bind(this));
    </script>
</form-maneger>
