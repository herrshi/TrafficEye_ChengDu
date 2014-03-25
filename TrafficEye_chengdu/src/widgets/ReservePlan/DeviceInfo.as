package widgets.ReservePlan
{
	public class DeviceInfo extends Object
	{
		
		public var planId:String;
		public var id:String;		
		public var desc:String;

		public var title:String;
		
		public var typeName:String;
		public var typeId:String;
		
		//由树状列表控制的visible
		public var selected:Boolean;
		//由legend控制的visible
		//所属岗点
		public var postName:String;
		public var postId:String;
		
		public var location:String;
		
		
		public var longitude:Number;		
		public var latitude:Number;
		
		public var channelId:String;
		
		
		
		public function DeviceInfo()
		{
			desc="";
			id="";
			typeName="";
			typeId="";
			title ="";
			selected=true;
			postName="";
			channelId="";
			
		}
	}
}