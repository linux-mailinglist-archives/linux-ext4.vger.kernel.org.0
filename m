Return-Path: <linux-ext4+bounces-670-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CA5823F68
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 11:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B17471F24FC4
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 10:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30C420B2F;
	Thu,  4 Jan 2024 10:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uQJP+z05";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ocKIaO+L";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uQJP+z05";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ocKIaO+L"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519A520B11;
	Thu,  4 Jan 2024 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 688B021E06;
	Thu,  4 Jan 2024 10:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704364021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IpPQBTmyvOP/OKFAG4qDUnS9KMdhc1z7R/7qs76GfkQ=;
	b=uQJP+z05cUrj8PC51PfcNuJqx9Vjpi9JcPgzr+Z7RC3FepVFea/Kd59mSbSIx3+PSFy0u4
	8a/8LGOWKAbUQmzG34OEkfQl8DB05XJPl41K+OLIw+sjVMLLgVa8jITRPTb87lgK0+1HE8
	cJ8KnD0NNphRA+Xjj0KcHHZ9LlYsTXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704364021;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IpPQBTmyvOP/OKFAG4qDUnS9KMdhc1z7R/7qs76GfkQ=;
	b=ocKIaO+Lvr2HMGBjdsRAFQpfdZyWibgWKlYF7bjz//rlr400lrl5zpbB4/Pkl8UjfwKvjD
	+JqF+6LmiynGAsDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704364021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IpPQBTmyvOP/OKFAG4qDUnS9KMdhc1z7R/7qs76GfkQ=;
	b=uQJP+z05cUrj8PC51PfcNuJqx9Vjpi9JcPgzr+Z7RC3FepVFea/Kd59mSbSIx3+PSFy0u4
	8a/8LGOWKAbUQmzG34OEkfQl8DB05XJPl41K+OLIw+sjVMLLgVa8jITRPTb87lgK0+1HE8
	cJ8KnD0NNphRA+Xjj0KcHHZ9LlYsTXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704364021;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IpPQBTmyvOP/OKFAG4qDUnS9KMdhc1z7R/7qs76GfkQ=;
	b=ocKIaO+Lvr2HMGBjdsRAFQpfdZyWibgWKlYF7bjz//rlr400lrl5zpbB4/Pkl8UjfwKvjD
	+JqF+6LmiynGAsDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59246137E8;
	Thu,  4 Jan 2024 10:27:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7ai9FfWHlmXEcQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 04 Jan 2024 10:27:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DF668A07EF; Thu,  4 Jan 2024 11:27:00 +0100 (CET)
Date: Thu, 4 Jan 2024 11:27:00 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com,
	Wei Chen <harperchen1110@gmail.com>,
	xingwei lee <xrivendell7@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/8] ext4: fix double-free of blocks due to wrong
 extents moved_len
Message-ID: <20240104102700.kqfc6xg3mc7ur5kl@quack3>
References: <20231221150558.2740823-1-libaokun1@huawei.com>
 <20231221150558.2740823-2-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221150558.2740823-2-libaokun1@huawei.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: *****
X-Spam-Score: 5.20
X-Spamd-Result: default: False [5.20 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.00)[38.34%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Thu 21-12-23 23:05:51, Baokun Li wrote:
> In ext4_move_extents(), moved_len is only updated when all moves are
> successfully executed, and only discards orig_inode and donor_inode
> preallocations when moved_len is not zero. When the loop fails to exit
> after successfully moving some extents, moved_len is not updated and
> remains at 0, so it does not discard the preallocations.
> 
> If the moved extents overlap with the preallocated extents, the
> overlapped extents are freed twice in ext4_mb_release_inode_pa() and
> ext4_process_freed_data() (as described in commit 94d7c16cbbbd ("ext4:
> Fix double-free of blocks with EXT4_IOC_MOVE_EXT")), and bb_free is
> incremented twice. Hence when trim is executed, a zero-division bug is
> triggered in mb_update_avg_fragment_size() because bb_free is not zero
> and bb_fragments is zero.
> 
> Therefore, update move_len after each extent move to avoid the issue.
> 
> Reported-by: Wei Chen <harperchen1110@gmail.com>
> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Closes: https://lore.kernel.org/r/CAO4mrferzqBUnCag8R3m2zf897ts9UEuhjFQGPtODT92rYyR2Q@mail.gmail.com
> Fixes: fcf6b1b729bc ("ext4: refactor ext4_move_extents code base")
> CC: stable@vger.kernel.org # 3.18
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/move_extent.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> index 3aa57376d9c2..391efa6d4c56 100644
> --- a/fs/ext4/move_extent.c
> +++ b/fs/ext4/move_extent.c
> @@ -618,6 +618,7 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
>  		goto out;
>  	o_end = o_start + len;
>  
> +	*moved_len = 0;
>  	while (o_start < o_end) {
>  		struct ext4_extent *ex;
>  		ext4_lblk_t cur_blk, next_blk;
> @@ -672,7 +673,7 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
>  		 */
>  		ext4_double_up_write_data_sem(orig_inode, donor_inode);
>  		/* Swap original branches with new branches */
> -		move_extent_per_page(o_filp, donor_inode,
> +		*moved_len += move_extent_per_page(o_filp, donor_inode,
>  				     orig_page_index, donor_page_index,
>  				     offset_in_page, cur_len,
>  				     unwritten, &ret);
> @@ -682,9 +683,6 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
>  		o_start += cur_len;
>  		d_start += cur_len;
>  	}
> -	*moved_len = o_start - orig_blk;
> -	if (*moved_len > len)
> -		*moved_len = len;
>  
>  out:
>  	if (*moved_len) {
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

