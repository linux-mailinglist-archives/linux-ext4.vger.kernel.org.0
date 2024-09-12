Return-Path: <linux-ext4+bounces-4126-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E697897654D
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Sep 2024 11:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175391C23377
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Sep 2024 09:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F114F193426;
	Thu, 12 Sep 2024 09:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VLxAmZIj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hot8nbMu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VLxAmZIj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hot8nbMu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FF0126C16
	for <linux-ext4@vger.kernel.org>; Thu, 12 Sep 2024 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726132565; cv=none; b=eSuW0uMJNmtFYe2e8bfmDx+yzxoK2io6VCqUPXphAUVCyBFln+XlT3SrpPoG691J0sh6LrULmZrSkA42pH8P171v6uX97LXWlzwAb6o8Y67re5FI1H4N0+iUnvQ5Z62jDjvtEktBWGEtIwA5xudBfyaSROgDVtIh2hWrgPRkPws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726132565; c=relaxed/simple;
	bh=hvei8kzsoNf/lE5gg5GgGX1ZMMSjhcnklY2h2rGOWQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vby/sDGlFSVAajtxxDIIniYY4HC5kVYqtkg2j0wWVKzMKw8dZIfqL7RgEIFe8zf6dNuYVRzXtKwMPBwdRP/Wj5HBqiVdeCQgxTS4KBKVLvDoCj7cDRMVgHEZfAbFHjLNYhAW4Ly9//vPKd+XEQo76U0SoDqei4tf2g2UuVdQhRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VLxAmZIj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hot8nbMu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VLxAmZIj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hot8nbMu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5994121AED;
	Thu, 12 Sep 2024 09:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726132559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o8IeVkjXV8aZM/PYDu6LHmJklhDX53CyYWWujBzn8x4=;
	b=VLxAmZIjNR651dvRTQ08uKjK4JKw0+Db8sp15SxL+Vqw7/mo7VmAqpDsCAYPpN4OHniVzd
	vFBCBC5HGzbctyeZaZ1+Vyj5DheefL4WWhTRoq83vCESRecOpRxv8GSrQGYAWAu9lxoFbT
	Pcn28OCS4RAtXWbOPApZGQPte9J0O3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726132559;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o8IeVkjXV8aZM/PYDu6LHmJklhDX53CyYWWujBzn8x4=;
	b=Hot8nbMuyXlU7yDal33COj/SSKEA0AkpF53hdPdfMLju7Fa8rRPnQ8vvBAJn3ZsUqZcJzL
	k2LCHagTtNYko2Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VLxAmZIj;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Hot8nbMu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726132559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o8IeVkjXV8aZM/PYDu6LHmJklhDX53CyYWWujBzn8x4=;
	b=VLxAmZIjNR651dvRTQ08uKjK4JKw0+Db8sp15SxL+Vqw7/mo7VmAqpDsCAYPpN4OHniVzd
	vFBCBC5HGzbctyeZaZ1+Vyj5DheefL4WWhTRoq83vCESRecOpRxv8GSrQGYAWAu9lxoFbT
	Pcn28OCS4RAtXWbOPApZGQPte9J0O3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726132559;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o8IeVkjXV8aZM/PYDu6LHmJklhDX53CyYWWujBzn8x4=;
	b=Hot8nbMuyXlU7yDal33COj/SSKEA0AkpF53hdPdfMLju7Fa8rRPnQ8vvBAJn3ZsUqZcJzL
	k2LCHagTtNYko2Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D4ED13A73;
	Thu, 12 Sep 2024 09:15:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AvbcEk+x4mY7HgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 12 Sep 2024 09:15:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C6986A08B3; Thu, 12 Sep 2024 11:15:58 +0200 (CEST)
Date: Thu, 12 Sep 2024 11:15:58 +0200
From: Jan Kara <jack@suse.cz>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: tytso@mit.edu, uekawa@chromium.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] tune2fs: do not update quota when not needed
Message-ID: <20240912091558.jbmwtnvfxrymjch2@quack3>
References: <20240830185921.2690798-1-gwendal@chromium.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830185921.2690798-1-gwendal@chromium.org>
X-Rspamd-Queue-Id: 5994121AED
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 30-08-24 11:59:21, Gwendal Grignou wrote:
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
> | commands                                                | trigger | comments
> +---------------------------------------------------------+---------+---------
> | tune2fs -Qusrquota,grpquota -Qprjquota -O quota unused  | Y       |
>                   Quota not set at formatting.
> | tune2fs -Qusrquota,grpquota -Qprjquota -O quota unused  | N       |
>                   Already set just above
> | tune2fs -Qusrquota,grpquota -Q^prjquota -O quota unused | Y       |
>                   Disabling a quota option always force a deep look.
> | tune2fs -Qusrquota,grpquota -Q^prjquota -O quota unused | Y       |
>                   See just above
> | tune2fs -Qusrquota,grpquota -O quota unused             | N       |
>                   No change from previous line.
> | tune2fs -Qusrquota,^grpquota -O quota unused            | Y       |
>                   Disabling a quota option always force a deep look.
> | tune2fs -Qusrquota -O quota unused                      | N       |
>                   No change from previous line.
> | tune2fs -O ^quota unused                                | Y       |
>                   Remove quota
> | tune2fs -O quota unused                                 | X       |
>                   function handle_quota_options() not called, default values
>                   (-Qusrquota,grpquota) used.
> | tune2fs -O quota -Qusrquota unused                      | N       |
>                   Already set just above

Good idea. One comment regarding the code:

> diff --git a/misc/tune2fs.c b/misc/tune2fs.c
> index 6de40e93..3cce8861 100644
> --- a/misc/tune2fs.c
> +++ b/misc/tune2fs.c
> @@ -1804,6 +1804,41 @@ static int handle_quota_options(ext2_filsys fs)
>  			qtype_bits |= 1 << qtype;
>  	}
>  
> +	/*
> +	 * Check if the filesystem already has quota enabled and more features
> +	 * need to be enabled and are not, or some features need to be disabled.
> +	 */
> +	if (ext2fs_has_feature_quota(fs->super) && qtype_bits) {
> +		for (qtype = 0 ; qtype < MAXQUOTAS; qtype++) {
> +			if ((quota_enable[qtype] == QOPT_ENABLE &&
> +			     *quota_sb_inump(fs->super, qtype) == 0) ||
> +			    (quota_enable[qtype] == QOPT_DISABLE)) {
> +				/* Some work needed to match the configuration. */
> +				break;
> +			}
> +		}
> +		if (qtype == MAXQUOTAS) {
> +			/* Nothing to do. */
> +			return 0;
> +		}
> +	}
> +	/*
> +	 * Check if the user wants all features disabled and it is already
> +	 * the case.
> +	 */
> +	if (!ext2fs_has_feature_quota(fs->super) && !qtype_bits) {
> +		for (qtype = 0 ; qtype < MAXQUOTAS; qtype++) {
> +			if (*quota_sb_inump(fs->super, qtype)) {
> +				/* Some work needed to match the configuration. */
> +				break;
> +			}
> +		}
> +		if (qtype == MAXQUOTAS) {
> +			/* Nothing to do. */
> +			return 0;
> +		}
> +	}

Why don't you do it like:

	for (qtype = 0 ;qtype < MAXQUOTAS; qtype++) {
		if (quota_enable[qtype] == QOPT_ENABLE &&
		     *quota_sb_inump(fs->super, qtype) == 0) {
			/* Need to enable this quota type. */
			break;
		}
		if (quota_enable[qtype] == QOPT_DISABLE &&
		    *quota_sb_inump(fs->super, qtype)) {
			/* Need to disable this quota type. */
			break;
		}
	}
	if (qtype == MAXQUOTAS) {
		/* Nothing to do. */
		return 0;
	}

As far as I can tell this should result in similar decisions and should be
much easier to understand what's going on...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

