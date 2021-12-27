@IsTest
public class Test_CAT_C_Digital {
     Static testMethod  void  accountUnitTest(){
        // Create an account with predefined default values
        List<Account> accountList1 = new List<Account>();
        for(Integer i=0;i<10;i++){
            Account acct = (Account)Account.sObjectType.newSObject(null, true);
            // Provide a value for Name
            acct.Name = 'Acme'+i;
            accountList1.add(acct);
         }
        // Insert new account
        insert accountList1;
        Map<Id, SObject> historyMap = new Map<Id, SObject>(accountList1);
       
        List<Account> accountList2 = new List<Account>();
        integer i=0;
         for(Account ac: accountList1){
             Account acc =new Account(Id=ac.id);
             acc.Name = 'New Acme'+i++;
             accountList2.add(acc);
         }
         // Insert new account
        update accountList2;
         
        String objectName = 'Account'; 
  		Map<String , Schema.SObjectType> schemaGlobalDescription = Schema.getGlobalDescribe();
   		Schema.sObjectType objType = schemaGlobalDescription.get(objectName); 
   		Schema.DescribeSObjectResult objDescribeSObjectResult = objType.getDescribe(); 
   		Map<String , Schema.SObjectField> mapFieldList = objDescribeSObjectResult.fields.getMap();
        Map<SObjectField, String> valueMatchDef = New Map<SObjectField, String>();
       	for(String fieldName : mapFieldList.keyset()){
            if(fieldName =='name'){
                valueMatchDef.put(mapFieldList.get(fieldName),'New Acme1');
            }
        }
         
        Test.startTest();
        CAT_C_Digital.filterRecords(accountList2,historyMap,mapFieldList.values(),valueMatchDef);
         
        test.stopTest();
        
     }
}