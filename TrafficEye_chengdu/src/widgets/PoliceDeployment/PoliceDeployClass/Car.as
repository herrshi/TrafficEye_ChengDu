package widgets.PoliceDeployment.PoliceDeployClass
{
	public class Car
	{
		public var carLicense:String;
		public var shiftId:String;
		
		public function toString():String {
			return "车牌号码：" + carLicense + " 所属排班：" + shiftId;
		}
	}
}