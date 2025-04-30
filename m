Return-Path: <linux-ext4+bounces-7576-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 822A9AA4866
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Apr 2025 12:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC6769C6CD8
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Apr 2025 10:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4894E2586E2;
	Wed, 30 Apr 2025 10:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ieoyY9KA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="K0VMrtG5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ieoyY9KA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="K0VMrtG5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BF82580D1
	for <linux-ext4@vger.kernel.org>; Wed, 30 Apr 2025 10:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746008976; cv=none; b=E5ydZqLCCqcvUPGKzfD+6i3RAy3Kg1w9NbwydOyghykin71oqDAVJSjsLUiJr0dEFV5qfothBQ9wYp5pCR2NXeKdUX5ukuzqjIDLZq02fU1RpmhKTFSe2TwE1Y6OcZV0unTd5YoLeseOddRoNT/DIsI56tmE5FMPW/MFxYYwZnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746008976; c=relaxed/simple;
	bh=1/hcK43LJWnxHIbsp7c5JWka3wbNQxvU7cl2sNw1YBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRFKNW267y5XgI62ZNNsbS1E9s0iMz1dEHmR4nNkkwlzO3WSvuHohYHiXFszS6ldq7zyOayYlpDZ/zRP7NzQX27qCYMMxneyR95sedHk/PKDBo/kPrYzlCps9T3xh2DdLQ1UXYhgj0UeK3PmEvvz1+ashZBHA4NwwVbXJgviG1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ieoyY9KA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=K0VMrtG5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ieoyY9KA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=K0VMrtG5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4B4E61F7BF;
	Wed, 30 Apr 2025 10:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746008972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6pfV9V94VhItRTKKq7RUu0RiR0suKrLZMLyEsiIoomU=;
	b=ieoyY9KAucohCmxfC8BQW0LYVX1WS7tNLupQsdGCQW32t/JHCG+R+9AtpLRkxBP+Rc9uMw
	x3Fai0xhDa9hM372aajosgkmfI7Nj5f1XvfBcBxAEfTM3cPC2ypiWdJ370WsvKLDIFyCTD
	hytiwElYyKLEQG8Wr/0uRJlsaAFPA40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746008972;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6pfV9V94VhItRTKKq7RUu0RiR0suKrLZMLyEsiIoomU=;
	b=K0VMrtG5h23L8CpZaYz9FMshpiOcjN3bvlV+QH9z5zG1cvF/9h53rIOlNAHzr8BheEuNCm
	p24NGi+evX8QZ1BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746008972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6pfV9V94VhItRTKKq7RUu0RiR0suKrLZMLyEsiIoomU=;
	b=ieoyY9KAucohCmxfC8BQW0LYVX1WS7tNLupQsdGCQW32t/JHCG+R+9AtpLRkxBP+Rc9uMw
	x3Fai0xhDa9hM372aajosgkmfI7Nj5f1XvfBcBxAEfTM3cPC2ypiWdJ370WsvKLDIFyCTD
	hytiwElYyKLEQG8Wr/0uRJlsaAFPA40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746008972;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6pfV9V94VhItRTKKq7RUu0RiR0suKrLZMLyEsiIoomU=;
	b=K0VMrtG5h23L8CpZaYz9FMshpiOcjN3bvlV+QH9z5zG1cvF/9h53rIOlNAHzr8BheEuNCm
	p24NGi+evX8QZ1BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2994E139E7;
	Wed, 30 Apr 2025 10:29:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +BbhCYz7EWi2NwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 30 Apr 2025 10:29:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D3D17A0AF0; Wed, 30 Apr 2025 12:29:27 +0200 (CEST)
Date: Wed, 30 Apr 2025 12:29:27 +0200
From: Jan Kara <jack@suse.cz>
To: =?utf-8?B?6IOh54Sc?= <huk23@m.fudan.edu.cn>
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>, 
	linux-ext4 <linux-ext4@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	syzkaller <syzkaller@googlegroups.com>, =?utf-8?B?6KaD5L2z5Z+6?= <jjtan24@m.fudan.edu.cn>, 
	baishuoran <baishuoran@hrbeu.edu.cn>
Subject: Re: INFO_ task hung in jbd2_complete_transaction
Message-ID: <476pyowwvydb3vewhc666g7wdz4hleq74f3ht7vzodgysbfjh6@tv4xnbr5hgao>
References: <tencent_795BB5FD00A0E9FA2986495F@qq.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_795BB5FD00A0E9FA2986495F@qq.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

Hello!

On Wed 30-04-25 16:51:17, 胡焜 wrote:
> When using our customized Syzkaller to fuzz the latest Linux kernel, the
> following crash (49th)was triggered.
> 
> HEAD commit: 6537cfb395f352782918d8ee7b7f10ba2cc3cbf2
> git tree: upstream
> Output:https://github.com/pghk13/Kernel-Bug/blob/main/0115rc7/49-INFO_%20task%20hung%20in%20jbd2_complete_transaction/report0
> Kernel config:https://github.com/pghk13/Kernel-Bug/blob/main/0115rc7/config.txt
> C reproducer:https://github.com/pghk13/Kernel-Bug/blob/main/0115rc7/49-INFO_%20task%20hung%20in%20jbd2_complete_transaction/4repro.c
> Syzlang reproducer: https://github.com/pghk13/Kernel-Bug/blob/main/0115rc7/49-INFO_%20task%20hung%20in%20jbd2_complete_transaction/4_repro.txt

So the reproducer does nothing with ext4 filesystem which is suspicious and
suggests that there are likely other factors on your system causing the
lockup.

> Multiple processes are in an uninterruptible sleep state (D) for more
> than 143 seconds, causing the system to hang. The core problem may be in
> jbd2_log_wait_commit function. Log commits are blocked because another
> process holds a read/write lock (s_writepages_rwsem) on the file system,
> and the process holding that lock may be waiting for the lock held by the
> current process, creating a ring dependency deadlock We have reproduced
> this issue several times on 6.13-rc7 again, but we don't have too much
> knowledge about this area, could we trouble you to check the root cause.

So this certainly isn't the full story. In particular I don't see how a
transaction commit can block on s_writepages_rwsem because it should not
acquire it at all.

The stack traces below don't show any deadlock loop either. When you
reproduce this again, can you do "echo w >/proc/sysrq-trigger" in the hung
VM (or perhaps add this your automation when lockup is detected) so that we
capture stack traces of all blocked tasks? Thanks!

								Honza

> ==================================================================
> INFO: task syz.8.17184:127686 blocked for more than 143 seconds.
> &nbsp; &nbsp; &nbsp; Not tainted 6.13.0-rc7 #1
> "echo 0 &gt; /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz.8.17184 &nbsp; &nbsp; state:D stack:27568 pid:127686 tgid:127684 ppid:125724 flags:0x00004004
> Call Trace:
> &nbsp;<TASK&gt;
> &nbsp;context_switch kernel/sched/core.c:5369 [inline]
> &nbsp;__schedule+0xe60/0x4120 kernel/sched/core.c:6756
> &nbsp;__schedule_loop kernel/sched/core.c:6833 [inline]
> &nbsp;schedule+0xd4/0x210 kernel/sched/core.c:6848
> &nbsp;jbd2_log_wait_commit+0x2cc/0x430 fs/jbd2/journal.c:673
> &nbsp;jbd2_complete_transaction+0x188/0x1f0 fs/jbd2/journal.c:799
> &nbsp;ext4_fc_commit+0x984/0x1840 fs/ext4/fast_commit.c:1236
> &nbsp;ext4_fallocate+0x540/0x3810 fs/ext4/extents.c:4827
> &nbsp;vfs_fallocate+0x49d/0xeb0 fs/open.c:327
> &nbsp;ksys_fallocate+0x55/0xa0 fs/open.c:351
> &nbsp;__do_sys_fallocate fs/open.c:356 [inline]
> &nbsp;__se_sys_fallocate fs/open.c:354 [inline]
> &nbsp;__x64_sys_fallocate+0x97/0x100 fs/open.c:354
> &nbsp;do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> &nbsp;do_syscall_64+0xc3/0x1d0 arch/x86/entry/common.c:83
> &nbsp;entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f0e50ae071d
> RSP: 002b:00007f0e4f733ba8 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
> RAX: ffffffffffffffda RBX: 00007f0e50ca2f80 RCX: 00007f0e50ae071d
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
> RBP: 00007f0e50b55425 R08: 0000000000000000 R09: 0000000000000000
> R10: 00000000001000f8 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f0e50ca2f8c R14: 00007f0e50ca3018 R15: 00007f0e4f733d40
> &nbsp;</TASK&gt;
> INFO: task syz.8.17184:127690 blocked for more than 143 seconds.
> &nbsp; &nbsp; &nbsp; Not tainted 6.13.0-rc7 #1
> "echo 0 &gt; /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz.8.17184 &nbsp; &nbsp; state:D stack:28376 pid:127690 tgid:127684 ppid:125724 flags:0x00000004
> Call Trace:
> &nbsp;<TASK&gt;
> &nbsp;context_switch kernel/sched/core.c:5369 [inline]
> &nbsp;__schedule+0xe60/0x4120 kernel/sched/core.c:6756
> &nbsp;__schedule_loop kernel/sched/core.c:6833 [inline]
> &nbsp;schedule+0xd4/0x210 kernel/sched/core.c:6848
> &nbsp;schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6905
> &nbsp;rwsem_down_read_slowpath+0x78f/0xf10 kernel/locking/rwsem.c:1084
> &nbsp;__down_read_common kernel/locking/rwsem.c:1248 [inline]
> &nbsp;__down_read kernel/locking/rwsem.c:1261 [inline]
> &nbsp;down_read+0xf0/0x480 kernel/locking/rwsem.c:1526
> &nbsp;inode_lock_shared include/linux/fs.h:828 [inline]
> &nbsp;ext4_dio_read_iter fs/ext4/file.c:78 [inline]
> &nbsp;ext4_file_read_iter fs/ext4/file.c:145 [inline]
> &nbsp;ext4_file_read_iter+0x211/0x410 fs/ext4/file.c:130
> &nbsp;copy_splice_read+0x5d5/0xb90 fs/splice.c:365
> &nbsp;do_splice_read.part.0+0x1c1/0x230 fs/splice.c:984
> &nbsp;do_splice_read fs/splice.c:967 [inline]
> &nbsp;splice_direct_to_actor+0x2c4/0xa10 fs/splice.c:1089
> &nbsp;do_splice_direct_actor+0x181/0x250 fs/splice.c:1207
> &nbsp;do_splice_direct+0x41/0x60 fs/splice.c:1233
> &nbsp;do_sendfile+0xac1/0xde0 fs/read_write.c:1363
> &nbsp;__do_sys_sendfile64 fs/read_write.c:1424 [inline]
> &nbsp;__se_sys_sendfile64 fs/read_write.c:1410 [inline]
> &nbsp;__x64_sys_sendfile64+0x1d5/0x210 fs/read_write.c:1410
> &nbsp;do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> &nbsp;do_syscall_64+0xc3/0x1d0 arch/x86/entry/common.c:83
> &nbsp;entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f0e50ae071d
> RSP: 002b:00007f0e4f712ba8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 00007f0e50ca3058 RCX: 00007f0e50ae071d
> RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000003
> RBP: 00007f0e50b55425 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000100000008 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f0e50ca3064 R14: 00007f0e50ca30f0 R15: 00007f0e4f712d40
> &nbsp;</TASK&gt;
> INFO: task syz.4.17192:127724 blocked for more than 143 seconds.
> &nbsp; &nbsp; &nbsp; Not tainted 6.13.0-rc7 #1
> "echo 0 &gt; /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz.4.17192 &nbsp; &nbsp; state:D stack:30144 pid:127724 tgid:127723 ppid:125700 flags:0x00000004
> Call Trace:
> &nbsp;<TASK&gt;
> &nbsp;context_switch kernel/sched/core.c:5369 [inline]
> &nbsp;__schedule+0xe60/0x4120 kernel/sched/core.c:6756
> &nbsp;__schedule_loop kernel/sched/core.c:6833 [inline]
> &nbsp;schedule+0xd4/0x210 kernel/sched/core.c:6848
> &nbsp;jbd2_log_wait_commit+0x2cc/0x430 fs/jbd2/journal.c:673
> &nbsp;ext4_sync_fs+0x6f6/0x880 fs/ext4/super.c:6373
> &nbsp;dquot_quota_sync+0xeb/0x3a0 fs/quota/dquot.c:755
> &nbsp;quota_sync_one+0x14d/0x1a0 fs/quota/quota.c:60
> &nbsp;iterate_supers+0xff/0x230 fs/super.c:934
> &nbsp;quota_sync_all+0xca/0xe0 fs/quota/quota.c:69
> &nbsp;__do_sys_quotactl fs/quota/quota.c:938 [inline]
> &nbsp;__se_sys_quotactl fs/quota/quota.c:917 [inline]
> &nbsp;__x64_sys_quotactl+0x255/0x3b0 fs/quota/quota.c:917
> &nbsp;do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> &nbsp;do_syscall_64+0xc3/0x1d0 arch/x86/entry/common.c:83
> &nbsp;entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f23f835971d
> RSP: 002b:00007f23f6facba8 EFLAGS: 00000246 ORIG_RAX: 00000000000000b3
> RAX: ffffffffffffffda RBX: 00007f23f851bf80 RCX: 00007f23f835971d
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff80000102
> RBP: 00007f23f83ce425 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f23f851bf8c R14: 00007f23f851c018 R15: 00007f23f6facd40
> &nbsp;</TASK&gt;
> INFO: task syz.4.17192:127725 blocked for more than 143 seconds.
> &nbsp; &nbsp; &nbsp; Not tainted 6.13.0-rc7 #1
> "echo 0 &gt; /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz.4.17192 &nbsp; &nbsp; state:D stack:28320 pid:127725 tgid:127723 ppid:125700 flags:0x00000004
> Call Trace:
> &nbsp;<TASK&gt;
> &nbsp;context_switch kernel/sched/core.c:5369 [inline]
> &nbsp;__schedule+0xe60/0x4120 kernel/sched/core.c:6756
> &nbsp;__schedule_loop kernel/sched/core.c:6833 [inline]
> &nbsp;schedule+0xd4/0x210 kernel/sched/core.c:6848
> &nbsp;jbd2_log_wait_commit+0x2cc/0x430 fs/jbd2/journal.c:673
> &nbsp;ext4_sync_fs+0x6f6/0x880 fs/ext4/super.c:6373
> &nbsp;dquot_quota_sync+0xeb/0x3a0 fs/quota/dquot.c:755
> &nbsp;quota_sync_one+0x14d/0x1a0 fs/quota/quota.c:60
> &nbsp;iterate_supers+0xff/0x230 fs/super.c:934
> &nbsp;quota_sync_all+0xca/0xe0 fs/quota/quota.c:69
> &nbsp;__do_sys_quotactl fs/quota/quota.c:938 [inline]
> &nbsp;__se_sys_quotactl fs/quota/quota.c:917 [inline]
> &nbsp;__x64_sys_quotactl+0x255/0x3b0 fs/quota/quota.c:917
> &nbsp;do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> &nbsp;do_syscall_64+0xc3/0x1d0 arch/x86/entry/common.c:83
> &nbsp;entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f23f835971d
> RSP: 002b:00007f23f6f8bba8 EFLAGS: 00000246 ORIG_RAX: 00000000000000b3
> RAX: ffffffffffffffda RBX: 00007f23f851c058 RCX: 00007f23f835971d
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff80000101
> RBP: 00007f23f83ce425 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f23f851c064 R14: 00007f23f851c0f0 R15: 00007f23f6f8bd40
> &nbsp;</TASK&gt;
> INFO: task syz.4.17192:127726 blocked for more than 143 seconds.
> &nbsp; &nbsp; &nbsp; Not tainted 6.13.0-rc7 #1
> "echo 0 &gt; /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz.4.17192 &nbsp; &nbsp; state:D stack:28320 pid:127726 tgid:127723 ppid:125700 flags:0x00000004
> Call Trace:
> &nbsp;<TASK&gt;
> &nbsp;context_switch kernel/sched/core.c:5369 [inline]
> &nbsp;__schedule+0xe60/0x4120 kernel/sched/core.c:6756
> &nbsp;__schedule_loop kernel/sched/core.c:6833 [inline]
> &nbsp;schedule+0xd4/0x210 kernel/sched/core.c:6848
> &nbsp;jbd2_log_wait_commit+0x2cc/0x430 fs/jbd2/journal.c:673
> &nbsp;ext4_sync_fs+0x6f6/0x880 fs/ext4/super.c:6373
> &nbsp;dquot_quota_sync+0xeb/0x3a0 fs/quota/dquot.c:755
> &nbsp;quota_sync_one+0x14d/0x1a0 fs/quota/quota.c:60
> &nbsp;iterate_supers+0xff/0x230 fs/super.c:934
> &nbsp;quota_sync_all+0xca/0xe0 fs/quota/quota.c:69
> &nbsp;__do_sys_quotactl fs/quota/quota.c:938 [inline]
> &nbsp;__se_sys_quotactl fs/quota/quota.c:917 [inline]
> &nbsp;__x64_sys_quotactl+0x255/0x3b0 fs/quota/quota.c:917
> &nbsp;do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> &nbsp;do_syscall_64+0xc3/0x1d0 arch/x86/entry/common.c:83
> &nbsp;entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f23f835971d
> RSP: 002b:00007f23f6f6aba8 EFLAGS: 00000246 ORIG_RAX: 00000000000000b3
> RAX: ffffffffffffffda RBX: 00007f23f851c130 RCX: 00007f23f835971d
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff80000101
> RBP: 00007f23f83ce425 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f23f851c13c R14: 00007f23f851c1c8 R15: 00007f23f6f6ad40
> &nbsp;</TASK&gt;
> 
> 
> Showing all locks held in the system:
> 1 lock held by systemd/1:
> &nbsp;#0: ff110000082a2cc8 (mapping.invalidate_lock){++++}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:873 [inline]
> &nbsp;#0: ff110000082a2cc8 (mapping.invalidate_lock){++++}-{4:4}, at: page_cache_ra_unbounded+0x159/0x690 mm/readahead.c:226
> 1 lock held by khungtaskd/45:
> &nbsp;#0: ffffffffab51aea0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
> &nbsp;#0: ffffffffab51aea0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
> &nbsp;#0: ffffffffab51aea0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6744
> 1 lock held by kswapd0/83:
> &nbsp;#0: ffffffffab647720 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0xfb/0xe80 mm/vmscan.c:6871
> 1 lock held by systemd-journal/222:
> &nbsp;#0: ff11000055863698 (mapping.invalidate_lock){++++}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:873 [inline]
> &nbsp;#0: ff11000055863698 (mapping.invalidate_lock){++++}-{4:4}, at: page_cache_ra_unbounded+0x159/0x690 mm/readahead.c:226
> 1 lock held by cron/288:
> &nbsp;#0: ff1100000db1f9b8 (&amp;type-&gt;i_mutex_dir_key#3){++++}-{4:4}, at: inode_lock_shared include/linux/fs.h:828 [inline]
> &nbsp;#0: ff1100000db1f9b8 (&amp;type-&gt;i_mutex_dir_key#3){++++}-{4:4}, at: lookup_slow fs/namei.c:1807 [inline]
> &nbsp;#0: ff1100000db1f9b8 (&amp;type-&gt;i_mutex_dir_key#3){++++}-{4:4}, at: walk_component+0x338/0x5b0 fs/namei.c:2112
> 2 locks held by in:imklog/328:
> &nbsp;#0: ff110000082dacc8 (mapping.invalidate_lock){++++}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:873 [inline]
> &nbsp;#0: ff110000082dacc8 (mapping.invalidate_lock){++++}-{4:4}, at: filemap_fault+0x17c1/0x2ec0 mm/filemap.c:3342
> &nbsp;#1: ffffffffab647720 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:3926 [inline]
> &nbsp;#1: ffffffffab647720 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim mm/page_alloc.c:3951 [inline]
> &nbsp;#1: ffffffffab647720 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath.constprop.0+0x50c/0x2170 mm/page_alloc.c:4382
> 1 lock held by sshd/402:
> &nbsp;#0: ff110000080cd408 (mapping.invalidate_lock){++++}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:873 [inline]
> &nbsp;#0: ff110000080cd408 (mapping.invalidate_lock){++++}-{4:4}, at: page_cache_ra_unbounded+0x159/0x690 mm/readahead.c:226
> 1 lock held by syz-executor/408:
> &nbsp;#0: ffffffffab647720 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:3926 [inline]
> &nbsp;#0: ffffffffab647720 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim mm/page_alloc.c:3951 [inline]
> &nbsp;#0: ffffffffab647720 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath.constprop.0+0x50c/0x2170 mm/page_alloc.c:4382
> 4 locks held by kworker/u18:5/740:
> &nbsp;#0: ff11000002250948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
> &nbsp;#0: ff11000002250948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_scheduled_works+0x1175/0x1ba0 kernel/workqueue.c:3317
> &nbsp;#1: ffa000001420fd98 ((work_completion)(&amp;(&amp;wb-&gt;dwork)-&gt;work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
> &nbsp;#1: ffa000001420fd98 ((work_completion)(&amp;(&amp;wb-&gt;dwork)-&gt;work)){+.+.}-{0:0}, at: process_scheduled_works+0x52f/0x1ba0 kernel/workqueue.c:3317
> &nbsp;#2: ff1100000acf20e0 (&amp;type-&gt;s_umount_key#52){++++}-{4:4}, at: super_trylock_shared+0x21/0x100 fs/super.c:562
> &nbsp;#3: ff1100000acf4b98 (&amp;sbi-&gt;s_writepages_rwsem){++++}-{0:0}, at: do_writepages+0x19d/0x7d0 mm/page-writeback.c:2702
> 3 locks held by kworker/2:4/90257:
> &nbsp;#0: ff11000001071948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
> &nbsp;#0: ff11000001071948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_scheduled_works+0x1175/0x1ba0 kernel/workqueue.c:3317
> &nbsp;#1: ffa00000047b7d98 ((reg_check_chans).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
> &nbsp;#1: ffa00000047b7d98 ((reg_check_chans).work){+.+.}-{0:0}, at: process_scheduled_works+0x52f/0x1ba0 kernel/workqueue.c:3317
> &nbsp;#2: ffffffffacfb2208 (rtnl_mutex){+.+.}-{4:4}, at: reg_check_chans_work+0x8c/0x1050 net/wireless/reg.c:2480
> 4 locks held by kworker/3:5/107489:
> 3 locks held by kworker/u20:3/114127:
> &nbsp;#0: ff11000001079148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
> &nbsp;#0: ff11000001079148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x1175/0x1ba0 kernel/workqueue.c:3317
> &nbsp;#1: ffa0000003cd7d98 ((work_completion)(&amp;(&amp;krcp-&gt;page_cache_work)-&gt;work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
> &nbsp;#1: ffa0000003cd7d98 ((work_completion)(&amp;(&amp;krcp-&gt;page_cache_work)-&gt;work)){+.+.}-{0:0}, at: process_scheduled_works+0x52f/0x1ba0 kernel/workqueue.c:3317
> &nbsp;#2: ffffffffab647720 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:3926 [inline]
> &nbsp;#2: ffffffffab647720 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim mm/page_alloc.c:3951 [inline]
> &nbsp;#2: ffffffffab647720 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath.constprop.0+0x50c/0x2170 mm/page_alloc.c:4382
> 3 locks held by kworker/u16:1/117711:
> &nbsp;#0: ff1100000a902148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
> &nbsp;#0: ff1100000a902148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x1175/0x1ba0 kernel/workqueue.c:3317
> &nbsp;#1: ffa0000004147d98 ((work_completion)(&amp;(&amp;ifa-&gt;dad_work)-&gt;work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
> &nbsp;#1: ffa0000004147d98 ((work_completion)(&amp;(&amp;ifa-&gt;dad_work)-&gt;work)){+.+.}-{0:0}, at: process_scheduled_works+0x52f/0x1ba0 kernel/workqueue.c:3317
> &nbsp;#2: ffffffffacfb2208 (rtnl_mutex){+.+.}-{4:4}, at: addrconf_dad_work+0xb2/0x12c0 net/ipv6/addrconf.c:4215
> 3 locks held by kworker/u17:7/125828:
> &nbsp;#0: ff11000001079148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
> &nbsp;#0: ff11000001079148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x1175/0x1ba0 kernel/workqueue.c:3317
> &nbsp;#1: ffa0000003e57d98 ((work_completion)(&amp;(&amp;krcp-&gt;page_cache_work)-&gt;work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
> &nbsp;#1: ffa0000003e57d98 ((work_completion)(&amp;(&amp;krcp-&gt;page_cache_work)-&gt;work)){+.+.}-{0:0}, at: process_scheduled_works+0x52f/0x1ba0 kernel/workqueue.c:3317
> &nbsp;#2: ffffffffab647720 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:3926 [inline]
> &nbsp;#2: ffffffffab647720 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim mm/page_alloc.c:3951 [inline]
> &nbsp;#2: ffffffffab647720 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath.constprop.0+0x50c/0x2170 mm/page_alloc.c:4382
> 3 locks held by kworker/u17:11/125830:
> &nbsp;#0: ff11000001079148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
> &nbsp;#0: ff11000001079148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x1175/0x1ba0 kernel/workqueue.c:3317
> &nbsp;#1: ffa0000003da7d98 ((work_completion)(&amp;(&amp;krcp-&gt;page_cache_work)-&gt;work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
> &nbsp;#1: ffa0000003da7d98 ((work_completion)(&amp;(&amp;krcp-&gt;page_cache_work)-&gt;work)){+.+.}-{0:0}, at: process_scheduled_works+0x52f/0x1ba0 kernel/workqueue.c:3317
> &nbsp;#2: ffffffffab647720 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:3926 [inline]
> &nbsp;#2: ffffffffab647720 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim mm/page_alloc.c:3951 [inline]
> &nbsp;#2: ffffffffab647720 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath.constprop.0+0x50c/0x2170 mm/page_alloc.c:4382
> 3 locks held by kworker/u17:20/125839:
> &nbsp;#0: ff11000001079148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
> &nbsp;#0: ff11000001079148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x1175/0x1ba0 kernel/workqueue.c:3317
> &nbsp;#1: ffa0000003eb7d98 ((work_completion)(&amp;(&amp;krcp-&gt;page_cache_work)-&gt;work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
> &nbsp;#1: ffa0000003eb7d98 ((work_completion)(&amp;(&amp;krcp-&gt;page_cache_work)-&gt;work)){+.+.}-{0:0}, at: process_scheduled_works+0x52f/0x1ba0 kernel/workqueue.c:3317
> &nbsp;#2: ffffffffab647720 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:3926 [inline]
> &nbsp;#2: ffffffffab647720 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim mm/page_alloc.c:3951 [inline]
> &nbsp;#2: ffffffffab647720 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath.constprop.0+0x50c/0x2170 mm/page_alloc.c:4382
> 2 locks held by kworker/u17:21/125840:
> &nbsp;#0: ff11000001079148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3211 [inline]
> &nbsp;#0: ff11000001079148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x1175/0x1ba0 kernel/workqueue.c:3317
> &nbsp;#1: ffa0000003ec7d98 ((work_completion)(&amp;sub_info-&gt;work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3212 [inline]
> &nbsp;#1: ffa0000003ec7d98 ((work_completion)(&amp;sub_info-&gt;work)){+.+.}-{0:0}, at: process_scheduled_works+0x52f/0x1ba0 kernel/workqueue.c:3317
> 3 locks held by syz.1.17173/127617:
> 2 locks held by syz.8.17184/127686:
> &nbsp;#0: ff1100000acf2420 (sb_writers#3){.+.+}-{0:0}, at: ksys_fallocate+0x55/0xa0 fs/open.c:351
> &nbsp;#1: ff1100000dbde618 (&amp;sb-&gt;s_type-&gt;i_mutex_key#7){++++}-{4:4}, at: inode_lock include/linux/fs.h:818 [inline]
> &nbsp;#1: ff1100000dbde618 (&amp;sb-&gt;s_type-&gt;i_mutex_key#7){++++}-{4:4}, at: ext4_fallocate+0x2dc/0x3810 fs/ext4/extents.c:4796
> 1 lock held by syz.8.17184/127690:
> &nbsp;#0: ff1100000dbde618 (&amp;sb-&gt;s_type-&gt;i_mutex_key#7){++++}-{4:4}, at: inode_lock_shared include/linux/fs.h:828 [inline]
> &nbsp;#0: ff1100000dbde618 (&amp;sb-&gt;s_type-&gt;i_mutex_key#7){++++}-{4:4}, at: ext4_dio_read_iter fs/ext4/file.c:78 [inline]
> &nbsp;#0: ff1100000dbde618 (&amp;sb-&gt;s_type-&gt;i_mutex_key#7){++++}-{4:4}, at: ext4_file_read_iter fs/ext4/file.c:145 [inline]
> &nbsp;#0: ff1100000dbde618 (&amp;sb-&gt;s_type-&gt;i_mutex_key#7){++++}-{4:4}, at: ext4_file_read_iter+0x211/0x410 fs/ext4/file.c:130
> 1 lock held by syz.4.17192/127724:
> &nbsp;#0: ff1100000acf20e0 (&amp;type-&gt;s_umount_key#52){++++}-{4:4}, at: __super_lock fs/super.c:58 [inline]
> &nbsp;#0: ff1100000acf20e0 (&amp;type-&gt;s_umount_key#52){++++}-{4:4}, at: super_lock+0x17a/0x3e0 fs/super.c:120
> 1 lock held by syz.4.17192/127725:
> &nbsp;#0: ff1100000acf20e0 (&amp;type-&gt;s_umount_key#52){++++}-{4:4}, at: __super_lock fs/super.c:58 [inline]
> &nbsp;#0: ff1100000acf20e0 (&amp;type-&gt;s_umount_key#52){++++}-{4:4}, at: super_lock+0x17a/0x3e0 fs/super.c:120
> 1 lock held by syz.4.17192/127726:
> &nbsp;#0: ff1100000acf20e0 (&amp;type-&gt;s_umount_key#52){++++}-{4:4}, at: __super_lock fs/super.c:58 [inline]
> &nbsp;#0: ff1100000acf20e0 (&amp;type-&gt;s_umount_key#52){++++}-{4:4}, at: super_lock+0x17a/0x3e0 fs/super.c:120
> 1 lock held by syz.9.17206/128665:
> &nbsp;#0: ff1100003388f3e0 (&amp;mm-&gt;mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:144 [inline]
> &nbsp;#0: ff1100003388f3e0 (&amp;mm-&gt;mmap_lock){++++}-{4:4}, at: do_madvise mm/madvise.c:1671 [inline]
> &nbsp;#0: ff1100003388f3e0 (&amp;mm-&gt;mmap_lock){++++}-{4:4}, at: do_madvise+0x3dd/0x9c0 mm/madvise.c:1635
> 1 lock held by syz.5.17137/128685:
> &nbsp;#0: ff1100000acf4b98 (&amp;sbi-&gt;s_writepages_rwsem){++++}-{0:0}, at: do_writepages+0x19d/0x7d0 mm/page-writeback.c:2702
> 1 lock held by syz.2.17205/128709:
> &nbsp;#0: ff1100000acf4b98 (&amp;sbi-&gt;s_writepages_rwsem){++++}-{0:0}, at: do_writepages+0x19d/0x7d0 mm/page-writeback.c:2702
> 2 locks held by syz.7.17241/128994:
> &nbsp;#0: ff1100000acf2420 (sb_writers#3){.+.+}-{0:0}, at: do_pwritev+0x1b1/0x270 fs/read_write.c:1146
> &nbsp;#1: ff1100000acf4b98 (&amp;sbi-&gt;s_writepages_rwsem){++++}-{0:0}, at: do_writepages+0x19d/0x7d0 mm/page-writeback.c:2702
> 1 lock held by syz.1.17261/129124:
> &nbsp;#0: ff1100003c6f3ae0 (&amp;mm-&gt;mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:144 [inline]
> &nbsp;#0: ff1100003c6f3ae0 (&amp;mm-&gt;mmap_lock){++++}-{4:4}, at: do_madvise mm/madvise.c:1671 [inline]
> &nbsp;#0: ff1100003c6f3ae0 (&amp;mm-&gt;mmap_lock){++++}-{4:4}, at: do_madvise+0x3dd/0x9c0 mm/madvise.c:1635
> 2 locks held by syz.0.17260/129092:
> &nbsp;#0: ff1100000ecf9ec8 (&amp;sb-&gt;s_type-&gt;i_mutex_key#12){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:818 [inline]
> &nbsp;#0: ff1100000ecf9ec8 (&amp;sb-&gt;s_type-&gt;i_mutex_key#12){+.+.}-{4:4}, at: __sock_release+0x86/0x270 net/socket.c:639
> &nbsp;#1: ffffffffacfb2208 (rtnl_mutex){+.+.}-{4:4}, at: ip_mc_drop_socket+0x92/0x290 net/ipv4/igmp.c:2718
> 3 locks held by syz.5.17276/129138:
> &nbsp;#0: ff1100000acf2420 (sb_writers#3){.+.+}-{0:0}, at: ioctl_setflags fs/ioctl.c:725 [inline]
> &nbsp;#0: ff1100000acf2420 (sb_writers#3){.+.+}-{0:0}, at: do_vfs_ioctl+0x1df/0x1850 fs/ioctl.c:869
> &nbsp;#1: ff1100000ef06fe8 (&amp;sb-&gt;s_type-&gt;i_mutex_key#7){++++}-{4:4}, at: inode_lock include/linux/fs.h:818 [inline]
> &nbsp;#1: ff1100000ef06fe8 (&amp;sb-&gt;s_type-&gt;i_mutex_key#7){++++}-{4:4}, at: vfs_fileattr_set+0x14c/0xa00 fs/ioctl.c:681
> &nbsp;#2: ff1100000acf4b98 (&amp;sbi-&gt;s_writepages_rwsem){++++}-{0:0}, at: ext4_writepages_down_write fs/ext4/ext4.h:1788 [inline]
> &nbsp;#2: ff1100000acf4b98 (&amp;sbi-&gt;s_writepages_rwsem){++++}-{0:0}, at: ext4_ind_migrate+0x23c/0xa10 fs/ext4/migrate.c:626
> 1 lock held by syz.2.17290/129203:
> &nbsp;#0: ff1100003d0794e0 (&amp;mm-&gt;mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:144 [inline]
> &nbsp;#0: ff1100003d0794e0 (&amp;mm-&gt;mmap_lock){++++}-{4:4}, at: do_madvise mm/madvise.c:1671 [inline]
> &nbsp;#0: ff1100003d0794e0 (&amp;mm-&gt;mmap_lock){++++}-{4:4}, at: do_madvise+0x3dd/0x9c0 mm/madvise.c:1635
> 1 lock held by syz.0.17293/129212:
> &nbsp;#0: ff1100000acf4b98 (&amp;sbi-&gt;s_writepages_rwsem){++++}-{0:0}, at: do_writepages+0x19d/0x7d0 mm/page-writeback.c:2702
> 1 lock held by syz.0.17293/129213:
> &nbsp;#0: ff1100000acf4b98 (&amp;sbi-&gt;s_writepages_rwsem){++++}-{0:0}, at: do_writepages+0x19d/0x7d0 mm/page-writeback.c:2702
> 1 lock held by syz.0.17293/129215:
> &nbsp;#0: ff1100000acf4b98 (&amp;sbi-&gt;s_writepages_rwsem){++++}-{0:0}, at: do_writepages+0x19d/0x7d0 mm/page-writeback.c:2702
> 1 lock held by syz.6.17302/129248:
> &nbsp;#0: ff1100000af273e0 (&amp;mm-&gt;mmap_lock){++++}-{4:4}, at: mmap_read_lock include/linux/mmap_lock.h:144 [inline]
> &nbsp;#0: ff1100000af273e0 (&amp;mm-&gt;mmap_lock){++++}-{4:4}, at: do_madvise mm/madvise.c:1671 [inline]
> &nbsp;#0: ff1100000af273e0 (&amp;mm-&gt;mmap_lock){++++}-{4:4}, at: do_madvise+0x3dd/0x9c0 mm/madvise.c:1635
> 2 locks held by syz.3.17305/129251:
> &nbsp;#0: ff1100000acf2420 (sb_writers#3){.+.+}-{0:0}, at: ksys_fallocate+0x55/0xa0 fs/open.c:351
> &nbsp;#1: ff1100000db83508 (&amp;sb-&gt;s_type-&gt;i_mutex_key#7){++++}-{4:4}, at: inode_lock include/linux/fs.h:818 [inline]
> &nbsp;#1: ff1100000db83508 (&amp;sb-&gt;s_type-&gt;i_mutex_key#7){++++}-{4:4}, at: ext4_zero_range fs/ext4/extents.c:4607 [inline]
> &nbsp;#1: ff1100000db83508 (&amp;sb-&gt;s_type-&gt;i_mutex_key#7){++++}-{4:4}, at: ext4_fallocate+0xc98/0x3810 fs/ext4/extents.c:4787
> 2 locks held by syz.0.17314/129284:
> &nbsp;#0: ff1100000acf2420 (sb_writers#3){.+.+}-{0:0}, at: ksys_fallocate+0x55/0xa0 fs/open.c:351
> &nbsp;#1: ff1100000fcd5c48 (&amp;sb-&gt;s_type-&gt;i_mutex_key#7){++++}-{4:4}, at: inode_lock include/linux/fs.h:818 [inline]
> &nbsp;#1: ff1100000fcd5c48 (&amp;sb-&gt;s_type-&gt;i_mutex_key#7){++++}-{4:4}, at: ext4_fallocate+0x2dc/0x3810 fs/ext4/extents.c:4796
> 1 lock held by syz.0.17314/129285:
> &nbsp;#0: ff1100000fcd5c48 (&amp;sb-&gt;s_type-&gt;i_mutex_key#7){++++}-{4:4}, at: inode_lock_shared include/linux/fs.h:828 [inline]
> &nbsp;#0: ff1100000fcd5c48 (&amp;sb-&gt;s_type-&gt;i_mutex_key#7){++++}-{4:4}, at: ext4_dio_read_iter fs/ext4/file.c:78 [inline]
> &nbsp;#0: ff1100000fcd5c48 (&amp;sb-&gt;s_type-&gt;i_mutex_key#7){++++}-{4:4}, at: ext4_file_read_iter fs/ext4/file.c:145 [inline]
> &nbsp;#0: ff1100000fcd5c48 (&amp;sb-&gt;s_type-&gt;i_mutex_key#7){++++}-{4:4}, at: ext4_file_read_iter+0x211/0x410 fs/ext4/file.c:130
> 3 locks held by syz-executor/129398:
> &nbsp;#0: ffffffffac415aa0 (&amp;ops-&gt;srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:158 [inline]
> &nbsp;#0: ffffffffac415aa0 (&amp;ops-&gt;srcu){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:249 [inline]
> &nbsp;#0: ffffffffac415aa0 (&amp;ops-&gt;srcu){.+.+}-{0:0}, at: rtnl_link_ops_get+0x116/0x2c0 net/core/rtnetlink.c:559
> &nbsp;#1: ffffffffacfb2208 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
> &nbsp;#1: ffffffffacfb2208 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:326 [inline]
> &nbsp;#1: ffffffffacfb2208 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x77c/0x1cb0 net/core/rtnetlink.c:4011
> &nbsp;#2: ffffffffab647720 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:3926 [inline]
> &nbsp;#2: ffffffffab647720 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim mm/page_alloc.c:3951 [inline]
> &nbsp;#2: ffffffffab647720 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath.constprop.0+0x50c/0x2170 mm/page_alloc.c:4382
> 1 lock held by syz-executor/129430:
> &nbsp;#0: ffffffffab647720 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:3926 [inline]
> &nbsp;#0: ffffffffab647720 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim mm/page_alloc.c:3951 [inline]
> &nbsp;#0: ffffffffab647720 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath.constprop.0+0x50c/0x2170 mm/page_alloc.c:4382
> 2 locks held by modprobe/129433:
> &nbsp;#0: ff1100003d0781e0 (&amp;mm-&gt;mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:122 [inline]
> &nbsp;#0: ff1100003d0781e0 (&amp;mm-&gt;mmap_lock){++++}-{4:4}, at: setup_arg_pages+0x2a8/0xce0 fs/exec.c:770
> &nbsp;#1: ffffffffab647720 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:3926 [inline]
> &nbsp;#1: ffffffffab647720 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim mm/page_alloc.c:3951 [inline]
> &nbsp;#1: ffffffffab647720 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_slowpath.constprop.0+0x50c/0x2170 mm/page_alloc.c:4382
> 1 lock held by syz-executor/129434:
> &nbsp;#0: ff110000102f0f58 (mapping.invalidate_lock){++++}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:873 [inline]
> &nbsp;#0: ff110000102f0f58 (mapping.invalidate_lock){++++}-{4:4}, at: page_cache_ra_unbounded+0x159/0x690 mm/readahead.c:226
> 1 lock held by syz-executor/129435:
> &nbsp;#0: ff110000102f0f58 (mapping.invalidate_lock){++++}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:873 [inline]
> &nbsp;#0: ff110000102f0f58 (mapping.invalidate_lock){++++}-{4:4}, at: page_cache_ra_unbounded+0x159/0x690 mm/readahead.c:226
> 1 lock held by syz-executor/129436:
> &nbsp;#0: ff110000102f0f58 (mapping.invalidate_lock){++++}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:873 [inline]
> &nbsp;#0: ff110000102f0f58 (mapping.invalidate_lock){++++}-{4:4}, at: page_cache_ra_unbounded+0x159/0x690 mm/readahead.c:226
> 1 lock held by syz-executor/129437:
> &nbsp;#0: ff110000102f0f58 (mapping.invalidate_lock){++++}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:873 [inline]
> &nbsp;#0: ff110000102f0f58 (mapping.invalidate_lock){++++}-{4:4}, at: filemap_fault+0xe80/0x2ec0 mm/filemap.c:3323
> 1 lock held by syz-executor/129438:
> &nbsp;#0: ff110000102f0f58 (mapping.invalidate_lock){++++}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:873 [inline]
> &nbsp;#0: ff110000102f0f58 (mapping.invalidate_lock){++++}-{4:4}, at: filemap_fault+0xe80/0x2ec0 mm/filemap.c:3323
> 
> 
> =============================================
> 
> 
> 
> 
> 
> 
> ------------------------------
> thanks,
> Kun Hu
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

