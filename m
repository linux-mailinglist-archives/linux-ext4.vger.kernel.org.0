Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC9DAD250
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Sep 2019 05:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733264AbfIIDkk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 8 Sep 2019 23:40:40 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:47312 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726491AbfIIDkk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 8 Sep 2019 23:40:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0TboV8Zd_1568000434;
Received: from 30.5.113.70(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0TboV8Zd_1568000434)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 09 Sep 2019 11:40:35 +0800
Subject: Re: [PATCH] ext4: disable mount with both dioread_nolock and
 nodelalloc
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
References: <20190731130600.7867-1-xiaoguang.wang@linux.alibaba.com>
 <20190907160004.GB23683@mit.edu>
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Message-ID: <fb03f569-6b38-9a85-3828-f814a5aec313@linux.alibaba.com>
Date:   Mon, 9 Sep 2019 11:40:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190907160004.GB23683@mit.edu>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

hi,

> On Wed, Jul 31, 2019 at 09:06:00PM +0800, Xiaoguang Wang wrote:
>> Mount with both dioread_nolock and nodelalloc will result in huge
>> performance drop, which indeed is an known issue, so before we fix
>> this issue, currently we disable this behaviour. Below test reproducer
>> can reveal this performance drop.
> 
> Is it really worth it to disable this combination?  Nothing goes
> *wrong* per se; it's just slower than we would like.
Yes, agree, then should we have some places to record this issue? In case
somebody looks into it again.

Regards,
Xiaoguang Wang

> 
> 	    	     	  	      	 - Ted
> 
