class Reducer extends Simple_Redux_Reducer {
    isMergeActionTypes (action_type) {
        return ['MOVE-PAGE',
                'LOADED-PROJECTS',
                'LOADED-WBS',
                'LOADED-ACTIVITIES',
                'LOADED-ACTIONS',
                'LOADED-PAGE-PROJECTS-UNIT',
                'LOADED-PAGE-PROJECTS-LIST',
                'TOGGLE-GLOBAL-MENU-GROUP',
                'OPEN-FORM',
                'LOADED-PAGE-COCKPIT',
                'SELECT-BUCKET',
                'LOADED-PAGE-WBS'].find(function (v) {
                    return v==action_type;
                }) ;
    }
    put (state, action) {
        return this.isMergeActionTypes(action.type) ?
            this.merge(state, action.data) : state;
    }
}
