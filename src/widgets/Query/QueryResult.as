////////////////////////////////////////////////////////////////////////////////
//
// Copyright (c) 2010 ESRI
//
// All rights reserved under the copyright laws of the United States.
// You may freely redistribute and use this software, with or
// without modification, provided you include the original copyright
// and use restrictions.  See use restrictions in the file:
// <install location>/License.txt
//
////////////////////////////////////////////////////////////////////////////////
package widgets.Query
{
	
	import com.esri.ags.geometry.Geometry;
	import com.esri.ags.geometry.MapPoint;
	import com.esri.ags.symbols.Symbol;
	
	[Bindable]
	[RemoteClass(alias="widgets.Query.QueryResult")]
	
	public class QueryResult
	{
		public var title:String;
		
		public var symbol:Symbol;
		
		public var content:String;
		
		public var point:MapPoint;
		
		public var link:String;
		
		public var geometry:Geometry;
		
		public var buttons:Array;
		
		public var companyId:String;
		
		public var id:String;
		
		public var type:String;
		
		public var status:String;
		
		public var plusInfo:String;
		
		public var keyArray:Array;
		
	}
	
}
