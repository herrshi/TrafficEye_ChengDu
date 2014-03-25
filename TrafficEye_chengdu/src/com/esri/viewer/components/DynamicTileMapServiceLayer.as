package com.esri.viewer.components
{
	import com.esri.ags.SpatialReference;
	import com.esri.ags.geometry.Extent;
	import com.esri.ags.geometry.MapPoint;
	import com.esri.ags.layers.TiledMapServiceLayer;
	import com.esri.ags.layers.supportClasses.LOD;
	import com.esri.ags.layers.supportClasses.TileInfo;
	
	import flash.globalization.DateTimeStyle;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.setInterval;
	
	import spark.formatters.DateTimeFormatter;
	
	
	public class DynamicTileMapServiceLayer extends TiledMapServiceLayer
	{
		private var dtFormat:DateTimeFormatter = new DateTimeFormatter();
		
		public function DynamicTileMapServiceLayer()
		{
			super();
			dtFormat.dateStyle = DateTimeStyle.SHORT;
			dtFormat.timeStyle = DateTimeStyle.SHORT;
//			buildTileInfo();
//			setLoaded( true );
		}
		
		private var _fullExtent:Extent;
		
		override public function get fullExtent():Extent {
			return _fullExtent;
		}
		
		public function set fullExtent( value:Extent ):void {
			_fullExtent = value;
		}
		
		private var _initialExtent:Extent;
		
		override public function get initialExtent():Extent {
			return _initialExtent;
		}
		
		public function set initialExtent( value:Extent ):void {
			_initialExtent = value;
		}
		
		override public function get spatialReference():SpatialReference {
			return _tileInfo.spatialReference;
		}
				
		private var _urlList:Array;
		
		public function get urlList():Array {
			return _urlList;
		}
		
		/**
		 * 动态地图服务的url，支持多个url轮询切片
		 * @param value url数组
		 * 
		 */			
		public function set urlList( value:Array ):void {
			_urlList = value;
		}
		
		private var _currentUrlListIndex:uint = 0;
		
		private function getCurrentUrl():String {
			if ( _urlList.length == 1 )
				return _urlList[ 0 ];
			
			var url:String = _urlList[ _currentUrlListIndex ];
			_currentUrlListIndex++;
			if ( _currentUrlListIndex >= _urlList.length )
				_currentUrlListIndex = 0;
			return url;
		}
		
		private var _disableClientCacheProperty:Boolean = true;
		
		public function get disableClientCacheProperty():Boolean {
			return _disableClientCacheProperty;
		}
		
		/**
		 *是否允许客户端缓存图片，default=true 
		 * @param value true: 不允许缓存 false: 允许缓存
		 * 
		 */
		public function set disableClientCacheProperty( value:Boolean ):void {
			_disableClientCacheProperty = value;
		}
		
		private var _tileInfo:TileInfo = new TileInfo();
		
		override public function get tileInfo():TileInfo {
			return _tileInfo;
		}
		
		public function set tileInfo( value:TileInfo ):void {
			_tileInfo = value;
			setLoaded( true );
		}
		
		override protected function getTileURL(level:Number, row:Number, col:Number):URLRequest {
			var resolution:Number = _tileInfo.lods[level].resolution;
			
			var xmin:Number = _tileInfo.origin.x + resolution * _tileInfo.width * col;
			var ymin:Number = _tileInfo.origin.y - resolution * _tileInfo.height * ( row + 1 );
			var xmax:Number = _tileInfo.origin.x + resolution * _tileInfo.width * ( col + 1 );
			var ymax:Number = _tileInfo.origin.y - resolution * _tileInfo.height * row;
			
			var currentUrl:String = getCurrentUrl();
			currentUrl +=	"/export?" +
				"bbox=" + xmin + "%2C" + ymin + "%2C" + xmax + "%2C" + ymax + 
				"&size=" + _tileInfo.height + "%2C" + _tileInfo.width +
				"&format=png&transparent=true&f=image";
			if ( _disableClientCacheProperty )
				currentUrl += "&_ts=" + dtFormat.format( new Date() );
			trace( currentUrl );
			return new URLRequest( currentUrl );
		}
	}
}