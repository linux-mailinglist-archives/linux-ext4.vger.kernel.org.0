Return-Path: <linux-ext4+bounces-5894-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE71BA022B4
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jan 2025 11:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29CCC1884799
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jan 2025 10:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D711D63D7;
	Mon,  6 Jan 2025 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yQGJO2Ij";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Eu+0U08a";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yQGJO2Ij";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Eu+0U08a"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3A812F59C
	for <linux-ext4@vger.kernel.org>; Mon,  6 Jan 2025 10:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736158226; cv=none; b=oKFlkpfKRZ7b7CJvsBVOyovnqdf780m70tuHyxUaAlTZNfCO0V4hJ6H9gnPKq6R7aVH/mNUm4KvAq88GSVD+pfVQbkphdwiSAbtvrsWaQmxfV4DLDWyGg/HY4jXJU6ZC7TWRbxEXH+rV08EgEpJTY6PB2Yqhqw4zhDAqvjdcppo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736158226; c=relaxed/simple;
	bh=vpIKrHMaxSmOMUH0wMbgr028E+Xu8G/MlzHo6zbsBo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ti9jLq/Ik+ib7MWCioOvdvXufiu2FcAV90EedntcKcqqbpeghNQpVu2pAwtETYQJizqb7YQOKEmC/eHiYkrjrdHDrDElTwP9lzDFP0dDaaskzTjRpyZ+5lvHqtp30IMPHzD89Yq5ffqoD39hUVu/v0B9OJV2YVmUpBkyheAsKGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yQGJO2Ij; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Eu+0U08a; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yQGJO2Ij; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Eu+0U08a; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A6D0321108;
	Mon,  6 Jan 2025 10:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736158222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PV3Xb69/qYL+1g3Ze9qA41pPnevsepWG6i2hsJNTZm0=;
	b=yQGJO2IjbGBcB3FPYBnMhVIkTxRycig0vA5WGFnx1M1q3Lj/f3o+OYp/WkjanTg3Iz5E8j
	dDUV8sq2TySw4uUMT+SrHOBi/+4hVKtbSADZYLp9aOuVFngCLw3F08Hw4O+3mhG++oVhbk
	ZelAaTvVz2KNGh0kcUvQlzOUkGcbkRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736158222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PV3Xb69/qYL+1g3Ze9qA41pPnevsepWG6i2hsJNTZm0=;
	b=Eu+0U08aqg0jNv3wgzHIyd76f9ZLq034qTOhSiceBIaNbNhuL5lxcXt+udQFwsGyWLwfY6
	hKleFd9kKTV0stAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736158222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PV3Xb69/qYL+1g3Ze9qA41pPnevsepWG6i2hsJNTZm0=;
	b=yQGJO2IjbGBcB3FPYBnMhVIkTxRycig0vA5WGFnx1M1q3Lj/f3o+OYp/WkjanTg3Iz5E8j
	dDUV8sq2TySw4uUMT+SrHOBi/+4hVKtbSADZYLp9aOuVFngCLw3F08Hw4O+3mhG++oVhbk
	ZelAaTvVz2KNGh0kcUvQlzOUkGcbkRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736158222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PV3Xb69/qYL+1g3Ze9qA41pPnevsepWG6i2hsJNTZm0=;
	b=Eu+0U08aqg0jNv3wgzHIyd76f9ZLq034qTOhSiceBIaNbNhuL5lxcXt+udQFwsGyWLwfY6
	hKleFd9kKTV0stAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99CFF137DA;
	Mon,  6 Jan 2025 10:10:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KnWEJQ6se2dUegAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 06 Jan 2025 10:10:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4A857A089C; Mon,  6 Jan 2025 11:10:18 +0100 (CET)
Date: Mon, 6 Jan 2025 11:10:18 +0100
From: Jan Kara <jack@suse.cz>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: jack@suse.cz, linux-ext4@vger.kernel.org, tytso@mit.edu, 
	uekawa@chromium.org
Subject: Re: [PATCH v2] tune2fs: do not update quota when not needed
Message-ID: <2hdmxzu3ckem3pbnf7lp7rr3twme2coqvwbnymwmmmkodzjnpf@o2q2ermvex5f>
References: <20240912091558.jbmwtnvfxrymjch2@quack3>
 <20250103235042.4029197-1-gwendal@chromium.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103235042.4029197-1-gwendal@chromium.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 03-01-25 15:50:42, Gwendal Grignou wrote:
> Enabling quota is expensive: All inodes in the filesystem are scanned.
> Only do it when the requested quota configuration does not match the
> existing configuration.
> 
> Test:
> Add a tiny patch to print out when core of function
> handle_quota_options() is triggered.
> Issue commands:
> truncate -s 1G unused ; mkfs.ext4 unused
> 
> | commands                                                | trigger |
> comments
> +---------------------------------------------------------+---------+---------
> | tune2fs -Qusrquota,grpquota -Qprjquota -O quota unused  | Y       |
>                   Quota not set at formatting.
> | tune2fs -Qusrquota,grpquota -Qprjquota -O quota unused  | N       |
>                   Already set just above
> | tune2fs -Qusrquota,grpquota -Q^prjquota -O quota unused | Y       |
>                   Disabling a quota
> | tune2fs -Qusrquota,grpquota -Q^prjquota -O quota unused | N       |
>                   No change from previous line.
> | tune2fs -Qusrquota,grpquota -O quota unused             | N       |
>                   No change from previous line.
> | tune2fs -Qusrquota,^grpquota -O quota unused            | Y       |
>                   Disabling a quota
> | tune2fs -Qusrquota -O quota unused                      | N       |
>                   No change from previous line.
> | tune2fs -O ^quota unused                                | Y       |
>                   Remove quota
> | tune2fs -O quota unused                                 | Y       |
>                   Re-enable quota, default values
>                   (-Qusrquota,grpquota) used.
> | tune2fs -O quota -Qusrquota unused                      | N       |
>                   Already set just above
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> ---
> Changes in v2:
> Logic has been simplified, based on jack@suse.cz feedback.
> 
>  misc/tune2fs.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/misc/tune2fs.c b/misc/tune2fs.c
> index 2548a766..3db57632 100644
> --- a/misc/tune2fs.c
> +++ b/misc/tune2fs.c
> @@ -1799,11 +1799,27 @@ static int handle_quota_options(ext2_filsys fs)
>  		return 1;
>  	}
>  
> +	for (qtype = 0; qtype < MAXQUOTAS; qtype++) {
> +		if (quota_enable[qtype] == QOPT_ENABLE &&
> +		    *quota_sb_inump(fs->super, qtype) == 0) {
> +			/* Some work needed to match the configuration. */
> +			break;
> +		}
> +		if (quota_enable[qtype] == QOPT_DISABLE &&
> +		    *quota_sb_inump(fs->super, qtype)) {
> +			/* Some work needed to match the configuration. */
> +			break;
> +		}
> +	}
> +	if (qtype == MAXQUOTAS) {
> +		/* Nothing to do. */
> +		return 0;
> +	}
> +
>  	for (qtype = 0; qtype < MAXQUOTAS; qtype++) {
>  		if (quota_enable[qtype] == QOPT_ENABLE)
>  			qtype_bits |= 1 << qtype;
>  	}
> -
>  	retval = quota_init_context(&qctx, fs, qtype_bits);
>  	if (retval) {
>  		com_err(program_name, retval,
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

