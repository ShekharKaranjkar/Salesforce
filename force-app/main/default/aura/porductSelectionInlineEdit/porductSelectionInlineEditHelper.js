({
    
    getProducts: function(component, event, helper) {
        var action = component.get('c.getAllProducts');
        action.setParams({
            "recordId": component.get("v.recordId")
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                let temp = response.getReturnValue();
                let temp1 = response.getReturnValue();
                let temp2 = response.getReturnValue();
                component.set('v.productListAfterCancelBtn1dModel', JSON.parse(JSON.stringify(temp1)));
                component.set('v.productListAfterCancelBtnTripModel', JSON.parse(JSON.stringify(temp2)));
                
                
                component.set('v.productselected1DList', component.get('v.productListAfterCancelBtn1dModel'));
                component.set('v.productselectedTripList',component.get('v.productListAfterCancelBtnTripModel'));
                
                // component.set('v.productList', response.getReturnValue());                 
            }
        });
        $A.enqueueAction(action);
        
    },
    
    selectedProductHelper:function(component, event, helper){     
        var action = component.get('c.showProductSelected');
        
        var oneDlist   =      component.get('v.productListAfterCancelBtn1dModel');
        var tripList    =      component.get('v.productListAfterCancelBtnTripModel');
        console.log('oneDlist=================11111'+JSON.stringify(component.get('v.productListAfterCancelBtn1dModel')));
        console.log('oneDlist==========1=======11111'+JSON.stringify(component.get('v.productselected1DList')));
        console.log('tripList=================11111'+JSON.stringify(component.get('v.productListAfterCancelBtnTripModel')));
        
        
        console.log('oneDlist==========1=======11111'+JSON.stringify(component.get('v.productselectedTripList')));
        
        var selectedProductsList = component.get('v.productselected1DList').concat(component.get('v.productselectedTripList')   );
        
        console.log('oneDlist==========1=======11111'+JSON.stringify(selectedProductsList));
        
        
        action.setParams({
            "selectedProductsList": selectedProductsList
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") { 
                console.log('product=================11111'+JSON.stringify(response.getReturnValue()));
                component.set('v.selectedProductList', response.getReturnValue());  
                
            }
        });
        $A.enqueueAction(action); 
    },
    
    getproductNewList :function(component, event, helper){  
       // console.log('productListAfterCancelBtn1dModel'+JSON.stringify(component.get('v.productListAfterCancelBtn1dModel')));
     //   console.log('productListAfterCancelBtnTripModel'+JSON.stringify(component.get('v.productListAfterCancelBtnTripModel')));
        //  var allproduct=component.get('v.productList');
        //var oneD=component.get('v.productListAfterCancelBtn1dModel');
        
        var results=[];   
        var input= component.get("v.searchKeyword");
        console.log('inputvalue'+input);   
        let products=[];
        var id = event.getSource().getLocalId(); 
        if(id=='oneD'){
            //console.log('id'+id);
            products= component.get('v.productListAfterCancelBtn1dModel');
            
        }else{
            
           // console.log('id2'+id);
            products= component.get("v.productListAfterCancelBtnTripModel");
        }
        
        
        if(input){

            if(products.length==0 ){
                        if(id=='oneD'){
            products= component.get('v.productselected1DList');
            
        }else{

            products= component.get("v.productselectedTripList");
        }

            }
            console.log('products=json'+JSON.stringify(products));
            for(var i=0; i<products.length; i++) {
               console.log('in1='+products.length); 
                var t=products[i].pbe.Product2;  
                for(var key in t) {
                    console.log('key1'+key);
                    console.log('input.toLowerCase().length'+input.toLowerCase().length);
                       console.log('t[key]'+t[key]);
                    console.log('for='+t[key].toLowerCase().substring(0, input.toLowerCase().length));
                   console.log('for1='+ input.toLowerCase());
                    if(t[key].toLowerCase().substring(0, input.toLowerCase().length)==input.toLowerCase()) {

                        results.push(products[i]);
                    }
                }     
                
            }
            if(id=='oneD'){
                //console.log('intabofOnD');
                component.set('v.productListAfterCancelBtn1dModel', results);   
                
            }else{
                
                component.set('v.productListAfterCancelBtnTripModel', results);
            }
            
            
          //  console.log('1productListAfterCancelBtn1dModel'+JSON.stringify(component.get('v.productListAfterCancelBtn1dModel')));
          //  console.log('1productListAfterCancelBtnTripModel'+JSON.stringify(component.get('v.productListAfterCancelBtnTripModel')));
            
            
        } else{
           // console.log('else');    
           // console.log('12productListAfterCancelBtn1dModel'+JSON.stringify(component.get('v.productselected1DList')));
          //  console.log('12productListAfterCancelBtnTripModel'+JSON.stringify(component.get('v.productselectedTripList')));
            if(id=='oneD'){
                component.set('v.productListAfterCancelBtn1dModel', component.get('v.productselected1DList'));  
                
            }
            else
            {
                component.set('v.productListAfterCancelBtnTripModel', component.get('v.productselectedTripList'));   
            }
            
        }
        
        
        
        
    },
    
    getproductAfterCancel : function(component, event, helper){
        component.set('v.productListAfterCancelBtnTripModel',  component.get('v.productselectedTripList'));
        component.set('v.productListAfterCancelBtn1dModel', component.get('v.productselected1DList')); 
    },
    
    
})