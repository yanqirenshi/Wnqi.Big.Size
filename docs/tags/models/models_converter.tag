<models_converter>
    <div style="display:flex;">
        <div style="flex-grow:1;">
            <textarea class="textarea">{source()}</textarea>
        </div>
        <div>
            <button class="button" onclick={clickConvertButton}>変換</button>
        </div>
        <div style="flex-grow:1;">
            <textarea class="textarea">{target()}</textarea>
        </div>
    </div>

    <script>
     this.node_json = null;
     this.clickConvertButton = () => {
         this.node_json = new Wbs().makeTreeNode(opts.source);
         this.update();
     };
    </script>

    <script>
     this.target = () => {
         if (!this.node_json)
             return '';

         return JSON.stringify(this.node_json, null, "   ");
     };
     this.source = () => {
         return JSON.stringify(opts.source, null, "   ");
     };
    </script>

    <style>
     models_converter .button {
         margin-left:11px;
         margin-right:11px;
         height:100%;
     }
     models_converter .textarea {
         height: 555px;
     }
    </style>
</models_converter>
