package com.esri.viewer.components.treePolice
{
	import com.esri.viewer.components.treePolice.treePoliceClasses.TreePoliceDeptItem;
	import com.esri.viewer.components.treePolice.treePoliceClasses.TreePoliceItemRenderer;
	import com.esri.viewer.components.treePolice.treePoliceClasses.TreePolicePersonItem;
	import com.esri.viewer.components.treePolice.treePoliceClasses.TreePoliceTeamItem;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Tree;
	import mx.core.ClassFactory;
	import mx.events.ListEvent;
	
	import widgets.PoliceManageNew.Police;
	import widgets.PoliceManageNew.PoliceDept;
	
	public class TreePolice extends Tree
	{
		public function TreePolice() {
			super();
			dataProvider = _root;
			itemRenderer = new ClassFactory( TreePoliceItemRenderer );
			iconFunction = itemIconFunction;
			
			doubleClickEnabled = true;
			addEventListener(ListEvent.ITEM_DOUBLE_CLICK, onItemDoubleClick);
			// Set default styles
			setStyle("borderStyle", "none");
		}
		
		private var _root:ArrayCollection = new ArrayCollection();
		
		public function get rootNode():ArrayCollection {
			return _root;
		}
		
		//--------------------------------------------------------------------------
		//  Property:  deptList
		//  分局、小组、警员列表
		//--------------------------------------------------------------------------
		
		private var _depList:Vector.<PoliceDept>;

		public function get depList():Vector.<PoliceDept> {
			return _depList;
		}

		public function set depList(value:Vector.<PoliceDept>):void {
			_depList = value;
			registerAllDept();
		}
		
		
		private function onItemDoubleClick(event:ListEvent):void {
			if (event.itemRenderer && event.itemRenderer.data)
			{
				var item:Object = event.itemRenderer.data;
				expandItem(item, !isItemOpen(item), true, true, event);
			}
		}
		
		private function registerAllDept():void {
			_root.removeAll();
			for each ( var dept:PoliceDept in _depList ) {
				var deptItem:TreePoliceDeptItem = new TreePoliceDeptItem( dept );
				_root.addItem( deptItem );
			}
		}
		
		[Embed(source='assets/images/i_policestation_s.png')]
		private var deptIcon:Class;		
		[Embed(source='assets/images/i_demographics_s.png')]
		private var teamIcon:Class;
		[Embed(source='assets/images/police.png')]
		private var personIcon:Class;
		
		private function itemIconFunction( item:Object ):Class {
			if ( item is TreePoliceDeptItem ) {
				return deptIcon;
			} 
			else if ( item is TreePoliceTeamItem ) {
				return teamIcon;
			} 
			else {
				return personIcon;
			}
		}
	}
}