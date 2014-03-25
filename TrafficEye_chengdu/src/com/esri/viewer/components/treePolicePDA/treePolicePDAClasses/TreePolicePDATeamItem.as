package com.esri.viewer.components.treePolicePDA.treePolicePDAClasses
{
	import widgets.PoliceManagePDA.Police;
	import widgets.PoliceManagePDA.PoliceTeam;
	import com.esri.viewer.components.treePolicePDA.treePolicePDAClasses.TreePolicePDADeptItem;
	import com.esri.viewer.components.treePolicePDA.treePolicePDAClasses.TreePolicePDAItem;
	import com.esri.viewer.components.treePolicePDA.treePolicePDAClasses.TreePolicePDAPersonItem;

	public class TreePolicePDATeamItem extends TreePolicePDAItem
	{
		public function TreePolicePDATeamItem( team:PoliceTeam, parent:TreePolicePDADeptItem ) {
			super( parent );
			
			_team = team;
			statisticPoliceStatus();
			label = labelFunction();
			
			createChildren();
		}
		
		private var _team:PoliceTeam;

		public function get team():PoliceTeam {
			return _team;
		}

		private function labelFunction():String {
			var label:String = _team.teamName + " (" + policeCount.toString() + "人)";
//			for each ( var obj:Object in _statusObjects ) {
//				label += ", " + obj.status + ":" + obj.count + "人";
//			}
//			return _team.teamName;
			return label;
		}
		
		public function get policeCount():uint
		{
			return  (_team) ?  _team.policeList.length : 0;
		}
		
		private function createChildren():void {
			for each ( var person:Police in _team.policeList ) {
				var personItem:TreePolicePDAPersonItem = new TreePolicePDAPersonItem( person, this );
				addChild( personItem );
			}
		}
		
		//统计分类数量
		private var _statusObjects:Array = [];

		public function get statusObjects():Array
		{
			return _statusObjects;
		}

		
		private function statisticPoliceStatus():void {
			for each ( var police:Police in _team.policeList ) {
				var status:String = police.status;
				var obj:Object = getStatusObject( status );
				obj.count++;
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