<global-nav-item class="{opts.menu.display ? '' : 'hide'}"
                 code={opts.menu.code}
                 action-type={opts.menu.action.type}
                 action-data={opts.menu.action.data}
                 style="bottom: {opts.menu.position.bottom}px; right: {opts.menu.position.right}px">

    <li class="{opts.menu.display ? '' : 'hide'}"
        title={title}>
        <span>
            <i class="fa {opts.menu.icon}"></i>
        </span>
    </li>

    <style>
     global-nav-item {
         z-index:88888888;
         background: #ffffff;
         color: rgba(137, 91, 138, 0.66);
         position: fixed;
         margin-left: 11px;
         width: 55px;
         height: 55px;
         border-radius: 55px;
         border: 1px solid #cccccc;
         box-shadow: 0 0 11px #eeeeee;

         padding-top: 3px;
         font-size: 33px;
         text-align: center;

     }
     global-nav-item:hover {
         background: rgba(137, 91, 138, 0.66);
         color: #ffffff;
     }
     global-nav-item.hide {
         display: none;
     }
    </style>
</global-nav-item>
