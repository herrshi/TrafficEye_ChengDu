package widgets.TracePlayback
{
	import com.esri.ags.symbols.PictureMarkerSymbol;
	import com.esri.ags.symbols.SimpleFillSymbol;
	import com.esri.ags.symbols.SimpleLineSymbol;

	public class TraceResultSymbol
	{
		
		
		public var type:String;
		public var typeAlias:String;
		public var count:uint = 0;
		public var visible:Boolean = true;
		public var resultMarkerSymboldev:PictureMarkerSymbol;
		public var resultMarkerSymbolinfo:PictureMarkerSymbol;

		public var resultLineSymbol:SimpleLineSymbol;
		public var resultFillSymbol:SimpleFillSymbol;
		
		
		public function TraceResultSymbol()
		{
		}
	}
}