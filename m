Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0CF3F3F70
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Aug 2021 15:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhHVNPC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 22 Aug 2021 09:15:02 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:49029 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230495AbhHVNPB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 22 Aug 2021 09:15:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Ul-h5c8_1629638058;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Ul-h5c8_1629638058)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 22 Aug 2021 21:14:19 +0800
Subject: Re: [PATCH] ext4: fix reserved space counter leakage
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
To:     Eric Whitney <enwlinux@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
References: <20210819091351.19297-1-jefflexu@linux.alibaba.com>
 <20210820164556.GA30851@localhost.localdomain>
 <c7a95109-e468-cd25-1042-20e0779a87d4@linux.alibaba.com>
Message-ID: <e33bc4a3-4378-364e-c834-8bb479872fa4@linux.alibaba.com>
Date:   Sun, 22 Aug 2021 21:14:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <c7a95109-e468-cd25-1042-20e0779a87d4@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 8/22/21 9:06 PM, Joseph Qi wrote:
> 
> 
> On 8/21/21 12:45 AM, Eric Whitney wrote:
>> * Jeffle Xu <jefflexu@linux.alibaba.com>:
>>> When ext4_es_insert_delayed_block() returns error, e.g., ENOMEM,
>>> previously reserved space is not released as the error handling,
>>> in which case @s_dirtyclusters_counter is left over. Since this delayed
>>> extent failes to be inserted into extent status tree, when inode is
>>> written back, the extra @s_dirtyclusters_counter won't be subtracted and
>>> remains there forever.
>>>
>>> This can leads to /sys/fs/ext4/<dev>/delayed_allocation_blocks remains
>>> non-zero even when syncfs is executed on the filesystem.
>>>
>>
>> Hi:
>>
>> I think the fix below looks fine.  However, this comment doesn't look right
>> to me.  Are you really seeing delayed_allocation_blocks values that remain
>> incorrectly elevated across last closes (or across file system unmounts and
>> remounts)?  s_dirtyclusters_counter isn't written out to stable storage -
>> it's an in-memory only variable that's created when a file is first opened
>> and destroyed on last close.
>>
> 
> Actually we've encountered a real case in our production environment,
> which has about 20G space lost (df - du = ~20G).
> After some investigation, we've confirmed that it cause by leaked
> s_dirtyclusters_counter (~5M), and even we do manually sync, it remains.
> Since there is no error messages, we've checked all logic around
> s_dirtyclusters_counter and found this. Also we can manually inject
> error and reproduce the leaked s_dirtyclusters_counter.
> 

BTW, it's a runtime lost, but not about on-disk.
If umount and then mount it again, it becomes normal. But
application also should be restarted...

Thanks,
Joseph
