Return-Path: <linux-ext4+bounces-676-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A05A9823FE7
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 11:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15DC01F222DD
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 10:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242CE20DEF;
	Thu,  4 Jan 2024 10:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RygVgUgJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qAUBlywq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RygVgUgJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qAUBlywq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB2B20DD4;
	Thu,  4 Jan 2024 10:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1471C2208A;
	Thu,  4 Jan 2024 10:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704365512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zFYFf+UB3dBFs5V9ixTsOE5Ni/3M4S6dRh2f4ykJP1M=;
	b=RygVgUgJ78g2vNmNj9IPoPKK0eDIBzpTOYS2piHBDn6XTP/4SNEXrd7KhB+LLL2kgL27C+
	8jSjqFh/NIRJ+PrBhknkUAncvRBR0Zru0OpoGE/4MXf88yYF1IHJqDgPa3079dlOgGeuEr
	Vud1z6ZnoPA2KZ1SrqMjL3g+pGgaDSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704365512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zFYFf+UB3dBFs5V9ixTsOE5Ni/3M4S6dRh2f4ykJP1M=;
	b=qAUBlywqfXYHwUWgjmv6rjf1UDp86bhBpvX2iBuAyIzwv0sS1iM/u0xl4uPH0GBsS5ECdI
	aM9J6jxSNR9+TVBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704365512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zFYFf+UB3dBFs5V9ixTsOE5Ni/3M4S6dRh2f4ykJP1M=;
	b=RygVgUgJ78g2vNmNj9IPoPKK0eDIBzpTOYS2piHBDn6XTP/4SNEXrd7KhB+LLL2kgL27C+
	8jSjqFh/NIRJ+PrBhknkUAncvRBR0Zru0OpoGE/4MXf88yYF1IHJqDgPa3079dlOgGeuEr
	Vud1z6ZnoPA2KZ1SrqMjL3g+pGgaDSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704365512;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zFYFf+UB3dBFs5V9ixTsOE5Ni/3M4S6dRh2f4ykJP1M=;
	b=qAUBlywqfXYHwUWgjmv6rjf1UDp86bhBpvX2iBuAyIzwv0sS1iM/u0xl4uPH0GBsS5ECdI
	aM9J6jxSNR9+TVBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0961E13722;
	Thu,  4 Jan 2024 10:51:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sMlIAsiNlmUzeQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 04 Jan 2024 10:51:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A0FCDA07EF; Thu,  4 Jan 2024 11:51:51 +0100 (CET)
Date: Thu, 4 Jan 2024 11:51:51 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 8/8] ext4: mark the group block bitmap as corrupted
 before reporting an error
Message-ID: <20240104105151.3c2yrg3f3efiajgv@quack3>
References: <20231221150558.2740823-1-libaokun1@huawei.com>
 <20231221150558.2740823-9-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221150558.2740823-9-libaokun1@huawei.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Thu 21-12-23 23:05:58, Baokun Li wrote:
> Otherwise unlocking the group in ext4_grp_locked_error may allow other
> processes to modify the core block bitmap that is known to be corrupt.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

I'm not opposed but I don't think this matters much.
ext4_grp_locked_error() unlocks the group only in errors=remount-ro case
these days and in that case we abort the journal so none of the changes
should make it to disk anyway. Anyway, in the name of defensive programming
feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

:)

								Honza

> ---
>  fs/ext4/mballoc.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index b862ca2750fd..c43eefebdaa3 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -564,14 +564,14 @@ static void mb_free_blocks_double(struct inode *inode, struct ext4_buddy *e4b,
>  
>  			blocknr = ext4_group_first_block_no(sb, e4b->bd_group);
>  			blocknr += EXT4_C2B(EXT4_SB(sb), first + i);
> +			ext4_mark_group_bitmap_corrupted(sb, e4b->bd_group,
> +					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
>  			ext4_grp_locked_error(sb, e4b->bd_group,
>  					      inode ? inode->i_ino : 0,
>  					      blocknr,
>  					      "freeing block already freed "
>  					      "(bit %u)",
>  					      first + i);
> -			ext4_mark_group_bitmap_corrupted(sb, e4b->bd_group,
> -					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
>  		}
>  		mb_clear_bit(first + i, e4b->bd_info->bb_bitmap);
>  	}
> @@ -1926,14 +1926,13 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
>  		blocknr = ext4_group_first_block_no(sb, e4b->bd_group);
>  		blocknr += EXT4_C2B(sbi, block);
>  		if (!(sbi->s_mount_state & EXT4_FC_REPLAY)) {
> +			ext4_mark_group_bitmap_corrupted(sb, e4b->bd_group,
> +					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
>  			ext4_grp_locked_error(sb, e4b->bd_group,
>  					      inode ? inode->i_ino : 0,
>  					      blocknr,
>  					      "freeing already freed block (bit %u); block bitmap corrupt.",
>  					      block);
> -			ext4_mark_group_bitmap_corrupted(
> -				sb, e4b->bd_group,
> -				EXT4_GROUP_INFO_BBITMAP_CORRUPT);
>  		} else {
>  			mb_regenerate_buddy(e4b);
>  			goto check;
> @@ -2410,12 +2409,12 @@ void ext4_mb_simple_scan_group(struct ext4_allocation_context *ac,
>  
>  		k = mb_find_next_zero_bit(buddy, max, 0);
>  		if (k >= max) {
> +			ext4_mark_group_bitmap_corrupted(ac->ac_sb,
> +					e4b->bd_group,
> +					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
>  			ext4_grp_locked_error(ac->ac_sb, e4b->bd_group, 0, 0,
>  				"%d free clusters of order %d. But found 0",
>  				grp->bb_counters[i], i);
> -			ext4_mark_group_bitmap_corrupted(ac->ac_sb,
> -					 e4b->bd_group,
> -					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
>  			break;
>  		}
>  		ac->ac_found++;
> @@ -2466,12 +2465,12 @@ void ext4_mb_complex_scan_group(struct ext4_allocation_context *ac,
>  			 * free blocks even though group info says we
>  			 * have free blocks
>  			 */
> +			ext4_mark_group_bitmap_corrupted(sb, e4b->bd_group,
> +					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
>  			ext4_grp_locked_error(sb, e4b->bd_group, 0, 0,
>  					"%d free clusters as per "
>  					"group info. But bitmap says 0",
>  					free);
> -			ext4_mark_group_bitmap_corrupted(sb, e4b->bd_group,
> -					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
>  			break;
>  		}
>  
> @@ -2497,12 +2496,12 @@ void ext4_mb_complex_scan_group(struct ext4_allocation_context *ac,
>  		if (WARN_ON(ex.fe_len <= 0))
>  			break;
>  		if (free < ex.fe_len) {
> +			ext4_mark_group_bitmap_corrupted(sb, e4b->bd_group,
> +					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
>  			ext4_grp_locked_error(sb, e4b->bd_group, 0, 0,
>  					"%d free clusters as per "
>  					"group info. But got %d blocks",
>  					free, ex.fe_len);
> -			ext4_mark_group_bitmap_corrupted(sb, e4b->bd_group,
> -					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
>  			/*
>  			 * The number of free blocks differs. This mostly
>  			 * indicate that the bitmap is corrupt. So exit
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

