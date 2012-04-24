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
	 * Holds details on a given player of Dribbble.com
	 * 
	 * @author sangupta
	 *
	 */
	public class Player {

		public var id:uint;
		
		public var name:String;
		
		public var username:String;
		
		public var url:String;
		
		public var avatarUrl:String;
		
		public var location:String;
		
		public var twitterScreenName:String;
		
		public var draftedByPlayerId:String;
		
		public var shotsCount:int;
		
		public var drafteesCount:int;
		
		public var followersCount:int;
		
		public var followingCount:int;
		
		public var commentsCount:int;
		
		public var commentsReceivedCount:int;
		
		public var likesCount:int;
		
		public var likesReceivedCount:int;
		
		public var reboundsCount:int;
		
		public var reboundsReceivedCount:int;
		
		public var createdAt:String;
		
		public function toString():String {
			return '[Player ID: ' + this.id + ']';
		}
		
		/**
		 * Return a strongly-typed <code>Player</code> object from this loosely-typed
		 * object.
		 * 
		 * @param parsed the loosely typed object
		 * 
		 * @return the strongly typed object
		 * 
		 */
		public static function createFromObject(parsed:Object):Player {
			if(parsed == null) {
				return null;
			}
			
			const player:Player = new Player;
			
			player.id = parsed.id;
			player.name = parsed.name;
			player.username = parsed.username;
			player.url = parsed.url;
			player.avatarUrl = parsed.avatar_url;
			player.location = parsed.location;
			player.twitterScreenName = parsed.twitter_screen_name;
			player.draftedByPlayerId = parsed.drafted_by_player_id;
			player.shotsCount = parsed.shots_count;
			player.drafteesCount = parsed.draftees_count;
			player.followersCount = parsed.followers_count;
			player.followingCount = parsed.following_count;
			player.commentsCount = parsed.comments_count;
			player.commentsReceivedCount = parsed.comments_received_count;
			player.likesCount = parsed.likes_count;
			player.likesReceivedCount = parsed.likes_received_count;
			player.reboundsCount = parsed.rebounds_count;
			player.reboundsReceivedCount = parsed.rebounds_received_count;
			player.createdAt = parsed.created_at;
			
			return player;
		}
		
	}
}
