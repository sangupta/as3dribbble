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
	 * Defines the type of shot list for fetching generic shot lists.
	 * 
	 * @author sangupta
	 *
	 */
	public class ShotListType {
		
		private var _value:uint;
		
		private var _name:String;
		
		public function ShotListType(value:uint, name:String) {
			this._value = value;
			this._name = name;
		}
		
		public function get value():uint {
			return this._value;
		}
		
		public function get name():String {
			return this._name;
		}
		
		public function toString():String {
			return '[ShotListType: ' + this._name + ']';
		}
		
		public static const DEBUTS:ShotListType = new ShotListType(1, "debuts");
		
		public static const EVERYONE:ShotListType = new ShotListType(2, "everyone");
		
		public static const POPULAR:ShotListType = new ShotListType(3, "popular");
	}
}
