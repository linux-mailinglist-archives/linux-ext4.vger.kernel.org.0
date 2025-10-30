Return-Path: <linux-ext4+bounces-11373-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C21C21BCE
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 19:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EEA6B35037D
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 18:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D662C3263;
	Thu, 30 Oct 2025 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t/fOPgTX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PdJ6p+FM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t/fOPgTX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PdJ6p+FM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C2336E376
	for <linux-ext4@vger.kernel.org>; Thu, 30 Oct 2025 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761848433; cv=none; b=BlGn/MQfy2bQdD9/bvF6JGZLfISpx/PQEOHoZYqZGOUup7Cmw7or+lKviyY4LIXvAj/MLSqnc3HCVI0lFSOgzhkWthL0YlR9/2U/EcjIlMh291bun9K4UnYG5imYDS/pxjBYkCEbzuwANRlGoTIsA5A9Tl9Og6wCi8WKqkhWQGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761848433; c=relaxed/simple;
	bh=aHiYYtfRhEIOQ14u4J3fLY6qher4/HToR00i105VFoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=um9FAcsOXPHxMwVNSxcsOQbeK3OvyLtrvLIBIoVBTVH+iwtleOsysC7LifkWKHX2mYblybAsWSzDZ4z9VxdIVhbsAGN3zI38JC7Cn3IGWCYw6dKncHiNW4ClF+yp/4jdKkcCUaJh0d/DOImEVKdQ45xDpmZew3AIU9wXcUrqgCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t/fOPgTX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PdJ6p+FM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t/fOPgTX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PdJ6p+FM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AD3381F7E9;
	Thu, 30 Oct 2025 18:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761848429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nnRbmKI6dG6K0WVvpcVQJ8AIF1fv782+3lZiAD/ZAb8=;
	b=t/fOPgTXXabOoVlkwte1Xb8Yc+jEBr11gXV3F13vhHSTO58ET72fWTEJPU8613PSQN6urD
	5UNvdQd+8Kb17wq45KqWwrNgQwdzI4IgQckK6hGU96IDTtVhUyOitl5cBm+1w80hdxbN0X
	ARI8OMfo7trUBjegUa4mEeAaRbZZ9Gg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761848429;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nnRbmKI6dG6K0WVvpcVQJ8AIF1fv782+3lZiAD/ZAb8=;
	b=PdJ6p+FMi+2luDUm7B6+onziH/lVegvx7V22rHonHSmHPVVhy0KssjncI1bJZbtxCUdGaV
	l85YYtigTC3YNeCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="t/fOPgTX";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PdJ6p+FM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761848429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nnRbmKI6dG6K0WVvpcVQJ8AIF1fv782+3lZiAD/ZAb8=;
	b=t/fOPgTXXabOoVlkwte1Xb8Yc+jEBr11gXV3F13vhHSTO58ET72fWTEJPU8613PSQN6urD
	5UNvdQd+8Kb17wq45KqWwrNgQwdzI4IgQckK6hGU96IDTtVhUyOitl5cBm+1w80hdxbN0X
	ARI8OMfo7trUBjegUa4mEeAaRbZZ9Gg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761848429;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nnRbmKI6dG6K0WVvpcVQJ8AIF1fv782+3lZiAD/ZAb8=;
	b=PdJ6p+FMi+2luDUm7B6+onziH/lVegvx7V22rHonHSmHPVVhy0KssjncI1bJZbtxCUdGaV
	l85YYtigTC3YNeCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9264E1396A;
	Thu, 30 Oct 2025 18:20:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oQW8I22sA2mvBQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 30 Oct 2025 18:20:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DA0D3A292A; Thu, 30 Oct 2025 19:20:28 +0100 (CET)
Date: Thu, 30 Oct 2025 19:20:28 +0100
From: Jan Kara <jack@suse.cz>
To: Ye Bin <yebin@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	jack@suse.cz
Subject: Re: [PATCH] jbd2: avoid bug_on in jbd2_journal_get_create_access()
 when file system corrupted
Message-ID: <q4aiajowsv4ywecclvsxikiigjsztkio44samvgytwtmemskrl@pw4j7t5ixwhh>
References: <20251025072657.307851-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025072657.307851-1-yebin@huaweicloud.com>
X-Rspamd-Queue-Id: AD3381F7E9
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Sat 25-10-25 15:26:57, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> There's issue when file system corrupted:
> ------------[ cut here ]------------
> kernel BUG at fs/jbd2/transaction.c:1289!
> Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
> CPU: 5 UID: 0 PID: 2031 Comm: mkdir Not tainted 6.18.0-rc1-next
> RIP: 0010:jbd2_journal_get_create_access+0x3b6/0x4d0
> RSP: 0018:ffff888117aafa30 EFLAGS: 00010202
> RAX: 0000000000000000 RBX: ffff88811a86b000 RCX: ffffffff89a63534
> RDX: 1ffff110200ec602 RSI: 0000000000000004 RDI: ffff888100763010
> RBP: ffff888100763000 R08: 0000000000000001 R09: ffff888100763028
> R10: 0000000000000003 R11: 0000000000000000 R12: 0000000000000000
> R13: ffff88812c432000 R14: ffff88812c608000 R15: ffff888120bfc000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f91d6970c99 CR3: 00000001159c4000 CR4: 00000000000006f0
> Call Trace:
>  <TASK>
>  __ext4_journal_get_create_access+0x42/0x170
>  ext4_getblk+0x319/0x6f0
>  ext4_bread+0x11/0x100
>  ext4_append+0x1e6/0x4a0
>  ext4_init_new_dir+0x145/0x1d0
>  ext4_mkdir+0x326/0x920
>  vfs_mkdir+0x45c/0x740
>  do_mkdirat+0x234/0x2f0
>  __x64_sys_mkdir+0xd6/0x120
>  do_syscall_64+0x5f/0xfa0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> The above issue occurs with us in errors=continue mode when accompanied by
> storage failures. There have been many inconsistencies in the file system
> data.
> In the case of file system data inconsistency, for example, if the block
> bitmap of a referenced block is not set, it can lead to the situation where
> a block being committed is allocated and used again. As a result, the
> following condition will not be satisfied then trigger BUG_ON. Of course,
> it is entirely possible to construct a problematic image that can trigger
> this BUG_ON through specific operations. In fact, I have constructed such
> an image and easily reproduced this issue.
> Therefore, J_ASSERT() holds true only under ideal conditions, but it may
> not necessarily be satisfied in exceptional scenarios. Using J_ASSERT()
> directly in abnormal situations would cause the system to crash, which is
> clearly not what we want. So here we directly trigger a JBD abort instead
> of immediately invoking BUG_ON.
> 
> Fixes: 470decc613ab ("[PATCH] jbd2: initial copy of files from jbd")
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/transaction.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index 3e510564de6e..9ce626ac947e 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -1284,14 +1284,23 @@ int jbd2_journal_get_create_access(handle_t *handle, struct buffer_head *bh)
>  	 * committing transaction's lists, but it HAS to be in Forget state in
>  	 * that case: the transaction must have deleted the buffer for it to be
>  	 * reused here.
> +	 * In the case of file system data inconsistency, for example, if the
> +	 * block bitmap of a referenced block is not set, it can lead to the
> +	 * situation where a block being committed is allocated and used again.
> +	 * As a result, the following condition will not be satisfied, so here
> +	 * we directly trigger a JBD abort instead of immediately invoking
> +	 * bugon.
>  	 */
>  	spin_lock(&jh->b_state_lock);
> -	J_ASSERT_JH(jh, (jh->b_transaction == transaction ||
> -		jh->b_transaction == NULL ||
> -		(jh->b_transaction == journal->j_committing_transaction &&
> -			  jh->b_jlist == BJ_Forget)));
> +	if (!(jh->b_transaction == transaction || jh->b_transaction == NULL ||
> +	      (jh->b_transaction == journal->j_committing_transaction &&
> +	       jh->b_jlist == BJ_Forget)) || jh->b_next_transaction != NULL) {
> +		err = -EROFS;
> +		spin_unlock(&jh->b_state_lock);
> +		jbd2_journal_abort(journal, err);
> +		goto out;
> +	}
>  
> -	J_ASSERT_JH(jh, jh->b_next_transaction == NULL);
>  	J_ASSERT_JH(jh, buffer_locked(jh2bh(jh)));
>  
>  	if (jh->b_transaction == NULL) {
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

