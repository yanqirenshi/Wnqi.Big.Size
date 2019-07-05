<example_page_tab_option-left>

    <div class="indicator">
        <h1 class="title is-4"><code>hide</code></h1>

        <div class="contents">
            <p>データの状態による表示/非表示を管理します。</p>
            <p>2019-06-27 (Thu) 時点では <code>rows</code> に移行予定です。</p>
        </div>
    </div>

    <div class="indicator">
        <h1 class="title is-4"><code>term</code></h1>

        <div class="contents">
        </div>
    </div>

    <div class="indicator">
        <h1 class="title is-4"><code>columns</code></h1>

        <div class="contents">
            <p>主に以下の設定を管理します。</p>
            <ol style="margin-left:33px;">
                <li>列の表示/非表示、</li>
                <li>列のヘッダの表示形式</li>
                <li>列の値の表示形式</li>
            </ol>
        </div>
    </div>

    <div class="indicator">
        <h1 class="title is-4"><code>rows</code></h1>

        <div class="contents">
            <p>主に以下の設定を管理します。</p>
            <ol style="margin-left:33px;">
                <li>行の表示/非表示、</li>
            </ol>
            <p>※ この機能は実装中です。</p>
        </div>

        <div class="indicator">
            <h1 class="title is-4"><code>operators</code></h1>

            <div class="contents">
                <p>pageLink は id の リンク先をカスタマイズします。</p>
                <p>id の リンク先を返す関数を設定します。</p>
                <p>pageLink が空の場合は、標準の URL を返します。</p>
                <p><pre>/* Sample Code */
operators: \{
    pageLink: (record) => \{
        let path_node = null;

        if (record._class=='WBS')
            path_node = 'wbs';
        else if (record._class=='PROJECT')
            path_node = 'projects';
        else if (record._class=='WORKPACKAGE')
            path_node = 'workpackages';

        if (!path_node)
            throw new Error('不明な Class です。class=' + record._class);

        return '%s/%s/%d'.format(
            location.hash.split('/')[0],
            path_node,
            record._id)
    \},
\},</pre></p>
            </div>
        </div>
    </div>

    <style>
     example_page_tab_option-left {
         flex-grow: 1;

         margin-left: 22px;

         display: flex;
         flex-direction: column;
     }
     example_page_tab_option-left > .indicator {
         margin-bottom: 33px;
     }
     example_page_tab_option-left .indicator > .title {
         margin-bottom: 6px;
     }
     example_page_tab_option-left .indicator > .contents {
         padding-left: 22px;
     }

     example_page_tab_option-left .contents pre{
         font-size: 12px;
         line-height: 12px;
         padding: 11px 22px;
     }
     example_page_tab_option-left .indicator > .indicator {
         padding-top:11px;
         padding-left:22px;
     }
    </style>
</example_page_tab_option-left>
