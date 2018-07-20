<action-list>
    <table class="table is-bordered is-striped is-narrow is-hoverable">
        <thead>
            <tr>
                <td>Code</td>
                <td>Description</td>
            </tr>
        </thead>
        <tbody>
            <tr each={this.opts.actions}>
                <td>{activity_code}</td>
                <td>{description}</td>
            </tr>
        </tbody>
    </table>
</action-list>
