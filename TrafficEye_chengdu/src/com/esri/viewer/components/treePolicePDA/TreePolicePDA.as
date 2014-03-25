package com.esri.viewer.components.treePolicePDA
{
	import com.esri.viewer.components.treePolicePDA.treePolicePDAClasses.TreePolicePDADeptItem;
	import com.esri.viewer.components.treePolicePDA.treePolicePDAClasses.TreePolicePDAItemRenderer;
	import com.esri.viewer.components.treePolicePDA.treePolicePDAClasses.TreePolicePDAPersonItem;
	import com.esri.viewer.components.treePolicePDA.treePolicePDAClasses.TreePolicePDATeamItem;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Tree;
	import mx.core.ClassFactory;
	import mx.events.ListEvent;
	
	import widgets.PoliceManagePDA.Police;
	import widgets.PoliceManagePDA.PoliceDept;
	
	public class TreePolicePDA extends Tree
	{
		public function TreePolicePDA() {
			super();
			dataProvider = _root;
			itemRenderer = new ClassFactory( TreePolicePDAItemRenderer );
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
				var deptItem:TreePolicePDADeptItem = new TreePolicePDADeptItem( dept );
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
			if ( item is TreePolicePDADeptItem ) {
				return deptIcon;
			} 
			else if ( item is TreePolicePDATeamItem ) {
				return teamIcon;
			} 
			else {
				return personIcon;
			}
		}
	}
}