as3dribbble
===========

as3dribbble is a strongly typed ActionScript client library for accessing http://dribbble.com API. 
The library provides support for rate limiting requests.

The library also exposes a convenience class called `DribbbleInvoker` that may be used to add more 
APIs (should they get added in future and this library looses track). The invoker is rate-limit safe.

Usage
-----

A simple example to use is as under,

```actionscript
private function getShotDetails():void {
	var client:DribbbleClient = new DribbbleClient();
	client.getShot(12, showShot, errorHandler);
}

private function showShot(shot:Shot):void {
	trace('received shot details: ' + shot);
}

private function errorHandler():void {
	// error occured when fetching shot details
}
```

Pagination Support
------------------

All API methods that support pagination have a corresponding, pagination-aware method available as well. For example,
when fetching comments for a shot you may do,

```actionscript
var client:DribbbleClient = new DribbbleClient();

private function getShotComments():void {
	client.getShotComments(123, showComments, errorHandler);
}

private function showComments(list:CommentList):void {
	// do something with these comments

	// check for more comments
	if(list.getPage() < list.getPages()) {
		// fetch results from page 2
		client.getShotComments(1, showComments, errorHandler, 2);
	
		// or, may provide the number of results to fetch as well
		// fetch results from page 2, with 15 results per page
		list = getShotComments(1, showComments, errorHandler, 2, 15);
	}
}
```

The current default for number of results per page is 15 per Dribbble API. Refer http://dribbble.com/api for more
details.

Rate-Limiting and Exceptions
----------------------------

By default, the `DribbbleClient` will throw a `DribbbleApiRateLimitException` run-time error when the
request rate goes over the board. This makes sure that your client does not need to catch unnecessary exceptions
during invocation. 

In case you wish, you may catch this exception and delay the request to a future time as,

```actionscript
private functino getShot():void {
	var shot:Shot = null;
	var shotID:uint = 1;

	try {
		shot = client.getShot(shotID);
	} catch(e:DribbbleApiRateLimitException) {
		// wait for a minute
		setTimeOut(getShot, 1000 * 60); // call again after a minute
	}
}
```

If you wish to prevent the code from throwing the `DribbbleApiRateLimitException` exception, you can do so when
creating the client.

```actionscript

var client:DribbbleClient = new DribbbleClient(false);
```

Any invocations on this client, will not throw the error, but return a `null` back as the result to the completion
handler you specified.

Dependencies
------------

The library does not depend on any third-party librarues and is self-contained. 

The library requires Flash 11.0/Adobe AIR 3.0 for functioning.

Versioning
----------

For transparency and insight into our release cycle, and for striving to maintain backward compatibility, 
dribbble-java-client will be maintained under the Semantic Versioning guidelines as much as possible.

Releases will be numbered with the follow format:

`<major>.<minor>.<patch>`

And constructed with the following guidelines:

* Breaking backward compatibility bumps the major
* New additions without breaking backward compatibility bumps the minor
* Bug fixes and misc changes bump the patch

For more information on SemVer, please visit http://semver.org/.

License
-------
	
Copyright (c) 2012, Sandeep Gupta

The project uses various other libraries that are subject to their
own license terms. See the distribution libraries or the project
documentation for more details.

The entire source is licensed under the Apache License, Version 2.0 
(the "License"); you may not use this work except in compliance with
the LICENSE. You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
