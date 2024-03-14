import sys, time, logging, json
from aliyunsdkcore.client import AcsClient
from aliyunsdkcore.acs_exception.exceptions import ClientException
from aliyunsdkcore.acs_exception.exceptions import ServerException
from aliyunsdkcdn.request.v20180510.RefreshObjectCachesRequest import RefreshObjectCachesRequest
from aliyunsdkcdn.request.v20180510.PushObjectCacheRequest import PushObjectCacheRequest
from aliyunsdkcdn.request.v20180510.DescribeRefreshTasksRequest import DescribeRefreshTasksRequest
from aliyunsdkcdn.request.v20180510.DescribeRefreshQuotaRequest import DescribeRefreshQuotaRequest

def handler(event, context):
  id = 'LTA*********nRkRaYb7'
  secret = 'YJuNY*************rdeKLnl'
  client = AcsClient(id, secret, 'cn-shenzhen')
  obj = json.loads(event)
  doRefresh(obj['urls'], obj['type'], obj['objectType'], obj['area'], client)

  return 'hello world'

def doRefresh(lists,types,objectType,area,client):
    try:
      if types == 'clear':
        taskID = 'RefreshTaskId'
        request = RefreshObjectCachesRequest()
        if objectType:
          request.set_ObjectType(objectType)
      elif types == 'push':
        taskID = 'PushTaskId'
        request = PushObjectCacheRequest()
        if area:
          request.set_Area(area)

      taskreq = DescribeRefreshTasksRequest()
      request.set_accept_format('json')
      request.set_ObjectPath(lists)
      response = json.loads(client.do_action_with_exception(request))
      print(response)
    
      while True:
        count = 0
        taskreq.set_accept_format('json')
        taskreq.set_TaskId(int(response[taskID]))
        taskresp = json.loads(client.do_action_with_exception(taskreq))
        print("[" + response[taskID] + "]" + "is doing... ...")
        for t in taskresp['Tasks']['CDNTask']:
          if t['Status'] != 'Complete':
            count += 1
        if count == 0:
          break
        else:
          continue
        time.sleep(5)
    except Exception as e:
      sys.exit("[Error]" + str(e))