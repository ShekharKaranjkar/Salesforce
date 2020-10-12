({
    doInit : function(component, event, helper) {
        var controllingFieldAPI = component.get("v.controllingFieldAPI");
        var dependingFieldAPI = component.get("v.dependingFieldAPI");
        var objDetails = component.get("v.objDetail");
        helper.getProducts(component, event, helper,objDetails,controllingFieldAPI, dependingFieldAPI);
    },
    
    change : function(component, event, helper) { 
        var id = event.getSource().getLocalId(); 
        if(id=='oneDtab'){
            component.set("v.searchKeywordTrip",'');
        }
        if(id=='triptab'){
            component.set("v.searchKeyword1D",''); 
        }
        helper.getproductNewList(component, event, helper);
    },
    
    checkboxSelect: function(component, event, helper) {
        helper.checkboxSelectValues(component, event, helper);
    },
    
    selectedProductsCheckbox: function(component, event, helper) {
        helper.selectedProductHelper(component, event, helper);
    },
    
    goesBack: function(component,event,helper){      
        component.set("v.showHide", true); 
        helper.getproductAfterCancel(component, event, helper);   
    },
    
    
    filterProducts:function(component, event, helper){
        window.setTimeout(
            $A.getCallback(function() {
                helper.getproductNewList(component, event, helper);  
            }), 3000
        );
        
    },
    
    Save: function(component, event, helper) {
            component.set("v.Spinner", true);
        helper.saveProducts(component, event, helper);
            component.set("v.Spinner", false);
    },
    
    showSpinner: function(component, event, helper) {
        component.set("v.Spinner", true); 
    },
    
    hideSpinner : function(component,event,helper){
        component.set("v.Spinner", false);
    },
    
    handleFlat : function(component,event,helper) {
        component.set("v.showFlat", true);
        component.set("v.showSlab", false);
    },
    
    handleSlab : function(component,event,helper) {
        component.set("v.showFlat", false);
        component.set("v.showSlab", true);
    },
    
    addNewRow: function(component, event, helper) {
        var productId = event.getParam("productId");
        helper.createObjectData(component, event,productId);
    },
    
    addNewRow1D : function(component, event, helper) {
        var productId = event.getParam("productId");
        helper.createObjectData1D(component, event,productId);
    },
    
    addNewRowflat : function(component, event, helper) {
        var productId = event.getParam("productId");
        helper.createObjectDataflat(component, event,productId);
    },
    
    removeDeletedRow: function(component, event, helper) {
        console.log("remove in parent"+JSON.stringify(component.get("v.tabelSelectedProduct")));
        var index = event.getParam("indexVar"); 
      //  console.log('index========'+index);
        var AllRowsList = component.get("v.tabelSelectedProduct");
        var productId = event.getParam("productId");
        var DeleteslabList = component.get("v.DeleteslabList");
        for(var i=0 ; i<AllRowsList.length ; i++){
            if(AllRowsList[i].Id == productId){
                var olilist=AllRowsList[i].olislab;
                console.log('olislab'+JSON.stringify(olilist));
                if(olilist[index].oppliid){
                    DeleteslabList.push(olilist[index].oppliid) ;
                }
                olilist.splice(index, 1);
            }
        }  
        component.set("v.DeleteslabList", DeleteslabList);
        console.log('DeleteslabList'+DeleteslabList);
        component.set("v.tabelSelectedProduct", AllRowsList);
    },
    
    removeDeletedRowflat : function(component, event, helper) {
        console.log("remove in parent"+JSON.stringify(component.get("v.tabelSelectedProduct")));
        var index = event.getParam("indexVar"); 
        var AllRowsList = component.get("v.tabelSelectedProduct");
        var productId = event.getParam("productId");
        var DeleteflatList = component.get("v.DeleteflatList");
        for(var i=0 ; i<AllRowsList.length ; i++){
            if(AllRowsList[i].Id == productId){
                var olilist=AllRowsList[i].oliflat;
                console.log('olilistflat1'+JSON.stringify(olilist));
                console.log(index);
                if(olilist[index] != null){
                    DeleteflatList.push(olilist[index].oppliid) ;
                }
                olilist.splice(index, 1);
                AllRowsList[i].oliflat= olilist;
            }
        }  
        component.set("v.DeleteflatList", DeleteflatList);
       // console.log('DeleteflatList'+DeleteflatList);
        component.set("v.tabelSelectedProduct", AllRowsList);
    },
    
    removeDeletedRow1D : function(component, event, helper) {
       // console.log("remove in parent"+JSON.stringify(component.get("v.tabelSelectedProduct1D")));
        var index = event.getParam("indexVar"); 
      //  console.log('index========'+index);
        var AllRowsList = component.get("v.tabelSelectedProduct1D");
        var productId = event.getParam("productId");
      //  console.log('AllRowsList++++'+JSON.stringify(AllRowsList));
        var DeleteoneDList = component.get("v.DeleteoneDList");
        for(var i=0 ; i<AllRowsList.length ; i++){
            if(AllRowsList[i].Id == productId){
                var olilist=AllRowsList[i].oli1D;
                console.log('olilist'+JSON.stringify(olilist));
                if(olilist[index].oppliid){
                    DeleteoneDList.push(olilist[index].oppliid) ;
                }
                olilist.splice(index, 1);
            }
        }  
        component.set("v.DeleteoneDList", DeleteoneDList);
      //  console.log('DeleteoneDList++++'+DeleteoneDList);
      //  console.log('Deleteoneolilist++++'+JSON.stringify(olilist));
        component.set("v.tabelSelectedProduct1D", AllRowsList);
    },
    
    goesToOpp : function(component, event, helper){
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId":component.get("v.recordId") ,
            "slideDevName": "related"
        });
        navEvt.fire();
    },
    
})