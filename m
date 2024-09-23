Return-Path: <linux-ext4+bounces-4276-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3377897EA9F
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Sep 2024 13:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82B34B21365
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Sep 2024 11:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8FD198832;
	Mon, 23 Sep 2024 11:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LfmRKmnq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XMCNhzdL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oAi6riAL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ufx7qkml"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9495C944E;
	Mon, 23 Sep 2024 11:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727090687; cv=none; b=mar9OKghAnVr3uCgvAXcmXGJjjJ4d824R+ibcF2bitJX0z9OekQUXpCTzgQfb+UiKDA07t+vJa408Wq05G5Lb3AnDKd9nLtJ8BuxlCnoe0B7dKrzUihMwBUzfJQzVVlPUT4/rSOpDLl47/ZtxIdjaKgXUsG2kZGydfxhrLhZXis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727090687; c=relaxed/simple;
	bh=TDMHdTKfATd/dykqfdr8JyYigMdMf6pQbZ437Da5dCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UoIVkO9MDjskTq9GhBtZ1fBdOZNTgGUCMaUBhWpTdKDJG7BfpDwjEr3pk7FXkISgjNIYx4OnfU/M3GSRUMjONRrx/xeXx/tnrt9xoCmfsF9KG9stq4qcp/DevozRzcDR9GXxh24AFfwbKo7fcoBot1RZ+QH5O2Jb41E6prhpk6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LfmRKmnq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XMCNhzdL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oAi6riAL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ufx7qkml; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9BE2521EFF;
	Mon, 23 Sep 2024 11:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727090683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7/KdNH7ixd2/09AxnzQSLbxMpALLTS1WnI8+v7RLZc8=;
	b=LfmRKmnqjjIdnOPmvvu4dKL873achQT+wvmcGOxNYdt8/Vn7by21hQQRPEzo2Pt8kIlPOa
	Xd5zCGAx5Y3FCxF+UCxQH9VHQWAb8tAwuuFk2k/EtYmHHLqkMNNqJ2WQHHeyt7hdF57zal
	sTdRhlEVxvjpB/4oRAyarHR0IQZl4g0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727090683;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7/KdNH7ixd2/09AxnzQSLbxMpALLTS1WnI8+v7RLZc8=;
	b=XMCNhzdLdyVPOb5Rh6zPOfGAjZqpDNoU1RU5H2p62ErqP2zAlikZev/R95J9+bEFaNmsI6
	uriKRuqMSY5s7bAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727090682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7/KdNH7ixd2/09AxnzQSLbxMpALLTS1WnI8+v7RLZc8=;
	b=oAi6riALFaab8eKPk7cq6ZR2WHLl0JnJW7z6UaxNSjPsWRVI05k209AOBKShdRmihAgbXy
	qYGuUdFYEkGsUKt20ziO8/IRbOD+jAny7W9Rj57wbi72rO1XhZOgjemd7xt/ZdtBMOUqoQ
	nmttandoSJFm8A+xoujydudx7PXXdP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727090682;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7/KdNH7ixd2/09AxnzQSLbxMpALLTS1WnI8+v7RLZc8=;
	b=Ufx7qkmlISh57+kAKK52RONXoU0sqac5vQlowIDOyzT3T2CaWA/iUshRUiEKrTDxB7dfv7
	H5IuDSI2QUddRqDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D9441347F;
	Mon, 23 Sep 2024 11:24:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OeN+IvpP8WZnKAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Sep 2024 11:24:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 487C0A0844; Mon, 23 Sep 2024 13:24:38 +0200 (CEST)
Date: Mon, 23 Sep 2024 13:24:38 +0200
From: Jan Kara <jack@suse.cz>
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ext4: mark fc as ineligible using an handle in
 ext4_xattr_set()
Message-ID: <20240923112438.gjn33ztjtimly4eu@quack3>
References: <20240923104909.18342-1-luis.henriques@linux.dev>
 <20240923104909.18342-3-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923104909.18342-3-luis.henriques@linux.dev>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[mit.edu,dilger.ca,suse.cz,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,linux.dev:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Mon 23-09-24 11:49:09, Luis Henriques (SUSE) wrote:
> Calling ext4_fc_mark_ineligible() with a NULL handle is racy and may result
> in a fast-commit being done before the filesystem is effectively marked as
> ineligible.  This patch moves the call to this function so that an handle
> can be used.  If a transaction fails to start, then there's not point in
> trying to mark the filesystem as ineligible, and an error will eventually be
> returned to user-space.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/xattr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 46ce2f21fef9..aea9e3c405f1 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -2559,6 +2559,8 @@ ext4_xattr_set(struct inode *inode, int name_index, const char *name,
>  
>  		error = ext4_xattr_set_handle(handle, inode, name_index, name,
>  					      value, value_len, flags);
> +		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_XATTR,
> +					handle);
>  		error2 = ext4_journal_stop(handle);
>  		if (error == -ENOSPC &&
>  		    ext4_should_retry_alloc(sb, &retries))
> @@ -2566,7 +2568,6 @@ ext4_xattr_set(struct inode *inode, int name_index, const char *name,
>  		if (error == 0)
>  			error = error2;
>  	}
> -	ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_XATTR, NULL);
>  
>  	return error;
>  }
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

