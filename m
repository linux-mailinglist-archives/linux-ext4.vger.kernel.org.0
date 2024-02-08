Return-Path: <linux-ext4+bounces-1178-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC51784E8A2
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Feb 2024 20:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C56B1C297A7
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Feb 2024 19:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60332421D;
	Thu,  8 Feb 2024 19:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FTKS6htP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BOcd2SgB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FTKS6htP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BOcd2SgB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6271D557;
	Thu,  8 Feb 2024 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418978; cv=none; b=D2NYOdu9X/k7EqoVdBZtITc7abRJ2n5dxvirDco1UWnBV0MyKbhAjRffsBlXPj5gv407yobdjqIyaXZ8GVVHMNeB2PShxaKF3ih/OWjZO1nwuKmmmYyycA1vwxOjxiIH+mV42u197B7H1HP3c3CHa8jQO6sU8DbaZV11lnmPp/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418978; c=relaxed/simple;
	bh=/YSE+gaDDx8Hjfm4z2CAlqbpuQepnagPldZO0zEkhB8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=huAhiXJH6yPwZTexfPr/5OgofV86Y4GzXhmMbG+6L3hkDOrsCeMxZuhEz3nrTNay8y9UYf/o0Ij8UhdKzx+Q85x3JzIsVjGZ7EyRm1Pc9TiWoXP26XEdVEjSlLCYD9J3pW/WRtaXgaGhXmm/1ZujPDjFhkxWjtYW3WMQf3J8XPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FTKS6htP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BOcd2SgB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FTKS6htP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BOcd2SgB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3D8B61FD01;
	Thu,  8 Feb 2024 19:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707418973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A4tl48kor+w9AEk22DCGxhyQHgkJ9/sl7JjncIPs25U=;
	b=FTKS6htP6WOTy7nLhwzMaMrwe2A0f985BZTD+CGOAAQ1dw8GYU8uBuHuKaBJtpNoH0/dIX
	sDt5O8V+KtNwoed/wW+6KkMTrnGa63KEFoK2X771qFLvxQk+E11iJP4Vhoim5qSvLWUk6M
	R76StbIBFz57+yrnjfcNmWFCHiQ+Bds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707418973;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A4tl48kor+w9AEk22DCGxhyQHgkJ9/sl7JjncIPs25U=;
	b=BOcd2SgB+PsFT41UfsET58Gw1v1V9s4TIq904lcby7N+YXdoy8Ro/YfA1/Uhgkbkbu97r2
	lcZwrlIzxhs50gAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707418973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A4tl48kor+w9AEk22DCGxhyQHgkJ9/sl7JjncIPs25U=;
	b=FTKS6htP6WOTy7nLhwzMaMrwe2A0f985BZTD+CGOAAQ1dw8GYU8uBuHuKaBJtpNoH0/dIX
	sDt5O8V+KtNwoed/wW+6KkMTrnGa63KEFoK2X771qFLvxQk+E11iJP4Vhoim5qSvLWUk6M
	R76StbIBFz57+yrnjfcNmWFCHiQ+Bds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707418973;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A4tl48kor+w9AEk22DCGxhyQHgkJ9/sl7JjncIPs25U=;
	b=BOcd2SgB+PsFT41UfsET58Gw1v1V9s4TIq904lcby7N+YXdoy8Ro/YfA1/Uhgkbkbu97r2
	lcZwrlIzxhs50gAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3F921326D;
	Thu,  8 Feb 2024 19:02:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZltbNVwlxWU9OAAAD6G6ig
	(envelope-from <krisman@suse.de>); Thu, 08 Feb 2024 19:02:52 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: tytso@mit.edu,  adilger.kernel@dilger.ca,  linux-ext4@vger.kernel.org,
  linux-kernel@vger.kernel.org,  kernel@collabora.co,  Gabriel Krisman
 Bertazi <krisman@collabora.com>,  Eric Biggers <ebiggers@google.com>
Subject: Re: [RESEND PATCH v9] ext4: Log error when lookup of encoded dentry
 fails
In-Reply-To: <20240208083511.270636-1-eugen.hristev@collabora.com> (Eugen
	Hristev's message of "Thu, 8 Feb 2024 10:35:11 +0200")
References: <20240208083511.270636-1-eugen.hristev@collabora.com>
Date: Thu, 08 Feb 2024 14:02:51 -0500
Message-ID: <87le7uvkx0.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FTKS6htP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BOcd2SgB
X-Spamd-Result: default: False [-2.58 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.27)[73.86%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3D8B61FD01
X-Spam-Level: 
X-Spam-Score: -2.58
X-Spam-Flag: NO

Eugen Hristev <eugen.hristev@collabora.com> writes:

> From: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> If the volume is in strict mode, ext4_ci_compare can report a broken
> encoding name.  This will not trigger on a bad lookup, which is caught
> earlier, only if the actual disk name is bad.
>
> Reviewed-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>

Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>

> ---
> Hello,
>
> I am trying to respin the series here :
> https://www.spinics.net/lists/linux-ext4/msg85081.html
>
> To make it easier to apply I split it into smaller chunks which address
> one single thing.
>
> This patch simply adds an error message in the UNICODE path.
>
>  fs/ext4/namei.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 6e7af8dc4dde..7d357c417475 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -1477,6 +1477,9 @@ static bool ext4_match(struct inode *parent,
>  			 * only case where it happens is on a disk
>  			 * corruption or ENOMEM.
>  			 */
> +			if (ret == -EINVAL)
> +				EXT4_ERROR_INODE(parent,
> +					"Directory contains filename that is invalid UTF-8");
>  			return false;
>  		}
>  		return ret;

-- 
Gabriel Krisman Bertazi

