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
	 * Holds details of one page of comments from Dribbble.com
	 * 
	 * @author sangupta
	 *
	 */
	public class CommentList {

		public var page:int;
		
		public var pages:int;
		
		public var perPage:int;
		
		public var total:uint;
		
		public var comments:Vector.<Comment>;
		
		/**
		 * Return a strongly-typed <code>CommentList</code> object from this loosely-typed
		 * object.
		 * 
		 * @param parsed the loosely typed object
		 * 
		 * @return the strongly typed object
		 * 
		 */
		public static function createFromObject(parsed:Object):CommentList {
			if(parsed == null) {
				return null;
			}
			
			const list:CommentList = new CommentList();
			
			list.page = parsed.page;
			list.pages = parsed.pages;
			list.perPage = parsed.per_page;
			list.total = parsed.total;
			
			if(parsed.comments != null && parsed.comments.length > 0) {
				list.comments = new Vector.<Comment>();
				
				for(var index:int = 0; index < parsed.comments.length; index++) {
					var commentObject:Object = parsed.comments[index];
					var comment:Comment = Comment.createFromObject(commentObject);
					list.comments.push(comment);
				}
			}
			
			return list;
		}
	}
}
