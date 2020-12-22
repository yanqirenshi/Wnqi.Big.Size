<models_page_tab_wbs>
    <section class="section">
        <div class="container">
            <h1 class="title"></h1>
            <div class="contents">
                <models_converter source={model()}></models_converter>
            </div>
        </div>
    </section>

    <script>
     this.model = () => {
         return STORE.get('models.wbs');
     };
    </script>
</models_page_tab_wbs>
