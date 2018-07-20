<cockpit-main>
    <div class="columns" style="padding: 0px 22px">
        <div class="column is-2">
            <bucket-card each={this.displayBuckets()}
                         selected={this.selected(bucket_code)}
                         bucket-code={bucket_code}
                         bucket-name={name}
                         onclick={this.clickBucket}></bucket-card>
        </div>

        <div class="column">
            <main-card each={obj in this.displayDatas()}
                       action-code={obj.action_code}
                       selected={this.selectedAction(obj.action_code)}
                       started={this.startAction(obj.action_code)}
                       object={obj}
                       buckets={this.displayBuckets()}></main-card>
        </div>
    </div>

    <style>
     main-card { float: left; margin-right: 22px; margin-bottom: 22px;}
    </style>

    <script>
     this.clickBucket = function (e) {
         let target = e.target;
         if (target.tagName=='DIV')
             target = target.parentElement;

         STORE.dispatch(
             ACTIONS.selectBucket('cockpit',
                                  target.getAttribute('bucket-code') * 1));
     };
     this.startAction = function (code) {
         let started_action = this.opts.data.actionStart;
         if (!started_action)
             return false;

         let start_code = started_action ? started_action.action_code : null;
         return (code==start_code);
     }.bind(this);

     this.selected = function (bucket_code) {
         return this.opts.data.selected.bucket==bucket_code;
     }.bind(this);

     this.selectedAction = function (code) {
         return this.opts.selectedAction==code;
     }.bind(this);

     this.ensure = function (list) {
         return list ? list : [];
     }

     this.displayBuckets = function () {
         let buckets = this.opts.buckets ? this.opts.buckets : [];

         return buckets
             .filter(function (value,index,array) {
                 return value.bucket_type != 666;
             })
             .sort(function (a, b) {
                 return a.order_number < b.order_number ? -1 : 1;
             });
     }.bind(this);

     this.displayActions = function () {
         let actions = this.ensure(this.opts.actions)
         let out = [];
         let bucket = this.opts.data.selected.bucket;

         for (var i in actions)
             if (actions[i].bucket_code == bucket)
                 out.push(actions[i]);

         return out;
     }.bind(this);

     this.displayDatas = function () {
         return []
             .concat(this.displayActions());
         // .concat(this.ensure(this.opts.activities))
         // .concat(this.ensure(this.opts.wbs))
         // .concat(this.ensure(this.opts.projects))
         ;
     }.bind(this);
    </script>
</cockpit-main>
