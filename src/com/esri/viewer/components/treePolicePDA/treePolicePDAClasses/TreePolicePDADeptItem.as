package com.esri.viewer.components.treePolicePDA.treePolicePDAClasses
{
	import com.esri.viewer.components.treePolicePDA.treePolicePDAClasses.TreePolicePDAItem;
	
	import widgets.PoliceManagePDA.PoliceDept;
	import widgets.PoliceManagePDA.PoliceTeam;

	public class TreePolicePDADeptItem extends TreePolicePDAItem
	{
		public function TreePolicePDADeptItem( dept:PoliceDept ) {
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
//			for each ( var obj:Object in _statusObjects ) {
//				label += ", " + obj.status + ":" + obj.count + "人";
//			}
//			return _dept.deptName;
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
				var teamItem:TreePolicePDATeamItem = new TreePolicePDATeamItem( team, this );
				teamItem.visible = team.teamVisible;
				addChild( teamItem );
			}
		}
		
		private var _statusObjects:Array = [];
		
		private function statisticPoliceStatus():void {
			for each ( var teamItem:TreePolicePDATeamItem in children ) {
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