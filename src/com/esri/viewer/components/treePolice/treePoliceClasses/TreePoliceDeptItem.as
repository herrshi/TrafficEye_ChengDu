package com.esri.viewer.components.treePolice.treePoliceClasses
{
	import widgets.PoliceManageNew.PoliceDept;
	import widgets.PoliceManageNew.PoliceTeam;

	public class TreePoliceDeptItem extends TreePoliceItem
	{
		public function TreePoliceDeptItem( dept:PoliceDept ) {
			_dept = dept;
			
			createChildren();
			statisticPoliceStatus();
			label = labelFunction();
		}
		
		private var _dept:PoliceDept;

		public function get dept():PoliceDept {
			return _dept;
		}
		
		private function labelFunction(): String {
			var label:String = _dept.deptName + " (" + policeCount.toString() + "人)";
//			var label:String = _dept.deptName + " 共" + policeCount.toString() + "人";
//			for each ( var obj:Object in _statusObjects ) {
//				label += ", " + obj.status + ":" + obj.count + "人";
//			}
			return label;
		}
		
		public function get policeCount():uint
		{
			var count:uint = 0;
			for each ( var team:PoliceTeam in _dept.teamList ) {
				count += team.policeList.length;
			}
			
			return count;
		}
		
		private function createChildren():void {
			for each ( var team:PoliceTeam in _dept.teamList ) {
				var teamItem:TreePoliceTeamItem = new TreePoliceTeamItem( team, this );
				teamItem.visible = team.teamVisible;
				addChild( teamItem );
			}
		}
		
		private var _statusObjects:Array = [];
		
		private function statisticPoliceStatus():void {
			for each ( var teamItem:TreePoliceTeamItem in children ) {
				var teamStatistic:Array = teamItem.statusObjects;
				for each ( var teamStatisticObj:Object in teamStatistic ) {
					var status:String = teamStatisticObj.status;
					var count:Number = teamStatisticObj.count;
					var deptStatisticObj:Object = getStatusObject( status );
					deptStatisticObj.count += count;
				}
			}
			
			_statusObjects.sortOn( "status" );
		}
		
		private function getStatusObject( status:String ):Object {
			var obj:Object;
			for each ( obj in _statusObjects ) {
				if ( obj.status == status )
					return obj;
			}
			
			obj = {
				status: status,
				count: 0
			}
			_statusObjects.push( obj );
			return obj;
		}

	}
}