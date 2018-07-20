<main-card-contents-edit>
    <textarea style="height: 271px; border: 1px solid #eeeeee;">{this.opts.description}</textarea>

    <button class="button is-danger" onclick={this.opts.clickArchiveAction}>Archive</button>

    <script>
     dump(this.opts.description);
    </script>
</main-card-contents-edit>
