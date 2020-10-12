public class ProjectTaskHandler {
    public void createTask(list<MPM4_BASE__Milestone1_Milestone__c> Mile)
    {
        List<MPM4_BASE__Milestone1_Task__c> milestsonelist = new list<MPM4_BASE__Milestone1_Task__c>();
        for(MPM4_BASE__Milestone1_Milestone__c mi: Mile){
            
             if(mi.name == 'Driver Recruitment')
            {
                MPM4_BASE__Milestone1_Task__c miles = new MPM4_BASE__Milestone1_Task__c();
                miles.Name = 'Recruitment plan based on the trip profile & requirement of SP shifts';
                miles.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles);
                
                MPM4_BASE__Milestone1_Task__c miles1 = new MPM4_BASE__Milestone1_Task__c();
                miles1.Name = 'Road shows, quikr ads, justdial ads, referrals to atrract SPs';
                miles1.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles1);
                
                MPM4_BASE__Milestone1_Task__c miles2 = new MPM4_BASE__Milestone1_Task__c();
                miles2.Name = 'Document prepartaion at Lithium side DL,PVC,BGV,Aadhar,Pan,Medical';
                miles2.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles2);    
                
                
                MPM4_BASE__Milestone1_Task__c miles3 = new MPM4_BASE__Milestone1_Task__c();
                miles3.Name = 'Document check completed';
                miles3.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles3);
                
                MPM4_BASE__Milestone1_Task__c miles4 = new MPM4_BASE__Milestone1_Task__c();
                miles4.Name = 'Iduction of SPs at client site begins';
                miles4.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles4);
                
                MPM4_BASE__Milestone1_Task__c miles5 = new MPM4_BASE__Milestone1_Task__c();
                miles5.Name = 'Lithium internal training';
                miles5.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles5);
                
                MPM4_BASE__Milestone1_Task__c miles6 = new MPM4_BASE__Milestone1_Task__c();
                miles6.Name = 'M&M training';
                miles6.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles6);
                
                MPM4_BASE__Milestone1_Task__c miles7 = new MPM4_BASE__Milestone1_Task__c();
                miles7.Name = 'Induction of SPs at client site completed';
                miles7.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles7);
                
                MPM4_BASE__Milestone1_Task__c miles8 = new MPM4_BASE__Milestone1_Task__c();
                miles8.Name = 'SPs ready for operations';
                miles8.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles8);
                
            }
            
            if(mi.name == 'Charging Infrastructure')
            {
                MPM4_BASE__Milestone1_Task__c miles = new MPM4_BASE__Milestone1_Task__c();
                miles.Name = 'Identifying the load availability at client location';
                miles.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles);
                
                MPM4_BASE__Milestone1_Task__c miles1 = new MPM4_BASE__Milestone1_Task__c();
                miles1.Name = 'Plan for chargers based on trip profile & number of vehicles to be deployed';
                miles1.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles1);
                
                MPM4_BASE__Milestone1_Task__c miles2= new MPM4_BASE__Milestone1_Task__c();
                miles2.Name = 'Procure chargers based on the plan';
                miles2.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles2);
                
                MPM4_BASE__Milestone1_Task__c miles3 = new MPM4_BASE__Milestone1_Task__c();
                miles3.Name = 'Site Survey for identifying place ';
                miles3.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles3);
                
                MPM4_BASE__Milestone1_Task__c miles4 = new MPM4_BASE__Milestone1_Task__c();
                miles4.Name = 'Cabling completed check at site location';
                miles4.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles4);
                
                MPM4_BASE__Milestone1_Task__c miles5 = new MPM4_BASE__Milestone1_Task__c();
                miles5.Name = 'Logistics of charger to client site';
                miles5.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles5);
                
                MPM4_BASE__Milestone1_Task__c miles6 = new MPM4_BASE__Milestone1_Task__c();
                miles6.Name = 'Installation of chargers at client location';
                miles6.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles6);
                
                MPM4_BASE__Milestone1_Task__c miles7 = new MPM4_BASE__Milestone1_Task__c();
                miles7.Name = 'Testing of installed chargers';
                miles7.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles7);
                
                MPM4_BASE__Milestone1_Task__c miles8 = new MPM4_BASE__Milestone1_Task__c();
                miles8.Name = 'Chargers ready for operations';
                miles8.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles8);
                
                
                
            }
            if(mi.name == 'Vehicle Procurement')
            {
                MPM4_BASE__Milestone1_Task__c miles = new MPM4_BASE__Milestone1_Task__c();
                miles.Name = 'Identifying the number of Evs required based on trip profile & submitted plan';
                miles.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles);
                
                MPM4_BASE__Milestone1_Task__c miles1 = new MPM4_BASE__Milestone1_Task__c();
                miles1.Name = 'Procure Evs';
                miles1.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles1);
                
                MPM4_BASE__Milestone1_Task__c miles2 = new MPM4_BASE__Milestone1_Task__c();
                miles2.Name = 'Evs reach the client city';
                miles2.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles2);    
                
                
                MPM4_BASE__Milestone1_Task__c miles3 = new MPM4_BASE__Milestone1_Task__c();
                miles3.Name = 'Identifying workshops for vehicle maintenance';
                miles3.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles3);
                
                MPM4_BASE__Milestone1_Task__c miles4 = new MPM4_BASE__Milestone1_Task__c();
                miles4.Name = 'Identifying washing ramp';
                miles4.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles4);
                
                MPM4_BASE__Milestone1_Task__c miles5 = new MPM4_BASE__Milestone1_Task__c();
                miles5.Name = 'Insurance copy check for the vehicles';
                miles5.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles5);
                
                MPM4_BASE__Milestone1_Task__c miles6 = new MPM4_BASE__Milestone1_Task__c();
                miles6.Name = 'Registration process starts';
                miles6.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles6);
                
                MPM4_BASE__Milestone1_Task__c miles7 = new MPM4_BASE__Milestone1_Task__c();
                miles7.Name = 'Procuring cameras, sleep alert, stickers';
                miles7.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles7);
                
                MPM4_BASE__Milestone1_Task__c miles8 = new MPM4_BASE__Milestone1_Task__c();
                miles8.Name = 'Procuring torch, medical kit, fire extingusiher, umbrella';
                miles8.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles8);
                
                MPM4_BASE__Milestone1_Task__c miles9 = new MPM4_BASE__Milestone1_Task__c();
                miles9.Name = 'Registration completed';
                miles9.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles9);
                
                MPM4_BASE__Milestone1_Task__c miles10 = new MPM4_BASE__Milestone1_Task__c();
                miles10.Name = 'Installation of cameras, sleep alert & stickers';
                miles10.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles10);
                
                MPM4_BASE__Milestone1_Task__c miles11 = new MPM4_BASE__Milestone1_Task__c();
                miles11.Name = 'Fast tag issueds';
                miles11.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles11);
                
                
                
                MPM4_BASE__Milestone1_Task__c miles12 = new MPM4_BASE__Milestone1_Task__c();
                miles12.Name = 'Final EV document check';
                miles12.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles12);
                
                
                MPM4_BASE__Milestone1_Task__c miles13 = new MPM4_BASE__Milestone1_Task__c();
                miles13.Name = 'Evs inducted at client site';
                miles13.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles13);
                
                
                MPM4_BASE__Milestone1_Task__c miles14 = new MPM4_BASE__Milestone1_Task__c();
                miles14.Name = 'Evs ready for operations';
                miles14.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles14);
                
            }
             if(mi.name == 'On-Site Team Allotment')
            {
                MPM4_BASE__Milestone1_Task__c miles = new MPM4_BASE__Milestone1_Task__c();
                miles.Name = 'Recruitment plan based on the trip profile & requirement of Site tea shifts';
                miles.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles);
                
                MPM4_BASE__Milestone1_Task__c miles1 = new MPM4_BASE__Milestone1_Task__c();
                miles1.Name = 'Creating pool of supervisors,trackers,shift incarge & site head(if required)';
                miles1.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles1);
                
                MPM4_BASE__Milestone1_Task__c miles2 = new MPM4_BASE__Milestone1_Task__c();
                miles2.Name = 'Interview process)';
                miles2.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles2);    
                
                
                MPM4_BASE__Milestone1_Task__c miles3 = new MPM4_BASE__Milestone1_Task__c();
                miles3.Name = 'Reference check';
                miles3.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles3);
                
                MPM4_BASE__Milestone1_Task__c miles4 = new MPM4_BASE__Milestone1_Task__c();
                miles4.Name = 'Li Supervisor training& induction';
                miles4.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles4);
                
                MPM4_BASE__Milestone1_Task__c miles5 = new MPM4_BASE__Milestone1_Task__c();
                miles5.Name = 'Supervisor documentation ready - Identify proof, photographs, PVC';
                miles5.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles5);
                
                MPM4_BASE__Milestone1_Task__c miles6 = new MPM4_BASE__Milestone1_Task__c();
                miles6.Name = 'Supervisor induction at client site';
                miles6.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles6);
                
                MPM4_BASE__Milestone1_Task__c miles7 = new MPM4_BASE__Milestone1_Task__c();
                miles7.Name = 'Site team ready for operations';
                miles7.MPM4_BASE__Project_Milestone__c= mi.Id;
                
                milestsonelist.add(miles7);
                
                
            } 
            
        }
        if (milestsonelist.size() > 0)
        insert milestsonelist;
      
        
    }
}