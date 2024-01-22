Return-Path: <linux-ext4+bounces-863-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E21D8362A5
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Jan 2024 12:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 411F21C2721A
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Jan 2024 11:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD8F3D38F;
	Mon, 22 Jan 2024 11:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kyU/RCZs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="c8rDicYw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kyU/RCZs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="c8rDicYw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315B43D0DB;
	Mon, 22 Jan 2024 11:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705924248; cv=none; b=Soxl6JXtx9F0gjHhWZ2szx5lFLvSrkWkul5dvcufu63l38XzdcmWrz9h8djpCIJsZ4xz0ro2TypMmfWmzQ0SbUFTHsb3jFjBtRzlyfkq1ikr7W/lsCtyop9yVUM4r3ZttIXharLqJQRRcbCUxeVKrLRrUrlXPmj29OSOjH5BEt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705924248; c=relaxed/simple;
	bh=f7xqXvBlliSCMXAbOlQqtJw7GsJAVcpMlMLht3Qd/Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1mMuWZbkaf+7zitFPcSnvOCaCwpyVr+o7YCe2D32YmHBqQ39Px9DuSKr/uy5vKWkJ7EUrBvqCpbk6NMtHT3pPlCLD2lw+1EDCwkZ8QHtKbQOstAviHNrJyONuzuMg6/CtkxmbnDnYEYOeJaCUaQCbUBHR9/pNo6X+UxpXwZYD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kyU/RCZs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=c8rDicYw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kyU/RCZs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=c8rDicYw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 30AC722234;
	Mon, 22 Jan 2024 11:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705924245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zvsTBp3wU+i5f0TTlXhYeaxoeFgqTzRm3i+4dBHaNdE=;
	b=kyU/RCZsMQLZctqPuwpNqafrtDvIq2MJYrAWOdDc3vrAbzziciR48NShRWoiudsQ39SIPk
	leUP5Sg9pG879tNhKvpatRJbXYW7VRKKXN1Bl45qdA4Akk7EP51jAD8mNputj4tt70oKVu
	U/EgBKSvgDmSmf6U5mirwcD8OClI+y8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705924245;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zvsTBp3wU+i5f0TTlXhYeaxoeFgqTzRm3i+4dBHaNdE=;
	b=c8rDicYwmWeSGD7Qwk30bSLINvyIvso6k4+GR0AcCCtf5529tjDPUsBYiao0TS4lmYNoWi
	wfNZVEkeO6r6lkDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705924245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zvsTBp3wU+i5f0TTlXhYeaxoeFgqTzRm3i+4dBHaNdE=;
	b=kyU/RCZsMQLZctqPuwpNqafrtDvIq2MJYrAWOdDc3vrAbzziciR48NShRWoiudsQ39SIPk
	leUP5Sg9pG879tNhKvpatRJbXYW7VRKKXN1Bl45qdA4Akk7EP51jAD8mNputj4tt70oKVu
	U/EgBKSvgDmSmf6U5mirwcD8OClI+y8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705924245;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zvsTBp3wU+i5f0TTlXhYeaxoeFgqTzRm3i+4dBHaNdE=;
	b=c8rDicYwmWeSGD7Qwk30bSLINvyIvso6k4+GR0AcCCtf5529tjDPUsBYiao0TS4lmYNoWi
	wfNZVEkeO6r6lkDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2666B139A2;
	Mon, 22 Jan 2024 11:50:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4q5eCZVWrmU3IgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Jan 2024 11:50:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BF8CAA0803; Mon, 22 Jan 2024 12:50:44 +0100 (CET)
Date: Mon, 22 Jan 2024 12:50:44 +0100
From: Jan Kara <jack@suse.cz>
To: Ye Bin <yebin10@huawei.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, jack@suse.cz
Subject: Re: [PATCH] ext4: forbid commit inconsistent quota data when
 errors=remount-ro
Message-ID: <20240122115044.pbh6womwasoct36f@quack3>
References: <20240119062908.3598806-1-yebin10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119062908.3598806-1-yebin10@huawei.com>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="kyU/RCZs";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=c8rDicYw
X-Spamd-Result: default: False [0.19 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 0.19
X-Rspamd-Queue-Id: 30AC722234
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Fri 19-01-24 14:29:08, Ye Bin wrote:
> There's issue as follows When do IO fault injection test:
> Quota error (device dm-3): find_block_dqentry: Quota for id 101 referenced but not present
> Quota error (device dm-3): qtree_read_dquot: Can't read quota structure for id 101
> Quota error (device dm-3): do_check_range: Getting block 2021161007 out of range 1-186
> Quota error (device dm-3): qtree_read_dquot: Can't read quota structure for id 661
> 
> Now, ext4_write_dquot()/ext4_acquire_dquot()/ext4_release_dquot() may commit
> inconsistent quota data even if process failed. This may lead to filesystem
> corruption.
> To ensure filesystem consistent when errors=remount-ro there is need to call
> ext4_handle_error() to abort journal.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

After thinking about this for a while I agree. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 0980845c8b8f..ef41b452173e 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -6873,6 +6873,10 @@ static int ext4_write_dquot(struct dquot *dquot)
>  	if (IS_ERR(handle))
>  		return PTR_ERR(handle);
>  	ret = dquot_commit(dquot);
> +	if (ret < 0)
> +		ext4_error_err(dquot->dq_sb, -ret,
> +			       "Failed to commit dquot type %d",
> +			       dquot->dq_id.type);
>  	err = ext4_journal_stop(handle);
>  	if (!ret)
>  		ret = err;
> @@ -6889,6 +6893,10 @@ static int ext4_acquire_dquot(struct dquot *dquot)
>  	if (IS_ERR(handle))
>  		return PTR_ERR(handle);
>  	ret = dquot_acquire(dquot);
> +	if (ret < 0)
> +		ext4_error_err(dquot->dq_sb, -ret,
> +			      "Failed to acquire dquot type %d",
> +			      dquot->dq_id.type);
>  	err = ext4_journal_stop(handle);
>  	if (!ret)
>  		ret = err;
> @@ -6908,6 +6916,10 @@ static int ext4_release_dquot(struct dquot *dquot)
>  		return PTR_ERR(handle);
>  	}
>  	ret = dquot_release(dquot);
> +	if (ret < 0)
> +		ext4_error_err(dquot->dq_sb, -ret,
> +			       "Failed to release dquot type %d",
> +			       dquot->dq_id.type);
>  	err = ext4_journal_stop(handle);
>  	if (!ret)
>  		ret = err;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

