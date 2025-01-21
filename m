Return-Path: <linux-ext4+bounces-6169-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BED8A17D21
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 12:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 763353A9255
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 11:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3841F1503;
	Tue, 21 Jan 2025 11:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EGZNIu8o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OPtR9UHx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EGZNIu8o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OPtR9UHx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CA71B140D;
	Tue, 21 Jan 2025 11:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737459444; cv=none; b=r9wHehdSRCuskdHWQ0aUSy/DDHtmWzmGtSnpbx1WaqHswKYxgcFr4bvaTZhbN2TJBuKSyUTFTxpEvazPgW82dW7D0onC91sSWBgnHopdwv6nbTOojup0pZJJhAZj0mArBeiRcsKPTAG6XNyU4zavZISepyWCpQhvvKFesZ70Ink=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737459444; c=relaxed/simple;
	bh=+ch0S3ORYAVmb+240QcbO4TBqp2uMPFXpXBDt1zcK7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omjZN6P9jO0NWVoFk7hr7GDfbcempE127tnuU3IIPYYjX1psmuQIvU+pHmj4U8X85pWGtXwPs8V0gSbKlQRCBSqNWiZwvvG9B15LJ3pMxQatLb+4EG+ylpHurz6XQ4gqxS74YpP+eNRnCiVPG/sOo7HYFpGCYshbIaCLF86XmFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EGZNIu8o; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OPtR9UHx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EGZNIu8o; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OPtR9UHx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2B7761F397;
	Tue, 21 Jan 2025 11:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737459440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EDVd/yLlfEuclkOM9/amIRIZfT8073/2RIgL+yj9fOE=;
	b=EGZNIu8osgdT8qKl17RlRB2g0l0htBZXEY/wjYq/X8tUURn85+f79FsgJ86cxQnfVHZ6Ar
	sx+5HLYFLcTun8cIOtM2PiFhTvQN2tvCwONwyXgdOafoqbb2kYxgEwo5CKS8ppgiwlsVFV
	rz+VWaIE8BCqHnZSlR0nP25EyK+X13M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737459440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EDVd/yLlfEuclkOM9/amIRIZfT8073/2RIgL+yj9fOE=;
	b=OPtR9UHxW5oF40Yeq4YiTrCjSxlFha++jwIqQxQO4LtUBZsXBHhJOeKQgp8Vwkf8GxhaLM
	QGciUSJlzLN5ifDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737459440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EDVd/yLlfEuclkOM9/amIRIZfT8073/2RIgL+yj9fOE=;
	b=EGZNIu8osgdT8qKl17RlRB2g0l0htBZXEY/wjYq/X8tUURn85+f79FsgJ86cxQnfVHZ6Ar
	sx+5HLYFLcTun8cIOtM2PiFhTvQN2tvCwONwyXgdOafoqbb2kYxgEwo5CKS8ppgiwlsVFV
	rz+VWaIE8BCqHnZSlR0nP25EyK+X13M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737459440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EDVd/yLlfEuclkOM9/amIRIZfT8073/2RIgL+yj9fOE=;
	b=OPtR9UHxW5oF40Yeq4YiTrCjSxlFha++jwIqQxQO4LtUBZsXBHhJOeKQgp8Vwkf8GxhaLM
	QGciUSJlzLN5ifDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C21213963;
	Tue, 21 Jan 2025 11:37:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jZfZBvCGj2dGGQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 21 Jan 2025 11:37:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C1EB8A0889; Tue, 21 Jan 2025 12:37:15 +0100 (CET)
Date: Tue, 21 Jan 2025 12:37:15 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH v2 3/8] ext4: reject the 'data_err=abort' option in
 nojournal mode
Message-ID: <2hr7ifk6f7ojn3iubi3qj2yp5m72fvbch22afkmw2emsypz5kv@uah27xxstly3>
References: <20250121071050.3991249-1-libaokun@huaweicloud.com>
 <20250121071050.3991249-4-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121071050.3991249-4-libaokun@huaweicloud.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 21-01-25 15:10:45, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> data_err=abort aborts the journal on I/O errors. However, this option is
> meaningless if journal is disabled, so it is rejected in nojournal mode
> to reduce unnecessary checks. Also, this option is ignored upon remount.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> ---
> Or maybe we should make mount and remount consistent?
> Rejecting it in both would make things a lot easier.

The reason why it is ignored on remount is that we cannot modify
JBD2_ABORT_ON_SYNCDATA_ERR on remount. Now that we don't really depend on
JBD2_ABORT_ON_SYNCDATA_ERR, we could indeed make mount and remount
consistent and probably just drop JBD2_ABORT_ON_SYNCDATA_ERR altogether
(and only warn in jbd2 as it used to be long ago).

								Honza
> 
>  fs/ext4/super.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index a50e5c31b937..34a7b6523f8b 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -2785,6 +2785,13 @@ static int ext4_check_opt_consistency(struct fs_context *fc,
>  	}
>  
>  	if (is_remount) {
> +		if (!sbi->s_journal &&
> +		    ctx_test_mount_opt(ctx, EXT4_MOUNT_DATA_ERR_ABORT)) {
> +			ext4_msg(NULL, KERN_WARNING,
> +				 "Remounting fs w/o journal so ignoring data_err option");
> +			ctx_clear_mount_opt(ctx, EXT4_MOUNT_DATA_ERR_ABORT);
> +		}
> +
>  		if (ctx_test_mount_opt(ctx, EXT4_MOUNT_DAX_ALWAYS) &&
>  		    (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA)) {
>  			ext4_msg(NULL, KERN_ERR, "can't mount with "
> @@ -5428,6 +5435,11 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  				 "data=, fs mounted w/o journal");
>  			goto failed_mount3a;
>  		}
> +		if (test_opt(sb, DATA_ERR_ABORT)) {
> +			ext4_msg(sb, KERN_ERR,
> +				 "can't mount with data_err=abort, fs mounted w/o journal");
> +			goto failed_mount3a;
> +		}
>  		sbi->s_def_mount_opt &= ~EXT4_MOUNT_JOURNAL_CHECKSUM;
>  		clear_opt(sb, JOURNAL_CHECKSUM);
>  		clear_opt(sb, DATA_FLAGS);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

