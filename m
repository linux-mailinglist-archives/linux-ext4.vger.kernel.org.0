Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E878D96EA5
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Aug 2019 03:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfHUBFC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 20 Aug 2019 21:05:02 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:35919 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726215AbfHUBFC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 20 Aug 2019 21:05:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Ta0LkxB_1566349497;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Ta0LkxB_1566349497)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 21 Aug 2019 09:04:57 +0800
Subject: Re: [RFC] performance regression with "ext4: Allow parallel DIO
 reads"
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, Joseph Qi <jiangqi903@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Andreas Dilger <adilger@dilger.ca>,
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
 <a8ddec64-d87c-ae7a-9b02-2f24da2396e9@linux.alibaba.com>
 <20190820160805.GB10232@mit.edu>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <f89131c9-6f84-ac3c-b53c-d3d55887ea89@linux.alibaba.com>
Date:   Wed, 21 Aug 2019 09:04:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820160805.GB10232@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted，

On 19/8/21 00:08, Theodore Y. Ts'o wrote:
> On Tue, Aug 20, 2019 at 11:00:39AM +0800, Joseph Qi wrote:
>>
>> I've tested parallel dio reads with dioread_nolock, it doesn't have
>> significant performance improvement and still poor compared with reverting
>> parallel dio reads. IMO, this is because with parallel dio reads, it take
>> inode shared lock at the very beginning in ext4_direct_IO_read().
> 
> Why is that a problem?  It's a shared lock, so parallel threads should
> be able to issue reads without getting serialized?
> 
The above just tells the result that even mounting with dioread_nolock,
parallel dio reads still has poor performance than before (w/o parallel
dio reads).

> Are you using sufficiently fast storage devices that you're worried
> about cache line bouncing of the shared lock?  Or do you have some
> other concern, such as some other thread taking an exclusive lock?
> 
The test case is random read/write described in my first mail. And
from my preliminary investigation, shared lock consumes more in such
scenario.

Thanks,
Joseph 
