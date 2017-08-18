import org.apache.storm.trident.Stream;
import org.apache.storm.trident.operation.BaseFilter;
import org.apache.storm.trident.tuple.TridentTuple;
import org.apache.storm.tuple.Fields;

public class ${objectName}{
	public static Stream exec(Stream stream){
		Stream stream1 = stream.each(new Fields(${inputFields}), new MyFilter()).parallelismHint(${parallelismHint});
		return stream1;
	}
	
	public static class MyFilter extends BaseFilter {
		private static final long serialVersionUID = 1L;
		
		@Override
		public boolean isKeep(TridentTuple tuple) {
			return ${rule};
		}
	}
}


