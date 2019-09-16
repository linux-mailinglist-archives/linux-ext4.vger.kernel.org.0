Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C82B6B3C71
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2019 16:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388541AbfIPOU6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Sep 2019 10:20:58 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:45538 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388421AbfIPOU5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 16 Sep 2019 10:20:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0TcWjSlV_1568643654;
Received: from 30.8.168.199(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0TcWjSlV_1568643654)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 16 Sep 2019 22:20:55 +0800
Subject: Re: [PATCH 1/2] jbd2: add new tracepoint jbd2_sleep_on_shadow
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
References: <20190902145442.1921-1-xiaoguang.wang@linux.alibaba.com>
 <20190907162145.GC23683@mit.edu>
 <5d96e18f-9610-208f-6db3-6a7b6a112400@linux.alibaba.com>
 <20190911135707.GC2740@mit.edu>
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Message-ID: <7afa6bc5-71c1-ba8e-5d0b-ea3afc02cd84@linux.alibaba.com>
Date:   Mon, 16 Sep 2019 22:20:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190911135707.GC2740@mit.edu>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

hi,

> On Wed, Sep 11, 2019 at 02:52:51PM +0800, Xiaoguang Wang wrote:
>>> I think maybe it might be better to use units of microseconds and then
>>> change sleep to usleep so the units are clear?  This is a spinlock, so
>>> it should be quick.
>>
>> Sorry, I may not quite understand you, do you mean that milliseconds is not precise, so
>> should use microseconds? For these two patches, they do not use usleep or msleep to do
>> real sleep work, they just record the duration which process takes to wait bh_shadow flag
>> to be cleared or transaction to be unlocked.
> 
> Apologies, I should have been clear enough.  Yes, my concern that
> milliseconds might not be fine-grained enough.  The sample results
> which you showed had values of 2ms, 1ms, and 0ms.  And the single 0ms
> result in particular raised the concern that we should use a
> microseconds instead of milliseconds.
> 
> In fact, instead of "sleep", maybe "latency(us)" or "latency(ms)"
> would be a better label?
OK, I'll update a v2, thanks.

Regards,
Xiaoguang Wang

> 
> Regards,
> 
> 						- Ted
> 
