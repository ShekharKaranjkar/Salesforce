trigger contractActivenotification on Contract (After update, After insert) {
//Boolean isrecursive = True;
    if(trigger.isAfter && trigger.isUpdate){
        ContractActivatenotifications controller =new ContractActivatenotifications();
        controller.contractlists(Trigger.New,ContractActivatenotifications.Isrecursive,trigger.oldmap);
    }
    
}