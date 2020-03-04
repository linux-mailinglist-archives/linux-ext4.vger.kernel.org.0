Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDDF179190
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Mar 2020 14:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbgCDNlA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Mar 2020 08:41:00 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:38719 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728278AbgCDNlA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Mar 2020 08:41:00 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TreKNo._1583329254;
Received: from 30.0.153.8(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0TreKNo._1583329254)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 Mar 2020 21:40:54 +0800
Subject: Re: [PATCH] ext4: start to support iopoll method
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz,
        joseph qi <joseph.qi@linux.alibaba.com>
References: <20200207120758.2411-1-xiaoguang.wang@linux.alibaba.com>
 <c535d8f5-e746-30dc-f3e8-aeed04fcb5b8@linux.alibaba.com>
 <20200302191604.GD6826@mit.edu>
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Message-ID: <22af3309-cccf-57a8-af35-32c9e5fa06ca@linux.alibaba.com>
Date:   Wed, 4 Mar 2020 21:40:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302191604.GD6826@mit.edu>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

hi,

Sorry for being late.
> On Mon, Mar 02, 2020 at 05:17:09PM +0800, Xiaoguang Wang wrote:
>> hi,
>>
>> Ted, could you please consider applying this patch? Iouring polling
>> tests in ext4 needs this patch, Jan Kara has nicely reviewed this patch, thanks.
> 
> Yeah, I had been waiting to make sure the fix: "io_uring: fix
> poll_list race for SETUP_IOPOLL|SETUP_SQPOLL" was going to land.
I confirmed that it had been merged into mainline.

> 
> Am I correct that the bug fixed in the above fix isn't going to impact
> xfstests (since it looks like there are no fio runs with the io_uring
> engine at the moment)?
Yes, I have run xfstests with "-g auto", with or without this patch, there always
are six same failed test cases, so I think it won't impact current xfstests, thanks.

Regards,
Xiaoguang Wang
> 
> 						- Ted
> 
