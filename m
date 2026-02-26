Return-Path: <linux-ext4+bounces-14046-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLRgOc89oGmrhAQAu9opvQ
	(envelope-from <linux-ext4+bounces-14046-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 13:34:23 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4890E1A5BC4
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 13:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D25E302BA45
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 12:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97A237BE98;
	Thu, 26 Feb 2026 12:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mgPm+JZv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EBXzpnbe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mgPm+JZv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EBXzpnbe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3790936C5B6
	for <linux-ext4@vger.kernel.org>; Thu, 26 Feb 2026 12:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772109254; cv=none; b=Se/hSecOi+AXVXObjff0TJtyPj9xeSHebsENgfAXL/H4653iNiR+BdEZ0RsfIWmfDZrtloQ7FHEM3dyxsrmHScHLwJPhvosGAyhYuspvCnBFu8/s3m9arRA3Vt1XvFe2tpOEGIirYcRQE08pDfeafz6OGOEx0X3cR7UUtCQgrIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772109254; c=relaxed/simple;
	bh=xu3zELdMHUdOQZFbtYqY5IEikUk3BeFI+3/elu4smuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQkHKycsgeECt8i7xbeYIVYlRkarvKEJfGbEqAlnhsYLaVN6oBJ9S8XK5JNmB4/4yUTgxLp+aQEk5tQCJ6s7RaV5f1u8BVFyW4t4kZDqIMdW9/zF/Xwq7rVquQTLGca6eL7I63YaLvCP0kYwDZ7SQJp25NRYzn3RpBRJDnRwX5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mgPm+JZv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EBXzpnbe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mgPm+JZv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EBXzpnbe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7D59B3FDCB;
	Thu, 26 Feb 2026 12:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772109251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hepTeBzqgzqQ878odYHWHK4hPoTuIBdn/QWdbRFv0cY=;
	b=mgPm+JZvJlJGeNRo6S3kDCA1SLJdlFa9VJHDE0hSkx3x5aS/Ai2pVX/R5th9x+qCJdyNkd
	P5vBcLLXjEnW6RWl3vSf6tepHN+/bzT5BPl3u9RO2mq2KNoHzSgF+2Z6QsEnpCG8+kJgSc
	Bzx8+Yed+jS4Bz4ssxjLY3L0NZpxFF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772109251;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hepTeBzqgzqQ878odYHWHK4hPoTuIBdn/QWdbRFv0cY=;
	b=EBXzpnbekk+rRnqQiYjV2febmsj8E2+6yAlSAE/ybIbQ8qFZjxHSPzySKqclf7UmlAE4LU
	obcrIJzui/234ICg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772109251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hepTeBzqgzqQ878odYHWHK4hPoTuIBdn/QWdbRFv0cY=;
	b=mgPm+JZvJlJGeNRo6S3kDCA1SLJdlFa9VJHDE0hSkx3x5aS/Ai2pVX/R5th9x+qCJdyNkd
	P5vBcLLXjEnW6RWl3vSf6tepHN+/bzT5BPl3u9RO2mq2KNoHzSgF+2Z6QsEnpCG8+kJgSc
	Bzx8+Yed+jS4Bz4ssxjLY3L0NZpxFF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772109251;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hepTeBzqgzqQ878odYHWHK4hPoTuIBdn/QWdbRFv0cY=;
	b=EBXzpnbekk+rRnqQiYjV2febmsj8E2+6yAlSAE/ybIbQ8qFZjxHSPzySKqclf7UmlAE4LU
	obcrIJzui/234ICg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 664EA3EA62;
	Thu, 26 Feb 2026 12:34:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w6LzGMM9oGnDHwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 26 Feb 2026 12:34:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2A296A0A27; Thu, 26 Feb 2026 13:34:11 +0100 (CET)
Date: Thu, 26 Feb 2026 13:34:11 +0100
From: Jan Kara <jack@suse.cz>
To: Li Chen <me@linux.beauty>
Cc: Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] ext4: publish jinode after initialization
Message-ID: <ge2sjh7x7x4axtkpkghgudgv6krcuan4i7lep6p7uw23f7aq2k@ldljqssvaub4>
References: <20260225082617.147957-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225082617.147957-1-me@linux.beauty>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_FROM(0.00)[bounces-14046-lists,linux-ext4=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:email,suse.cz:dkim,linux.beauty:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4890E1A5BC4
X-Rspamd-Action: no action

On Wed 25-02-26 16:26:16, Li Chen wrote:
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

Thanks! Looks good to me now. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Changes since v2 (as suggested by Jan Kara:
> - Drop READ_ONCE() changes in ext4_jbd2_inode_add_*() and ext4_clear_inode().
> - Inline READ_ONCE(ei->jinode) in ext4_fc_flush_data().
> 
>  fs/ext4/fast_commit.c |  4 ++--
>  fs/ext4/inode.c       | 15 +++++++++++----
>  2 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index f575751f1cae..6e949c21842d 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -975,13 +975,13 @@ static int ext4_fc_flush_data(journal_t *journal)
>  	int ret = 0;
>  
>  	list_for_each_entry(ei, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
> -		ret = jbd2_submit_inode_data(journal, ei->jinode);
> +		ret = jbd2_submit_inode_data(journal, READ_ONCE(ei->jinode));
>  		if (ret)
>  			return ret;
>  	}
>  
>  	list_for_each_entry(ei, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
> -		ret = jbd2_wait_inode_data(journal, ei->jinode);
> +		ret = jbd2_wait_inode_data(journal, READ_ONCE(ei->jinode));
>  		if (ret)
>  			return ret;
>  	}
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
> -- 
> 2.52.0
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

