Return-Path: <linux-ext4+bounces-3025-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A37A91C175
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Jun 2024 16:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CF571C216E2
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Jun 2024 14:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D351C0053;
	Fri, 28 Jun 2024 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t2GKhf4w";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3xJvY7/k";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t2GKhf4w";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3xJvY7/k"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3FE1BF31A
	for <linux-ext4@vger.kernel.org>; Fri, 28 Jun 2024 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586036; cv=none; b=ftPdE23wYkUdhSbIjAarwGAdusf5lx0WfrYZ2qP0tNEvAOUFArjgXWa3+YqXnnZ0l9F5gnmHcA8QLjG97u9sNp5KKUpMNmeBPKvjfVbv3HvoHcy+fMDt9pDGaJfem1BzXA8VAkVhWV+YxZYQRXfxD645H+H3YeMCzG31PhLbPjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586036; c=relaxed/simple;
	bh=QTuv5Gme75OV3xR1E4URSW4tH626T4pbLyZPxlXj7go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjAhz2tgPz9kAW86bHS0AZCFQhRQMXs/bZAkywiD3T+GB7IPYeE7Lw3e4fdQQNhFn9LmjAvGXEkB1pVye+NM+m+ONNVSyivWBADg2DQBs22d42AaiIPiEeOIBuzjNFo8u9yW9TDB8xjNjNdCYMlpAFEW5BfncXUmbSRoKgsteUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t2GKhf4w; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3xJvY7/k; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t2GKhf4w; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3xJvY7/k; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 853A81FCF3;
	Fri, 28 Jun 2024 14:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719586032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H5p9joOVzHub7D2V4FKGMJ0yNgGhE5A8La+DJI/+jEE=;
	b=t2GKhf4wX1GY+ya5KpJaVuxxESDYMZudwLgP8AI+PTnDZoQR/4noGpY6j1e+iec+w1sJPs
	1h1c3qyQDCCbXvo+7YOcJLpUnkdT4wTN5xzkTsQX3vz68nwgR8CZB2tYl71atAJAClvTTm
	O64JwtMVZ05nrspjmfQtBO5r6J4Q6y4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719586032;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H5p9joOVzHub7D2V4FKGMJ0yNgGhE5A8La+DJI/+jEE=;
	b=3xJvY7/kMi2wY5m/01QZ64LoQiJx8fYLmD6ugKBGnjodfNMmWbvJbLgq2PwDb7aVW9y9xY
	Y0DZeEPRjUxE3GDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=t2GKhf4w;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="3xJvY7/k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719586032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H5p9joOVzHub7D2V4FKGMJ0yNgGhE5A8La+DJI/+jEE=;
	b=t2GKhf4wX1GY+ya5KpJaVuxxESDYMZudwLgP8AI+PTnDZoQR/4noGpY6j1e+iec+w1sJPs
	1h1c3qyQDCCbXvo+7YOcJLpUnkdT4wTN5xzkTsQX3vz68nwgR8CZB2tYl71atAJAClvTTm
	O64JwtMVZ05nrspjmfQtBO5r6J4Q6y4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719586032;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H5p9joOVzHub7D2V4FKGMJ0yNgGhE5A8La+DJI/+jEE=;
	b=3xJvY7/kMi2wY5m/01QZ64LoQiJx8fYLmD6ugKBGnjodfNMmWbvJbLgq2PwDb7aVW9y9xY
	Y0DZeEPRjUxE3GDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69B9E1373E;
	Fri, 28 Jun 2024 14:47:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qIbLGfDMfmbaGAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 28 Jun 2024 14:47:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E4C6AA0887; Fri, 28 Jun 2024 16:47:11 +0200 (CEST)
Date: Fri, 28 Jun 2024 16:47:11 +0200
From: Jan Kara <jack@suse.cz>
To: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, saukad@google.com,
	harshads@google.com
Subject: Re: [PATCH v6 10/10] ext4: make fast commit ineligible on
 ext4_reserve_inode_write failure
Message-ID: <20240628144711.pdvrpztjdenadg6o@quack3>
References: <20240529012003.4006535-1-harshadshirwadkar@gmail.com>
 <20240529012003.4006535-11-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529012003.4006535-11-harshadshirwadkar@gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 853A81FCF3
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Wed 29-05-24 01:20:03, Harshad Shirwadkar wrote:
> Fast commit by default makes every inode on which
> ext4_reserve_inode_write() is called. Thus, if that function
> fails for some reason, make the next fast commit ineligible.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Yeah, makes sense. The hunk in ext4_reserve_inode_write() will need redoing
once you fix the problem I've pointed out in patch 2 but otherwise the
patch looks good.

								Honza

> ---
>  fs/ext4/fast_commit.c       |  1 +
>  fs/ext4/fast_commit.h       |  1 +
>  fs/ext4/inode.c             | 29 ++++++++++++++++++-----------
>  include/trace/events/ext4.h |  7 +++++--
>  4 files changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 55a13d3ff681..e7cac190527c 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -2291,6 +2291,7 @@ static const char * const fc_ineligible_reasons[] = {
>  	[EXT4_FC_REASON_FALLOC_RANGE] = "Falloc range op",
>  	[EXT4_FC_REASON_INODE_JOURNAL_DATA] = "Data journalling",
>  	[EXT4_FC_REASON_ENCRYPTED_FILENAME] = "Encrypted filename",
> +	[EXT4_FC_REASON_INODE_RSV_WRITE_FAIL] = "Inode reserve write failure"
>  };
>  
>  int ext4_fc_info_show(struct seq_file *seq, void *v)
> diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
> index 2fadb2c4780c..f7f85c3dd3af 100644
> --- a/fs/ext4/fast_commit.h
> +++ b/fs/ext4/fast_commit.h
> @@ -97,6 +97,7 @@ enum {
>  	EXT4_FC_REASON_FALLOC_RANGE,
>  	EXT4_FC_REASON_INODE_JOURNAL_DATA,
>  	EXT4_FC_REASON_ENCRYPTED_FILENAME,
> +	EXT4_FC_REASON_INODE_RSV_WRITE_FAIL,
>  	EXT4_FC_REASON_MAX
>  };
>  
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index f00408017c7a..8fd6e5637542 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5729,20 +5729,27 @@ ext4_reserve_inode_write(handle_t *handle, struct inode *inode,
>  {
>  	int err;
>  
> -	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
> -		return -EIO;
> +	if (unlikely(ext4_forced_shutdown(inode->i_sb))) {
> +		err = -EIO;
> +		goto out;
> +	}
>  
>  	err = ext4_get_inode_loc(inode, iloc);
> -	if (!err) {
> -		BUFFER_TRACE(iloc->bh, "get_write_access");
> -		err = ext4_journal_get_write_access(handle, inode->i_sb,
> -						    iloc->bh, EXT4_JTR_NONE);
> -		if (err) {
> -			brelse(iloc->bh);
> -			iloc->bh = NULL;
> -		}
> -		ext4_fc_track_inode(handle, inode);
> +	if (err)
> +		goto out;
> +
> +	BUFFER_TRACE(iloc->bh, "get_write_access");
> +	err = ext4_journal_get_write_access(handle, inode->i_sb,
> +						iloc->bh, EXT4_JTR_NONE);
> +	if (err) {
> +		brelse(iloc->bh);
> +		iloc->bh = NULL;
>  	}
> +	ext4_fc_track_inode(handle, inode);
> +out:
> +	if (err)
> +		ext4_fc_mark_ineligible(inode->i_sb,
> +			EXT4_FC_REASON_INODE_RSV_WRITE_FAIL, handle);
>  	ext4_std_error(inode->i_sb, err);
>  	return err;
>  }
> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index a697f4b77162..597845d5c1e8 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -105,6 +105,7 @@ TRACE_DEFINE_ENUM(EXT4_FC_REASON_RENAME_DIR);
>  TRACE_DEFINE_ENUM(EXT4_FC_REASON_FALLOC_RANGE);
>  TRACE_DEFINE_ENUM(EXT4_FC_REASON_INODE_JOURNAL_DATA);
>  TRACE_DEFINE_ENUM(EXT4_FC_REASON_ENCRYPTED_FILENAME);
> +TRACE_DEFINE_ENUM(EXT4_FC_REASON_INODE_RSV_WRITE_FAIL);
>  TRACE_DEFINE_ENUM(EXT4_FC_REASON_MAX);
>  
>  #define show_fc_reason(reason)						\
> @@ -118,7 +119,8 @@ TRACE_DEFINE_ENUM(EXT4_FC_REASON_MAX);
>  		{ EXT4_FC_REASON_RENAME_DIR,	"RENAME_DIR"},		\
>  		{ EXT4_FC_REASON_FALLOC_RANGE,	"FALLOC_RANGE"},	\
>  		{ EXT4_FC_REASON_INODE_JOURNAL_DATA,	"INODE_JOURNAL_DATA"}, \
> -		{ EXT4_FC_REASON_ENCRYPTED_FILENAME,	"ENCRYPTED_FILENAME"})
> +		{ EXT4_FC_REASON_ENCRYPTED_FILENAME,	"ENCRYPTED_FILENAME"}, \
> +		{ EXT4_FC_REASON_INODE_RSV_WRITE_FAIL,	"INODE_RSV_WRITE_FAIL"})
>  
>  TRACE_DEFINE_ENUM(CR_POWER2_ALIGNED);
>  TRACE_DEFINE_ENUM(CR_GOAL_LEN_FAST);
> @@ -2805,7 +2807,7 @@ TRACE_EVENT(ext4_fc_stats,
>  	),
>  
>  	TP_printk("dev %d,%d fc ineligible reasons:\n"
> -		  "%s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u"
> +		  "%s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u"
>  		  "num_commits:%lu, ineligible: %lu, numblks: %lu",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev),
>  		  FC_REASON_NAME_STAT(EXT4_FC_REASON_XATTR),
> @@ -2818,6 +2820,7 @@ TRACE_EVENT(ext4_fc_stats,
>  		  FC_REASON_NAME_STAT(EXT4_FC_REASON_FALLOC_RANGE),
>  		  FC_REASON_NAME_STAT(EXT4_FC_REASON_INODE_JOURNAL_DATA),
>  		  FC_REASON_NAME_STAT(EXT4_FC_REASON_ENCRYPTED_FILENAME),
> +		  FC_REASON_NAME_STAT(EXT4_FC_REASON_INODE_RSV_WRITE_FAIL),
>  		  __entry->fc_commits, __entry->fc_ineligible_commits,
>  		  __entry->fc_numblks)
>  );
> -- 
> 2.45.1.288.g0e0cd299f1-goog
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

