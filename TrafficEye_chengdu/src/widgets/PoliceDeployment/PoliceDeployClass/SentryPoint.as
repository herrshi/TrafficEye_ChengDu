package widgets.PoliceDeployment.PoliceDeployClass
{
	import com.esri.ags.geometry.MapPoint;

	public class SentryPoint
	{
		public var sentryId:String;
		public var sentryName:String;
		public var point:MapPoint;
		public var policeList:Vector.<Police> = new Vector.<Police>;
		public var assistantList:Vector.<Assistant> = new Vector.<Assistant>;
		
		public function toString():String {
			return "岗点名称：" + sentryName + " 岗点编号：" + sentryId + " 岗点位置：(" + point.x + "," + point.y + ")"; 
		}
	}
}