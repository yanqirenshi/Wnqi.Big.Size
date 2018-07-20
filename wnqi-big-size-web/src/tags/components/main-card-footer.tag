<main-card-footer>
    <div each={this.footerItemData()}
         class="card-footer-item">
        <button class="card-operator button start-stop"
                onClick={func}>
            {label}
        </button>
    </div>


    <script>
     this.footerItemData = function () {
         let callbacks = this.opts.callbacks ? this.opts.callbacks : [];
         let out = [];
         let mode = this.opts.mode;

         for (var i in callbacks)
             if (mode==callbacks[i].mode)
                 out.push(callbacks[i]);

         return out.sort(function (a, b) {
             return a.order < b.order ? -1 : 1;
         })
     }.bind(this);
    </script>
</main-card-footer>
