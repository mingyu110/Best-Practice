#!/usr/bin/env python
#coding=utf-8

import os, sys, getopt, time, json, urllib, yaml
from mns.account import Account
from mns.topic import *

class Refresh(object):

  '''init func'''

  def __init__(self):

   self.lists = []
   self.config = {}
   self.config_file = './config.yaml'

  def main(self,argv):
    with open(self.config_file, 'rb') as f:
      self.config = yaml.safe_load(f)
    
    try:
      client = Account(self.config['mns_topic_url'], self.config['access_id'], self.config['access_secret'], '')
      topic = client.get_topic(self.config['mns_topic_name'])
    except NameError:
      sys.exit("[Error]: SDK module not detected")

    for g in self.doProd():
      self.lists = []
      self.doPushToMNS(''.join(g),self.config['type'],topic)
  
  '''
  描述：生成器切分文件，对每行文件进行处理 '\n'
  gop：每次读取 URL 数量
  '''
  def doProd(self):
    gop = self.config['batch_size']
    mins = 1
    maxs = gop

    with open(self.config['url_file'], "r") as f:
      for line in f.readlines():
        line = line.strip("\n")
        line = urllib.parse.quote(line, safe='/:+') + "\n"
        self.lists.append(line)

        if mins >= maxs:
         yield self.lists
         mins = maxs
         maxs = gop + maxs -1
        else:
         mins += 1
      if len(self.lists) > 0: yield self.lists
       
  '''
  描述：将消息推送到mns队列，准备处理
  '''
  def doPushToMNS(self,urls,types,topic):
        msg = {
            'urls': urls,
            'type': types,
            'area': self.config['area'] if self.config['area'] else 'domestic',
            'objectType': self.config['area'] if self.config['object_type'] else 'File'
        }
        msg_body = json.dumps(msg)
        mns_msg = TopicMessage(msg_body)
        try:
            send_msg = topic.publish_message(mns_msg)
            sys.stdout.write("Send Message Succeed.\nMessageId:%s\n" % (send_msg.message_id))
        except MNSExceptionBase as e:
            sys.stderr.write("Send Message Failed!\nException:%s\n\n" % e)

#TODO 入口

if __name__ == '__main__':
  fun = Refresh()
  fun.main(sys.argv[1:])