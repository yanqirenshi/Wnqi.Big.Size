<projects-unit-wbs style="{opts.display ? '' : 'display:none;'}">
    <section class="section">
        <div class="container">
            <h1 class="title is-3">WBS List</h1>
            <h2 class="subtitle"></h2>
            <div class="contents">
                <wbs-tree-list wbs={STORE.state().pages.projects.unit.WBS}></wbs-tree-list>
            </div>
        </div>
    </section>
</projects-unit-wbs>
