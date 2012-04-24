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
		
		/**
		 * Convenience constructor that also sets the value of this shot type
		 * and the common name.
		 * 
		 * @param value the integer value to uniquely identify this shot type
		 * 
		 * @param name the name to be used for this shot type. The same value is also used by the DribbbleClient
		 * 			when passing the token to the webservice
		 * 
		 */
		public function ShotListType(value:uint, name:String) {
			this._value = value;
			this._name = name;
		}
		
		/**
		 * Return the integer value of this shot type
		 * 
		 * @return the integer value of this shot type
		 */
		public function get value():uint {
			return this._value;
		}
		
		/**
		 * Return the string value of this shot type
		 * 
		 * @return the string value of this shot type
		 */
		public function get name():String {
			return this._name;
		}
		
		/**
		 * Returns a string based representation of this shot type
		 * 
		 * @return string based representation of this shot type
		 */
		public function toString():String {
			return '[ShotListType: ' + this._name + ']';
		}
		
		/**
		 * Shot type for DEBUTS enumeration
		 */
		public static const DEBUTS:ShotListType = new ShotListType(1, "debuts");
		
		/**
		 * Shot type for EVERYONE enumeration
		 */
		public static const EVERYONE:ShotListType = new ShotListType(2, "everyone");

		/**
		 * Shot type for POPULAR enumeration
		 */
		public static const POPULAR:ShotListType = new ShotListType(3, "popular");
	}
}
