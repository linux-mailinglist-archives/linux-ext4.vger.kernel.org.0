Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D84CAAF62A
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Sep 2019 08:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfIKGxB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Sep 2019 02:53:01 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:59326 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726390AbfIKGxB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 11 Sep 2019 02:53:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Tc2lZS6_1568184771;
Received: from 30.5.113.40(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0Tc2lZS6_1568184771)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 11 Sep 2019 14:52:51 +0800
Subject: Re: [PATCH 1/2] jbd2: add new tracepoint jbd2_sleep_on_shadow
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
References: <20190902145442.1921-1-xiaoguang.wang@linux.alibaba.com>
 <20190907162145.GC23683@mit.edu>
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Message-ID: <5d96e18f-9610-208f-6db3-6a7b6a112400@linux.alibaba.com>
Date:   Wed, 11 Sep 2019 14:52:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190907162145.GC23683@mit.edu>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

hi,

Thanks for reviewing.
> On Mon, Sep 02, 2019 at 10:54:41PM +0800, Xiaoguang Wang wrote:
>> Sometimes process will be stalled in "wait_on_bit_io(&bh->b_state,
>> BH_Shadow, TASK_UNINTERRUPTIBLE)" for a while, and in order to analyse
>> app's latency thoroughly, add a new tracepoint to track this delay.
>>
>> Trace info likes below:
>> fsstress-5068  [008] .... 11007.757543: jbd2_sleep_on_shadow: dev 254,17 sleep 1
>> fsstress-5070  [007] .... 11007.757544: jbd2_sleep_on_shadow: dev 254,17 sleep 2
>> fsstress-5069  [009] .... 11007.757548: jbd2_sleep_on_shadow: dev 254,17 sleep 2
>> fsstress-5067  [011] .... 11007.757569: jbd2_sleep_on_shadow: dev 254,17 sleep 1
>> fsstress-5063  [007] .... 11007.757651: jbd2_sleep_on_shadow: dev 254,17 sleep 2
>> fsstress-5070  [007] .... 11007.757792: jbd2_sleep_on_shadow: dev 254,17 sleep 0
>> fsstress-5071  [011] .... 11007.763493: jbd2_sleep_on_shadow: dev 254,17 sleep 1
>>
>> Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
> 
> I think maybe it might be better to use units of microseconds and then
> change sleep to usleep so the units are clear?  This is a spinlock, so
> it should be quick.
Sorry, I may not quite understand you, do you mean that milliseconds is not precise, so
should use microseconds? For these two patches, they do not use usleep or msleep to do
real sleep work, they just record the duration which process takes to wait bh_shadow flag
to be cleared or transaction to be unlocked.

Regards,
Xiaougang Wang

> 
> For the other patch in this series, milliseconds seems fine, but if we
> change the trace info to use "msleep" instead that would be clearer
> --- or you could change it to use microseconds as well just for
> consistency; I think either would be fine.
> 
> What do you think?
> 
> Cheers,
> 
> 						- Ted
> 
