package widgets.ReservePlan
{
	import com.esri.ags.symbols.PictureMarkerSymbol;
	import com.esri.ags.symbols.SimpleFillSymbol;
	import com.esri.ags.symbols.SimpleLineSymbol;

	public class PlanRankSymbol
	{
		
			
			public var keyValue:String;
			public var keyValueAlias:String;
			public var count:uint = 0;
			public var visible:Boolean = true;
			public var resultMarkerSymbol:PictureMarkerSymbol;
			public var resultLineSymbol:SimpleLineSymbol;
			public var resultFillSymbol:SimpleFillSymbol;
	}
}