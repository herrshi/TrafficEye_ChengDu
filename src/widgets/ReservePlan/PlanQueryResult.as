package widgets.ReservePlan
{
	import com.esri.ags.geometry.Geometry;
	import com.esri.ags.geometry.MapPoint;
	import com.esri.ags.symbols.Symbol;
	
	import flash.events.EventDispatcher;

	public class PlanQueryResult extends EventDispatcher
	{
		public var title:String;
		
		public var name:String;
		
		public var symbol:Symbol;
		
		public var content:String;
		
		public var point:MapPoint;
		
		public var link:String;
		
		public var geometry:Geometry;
		
		public var buttons:Array;
		
		public var companyId:String;
		
		public var id:String;
		
		public var type:String;
		
		public var status:String;
		
		public var plusInfo:String;
	}
}