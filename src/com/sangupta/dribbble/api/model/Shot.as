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
	 * Holds details of one shot from Dribbble.com
	 * 
	 * @author sangupta
	 *
	 */
	public class Shot {

		public var id:uint;
		
		public var title:String;
		
		public var url:String;
		
		public var shortUrl:String;
		
		public var imageUrl:String;
		
		public var imageTeaserUrl:String;
		
		public var width:int;
		
		public var height:int;
		
		public var viewsCount:int;
		
		public var likesCount:int;
		
		public var commentsCount:int;
		
		public var reboundsCount:int;
		
		public var reboundSourceID:int;
		
		public var createdAt:String;
		
		public var player:Player;
		
		public function toString():String {
			return '[Shot ID: ' + this.id + ']';
		}
		
		/**
		 * Return a strongly-typed <code>Shot</code> object from this loosely-typed
		 * object.
		 * 
		 * @param parsed the loosely typed object
		 * 
		 * @return the strongly typed object
		 * 
		 */
		public static function createFromObject(parsed:Object):Shot {
			if(parsed == null) {
				return null;
			}
			
			const shot:Shot = new Shot();
			
			shot.id = parsed.id;
			shot.title = parsed.title;
			shot.url = parsed.url;
			shot.shortUrl = parsed.short_url;
			shot.imageUrl = parsed.image_url;
			shot.imageTeaserUrl = parsed.image_teaser_url;
			shot.width = parsed.width;
			shot.height = parsed.height;
			shot.viewsCount = parsed.views_count;
			shot.likesCount = parsed.likes_count;
			shot.commentsCount = parsed.comments_count;
			shot.reboundsCount = parsed.rebounds_count;
			shot.reboundSourceID = parsed.rebound_source_id;
			shot.createdAt = parsed.created_at;
			shot.player = Player.createFromObject(parsed.player);
			
			return shot;
		}
		
	}
}
