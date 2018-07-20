<wbs-list>
    <table class="table is-bordered is-striped is-narrow is-hoverable">
        <thead>
            <tr>
                <td>Code</td>
                <td>Name</td>
            </tr>
        </thead>
        <tbody>
            <tr each={this.opts.wbs}>
                <td>{wbs_code}</td>
                <td>{title}</td>
            </tr>
        </tbody>
    </table>
</wbs-list>
