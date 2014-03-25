package com.esri.viewer.components.treePolicePDA.treePolicePDAClasses
{
	import com.esri.viewer.AppEvent;
	import com.esri.viewer.ViewerContainer;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.events.PropertyChangeEvent;
	
	public class TreePolicePDAItem extends EventDispatcher
	{
		public function TreePolicePDAItem( parentItem:TreePolicePDAItem = null ) {
			_parent = parentItem;
		}
		
		//--------------------------------------------------------------------------
		//  Property:  parent
		//--------------------------------------------------------------------------
		
		private var _parent:TreePolicePDAItem;
		
		public function get parent():TreePolicePDAItem {
			return _parent;
		}
		
		//--------------------------------------------------------------------------
		//  Property:  children
		//--------------------------------------------------------------------------
		
		[Bindable] public var children:ArrayCollection; // of TocItem
		
		/**
		 * Adds a child TOC item to this item.
		 */
		internal function addChild(item:TreePolicePDAItem):void {
			if (!children) {
				children = new ArrayCollection();
			}
			children.addItem(item);
		}
		
		//--------------------------------------------------------------------------
		//  Property:  label
		//--------------------------------------------------------------------------
		
		internal static const DEFAULT_LABEL:String = "(Unknown)";
		
		private var _label:String = DEFAULT_LABEL;
		
		[Bindable("propertyChange")]
		/**
		 * The text label for the item renderer.
		 */
		public function get label():String {
			return _label;
		}
		
		/**
		 * @private
		 */
		public function set label(value:String):void {
			var oldValue:Object = _label;
			_label = (value ? value : DEFAULT_LABEL);
			
			// Dispatch a property change event to notify the item renderer
			dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "label", oldValue, _label));
		}
		
		//--------------------------------------------------------------------------
		//  Property:  visible
		//--------------------------------------------------------------------------
		
		internal static const DEFAULT_VISIBLE:Boolean = true;
		
		private var _visible:Boolean = DEFAULT_VISIBLE;
		
		[Bindable("propertyChange")]
		/**
		 * Whether the map layer referred to by this TOC item is visible or not.
		 */
		public function get visible():Boolean
		{
			return _visible;
		}
		
		/**
		 * @private
		 */
		public function set visible(value:Boolean):void
		{
			setVisible(value);
		}
		
		/**
		 * Allows subclasses to change the visible state without causing a layer refresh.
		 */
		internal function setVisible(value:Boolean):void
		{
			if (value != _visible || _indeterminate )
			{
				var oldValue:Object = _visible;
				_visible = value;
				
				for each ( var child:TreePolicePDAItem in children ) {
					if ( child.visible != value || child.indeterminate )
						child.visible = value;
				}
				updateIndeterminateState();
				
				// Dispatch a property change event to notify the item renderer
				dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "visible", oldValue, value));
				//通知地图处理状态改变
				if ( this is TreePolicePDAPersonItem ) {
					var data:Object = {
						item: ( this as TreePolicePDAPersonItem ).person.policeCode,
							visible: value
					}
					AppEvent.dispatch( AppEvent.POLICETREE_PDA_PERSON_CHECKBOX_CLICKED, data );
				}
				if ( this is TreePolicePDATeamItem ) {
					AppEvent.dispatch( AppEvent.POLICETREE_PDA_TEAM_CHECKBOX_CLICKED, 
						{ id: ( this as TreePolicePDATeamItem ).team.teamCode,
							visible: value } );
				}
				//					AppEvent.dispatch( new AppEvent( AppEvent.POLICETREE_CHECKBOX_CLICKED, { item:this, visible: value } ) );
			}
		}
		
		//--------------------------------------------------------------------------
		//  Property:  indeterminate
		//--------------------------------------------------------------------------
		
		internal static const DEFAULT_INDETERMINATE:Boolean = false;
		
		private var _indeterminate:Boolean = DEFAULT_INDETERMINATE;
		
		[Bindable("propertyChange")]
		/**
		 * Whether the visibility of this TOC item is in a mixed state,
		 * based on child item visibility or other criteria.
		 */
		public function get indeterminate():Boolean
		{
			return _indeterminate;
		}
		
		/**
		 * @private
		 */
		public function set indeterminate(value:Boolean):void
		{
			if (value != _indeterminate)
			{
				var oldValue:Object = _indeterminate;
				_indeterminate = value;
				
				// Dispatch a property change event to notify the item renderer
				dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "indeterminate", oldValue, value));				
			}
		}
		
		/**
		 * Whether this TOC item is at the root level.
		 */
		public function isTopLevel():Boolean
		{
			return _parent == null;
		}
		
		/**
		 * Whether this TOC item contains any child items.
		 */
		public function isGroupLayer():Boolean
		{
			return children && children.length > 0;
		}
		
		/**
		 * Updates the indeterminate visibility state of this TOC item.
		 */
		internal function updateIndeterminateState(calledFromChild:Boolean = false):void
		{
			// Inspect the visibility of the children
			var vis:Boolean = false;
			var invis:Boolean = false;
			for each (var item:TreePolicePDAItem in children)
			{
				if (item.indeterminate)
				{
					vis = invis = true;
					break;
				}
				else if (item.visible)
				{
					vis = true;
				}
				else
				{
					invis = true;
				}
			}
			indeterminate = (vis && invis);
			
			if (calledFromChild)
			{
				if (vis && !invis)
				{
					setVisible(true);
				}
				else if (!vis && invis)
				{
					setVisible(false);
				}
			}
			
			// Recurse up the tree
			if (parent)
			{
				parent.updateIndeterminateState(true);
			}
		}
	}
}