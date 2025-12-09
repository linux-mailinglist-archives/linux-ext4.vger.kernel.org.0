Return-Path: <linux-ext4+bounces-12237-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C6BCAF59F
	for <lists+linux-ext4@lfdr.de>; Tue, 09 Dec 2025 09:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C4D3302CF63
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Dec 2025 08:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96AC2D8362;
	Tue,  9 Dec 2025 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vUAFLXed";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gXcm/H6s";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vUAFLXed";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gXcm/H6s"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F4928CF7C
	for <linux-ext4@vger.kernel.org>; Tue,  9 Dec 2025 08:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765270590; cv=none; b=Jg2sti5LdsGD9UcZVr/S34zDuXFCsP4i/XS63OoZ/HRhCySfh72XMpaMLV/ta4xhx9X0j1xVmaQVnmziT33ClvSHLSGFnGQ0w39CSZS9i//dhXtdX/I4fPoFZ/DRd+TUEg5BJNdgYa7xMmlfztj4AHkkTod2gAt2O8lvNGJslZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765270590; c=relaxed/simple;
	bh=Mvr0y8wLxtgpbN0+HeKuuLMTQuZ5zTDxyqjMNL38iQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmDBfCX8AbVYScBwxyLbN44UCmylYHrlf+XMb3TT7Z4mTpwsC/UTeKrdKY7mNDq3P9QdNLvEWfcQunRRKCJfFZq3D6jiGA1aq1AsqSYRv16jBfKB402NVNjNVGUNarUVh7esvONME1Sct4hiphIvqSl6BDI/ShNFpRSBidYCEwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vUAFLXed; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gXcm/H6s; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vUAFLXed; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gXcm/H6s; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AF3BC5BDA4;
	Tue,  9 Dec 2025 08:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765270585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F3///qzFxJCD9tlXRACR7G0C01dKSlkkvy1pOe5/b5M=;
	b=vUAFLXedd3c+8M5b5SORvRRJxbZEgsAOQvA9TLgYMNrggRjX2Hju8qvGUjoVckl9G3Ikn7
	v2sNnhN0t0DbhZXLWSQWlgnNh2FyvMgSBVUfzpHHoYV17yAZ4iE71yaXj/O6MGbOvHxJgR
	XaXTAMUpjobwjTK0hzmTn17CV5WLfGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765270585;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F3///qzFxJCD9tlXRACR7G0C01dKSlkkvy1pOe5/b5M=;
	b=gXcm/H6sWValdtbfKJyacH6WVhFx+CcO+/0C4JJOs0SVlHkfccAktelUbAN9PBZihra1dj
	tKw3U6OkoNhiMBDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vUAFLXed;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="gXcm/H6s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765270585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F3///qzFxJCD9tlXRACR7G0C01dKSlkkvy1pOe5/b5M=;
	b=vUAFLXedd3c+8M5b5SORvRRJxbZEgsAOQvA9TLgYMNrggRjX2Hju8qvGUjoVckl9G3Ikn7
	v2sNnhN0t0DbhZXLWSQWlgnNh2FyvMgSBVUfzpHHoYV17yAZ4iE71yaXj/O6MGbOvHxJgR
	XaXTAMUpjobwjTK0hzmTn17CV5WLfGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765270585;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F3///qzFxJCD9tlXRACR7G0C01dKSlkkvy1pOe5/b5M=;
	b=gXcm/H6sWValdtbfKJyacH6WVhFx+CcO+/0C4JJOs0SVlHkfccAktelUbAN9PBZihra1dj
	tKw3U6OkoNhiMBDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A477C3EA63;
	Tue,  9 Dec 2025 08:56:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZukbKDnkN2l2GgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 09 Dec 2025 08:56:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 621CEA0A1B; Tue,  9 Dec 2025 09:56:25 +0100 (CET)
Date: Tue, 9 Dec 2025 09:56:25 +0100
From: Jan Kara <jack@suse.cz>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.cz>, Arnd Bergmann <arnd@arndb.de>, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] ext4: fix ext4_tune_sb_params padding
Message-ID: <3d5u34hrtdiyiyqporwsyfde5a5msyodnjw5oulhdib3givjek@aakrdecmyiou>
References: <20251205111906.1247452-1-arnd@kernel.org>
 <20251208180310.GH89492@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208180310.GH89492@frogsfrogsfrogs>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,suse.com:email,arndb.de:email];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: AF3BC5BDA4
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Mon 08-12-25 10:03:10, Darrick J. Wong wrote:
> On Fri, Dec 05, 2025 at 12:19:00PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The padding at the end of struct ext4_tune_sb_params is architecture
> > specific and in particular is different between x86-32 and x86-64,
> > since the __u64 member only enforces struct alignment on the latter.
> > 
> > This shows up as a new warning when test-building the headers with
> > -Wpadded:
> > 
> > include/linux/ext4.h:144:1: error: padding struct size to alignment boundary with 4 bytes [-Werror=padded]
> > 
> > All members inside the structure are naturally aligned, so the only
> > difference here is the amount of padding at the end.
> > 
> > Add explicit padding to mount_opts[] to keep the struct members compatible
> > with the original version and also keep the pad[64] member 8-byte
> > aligned for future extensions.  This gives a consistent sizeof(struct
> > ext4_tune_sb_params) of 232 on all architectures and avoids adding compat
> > ioctl handling for EXT4_IOC_GET_TUNE_SB_PARAM/EXT4_IOC_SET_TUNE_SB_PARAM.
> > 
> > This is an ABI break on x86-32 but hopefully this can go into 6.18.y
> > early enough as a fixup so no actual users will be affected.
> > 
> > Fixes: 04a91570ac67 ("ext4: implemet new ioctls to set and get superblock parameters")
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > v2: extend mount_opts[] instead of pad[], as suggested by Andreas Dilger
> > ---
> >  include/uapi/linux/ext4.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/uapi/linux/ext4.h b/include/uapi/linux/ext4.h
> > index 6829d6f1497d..1c7cdcdb7dca 100644
> > --- a/include/uapi/linux/ext4.h
> > +++ b/include/uapi/linux/ext4.h
> > @@ -139,7 +139,7 @@ struct ext4_tune_sb_params {
> >  	__u32 clear_feature_compat_mask;
> >  	__u32 clear_feature_incompat_mask;
> >  	__u32 clear_feature_ro_compat_mask;
> > -	__u8  mount_opts[64];
> > +	__u8  mount_opts[68];
> 
> Hmm... given that the ondisk super field is a __u8[64], it feels weird
> to expose a __u8[68] field in the ioctl ABI and silently truncate the
> user's input if they try to use that many bytes.  I'd have enlarged the
> padding field but as Ted was both author and maintainer I'm ok with
> letting him have the final say.

The point about silent truncation is a good one. I thought
ext4_sb_setparams() checks the return value of strscpy_pad() but it doesn't
so IMO that needs fixing.

								Honza

> 
> --D
> 
> >  	__u8  pad[64];
> >  };
> >  
> > -- 
> > 2.39.5
> > 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

