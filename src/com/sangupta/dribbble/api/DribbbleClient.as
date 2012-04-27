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
	
	import com.sangupta.dribbble.api.model.Comment;
	import com.sangupta.dribbble.api.model.CommentList;
	import com.sangupta.dribbble.api.model.Player;
	import com.sangupta.dribbble.api.model.PlayerList;
	import com.sangupta.dribbble.api.model.Shot;
	import com.sangupta.dribbble.api.model.ShotList;
	import com.sangupta.dribbble.api.model.ShotListType;
	
	import flash.events.Event;
	
	import mx.utils.StringUtil;
	
	/**
	 * Client to access Dribbble APIs from ActionScript. The client supports all available
	 * methods in the Dribbble API and provide results as strongly-typed ActionScript objects.
	 * 
	 * The client also implements rate limiting guidelines as per the Dribbble API
	 * documentation of 60 requests per minute. Also exposed is a convenience class
	 * called {@link DribbbleInvoker} that may be used to add more APIs (should they
	 * get added in future and this library looses track). The invoker is rate-limit
	 * safe.
	 * 
	 * @author sangupta
	 *
	 */
	public class DribbbleClient {
		
		/**
		 * Specifies if we need to throw an error if this request crosses rate-limiting.
		 */
		private var throwException:Boolean = true;
		
		/**
		 * Default page number
		 */
		private static const DEFAULT_PAGE:int = 1;
		
		/**
		 * Default results per page
		 */ 
		private static const DEFAULT_PER_PAGE:int = 15;
		
		/**
		 * Counter that keeps track of which request passed or failed. The identifier is passed back when making a call
		 * and also when a request fails.
		 */
		private static var requestCounter:uint = 0;
		
		/**
		 * Constructor to create a client instance.
		 * 
		 * @param throwException (optional) specifies if an exception needs to be thrown if our
		 * 			request is above the specified rate limit. Default value is <code>true</code>.
		 * 
		 */
		public function DribbbleClient(throwException:Boolean = true) {
			this.throwException = throwException;
		}
		
		/**
		 * Returns details for a shot specified by :id.
		 * 
		 * @param shotID the numeric identifier for the shot
		 * 
		 * @param completionFunction a call-back function that will be called with the shot details. The function signature should be of the type, <code>function functionName(shot:Shot):void</code>.
		 * 			The shot object may be null depending on if no contents are received for the object. 
		 * 
		 * @param errorFunction a call-back function that will be called if an error occurs, when fetching details. The function signature should be of the type, <code>function functionName(id:uint):void</code>
		 * 			The ID will be <code>uint</code> in this case.
		 * 
		 * @return an integer specifying the unique identifier for this request. The same integer is passed back to the error handler when a call fails
		 */
		public function getShot(shotID:uint, completionFunction:Function, errorFunction:Function):uint {
			if(shotID < 1) {
				throw new ArgumentError('Shot ID must be greater than zero.');
			}
			
			if(completionFunction == null) {
				throw new ArgumentError('Completion function cannot be null.');
			}
			
			return fulfillRequest('shots/' + String(shotID), parseShotDetails, completionFunction, errorFunction);
		}
		
		/**
		 * Returns the set of rebounds (shots in response to a shot) for the shot specified by :id.
		 * 
		 * @param shotID the numeric identifier for the shot
		 * 
		 * @param completionFunction a call-back function that will be called with the shot list details. The function signature should be of the type, <code>function functionName(shotList:ShotList)</code>.
		 * 			The shotList object may be null depending on if no contents are received for the object. 
		 * 
		 * @param errorFunction a call-back function that will be called if an error occurs, when fetching details. The function signature should be of the type, <code>function functionName(id:uint)</code>
		 * 			The ID will be <code>uint</code> in this case.
		 * 
		 * @param page the page number in the results collection to fetch
		 * 
		 * @param perPage the number of results to seek in pagination from results collection
		 * 
		 * @return an integer specifying the unique identifier for this request
		 * 
		 */
		public function getShotRebounds(shotID:uint, completionFunction:Function, errorFunction:Function, page:uint = DEFAULT_PAGE, perPage:uint = DEFAULT_PER_PAGE):uint {
			if(shotID < 1) {
				throw new ArgumentError('Shot ID must be greater than zero.');
			}
			
			if(completionFunction == null) {
				throw new ArgumentError('Completion function cannot be null.');
			}
			
			if(page < 1) {
				throw new ArgumentError("Page number must be greater than zero.");
			}
			
			if(perPage < 1) {
				throw new ArgumentError("Per-page number must be greater than zero.");
			}
			
			return fulfillListRequest('shots/' + String(shotID) + '/rebounds', parseShotList, completionFunction, errorFunction, page, perPage);
		}
		
		/**
		 * Returns the set of comments for the shot specified by :id.
		 * 
		 * @param shotID the numeric identifier for the shot
		 * 
		 * @param completionFunction a call-back function that will be called with the comment list details. The function signature should be of the type, <code>function functionName(commentList:CommentList)</code>.
		 * 			The commentList object may be null depending on if no contents are received for the object. 
		 * 
		 * @param errorFunction a call-back function that will be called if an error occurs, when fetching details. The function signature should be of the type, <code>function functionName(id:uint)</code>
		 * 			The ID will be <code>uint</code> in this case.
		 * 
		 * @param page the page number in the results collection to fetch
		 * 
		 * @param perPage the number of results to seek in pagination from results collection
		 * 
		 * @return an integer specifying the unique identifier for this request
		 * 
		 */
		public function getShotComments(shotID:uint, completionFunction:Function, errorFunction:Function, page:uint = DEFAULT_PAGE, perPage:uint = DEFAULT_PER_PAGE):uint {
			if(shotID < 1) {
				throw new ArgumentError('Shot ID must be greater than zero.');
			}
			
			if(completionFunction == null) {
				throw new ArgumentError('Completion function cannot be null.');
			}
			
			if(page < 1) {
				throw new ArgumentError("Page number must be greater than zero.");
			}
			
			if(perPage < 1) {
				throw new ArgumentError("Per-page number must be greater than zero.");
			}
			
			return fulfillListRequest('shots/' + String(shotID) + '/comments', parseCommentsList, completionFunction, errorFunction, page, perPage);
		}
		
		/**
		 * Returns the specified list of shots where :list has one of the following values: debuts, everyone, popular
		 * 
		 * @param shotListType A shotListType describing the type of shots to be fetched
		 * 
		 * @param completionFunction a call-back function that will be called with the shot list details. The function signature should be of the type, <code>function functionName(shotList:ShotList)</code>.
		 * 			The shotList object may be null depending on if no contents are received for the object. 
		 * 
		 * @param errorFunction a call-back function that will be called if an error occurs, when fetching details. The function signature should be of the type, <code>function functionName(id:uint)</code>
		 * 			The ID will be <code>uint</code> in this case.
		 * 
		 * @param page the page number in the results collection to fetch
		 * 
		 * @param perPage the number of results to seek in pagination from results collection
		 * 
		 * @return an integer specifying the unique identifier for this request
		 * 
		 */
		public function getShotsList(shotListType:ShotListType, completionFunction:Function, errorFunction:Function, page:uint = DEFAULT_PAGE, perPage:uint = DEFAULT_PER_PAGE):uint {
			if(shotListType == null) {
				throw new ArgumentError('Shot list cannot be null.');
			}
			
			if(completionFunction == null) {
				throw new ArgumentError('Completion function cannot be null.');
			}
			
			if(page < 1) {
				throw new ArgumentError("Page number must be greater than zero.");
			}
			
			if(perPage < 1) {
				throw new ArgumentError("Per-page number must be greater than zero.");
			}
			
			return fulfillListRequest('shots/' + shotListType.name, parseShotList, completionFunction, errorFunction, page, perPage);
		}
		
		/**
		 * Returns the most recent shots for the player specified by :id.
		 * 
		 * @param playerID an identifier for the player. The value can be an <code>int</code>, <code>uint</code>, or a <code>Number</code> if specifying user id, or a <code>String</code>
		 * 			if specifying the username.
		 * 
		 * @param completionFunction a call-back function that will be called with the shot list details. The function signature should be of the type, <code>function functionName(shotList:ShotList)</code>.
		 * 			The shotList object may be null depending on if no contents are received for the object. 
		 * 
		 * @param errorFunction a call-back function that will be called if an error occurs, when fetching details. The function signature should be of the type, <code>function functionName(id:uint)</code>
		 * 			The ID will be <code>int</code>, <code>uint</code>, <code>Number</code> or a <code>String</code> in this case.
		 * 
		 * @param page the page number in the results collection to fetch
		 * 
		 * @param perPage the number of results to seek in pagination from results collection
		 * 
		 * @return an integer specifying the unique identifier for this request
		 * 
		 */
		public function getShotsForPlayer(playerID:*, completionFunction:Function, errorFunction:Function, page:uint = DEFAULT_PAGE, perPage:uint = DEFAULT_PER_PAGE):uint {
			validatePlayerID(playerID);
			
			if(completionFunction == null) {
				throw new ArgumentError('Completion function cannot be null.');
			}
			
			if(page < 1) {
				throw new ArgumentError("Page number must be greater than zero.");
			}
			
			if(perPage < 1) {
				throw new ArgumentError("Per-page number must be greater than zero.");
			}
			
			return fulfillListRequest('players/' + String(playerID) + '/shots', parseShotList, completionFunction, errorFunction, page, perPage);
		}
		
		/**
		 * Returns the most recent shots published by those the player specified by :id is following.
		 * 
		 * @param playerID an identifier for the player. The value can be an <code>int</code>, <code>uint</code>, or a <code>Number</code> if specifying user id, or a <code>String</code>
		 * 			if specifying the username.
		 * 
		 * @param completionFunction a call-back function that will be called with the shot list details. The function signature should be of the type, <code>function functionName(shotList:ShotList)</code>.
		 * 			The shotList object may be null depending on if no contents are received for the object. 
		 * 
		 * @param errorFunction a call-back function that will be called if an error occurs, when fetching details. The function signature should be of the type, <code>function functionName(id:uint)</code>
		 * 			The ID will be <code>int</code>, <code>uint</code>, <code>Number</code> or a <code>String</code> in this case.
		 * 
		 * @param page the page number in the results collection to fetch
		 * 
		 * @param perPage the number of results to seek in pagination from results collection
		 * 
		 * @return an integer specifying the unique identifier for this request
		 * 
		 */
		public function getShotsOfPlayerFollowed(playerID:*, completionFunction:Function, errorFunction:Function, page:uint = DEFAULT_PAGE, perPage:uint = DEFAULT_PER_PAGE):uint {
			validatePlayerID(playerID);
			
			if(completionFunction == null) {
				throw new ArgumentError('Completion function cannot be null.');
			}
			
			if(page < 1) {
				throw new ArgumentError("Page number must be greater than zero.");
			}
			
			if(perPage < 1) {
				throw new ArgumentError("Per-page number must be greater than zero.");
			}
			
			return fulfillListRequest('players/' + String(playerID) + "/shots/following", parseShotList, completionFunction, errorFunction, page, perPage);
		}
		
		/**
		 * Returns shots liked by the player specified by :id.
		 * 
		 * @param playerID an identifier for the player. The value can be an <code>int</code>, <code>uint</code>, or a <code>Number</code> if specifying user id, or a <code>String</code>
		 * 			if specifying the username.
		 * 
		 * @param completionFunction a call-back function that will be called with the shot list details. The function signature should be of the type, <code>function functionName(shotList:ShotList)</code>.
		 * 			The shotList object may be null depending on if no contents are received for the object. 
		 * 
		 * @param errorFunction a call-back function that will be called if an error occurs, when fetching details. The function signature should be of the type, <code>function functionName(id:uint)</code>
		 * 			The ID will be <code>int</code>, <code>uint</code>, <code>Number</code> or a <code>String</code> in this case.
		 * 
		 * @param page the page number in the results collection to fetch
		 * 
		 * @param perPage the number of results to seek in pagination from results collection
		 * 
		 * @return an integer specifying the unique identifier for this request
		 */
		public function getPlayerLikedShots(playerID:*, completionFunction:Function, errorFunction:Function, page:uint = DEFAULT_PAGE, perPage:uint = DEFAULT_PER_PAGE):uint {
			validatePlayerID(playerID);
			
			if(completionFunction == null) {
				throw new ArgumentError('Completion function cannot be null.');
			}
			
			if(page < 1) {
				throw new ArgumentError("Page number must be greater than zero.");
			}
			
			if(perPage < 1) {
				throw new ArgumentError("Per-page number must be greater than zero.");
			}
			
			return fulfillListRequest('players/' + String(playerID) + "/shots/likes", parseShotList, completionFunction, errorFunction, page, perPage);
		}
		
		/**
		 * Returns details for a player specified by :id.
		 * 
		 * @param playerID an identifier for the player. The value can be an <code>int</code>, <code>uint</code>, or a <code>Number</code> if specifying user id, or a <code>String</code>
		 * 			if specifying the username.
		 * 
		 * @param completionFunction a call-back function that will be called with the player details. The function signature should be of the type, <code>function functionName(player:Player)</code>.
		 * 			The player object may be null depending on if no contents are received for the object. 
		 * 
		 * @param errorFunction a call-back function that will be called if an error occurs, when fetching details. The function signature should be of the type, <code>function functionName(id:uint)</code>
		 * 			The ID will be <code>int</code>, <code>uint</code>, <code>Number</code> or a <code>String</code> in this case.
		 * 
		 * @return an integer specifying the unique identifier for this request
		 */
		public function getPlayer(playerID:*, completionFunction:Function, errorFunction:Function):uint {
			validatePlayerID(playerID);
			
			if(completionFunction == null) {
				throw new ArgumentError('Completion function cannot be null.');
			}
			
			return fulfillRequest('player/' + String(playerID), parsePlayerDetails, completionFunction, errorFunction);
		}
		
		/**
		 * Returns shots liked by the player specified by :id.
		 * 
		 * @param playerID an identifier for the player. The value can be an <code>int</code>, <code>uint</code>, or a <code>Number</code> if specifying user id, or a <code>String</code>
		 * 			if specifying the username.
		 * 
		 * @param completionFunction a call-back function that will be called with the player details. The function signature should be of the type, <code>function functionName(playerList:PlayerList)</code>.
		 * 			The playerList object may be null depending on if no contents are received for the object. 
		 * 
		 * @param errorFunction a call-back function that will be called if an error occurs, when fetching details. The function signature should be of the type, <code>function functionName(id:uint)</code>
		 * 			The ID will be <code>int</code>, <code>uint</code>, <code>Number</code> or a <code>String</code> in this case.
		 * 
		 * @param page the page number in the results collection to fetch
		 * 
		 * @param perPage the number of results to seek in pagination from results collection
		 * 
		 * @return an integer specifying the unique identifier for this request
		 * 
		 */
		public function getPlayerFollowers(playerID:*, completionFunction:Function, errorFunction:Function, page:uint = DEFAULT_PAGE, perPage:uint = DEFAULT_PER_PAGE):uint {
			validatePlayerID(playerID);
			
			if(completionFunction == null) {
				throw new ArgumentError('Completion function cannot be null.');
			}
			
			if(page < 1) {
				throw new ArgumentError("Page number must be greater than zero.");
			}
			
			if(perPage < 1) {
				throw new ArgumentError("Per-page number must be greater than zero.");
			}
			
			return fulfillListRequest('players/' + String(playerID) + "/followers", parsePlayerList, completionFunction, errorFunction, page, perPage);
		}
		
		/**
		 * Returns the list of players followed by the player specified by :id.
		 * 
		 * @param playerID an identifier for the player. The value can be an <code>int</code>, <code>uint</code>, or a <code>Number</code> if specifying user id, or a <code>String</code>
		 * 			if specifying the username.
		 * 
		 * @param completionFunction a call-back function that will be called with the player details. The function signature should be of the type, <code>function functionName(playerList:PlayerList)</code>.
		 * 			The playerList object may be null depending on if no contents are received for the object. 
		 * 
		 * @param errorFunction a call-back function that will be called if an error occurs, when fetching details. The function signature should be of the type, <code>function functionName(id:uint)</code>
		 * 			The ID will be <code>int</code>, <code>uint</code>, <code>Number</code> or a <code>String</code> in this case.
		 * 
		 * @param page the page number in the results collection to fetch
		 * 
		 * @param perPage the number of results to seek in pagination from results collection
		 * 
		 * @return an integer specifying the unique identifier for this request
		 */
		public function getPlayerFollowed(playerID:*, completionFunction:Function, errorFunction:Function, page:uint = DEFAULT_PAGE, perPage:uint = DEFAULT_PER_PAGE):uint {
			validatePlayerID(playerID);
			
			if(completionFunction == null) {
				throw new ArgumentError('Completion function cannot be null.');
			}
			
			if(page < 1) {
				throw new ArgumentError("Page number must be greater than zero.");
			}
			
			if(perPage < 1) {
				throw new ArgumentError("Per-page number must be greater than zero.");
			}
			
			return fulfillListRequest('players/' + String(playerID) + "/following", parsePlayerList, completionFunction, errorFunction, page, perPage);
		}
		
		/**
		 * Returns the list of players drafted by the player specified by :id.
		 * 
		 * @param playerID an identifier for the player. The value can be an <code>int</code>, <code>uint</code>, or a <code>Number</code> if specifying user id, or a <code>String</code>
		 * 			if specifying the username.
		 * 
		 * @param completionFunction a call-back function that will be called with the player details. The function signature should be of the type, <code>function functionName(playerList:PlayerList)</code>.
		 * 			The playerList object may be null depending on if no contents are received for the object. 
		 * 
		 * @param errorFunction a call-back function that will be called if an error occurs, when fetching details. The function signature should be of the type, <code>function functionName(id:uint)</code>
		 * 			The ID will be <code>int</code>, <code>uint</code>, <code>Number</code> or a <code>String</code> in this case.
		 * 
		 * @param page the page number in the results collection to fetch
		 * 
		 * @param perPage the number of results to seek in pagination from results collection
		 * 
		 * @return an integer specifying the unique identifier for this request
		 * 
		 */
		public function getPlayerDraftees(playerID:*, completionFunction:Function, errorFunction:Function, page:uint = DEFAULT_PAGE, perPage:uint = DEFAULT_PER_PAGE):uint {
			validatePlayerID(playerID);
			
			if(completionFunction == null) {
				throw new ArgumentError('Completion function cannot be null.');
			}
			
			if(page < 1) {
				throw new ArgumentError("Page number must be greater than zero.");
			}
			
			if(perPage < 1) {
				throw new ArgumentError("Per-page number must be greater than zero.");
			}
			
			return fulfillListRequest('players/' + String(playerID) + "/draftees", parsePlayerList, completionFunction, errorFunction, page, perPage);
		}
		
		//------------------------------------------------
		// PRIVATE METHODS FOLLOW
		//------------------------------------------------
		
		/**
		 * Validates a given Player ID. It can be an <code>int</code>, <code>uint</code>,
		 * <code>Number</code> or a <code>String</code>.
		 */
		private function validatePlayerID(playerID:*):void {
			// int
			if(playerID is int) {
				var i:int = int(playerID);
				if(i < 1) {
					throw new ArgumentError('Player ID must be greater than zero.');
				}
			}

			// uint
			if(playerID is uint) {
				var ui:uint = uint(playerID);
				if(ui < 1) {
					throw new ArgumentError('Player ID must be greater than zero.');
				}
			}

			// Number
			if(playerID is Number) {
				var n:Number = Number(playerID);
				if(n < 1) {
					throw new ArgumentError('Player ID must be greater than zero.');
				}
			}
			
			// String
			if(playerID is String) {
				var s:String = playerID as String;
				if(s == null || StringUtil.trim(s).length == 0) {
					throw new ArgumentError('Player name cannot be null/empty.');
				}
			}
		}
		
		/**
		 * Fulfill client request returning the object details.
		 * 
		 * @param url the URL to hit as end point
		 * 
		 * @param parseFunction function to use to parse the JSON object into the strongly typed object. Function should have the signature 
		 * 				<code>function methodName(jsonObject:Object):StronglyTypedObject</code>
		 * 
		 * @param completionFunction the function to be called on the completion of JSON hit. Function should have the signature
		 * 				<code>function methodName(stronglyTypedObject:StronglyTypedObject)</code>
		 * 
		 * @param errorFunction the function to be called when something fails during the JSON hit. Function should have the signature
		 * 				<code>function methodName()</code>
		 * 
		 * @return an integer specifying the unique identifier for this request
		 */
		private function fulfillRequest(url:String, parseFunction:Function, completionFunction:Function, errorFunction:Function):uint {
			const counter:uint = requestCounter++;

			const callback:DribbbleFunctionCallback = new DribbbleFunctionCallback();
			callback.dribbbleCompletionHandler = completionFunction;
			callback.dribbbleErrorHandler = errorFunction;
			callback.parseFunction = parseFunction;
			callback.requestIdentifier = counter;
			
			DribbbleInvoker.invokeEndPoint(url, null, this.throwException, fetchJSONObject, errorHandler, callback);
			
			return counter;
		}
		
		/**
		 * Fulfill client request returning the list details.
		 * 
		 * @param url the URL to hit as end point
		 * 
		 * @param parseFunction function to use to parse the JSON object into the strongly typed object. Function should have the signature 
		 * 				<code>function methodName(jsonObject:Object):StronglyTypedObject</code>
		 * 
		 * @param completionFunction the function to be called on the completion of JSON hit. Function should have the signature
		 * 				<code>function methodName(stronglyTypedObject:StronglyTypedObject)</code>
		 * 
		 * @param errorFunction the function to be called when something fails during the JSON hit. Function should have the signature
		 * 				<code>function methodName(id:uint)</code>
		 * 
		 * @param page the page number for which to fetch the results
		 * 
		 * @param perPage the number of results per page to fetch
		 * 
		 * @return an integer specifying the unique identifier for this request
		 */
		private function fulfillListRequest(url:String, parseFunction:Function, completionFunction:Function, errorFunction:Function, page:uint, perPage:uint):uint {
			const params:String = "page=" + page + "&per_page=" + perPage;

			const counter:uint = requestCounter++;

			const callback:DribbbleFunctionCallback = new DribbbleFunctionCallback();
			callback.dribbbleCompletionHandler = completionFunction;
			callback.dribbbleErrorHandler = errorFunction;
			callback.parseFunction = parseFunction;
			callback.requestIdentifier = counter;
			
			DribbbleInvoker.invokeEndPoint(url, params, this.throwException, fetchJSONObject, errorHandler, callback);
			
			return requestCounter++;
		}
		
		/**
		 * Handles the returned JSON object. Calls the callback handler function passing it the relevant
		 * strongly-typed object.
		 * 
		 * @param message the JSON object as returned by the <code>JSONService</code>
		 * 
		 * @param callbackData the function callback token that was passed to the <code>JSONService</code> invoker
		 * 
		 */
		private function fetchJSONObject(message:Object, callbackData:DribbbleFunctionCallback):void {
			const func:Function = callbackData.dribbbleCompletionHandler;
			const parse:Function = callbackData.parseFunction;
			callbackData.destroy();
			
			const parsedObject:Object = parse(message);
			
			func(parsedObject);
		}
		
		/**
		 * Handles the error event and calls the error callback handler supplied by the calling
		 * code.
		 * 
		 * @param event the Error <code>Event</code> that was thrown while invoking the JSON service
		 * 
		 * @param callbackData the function callback token that was passed to the <code>JSONService</code> invoker
		 *  
		 */
		private function errorHandler(event:Event, callbackData:DribbbleFunctionCallback):void {
			const func:Function = callbackData.dribbbleErrorHandler;
			const counter:uint = callbackData.requestIdentifier;
			callbackData.destroy();
			
			if(func != null) {
				func(counter);
			}
		}

		/**
		 * Parse the JSON object into the strongly typed <code>Shot</code> object.
		 * 
		 * @param parsed the loosely-typed stream-parsed JSON object.
		 * 
		 * @return strongly-typed object.
		 */
		private function parseShotDetails(parsed:Object):Shot {
			return Shot.createFromObject(parsed);
		}
		
		/**
		 * Parse the JSON object into the strongly typed <code>ShotList</code> object.
		 * 
		 * @param parsed the loosely-typed stream-parsed JSON object.
		 * 
		 * @return strongly-typed object.
		 */
		private function parseShotList(parsed:Object):ShotList {
			return ShotList.createFromObject(parsed);
		}
		
		/**
		 * Parse the JSON object into the strongly typed <code>Player</code> object.
		 * 
		 * @param parsed the loosely-typed stream-parsed JSON object.
		 * 
		 * @return strongly-typed object.
		 */
		private function parsePlayerDetails(parsed:Object):Player {
			return Player.createFromObject(parsed);
		}
		
		/**
		 * Parse the JSON object into the strongly typed <code>PlayerList</code> object.
		 * 
		 * @param parsed the loosely-typed stream-parsed JSON object.
		 * 
		 * @return strongly-typed object.
		 */
		private function parsePlayerList(parsed:Object):PlayerList {
			return PlayerList.createFromObject(parsed);
		}
		
		/**
		 * Parse the JSON object into the strongly typed <code>Comment</code> object.
		 * 
		 * @param parsed the loosely-typed stream-parsed JSON object.
		 * 
		 * @return strongly-typed object.
		 */
		private function parseCommentDetails(parsed:Object):Comment {
			return Comment.createFromObject(parsed);
		}
		
		/**
		 * Parse the JSON object into the strongly typed <code>CommentList</code> object.
		 * 
		 * @param parsed the loosely-typed stream-parsed JSON object.
		 * 
		 * @return strongly-typed object.
		 */
		private function parseCommentsList(parsed:Object):CommentList {
			return CommentList.createFromObject(parsed);
		}
		
	}
}
