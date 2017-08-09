/**
* @author Jakub Kołacz
* @date 2017
* @group Model
* @description Class responsible to populate relavant fields to Lms Folio Hdr external object
**/

public with sharing class LmsFolioHdr extends ExternalObjectResponse implements ExternalObjectInterface{

    public List<Record> body {get; set;}

    public class Record {

        public String id {get; set;}
        public String c_bill_cd {get; set;}
        public final String c_compor_dept {get; set;}
        public final String c_compor_first_name {get; set;}
        public final String c_compor_gl_cd {get; set;}
        public final String c_compor_last_name {get; set;}
        public final String c_convention_cd {get; set;}
        public final String c_folio_creator_id {get; set;}
        public final String c_prop_cd {get; set;}
        public final String c_prop_cd_fk {get; set;}
        public final String c_quality_cd {get; set;}
        public final String d_folio_create_timestamp {get; set;}
        public final String d_folio_effective_dt {get; set;}
        public final String d_folio_expire_dt {get; set;}
        public final String d_timestamp {get; set;}
        public final String f_folio_id {get; set;}
        public final Decimal f_reserve_id {get; set;}
        public final Integer i_folio_type_id {get; set;}
        public final Integer lms_hotel_activity_fk {get;set;}
    }

	/*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
    public List<Map<String, Object>> populateData(List<Map<String, Object>> rows) {
        for (LmsFolioHdr.Record wrapper : this.body) {
            Map<String, Object> row = new Map<String, Object>();
            row.put('ExternalId', wrapper.id);
            row.put('DisplayUrl', wrapper.id);
            row.put('c_bill_cd', wrapper.c_bill_cd);
            row.put('c_compor_dept', wrapper.c_compor_dept);
            row.put('c_compor_first_name', wrapper.c_compor_first_name);
            row.put('c_compor_gl_cd', wrapper.c_compor_gl_cd);
            row.put('c_compor_last_name', wrapper.c_compor_last_name);
            row.put('c_convention_cd', wrapper.c_convention_cd);
            row.put('c_folio_creator_id', wrapper.c_folio_creator_id);
            row.put('c_prop_cd', wrapper.c_prop_cd);
            row.put('c_prop_cd_fk', wrapper.c_prop_cd_fk);
            row.put('c_quality_cd', wrapper.c_quality_cd);
            row.put('d_folio_create_timestamp', wrapper.d_folio_create_timestamp);
            row.put('d_folio_effective_dt', wrapper.d_folio_effective_dt);
            row.put('d_folio_expire_dt', wrapper.d_folio_expire_dt);
            row.put('d_timestamp', wrapper.d_timestamp);
            row.put('f_folio_id', wrapper.f_folio_id);
            row.put('f_reserve_id', wrapper.f_reserve_id);
            row.put('i_folio_type_id', wrapper.i_folio_type_id);
            row.put('lms_hotel_activity_fk', wrapper.lms_hotel_activity_fk);
            rows.add(row);
        }
        return rows;
    }
}