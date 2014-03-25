package widgets.EventManager
{
	public class LocationResult
	{
		public var taskSourceTypeId:String;
		public var taskSourceId:String;
		public var eventId:String;
		public var userId:String;
		
		public var actionParameterXml:XML = new XML();
		public var businessFormXml:XML = new XML("<BusinessForm><PositionTime></PositionTime><PositionDeptId></PositionDeptId><PositionUserId></PositionUserId><Longitude></Longitude><Latitude></Latitude></BusinessForm>");
		XML.prettyPrinting = false;
		public function LocationResult()
		{
			
		}
	}
}