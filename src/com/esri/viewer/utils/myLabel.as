package com.esri.viewer.utils
{
	import mx.controls.Label;
	public class myLabel extends Label
	{
		public function myLabel()
		{
			super();
			//Label的字体大小
			this.setStyle("fontSize",12);
			var type:String;
			//字体颜色
			this.setStyle("color","#0000ff");
			this.width=135;
			this.height=20;
		}
	}

}