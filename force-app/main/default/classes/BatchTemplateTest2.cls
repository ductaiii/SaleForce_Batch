/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 *
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class BatchTemplateTest2 {

    @isTest
    static void myUnitTest() {
        // TO DO: implement unit test
        Test.startTest();
        BatchTemplate batch = new BatchTemplate();
        Database.executeBatch(batch);
        Test.stopTest();

        // Verify the results
        List<Account> processedAccounts = [SELECT Id, Name FROM Account WHERE Name = 'Điêu Thuyền'];
        System.assertEquals(1, processedAccounts.size(), 'Expected one account to be processed');
        System.assertEquals('Điêu Thuyền', processedAccounts[0].Name, 'Expected account name to match');

        // Verify that no other accounts were processed
        List<Account> allAccounts = [SELECT Id, Name FROM Account];
        System.assertEquals(1, allAccounts.size(), 'Expected only one account to exist');
        System.assertEquals('Điêu Thuyền', allAccounts[0].Name, 'Expected account name to match');

    }
}