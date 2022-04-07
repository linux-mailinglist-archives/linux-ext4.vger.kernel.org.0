Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309D04F8719
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Apr 2022 20:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbiDGScx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Apr 2022 14:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiDGScw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Apr 2022 14:32:52 -0400
X-Greylist: delayed 301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Apr 2022 11:30:48 PDT
Received: from forward500p.mail.yandex.net (forward500p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6D318854B
        for <linux-ext4@vger.kernel.org>; Thu,  7 Apr 2022 11:30:48 -0700 (PDT)
Received: from vla5-d9b1398c799b.qloud-c.yandex.net (vla5-d9b1398c799b.qloud-c.yandex.net [IPv6:2a02:6b8:c18:3522:0:640:d9b1:398c])
        by forward500p.mail.yandex.net (Yandex) with ESMTP id B2AF2F0266F;
        Thu,  7 Apr 2022 21:25:42 +0300 (MSK)
Received: from vla3-23c3b031fed5.qloud-c.yandex.net (vla3-23c3b031fed5.qloud-c.yandex.net [2a02:6b8:c15:2582:0:640:23c3:b031])
        by vla5-d9b1398c799b.qloud-c.yandex.net (mxback/Yandex) with ESMTP id l3l7tSPOaG-PgfKrpOJ;
        Thu, 07 Apr 2022 21:25:42 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1649355942;
        bh=1SVj6vwweek3NtuDpK3icVZaJcv1U0yq2yXVgiJ4Tos=;
        h=In-Reply-To:From:Subject:Cc:References:Date:Message-ID:To;
        b=TIAjEWZsf898vUOBtrS72+Oqzekqdyxhj+DvTWQIwUpkrs2aCTVIHRgVZ3/4B56Ay
         eyWlxj1J5KcRt41wDHmypHiteGAQ7mmIeUKfBWfQhcyUcWJ62Qc/ijtZcwObIgzlBc
         w02FeKmRQJ0ziLZCmn1dYok1r5GlNTWsU32FKm18=
Authentication-Results: vla5-d9b1398c799b.qloud-c.yandex.net; dkim=pass header.i=@ya.ru
Received: by vla3-23c3b031fed5.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id ZdRZVpPrBd-PfLCJYSt;
        Thu, 07 Apr 2022 21:25:41 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Message-ID: <697a8e92-513c-c81f-e619-57fa94bad4d0@ya.ru>
Date:   Thu, 7 Apr 2022 21:25:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3] ext4: truncate during setxattr leads to kernel panic
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>
Cc:     linux-ext4@vger.kernel.org,
        Andrew Perepechko <andrew.perepechko@hpe.com>
References: <20220402084023.1841375-1-anserper@ya.ru>
 <20220405095451.kx43cdu2ureywgcq@riteshh-domain> <Yk77KMgb4SYuXuUL@mit.edu>
From:   Andrew <anserper@ya.ru>
In-Reply-To: <Yk77KMgb4SYuXuUL@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Theodore and Ritesh!

Thank you for your feedback.
Please, let me give you some details.

First of all, the original issue was found with Lustre as the primary 
user of ext4. In this particular use case,
Lustre is very similar to a userspace ext4 user except that it has its 
own transaction logic that covers
setxattr and some other operation (so it's even harder to fix the issue 
by pushing iput from under transaction).

When the root cause was identified, I was able to reproduce the bug 
without Lustre with the following script:


dd if=/dev/zero of=/tmp/ldiskfs bs=1M count=100
mkfs.ext4 -O ea_inode /tmp/ldiskfs -J size=16 -I 512

mkdir -p /tmp/ldiskfs_m
mount -t ext4 /tmp/ldiskfs /tmp/ldiskfs_m -o loop,commit=600,no_mbcache
touch /tmp/ldiskfs_m/file{1..1024}

V=$(for i in `seq 60000`; do echo -n x ; done)
V1="1$V"
V2="2$V"

for k in 1 2 3 4 5 6 7 8 9; do
        setfattr -n user.xattr -v $V /tmp/ldiskfs_m/file{1..1024}
        setfattr -n user.xattr -v $V1 /tmp/ldiskfs_m/file{1..1024} &
        setfattr -n user.xattr -v $V2 /tmp/ldiskfs_m/file{1024..1} &
        wait
done

umount /tmp/ldiskfs_m


Please note that the reproducer does not really depend on sizes or options
such as commit=600 or no_mbcache. However, no_mbcache allows the 
reproducer to use a small set of
large ea values for the race. With mbcache, large EA inodes can be 
aggressively reused.

The above reproducer triggers the following oops (using a build from a 
recent linux.git commit):

[  181.269541] ------------[ cut here ]------------
[  181.269733] kernel BUG at fs/jbd2/transaction.c:1511!
[  181.269951] invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
[  181.270169] CPU: 0 PID: 940 Comm: setfattr Not tainted 
5.17.0-13430-g787af64d05cd #9
[  181.270243] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS 
VirtualBox 12/01/2006
[  181.270243] RIP: 0010:jbd2_journal_dirty_metadata+0x400/0x420
[  181.270243] Code: 24 4c 4c 8b 0c 24 41 83 f8 01 0f 84 3c ff ff ff e9 
24 94 0b 01 48 8b 7c 24 08 e8 cb f6 df ff 4d 39 6c 24 70 0f 84 e6 fc ff 
ff <0f> 0b 0f 0b c7 4
4 24 18 e4 ff ff ff e9 9f fe ff ff 0f 0b c7 44 24
[  181.270243] RSP: 0018:ffff88802632f698 EFLAGS: 00010207
[  181.270243] RAX: 0000000000000000 RBX: ffff88800044fcc8 RCX: 
ffffffffa73a03b5
[  181.270243] RDX: dffffc0000000000 RSI: 0000000000000004 RDI: 
ffff888032ff6f58
[  181.270243] RBP: ffff88802eb04418 R08: ffffffffa6f502bf R09: 
ffffed1004c65ec6
[  181.270243] R10: 0000000000000003 R11: ffffed1004c65ec5 R12: 
ffff888032ff6ee8
[  181.270243] R13: ffff888024af8300 R14: ffff88800044fcec R15: 
ffff888032ff6f50
[  181.270243] FS:  00007ffb5f6e3740(0000) GS:ffff888034800000(0000) 
knlGS:0000000000000000
[  181.270243] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  181.270243] CR2: 00007f9ca09dc024 CR3: 0000000032244000 CR4: 
00000000000506f0
[  181.270243] Call Trace:
[  181.270243]  <TASK>
[  181.270243]  __ext4_handle_dirty_metadata+0xb1/0x330
[  181.270243]  ext4_mark_iloc_dirty+0x2b7/0xcd0
[  181.270243]  ext4_xattr_set_handle+0x694/0xaf0
[  181.270243]  ext4_xattr_set+0x164/0x260
[  181.270243]  __vfs_setxattr+0xcb/0x110
[  181.270243]  __vfs_setxattr_noperm+0x8c/0x300
[  181.270243]  vfs_setxattr+0xff/0x250
[  181.270243]  setxattr+0x14a/0x260
[  181.270243]  path_setxattr+0x132/0x150
[  181.270243]  __x64_sys_setxattr+0x63/0x70
[  181.270243]  do_syscall_64+0x3b/0x90
[  181.270243]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  181.270243] RIP: 0033:0x7ffb5efebbee


This oops is caused by the fact that the inode bh was initially added to
another transaction. However, when it's being marked dirty, the running 
transaction has already changed
because of transaction restart in truncate.

Unfortunately, it's not the only issue here (so it cannot be fixed by 
simply re-adding bh to the new

transaction) since transaction restart forced the earlier transaction to
commit and the kernel panic left the running transaction uncommitted, 
on-disk corruption happens,
kernel panic will happen after remount if the corrupted inode/large EA 
is accessed again.

An example of a panic due to ondisk corruption after remount from a 
Lustre system:

[203570.602463] LDISKFS-fs error (device md65): ldiskfs_xattr_inode_iget:392: comm mdt04_008: error while reading EA inode 807598115 err=-116
[203570.617935] Aborting journal on device md65-8.
[203570.628176] Kernel panic - not syncing: LDISKFS-fs (device md65): panic forced after error

This whole text is probably an overkill for a commit message. What do 
you think I should keep for
the commit message?

Thank you,
Andrew

> On Tue, Apr 05, 2022 at 03:24:51PM +0530, Ritesh Harjani wrote:
>> On 22/04/02 11:40AM, anserper@ya.ru wrote:
>>> From: Andrew Perepechko <andrew.perepechko@hpe.com>
>>>
>>> When changing a large xattr value to a different large xattr value,
>>> the old xattr inode is freed. Truncate during the final iput causes
>>> current transaction restart. Eventually, parent inode bh is marked
>>> dirty and kernel panic happens when jbd2 figures out that this bh
>>> belongs to the committed transaction.
>>>
>>> A possible fix is to call this final iput in a separate thread.
>>> This way, setxattr transactions will never be split into two.
>>> Since the setxattr code adds xattr inodes with nlink=0 into the
>>> orphan list, old xattr inodes will be properly cleaned up in
>>> any case.
>> Ok, I think there is a lot happening in above description. I think part of the
>> problem I am unable to understand it easily is because I haven't spend much time
>> with xattr code. But I think below 2 requests will be good to have -
>>
>> 1. Do we have the call stack for this problem handy. I think it will be good to
>> mention it in the commit message itself. It is sometimes easy to look at the
>> call stack if someone else encounters a similar problem. That also gives more
>> idea about where the problem is occuring.
>>
>> 2. Do we have a easy reproducer for this problem? I think it will be a good
>>     addition to fstests given that this adds another context in calling iput on
>>     old_ea_inode.
> Andrew, would it be possible for you to supply a call stack and a
> reproducer?
>
> It sounds like what's going on is if the file system has the ea_inode
> feature enabled, and we have a large xattr value which is stored in an
> inode, it's possible if that when that inode is truncated, it is
> spread across two transactions.
>
> But the problem is that when the iput(ea_inode) is called from
> ext4_xattr_set_entry(), there is a handle which is passed into that
> function, since the xattr operation is part of its own transaction,
> and so the truncate operation is part of "nested handle".  That's OK,
> so long as the initial handle is started with sufficient credits for
> the nested start_handle.  But when that handle is closed, and then
> re-opened, it has two problems.  The first is that the xattr operation
> is no longer atomic (and spread across two transaction).  The second
> is that if the write access to the inode table's bh was requested
> before the implied truncate from iput(ea_inode), then when we call
> handle_dirty_metadata() on that bh, we get a jbd2 assertion.  (Which
> is good, because it notifies and catches the first problem.)
>
> So by moving the iput to a separate thread, it avoids this problem,
> since the truncate can take place in its own handle.  The other
> solution would be to some how pass the inode all the way up through
> the call chain, and only call iput(ea_inode) after handle is stopped.
> But that would require quite a lot of code surgery, since
> ext4_xattr_set_entry is called in a number of places, and the iput()
> would have to be plumbed up through two callers to where the handle is
> actually stopped.
>
> 						- Ted
