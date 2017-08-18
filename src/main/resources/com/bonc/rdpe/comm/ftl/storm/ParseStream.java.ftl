
import org.apache.storm.trident.Stream;
import org.apache.storm.trident.operation.BaseFunction;
import org.apache.storm.trident.operation.TridentCollector;
import org.apache.storm.trident.tuple.TridentTuple;
import org.apache.storm.tuple.Fields;
import org.apache.storm.tuple.Values;

public class ${objectName} {  

	public static Stream exec(Stream stream) {
		Stream stream1 = stream.each(new Fields(${inputFields}), new Parse(),new Fields(${outPutFields}));
		return stream1;
	}

	public static class Parse extends BaseFunction {
		private static final long serialVersionUID = 1L;

		public void execute(TridentTuple tuple, TridentCollector collector) {
			String[] colvalues = tuple.getString(0).split("${separator}");
			int[] index = new int[]{${index}};//页面传过来的下标int 类型
			List<String> list = new ArrayList<String>();
			for (int i : index) {
				list.add(colvalues[i]);
			}
			collector.emit(new Values(arrRet));
		}
	}
}