/**
* @author         IY/salesforce services
* @date           7/4/2017
* @description    Test class for RecordTypeModel class
* @group          Test
*
*
*/
@IsTest
public class RecordTypeModelTest {


    @IsTest
    public static void accountTests() {
        System.assertNotEquals(null, RecordTypeModel.Account_PropertyId);
    }


    @IsTest
    public static void findRecordTests() {
        System.assertNotEquals(null, RecordTypeModel.RecordTypeMapById);
        System.assert( RecordTypeModel.RecordTypeMapById.size() > 0 );
        string recordTypeName = RecordTypeModel.findRecordTypeNameById( RecordTypeModel.Account_PropertyId);

    }


    @IsTest
    public static void negativeTests() {
        System.assertEquals(null, RecordTypeModel.LookupRecordType('Contact','DoesNotExist'));
        System.assertEquals(null, RecordTypeModel.LookupRecordTypeId('Contact','DoesNotExist'));
        RecordTypeModel.findRecordTypeNameById(null);

    }



}