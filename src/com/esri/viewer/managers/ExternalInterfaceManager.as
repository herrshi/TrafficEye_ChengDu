//管理与外部jsp交互的ExternalInterface，包括调用外部jsp函数和外部调用flex函数

package com.esri.viewer.managers
{
	
	import com.esri.viewer.AppEvent;
	import com.esri.viewer.ViewerContainer;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	
	public class ExternalInterfaceManager extends EventDispatcher
	{
		
		public function ExternalInterfaceManager() {
			super();
			AppEvent.addListener( ViewerContainer.CONTAINER_INITIALIZED, init );
		}
		
		private function init( event:Event ):void {
			ExternalInterface.addCallback( "findDevice", findDevice );
			ExternalInterface.addCallback( "hideDevice", hideDevice );
			ExternalInterface.addCallback( "construnctionPointRefreshed", refreshConstructoinPoint );
			ExternalInterface.addCallback( "controlRouteRefreshed", refreshControlRoute );
			ExternalInterface.addCallback( "refreshPoliceInfo", refreshPoliceInfo );
			ExternalInterface.addCallback( "addPoints", addPoints );
			ExternalInterface.addCallback( "deletePoints", deletePoints );
			ExternalInterface.addCallback( "deleteAllPoints", deleteAllPoints );
			ExternalInterface.addCallback( "setMapCenter", setMapCenter );
			ExternalInterface.addCallback( "setMapExtent", setMapExtent );
			//ExternalInterface.addCallback( "RemoveOverlay", RemoveOverlay );
			//ExternalInterface.addCallback( "AddOverlay", AddOverlay );
			
			ExternalInterface.addCallback("addDevice",addDevice );
			ExternalInterface.addCallback("cpTrail", cpTrail );
			ExternalInterface.addCallback("cpTrail_Pause", cpTrail_Pause);
			ExternalInterface.addCallback("MapRefresh",mapRefresh );
			
			ExternalInterface.addCallback("setPlanInfo",setPlanInfo);
			
			ExternalInterface.addCallback( "addPoints", dispatchAddPointsEvent );
			ExternalInterface.addCallback( "deleteAllPoints", dispatchDeleteAllPointsEvent );
			ExternalInterface.addCallback( "deletePoints", dispatchDeletePointsEvent );
			
			ExternalInterface.addCallback( "addLines", dispatchAddLinesEvent );
			ExternalInterface.addCallback( "deleteAllLines", dispatchDeleteAllLinesEvent );
			ExternalInterface.addCallback( "deleteLines", dispatchDeleteLines );
			
			ExternalInterface.addCallback( "addBuffers", dispatchAddBuffersEvent );
			ExternalInterface.addCallback( "deleteBuffers", dispatchDeleteBuffersEvent );
			ExternalInterface.addCallback( "deleteAllBuffers", dispatchDeleteAllBuffersEvent );
			
			ExternalInterface.addCallback( "startEditGeometry", dispatchStartEditEvent );
			ExternalInterface.addCallback( "startAdd", dispatchStartAddEvent );
			
			//打开组件
			ExternalInterface.addCallback( "openWidget", dispatchOpenWidgetEvent );
			ExternalInterface.addCallback( "closeWidget", dispatchCloseWidgetEvent );
			//打开图层
			ExternalInterface.addCallback( "openLayer",dispatchOpenLayerEvent );
			ExternalInterface.addCallback( "closeLayer",dispatchCLoseLayerEvent);
			
			
			
			ExternalInterface.addCallback( "setSearchText", dispatchSetSearchTextEvent );

			AppEvent.addListener( AppEvent.OPEN_DEVICE, openDevice );
			AppEvent.addListener( AppEvent.REPORT_DEVICE, reportDevice );
			AppEvent.addListener( AppEvent.EXTERNAL_CALL, externalCall );
			AppEvent.addListener( AppEvent.DEVICE_ISSUE, deviceIssue );
			AppEvent.addListener( AppEvent.PLAN_DATA_READY, dataReady );
			AppEvent.addListener( AppEvent.GET_PLAN_ID, getPlanId );
			AppEvent.addListener( AppEvent.SEND_RESERVEPLAN_DATA_NEW, sendPlanInfo);
		}
		
		private function dispatchSetSearchTextEvent( param:String ):void
		{
			AppEvent.dispatch( AppEvent.SET_SEARCH_TEXT, param );
		}
		
		
		//需在layercontrolWidget中间配置
		private function dispatchOpenLayerEvent( param:String ):void
		{
			var visible:Boolean = true;
			AppEvent.dispatch( AppEvent.CHANGE_WIDGET_ACTIVITY, { name: param, visible: visible } );
		}
		
		//需在layercontrolWidget中间配置
		private function dispatchCLoseLayerEvent( param:String ):void
		{
			var visible:Boolean = false;
			AppEvent.dispatch( AppEvent.CHANGE_WIDGET_ACTIVITY, { name: param, visible: visible } );
		}
		
		
		private function dispatchOpenWidgetEvent( param:String ):void
		{
			AppEvent.dispatch( AppEvent.WIDGET_RUN, param );
		}
		
		private function dispatchCloseWidgetEvent( param:String ):void
		{
			AppEvent.dispatch( AppEvent.WIDGET_CLOSE, param );
		}
		
		private function dispatchAddBuffersEvent( param:String ):void
		{
			AppEvent.dispatch( AppEvent.ADD_BUFFERS, param );
		}
		
		private function dispatchDeleteBuffersEvent( param:String ):void
		{
			AppEvent.dispatch( AppEvent.DELETE_BUFFERS, param );
		}
		
		private function dispatchDeleteAllBuffersEvent( param:String ):void
		{
			AppEvent.dispatch( AppEvent.DELETE_ALL_BUFFERS, param );
		}
		
		private function dispatchStartAddEvent( param:String ):void
		{
			AppEvent.dispatch( AppEvent.START_ADD_OVERLAY, param );
		}
		
		private function dispatchStartEditEvent( param:String ):void
		{
			AppEvent.dispatch( AppEvent.START_MOVE_OVERLAY, param );
		}
		
		private function dispatchAddPointsEvent( param:String ):void
		{
			AppEvent.dispatch( AppEvent.ADD_POINTS, param );
		}
		
		private function dispatchDeleteAllPointsEvent( param:String ):void
		{
			AppEvent.dispatch( AppEvent.DELETE_ALL_POINTS, param );
		}
		
		private function dispatchDeletePointsEvent( param:String ):void
		{
			AppEvent.dispatch( AppEvent.DELETE_POINTS, param );
		}
		
		private function dispatchAddLinesEvent( param:String ):void
		{
			AppEvent.dispatch( AppEvent.ADD_LINES, param );
		}
		
		private function dispatchDeleteAllLinesEvent( param:String ):void
		{
			AppEvent.dispatch( AppEvent.DELETE_ALL_LINES, param );
		}
		
		private function dispatchDeleteLines( param:String ):void
		{
			AppEvent.dispatch( AppEvent.DELETE_LINES, param );
		}
		
		private function getPlanId(event:AppEvent):void
		{
			// TODO Auto Generated method stub
			var id:String="";
			var type:String=event.data.type ;
			var data:String ="";
			//Alert.show("planCallBack");
			var planid:String = ExternalInterface.call( "planCallBack", type, id, data );
			if (planid!="") 
			{
				AppEvent.dispatch(AppEvent.SET_PLAN_INFO,{planid:planid,type:type,data:data});

			}
		}		
		
		
		private function setPlanInfo(planid:String,type:String,data:String ):void
		{
			/**
			 * type:initplan/adddevice
			 */ 
			AppEvent.dispatch( AppEvent.SET_PLAN_INFO,{planid:planid,type:type,data:data} );
			// TODO Auto Generated method stub
			
		}		
		
		private function sendPlanInfo(event:AppEvent):void{
			var type:String=event.data.type;
			if (type=="removedevice"||type=="adddevice"||type=="removealldevice"||type=="addfbd") 
			{
				var planid:String = event.data.planid;
				var data:String = event.data.data;
				ExternalInterface.call("getPlanInfo",planid,type,data);
			}
		}
		/*private function RemoveOverlay():void{
		    AppEvent
		}
		
	    private function AddOverlay():void{
			
		}
		*/
		
		private function addDevice(str:String):void{
			AppEvent.dispatch( AppEvent.ADD_DEVICE, str );
		}
		
		private function mapRefresh():void
		{
			AppEvent.dispatch( AppEvent.MAPREFRESH);
		}
		
		private function cpTrail(xml:String):void
		{
			
			//Alert.show(xml);
			AppEvent.dispatch( AppEvent.TRACE_PLAYBACK, xml);
		}
		
		private function cpTrail_Pause(pause:Boolean):void
		{
			
			AppEvent.dispatch( AppEvent.TRACE_PLAYBACK_PAUSE , pause );
			
		}
		
		
		private function setMapCenter( x:Number, y:Number ):void {
			
			AppEvent.dispatch( AppEvent.SET_MAPCENTER, { x:x, y:y } );
		}
		
		private function setMapExtent( xMin:Number, xMax:Number, yMin:Number, yMax:Number ):void {
			AppEvent.dispatch( AppEvent.SET_MAPEXTENT, { xMin:xMin, xMax:xMax, yMin:yMin, yMax:yMax } );
		}
		
		private function findDevice( type:String, id:String = "", showInfo:Boolean = true ):void {
//			Alert.show( type, id );
			AppEvent.dispatch( AppEvent.CHANGE_WIDGET_ACTIVITY, { name: type, visible: true } );
			if ( id && id != "" )
				AppEvent.dispatch( AppEvent.FIND_DEVICE, 
					{ 
						type: type, 
						id: id, 
						showInfo: showInfo 
					} 
				);
		}
		
		private function hideDevice( type:String ):void {
			//Alert.show( type);
			AppEvent.dispatch( AppEvent.CHANGE_WIDGET_ACTIVITY, { name: type, visible: false } );
		}
		
		private function refreshConstructoinPoint():void {
			AppEvent.dispatch( AppEvent.REFRESH_REMOTE_DATA, 
				{ type: "ConstructionPointInfo" } );
		}
		
		private function refreshPoliceInfo():void {
			AppEvent.dispatch( AppEvent.REFRESH_REMOTE_DATA, 
				{ type: "PoliceManagerRTInfo" } ); 
		}
		
		private function refreshControlRoute():void {
			AppEvent.dispatch( AppEvent.REFRESH_REMOTE_DATA, 
				{ type: "ControlRouteInfo" } );
		}
		
		private function addPoints( xml:String ):void {
			AppEvent.dispatch( AppEvent.ADDPOINTS, xml ); 
		}
		
		private function deletePoints( xml:String ):void {
			AppEvent.dispatch( AppEvent.DELETEPOINTS, xml ); 
		}
		
		private function deleteAllPoints():void {
			AppEvent.dispatch( AppEvent.DELETEALLPOINTS ); 
		}
		
		//集中调用ExternalInterface.call
		private function externalCall( event:AppEvent ):void {
			var functionName:String = event.data.functionName;
			var paramArray:Array = event.data.params;
			
			trace( functionName );
			var paramStr:String = "";
			if ( paramArray ) {
				for (var i:int = 0; i < paramArray.length; i++)  {
					paramStr += ( paramArray[i].toString() ) + ",";
				}
				trace( paramStr );
			}
			
			if ( !paramArray || paramArray.length == 0 ) {
				ExternalInterface.call( functionName );
			}
			else {
				switch ( paramArray.length ) {
					case 1:
						ExternalInterface.call( functionName, paramArray[0] );
						break;
					case 2:
						ExternalInterface.call( functionName, paramArray[0], paramArray[1] );
						break;
					case 3:
						ExternalInterface.call( functionName, paramArray[0], paramArray[1], paramArray[2] );
						break;
					case 4:
						ExternalInterface.call( functionName, paramArray[0], paramArray[1], paramArray[2], 
							paramArray[3] );
						break;
					case 5:
						ExternalInterface.call( functionName, paramArray[0], paramArray[1], paramArray[2], 
							paramArray[3], paramArray[4] );
						break;
					case 6:
						ExternalInterface.call( functionName, paramArray[0], paramArray[1], paramArray[2], 
							paramArray[3], paramArray[4], paramArray[5] );
						break;
					case 7:
						ExternalInterface.call( functionName, paramArray[0], paramArray[1], paramArray[2], 
							paramArray[3], paramArray[4], paramArray[5], paramArray[6] );
						break;
					case 8:
						ExternalInterface.call( functionName, paramArray[0], paramArray[1], paramArray[2], 
							paramArray[3], paramArray[4], paramArray[5], paramArray[6],
							paramArray[7] );
						break;
					case 9:
						ExternalInterface.call( functionName, paramArray[0], paramArray[1], paramArray[2], 
							paramArray[3], paramArray[4], paramArray[5], paramArray[6],
							paramArray[7], paramArray[8] );
						break;
					case 10:
						ExternalInterface.call( functionName, paramArray[0], paramArray[1], paramArray[2], 
							paramArray[3], paramArray[4], paramArray[5], paramArray[6],
							paramArray[7], paramArray[8], paramArray[9] );
						break;
				}
			}
			
		}
		
		private function deviceIssue(event:AppEvent):void
		{
			var data:Object = event.data;
			var type:String = data.type;
			var DeviceIds:String = data.DeviceIds;
			if(type!=null && DeviceIds != null)
				ExternalInterface.call("deviceIssue", type, DeviceIds);
			// TODO Auto Generated method stub
			
		}
		
		private function dataReady(event:AppEvent):void
		{
			// TODO Auto Generated method stub
			var planid:String = event.data.planid;
			var type:String = event.data.type;
			var data:String = event.data.data;
			if (type!=null && planid!=null && data!=null) 
			{
				ExternalInterface.call( "planCallBack", planid, type, data );
			}
			
		}
		
		
		
		private function openDevice( event:AppEvent ):void {
			var type:String = event.data.type;
			if ( type == "callPerson" || type == "sendMessage" ) {
				var param:String = event.data.param;
				trace( type, param );
				ExternalInterface.call( "openDevice", type, param );
			}
			else {
				var id:String = event.data.id;
				var desc:String = event.data.desc;
				if ( type && type != "" && id && id != "" ) {
					trace( type, id, desc );
//					Alert.show( "type:"+type+" id:"+id);

					ExternalInterface.call( "openDevice", type, id, desc );
				}	
			}						
		}
		
		private function reportDevice( event:AppEvent ):void {
			var id:String = event.data as String;
			var urlReq:URLRequest = new URLRequest( "equipment.do?method=toEquipment&equiment_Id=" + id + "&type=1" );
			trace( urlReq.url );
			navigateToURL( urlReq );
		}
	}
}