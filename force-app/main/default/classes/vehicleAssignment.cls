public class vehicleAssignment {
    public PageReference page() {
        PageReference p = new PageReference('/apex/driver');
        p.setRedirect(true);
        return p;
        
    }
}