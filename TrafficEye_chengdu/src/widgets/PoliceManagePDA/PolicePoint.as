package widgets.PoliceManagePDA
{
	import com.esri.ags.geometry.Geometry;
	import com.esri.ags.geometry.MapPoint;
	import com.esri.ags.symbols.Symbol;

	public class PolicePoint
	{
		public var title:String;
		
		public var id:String;
		
		public var symbol:Symbol;
		
		public var content:String;
		
		public var point:MapPoint;
		
		public var link:String;
		
		public var geometry:Geometry;
		
		public var buttons:Array;
		
		public var policeInfo:Police;
		
		public function PolicePoint()
		{
		}
	}
}