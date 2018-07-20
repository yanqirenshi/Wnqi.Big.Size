<bucket-card class="{this.classSelected()}">
    <div class="bucket card"
         bucket-code="bucketCode">
        {opts.bucketName}
    </div>

    <style>
     bucket-card > div{
         margin-bottom: 11px;
         padding: 11px;
     }
     bucket-card.selected > div{
         border: 1px solid rgba(137, 91, 138, 0.66);
     }
    </style>

    <script>
     this.classSelected = function() {
         return this.opts.selected ? this.opts.selected : '';
     }.bind(this);
    </script>
</bucket-card>
