package widgets.PoliceManageNew
{
	public class Police
	{
		//警员类型, police--警员，assistant--协警，leader--领导
		private var _policeType:String;
		
		public function get policeType():String
		{
			return _policeType;
		}

		public function set policeType(value:String):void
		{
			_policeType = value;
		}

		//警员职务
		private var _policeDuty:String;

		public function get policeDuty():String
		{
			return _policeDuty;
		}

		public function set policeDuty(value:String):void
		{
			_policeDuty = value;
		}

		
		private var _policeCode:String;

		public function get policeCode():String
		{			
			return _policeCode ? _policeCode : "";
		}

		public function set policeCode(value:String):void
		{
			_policeCode = value;
		}

		private var _policeName:String;

		public function get policeName():String
		{
			return _policeName ? _policeName : "";
		}

		public function set policeName(value:String):void
		{
			_policeName = value;
		}

		private var _policeGpsCode:String;

		public function get policeGpsCode():String
		{
			return _policeGpsCode ? _policeGpsCode : "";
		}

		public function set policeGpsCode(value:String):void
		{
			_policeGpsCode = value;
		}

		
		private var _teamCode:String;

		public function get teamCode():String
		{
			return _teamCode ? _teamCode : "";
		}

		public function set teamCode(value:String):void
		{
			_teamCode = value;
		}

		private var _teamName:String;

		public function get teamName():String
		{
			return _teamName ? _teamName : "";
		}

		public function set teamName(value:String):void
		{
			_teamName = value;
		}

		private var _teamGpsCode:String;

		public function get teamGpsCode():String
		{
			return _teamGpsCode ? _teamGpsCode : "";
		}

		public function set teamGpsCode(value:String):void
		{
			_teamGpsCode = value;
		}

		
		private var _deptCode:String;

		public function get deptCode():String
		{
			return _deptCode ? _deptCode : "";
		}

		public function set deptCode(value:String):void
		{
			_deptCode = value;
		}

		private var _deptName:String;

		public function get deptName():String
		{
			return _deptName ? _deptName : "";
		}

		public function set deptName(value:String):void
		{
			_deptName = value;
		}

		private var _deptGpsCode:String;

		public function get deptGpsCode():String
		{
			return _deptGpsCode ? _deptGpsCode : "";
		}

		public function set deptGpsCode(value:String):void
		{
			_deptGpsCode = value;
		}

		
		public var Longitude:Number;		
		public var Latitude:Number;
		public var elevation:Number;
		public var x:Number;
		public var y:Number;
		public var status:String;
		public var timeStr:String;
		//由树状列表控制的visible
		public var treeVisible:Boolean;
		//由legend控制的visible
		public var legendVisible:Boolean;
		//所属岗点
		public var postName:String;
		//时间段
		public var timePeriod:String;
		
		public function Police()
		{
			policeCode = "";
			policeName = "";
			policeGpsCode = "";
			
			teamCode = "";
			teamName = "";
			teamGpsCode = "";
			
			deptCode = "";
			deptName = "";
			deptGpsCode = "";
			
			treeVisible = true;
			legendVisible = true;
		}
	}
}