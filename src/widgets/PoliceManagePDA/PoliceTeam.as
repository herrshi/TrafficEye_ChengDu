package widgets.PoliceManagePDA
{

	public class PoliceTeam
	{
		public var teamCode:String;
		public var teamName:String;
		public var teamGpsCode:String;
		public var teamVisible:Boolean;
		public var policeList:Vector.<Police>;
		
		public function PoliceTeam()
		{
			policeList  = new Vector.<Police>;
			teamVisible = true;
		}
	}
}