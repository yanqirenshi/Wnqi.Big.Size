var _MENUS = [
    {
        code: 2,
        title: 'Add New Action',
        icon: 'fa-plus',
        action: {
            type: 'OPEN-FORM',
            data: 'create-action'
        },
        position: {
            bottom: 22,
            right: 11 + (55 * 2 + 11 * 3)
        },
        display: true,
        group: 'root',
        menus: null
    },
    {
        code: 3,
        title: 'Move page',
        icon: 'fa-rocket',
        action: {
            type: 'TOGGLE-GROUP',
            data: 'move-page'
        },
        position: {
            bottom: 22,
            right: 11 + (55 * 1 + 11 * 2)
        },
        display: true,
        group: 'root',
        menus: null
    },
    {
        code: 4,
        title: 'Cockpit',
        icon: 'fa-home',
        action: {
            type: 'MOVE-PAGE',
            data: '#cockpit'
        },
        position: {
            bottom: 22,
            right: 11 + (55 * 0 + 11 * 1)
        },
        display: true,
        group: 'root',
        menus: null
    },
    {
        code: 5,
        title: 'Projects',
        icon: 'fa-product-hunt',
        action: {
            type: 'MOVE-PAGE',
            data: '#projects'
        },
        position: {
            bottom: 11 + (55 * 1 + 11 * 2),
            right: 11 + (55 * 1 + 11 * 2)
        },
        display: false,
        group: 'move-page',
        menus: null
    },
    {
        code: 6,
        title: 'Parsons',
        icon: 'fa-users',
        action: {
            type: 'MOVE-PAGE',
            data: '#parsons'
        },
        position: {
            bottom: 11 + (55 * 2 + 11 * 3),
            right: 11 + (55 * 1 + 11 * 2)
        },
        display: false,
        group: 'move-page',
        menus: null
    },
    {
        code: 6,
        title: 'Sign out',
        icon: 'fa-sign-out',
        action: {
            type: 'SIGN-OUT',
            data: '#sign-out'
        },
        position: {
            bottom: 11 + (55 * 3 + 11 * 4),
            right: 11 + (55 * 1 + 11 * 2)
        },
        display: false,
        group: 'move-page',
        menus: null
    }
];
