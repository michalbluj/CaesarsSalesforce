/**
 * @author Cezary Zeleznicki
 * @date 31.07.2017.
 * @group Model
 * @description generic class responsible mappign ApPdbTripHtl json response
 */
public with sharing class ApPdbTripHtl extends ExternalObjectResponse implements ExternalObjectInterface{

    public List<Record> body {get; set;}

    public class Record {
        public String id {get; set;}

        public final Integer ap_pdb_trip_hdr_fk {get; set;}
        public final String c_prop_market_cd {get; set;}
        public final String c_quality_cd {get; set;}
        public final String contact_fk {get; set;}
        public final String d_end_dt {get; set;}
        public final String d_start_dt {get; set;}
        public final String d_timestamp {get; set;}
        public final Decimal f_comp_rev {get; set;}
        public final Decimal f_fb_rev {get; set;}
        public final Decimal f_other_rev {get; set;}
        public final Decimal f_room_rev {get; set;}
        public final String i_ap_pdb_trip_id {get; set;}
        public final String i_dmid {get; set;}
        public final Integer i_nbr_occupants {get; set;}
        public final Integer i_nbr_rooms {get; set;}
        public final Integer i_prop_market_type_id {get; set;}
        public final Integer i_rm_night {get; set;}
        public final Integer i_stay {get; set;}
        public final String market_fk {get; set;}
    }

    /*
    * @description populates data from wrapper to map that represents row
    * @param row data row to be filled
    * @param wrapper object that contains data
    * @return row representation
    */
    public List<Map<String, Object>> populateData(List<Map<String, Object>> rows) {
        for (ApPdbTripHtl.Record wrapper : this.body) {
            Map<String, Object> row = new Map<String, Object>();
            row.put('id', wrapper.id);
            row.put('ExternalId', wrapper.id);
            row.put('DisplayUrl', wrapper.id);
            row.put('ap_pdb_trip_hdr_fk', wrapper.ap_pdb_trip_hdr_fk);
            row.put('c_prop_market_cd', wrapper.c_prop_market_cd);
            row.put('c_quality_cd', wrapper.c_quality_cd);
            row.put('contact_fk', wrapper.contact_fk);
            row.put('d_end_dt', wrapper.d_end_dt);
            row.put('d_start_dt', wrapper.d_start_dt);
            row.put('d_timestamp', wrapper.d_timestamp);
            row.put('f_comp_rev', wrapper.f_comp_rev);
            row.put('f_fb_rev', wrapper.f_fb_rev);
            row.put('f_other_rev', wrapper.f_other_rev);
            row.put('f_room_rev', wrapper.f_room_rev);
            row.put('i_ap_pdb_trip_id', wrapper.i_ap_pdb_trip_id);
            row.put('i_dmid', wrapper.i_dmid);
            row.put('i_nbr_occupants', wrapper.i_nbr_occupants);
            row.put('i_nbr_rooms', wrapper.i_nbr_rooms);
            row.put('i_prop_market_type_id', wrapper.i_prop_market_type_id);
            row.put('i_rm_night', wrapper.i_rm_night);
            row.put('i_stay', wrapper.i_stay);
            row.put('market_fk', wrapper.market_fk);
            rows.add(row);
        }
        return rows;
    }
}