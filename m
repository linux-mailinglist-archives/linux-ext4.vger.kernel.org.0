Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A051DF421A
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Nov 2019 09:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKHIbC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Nov 2019 03:31:02 -0500
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:44260 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726072AbfKHIbC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 Nov 2019 03:31:02 -0500
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 53DBF2E14A2;
        Fri,  8 Nov 2019 11:30:58 +0300 (MSK)
Received: from vla5-2bf13a090f43.qloud-c.yandex.net (vla5-2bf13a090f43.qloud-c.yandex.net [2a02:6b8:c18:3411:0:640:2bf1:3a09])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id rxIew9xOSF-UvMSX8ne;
        Fri, 08 Nov 2019 11:30:58 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1573201858; bh=Hp4ev14l2Lhx6iEHLcG1z7KhXz+b83W67JPYeP/4FDw=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=sG5lBWVzvm6JiVDH6m8flzUp/gHVxPkazSVwFHZfeNhrICYDxZ6aQr+o4vh+At1ek
         0RoB71VfYbbtZSlNX2nygKdkdyIGJ9uJY5xiJZKOKSzbs7Kx4V4vMGvgL0EntDfRZ4
         J9oqWO96TQLG5yf6UI0ENF0vepeGhHzglZ4EJEPg=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8554:53c0:3d75:2e8a])
        by vla5-2bf13a090f43.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id Nq2nXa0706-UvVa8ZLj;
        Fri, 08 Nov 2019 11:30:57 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] ext4: deaccount delayed allocations at freeing inode in
 ext4_evict_inode()
To:     Ritesh Harjani <riteshh@linux.ibm.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        Eric Whitney <enwlinux@gmail.com>
References: <157233344808.4027.17162642259754563372.stgit@buzz>
 <20191108020827.15D1EAE056@d06av26.portsmouth.uk.ibm.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <d00c572b-66ae-42dc-746a-e2c365c9895a@yandex-team.ru>
Date:   Fri, 8 Nov 2019 11:30:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191108020827.15D1EAE056@d06av26.portsmouth.uk.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 08/11/2019 05.08, Ritesh Harjani wrote:
> 
> 
> On 10/29/19 12:47 PM, Konstantin Khlebnikov wrote:
>> If inode->i_blocks is zero then ext4_evict_inode() skips ext4_truncate().
>> Delayed allocation extents are freed later in ext4_clear_inode() but this
>> happens when quota reference is already dropped. This leads to leak of
>> reserved space in quota block, which disappears after umount-mount.
>>
>> This seems broken for a long time but worked somehow until recent changes
>> in delayed allocation.
> 
> Sorry, I may have missed it, but could you please help understand
> what recent changes in delayed allocation make this break or worse?

I don't see problem for 4.19. Haven't bisected yet.
Most likely this is around 'reserved cluster accounting'.

I suspect before these changes something always triggered da before unlink and
space usage committed and then truncated at eviction.

> 
> 
> A silly query, since I couldn't figure it out. Maybe the code has been
> there ever since like this:-

> So why can't we just move drop_dquot later after the ext4_es_remove_extent() (in function ext4_clear_inode)? Any known
> problems around that?

Clear_inode is called also when inode evicts from cache while it has nlinks
and stays at disk. I'm not sure how this must interact with reserves.

> 
> -ritesh
> 
> 
>>
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> ---
>>   fs/ext4/inode.c |    9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 516faa280ced..580898145e8f 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -293,6 +293,15 @@ void ext4_evict_inode(struct inode *inode)
>>                      inode->i_ino, err);
>>               goto stop_handle;
>>           }
>> +    } else if (EXT4_I(inode)->i_reserved_data_blocks) {
>> +        /* Deaccount reserve if inode has only delayed allocations. */
>> +        err = ext4_es_remove_extent(inode, 0, EXT_MAX_BLOCKS);
>> +        if (err) {
>> +            ext4_warning(inode->i_sb,
>> +                     "couldn't remove extents %lu (err %d)",
>> +                     inode->i_ino, err);
>> +            goto stop_handle;
>> +        }
>>       }
>>
>>       /* Remove xattr references. */
>>
> 
