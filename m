Return-Path: <linux-ext4+bounces-13464-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLaiOgPUgGmFBwMAu9opvQ
	(envelope-from <linux-ext4+bounces-13464-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Feb 2026 17:42:43 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BDBCF161
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Feb 2026 17:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFC7A305F49C
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Feb 2026 16:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFA237F0F5;
	Mon,  2 Feb 2026 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fx5wjh44";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KFAK/ZMV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fx5wjh44";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KFAK/ZMV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E45837E2E5
	for <linux-ext4@vger.kernel.org>; Mon,  2 Feb 2026 16:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770050272; cv=none; b=sittInOYvL5isIuOxU6h1M0JDpb93x2pHn6XK7FwIpwUpfT102gYAGgv2bAHMwt63Za9tRtRaQfV/9eFQgEjqt30UPTg+jqh1fIR+rZv1Kl4KR+mQ3Op9H0giLmKxs00dm5wG6B8hwbi9uWtXywttstO3/rnIvp6WHk9u2n69fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770050272; c=relaxed/simple;
	bh=O3Q1f7xLSbm5ZFmQ/HIZekK8EkEfjgQxbB/IzS0VHgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxv8mJ3zK6cumIL6Tiq9b8HEYEoJ3xMqDDIKfyMKVEPgJL87bnzsFmkGC/sHcGMZXkMjHC30YkPqAz2sJLU9C66X4geEoM+aMGCGsryb5e6Xi/MfiZ+Nspud0EUhI9oC5fhVyQijMfOFSrgjlBHutY+mscnuohngreDP06v35J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fx5wjh44; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KFAK/ZMV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fx5wjh44; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KFAK/ZMV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6CDF15BCC7;
	Mon,  2 Feb 2026 16:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770050269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=la4DI70jM2hQnuKvDWFEOU3Kuxa/o5qPD6TR3lj5DP0=;
	b=fx5wjh44x0dsHzFMq5QSw9F5mqw9NjAckbYRzYzv9Joxz7rg3NWi0Ul+/ekQ6GEK5e4WAU
	cyrDa77iaBgNLnTjcPQ570Rear8aJPInDxUyZJJqVYes92K44kCT1ywsS4CE9EOiptUMy8
	vWyWl+72r+AtBxfzMpCpZGAFVV+7A/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770050269;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=la4DI70jM2hQnuKvDWFEOU3Kuxa/o5qPD6TR3lj5DP0=;
	b=KFAK/ZMVBkfBKIbq42kedxG5DDSfWhwX7DEIVcI3jPnpNa1nV3zL9TxEMG1ILRoGpuUS8A
	J2lJAqr5jAebsADg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770050269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=la4DI70jM2hQnuKvDWFEOU3Kuxa/o5qPD6TR3lj5DP0=;
	b=fx5wjh44x0dsHzFMq5QSw9F5mqw9NjAckbYRzYzv9Joxz7rg3NWi0Ul+/ekQ6GEK5e4WAU
	cyrDa77iaBgNLnTjcPQ570Rear8aJPInDxUyZJJqVYes92K44kCT1ywsS4CE9EOiptUMy8
	vWyWl+72r+AtBxfzMpCpZGAFVV+7A/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770050269;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=la4DI70jM2hQnuKvDWFEOU3Kuxa/o5qPD6TR3lj5DP0=;
	b=KFAK/ZMVBkfBKIbq42kedxG5DDSfWhwX7DEIVcI3jPnpNa1nV3zL9TxEMG1ILRoGpuUS8A
	J2lJAqr5jAebsADg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 557833EA62;
	Mon,  2 Feb 2026 16:37:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C1bUFN3SgGnzawAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Feb 2026 16:37:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0B479A08F8; Mon,  2 Feb 2026 17:37:49 +0100 (CET)
Date: Mon, 2 Feb 2026 17:37:48 +0100
From: Jan Kara <jack@suse.cz>
To: Li Chen <me@linux.beauty>
Cc: Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] ext4: publish jinode after initialization
Message-ID: <vrtwp467z7npa2uppdntauxfzexgaa4vja3nueqdcn7z6e7zll@hj3tjryw2dst>
References: <20260130025339.51519-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130025339.51519-1-me@linux.beauty>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_FROM(0.00)[bounces-13464-lists,linux-ext4=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.cz:dkim,linux.beauty:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 63BDBCF161
X-Rspamd-Action: no action

On Fri 30-01-26 10:53:38, Li Chen wrote:
> ext4_inode_attach_jinode() publishes ei->jinode to concurrent users.
> It used to set ei->jinode before jbd2_journal_init_jbd_inode(),
> allowing a reader to observe a non-NULL jinode with i_vfs_inode
> still unset.
> 
> The fast commit flush path can then pass this jinode to
> jbd2_wait_inode_data(), which dereferences i_vfs_inode->i_mapping and
> may crash.
> 
> Below is the crash I observe:
> ```
> BUG: unable to handle page fault for address: 000000010beb47f4
> PGD 110e51067 P4D 110e51067 PUD 0
> Oops: Oops: 0000 [#1] SMP NOPTI
> CPU: 1 UID: 0 PID: 4850 Comm: fc_fsync_bench_ Not tainted 6.18.0-00764-g795a690c06a5 #1 PREEMPT(voluntary)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.17.0-2-2 04/01/2014
> RIP: 0010:xas_find_marked+0x3d/0x2e0
> Code: e0 03 48 83 f8 02 0f 84 f0 01 00 00 48 8b 47 08 48 89 c3 48 39 c6 0f 82 fd 01 00 00 48 85 c9 74 3d 48 83 f9 03 77 63 4c 8b 0f <49> 8b 71 08 48 c7 47 18 00 00 00 00 48 89 f1 83 e1 03 48 83 f9 02
> RSP: 0018:ffffbbee806e7bf0 EFLAGS: 00010246
> RAX: 000000000010beb4 RBX: 000000000010beb4 RCX: 0000000000000003
> RDX: 0000000000000001 RSI: 0000002000300000 RDI: ffffbbee806e7c10
> RBP: 0000000000000001 R08: 0000002000300000 R09: 000000010beb47ec
> R10: ffff9ea494590090 R11: 0000000000000000 R12: 0000002000300000
> R13: ffffbbee806e7c90 R14: ffff9ea494513788 R15: ffffbbee806e7c88
> FS: 00007fc2f9e3e6c0(0000) GS:ffff9ea6b1444000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000010beb47f4 CR3: 0000000119ac5000 CR4: 0000000000750ef0
> PKRU: 55555554
> Call Trace:
> <TASK>
> filemap_get_folios_tag+0x87/0x2a0
> __filemap_fdatawait_range+0x5f/0xd0
> ? srso_alias_return_thunk+0x5/0xfbef5
> ? __schedule+0x3e7/0x10c0
> ? srso_alias_return_thunk+0x5/0xfbef5
> ? srso_alias_return_thunk+0x5/0xfbef5
> ? srso_alias_return_thunk+0x5/0xfbef5
> ? preempt_count_sub+0x5f/0x80
> ? srso_alias_return_thunk+0x5/0xfbef5
> ? cap_safe_nice+0x37/0x70
> ? srso_alias_return_thunk+0x5/0xfbef5
> ? preempt_count_sub+0x5f/0x80
> ? srso_alias_return_thunk+0x5/0xfbef5
> filemap_fdatawait_range_keep_errors+0x12/0x40
> ext4_fc_commit+0x697/0x8b0
> ? ext4_file_write_iter+0x64b/0x950
> ? srso_alias_return_thunk+0x5/0xfbef5
> ? preempt_count_sub+0x5f/0x80
> ? srso_alias_return_thunk+0x5/0xfbef5
> ? vfs_write+0x356/0x480
> ? srso_alias_return_thunk+0x5/0xfbef5
> ? preempt_count_sub+0x5f/0x80
> ext4_sync_file+0xf7/0x370
> do_fsync+0x3b/0x80
> ? syscall_trace_enter+0x108/0x1d0
> __x64_sys_fdatasync+0x16/0x20
> do_syscall_64+0x62/0x2c0
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> ...
> ```
> 
> Fix this by initializing the jbd2_inode first.
> Use smp_wmb() and WRITE_ONCE() to publish ei->jinode after
> initialization. Readers use READ_ONCE() to fetch the pointer.
> 
> Fixes: a361293f5fede ("jbd2: Fix oops in jbd2_journal_file_inode()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Li Chen <me@linux.beauty>

Looks pretty good. Some small comments below.

> ---
> 
> Changes since v1:
> - Publish EXT4_I(inode)->jinode with smp_wmb() + WRITE_ONCE(), and fetch it
>   with READ_ONCE() (instead of smp_store_release()/smp_load_acquire()), as
>   suggeted by Jan.

... 

> diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
> index 63d17c5201b5..2d5343441b71 100644
> --- a/fs/ext4/ext4_jbd2.h
> +++ b/fs/ext4/ext4_jbd2.h
> @@ -336,18 +336,26 @@ static inline int ext4_journal_force_commit(journal_t *journal)
>  static inline int ext4_jbd2_inode_add_write(handle_t *handle,
>  		struct inode *inode, loff_t start_byte, loff_t length)
>  {
> -	if (ext4_handle_valid(handle))
> +	if (ext4_handle_valid(handle)) {
> +		struct jbd2_inode *jinode;
> +
> +		jinode = READ_ONCE(EXT4_I(inode)->jinode);
>  		return jbd2_journal_inode_ranged_write(handle,
> -				EXT4_I(inode)->jinode, start_byte, length);
> +				jinode, start_byte, length);
> +	}
>  	return 0;
>  }
>  
>  static inline int ext4_jbd2_inode_add_wait(handle_t *handle,
>  		struct inode *inode, loff_t start_byte, loff_t length)
>  {
> -	if (ext4_handle_valid(handle))
> +	if (ext4_handle_valid(handle)) {
> +		struct jbd2_inode *jinode;
> +
> +		jinode = READ_ONCE(EXT4_I(inode)->jinode);
>  		return jbd2_journal_inode_ranged_wait(handle,
> -				EXT4_I(inode)->jinode, start_byte, length);
> +				jinode, start_byte, length);
> +	}
>  	return 0;
>  }

After some thought these two are guaranteed to be called about
EXT4_I(inode)->jinode is set and once set jinode never changes so I don't
think we need to change anything here (and it's actually somewhat
confusing because if jinode could be changing
jbd2_journal_inode_ranged_wait() could crash...).

> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index f575751f1cae..a80ed2d6df81 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -972,16 +972,19 @@ static int ext4_fc_flush_data(journal_t *journal)
>  	struct super_block *sb = journal->j_private;
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  	struct ext4_inode_info *ei;
> +	struct jbd2_inode *jinode;
>  	int ret = 0;
>  
>  	list_for_each_entry(ei, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
> -		ret = jbd2_submit_inode_data(journal, ei->jinode);
> +		jinode = READ_ONCE(ei->jinode);
> +		ret = jbd2_submit_inode_data(journal, jinode);
>  		if (ret)
>  			return ret;
>  	}
>  
>  	list_for_each_entry(ei, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
> -		ret = jbd2_wait_inode_data(journal, ei->jinode);
> +		jinode = READ_ONCE(ei->jinode);
> +		ret = jbd2_wait_inode_data(journal, jinode);
>  		if (ret)
>  			return ret;
>  	}

Perhaps we don't need the intermediate variable here and can just write:

		ret = jbd2_submit_inode_data(journal, READ_ONCE(ei->jinode));

and similarly with jbd2_wait_inode_data().

> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index da96db5f2345..d99296d7315f 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -128,6 +128,8 @@ void ext4_inode_csum_set(struct inode *inode, struct ext4_inode *raw,
>  static inline int ext4_begin_ordered_truncate(struct inode *inode,
>  					      loff_t new_size)
>  {
> +	struct jbd2_inode *jinode = READ_ONCE(EXT4_I(inode)->jinode);
> +
>  	trace_ext4_begin_ordered_truncate(inode, new_size);
>  	/*
>  	 * If jinode is zero, then we never opened the file for
> @@ -135,10 +137,10 @@ static inline int ext4_begin_ordered_truncate(struct inode *inode,
>  	 * jbd2_journal_begin_ordered_truncate() since there's no
>  	 * outstanding writes we need to flush.
>  	 */
> -	if (!EXT4_I(inode)->jinode)
> +	if (!jinode)
>  		return 0;
>  	return jbd2_journal_begin_ordered_truncate(EXT4_JOURNAL(inode),
> -						   EXT4_I(inode)->jinode,
> +						   jinode,
>  						   new_size);
>  }
>  
> @@ -4478,8 +4480,13 @@ int ext4_inode_attach_jinode(struct inode *inode)
>  			spin_unlock(&inode->i_lock);
>  			return -ENOMEM;
>  		}
> -		ei->jinode = jinode;
> -		jbd2_journal_init_jbd_inode(ei->jinode, inode);
> +		jbd2_journal_init_jbd_inode(jinode, inode);
> +		/*
> +		 * Publish ->jinode only after it is fully initialized so that
> +		 * readers never observe a partially initialized jbd2_inode.


> +		 */
> +		smp_wmb();
> +		WRITE_ONCE(ei->jinode, jinode);
>  		jinode = NULL;
>  	}
>  	spin_unlock(&inode->i_lock);
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 69eb63dde983..5cf6c2b54bbb 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1526,17 +1526,20 @@ static void destroy_inodecache(void)
>  
>  void ext4_clear_inode(struct inode *inode)
>  {
> +	struct jbd2_inode *jinode;
> +
>  	ext4_fc_del(inode);
>  	invalidate_inode_buffers(inode);
>  	clear_inode(inode);
>  	ext4_discard_preallocations(inode);
>  	ext4_es_remove_extent(inode, 0, EXT_MAX_BLOCKS);
>  	dquot_drop(inode);
> -	if (EXT4_I(inode)->jinode) {
> +	jinode = READ_ONCE(EXT4_I(inode)->jinode);
> +	if (jinode) {
>  		jbd2_journal_release_jbd_inode(EXT4_JOURNAL(inode),
> -					       EXT4_I(inode)->jinode);
> -		jbd2_free_inode(EXT4_I(inode)->jinode);
> -		EXT4_I(inode)->jinode = NULL;
> +					       jinode);
> +		jbd2_free_inode(jinode);
> +		WRITE_ONCE(EXT4_I(inode)->jinode, NULL);
>  	}
>  	fscrypt_put_encryption_info(inode);
>  	fsverity_cleanup_inode(inode);

These cannot ever race with anybody as by the time ext4_clear_inode() we
are the exclusive owners of the inode. So there's no point in changing this
code.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

