({
    getTotalList :function(component, event, helper) {
        var tota= component.get("v.total");
        console.log('getTripModel=='+tota);
        var getTripModel = event.getSource().get("v.value");
        var comp= component.get("v.singleRec");
        console.log('comp=='+JSON.stringify(comp));
        var t = comp.PriceCarMonth;
        console.log('t=='+t);
        console.log('getTripModel=='+getTripModel);
        var val=getTripModel*t;
        var temp= val+tota;
        console.log('temp=='+temp);
        component.set("v.total",temp);
        
	}
})