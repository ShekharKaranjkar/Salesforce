@isTest
public class NumberToWordTest {
    public static TestMethod void TestNumberToWord(){
        Test.startTest();
        	NumberToWord cls = new NumberToWord();
       			 NumberToWord.convert_nn(10);
       			 NumberToWord.convert_nn(100);
       			 NumberToWord.convert_nn(90);
        		 NumberToWord.convert_nnn(15);
        		 NumberToWord.english_number(16);
        		 NumberToWord.english_number(1000);
        Test.stopTest();
  	}
}