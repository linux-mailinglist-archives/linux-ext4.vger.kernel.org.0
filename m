Return-Path: <linux-ext4+bounces-5664-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA9E9F2E48
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Dec 2024 11:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3F2C1884E9B
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Dec 2024 10:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB8520370D;
	Mon, 16 Dec 2024 10:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e/a+lroJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OdqWHOz2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UxoJgw/s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d4LrfBte"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B2E200BB9
	for <linux-ext4@vger.kernel.org>; Mon, 16 Dec 2024 10:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734345607; cv=none; b=A1HXgz/A6QTgi6+2zwSmVGwu1kSsnZtlCsUDRdzYBfgPfaMB8wk7Gkd5RpEqO6Qsz2oNRiRphBr4Om9p/VhbRFdRorqOe8Xyhfo6sV56A3Aqh/bXvn76ei9Cbrh5cixqlolx9r7lMaToBOwpqGyf060xjYJTQXraH9tuKcOZfsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734345607; c=relaxed/simple;
	bh=b9kprH94+TCHnNWd5WrV6ylowdznqo+tNdXQhPddGZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLAFzLB5PeMql3m24dvoNtz5Wjo1SHAkMUK7l7cAP0EWBQIGBy5VwFtNbD+I8K4m42ygSCkrd10JwEp6Jn5JyJ/NQHC+5pKZhTZThgHp0Z/kq34pdgsHTADO0L3w/nMatWtbCb+Zu4KbXwrmGXJX55NWZ0S7HbXoQBgWJ0wFZUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e/a+lroJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OdqWHOz2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UxoJgw/s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d4LrfBte; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 77ADF1F449;
	Mon, 16 Dec 2024 10:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734345602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dfnXPC8lxrc08acTSjRAZyRhfLPgJ7C54h4TUtxkdeM=;
	b=e/a+lroJYpP+o+4EUzm8ILeTLMAolSl7RvE8t3ugZ51HRsqrr8L2ctQYkyNGPyq/kZ5y8N
	PX1RUzca9ywJ7aCLc9DW85SP+3qH9vwpbfu0Ggm+D35Ij2Jkfj7aUkKG0hPph8164vlTwh
	/BBDmmJWWl/mIVhAZFhcIhfjMeVVJrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734345602;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dfnXPC8lxrc08acTSjRAZyRhfLPgJ7C54h4TUtxkdeM=;
	b=OdqWHOz2Wg5axW2NHb+mHKxof+G3DXFOdqzepzcHaM2DS0KBC+PcZ3yPyaU7Qra4W3RTaM
	TRp+wGNPcGB2e+Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="UxoJgw/s";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=d4LrfBte
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734345601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dfnXPC8lxrc08acTSjRAZyRhfLPgJ7C54h4TUtxkdeM=;
	b=UxoJgw/sNkGsdCEEHMYaQurHJFqh+LMmFlh8ZFcLyNpeVxYUnUCeIpYY0uQLm4DwGqwhcX
	7DZyP+iuQEbFBZDVnVYmHkriVgTLkkvQjpqsv8MRgRqvbLmMkfbv4T06RFcdtAuyOEq+ch
	nqRB3EHRQCJjHoPCmNRivn8GJQqJVl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734345601;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dfnXPC8lxrc08acTSjRAZyRhfLPgJ7C54h4TUtxkdeM=;
	b=d4LrfBteIjk5yamuuM4CUV46pCkFUeiz5BWml5MDWMeqZDKQtysilmFk6qcS97vfrheK4T
	pWKdqW3zqZjritDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BDA6137CF;
	Mon, 16 Dec 2024 10:40:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Yf1ZGoEDYGciJwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 16 Dec 2024 10:40:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 02ECEA08E1; Mon, 16 Dec 2024 11:40:00 +0100 (CET)
Date: Mon, 16 Dec 2024 11:40:00 +0100
From: Jan Kara <jack@suse.cz>
To: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
	harshads@google.com
Subject: Re: [PATCH v7 8/9] ext4: make fast commit ineligible on
 ext4_reserve_inode_write failure
Message-ID: <20241216104000.cpzbeksxo6abawjj@quack3>
References: <20240818040356.241684-1-harshadshirwadkar@gmail.com>
 <20240818040356.241684-10-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818040356.241684-10-harshadshirwadkar@gmail.com>
X-Rspamd-Queue-Id: 77ADF1F449
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Sun 18-08-24 04:03:55, Harshad Shirwadkar wrote:
> Fast commit by default makes every inode on which
> ext4_reserve_inode_write() is called. Thus, if that function
> fails for some reason, make the next fast commit ineligible.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

I think this is a bit pointless. If ext4_reserve_inode_write() fails, we
have a data corruption problems, journal has aborted or similar. Thus I
think data consistency of fsync is kind of the least problem we are having
:). That being said just completely turning of fastcommit as soon as we hit
some filesystem error (in __ext4_std_error() when we don't decide to panic
system / shutdown the filesystem) makes sense to me as a kind of "let's
limit possible damage" measure.

								Honza

> ---
>  fs/ext4/fast_commit.c       |  1 +
>  fs/ext4/fast_commit.h       |  1 +
>  fs/ext4/inode.c             | 29 ++++++++++++++++++-----------
>  include/trace/events/ext4.h |  7 +++++--
>  4 files changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 2fc43b1e2..7525450f1 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -2282,6 +2282,7 @@ static const char * const fc_ineligible_reasons[] = {
>  	[EXT4_FC_REASON_FALLOC_RANGE] = "Falloc range op",
>  	[EXT4_FC_REASON_INODE_JOURNAL_DATA] = "Data journalling",
>  	[EXT4_FC_REASON_ENCRYPTED_FILENAME] = "Encrypted filename",
> +	[EXT4_FC_REASON_INODE_RSV_WRITE_FAIL] = "Inode reserve write failure"
>  };
>  
>  int ext4_fc_info_show(struct seq_file *seq, void *v)
> diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
> index 2fadb2c47..f7f85c3dd 100644
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
> index c82eba178..5a187902b 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5798,20 +5798,27 @@ ext4_reserve_inode_write(handle_t *handle, struct inode *inode,
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
> index cc5e9b7b2..8bab4febd 100644
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
> @@ -2809,7 +2811,7 @@ TRACE_EVENT(ext4_fc_stats,
>  	),
>  
>  	TP_printk("dev %d,%d fc ineligible reasons:\n"
> -		  "%s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u"
> +		  "%s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u, %s:%u"
>  		  "num_commits:%lu, ineligible: %lu, numblks: %lu",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev),
>  		  FC_REASON_NAME_STAT(EXT4_FC_REASON_XATTR),
> @@ -2822,6 +2824,7 @@ TRACE_EVENT(ext4_fc_stats,
>  		  FC_REASON_NAME_STAT(EXT4_FC_REASON_FALLOC_RANGE),
>  		  FC_REASON_NAME_STAT(EXT4_FC_REASON_INODE_JOURNAL_DATA),
>  		  FC_REASON_NAME_STAT(EXT4_FC_REASON_ENCRYPTED_FILENAME),
> +		  FC_REASON_NAME_STAT(EXT4_FC_REASON_INODE_RSV_WRITE_FAIL),
>  		  __entry->fc_commits, __entry->fc_ineligible_commits,
>  		  __entry->fc_numblks)
>  );
> -- 
> 2.46.0.184.g6999bdac58-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

