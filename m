Return-Path: <linux-ext4+bounces-14228-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCHBM39Bomlz1QQAu9opvQ
	(envelope-from <linux-ext4+bounces-14228-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Feb 2026 02:14:39 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3A41BFAA0
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Feb 2026 02:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7823F308A523
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Feb 2026 01:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F9F2DECC5;
	Sat, 28 Feb 2026 01:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="D5hNe9Ek"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABAF2DE6F1
	for <linux-ext4@vger.kernel.org>; Sat, 28 Feb 2026 01:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772241276; cv=none; b=drVrPd3+9M7UDSFosOG8lfg+g+AKYsX85CvTlmYH2hG8EqSczgL5w+IcmEgN3Z+/hYJDo4KBZg6mUPZDVg+8LZeNuoAH99DR1wcq6PPsKyusfMWHGPEWt3R6hHAkJvZ5DPCRS/zcEjvZWNr/y/B21MD3tBL2Fqz1/jKhz0LOGQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772241276; c=relaxed/simple;
	bh=FJmdl2It3tg59G3h/TZNJbRDCjpIAKda3HUvq9PyF20=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=r6cIempMAUHwtkIQWKz+Ty3E30QZ5WSFmvwj8JyQkC/UJWmBdf5llj2htHtZXbS+9/qtQXQzi0Or9iiCELyUOlkQiLS8S4grvx1eLk71+v2eP8xjwdsFq71QZoCSC4xw8U0cAmSCgwa2NVGM0rb/Kxwfat8gtrbfbmecAmLvk6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=D5hNe9Ek; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=asFSWCBnA7kO4j2SuCj7NWD6TCyWM5Yh7Y+k2kZ1Mh8=;
	b=D5hNe9EkdFuixPk5/jBgPHdg9dlqx32RdbAlrNYmdT6KTHb0DeRrXesLSKugkIaEzBlmetEqp
	45ZnvQE7uaQibxPTlWWZ6BN/sT7WJqpZmajWRt98rIe0rYpvpeq7pIrmN/uI93Yw/YmvvQglrIS
	SvUHxITW92Qn16YP1iPzwrk=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4fN6YJ28wQzmVXR;
	Sat, 28 Feb 2026 09:09:40 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id B36A04048B;
	Sat, 28 Feb 2026 09:14:29 +0800 (CST)
Received: from kwepemq500016.china.huawei.com (7.202.194.202) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 28 Feb 2026 09:14:29 +0800
Received: from [10.174.178.185] (10.174.178.185) by
 kwepemq500016.china.huawei.com (7.202.194.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 28 Feb 2026 09:14:28 +0800
Subject: Re: [syzbot ci] Re: ext4: test if inode's all dirty pages are
 submitted to disk
To: syzbot ci <syzbot+cif302214182590c61@syzkaller.appspotmail.com>,
	<adilger.kernel@dilger.ca>, <jack@suse.cz>, <linux-ext4@vger.kernel.org>,
	<tytso@mit.edu>, <yebin@huaweicloud.com>
References: <69a14d31.050a0220.305b49.00aa.GAE@google.com>
CC: <syzbot@lists.linux.dev>, <syzkaller-bugs@googlegroups.com>
From: "yebin (H)" <yebin10@huawei.com>
Message-ID: <69A24174.2080805@huawei.com>
Date: Sat, 28 Feb 2026 09:14:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <69a14d31.050a0220.305b49.00aa.GAE@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemq500016.china.huawei.com (7.202.194.202)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14228-lists,linux-ext4=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:mid,huawei.com:dkim,syzbot.org:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yebin10@huawei.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4,cif302214182590c61];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8A3A41BFAA0
X-Rspamd-Action: no action

This is my oversight. If the file system has already become read-only
and dirty pages cannot be flushed back, no warning should be generated
at this time.

On 2026/2/27 15:52, syzbot ci wrote:
> syzbot ci has tested the following series
>
> [v1] ext4: test if inode's all dirty pages are submitted to disk
> https://lore.kernel.org/all/20260226110718.1904825-1-yebin@huaweicloud.com
> * [PATCH] ext4: test if inode's all dirty pages are submitted to disk
>
> and found the following issue:
> WARNING in ext4_evict_inode
>
> Full report is available here:
> https://ci.syzbot.org/series/8f9434e5-a73c-4b31-be9f-e9b76f1c2596
>
> ***
>
> WARNING in ext4_evict_inode
>
> tree:      torvalds
> URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
> base:      f4d0ec0aa20d49f09dc01d82894ce80d72de0560
> arch:      amd64
> compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> config:    https://ci.syzbot.org/builds/7053c6f2-2ee6-4a1d-9f74-d2f56facd9f9/config
> C repro:   https://ci.syzbot.org/findings/4f7c2b91-8121-443d-9a4f-991feda8057c/c_repro
> syz repro: https://ci.syzbot.org/findings/4f7c2b91-8121-443d-9a4f-991feda8057c/syz_repro
>
> ------------[ cut here ]------------
> mapping_tagged(&inode->i_data, PAGECACHE_TAG_DIRTY)
> WARNING: fs/ext4/inode.c:191 at ext4_evict_inode+0xbdc/0xf10 fs/ext4/inode.c:191, CPU#1: syz-executor/5915
> Modules linked in:
> CPU: 1 UID: 0 PID: 5915 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> RIP: 0010:ext4_evict_inode+0xbdc/0xf10 fs/ext4/inode.c:191
> Code: ba 2c 02 00 48 8b bc 24 a0 00 00 00 e8 bd 49 14 00 e9 71 fe ff ff e8 43 63 40 ff 90 0f 0b 90 e9 e6 f4 ff ff e8 35 63 40 ff 90 <0f> 0b 90 e9 f2 f5 ff ff e8 27 63 40 ff 48 8d 3d 50 df 92 0d 67 48
> RSP: 0018:ffffc900048b79a0 EFLAGS: 00010293
> RAX: ffffffff8285287b RBX: ffff88811d980298 RCX: ffff8881027d8000
> RDX: 0000000000000000 RSI: 0000000004000000 RDI: 0000000000000000
> RBP: ffffc900048b7ab0 R08: ffffffff901181b7 R09: 1ffffffff2023036
> R10: dffffc0000000000 R11: fffffbfff2023037 R12: 1ffff92000916f44
> R13: dffffc0000000000 R14: ffff88811d9804b8 R15: 0000000004000000
> FS:  000055557d541500(0000) GS:ffff8882a9464000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000c00003e720 CR3: 000000010f9d2000 CR4: 00000000000006f0
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
> RIP: 0033:0x7fcf3c79d897
> Code: a2 c7 05 5c ee 24 00 00 00 00 00 eb 96 e8 e1 12 00 00 90 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 e8 ff ff ff f7 d8 64 89 02 b8
> RSP: 002b:00007ffe2362cef8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> RAX: 0000000000000000 RBX: 00007fcf3c831ef0 RCX: 00007fcf3c79d897
> RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffe2362cfb0
> RBP: 00007ffe2362cfb0 R08: 00007ffe2362dfb0 R09: 00000000ffffffff
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe2362e040
> R13: 00007fcf3c831ef0 R14: 000000000000f11c R15: 00007ffe2362e080
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
>
> .
>

