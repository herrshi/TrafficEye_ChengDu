package widgets.PoliceDeployment.PoliceDeployClass
{
	public class Detachment 
	{
		public var detachmentName:String;
		public var detachmentId:String;
		
		public function toString():String {
			return "中队名称：" + detachmentName + " 中队编号：" + detachmentId;
		}
	}
	
	
}