Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6BABD608
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Sep 2019 03:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390813AbfIYBR0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Sep 2019 21:17:26 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:50661 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389624AbfIYBR0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 24 Sep 2019 21:17:26 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TdLt5SR_1569374242;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TdLt5SR_1569374242)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 Sep 2019 09:17:23 +0800
Subject: Re: [RFC 0/2] ext4: Improve locking sequence in DIO write path
To:     Jan Kara <jack@suse.cz>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>, tytso@mit.edu,
        linux-ext4@vger.kernel.org, david@fromorbit.com, hch@infradead.org,
        adilger@dilger.ca, mbobrowski@mbobrowski.org, rgoldwyn@suse.de
References: <20190917103249.20335-1-riteshh@linux.ibm.com>
 <d1f3b048-d21c-67f1-09a3-dd2abf7c156d@linux.alibaba.com>
 <20190924151025.GD11819@quack2.suse.cz>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <dc63d1cc-b6ae-7a6d-d932-9f36e0ca29bd@linux.alibaba.com>
Date:   Wed, 25 Sep 2019 09:17:22 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190924151025.GD11819@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 19/9/24 23:10, Jan Kara wrote:
> Hi Joseph!
> 
> On Wed 18-09-19 14:35:15, Joseph Qi wrote:
>> On 19/9/17 18:32, Ritesh Harjani wrote:
>>> Hello,
>>>
>>> This patch series is based on the upstream discussion with Jan
>>> & Joseph @ [1].
>>> It is based on top of Matthew's v3 ext4 iomap patch series [2]
>>>
>>> Patch-1: Adds the ext4_ilock/unlock APIs and also replaces all
>>> inode_lock/unlock instances from fs/ext4/*
>>>
>>> For now I already accounted for trylock/lock issue symantics
>>> (which was discussed here [3]) in the same patch,
>>> since the this whole patch was around inode_lock/unlock API,
>>> so I thought it will be best to address that issue in the same patch. 
>>> However, kindly let me know if otherwise.
>>>
>>> Patch-2: Commit msg of this patch describes in detail about
>>> what it is doing.
>>> In brief - we try to first take the shared lock (instead of exclusive
>>> lock), unless it is a unaligned_io or extend_io. Then in
>>> ext4_dio_write_checks(), if we start with shared lock, we see
>>> if we can really continue with shared lock or not. If not, then
>>> we release the shared lock then acquire exclusive lock
>>> and restart ext4_dio_write_checks().
>>>
>>>
>>> Tested against few xfstests (with dioread_nolock mount option),
>>> those ran fine (ext4 & generic).
>>>
>>> I tried testing performance numbers on my VM (since I could not get
>>> hold of any real h/w based test device). I could test the fact
>>> that earlier we were trying to do downgrade_write() lock, but with
>>> this patch, that path is now avoided for fio test case
>>> (as reported by Joseph in [4]).
>>> But for the actual results, I am not sure if VM machine testing could
>>> really give the reliable perf numbers which we want to take a look at.
>>> Though I do observe some form of perf improvements, but I could not
>>> get any reliable numbers (not even with the same list of with/without
>>> patches with which Joseph posted his numbers [1]).
>>>
>>>
>>> @Joseph,
>>> Would it be possible for you to give your test case a run with this
>>> patches? That will be really helpful.
>>>
>>> Branch for this is hosted at below tree.
>>>
>>> https://github.com/riteshharjani/linux/tree/ext4-ilock-RFC
>>>
>> I've tested your branch, the result is:
>> mounting with dioread_nolock, it behaves the same like reverting
>> parallel dio reads + dioread_nolock;
>> while mounting without dioread_nolock, no improvement, or even worse.
>> Please refer the test data below. 
>>
>> fio -name=parallel_dio_reads_test -filename=/mnt/nvme0n1/testfile
>> -direct=1 -iodepth=1 -thread -rw=randrw -ioengine=psync -bs=$bs
>> -size=20G -numjobs=8 -runtime=600 -group_reporting
>>
>> w/     = with parallel dio reads
>> w/o    = reverting parallel dio reads
> 
> This is with 16c54688592ce8 "ext4: Allow parallel DIO reads" reverted,
> right?

Yes, actually, it also reverts the related patches:

Revert "ext4: remove EXT4_STATE_DIOREAD_LOCK flag"
Revert "ext4: fix off-by-one error when writing back pages before dio read"
Revert "ext4: Allow parallel DIO reads"

> 
>> w/o+   = reverting parallel dio reads + dioread_nolock
>> ilock  = ext4-ilock-RFC
>> ilock+ = ext4-ilock-RFC + dioread_nolock
>>
>> bs=4k:
>> --------------------------------------------------------------
>>       |            READ           |           WRITE          |
>> --------------------------------------------------------------
>> w/    | 30898KB/s,7724,555.00us   | 30875KB/s,7718,479.70us  |
>> --------------------------------------------------------------
>> w/o   | 117915KB/s,29478,248.18us | 117854KB/s,29463,21.91us |
>> --------------------------------------------------------------
> 
> I'm really surprised by the numbers here. They would mean that when DIO
> read takes i_rwsem exclusive lock instead of shared, it is a win for your
> workload... Argh, now checking code in fs/direct-io.c I think I can see the
> difference. The trick in do_blockdev_direct_IO() is:
> 
>         if (iov_iter_rw(iter) == READ && (dio->flags & DIO_LOCKING))
>                 inode_unlock(dio->inode);
>         if (dio->is_async && retval == 0 && dio->result &&
>             (iov_iter_rw(iter) == READ || dio->result == count))
>                 retval = -EIOCBQUEUED;
>         else
>                 dio_await_completion(dio);
> 
> So actually only direct IO read submission is protected by i_rwsem with
> DIO_LOCKING. Actual waiting for sync DIO read happens with i_rwsem dropped.
> 
> After some thought I think the best solution for this is to just finally
> finish the conversion of ext4 so that dioread_nolock is the only DIO path.
> With i_rwsem held in shared mode even for "unlocked" DIO, it should be
> actually relatively simple and most of the dances with unwritten extents
> shouldn't be needed anymore.
> 
> 								Honza
> 
