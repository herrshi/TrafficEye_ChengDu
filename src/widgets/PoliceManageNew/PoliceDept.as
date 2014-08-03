package widgets.PoliceManageNew
{
	public class PoliceDept
	{
		public var deptCode:String;
		public var deptName:String;
		public var deptGpsCode:String;
		
		public var teamList:Vector.<PoliceTeam>;
		
		public function PoliceDept()
		{
			teamList = new Vector.<PoliceTeam>;
		}
	}
}