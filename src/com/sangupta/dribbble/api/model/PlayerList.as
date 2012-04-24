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
	 * Holds details of one page of player list from Dribbble.com
	 * 
	 * @author sangupta
	 *
	 */
	public class PlayerList {
		
		public var page:int;
		
		public var pages:int;
		
		public var perPage:int;
		
		public var total:uint;
		
		public var players:Vector.<Player>;
	
		/**
		 * Return a strongly-typed <code>PlayerList</code> object from this loosely-typed
		 * object.
		 * 
		 * @param parsed the loosely typed object
		 * 
		 * @return the strongly typed object
		 * 
		 */
		public static function createFromObject(parsed:Object):PlayerList {
			if(parsed == null) {
				return null;
			}
			
			const list:PlayerList = new PlayerList();
			
			list.page = parsed.page;
			list.pages = parsed.pages;
			list.perPage = parsed.per_page;
			list.total = parsed.total;
			
			if(parsed.players != null && parsed.players.length > 0) {
				list.players = new Vector.<Player>();
				
				for(var index:int = 0; index < parsed.players.length; index++) {
					var playerObject:Object = parsed.players[index];
					var player:Player = Player.createFromObject(playerObject);
					list.players.push(player);
				}
			}
			
			return list;
		}
	}
}
