/**
 * Created by Michal Bluj on 2017-06-28.
 */

@IsTest
private  class TestFactoryTest {

    @IsTest
    public static void unitTest() {


        System.assert(TestFactory.PODs.size() >= 3);
        System.assert(TestFactory.Markets.size() >= 3);
        System.assert(TestFactory.DMCs.size() >= 3);
        System.assert(TestFactory.Properties.size() >= 2);
        System.assert(TestFactory.campaignProjects.size() >= 1);
        System.assert(TestFactory.offerDefinitions.size() >= 2);
        System.assert(TestFactory.offerIncentives.size() >= 2);

    }

}