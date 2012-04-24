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

package com.sangupta.dribbble.api {
	
	import mx.utils.StringUtil;
	
	/**
	 * Utility class to invoke the end point at Dribbble.com and
	 * invoke completion/error handlers accordingly.
	 *  
	 * @author sangupta
	 *
	 */
	public class DribbbleInvoker {

		private static const DRIBBBLE_END_POINT:String = "http://api.dribbble.com/";
		
		private static const MAX_REQUESTS_PER_MINUTE:uint = 60;
		
		private static var currentRunningMinute:Number = 0;
		
		private static var currentMinuteHitCount:uint = 0;
		
		public static function invokeEndPoint(endPoint:String, params:String, throwException:Boolean, completionFunction:Function, errorFunction:Function, callbackObject:DribbbleFunctionCallback):void {
			// build the final URL to hit upon
			if(endPoint == null || StringUtil.trim(endPoint).length == 0) {
				throw new ArgumentError('Dribbble end-point cannot be null.');
			}
			
			// build the absolute URL
			var url:String = DRIBBBLE_END_POINT + endPoint;
			if(params != null && StringUtil.trim(params).length > 0) {
				url += '?' + params;
			}
			
			// check for rate limiting now
			// as Flash/AIR is single-threaded
			// there is no need for synchronization
			var millis:Number = new Date().time;
			var seconds:Number = millis / 1000;
			var minute:Number = seconds / 60;
			
			var proceed:Boolean = checkRateLimit(minute, throwException);
			
			if(!proceed) {
				// call the success function
				if(completionFunction != null) {
					completionFunction(null);
				}
			}
			
			// go ahead and hit the URL
			hit(url, completionFunction, errorFunction, callbackObject);
		}
		
		private static function checkRateLimit(minute:Number, throwException:Boolean):Boolean {
			if(minute == currentRunningMinute) {
				// we are for the same minute
				currentMinuteHitCount++;
				
				if(currentMinuteHitCount > MAX_REQUESTS_PER_MINUTE) {
					if(throwException) {
						throw new DribbbleApiRateLimitException('Over the limit of 60 requests/minute... slow down.');
					}
					
					return false;
				}
				
				return true;
			}
			
			// we are on switchover minute
			currentRunningMinute = minute;
			currentMinuteHitCount = 1;
			
			return true;
		}
		
		/**
		 * Hit the given URL and wait for completion/error function being called.
		 * 
		 */
		private static function hit(url:String, completionFunction:Function, errorFunction:Function, callbackObject:DribbbleFunctionCallback):void {
			var service:JSONService = new JSONService(url, completionFunction, errorFunction);
			service.execute(callbackObject);
		}
	}
}
