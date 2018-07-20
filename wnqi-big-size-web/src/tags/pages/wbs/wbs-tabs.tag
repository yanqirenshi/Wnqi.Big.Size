<wbs-tabs>
    <div class="tabs">
        <ul>
            <li each={opts.tabs}
                class={active ? 'is-active' : '';}>
                <a href={href(code)}>{label}</a>
            </li>
        </ul>
    </div>

    <script>
     this.href = function (code) {
         let wbs = this.opts.wbs;
         return '#' +
                  (wbs ? 'wbs/' + wbs.wbs_code + '/' + code : '');
     };
    </script>
</wbs-tabs>
