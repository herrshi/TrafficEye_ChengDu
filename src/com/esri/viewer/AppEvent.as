////////////////////////////////////////////////////////////////////////////////
//
// Copyright (c) 2010-2011 Esri
//
// All rights reserved under the copyright laws of the United States.
// You may freely redistribute and use this software, with or
// without modification, provided you include the original copyright
// and use restrictions.  See use restrictions in the file:
// <install location>/License.txt
//
////////////////////////////////////////////////////////////////////////////////
package com.esri.viewer
{

import com.esri.viewer.managers.EventBus;

import flash.events.Event;

/**
 * AppEvent is used within the application to send messages among components
 * through the EventBus. All event driven messaging in the Flex Viewer is
 * using the AppEvent.
 *
 * <p>The typical way of sending a message via the AppEvent is, for example:</p>
 *
 * <listing>
 *   AppEvent.dispatch(AppEvent.DATA_OPT_LAYERS, null, getOplayers));
 * </listing>
 *
 * <p>The typical way of receiving a message via the AppEvent is, for example:</p>
 * <listing>
 *   AppEvent.addListener(AppEvent.DATA_PUBLISH, sharedDataUpdated);
 * </listing>
 *
 * @see EventBus
 */
public class AppEvent extends Event
{
    //--------------------------------------------------------------------------
    //
    //  Class constants
    //
    //--------------------------------------------------------------------------

    /**
     * The error event type. This event type is used to send a user friendly
     * error message via the event bus. A error window will display the error
     * message.
     *
     * <p>When sending the error message, the data sent with the AppEvent is the
     * error string. For example: </p>
     *
     * <listing>
     * AppEvent.dispatch(AppEvent.APP_ERROR, false, false, "An Error Message"));
     * </listing>
     *
     * @see components.ErrorWindow
     */
    public static const APP_ERROR:String = "appError";

    /**
     * This event type indicates that the Flex Viewer application has completed loading the
     * configuration file. The ConfigManager sends this event so that other components that
     * are interested in obtaining configuration data can listen to this event.
     *
     * @see ConfigManager
     */
    public static const CONFIG_LOADED:String = "configLoaded";
	
	public static const DISPATCH_IDS:String ="dispatchids";

    /**
     * This event type indicates that the map is loaded. The MapManager sends this event so
     * that other components such as the Controller can start working with the map.
     *
     * @see MapManager
     * @see Controller
     */
    public static const MAP_LOADED:String = "mapLoaded";

    public static const MAP_RESIZE:String = "mapResize";

    public static const MAP_LAYER_VISIBLE:String = "mapLayerVisibleChange";

    /**
     * This event type indicates a dynamic layer is loaded.
     */
    public static const LAYER_LOADED:String = "layerLoaded";

    /**
     * This event type is used by the Controller to indicate the base map has changed.
     *
     * @see Controller
     */
    public static const BASEMAP_SWITCH:String = "basemapSwitch";


    /**
     * This event type is used by either Flex Viewer components or a widget to
     * request set the map naviation method. The map navigation method could be
     * pan, zoomin, zoomout, etc.
     *
     * <p>The navigation methods supported are:</p>
     * <listing>
     * pan          (Navigation.PAN)
     * zoomin       (Navigation.ZOOM_IN)
     * zoomout      (Navigation.ZOOM_OUT)
     * zoomfull     (ViewerContainer.NAVIGATION_ZOOM_FULL)
     * zoomprevious (ViewerContainer.NAVIGATION_ZOOM_PREVIOUS)
     * zoomnext     (ViewerContainer.NAVIGATION_ZOOM_NEXT)
     * </listing>
     *
     * <p>The navigation request can be sent as such:</P>
     * <listing>
     *  var data:Object =
     *     {
     *       tool: Navigation.PAN,
     *       status: status
     *      }
     *   AppEvent.dispatch(AppEvent.SET_MAP_NAVIGATION, false, false, data));
     * </listing>
     *
     */
    public static const SET_MAP_NAVIGATION:String = "setMapNavigation";

    /**
     * This event type is used to set the status text shown at the controller bar. to AppEvent
     * to set the status string, for example:
     *
     * <listing>
     *  dispatchEvent(new AppEvent(AppEvent.SET_STATUS, false, false, status));
     * </listing>
     */
    public static const SET_STATUS:String = "setStatus";

    /**
     * Used to show the info windows on the map through the AppEvent via EventBus.
     *
     * <listing>
     *  AppEvent.dispatch(AppEvent.SHOW_INFOWINDOW, infoData);
     * </listing>
     *
     * The infoData is a dynamic object structure as, for example:
     * <listing>
     *   var infoData:Object =
     *       {
     *          icon: icon,              //a Image object
     *          title: "a title string",
     *          content: "a string",
     *          link: "http://a.url.com",
     *          point: point,            //a Point object
     *          geometry: geom           //a Geometry object
     *       };
     * </listing>
     */
    public static const SHOW_INFOWINDOW:String = "widgetShowInfo";

    /**
     * Used to set map's interactive mode, such as Draw point, line, etc. To
     * use AppEvent via EventBus:
     *
     * <listing>
     * AppEvent.dispatch(AppEvent.SET_MAP_ACTION, data));
     * </listing>
     *
     * Where data is a dynamic data structure:
     *
     * <listing>
     * var data:Object =
     *   {
     *       tool: action,       //an action string token
     *       status: "status string",
     *       handler: callback   //a callback Function
     *   }
     * </listing>
     * Please refer to the Developer's Guide for details.
     */
    public static const SET_MAP_ACTION:String = "setMapAction";

    /**
     * For widget chain and data manager to manage the session generated data.
     */
    public static const DATA_PUBLISH:String = "dataPublishing";
    /**
     * For widget chain. TBD
     */
    public static const DATA_NEW_PUBLISHED:String = "dataPublished";
	
	public static const TEAM_VISIBLE_PREV:String = "dataPrev";

    /**
     * for widget chain. TBD
     */
    public static const DATA_FETCH_ALL:String = "dataFetchAll";

    public static const DATA_FETCH:String = "dataFetch";

    public static const DATA_SENT:String = "dataFetched";

    public static const DATA_OPT_LAYERS:String = "dataOperationalLayers";

    public static const DATA_CREATE_INFOWIDGET:String = "createInfoWidget";

    /**
     * for widget layout
     */
    public static const CHANGE_LAYOUT:String = "changeLayout";

    /**
     * This event type is used by the Controller to indicate a widget run request
     */
    public static const WIDGET_RUN:String = "widgetRunRequested";

	
    /**
     * used to send message to widget to change its state such as close, min and max
     * var data:Object {
     *    id: widgetId, //as Number
     *    state: stateString //as String
     * }
     * AppEvent.publish(AppEvent.WIDGET_CHANGE_STATE, data);
     */
    public static const WIDGET_CHANGE_STATE:String = "widgetChangeState";

    public static const WIDGET_STATE_CHANGED:String = "widgetStateChanged";

    /**
     * for widget layout
     */
    public static const WIDGET_FOCUS:String = "focusWidget";

    public static const WIDGET_CHAIN_NEXT:String = "widgetChainNextRequested";

    public static const WIDGET_CHAIN_START:String = "widgetChainStartRequested"

    public static const WIDGET_MGR_RESIZE:String = "widgetManagerResize";

    public static const WIDGET_ADD:String = "addWidget";

    public static const WIDGET_ADDED:String = "widgetAdded";

    public static const WIDGET_CLOSE:String = "closeWidget";

    public static const INFOWIDGET_REQUEST:String = "requestInfoWidget";

    public static const INFOWIDGET_READY:String = "infoWidgetReady";

    /**
     * Builder events.
     */
    public static const SET_TITLES:String = 'setTitles';

    public static const SET_LOGO:String = 'setLogo';

    public static const SET_TITLE_COLOR:String = 'setTitleColor';

    public static const SET_TEXT_COLOR:String = 'setTextColor';

    public static const SET_BACKGROUND_COLOR:String = 'setBackgroundColor';

    public static const SET_ROLLOVER_COLOR:String = 'setRolloverColor';

    public static const SET_SELECTION_COLOR:String = 'setSelectionColor';

    public static const SET_APPLICATION_BACKGROUND_COLOR:String = 'setApplicationBackgroundColor';

    public static const SET_ALPHA:String = 'setAlpha';

    public static const SET_FONT_NAME:String = 'setFontName';

    public static const SET_APP_TITLE_FONT_NAME:String = 'setAppTitleFontName';

    public static const SET_SUB_TITLE_FONT_NAME:String = 'setSubTitleFontName';

    public static const SET_PREDEFINED_STYLES:String = 'setPredefinedStyles';
	
	//改变整个服务的可见性
	public static const MAP_SERVICE_VISIBLE:String = "mapServiceVisibleChange";
	
	//改变服务中某个图层的可见性
	public static const LAYER_VISIBLE:String = "layerVisibleChange";
	
	/**
	 *在地图上新增文字 
	 */
	public static const ADD_TEXT:String = "addText";
	
	/**
	 *在地图上删除文字 
	 */
	public static const CLEAR_TEXT:String = "clearText";
	
	/**
	 *改变LayerControlContent中widget激活状态
	 */
	public static const CHANGE_WIDGET_ACTIVITY:String = "changeWidgetActivity";
	
	/**
	 *查找widget中的图层元素
	 */
	public static const FIND_DEVICE:String = "findDevice";
	
	/**
	 *调用jsp中的openDevice函数
	 * var data:Object {
	 *    type: 设备类型, //as String
	 *    id: 设备编号 //as String
	 *    desc: 设备描述 //as String
	 * } 
	 */
	public static const OPEN_DEVICE:String = "openDevice";
	
	
	/**
	 *jsp调用回传参数 
	 * 
	 */
	public static const ADD_DEVICE:String = "addDevice";
	public static const DEVICE_ISSUE:String="deviceIssue";
	
	public static const PLAN_DATA_READY:String = "planDataReady";
	public static const SET_PLAN_INFO:String = "setPlanInfo";
	
	/**
	 *调用jsp中的函数
	 * var data:Object {
	 *    functionName: 函数名
	 *    params: 参数列表
	 * } 
	 */
	public static const EXTERNAL_CALL:String = "externalCall";
	
	//运维平台的设备点击
	public static const REPORT_DEVICE:String = "reportDevice";
	
	//hide layercontral
	public static const HIDE_LAYERCONTROL:String = "hideLayerControl";

	

	//警员列表中警员的状态改变
	public static const POLICETREE_PERSON_CHECKBOX_CLICKED:String = "policeTreePersonCheckboxClicked";
	
	//警员列表中中队的状态改变
	public static const POLICETREE_TEAM_CHECKBOX_CLICKED:String = "policeTreeTeamCheckboxClicked";
	
	//警员列表中警员的状态改变
	public static const POLICETREE_PDA_PERSON_CHECKBOX_CLICKED:String = "policeTreePDAPersonCheckboxClicked";
	
	//警员列表中中队的状态改变
	public static const POLICETREE_PDA_TEAM_CHECKBOX_CLICKED:String = "policeTreePDATeamCheckboxClicked";
	
	/**
	 *请求刷新RemoteObject数据
	 * var data:Object {
	 *    type: 类型 //as String
	 *    data: 参数 //as String
	 * } 
	 */
	public static const REFRESH_REMOTE_DATA:String = "refreshRemoteData";
	/**
	 *请求传输预案RemoteObject数据
	 * var data:Object {
	 *    type: 类型 //as String
	 *    data: 参数 //as String
	 * } 
	 */
	public static const SEND_RESERVEPLAN_DATA:String = "sendReservePlanData";
	public static const SEND_RESERVEPLAN_DATA_NEW:String = "sendReservePlanDataing";

	public static const REFRESH_PLAN_DATA:String = "refreshPlanDataed";
	public static const REFRESH_PLAN_DATA_NEW:String = "refreshPlanDataing";
	public static const GET_PLAN_ID:String = "getPlanId";
	
	/**
	 *图例中的checkbox点击，控制图层中对应元素的显示
	 * var data:Object {
	 *    widgetTitle: widget名称 //as String
	 *    rankValue: 分级名称 //as String
	 *    visible: 是否显示 //as boolean
	 * } 
	 */
	public static const LEGEND_CHECKBOX_CLICKED:String = "legendCheckboxClicked";
	
	/**
	 *点击派警按钮后在地图上选择警员，调用派警接口
	 * data: string, eventId
	 */
	public static const SEND_POLICE:String = "sendPolice";
	
	public static const WIDGET_CREATED:String = "widgetCreated";
	
	public static const SET_MAPCENTER:String = "setMapCenter";
	
	public static const SET_MAPEXTENT:String = "setMapExtent";
	
	public static const MAPREFRESH:String = "mapRefresh";
	
	/**
	 * 
	 * 
	 */
	public static const REMOVEOVERLAY:String = "RemoveOverlay";
	public static const ADDOVERLAY:String = "AddOverlay";
	public static const TRACE_PLAYBACK:String = "TracePlayback";
	public static const TRACE_PLAYBACK_PAUSE:String = "TracePlayback_pause";

	
	public static const ADDPOINTS:String = "addPoints";
	public static const DELETEPOINTS:String = "deletePoints";
	public static const DELETEALLPOINTS:String = "deleteAllPoints";
	
	/**
	 * 提供在地图上增加图标的接口。显示样式由flash配置文件指定。
	 * 参数: json字符串
	 * */
	public static const ADD_POINTS:String = "addPoints";
	
	/**
	 * 提供在地图上删除全部图标的接口。
	 * 参数: 无
	 * */
	public static const DELETE_ALL_POINTS:String = "deleteAllPoints";
	
	/**
	 * 提供在地图上删除指定图标的接口。
	 * 参数: json字符串
	 * */
	public static const DELETE_POINTS:String = "deletePoints";
	
	/**
	 * 提供在地图上增加polyline的接口
	 * */
	public static const ADD_LINES:String = "addLines";
	public static const DELETE_ALL_LINES:String = "deleteAllLines";
	public static const DELETE_LINES:String = "deleteLines";
	
	/**
	 * 提供在地图上增加缓冲区的接口
	 * */
	public static const ADD_BUFFERS:String = "addBuffers";
	public static const DELETE_BUFFERS:String = "deleteBuffers";
	public static const DELETE_ALL_BUFFERS:String = "deleteAllBuffers";
	
	/**
	 * 通知Overlay组件进入移动状态
	 * <listing>
	 * var data:Object = 
	 *   {
	 *     var type:String，组件的type。
	 *     var ids:[]，要移动的grahpic的id数组。为空则所有graphic都可以移动
	 *   }
	 * </listing>
	 * */
	public static const START_MOVE_OVERLAY:String = "startEditOverlay";
	
	/**
	 * 通知Overlay组件进入新增状态
	 * <listing>
	 * var type:String
	 * </listing>
	 * */
	public static const START_ADD_OVERLAY:String = "startAddOverlay";
	
	/**
	 * 通知Overlay组件结束编辑状态
	 * <listing>
	 * var type:String
	 * </listing>
	 * */
	public static const STOP_EDIT_OVERLAY:String = "stopEditOverlay";
	
	/**
	 * 通知Overlay组件结束新增状态
	 * <listing>
	 * var type:String
	 * </listing>
	 * */
	public static const STOP_ADD_OVERLAY:String = "stopAddOverlay";
	
	/**
	 * 通知页面删除点位
	 * <listing>
	 * var data:Object = 
	 *   {
	 *     var type:String，组件的type。
	 *     var ids:[]，要删除的grahpic的id数组。
	 *   }
	 * </listing>
	 * */
	public static const DELETE_POINTS_BY_MAP:String = "deletePointsByMap";
	
	/**
	 * 点击编辑工具栏的后退按钮触发的事件。移动Overlay时回到上一次的位置。
	 * */
	public static const EDITORTOOBAR_UNDO:String = "editorToolbarUnDo";
	
	/**
	 * 点击编辑工具栏的重做按钮触发的事件。
	 * */
	public static const EDITORTOOBAR_REDO:String = "editorToolbarReDo";
	
	/**
	 * 点击编辑工具栏的提交按钮触发的事件。向页面提交本次修改。
	 * */
	public static const EDITORTOOBAR_COMMIT:String = "editorToolbarCommit";
	
	/**
	 * 点击编辑工具栏的取消按钮触发的事件。结束编辑状态，回到初始位置。
	 * */
	public static const EDITORTOOBAR_CANCEL:String = "editorToolbarCancel";
	
	/**
	 * 设置MultiLayerSearch组件的查询条件
	 * 新增警情等点位时页面可以输入地址
	 * */
	public static const SET_SEARCH_TEXT:String = "setSearchText";
	
	public static const SIM_MOVE_POINT_START:String = "startSimMovePoint";
	public static const SIM_MOVE_POINT_PAUSE:String = "pauseSimMovePoint";
	public static const SIM_MOVE_POINT_RESUME:String = "resumeSimMovePoint";
	public static const SIM_MOVE_POINT_STOP:String = "stopSimMovePoint";
	public static const SIM_MOVE_POINT_SET_SPEED:String = "setSimMovePointSpeed";
	public static const GET_SIM_MOVE_POINT_CURRENT_POINT:String = "getSimMovePointCurrentPoint";
	public static const SET_SIM_MOVE_POINT_CURRENT_POINT:String = "setSimMovePointCurrentPoint";
	
	/**
	 * 增加警员、警车等gps轨迹
	 * 参数：json字符串
	 * */
	public static const ADD_GPS_TRACK:String = "addGpsTrack";
	public static const DELETE_ALL_GPS_TRACK:String = "deleteAllGpsTrack";
	
	/**
	 * 刷新单个警员位置
	 * */
	public static const REFRESH_SINGLE_POLICE:String = "refreshSinglePolice";
	
	/**
	 * 页面输入查询条件对图层进行过滤
	 * <listing>
	 * var data:Object =
	 *   {
	 *     var serviceName:String，服务名，配置在config.xml中的layer.label。为空则设置所有dynamic/feature服务的definition。
	 *     var layerId:Number，图层序号。为空则设置服务下的所有layer。
	 *     var whereClause:String，查询条件。
	 *   }
	 * </listing>
	 * */
	public static const SET_LAYER_FILTER_DEFINITION:String = "setLayerFilterDifinition";
	
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function AppEvent(type:String, data:Object = null, callback:Function = null)
    {
        super(type);
        _data = data;
        _callback = callback;
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    private var _data:Object;

    private var _callback:Function;

    /**
     * The data will be passed via the event. It allows the event dispatcher to publish
     * data to event listener(s).
     */
    public function get data():Object
    {
        return _data;
    }

    /**
     * @private
     */
    public function set data(value:Object):void
    {
        _data = value;
    }

    /**
     * The callback function associated with this event.
     */
    public function get callback():Function
    {
        return _callback;
    }

    /**
     * @private
     */
    public function set callback(value:Function):void
    {
        _callback = value;
    }

    /**
     * Override clone
     */
    public override function clone():Event
    {
        return new AppEvent(this.type, this.data, this.callback);
    }

    /**
     * Dispatch this event.
     */
    public function dispatch():Boolean
    {
        return EventBus.instance.dispatchEvent(this);
    }

    /**
     * Dispatch an AppEvent for specified type and with optional data and callback reference.
     */
    public static function dispatch(type:String, data:Object = null, callback:Function = null):Boolean
    {
        return EventBus.instance.dispatchEvent(new AppEvent(type, data, callback));
    }

    public static function addListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
    {
        EventBus.instance.addEventListener(type, listener, useCapture, priority, useWeakReference);
    }

    public static function removeListener(type:String, listener:Function, useCapture:Boolean = false):void
    {
        EventBus.instance.removeEventListener(type, listener, useCapture);
    }

    public static function setStatus(status:String):void
    {
        dispatch(AppEvent.SET_STATUS, status);
    }

    public static function showError(error:String):void
    {
        dispatch(AppEvent.APP_ERROR, error);
    }

}

}
