trigger UpdateOppOnTaskComplete on Task (after update) {
    UpdateOppOnTaskCompleteHnadler.updateparentrecordsopp(Trigger.New,Trigger.OldMap);
    TaskHandler.updateparentrecords(Trigger.New,Trigger.OldMap);
    
        ContractHandler.updateparentrecords(Trigger.New,Trigger.OldMap);

        VehicleTaskHandler.updateparentrecords(Trigger.New,Trigger.OldMap);
    }