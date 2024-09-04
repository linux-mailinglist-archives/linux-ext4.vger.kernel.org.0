Return-Path: <linux-ext4+bounces-4046-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E752196BA03
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Sep 2024 13:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27D59B24B0B
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Sep 2024 11:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218EA1CC887;
	Wed,  4 Sep 2024 11:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H3NNx1J0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/m/OaTc6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hzCu8bVx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F84ScicO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA20F126C01;
	Wed,  4 Sep 2024 11:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448012; cv=none; b=AdYnh0kMkXcEdK23oxtCtw6JvcBSo8YRQItFb2YGwQWbTP9fmhIitTO6nF9CiSZ4mg7cS64karD3TRDfiMXStTYNhFPzjKVCjalNYeNluMkE9tFGjZfiUSr6mdIvkafBat9XaGMP+dtvMIJ6z/Czb1Podi2UVKdi4wQAUCozezI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448012; c=relaxed/simple;
	bh=iyFsB9w/BfiEK+2JD52l/ygDFu6jxlsKnxYOvNbQ/TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pV9rg2BG8aAen5SrhGfKUHZ6jOFq86zdweDrEzoDaQ8SEJWG1yilJC3CnZux5fPt3++iRcZA9z0U+2l56599NG/ycaTMgtSfDu+lCKCti7ONTb+aK/4j2HfDM4hwTmLilpQ16OU1YZh0r5pi6HyHtaQ4RVrq+GdbIQqEGtjVB+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H3NNx1J0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/m/OaTc6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hzCu8bVx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F84ScicO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D46ED1F7BA;
	Wed,  4 Sep 2024 11:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725448009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2wjHT+CTi4rzAM99ML4jx9KseTfu3PzE3W6dX5KB1zk=;
	b=H3NNx1J0d/SRdx7OfwpTBmcR8JjJtkODzpHpzxY0pgM8m1M5Lx+yVR3O9uqf2uS7pybCqm
	hzg/C6sJg8/XDkEln532j7UYWSxAzXcDGhPfzz0MA6cJ92LtqDwKEXKpL2lZky7tRXlSV8
	Vv2CPNtxKGB13DlPSgdNqevM35IK+00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725448009;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2wjHT+CTi4rzAM99ML4jx9KseTfu3PzE3W6dX5KB1zk=;
	b=/m/OaTc6A5/NtKk+C09XBhGnRpFrFWUNsFzfJPhP1NxRccdzVzm5BHmZD5z1xeIYLPelHh
	mLVNMsSZWzEgN5Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725448008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2wjHT+CTi4rzAM99ML4jx9KseTfu3PzE3W6dX5KB1zk=;
	b=hzCu8bVxUwptUF2e2lCkAV7dpO51/q3zaNBRihVfa/ATupBGjC1iVImkiNRJYvWlnHykpY
	Vnbt1y8aGSRCtZYChuh+iehaAiJb7aBCKk+TbDp0daQ/gBmufyU6jkurFI3nbus02bS5/0
	L11YS9S8GeHfnCZ7jN/0mmVxvFxpOgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725448008;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2wjHT+CTi4rzAM99ML4jx9KseTfu3PzE3W6dX5KB1zk=;
	b=F84ScicOA/LrtcEXUt9wZojuVEIkv1OILjpEUHLg+TF/88SGQsIWfg7YvjmpstJBWMcHee
	Q0geXZ6JbdEpWBDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4EE2139E2;
	Wed,  4 Sep 2024 11:06:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I/kSMEg/2GZ0NQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Sep 2024 11:06:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4E326A0968; Wed,  4 Sep 2024 13:06:44 +0200 (CEST)
Date: Wed, 4 Sep 2024 13:06:44 +0200
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+c28d8da3e83b3cc68dc6@syzkaller.appspotmail.com>
Cc: jack@suse.com, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: [syzbot] [ext4?] kernel BUG in jbd2_journal_dirty_metadata
Message-ID: <20240904110644.g52vgotsmi4lm56c@quack3>
References: <00000000000042f2c5062143e9fd@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000042f2c5062143e9fd@google.com>
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=996585887acdadb3];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[c28d8da3e83b3cc68dc6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 03-09-24 21:50:20, syzbot wrote:
> syzbot found the following issue on:
> 
> HEAD commit:    fb24560f31f9 Merge tag 'lsm-pr-20240830' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1739530b980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=996585887acdadb3
> dashboard link: https://syzkaller.appspot.com/bug?extid=c28d8da3e83b3cc68dc6
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-fb24560f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2d39db26a2bc/vmlinux-fb24560f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/8910481ae16e/bzImage-fb24560f.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c28d8da3e83b3cc68dc6@syzkaller.appspotmail.com
> 
> loop0: detected capacity change from 0 to 32768
> =======================================================
> WARNING: The mand mount option has been deprecated and
>          and is ignored by this kernel. Remove the mand
>          option from the mount to silence this warning.
> =======================================================
> ocfs2: Mounting device (7,0) on (node local, slot 0) with ordered data mode.
> loop0: detected capacity change from 32768 to 0
> syz.0.0: attempt to access beyond end of device
> loop0: rw=0, sector=10576, nr_sectors = 1 limit=0
> (syz.0.0,5108,0):__ocfs2_xattr_set_value_outside:1385 ERROR: status = -5

Looks like ocfs2 issue, not ext4.

#syz set ocfs2

								Honza


> (syz.0.0,5108,0):ocfs2_xa_set:2261 ERROR: status = -5
> (syz.0.0,5108,0):__ocfs2_journal_access:705 ERROR: Error -30 getting 1 access to buffer!
> (syz.0.0,5108,0):ocfs2_journal_access_path:751 ERROR: status = -30
> (syz.0.0,5108,0):ocfs2_truncate_rec:5443 ERROR: status = -30
> (syz.0.0,5108,0):ocfs2_remove_extent:5584 ERROR: status = -30
> (syz.0.0,5108,0):__ocfs2_remove_xattr_range:782 ERROR: status = -30
> (syz.0.0,5108,0):ocfs2_xattr_shrink_size:836 ERROR: status = -30
> (syz.0.0,5108,0):__ocfs2_journal_access:705 ERROR: Error -30 getting 1 access to buffer!
> (syz.0.0,5108,0):ocfs2_xa_prepare_entry:2152 ERROR: status = -30
> (syz.0.0,5108,0):ocfs2_xa_set:2255 ERROR: status = -30
> ------------[ cut here ]------------
> kernel BUG at fs/jbd2/transaction.c:1513!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 0 UID: 0 PID: 5108 Comm: syz.0.0 Not tainted 6.11.0-rc5-syzkaller-00207-gfb24560f31f9 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:jbd2_journal_dirty_metadata+0xbab/0xc00 fs/jbd2/transaction.c:1512
> Code: ff e9 74 fc ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c af fc ff ff 4c 89 ef e8 30 27 8a ff e9 a2 fc ff ff e8 66 dc 22 ff 90 <0f> 0b 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 95 fd ff ff 48 89 df e8
> RSP: 0018:ffffc90002d7ea38 EFLAGS: 00010283
> RAX: ffffffff8270afca RBX: ffff88801240bca0 RCX: 0000000000040000
> RDX: ffffc90003092000 RSI: 00000000000081b4 RDI: 00000000000081b5
> RBP: 1ffff11002481794 R08: 0000000000000003 R09: fffff520005afd38
> R10: dffffc0000000000 R11: fffff520005afd38 R12: ffff88801240bc98
> R13: 1ffff110065e591e R14: ffff88801240a000 R15: ffff88801240bc38
> FS:  00007f28379866c0(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000200010c0 CR3: 000000003ce4c000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  ocfs2_journal_dirty+0x156/0x7c0 fs/ocfs2/journal.c:812
>  ocfs2_xa_journal_dirty fs/ocfs2/xattr.c:1453 [inline]
>  ocfs2_xa_set+0x225b/0x2b40 fs/ocfs2/xattr.c:2264
>  ocfs2_xattr_block_set+0x46e/0x3390 fs/ocfs2/xattr.c:2986
>  __ocfs2_xattr_set_handle+0x67a/0x10a0 fs/ocfs2/xattr.c:3388
>  ocfs2_xattr_set+0x128c/0x1930 fs/ocfs2/xattr.c:3651
>  __vfs_setxattr+0x468/0x4a0 fs/xattr.c:200
>  __vfs_setxattr_noperm+0x12e/0x660 fs/xattr.c:234
>  vfs_setxattr+0x221/0x430 fs/xattr.c:321
>  do_setxattr fs/xattr.c:629 [inline]
>  path_setxattr+0x37e/0x4d0 fs/xattr.c:658
>  __do_sys_setxattr fs/xattr.c:676 [inline]
>  __se_sys_setxattr fs/xattr.c:672 [inline]
>  __x64_sys_setxattr+0xbb/0xd0 fs/xattr.c:672
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f2836b79eb9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f2837986038 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
> RAX: ffffffffffffffda RBX: 00007f2836d15f80 RCX: 00007f2836b79eb9
> RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000020000080
> RBP: 00007f2836be793e R08: 0000000000000002 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f2836d15f80 R15: 00007ffdcb3dd268
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:jbd2_journal_dirty_metadata+0xbab/0xc00 fs/jbd2/transaction.c:1512
> Code: ff e9 74 fc ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c af fc ff ff 4c 89 ef e8 30 27 8a ff e9 a2 fc ff ff e8 66 dc 22 ff 90 <0f> 0b 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 95 fd ff ff 48 89 df e8
> RSP: 0018:ffffc90002d7ea38 EFLAGS: 00010283
> RAX: ffffffff8270afca RBX: ffff88801240bca0 RCX: 0000000000040000
> RDX: ffffc90003092000 RSI: 00000000000081b4 RDI: 00000000000081b5
> RBP: 1ffff11002481794 R08: 0000000000000003 R09: fffff520005afd38
> R10: dffffc0000000000 R11: fffff520005afd38 R12: ffff88801240bc98
> R13: 1ffff110065e591e R14: ffff88801240a000 R15: ffff88801240bc38
> FS:  00007f28379866c0(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000200010c0 CR3: 000000003ce4c000 CR4: 0000000000350ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

