Return-Path: <linux-ext4+bounces-498-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFACD817545
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Dec 2023 16:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65DA1B22744
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Dec 2023 15:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F4149899;
	Mon, 18 Dec 2023 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XIgEK3Jr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vgGCrf2a";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KUk7fX+i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7fD5+Bgy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F128E42387;
	Mon, 18 Dec 2023 15:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D7FBD1FD49;
	Mon, 18 Dec 2023 15:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702913548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lDm4hg48PDFBg6xR++pjGHYcQnl+zm5vP7lgIIqjERU=;
	b=XIgEK3JrFDDqR8QAwqXnwaUTVADyWH/Kr7iuRdakeO18MAQx5mzKLwJA7+/PAiPQ4Ec4/0
	NdZwewLHAYCTP5u33h3EVQ/vgRdJKSJVpTKIHJYVBUP+05wwlC3VilPxqmA5UqiLxhcStu
	QtTUBCMaDl7YcsRuGQoPLApPKCjVkGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702913548;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lDm4hg48PDFBg6xR++pjGHYcQnl+zm5vP7lgIIqjERU=;
	b=vgGCrf2a1l8GEw6DBR3FhOFD50FqRwVAJlYil3gMxTclWScu/ctFG4CYqg9giJppWqvYlp
	oW65Lnzx5PLsS0Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702913547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lDm4hg48PDFBg6xR++pjGHYcQnl+zm5vP7lgIIqjERU=;
	b=KUk7fX+izFMs4HurWN694iAICM8MvW/KNrBYqZUO+D5lEqTxralCp0+778c7OV1JnVHyg9
	fgoiwMhL/GXWdmNrxU3hjw/8ETSUDZiBIl+ztI2H4SSTIgGCtVhw1RiU9xqgtpVJh8ahP3
	TO4TSzRZfGdxMLmsfKUgnlHNICiOyt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702913547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lDm4hg48PDFBg6xR++pjGHYcQnl+zm5vP7lgIIqjERU=;
	b=7fD5+BgyrJSace8PYz5yajZ5/wG9SnT27qNRQFp3I1pJKbn/ZJskdMYeapFFsos593ujRn
	TEdIzrevBo3WzzBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C8CE313BC8;
	Mon, 18 Dec 2023 15:32:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id MmwCMQtmgGWHfAAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 18 Dec 2023 15:32:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5F147A07E0; Mon, 18 Dec 2023 16:32:27 +0100 (CET)
Date: Mon, 18 Dec 2023 16:32:27 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com,
	Wei Chen <harperchen1110@gmail.com>,
	xingwei lee <xrivendell7@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/4] ext4: fix double-free of blocks due to wrong extents
 moved_len
Message-ID: <20231218153227.x273h3c5t2dqgh76@quack3>
References: <20231218141814.1477338-1-libaokun1@huawei.com>
 <20231218141814.1477338-2-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218141814.1477338-2-libaokun1@huawei.com>
X-Spam-Level: **
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KUk7fX+i;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7fD5+Bgy
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[10.49%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: D7FBD1FD49
X-Spam-Flag: NO

On Mon 18-12-23 22:18:11, Baokun Li wrote:
> In ext4_move_extents(), moved_len is only updated when all moves are
> successfully executed, and only discards orig_inode and donor_inode
> preallocations when moved_len is not zero. When the loop fails to exit
> after successfully moving some extents, moved_len is not updated and
> remains at 0, so it does not discard the preallocations.
> 
> If the moved extents overlap with the preallocated extents, the
> overlapped extents are freed twice in ext4_mb_release_inode_pa() and
> ext4_process_freed_data() (as described in commit 94d7c16cbbbd), and
> bb_free is incremented twice. Hence when trim is executed, a zero-division
> bug is triggered in mb_update_avg_fragment_size() because bb_free is not
> zero and bb_fragments is zero.
> 
> Therefore, update move_len after each extent move to avoid the issue.
> 
> Reported-by: Wei Chen <harperchen1110@gmail.com>
> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Closes: https://lore.kernel.org/r/CAO4mrferzqBUnCag8R3m2zf897ts9UEuhjFQGPtODT92rYyR2Q@mail.gmail.com
> Fixes: fcf6b1b729bc ("ext4: refactor ext4_move_extents code base")
> CC: stable@vger.kernel.org # 3.18
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/ext4/move_extent.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> index 3aa57376d9c2..4b9b503c6346 100644
> --- a/fs/ext4/move_extent.c
> +++ b/fs/ext4/move_extent.c
> @@ -672,7 +672,7 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
>  		 */
>  		ext4_double_up_write_data_sem(orig_inode, donor_inode);
>  		/* Swap original branches with new branches */
> -		move_extent_per_page(o_filp, donor_inode,
> +		*moved_len += move_extent_per_page(o_filp, donor_inode,
>  				     orig_page_index, donor_page_index,
>  				     offset_in_page, cur_len,
>  				     unwritten, &ret);

Although this is currently fine, I think ext4_move_extents() should be
careful and zero out *moved_len before it starts using it.

> @@ -682,7 +682,6 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
>  		o_start += cur_len;
>  		d_start += cur_len;
>  	}
> -	*moved_len = o_start - orig_blk;
>  	if (*moved_len > len)
>  		*moved_len = len;

So I'm not sure the *moved_len > len condition can ever trigger but if it
does, we'd need to check it whenever we are returning moved_len. So either
I'd delete the condition or move it to the out label.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

