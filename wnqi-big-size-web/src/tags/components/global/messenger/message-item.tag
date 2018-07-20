<message-item>
    <article class="message is-dark" style="width:333px;">
        <div class="message-header">
            <p>{opts.title}</p>
            <button class="delete" aria-label="delete"></button>
        </div>
        <div class="message-body" style="height:111px;">
            <p style="width:100%; height:100%; overflow: auto;">
                <yield/>
            </p>
        </div>
    </article>
</message-item>
