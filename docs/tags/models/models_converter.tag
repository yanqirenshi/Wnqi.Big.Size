<models_converter>
    <div style="display:flex;">
        <div style="flex-grow:1;">
            <textarea class="textarea">{source()}</textarea>
        </div>
        <div>
            <button class="button">変換</button>
        </div>
        <div style="flex-grow:1;">
            <textarea class="textarea"></textarea>
        </div>
    </div>

    <script>
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
