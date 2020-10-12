public class WBLead {
    public list<Lead> leadlist {set;get;}
    public WBLead(){
        leadlist = new list<Lead>();
    }
    public static lead createlead(string name ,string email,string phone,string company){
        lead le = new lead();
        le.LastName=name;
        le.Email=email;
        le.Phone=phone;
        le.Company = company;
        return le;
        
    }

}