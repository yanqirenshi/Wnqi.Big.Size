<action-history-list>
    <table class="table is-bordered is-striped is-narrow is-hoverable">
        <thead>
            <tr>
                <td>Code</td>
                <td>Description</td>
                <td>parson</td>
                <td>start</td>
                <td>end</td>
                <td>elapsed_time</td>
            </tr>
        </thead>
        <tbody>
            <tr each={this.opts.actionHistories}>
                <td>{action_code}</td>
                <td>{description}</td>
                <td>{parson_name}</td>
                <td>{dt(start_time)}</td>
                <td>{dt(end_time)}</td>
                <td>{elapsed_time}</td>
            </tr>
        </tbody>
    </table>

    <script>
     this.dt = function (v) {
         if (!v) return '';

         return moment(v).format("YYYY-MM-DD hh:mm");
     };
    </script>
</action-history-list>
