<example_page_tab_option-right>

    <div>
        <p>
            <pre style="width:344px; fonts-size:12px;line-height:14px;">{JSON.stringify(this.options, null, 4)}</pre>
        </p>
    </div>

    <script>
     this.options = {
         hide: {
             wbs: {
                 finished: false,
             },
             workpackage: {
                 finished: false,
             }
         },
         term: {
             start: null,
             end: null,
         },
         columns: {
             code: {
                 code: "code",
                 hide: false,
             },
             name: {
                 code: "name",
                 hide: false,
             },
             schedule: {
                 code: "schedule",
                 hide: true,
                 children: {
                     start: {
                         hide: null, // 未使用
                     },
                     end: {
                         hide: null, // 未使用
                     },
                 }
             },
             result: {
                 code: "result",
                 hide: true,
                 children: {
                     start: {
                         hide: null, // 未使用
                     },
                     end: {
                         hide: null, // 未使用
                     },
                 }
             },
             operators: {
                 code: "operators",
                 hide: true,
             },
             description: {
                 code: "description",
                 hide: false,
             },
         },
         rows: {
             workpackage: {
                 hide: false,
             }
         }
     };
    </script>

    <style>
     example_page_tab_option-left {
         display: flex;
     }
    </style>
</example_page_tab_option-right>
