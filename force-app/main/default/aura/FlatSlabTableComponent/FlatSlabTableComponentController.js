({
    GetTable : function(component, event) {
        var params = event.getParam('arguments');
        if (params) {
            var param1 = params.tableshow;
            return param1;
        }
   
    }
})