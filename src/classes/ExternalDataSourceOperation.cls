/**
 * Created by Michal Bluj on 2017-06-28.
 */

public interface ExternalDataSourceOperation {

    List<Map<String, Object>> query(DataSource.QueryContext context);

}