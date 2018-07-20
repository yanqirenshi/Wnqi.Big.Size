<form-create-action>
    <div class="modal {this.isActive()}">
        <div class="modal-background"></div>
        <div class="modal-card">
            <header class="modal-card-head">
                <p class="modal-card-title">Creae New Action</p>
                <button class="delete"
                        aria-label="close"
                        onClick={this.clickCloseButton}></button>
            </header>
            <section class="modal-card-body">
                <div class="field">
                    <label class="label">
                        Description (一行目はタイトル風にしてください)
                    </label>
                    <div class="control">
                        <textarea class="textarea"
                                  placeholder="Textarea"
                                  style="height: 333px;"
                                  ref="description"></textarea>
                    </div>
                </div>
            </section>
            <footer class="modal-card-foot">
                <button class="button is-success"
                        onClick={this.clickCreateButton}>Create</button>
                <button class="button"
                        onClick={this.clickCloseButton}>Cancel</button>
            </footer>
        </div>
    </div>

    <script>
     this.isActive = function () {
         return this.opts.display ? 'is-active' : '';
     }.bind(this);

     this.clickCreateButton = function (e) {
         ACTIONS.createAction(this.refs.description.value, function (response) {
             ACTIONS.loadPageCockpit();
             ACTIONS.closeForm('create-action');
         });
     }.bind(this);

     this.clickCloseButton = function (e) {
         ACTIONS.closeForm('create-action');
     }.bind(this);
    </script>
</form-create-action>
