<project-list>
    <table class="table is-bordered is-striped is-narrow is-hoverable">
        <thead>
            <tr>
                <td>Code</td>
                <td>Name</td>
            </tr>
        </thead>
        <tbody>
            <tr each={this.opts.projects ? this.opts.projects : []}>
                <td>
                    <a href="#projects/{project_code}">{project_code}</a>
                </td>
                <td>{name}</td>
            </tr>
        </tbody>
    </table>

    <script>
    </script>
</project-list>
