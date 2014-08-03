package widgets.PoliceDeployment.PoliceDeployClass
{
	public class Assistant
	{
		public var name:String;
		public var policeNum:String;
		public var callNum:String;
		public var virtualNum:String;
		public var homeNum:String;
		public var carLicense:String;
		public var shiftId:String;
		public var duty:String;
		
		public function toString():String {
			return "警员姓名：" + name + " 警号：" + policeNum + " 呼号：" + callNum + " 虚拟号：" + virtualNum +
				" 宅电：" + homeNum + " 车辆：" + carLicense + " 排班：" + shiftId +
				" 职务：" + duty;
		}
	}
}