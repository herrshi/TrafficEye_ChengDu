package widgets.PoliceManageNew
{
	import mx.core.ClassFactory;
	
	import spark.components.DataGroup;
	
	[Event(name="queryResultClick", type="flash.events.Event")]
	[Event(name="queryResultMouseOver", type="flash.events.Event")]
	[Event(name="queryResultMouseOut", type="flash.events.Event")]
	
	public class PoliceItemDataGroup extends DataGroup
	{
		public function PoliceItemDataGroup()
		{
			super();
			this.itemRenderer = new ClassFactory( PoliceItemRenderer );
		}
	}
}