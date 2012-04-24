/**
 *
 * as3dribbble: ActionScript Client for Dribbble.com API
 * Copyright (C) 2012, Sandeep Gupta
 * 
 * http://www.sangupta.com/projects/as3dribbble
 *
 * The file is licensed under the the Apache License, Version 2.0
 * (the "License"); you may not use this work except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

package com.sangupta.dribbble.api.model {

	/**
	 * Holds details of one page of shots from Dribbble.com
	 * 
	 * @author sangupta
	 *
	 */
	public class ShotList {

		public var page:int;
		
		public var pages:int;
		
		public var perPage:int;
		
		public var total:uint;
		
		public var shots:Vector.<Shot> = null;
		
		/**
		 * Return a strongly-typed <code>ShotList</code> object from this loosely-typed
		 * object.
		 * 
		 * @param parsed the loosely typed object
		 * 
		 * @return the strongly typed object
		 * 
		 */
		public static function createFromObject(parsed:Object):ShotList {
			if(parsed == null) {
				return null;
			}
			
			const list:ShotList = new ShotList();
			
			list.page = parsed.page;
			list.pages = parsed.pages;
			list.perPage = parsed.per_page;
			list.total = parsed.total;
			
			if(parsed.shots != null && parsed.shots.length > 0) {
				list.shots = new Vector.<Shot>();
				
				for(var index:int = 0; index < parsed.shots.length; index++) {
					var shotObject:Object = parsed.shots[index];
					var shot:Shot = Shot.createFromObject(shotObject);
					list.shots.push(shot);
				}
			}
			
			return list;
		}
		
	}
}
