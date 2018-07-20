<main-card-contents-move-bucket>
    <p>どのバケットに移動しますか？</p>
    <table class="table is-bordered is-striped is-narrow is-hoverable"
           style="font-size: 12px;">
        <htead>
            <tr>
                <th>name</th>
                <th>description</th>
                <th></th>
            </tr>
        </htead>
        <tbody>
            <tr each={this.opts.buckets}>
                <td>{name}</td>
                <td>{description}</td>
                <td>
                    <button class="button is-small""
                            action-code={this.opts.object.action_code}
                            bucket-code={bucket_code}
                            onclick={this.opts.clickMoveBucketAction}>
                        ここに移動する
                    </button>
                </td>
            </tr>
        </tbody>
    </table>
</main-card-contents-move-bucket>
