Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCE629A9AA
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Aug 2019 10:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389184AbfHWIHg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Aug 2019 04:07:36 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:43509 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731543AbfHWIHf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 23 Aug 2019 04:07:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TaC4xuu_1566547652;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TaC4xuu_1566547652)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 23 Aug 2019 16:07:33 +0800
Subject: Re: [RFC] performance regression with "ext4: Allow parallel DIO
 reads"
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Joseph Qi <jiangqi903@gmail.com>,
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
 <20190822054001.GT7777@dread.disaster.area>
 <f0eb766f-3c04-2a53-1669-4088e09d8f73@linux.alibaba.com>
Message-ID: <ce8f96c5-1404-736d-65c5-f91edeb74309@linux.alibaba.com>
Date:   Fri, 23 Aug 2019 16:07:32 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f0eb766f-3c04-2a53-1669-4088e09d8f73@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 19/8/23 15:57, Joseph Qi wrote:
> Hi Dave,
> 
> On 19/8/22 13:40, Dave Chinner wrote:
>> On Wed, Aug 21, 2019 at 09:04:57AM +0800, Joseph Qi wrote:
>>> Hi Ted，
>>>
>>> On 19/8/21 00:08, Theodore Y. Ts'o wrote:
>>>> On Tue, Aug 20, 2019 at 11:00:39AM +0800, Joseph Qi wrote:
>>>>>
>>>>> I've tested parallel dio reads with dioread_nolock, it doesn't have
>>>>> significant performance improvement and still poor compared with reverting
>>>>> parallel dio reads. IMO, this is because with parallel dio reads, it take
>>>>> inode shared lock at the very beginning in ext4_direct_IO_read().
>>>>
>>>> Why is that a problem?  It's a shared lock, so parallel threads should
>>>> be able to issue reads without getting serialized?
>>>>
>>> The above just tells the result that even mounting with dioread_nolock,
>>> parallel dio reads still has poor performance than before (w/o parallel
>>> dio reads).
>>>
>>>> Are you using sufficiently fast storage devices that you're worried
>>>> about cache line bouncing of the shared lock?  Or do you have some
>>>> other concern, such as some other thread taking an exclusive lock?
>>>>
>>> The test case is random read/write described in my first mail. And
>>
>> Regardless of dioread_nolock, ext4_direct_IO_read() is taking
>> inode_lock_shared() across the direct IO call.  And writes in ext4
>> _always_ take the inode_lock() in ext4_file_write_iter(), even
>> though it gets dropped quite early when overwrite && dioread_nolock
>> is set.  But just taking the lock exclusively in write fro a short
>> while is enough to kill all shared locking concurrency...
>>
>>> from my preliminary investigation, shared lock consumes more in such
>>> scenario.
>>
>> If the write lock is also shared, then there should not be a
>> scalability issue. The shared dio locking is only half-done in ext4,
>> so perhaps comparing your workload against XFS would be an
>> informative exercise... 
> 
> I've done the same test workload on xfs, it behaves the same as ext4
> after reverting parallel dio reads and mounting with dioread_lock.
A typo here, s/dioread_lock/dioread_nolock/

> Here is the test result:
> psync, randrw, direct=1, numofjobs=8
> 
> 4k:
> -----------------------------------------
> ext4 | READ 123450KB/s | WRITE 123368KB/s
> -----------------------------------------
> xfs  | READ 123848KB/s | WRITE 123761KB/s
> -----------------------------------------
> 
> 16k:
> -----------------------------------------
> ext4 | READ 222477KB/s | WRITE 222322KB/s
> -----------------------------------------
> xfs  | READ 223261KB/s | WRITE 223106KB/s
> -----------------------------------------
> 
> 64k:
> -----------------------------------------
> ext4 | READ 427406KB/s | WRITE 426197KB/s
> -----------------------------------------
> xfs  | READ 403697KB/s | WRITE 402555KB/s
> -----------------------------------------
> 
> 512k:
> -----------------------------------------
> ext4 | READ 618752KB/s | WRITE 619054KB/s
> -----------------------------------------
> xfs  | READ 614954KB/s | WRITE 615254KB/s
> -----------------------------------------
> 
> 1M:
> -----------------------------------------
> ext4 | READ 615011KB/s | WRITE 612255KB/s
> -----------------------------------------
> xfs  | READ 624087KB/s | WRITE 621290KB/s
> -----------------------------------------
> 
