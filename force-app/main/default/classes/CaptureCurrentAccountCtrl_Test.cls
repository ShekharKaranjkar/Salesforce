@isTest
public class CaptureCurrentAccountCtrl_Test {
    testMethod
    public static void capture_test() {
        Boolean result = CaptureCurrentAccountCtrl.capture( 'ACCOUNT-ID' );
        
        System.assertEquals( TRUE, result );
    }
}