#### The utilization of Promises in javascript
A promise is an object representing the eventual completion or failure of an asynchronous operation
-
- Pending When the async operation is in the process, it has not been completed nor failed, then the state of promise will be pending and the promise object will have another key, the PromiseResult key, which will be set to undefined
- Fulfilled - When the async operation completes with the desired result, the state will change to a fulfilled state and the PromiseResult key will have the desired result.
- Rejected- When the async operation fails, the state will be rejected and the PromiseResult key will have the reason to fail.
![1](https://github.com/mingyu110/Best-Practice/assets/48540798/afba4637-5baa-435e-a6fd-6e357aae0cd7)
The following is a sample code snippet accompanied by explanatory comments in Chinese, just for learning purpose of Promises in Javascript.

