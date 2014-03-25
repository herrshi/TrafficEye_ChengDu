package com.esri.viewer.managers
{
	import com.esri.viewer.AppEvent;
	import com.esri.viewer.ConfigData;
	import com.esri.viewer.ViewerContainer;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.collections.ArrayCollection;
	import mx.core.FlexGlobals;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	public class RemoteObjectManager extends EventDispatcher {
		public function RemoteObjectManager(target:IEventDispatcher=null) {
			super(target);
			AppEvent.addListener( ViewerContainer.CONTAINER_INITIALIZED, init );
		}
		
		private var _userId:String;
		private var _roleId:String;
		
		private function init( event:Event ):void {	
			_userId = FlexGlobals.topLevelApplication.parameters.userId;
			_roleId = FlexGlobals.topLevelApplication.parameters.roleId;
			
			AppEvent.addListener( AppEvent.CONFIG_LOADED, config );
		}
		
		private var remoteList:Array;
		
		private function config( event:AppEvent ):void {
			var configData:ConfigData = event.data as ConfigData;
			remoteList = configData.remoteObjects;
			
			initPoliceManagerRemote();
			initEventManagerRemote();
			initPoliceDeploymentRemote();
			initConstructionPointRemote();
			initGetIssuesectsByUserRemote();
			initReservePlanManagerRemote();
			initPolicePDAManagerRemote();
			
			AppEvent.addListener( AppEvent.REFRESH_REMOTE_DATA, refreshData );
			AppEvent.addListener(AppEvent.SEND_RESERVEPLAN_DATA_NEW, sendReservePlanManagerInfo);
			AppEvent.addListener( AppEvent.REFRESH_PLAN_DATA, getReservePlanManagerInfo );

		}
		
		private function getRemoteConfig( name:String ):Object {
			for each ( var remote:Object in remoteList ) {
				if ( remote.name == name )
					return remote;
			}
			return null;
		}
		
		private function refreshData( event:AppEvent ):void {
			var type:String = event.data.type;
			switch ( type ) {
				case "PoliceManagerRTInfo":
					if ( policeManagerRTInfoRemote )
						policeManagerRTInfoRemote.getGPSPositionList( _userId, _roleId );
					if ( policeManagerTimer && !policeManagerTimer.running )
						policeManagerTimer.start();
					break;
				case "PoliceManagerPDARTInfo":
					if ( policeManagerRTInfoRemote )
						policeManagerPDARTInfoRemote.getPoliceGpsList( _userId, _roleId );
					if ( policeManagerPDATimer && !policeManagerPDATimer.running )
						policeManagerPDATimer.start();
					break;
				case "EventInfo":
					if ( eventManagerRemote )
						eventManagerRemote.getCase122();
					if ( eventManagerTimer && !eventManagerTimer.running )
						eventManagerTimer.start();
					break;
				case "PoliceDeploymentInfo":
					var date:String = event.data.date;
					if ( policeDeploymentRemote )
						policeDeploymentRemote.getPostLayoutFlexList( date );
					break;
				case "ConstructionPointInfo":
					if ( constructionPointRemote )
						constructionPointRemote.getConstructionPoint();
					break;
				case "GetIssuesectsByUserInfo":
					if ( getIssuesectsByUserRemote )
						getIssuesectsByUserRemote.getIssuesectsByUser();
					break;
				case "ControlRouteInfo":
					if ( controlRouteRemote )
						controlRouteRemote.getControlRoute();
					
			}
		}
		
		
		/**
		 *预案管理
		 */
		
		private var reservePlanManagerRemote:RemoteObject;
		private var reservePlanTimer:Timer;
		
		private function initReservePlanManagerRemote():void{
			var remoteConfig:Object = getRemoteConfig( "ReservePlanManager" );
			if (remoteConfig && remoteConfig.enable) 
			{
				var destination:String = remoteConfig.destination;
				var refreshrate:uint = remoteConfig.refreshRate;
				var endPoint:String = remoteConfig.endPoint;
				
				reservePlanManagerRemote = new RemoteObject( destination );
				reservePlanManagerRemote.endpoint = endPoint;
				reservePlanManagerRemote.showBusyCursor = true;
				reservePlanManagerRemote.addEventListener( ResultEvent.RESULT,reservePlanManagerInfoHandler );
				reservePlanManagerRemote.addEventListener( FaultEvent.FAULT, remoteFaultHandler );
//				
//				if (refreshrate>0) 
//				{
//						reservePlanTimer = new Timer( refreshrate * 1000 );
//						reservePlanTimer.addEventListener(TimerEvent.TIMER, refreshData );
//						//					timer.start();
//						//					refreshData( null );
//						
//						function refreshData( event:TimerEvent ):void {
//							reservePlanManagerRemote.getPlanInfoList();
//						}
//				}
			}

		}
		
		
		private function getReservePlanManagerInfo(event:AppEvent):void{
			var type:String = event.data.type;
			var planid:String = event.data.planid;
			if ( reservePlanManagerRemote )
			{
				//Alert.show( planid+" "+type);
			reservePlanManagerRemote.getPlanInfoList(planid,type);
			}
			
		}
		
		private function sendReservePlanManagerInfo( event:AppEvent ):void{
			var type:String = event.data.type;
			var planid:String = event.data.planid;

			if (type=="area") 
			{
				var listobj:ArrayCollection = event.data.data as ArrayCollection;
				if ( reservePlanManagerRemote )
					
					reservePlanManagerRemote.sendPlanInfoList( planid,type,listobj );
			}else if(type=="removealldevice"){
				reservePlanManagerRemote.sendPlanInfoList( planid,type,"" );
	
			}
			
		}
		
		
		private function reservePlanManagerInfoHandler( event:ResultEvent ):void {
			var planinfo:Object = event.result;
			var planid:String = planinfo.planId;
			var type:String = planinfo.type;
			var data:Object = planinfo.data;
			AppEvent.dispatch( AppEvent.DATA_NEW_PUBLISHED, 
				{ key: "ReservePlanManagerInfo", planinfo:{planid:planid,type:type,data:data} } );
			
		}
		/**
		 *警员管理
		 */
		private var policeManagerRTInfoRemote:RemoteObject;
		private var policeManagerTimer:Timer;
		private function initPoliceManagerRemote():void {
			var remoteConfig:Object = getRemoteConfig( "PoliceManager" );
			if ( remoteConfig && remoteConfig.enable ) {
				var destination:String = remoteConfig.destination;
				var refreshrate:uint = remoteConfig.refreshRate;
				var endPoint:String = remoteConfig.endPoint;
				
				policeManagerRTInfoRemote = new RemoteObject( destination );
				policeManagerRTInfoRemote.endpoint = endPoint;
//				policeManagerRTInfoRemote.requestTimeout = 0;
				policeManagerRTInfoRemote.showBusyCursor = true;
				policeManagerRTInfoRemote.addEventListener( ResultEvent.RESULT, 
					policeManagerRTInfoHandler );
				policeManagerRTInfoRemote.addEventListener( FaultEvent.FAULT, remoteFaultHandler );
				
				if ( refreshrate > 0 ) {
					policeManagerTimer = new Timer( refreshrate * 1000 );
					policeManagerTimer.addEventListener(TimerEvent.TIMER, refreshData );
//					policeManagerTimer.start();
//					refreshData( null );
					
					function refreshData( event:TimerEvent ):void {
						policeManagerRTInfoRemote.getGPSPositionList( _userId, _roleId );
					}
				}
			}
		}	
		
		private function policeManagerRTInfoHandler( event:ResultEvent ):void {
			var policeAC:ArrayCollection = event.result as ArrayCollection;
			
				AppEvent.dispatch( AppEvent.DATA_PUBLISH, 
					{ key: "PoliceManagerRTInfo", data: policeAC } );
		}
		
		/**
		 *警员PDA管理
		 */
		private var policeManagerPDARTInfoRemote:RemoteObject;
		private var policeManagerPDATimer:Timer;
		private function initPolicePDAManagerRemote():void {
			var remoteConfig:Object = getRemoteConfig( "PoliceManager" );
			if ( remoteConfig && remoteConfig.enable ) {
				var destination:String = remoteConfig.destination;
				var refreshrate:uint = remoteConfig.refreshRate;
				var endPoint:String = remoteConfig.endPoint;
				
				policeManagerPDARTInfoRemote = new RemoteObject( destination );
				policeManagerPDARTInfoRemote.endpoint = endPoint;
				//				policeManagerRTInfoRemote.requestTimeout = 0;
				policeManagerPDARTInfoRemote.showBusyCursor = true;
				policeManagerPDARTInfoRemote.addEventListener( ResultEvent.RESULT, 
					policeManagerPDARTInfoHandler );
				policeManagerPDARTInfoRemote.addEventListener( FaultEvent.FAULT, remoteFaultHandler );
				
				if ( refreshrate > 0 ) {
					policeManagerPDATimer = new Timer( refreshrate * 1000 );
					policeManagerPDATimer.addEventListener(TimerEvent.TIMER, refreshData );
					//					policeManagerTimer.start();
					//					refreshData( null );
					
					function refreshData( event:TimerEvent ):void {
						policeManagerPDARTInfoRemote.getPoliceGpsList( _userId, _roleId );
					}
				}
			}
		}	
		
		private function policeManagerPDARTInfoHandler( event:ResultEvent ):void {
			var policeAC:ArrayCollection = event.result as ArrayCollection;
			
			AppEvent.dispatch( AppEvent.DATA_PUBLISH, 
				{ key: "PoliceManagerPDARTInfo", data: policeAC } );
			
		}
		
		
		
		
		/**
		 *警情管理
		 */
		private var eventManagerRemote:RemoteObject;
		private var eventManagerTimer:Timer;
		private function initEventManagerRemote():void {
			var remoteConfig:Object = getRemoteConfig( "EventManager" ); 
			if ( remoteConfig && remoteConfig.enable ) {
				var destination:String = remoteConfig.destination;
				var refreshrate:uint = remoteConfig.refreshRate;
				var endPoint:String = remoteConfig.endPoint;
				
				eventManagerRemote = new RemoteObject( destination );
				eventManagerRemote.endpoint = endPoint;
//				eventManagerRemote.requestTimeout = 0;
				eventManagerRemote.showBusyCursor = true;
				eventManagerRemote.addEventListener( ResultEvent.RESULT, eventManagerHandler );
				eventManagerRemote.addEventListener( FaultEvent.FAULT, remoteFaultHandler );
				
				if ( refreshrate > 0 ) {
					eventManagerTimer = new Timer( refreshrate * 1000 );
					eventManagerTimer.addEventListener(TimerEvent.TIMER, refreshData );
//					timer.start();
//					refreshData( null );
					
					function refreshData( event:TimerEvent ):void {
						eventManagerRemote.getCase122();
					}
				}
			}
		}
		
		private function eventManagerHandler( event:ResultEvent ):void {
			var resultAC:ArrayCollection = event.result as ArrayCollection;
			AppEvent.dispatch( AppEvent.DATA_PUBLISH, 
				{ key: "EventInfo", data: resultAC } );
			AppEvent.dispatch( AppEvent.DISPATCH_IDS ,{userId:_userId , roleId:_roleId});

		}
		
		/**
		 *勤务管理
		 */
		private var policeDeploymentRemote:RemoteObject;
		private var policeDeploymentTimer:Timer;

		private function initPoliceDeploymentRemote():void {
			var remoteConfig:Object = getRemoteConfig( "PoliceDeployment" );
			if ( remoteConfig && remoteConfig.enable ) {
				var destination:String = remoteConfig.destination;
				var refreshrate:uint = remoteConfig.refreshRate;
				var endPoint:String = remoteConfig.endPoint;
				policeDeploymentRemote = new RemoteObject( destination );
				policeDeploymentRemote.endpoint = endPoint;
				policeDeploymentRemote.showBusyCursor = true;
				policeDeploymentRemote.addEventListener( ResultEvent.RESULT, policeDeploymentHandler );
				policeDeploymentRemote.addEventListener( FaultEvent.FAULT, remoteFaultHandler );
												
			}
		}
		
		private function policeDeploymentHandler( event:ResultEvent ):void {
			var data:ArrayCollection = event.result as ArrayCollection;
			AppEvent.dispatch( AppEvent.DATA_PUBLISH, 
				{ key: "PoliceDeploymentInfo", data: data } );
		}
		
		/**
		 *道路施工信息
		 */
		private var constructionPointRemote:RemoteObject;
		private function initConstructionPointRemote():void {
			var remoteConfig:Object = getRemoteConfig( "ConstructionPoint" );
			if ( remoteConfig && remoteConfig.enable ) {
				var destination:String = remoteConfig.destination;
				var refreshrate:uint = remoteConfig.refreshRate;
				var endPoint:String = remoteConfig.endPoint;
				constructionPointRemote = new RemoteObject( destination );
				constructionPointRemote.endpoint = endPoint;
				constructionPointRemote.showBusyCursor = true;
				constructionPointRemote.addEventListener( ResultEvent.RESULT, constructionPointHandler );
				constructionPointRemote.addEventListener( FaultEvent.FAULT, remoteFaultHandler );
			}
		}
		
		private function constructionPointHandler( event:ResultEvent ):void {
			var data:ArrayCollection = event.result as ArrayCollection;
			AppEvent.dispatch( AppEvent.DATA_PUBLISH, 
				{ key: "ConstructionPointInfo", data: data } );
		}
		
		/**
		 *发布段信息
		 */
		private var getIssuesectsByUserRemote:RemoteObject;
		private function initGetIssuesectsByUserRemote():void {
			var remoteConfig:Object = getRemoteConfig( "getIssuesectsByUser" );
			if ( remoteConfig && remoteConfig.enable ) {
				var destination:String = remoteConfig.destination;
				var refreshrate:uint = remoteConfig.refreshRate;
				var endPoint:String = remoteConfig.endPoint;
				getIssuesectsByUserRemote = new RemoteObject( destination );
				getIssuesectsByUserRemote.endpoint = endPoint;
				getIssuesectsByUserRemote.showBusyCursor = true;
				getIssuesectsByUserRemote.addEventListener( ResultEvent.RESULT, getIssuesectsByUserHandler );
				getIssuesectsByUserRemote.addEventListener( FaultEvent.FAULT, remoteFaultHandler );
			}
		}
		private function getIssuesectsByUserHandler( event:ResultEvent ):void {
			var data:ArrayCollection = event.result as ArrayCollection;
			AppEvent.dispatch( AppEvent.DATA_NEW_PUBLISHED, 
				{ key: "GetIssuesectsByUserInfo", data: data } );
		}
		
		/**
		 *管制路线
		 */
		private var controlRouteRemote:RemoteObject;
		private function initcontrolRouteRemote():void {
			var remoteConfig:Object = getRemoteConfig( "ControlRoute" );
			if ( remoteConfig && remoteConfig.enable ) {
				var destination:String = remoteConfig.destination;
				var refreshrate:uint = remoteConfig.refreshRate;
				var endPoint:String = remoteConfig.endPoint;
				controlRouteRemote = new RemoteObject( destination );
				controlRouteRemote.endpoint = endPoint;
				controlRouteRemote.showBusyCursor = true;
				controlRouteRemote.addEventListener( ResultEvent.RESULT, constructionPointHandler );
				controlRouteRemote.addEventListener( FaultEvent.FAULT, remoteFaultHandler );
			}
		}
		
		private function controlRouteHandler( event:ResultEvent ):void {
			var data:ArrayCollection = event.result as ArrayCollection;
			AppEvent.dispatch( AppEvent.DATA_PUBLISH, 
				{ key: "ControlRouteInfo", data: data } );
		}
		
		private function remoteFaultHandler( event:FaultEvent ):void {
			var strInfo: String;
			strInfo += "Event Headers: " + event.headers + "\n";
			strInfo += "Event Target: " + event.target + "\n";
			strInfo += "Event Type: " + event.type + "\n";
			strInfo += "Fault Code: " + event.fault.faultCode + "\n";
			strInfo += "Fault Info: " + event.fault.faultString + "\n";
			strInfo += "Fault Detail: " + event.fault.faultDetail;
			AppEvent.dispatch( AppEvent.APP_ERROR, strInfo );
		}
		
	}
}