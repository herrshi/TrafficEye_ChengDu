package widgets.ReservePlan
{
	public class DeviceGroup
	{
		
		public var deviceType:String;
		public var deviceTypeId:String;
		public var deviceTypevisiable:Boolean;
		
		public var deviceList:Vector.<DeviceInfo>;		
		public function DeviceGroup()
		{
			deviceList = new Vector.<DeviceInfo>;
			deviceTypevisiable = true;
		}
	}
}