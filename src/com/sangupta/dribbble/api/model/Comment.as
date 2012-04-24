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
	 * Holds details of one comment from Dribbble.com
	 * 
	 * @author sangupta
	 */
	public class Comment {

		public var id:uint;
		
		public var body:String;
		
		public var likesCount:int;
		
		public var createdAt:String;
		
		public var player:Player;
		
		public function toString():String {
			return '[Comment ID: ' + this.id + ']';
		}
		
		/**
		 * Return a strongly-typed <code>Comment</code> object from this loosely-typed
		 * object.
		 * 
		 * @param parsed the loosely typed object
		 * 
		 * @return the strongly typed object
		 * 
		 */
		public static function createFromObject(parsed:Object):Comment {
			if(parsed == null) {
				return null;
			}
			
			const comment:Comment = new Comment();
			
			comment.id = parsed.id;
			comment.body = parsed.body;
			comment.likesCount = parsed.likes_count;
			comment.createdAt = parsed.created_at;
			comment.player = Player.createFromObject(parsed.player);
			
			return comment;
		}
	}
}
