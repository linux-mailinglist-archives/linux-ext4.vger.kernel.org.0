Return-Path: <linux-ext4+bounces-14306-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Ck6GDqbpWmfEwYAu9opvQ
	(envelope-from <linux-ext4+bounces-14306-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 15:14:18 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C30F1DA7FE
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 15:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D754330312C8
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Mar 2026 14:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D213FB066;
	Mon,  2 Mar 2026 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="hboQpaA3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87113B8BD3
	for <linux-ext4@vger.kernel.org>; Mon,  2 Mar 2026 14:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460529; cv=none; b=pJvsuuVmU0k1wnN39fWrlCjxTbUdM42kol3R6yrvivT7hA35g+UvFN6sRGKwTBP6mG0khdtTmLR+uHwFWlYWKkYn6rrmalPAM7AUIniaRbptoXichxYzl/IKwTFrrOYOX2TrjOBNwnNSUFvnp3xwaoiJg0Wnilc8oShszAlKixs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460529; c=relaxed/simple;
	bh=714pzEA/gSveV24m+jg9YyO38bh6lRKmvzZADsc1DZY=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=b1gFAfrmYw0n/CkqOBtuU3hckH1k0xaLzVmY9dL+PM+fBcPda1Y5CIhYxdarQzYFB5i981LQ8ECPMPWU7YXArMGIvVUk9C4IYzUNdMgcthppbcnqGAjVf/bJ/rtv00EekqHNdEehS5+owsGe2Va5NKKdfmTC/HGInqLvZVFxjo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=hboQpaA3; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=UFocLgCdWdakcfrWgmjjasAkIMUdTkFirF8YtYpkSWs=;
	b=hboQpaA31E2xXEMjMRzE7y+OKj0ne4X8CsTiEoLMQzdHsVBuZHaE5lkRMDTQfKa9tmyyV5wsK
	pjz/nVUr6QwEfFGN7d/mp7oG8VP6zKXJHiRc9aZRUs1svfwqNk1FpCABJYE1/BDYiSSHGc0bOj0
	KcCP39YgkhxZ+uCTBsMX2t8=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fPgdK03QXzcZxw;
	Mon,  2 Mar 2026 22:03:33 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 7E96440561;
	Mon,  2 Mar 2026 22:08:42 +0800 (CST)
Received: from kwepemq500016.china.huawei.com (7.202.194.202) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Mar 2026 22:08:42 +0800
Received: from [10.174.178.185] (10.174.178.185) by
 kwepemq500016.china.huawei.com (7.202.194.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Mar 2026 22:08:41 +0800
Subject: Re: [syzbot ci] Re: ext4: test if inode's all dirty pages are
 submitted to disk
To: syzbot ci <syzbot+ci218c29ae48f2e4ea@syzkaller.appspotmail.com>,
	<adilger.kernel@dilger.ca>, <jack@suse.cz>, <linux-ext4@vger.kernel.org>,
	<tytso@mit.edu>, <yebin@huaweicloud.com>
References: <69a561a0.050a0220.3a55be.0073.GAE@google.com>
CC: <syzbot@lists.linux.dev>, <syzkaller-bugs@googlegroups.com>
From: "yebin (H)" <yebin10@huawei.com>
Message-ID: <69A599E5.1000801@huawei.com>
Date: Mon, 2 Mar 2026 22:08:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <69a561a0.050a0220.3a55be.0073.GAE@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq500016.china.huawei.com (7.202.194.202)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14306-lists,linux-ext4=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,huawei.com:mid,huawei.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,googlesource.com:url,appspotmail.com:email,syzbot.org:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yebin10@huawei.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4,ci218c29ae48f2e4ea];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4C30F1DA7FE
X-Rspamd-Action: no action



On 2026/3/2 18:08, syzbot ci wrote:
> syzbot ci has tested the following series
>
> [v2] ext4: test if inode's all dirty pages are submitted to disk
> https://lore.kernel.org/all/20260228025650.2664098-1-yebin@huaweicloud.com
> * [PATCH v2] ext4: test if inode's all dirty pages are submitted to disk
>
> and found the following issue:
> WARNING in ext4_evict_inode
>
> Full report is available here:
> https://ci.syzbot.org/series/b58ccb85-a946-44ae-9d57-c02bee2a43ba
>
> ***
>
> WARNING in ext4_evict_inode
>
> tree:      torvalds
> URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
> base:      4d349ee5c7782f8b27f6cb550f112c5e26fff38d
> arch:      amd64
> compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> config:    https://ci.syzbot.org/builds/1accd9c8-371e-4c6c-9c4b-b930c65c23be/config
> C repro:   https://ci.syzbot.org/findings/ccbdbde1-d214-4e90-aeb7-d4bbda01329c/c_repro
> syz repro: https://ci.syzbot.org/findings/ccbdbde1-d214-4e90-aeb7-d4bbda01329c/syz_repro
>
> ------------[ cut here ]------------
> !ext4_emergency_state(inode->i_sb) && mapping_tagged(&inode->i_data, PAGECACHE_TAG_DIRTY)
> WARNING: fs/ext4/inode.c:192 at ext4_evict_inode+0xce7/0x1020 fs/ext4/inode.c:191, CPU#1: syz-executor/5917
> Modules linked in:
> CPU: 1 UID: 0 PID: 5917 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> RIP: 0010:ext4_evict_inode+0xce7/0x1020 fs/ext4/inode.c:191
> Code: f3 ff ff e8 ab 60 40 ff 49 89 dc 48 8b 5c 24 18 e9 ea f5 ff ff e8 99 60 40 ff 48 8b 5c 24 18 e9 db f5 ff ff e8 8a 60 40 ff 90 <0f> 0b 90 e9 cd f5 ff ff e8 7c 60 40 ff 48 8d 3d 85 e4 92 0d 67 48
> RSP: 0018:ffffc900057e79a0 EFLAGS: 00010293
> RAX: ffffffff82852b46 RBX: ffff88812000f5b8 RCX: ffff88811128ba00
> RDX: 0000000000000000 RSI: 0000000004000000 RDI: 0000000000000000
> RBP: ffffc900057e7ab0 R08: ffff8881111b6387 R09: 1ffff11022236c70
> R10: dffffc0000000000 R11: ffffed1022236c71 R12: 1ffff92000afcf44
> R13: dffffc0000000000 R14: 0000000004000000 R15: ffff8881111b6380
> FS:  0000555570b0d500(0000) GS:ffff8882a9464000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fff533fce88 CR3: 000000010b644000 CR4: 00000000000006f0
> Call Trace:
>   <TASK>
>   evict+0x61e/0xb10 fs/inode.c:846
>   dispose_list fs/inode.c:888 [inline]
>   evict_inodes+0x75a/0x7f0 fs/inode.c:942
>   generic_shutdown_super+0xaa/0x2d0 fs/super.c:632
>   kill_block_super+0x44/0x90 fs/super.c:1725
>   ext4_kill_sb+0x68/0xb0 fs/ext4/super.c:7459
>   deactivate_locked_super+0xbc/0x130 fs/super.c:476
>   cleanup_mnt+0x437/0x4d0 fs/namespace.c:1312
>   task_work_run+0x1d9/0x270 kernel/task_work.c:233
>   resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>   __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
>   exit_to_user_mode_loop+0xed/0x480 kernel/entry/common.c:98
>   __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
>   syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
>   syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
>   do_syscall_64+0x32d/0xf80 arch/x86/entry/syscall_64.c:100
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fb75539d9d7
> Code: a2 c7 05 1c ed 24 00 00 00 00 00 eb 96 e8 e1 12 00 00 90 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 e8 ff ff ff f7 d8 64 89 02 b8
> RSP: 002b:00007ffe2e6b7108 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> RAX: 0000000000000000 RBX: 00007fb755431f90 RCX: 00007fb75539d9d7
> RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffe2e6b71c0
> RBP: 00007ffe2e6b71c0 R08: 00007ffe2e6b81c0 R09: 00000000ffffffff
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe2e6b8250
> R13: 00007fb755431f90 R14: 000000000000f951 R15: 00007ffe2e6b8290
>   </TASK>
>
>
> ***
>
> If these findings have caused you to resend the series or submit a
> separate fix, please add the following tag to your commit message:
>    Tested-by: syzbot@syzkaller.appspotmail.com
>
> ---
> This report is generated by a bot. It may contain errors.
> syzbot ci engineers can be reached at syzkaller@googlegroups.com.
>
[   63.910480][ T5955] EXT4-fs (loop0): mounted filesystem 
00000000-0000-0006-0000-000000000000 r/w without journal. Quota mode: 
writeback.
[   63.915765][ T5955] ext4 filesystem being mounted at /0/file1 
supports timestamps until 2038-01-19 (0x7fffffff)
[   63.921828][ T5955] EXT4-fs error (device loop0): 
ext4_validate_block_bitmap:441: comm syz.0.17: bg 0: block 112: padding 
at end of block bitmap is not set
[   63.927661][ T5955] EXT4-fs (loop0): Delayed block allocation failed 
for inode 15 at logical offset 16 with max blocks 16 with error 117
[   63.932075][ T5955] EXT4-fs (loop0): This should not happen!! Data 
will be lost
[   63.932075][ T5955]
[   63.946677][  T197] EXT4-fs (loop0): Delayed block allocation failed 
for inode 15 at logical offset 32 with max blocks 36 with error 117
[   63.960973][  T197] EXT4-fs (loop0): This should not happen!! Data 
will be lost

In this case, WARN_ON is not suitable for the fault scenario. It is
better to directly add log printing.

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 396dc3a5d16b..d4d65593bce2 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -184,6 +184,14 @@ void ext4_evict_inode(struct inode *inode)
         if (EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)
                 ext4_evict_ea_inode(inode);
         if (inode->i_nlink) {
+               /*
+                * If there's dirty page will lead to data loss, user
+                * could see stale data.
+                */
+               if (unlikely(!ext4_emergency_state(inode->i_sb) &&
+                   mapping_tagged(&inode->i_data, PAGECACHE_TAG_DIRTY)))
+                       ext4_warning_inode(inode, "data will be lost");
+
                 truncate_inode_pages_final(&inode->i_data);

                 goto no_delete;

>
> .
>

