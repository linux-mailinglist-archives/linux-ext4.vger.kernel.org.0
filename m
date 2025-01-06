Return-Path: <linux-ext4+bounces-5899-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C857DA028D9
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jan 2025 16:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A130316409B
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jan 2025 15:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59033145B3E;
	Mon,  6 Jan 2025 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SEu3uW2b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6ewdw48y";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SEu3uW2b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6ewdw48y"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254F069D2B;
	Mon,  6 Jan 2025 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736176450; cv=none; b=BEji8qchVv459Uvc8xAa/B9CJe2JIiekl/eV+OH1TRNK+ewuT+JyqRoLceQwxLxAxaEKQhZZit8s+zEJI9Ei4KWce3zjWUhsJmSleEW7aDtbK2DpaUhkR0kC4wofOQUeXHBuWePM4dgeVbADJcEr35D1YC47y8BjN2w1WP7IaeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736176450; c=relaxed/simple;
	bh=oyHj87RmDfAv1jF8grtW1Goe4ueqTXTTIEXqFMhW0tY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3mXrtQOs2+Gffz0cqAxTEKsTFK6Jw74tzI0JzfZxJlYIiOGxCqpGpsGzZBNLvYIdXzHCk/bdhi24WQg3Cy6HE06TY8n+2JHif+5LrF/P+jMfnCCTHF52NhNMH7GMQn3jbVPtQqgFVKABI6ySxtGv5Nj/HelDsUBCZjrAe6Lp+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SEu3uW2b; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6ewdw48y; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SEu3uW2b; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6ewdw48y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3D1691F392;
	Mon,  6 Jan 2025 15:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736176447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mCIRQlbE+LKdM5veFpfqL6JODtgabhTAFuOo/hl6n0c=;
	b=SEu3uW2bpQSho20H0GOVudzWJqj9LXDVbtLzEgS/lbeZbdd5h6iSip4DFE+8vNjhRApQaE
	mogzD2WsZnpXUozGHBCFipHehtSEtVWnZN0Kp/pzU6qtsxQg2pxtXLL/DOgXZBIFSqQHuO
	Y/hK2mCDNeSU2fJvSmYmLUl1ux3/NmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736176447;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mCIRQlbE+LKdM5veFpfqL6JODtgabhTAFuOo/hl6n0c=;
	b=6ewdw48yoozOFBXPUH+eI/gAyV8RAlrYk+U4GqmBR9ziE9+ylX/ABBOAuV+70jsYH8G1UN
	/ilth1MEZ2pAYDBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SEu3uW2b;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6ewdw48y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736176447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mCIRQlbE+LKdM5veFpfqL6JODtgabhTAFuOo/hl6n0c=;
	b=SEu3uW2bpQSho20H0GOVudzWJqj9LXDVbtLzEgS/lbeZbdd5h6iSip4DFE+8vNjhRApQaE
	mogzD2WsZnpXUozGHBCFipHehtSEtVWnZN0Kp/pzU6qtsxQg2pxtXLL/DOgXZBIFSqQHuO
	Y/hK2mCDNeSU2fJvSmYmLUl1ux3/NmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736176447;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mCIRQlbE+LKdM5veFpfqL6JODtgabhTAFuOo/hl6n0c=;
	b=6ewdw48yoozOFBXPUH+eI/gAyV8RAlrYk+U4GqmBR9ziE9+ylX/ABBOAuV+70jsYH8G1UN
	/ilth1MEZ2pAYDBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 328D4139AB;
	Mon,  6 Jan 2025 15:14:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cpVUDD/ze2elRgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 06 Jan 2025 15:14:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C91C8A089C; Mon,  6 Jan 2025 16:14:06 +0100 (CET)
Date: Mon, 6 Jan 2025 16:14:06 +0100
From: Jan Kara <jack@suse.cz>
To: Liebes Wang <wanghaichi0403@gmail.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, ocfs2-devel@lists.linux.dev
Subject: Re: WARNING in jbd2_journal_update_sb_log_tail
Message-ID: <mzypseklhk6colsb5fh42ya74x43z5mmkzdjdyluesx6hb744a@hycbebanf7mv>
References: <CADCV8sq0E9_tmBbedYdUJyD4=yyjSngp2ZGVR2VfZfD0Q1nUFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADCV8sq0E9_tmBbedYdUJyD4=yyjSngp2ZGVR2VfZfD0Q1nUFQ@mail.gmail.com>
X-Rspamd-Queue-Id: 3D1691F392
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 31-12-24 13:53:23, Liebes Wang wrote:
> Dear Linux maintainers and reviewers:
> 
> We are reporting a Linux kernel bug titled **WARNING in
> jbd2_journal_update_sb_log_tail**, discovered using a modified version of
> Syzkaller.

Very likely this is actually some issue with ocfs2 since the only thing the
reproducer seems to be doing is that it is mounting ocfs2 image. Joseph,
can you have a look please?

								Honza

> Linux version: v6.12-rc6:59b723cd2adbac2a34fc8e12c74ae26ae45bf230 (crash is
> also reproduced in the latest kernel version)
> The test case and kernel config is in attach.
> 
> The warning report is (The full report is attached):
> 
> WARNING: CPU: 0 PID: 6139 at fs/jbd2/journal.c:1887
> jbd2_journal_update_sb_log_tail+0x32d/0x3b0 fs/jbd2/journal.c:1887
> Modules linked in:
> CPU: 0 UID: 0 PID: 6139 Comm: syz.7.135 Not tainted 6.12.0-rc6 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> RIP: 0010:jbd2_journal_update_sb_log_tail+0x32d/0x3b0 fs/jbd2/journal.c:1887
> Code: fe ff ff e8 05 0e a7 ff e9 f4 fd ff ff e8 eb 0e a7 ff e9 16 ff ff ff
> 4c 89 ef e8 de 0e a7 ff e9 d5 fe ff ff e8 94 ec 54 ff 90 <0f> 0b 90 eb 88
> 41 bc fb ff ff ff e9 13 ff ff ff e8 7e ec 54 ff be
> RSP: 0018:ff1100013b6ff818 EFLAGS: 00010246
> RAX: 0000000000040000 RBX: 0000000000000000 RCX: ffa00000034b3000
> RDX: 0000000000040000 RSI: ffffffff81fd15ec RDI: 0000000000000005
> RBP: ff110001405ce000 R08: 0000000000000001 R09: ffe21c00276dfef5
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: ff11000107e3a018 R14: ff11000107e3a000 R15: ff110001405ce0b0
> FS:  00007ff345cd5700(0000) GS:ff110004ca800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ff3470375c0 CR3: 0000000117544001 CR4: 0000000000771ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 80000000
> Call Trace:
>  <TASK>
>  journal_reset fs/jbd2/journal.c:1779 [inline]
>  jbd2_journal_load fs/jbd2/journal.c:2109 [inline]
>  jbd2_journal_load+0x93e/0xcf0 fs/jbd2/journal.c:2074
>  ocfs2_journal_load+0xbe/0x5e0 fs/ocfs2/journal.c:1143
>  ocfs2_check_volume fs/ocfs2/super.c:2421 [inline]
>  ocfs2_mount_volume fs/ocfs2/super.c:1817 [inline]
>  ocfs2_fill_super+0x19f1/0x4170 fs/ocfs2/super.c:1084
>  mount_bdev+0x1e6/0x2d0 fs/super.c:1693
>  legacy_get_tree+0x107/0x220 fs/fs_context.c:662
>  vfs_get_tree+0x94/0x380 fs/super.c:1814
>  do_new_mount fs/namespace.c:3507 [inline]
>  path_mount+0x6b2/0x1eb0 fs/namespace.c:3834
>  do_mount fs/namespace.c:3847 [inline]
>  __do_sys_mount fs/namespace.c:4057 [inline]
>  __se_sys_mount fs/namespace.c:4034 [inline]
>  __x64_sys_mount+0x283/0x300 fs/namespace.c:4034
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc1/0x1d0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f




-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

