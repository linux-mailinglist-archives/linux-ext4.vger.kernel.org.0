Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 922E79DAE0
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2019 03:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfH0BAZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Aug 2019 21:00:25 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:55969 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728036AbfH0BAZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 26 Aug 2019 21:00:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TaZ2tmY_1566867620;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TaZ2tmY_1566867620)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 27 Aug 2019 09:00:21 +0800
Subject: Re: [RFC] performance regression with "ext4: Allow parallel DIO
 reads"
To:     Andreas Dilger <adilger@dilger.ca>, Jan Kara <jack@suse.cz>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Joseph Qi <jiangqi903@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Liu Bo <bo.liu@linux.alibaba.com>
References: <075fd06f-b0b4-4122-81c6-e49200d5bd17@linux.alibaba.com>
 <20190816145719.GA3041@quack2.suse.cz>
 <a8ddec64-d87c-ae7a-9b02-2f24da2396e9@linux.alibaba.com>
 <20190820160805.GB10232@mit.edu>
 <f89131c9-6f84-ac3c-b53c-d3d55887ea89@linux.alibaba.com>
 <20190822054001.GT7777@dread.disaster.area>
 <f0eb766f-3c04-2a53-1669-4088e09d8f73@linux.alibaba.com>
 <20190823101623.GV7777@dread.disaster.area>
 <707b1a60-00f0-847e-02f9-e63d20eab47e@linux.alibaba.com>
 <20190824021840.GW7777@dread.disaster.area>
 <20190826083958.GA10614@quack2.suse.cz>
 <94515D9C-045C-46EA-9F3C-E13CB2DAA1F9@dilger.ca>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <a5c6b0cc-60d1-eac2-65a5-b40998c28de9@linux.alibaba.com>
Date:   Tue, 27 Aug 2019 09:00:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <94515D9C-045C-46EA-9F3C-E13CB2DAA1F9@dilger.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 19/8/27 03:10, Andreas Dilger wrote:
> On Aug 26, 2019, at 2:39 AM, Jan Kara <jack@suse.cz> wrote:
>>
>> On Sat 24-08-19 12:18:40, Dave Chinner wrote:
>>> On Fri, Aug 23, 2019 at 09:08:53PM +0800, Joseph Qi wrote:
>>>>
>>>>
>>>> On 19/8/23 18:16, Dave Chinner wrote:
>>>>> On Fri, Aug 23, 2019 at 03:57:02PM +0800, Joseph Qi wrote:
>>>>>> Hi Dave,
>>>>>>
>>>>>> On 19/8/22 13:40, Dave Chinner wrote:
>>>>>>> On Wed, Aug 21, 2019 at 09:04:57AM +0800, Joseph Qi wrote:
>>>>>>>> Hi Ted，
>>>>>>>>
>>>>>>>> On 19/8/21 00:08, Theodore Y. Ts'o wrote:
>>>>>>>>> On Tue, Aug 20, 2019 at 11:00:39AM +0800, Joseph Qi wrote:
>>>>>>>>>>
>>>>>>>>>> I've tested parallel dio reads with dioread_nolock, it
>>>>>>>>>> doesn't have significant performance improvement and still
>>>>>>>>>> poor compared with reverting parallel dio reads. IMO, this
>>>>>>>>>> is because with parallel dio reads, it take inode shared
>>>>>>>>>> lock at the very beginning in ext4_direct_IO_read().
>>>>>>>>>
>>>>>>>>> Why is that a problem?  It's a shared lock, so parallel
>>>>>>>>> threads should be able to issue reads without getting
>>>>>>>>> serialized?
>>>>>>>>>
>>>>>>>> The above just tells the result that even mounting with
>>>>>>>> dioread_nolock, parallel dio reads still has poor performance
>>>>>>>> than before (w/o parallel dio reads).
>>>>>>>>
>>>>>>>>> Are you using sufficiently fast storage devices that you're
>>>>>>>>> worried about cache line bouncing of the shared lock?  Or do
>>>>>>>>> you have some other concern, such as some other thread
>>>>>>>>> taking an exclusive lock?
>>>>>>>>>
>>>>>>>> The test case is random read/write described in my first
>>>>>>>> mail. And
>>>>>>>
>>>>>>> Regardless of dioread_nolock, ext4_direct_IO_read() is taking
>>>>>>> inode_lock_shared() across the direct IO call.  And writes in
>>>>>>> ext4 _always_ take the inode_lock() in ext4_file_write_iter(),
>>>>>>> even though it gets dropped quite early when overwrite &&
>>>>>>> dioread_nolock is set.  But just taking the lock exclusively
>>>>>>> in write fro a short while is enough to kill all shared
>>>>>>> locking concurrency...
>>>>>>>
>>>>>>>> from my preliminary investigation, shared lock consumes more
>>>>>>>> in such scenario.
>>>>>>>
>>>>>>> If the write lock is also shared, then there should not be a
>>>>>>> scalability issue. The shared dio locking is only half-done in
>>>>>>> ext4, so perhaps comparing your workload against XFS would be
>>>>>>> an informative exercise...
>>>>>>
>>>>>> I've done the same test workload on xfs, it behaves the same as
>>>>>> ext4 after reverting parallel dio reads and mounting with
>>>>>> dioread_lock.
>>>>>
>>>>> Ok, so the problem is not shared locking scalability ('cause
>>>>> that's what XFS does and it scaled fine), the problem is almost
>>>>> certainly that ext4 is using exclusive locking during
>>>>> writes...
>>>>>
>>>>
>>>> Agree. Maybe I've misled you in my previous mails.I meant shared
>>>> lock makes worse in case of mixed random read/write, since we
>>>> would always take inode lock during write.  And it also conflicts
>>>> with dioread_nolock. It won't take any inode lock before with
>>>> dioread_nolock during read, but now it always takes a shared
>>>> lock.
>>>
>>> No, you didn't mislead me. IIUC, the shared locking was added to the
>>> direct IO read path so that it can't run concurrently with
>>> operations like hole punch that free the blocks the dio read might
>>> currently be operating on (use after free).
>>>
>>> i.e. the shared locking fixes an actual bug, but the performance
>>> regression is a result of only partially converting the direct IO
>>> path to use shared locking. Only half the job was done from a
>>> performance perspective. Seems to me that the two options here to
>>> fix the performance regression are to either finish the shared
>>> locking conversion, or remove the shared locking on read and re-open
>>> a potential data exposure issue...
>>
>> We actually had a separate locking mechanism in ext4 code to avoid stale
>> data exposure during hole punch when unlocked DIO reads were running. But
>> it was kind of ugly and making things complex. I agree we need to move ext4
>> DIO path conversion further to avoid taking exclusive lock when we won't
>> actually need it.
> 
> It seems to me that the right solution for the short term is to revert
> the patch in question, since that appears to be incomplete, and reverting
> it will restore the performance.  I haven't seen any comments posted with
> a counter-example that the original patch actually improved performance,
> or that reverting it will cause some other performance regression.
> 
> We can then leave implementing a more complete solution to a later kernel.
> 
Thanks for the discussion.
So if no one else objects reverting parallel dio reads at present, I'll
send out the revert patches.

Thanks,
Joseph


