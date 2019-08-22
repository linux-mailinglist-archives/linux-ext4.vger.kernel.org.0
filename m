Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AADD398B87
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2019 08:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731653AbfHVGp1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Aug 2019 02:45:27 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:60338 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730856AbfHVGp1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 22 Aug 2019 02:45:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Ta74xR2_1566456323;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Ta74xR2_1566456323)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 22 Aug 2019 14:45:23 +0800
Subject: Re: [RFC] performance regression with "ext4: Allow parallel DIO
 reads"
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, Joseph Qi <jiangqi903@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Liu Bo <bo.liu@linux.alibaba.com>
References: <6DADA28C-542F-45F6-ADB0-870A81ABED23@dilger.ca>
 <15112e38-94fe-39d6-a8e2-064ff47187d5@linux.alibaba.com>
 <20190728225122.GG7777@dread.disaster.area>
 <960bb915-20cc-26a0-7abc-bfca01aa39c0@gmail.com>
 <20190815151336.GO14313@quack2.suse.cz>
 <075fd06f-b0b4-4122-81c6-e49200d5bd17@linux.alibaba.com>
 <20190816145719.GA3041@quack2.suse.cz>
 <a8ddec64-d87c-ae7a-9b02-2f24da2396e9@linux.alibaba.com>
 <20190820160805.GB10232@mit.edu>
 <f89131c9-6f84-ac3c-b53c-d3d55887ea89@linux.alibaba.com>
 <20190821033443.GI10232@mit.edu>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <4e3606cf-34ae-6989-404a-de67324a4919@linux.alibaba.com>
Date:   Thu, 22 Aug 2019 14:45:23 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821033443.GI10232@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 19/8/21 11:34, Theodore Y. Ts'o wrote:
> On Wed, Aug 21, 2019 at 09:04:57AM +0800, Joseph Qi wrote:
>> On 19/8/21 00:08, Theodore Y. Ts'o wrote:
>>> On Tue, Aug 20, 2019 at 11:00:39AM +0800, Joseph Qi wrote:
>>>>
>>>> I've tested parallel dio reads with dioread_nolock, it doesn't have
>>>> significant performance improvement and still poor compared with reverting
>>>> parallel dio reads. IMO, this is because with parallel dio reads, it take
>>>> inode shared lock at the very beginning in ext4_direct_IO_read().
>>>
>>> Why is that a problem?  It's a shared lock, so parallel threads should
>>> be able to issue reads without getting serialized?
>>>
>> The above just tells the result that even mounting with dioread_nolock,
>> parallel dio reads still has poor performance than before (w/o parallel
>> dio reads).
> 
> Right, but you were asserting that performance hit was *because* of
> the shared lock.  I'm asking what leading you to have that opinion.
> The fact that parallel dioread reads doesn't necessarily say that it
> was because of that particular shared lock.  It could be due to any
> number of other things.  Have you looked at /proc/lock_stat (enabeld
> via CONFIG_LOCK_STAT) to see where the locking bottlenecks might be?
> 
I've enabled CONFIG_LOCK_STAT and CONFIG_DEBUG_RWSEMS, but doesn't see
any statistics for i_rwsem. Am I missing something?

Thanks,
Joseph
