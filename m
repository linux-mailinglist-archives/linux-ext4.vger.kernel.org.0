Return-Path: <linux-ext4+bounces-672-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C07823F9E
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 11:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1228EB218C3
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 10:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AB720DC7;
	Thu,  4 Jan 2024 10:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DI1PVJHu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/cZz4SeW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UMw2yCNh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TyvK9ITx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A2720DCE;
	Thu,  4 Jan 2024 10:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F09BB1F7FD;
	Thu,  4 Jan 2024 10:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704364976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o2UxpR1JUyM6YvdVbBVgZQDEYYFlH6gLezEKahzOLyw=;
	b=DI1PVJHuKUzB4Yfoy98R8d7lJKbIA7BIUCcE4jwDF+xoEnnT1v+2Iehpuq8cGL6wo16hNQ
	xYi8PwoZAQ8m7L9i88aZ02MTODLhPwAPLesJV3cx185vv+SsomVbQZJj0TkJcOFNzSc4Vu
	NeNkXS+856fmVMuTTcvOZiCgj6Pzz4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704364976;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o2UxpR1JUyM6YvdVbBVgZQDEYYFlH6gLezEKahzOLyw=;
	b=/cZz4SeWOEHVEgWCFdqdhDBYwEvTQ9C5eOHdh1SesXnqdlIFSYJKYjupHVMtxX4C2HWMzG
	Fb64lpXv4lL1e2AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704364975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o2UxpR1JUyM6YvdVbBVgZQDEYYFlH6gLezEKahzOLyw=;
	b=UMw2yCNhYEmY63v0mCH5v65YsaYTBnB4meaNpSvfRmJRgrcqhq+OwVJsPN1CjSTFpNj2VL
	isdMzNo9j/90t+mZrKOFjHhSDOH8Sjeh/OuwJ6ubWSxUFI4t3w9lJFQYzL5sGivMZVGaja
	3G8IRxY8pZW5xTsR/ZSPo2xHO3tmAe4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704364975;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o2UxpR1JUyM6YvdVbBVgZQDEYYFlH6gLezEKahzOLyw=;
	b=TyvK9ITxl0UWu3pySHVEr83Xh/AvcIJnchq42FHVMCCVNnqEiPy0S0Nmh9+23hA0qYu1GU
	6Bdk4QiZduY+xsCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E167013722;
	Thu,  4 Jan 2024 10:42:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7Pz/Nq+LlmWZdgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 04 Jan 2024 10:42:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 89D12A07EF; Thu,  4 Jan 2024 11:42:55 +0100 (CET)
Date: Thu, 4 Jan 2024 11:42:55 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 4/8] ext4: avoid bb_free and bb_fragments
 inconsistency in mb_free_blocks()
Message-ID: <20240104104255.eewvmywxyqtfwzug@quack3>
References: <20231221150558.2740823-1-libaokun1@huawei.com>
 <20231221150558.2740823-5-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221150558.2740823-5-libaokun1@huawei.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: *
X-Spam-Score: 1.87
X-Spamd-Result: default: False [1.87 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.00)[25.51%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 NEURAL_SPAM_LONG(0.17)[0.048];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Thu 21-12-23 23:05:54, Baokun Li wrote:
> After updating bb_free in mb_free_blocks, it is possible to return without
> updating bb_fragments because the block being freed is found to have
> already been freed, which leads to inconsistency between bb_free and
> bb_fragments.
> 
> Since the group may be unlocked in ext4_grp_locked_error(), this can lead
> to problems such as dividing by zero when calculating the average fragment
> length. Hence move the update of bb_free to after the block double-free
> check guarantees that the corresponding statistics are updated only after
> the core block bitmap is modified.
> 
> Fixes: eabe0444df90 ("ext4: speed-up releasing blocks on commit")
> CC: stable@vger.kernel.org # 3.10
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Just one nit below but regardless of that feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> @@ -1941,10 +1936,16 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
>  				EXT4_GROUP_INFO_BBITMAP_CORRUPT);
>  		} else {
>  			mb_regenerate_buddy(e4b);
> +			goto check;
>  		}
> -		goto done;
> +		return;
>  	}

I think this might be more readable when we revert the condition like:

		/*
		 * Fastcommit replay can free already freed blocks which
		 * corrupts allocation info. Regenerate it.
		 */
		if (sbi->s_mount_state & EXT4_FC_REPLAY) {
	               	mb_regenerate_buddy(e4b);
			goto check;
		}
                ext4_grp_locked_error(sb, e4b->bd_group,
                                      inode ? inode->i_ino : 0, blocknr,
                                      "freeing already freed block (bit %u); block bitmap corrupt.",
                                      block);
                ext4_mark_group_bitmap_corrupted(sb, e4b->bd_group,
                                EXT4_GROUP_INFO_BBITMAP_CORRUPT);
		return;
	}

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

