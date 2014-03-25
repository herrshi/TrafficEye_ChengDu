package test_class
{
	
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Point;
	
	import mx.containers.Canvas;
	/**
	 * 划线工具类
	 * author:songyuanfu
	 * */
	public class LineDescriptor extends Shape {   
		
		private var _start:Point = new Point(0, 0);   
		private var _startX:Number;   
		private var _startY:Number;   
		
		private var _end:Point = new Point(0, 0);   
		private var _endX:Number;   
		private var _endY:Number;   
		
		private var _hasArrowHead:Boolean=false;   
		
		private var _thinkness:Number = 1;   
		private var _color:uint = 0x6E6E6E;   
		private var _alpha:Number = 1;   
		private var _pixelHinting:Boolean = false;   
		private var _scaleMode:String = "normal";
		private var _arrow_param:Number;   
		
		/**
		 *  初始化 
		 * @param startPoint
		 * @param endPoint
		 * @param hasArrow
		 * @param lineColor
		 * @param arrow_param
		 * 
		 */                                
		public function LineDescriptor(startPoint:Point=null, endPoint:Point=null,hasArrow:Boolean=false,lineColor:uint=0xffffff,arrow_param:Number=1)
		{   
			this._color=lineColor;
			start = startPoint;   
			end = endPoint;   
			hasArrowHead = hasArrow;
			_arrow_param=arrow_param;
		} 
		/**
		 *	画线 
		 * @param canvas
		 * 
		 */                           
		public function draw(canvas:Canvas):void
		{   
			with(canvas.graphics)
			{   
				lineStyle(_thinkness, _color, _alpha, _pixelHinting, _scaleMode);   
				moveTo(start.x, start.y);  
				curveTo((start.x+end.x)/2+20,(start.y+end.y)/2+20,end.x,end.y); 
				//lineTo(end.x, end.y);      
			}   
			
			if(hasArrowHead)
			{   
				drawArrowHead(canvas);   
			}   
		}   
		/**  
		 * 画箭头   
		 **/  
		private function drawArrowHead(canvas:Canvas):void
		{
			//设置让箭头在其3/4处显示
			if(start.x>end.x)
			{
				end.x=start.x/4+3*end.x/4;
				end.y=start.y/4+3*end.y/4;
			}
			else
			{
				end.x=3*end.x/4+start.x/4;
				end.y=start.y/4+3*end.y/4;
			}
			
			var startX:Number = start.x;   
			var startY:Number = start.y;   
			var endX:Number = end.x;   
			var endY:Number = end.y;   
			
			var arrowLength : Number = 10*_arrow_param;   
			var arrowAngle : Number = Math.PI / 6;   
			var lineAngle : Number;   
			if(endX - startX != 0)                             
				lineAngle = Math.atan((endY - startY) / (endX - startX));   
			else{   
				if(endY - startY < 0)   
					lineAngle = Math.PI / 2;   
				else  
					lineAngle = 3 * Math.PI / 2;   
			}                                  
			if(endY - startY >= 0 && endX - startX <= 0){   
				lineAngle = lineAngle + Math.PI;   
			}else if(endY - startY <= 0 && endX - startX <= 0){   
				lineAngle = lineAngle + Math.PI;   
			}   
			//定义三角形   
			var angleC : Number = arrowAngle;   
			var rimA : Number = arrowLength;   
			var rimB : Number = Math.pow(Math.pow(endY - startY,2) + Math.pow(endX - startX,2),1/2);   
			var rimC : Number = Math.pow(Math.pow(rimA,2) + Math.pow(rimB,2) - 2 * rimA * rimB * Math.cos(angleC),1/2);   
			var angleA : Number = Math.acos((rimB - rimA * Math.cos(angleC)) / rimC);   
			
			var leftArrowAngle : Number = lineAngle + angleA;   
			var rightArrowAngle : Number = lineAngle - angleA;                         
			var leftArrowX : Number = startX + rimC * Math.cos(leftArrowAngle);   
			var leftArrowY : Number = startY + rimC * Math.sin(leftArrowAngle);                        
			var rightArrowX : Number = startX + rimC * Math.cos(rightArrowAngle);   
			var rightArrowY : Number = startY + rimC * Math.sin(rightArrowAngle);   
			
			
			with(canvas.graphics){   
				moveTo(end.x, end.y);   
				lineTo(leftArrowX, leftArrowY);   
				moveTo(end.x, end.y);   
				lineTo(rightArrowX, rightArrowY);   
			}   
		}   
		
		/**  
		 * 是否有箭头  
		 **/  
		public function get hasArrowHead():Boolean
		{   
			return _hasArrowHead;   
		}   
		public function set hasArrowHead(value:Boolean):void
		{   
			_hasArrowHead = value;   
		}   
		
		/**  
		 * 线的起点  
		 **/  
		public function get start():Point
		{   
			return _start;   
		}   
		public function set start(value:Point):void
		{   
			if(value)
			{   
				_start = value;   
			}   
		}   
		
		public function get startX():Number
		{   
			return _start.x;   
		}   
		public function set startX(value:Number):void
		{   
			_start.x = value;   
		}   
		
		public function get startY():Number
		{   
			return _start.y;   
		}   
		public function set startY(value:Number):void
		{   
			_start.y = value;   
		}   
		
		/**  
		 * 线的终点  
		 **/  
		public function get end():Point
		{   
			return _end;   
		}   
		public function set end(value:Point):void
		{   
			if(value)
			{   
				_end = value;   
			}   
		}   
		
		public function get endX():Number
		{   
			return end.x;   
		}   
		public function set endX(value:Number):void
		{   
			_end.x = value;   
		}   
		
		public function get endY():Number
		{   
			return end.y;   
		}   
		public function set endY(value:Number):void
		{   
			_end.y = value;   
		}   
		
	}   
}
	
	
	
	public class draw_line
	{
		public function draw_line()
		{
		}
	}
}