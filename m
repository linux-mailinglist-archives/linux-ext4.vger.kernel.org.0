Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7BE775E5
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Jul 2019 04:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfG0CQH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 26 Jul 2019 22:16:07 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:37322 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726808AbfG0CQH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 26 Jul 2019 22:16:07 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TXsuqQZ_1564193760;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TXsuqQZ_1564193760)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 27 Jul 2019 10:16:00 +0800
Subject: Re: [RFC] performance regression with "ext4: Allow parallel DIO
 reads"
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Joseph Qi <jiangqi903@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Liu Bo <bo.liu@linux.alibaba.com>
References: <ab7cf51b-6b52-d151-e22c-6f4400a14589@linux.alibaba.com>
 <29d50d24-f8e7-5ef4-d4d8-3ea6fb1c6ed3@gmail.com>
 <6DADA28C-542F-45F6-ADB0-870A81ABED23@dilger.ca>
 <15112e38-94fe-39d6-a8e2-064ff47187d5@linux.alibaba.com>
 <A7FF6ED7-D480-4B01-A812-E100D595C515@dilger.ca>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <ee50ff90-6bed-d93c-863a-abdc7062cc74@linux.alibaba.com>
Date:   Sat, 27 Jul 2019 10:16:00 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <A7FF6ED7-D480-4B01-A812-E100D595C515@dilger.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 19/7/27 09:57, Andreas Dilger wrote:
> It would be useful to post some details about your test hardware
> (eg. HDD vs. SSD, CPU cores+speed, RAM), so that it is possible to make
> a good comparison of someone sees different results. 

Sure, as I posted before, it is on Intel P3600 NVMe SSD.
Other hardware information as below: 
CPU: Intel(R) Xeon(R) CPU E5-2682 v4 @ 2.50GHz * 64
MEM: 256G

In fact, it behaves the same on different machines. So I think it
has more to do with the test workload (concurrent rand read/write).

Thanks,
Joseph

> 
> Cheers, Andreas
> 
>> On Jul 25, 2019, at 19:12, Joseph Qi <joseph.qi@linux.alibaba.com> wrote:
>>
>>
>>
>>> On 19/7/26 05:20, Andreas Dilger wrote:
>>>
>>>> On Jul 23, 2019, at 5:17 AM, Joseph Qi <jiangqi903@gmail.com> wrote:
>>>>
>>>> Hi Ted & Jan,
>>>> Could you please give your valuable comments?
>>>
>>> It seems like the original patches should be reverted?  There is no data
>>
>> From my test result, yes.
>> I've also tested libaio with iodepth 16, it behaves the same. Here is the test
>> data for libaio 4k randrw:
>>
>> -------------------------------------------------------------------------------------------
>> w/ parallel dio reads | READ 78313KB/s, 19578, 1698.70us  | WRITE 78313KB/s, 19578, 4837.60us
>> -------------------------------------------------------------------------------------------
>> w/o parallel dio reads| READ 387774KB/s, 96943, 1009.73us | WRITE 387656KB/s，96914, 308.87us
>> -------------------------------------------------------------------------------------------
>>
>> Since this commit went into upstream long time ago，to be precise, Linux
>> 4.9, I wonder if someone else has also observed this regression, or
>> anything I missed?
>>
>> Thanks,
>> Joseph
>>
>>> in the original commit message that indicates there is an actual performance
>>> improvement from that patch, but there is data here showing it hurts both
>>> read and write performance quite significantly.
>>>> Cheers, Andreas
>>>
>>>>> On 19/7/19 17:22, Joseph Qi wrote:
>>>>> Hi Ted & Jan,
>>>>> I've observed an significant performance regression with the following
>>>>> commit in my Intel P3600 NVMe SSD.
>>>>> 16c54688592c ext4: Allow parallel DIO reads
>>>>>
>>>>> From my initial investigation, it may be because of the
>>>>> inode_lock_shared (down_read) consumes more than inode_lock (down_write)
>>>>> in mixed random read write workload.
>>>>>
>>>>> Here is my test result.
>>>>>
>>>>> ioengine=psync
>>>>> direct=1
>>>>> rw=randrw
>>>>> iodepth=1
>>>>> numjobs=8
>>>>> size=20G
>>>>> runtime=600
>>>>>
>>>>> w/ parallel dio reads : kernel 5.2.0
>>>>> w/o parallel dio reads: kernel 5.2.0, then revert the following commits:
>>>>> 1d39834fba99 ext4: remove EXT4_STATE_DIOREAD_LOCK flag (related)
>>>>> e5465795cac4 ext4: fix off-by-one error when writing back pages before dio read (related)
>>>>> 16c54688592c ext4: Allow parallel DIO reads
>>>>>
>>>>> bs=4k:
>>>>> -------------------------------------------------------------------------------------------
>>>>> w/ parallel dio reads | READ 30898KB/s, 7724, 555.00us   | WRITE 30875KB/s, 7718, 479.70us
>>>>> -------------------------------------------------------------------------------------------
>>>>> w/o parallel dio reads| READ 117915KB/s, 29478, 248.18us | WRITE 117854KB/s，29463, 21.91us
>>>>> -------------------------------------------------------------------------------------------
>>>>>
>>>>> bs=16k:
>>>>> -------------------------------------------------------------------------------------------
>>>>> w/ parallel dio reads | READ 58961KB/s, 3685, 835.28us   | WRITE 58877KB/s, 3679, 1335.98us
>>>>> -------------------------------------------------------------------------------------------
>>>>> w/o parallel dio reads| READ 218409KB/s, 13650, 554.46us | WRITE 218257KB/s，13641, 29.22us
>>>>> -------------------------------------------------------------------------------------------
>>>>>
>>>>> bs=64k:
>>>>> -------------------------------------------------------------------------------------------
>>>>> w/ parallel dio reads | READ 119396KB/s, 1865, 1759.38us | WRITE 119159KB/s, 1861, 2532.26us
>>>>> -------------------------------------------------------------------------------------------
>>>>> w/o parallel dio reads| READ 422815KB/s, 6606, 1146.05us | WRITE 421619KB/s, 6587, 60.72us
>>>>> -------------------------------------------------------------------------------------------
>>>>>
>>>>> bs=512k:
>>>>> -------------------------------------------------------------------------------------------
>>>>> w/ parallel dio reads | READ 392973KB/s, 767, 5046.35us  | WRITE 393165KB/s, 767, 5359.86us
>>>>> -------------------------------------------------------------------------------------------
>>>>> w/o parallel dio reads| READ 590266KB/s, 1152, 4312.01us | WRITE 590554KB/s, 1153, 2606.82us
>>>>> -------------------------------------------------------------------------------------------
>>>>>
>>>>> bs=1M:
>>>>> -------------------------------------------------------------------------------------------
>>>>> w/ parallel dio reads | READ 487779KB/s, 476, 8058.55us  | WRITE 485592KB/s, 474, 8630.51us
>>>>> -------------------------------------------------------------------------------------------
>>>>> w/o parallel dio reads| READ 593927KB/s, 580, 7623.63us  | WRITE 591265KB/s, 577, 6163.42us
>>>>> -------------------------------------------------------------------------------------------
>>>>>
>>>>> Thanks,
>>>>> Joseph
>>>>>
>>>
>>>
>>> Cheers, Andreas
>>>
>>>
>>>
>>>
>>>
