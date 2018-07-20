<projects-unit-tabs>
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
         let project_code = this.opts.project_code;
         return project_code ?
                '#projects/' + project_code + '/' + code :
                '';
     };
    </script>
</projects-unit-tabs>
