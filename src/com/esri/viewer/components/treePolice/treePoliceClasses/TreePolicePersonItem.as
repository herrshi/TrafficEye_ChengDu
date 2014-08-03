package com.esri.viewer.components.treePolice.treePoliceClasses
{
	import flash.events.MouseEvent;
	
	import widgets.PoliceManageNew.Police;

	public class TreePolicePersonItem extends TreePoliceItem
	{
		public function TreePolicePersonItem( person:Police, parent:TreePoliceTeamItem ) {
			super( parent );
			
			_person = person;
			label = labelFunction();
		}
		
		private var _person:Police;

		public function get person():Police {
			return _person;
		}
		
		private function labelFunction():String {
			var label:String = _person.policeName;
			
			switch ( _person.policeType ) {
				case "deptLeader":
					label +=	"(" + _person.policeDuty + ")";
					break;
				case "groupLeader":
					label +=	"(" + _person.policeDuty + ")";
					break;
				case "police":
					label += "(警员)";
					break;
				case "assistant":
					label += "(协警)";
					break;
				default:
					label += _person.policeType;
			}
			return label;
		}

	}
}