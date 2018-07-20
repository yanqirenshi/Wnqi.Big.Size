<main-card class="{this.classSelected()} {this.opts.started ? 'started' : ''}"
           ref="self">
    <div class="card">
        <header class="card-header">
            <p class="card-header-title" style="padding:8px;">
                {this.title()}
            </p>
        </header>

        <div class="card-content default" style="padding:8px; overflow:hidden;">
            <textarea style="" readonly>
                    {this.description()}
            </textarea>
        </div>

        <div class="card-content move-bucket" style="padding:8px; overflow:auto;">
            <main-card-contents-move-bucket object={this.opts.object}
                                            buckets={this.opts.buckets}
                                            click-move-bucket-action={this.clickMoveBucketButton}>
            </main-card-contents-move-bucket>
        </div>

        <div class="card-content edit" style="padding:8px; overflow:auto;">
            <main-card-contents-edit click-archive-action={this.clickArchiveButton}
                                     description={this.description()} ></main-card-contents-edit>
        </div>

        <main-card-footer class="card-footer"
                          mode={this.mode}
                          callbacks={this.callbacks()}>
        </main-card-footer>
    </div>

    <style>
     main-card div.card { width: 222px; }
     main-card div.card-content { height: 111px; }
     main-card textarea:focus { outline: 0; }

     main-card button.card-operator {
         border: none;
         border-radius: 0px;
         padding: 6px;
     }
     main-card .card-footer-item {
         padding: 3px;
     }
     main-card .card-footer-item > button{
         width:100%;
     }
     main-card {
         border: 1px solid #eeeeee;
     }
     main-card.selected {
         border: 1px solid rgba(137, 91, 138, 0.66);
     }
     main-card.started .card-header{
         background:rgba(137, 91, 138, 0.33);
     }
     main-card.started .button.start-stop{
         color: rgba(137, 91, 138, 1);
         font-weight: bold;
     }
     main-card textarea {
         width:100%;
         height:100%;
         border: none;
         resize: none;
         font-size: 12px;
     }

     main-card div.default { display:block; }
     main-card div.move-bucket { display:none; }
     main-card div.edit { display:none; }

     main-card[mode="move-bucket"] div.move-bucket { display:block; }
     main-card[mode="move-bucket"] div.default { display:none; }
     main-card[mode="move-bucket"] div.card { width: 468px; }
     main-card[mode="move-bucket"] div.card-content { height: 329px; }

     main-card[mode="edit"] div.edit { display:block; }
     main-card[mode="edit"] div.default { display:none; }
     main-card[mode="edit"] div.card { width: 468px; }
     main-card[mode="edit"] div.card-content { height: 329px; }
    </style>


    <script>
     this.mode = '';

     this.classSelected = function () {
         return false;
         /* return this.opts.selected ? this.opts.selected : '';*/
     }.bind(this);

     this.setMode = function (mode) {
         this.mode = mode

         let card = this.refs.self;
         card.setAttribute('mode', mode);

         this.update()
     }.bind(this);

     this.clearMode = function () {
         this.setMode('');
     }.bind(this);

     this.clickMoveButton = function (e) {
         this.setMode('move-bucket');
     }.bind(this);

     this.clickEditButton = function (e) {
         this.setMode('edit');
     }.bind(this);

     this.clickMoveBucketButton = function (e) {
         let action_code = e.target.getAttribute('action-code');
         let bucket_code = e.target.getAttribute('bucket-code');
         ACTIONS.moveBucketAction(action_code,bucket_code, function (res) {
             ACTIONS.loadPageCockpit();
         });
     };

     this.clickArchiveButton = function (e) {
         ACTIONS.archiveAction(this.opts.object.action_code, function (res) {
             ACTIONS.loadPageCockpit();
         });
     }.bind(this);

     this.clickStartButton = function (e) {
         ACTIONS.startAction(this.opts.object.action_code, function (res) {
             ACTIONS.loadPageCockpit();
         });
     }.bind(this);

     this.clickStopButton = function (e) {
         ACTIONS.stopAction(this.opts.object.action_code, function (res) {
             ACTIONS.loadPageCockpit();
         });
     }.bind(this);

     this.callbacks = function () {
         return {
             'start-stop': {
                 order: 1,
                 func: this.opts.started ? this.clickStopButton : this.clickStartButton,
                 label: this.opts.started ? 'Stop' : 'Start',
                 mode: ''
             },
             'move-bucket': {
                 order: 2,
                 func: this.clickMoveButton,
                 label: 'Move',
                 mode: ''
             },
             'edit': {
                 order: 3,
                 func: this.clickEditButton,
                 label: 'Edit',
                 mode: ''
             },
             'close': {
                 order: 4,
                 func: this.clearMode,
                 label: 'Close',
                 mode: 'move-bucket'
             },
             'save': {
                 order: 5,
                 func: function () {},
                 label: 'Save',
                 mode: 'edit'
             },
             'cancel': {
                 order: 6,
                 func: this.clearMode,
                 label: 'Cancel',
                 mode: 'edit'
             }
         }
     }.bind(this)

     this.title = function () {
         var obj = this.opts.object;

         if (obj['_class']=='action-start' ||
             obj['_class']=='action')
             return 'Action'

         if (obj['_class']=='project')
             return 'Project'

         if (obj['_class']=='wbs')
             return 'WBS'

         if (obj['_class']=='activity')
             return 'Activity'

         return '???';
     }.bind(this);

     this.description = function () {
         var obj = this.opts.object;

         if ((obj['_class']=='action-start' ||
              obj['_class']=='action') &&
             obj.description)
             return obj.description;

         if (obj['_class']=='project')
             return obj.project_code + obj.name;

         if (obj['_class']=='activity')
             return obj.title;

         if (obj['_class']=='wbs')
             return obj.title;

         return '???';
     }.bind(this);

    </script>

</main-card>
