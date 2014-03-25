package widgets.PoliceDeployment.PoliceDeployClass
{
	public class Shift
	{
		public var shiftName:String;
		public var shiftId:String;
		public var detachmentId:String;
		
		public function toString():String {
			return "排班名称：" + shiftName + " 排班编号：" + shiftId + " 所属中队：" + detachmentId;
		}
	}
}