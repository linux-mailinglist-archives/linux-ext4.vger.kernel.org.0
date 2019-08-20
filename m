Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94891954B6
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2019 05:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbfHTDA6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Aug 2019 23:00:58 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:56720 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728719AbfHTDA6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 19 Aug 2019 23:00:58 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TZy2p6q_1566270039;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TZy2p6q_1566270039)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 20 Aug 2019 11:00:40 +0800
Subject: Re: [RFC] performance regression with "ext4: Allow parallel DIO
 reads"
To:     Jan Kara <jack@suse.cz>
Cc:     Joseph Qi <jiangqi903@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Liu Bo <bo.liu@linux.alibaba.com>
References: <ab7cf51b-6b52-d151-e22c-6f4400a14589@linux.alibaba.com>
 <29d50d24-f8e7-5ef4-d4d8-3ea6fb1c6ed3@gmail.com>
 <6DADA28C-542F-45F6-ADB0-870A81ABED23@dilger.ca>
 <15112e38-94fe-39d6-a8e2-064ff47187d5@linux.alibaba.com>
 <20190728225122.GG7777@dread.disaster.area>
 <960bb915-20cc-26a0-7abc-bfca01aa39c0@gmail.com>
 <20190815151336.GO14313@quack2.suse.cz>
 <075fd06f-b0b4-4122-81c6-e49200d5bd17@linux.alibaba.com>
 <20190816145719.GA3041@quack2.suse.cz>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <a8ddec64-d87c-ae7a-9b02-2f24da2396e9@linux.alibaba.com>
Date:   Tue, 20 Aug 2019 11:00:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816145719.GA3041@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Jan,

On 19/8/16 22:57, Jan Kara wrote:
> On Fri 16-08-19 21:23:24, Joseph Qi wrote:
>> On 19/8/15 23:13, Jan Kara wrote:
>>> On Tue 30-07-19 09:34:39, Joseph Qi wrote:
>>>> On 19/7/29 06:51, Dave Chinner wrote:
>>>>> On Fri, Jul 26, 2019 at 09:12:07AM +0800, Joseph Qi wrote:
>>>>>>
>>>>>>
>>>>>> On 19/7/26 05:20, Andreas Dilger wrote:
>>>>>>>
>>>>>>>> On Jul 23, 2019, at 5:17 AM, Joseph Qi <jiangqi903@gmail.com> wrote:
>>>>>>>>
>>>>>>>> Hi Ted & Jan,
>>>>>>>> Could you please give your valuable comments?
>>>>>>>
>>>>>>> It seems like the original patches should be reverted?  There is no data
>>>>>>
>>>>>> From my test result, yes.
>>>>>> I've also tested libaio with iodepth 16, it behaves the same. Here is the test
>>>>>> data for libaio 4k randrw:
>>>>>>
>>>>>> -------------------------------------------------------------------------------------------
>>>>>> w/ parallel dio reads | READ 78313KB/s, 19578, 1698.70us  | WRITE 78313KB/s, 19578, 4837.60us
>>>>>> -------------------------------------------------------------------------------------------
>>>>>> w/o parallel dio reads| READ 387774KB/s, 96943, 1009.73us | WRITE 387656KB/s，96914, 308.87us
>>>>>> -------------------------------------------------------------------------------------------
>>>>>>
>>>>>> Since this commit went into upstream long time ago，to be precise, Linux
>>>>>> 4.9, I wonder if someone else has also observed this regression, or
>>>>>> anything I missed?
>>>>>
>>>>> I suspect that the second part of this set of mods that Jan had
>>>>> planned to do (on the write side to use shared locking as well)
>>>>> did not happen and so the DIO writes are serialising the workload.
>>>>>
>>>>
>>>> Thanks for the inputs, Dave.
>>>> Hi Jan, Could you please confirm this?
>>>> If so, should we revert this commit at present?
>>>
>>> Sorry for getting to you only now. I was on vacation and then catching up
>>> with various stuff. I suppose you are not using dioread_nolock mount
>>> option, are you? Can you check what are your results with that mount
>>> option?
>>>
>> Yes, I've just used default mount options when testing. And it is indeed
>> that there is performance improvement with dioread_nolock after reverting
>> the 3 related commits.
>> I'll do a supplementary test with parallel dio reads as well as
>> dioread_nolock and send out the test result.

I've tested parallel dio reads with dioread_nolock, it doesn't have
significant performance improvement and still poor compared with reverting
parallel dio reads. IMO, this is because with parallel dio reads, it take
inode shared lock at the very beginning in ext4_direct_IO_read().

Thanks,
Joseph
