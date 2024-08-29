Return-Path: <linux-ext4+bounces-3960-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D94DB963F97
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Aug 2024 11:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92305286BAC
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Aug 2024 09:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8D64A00;
	Thu, 29 Aug 2024 09:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="k21MZ73l";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7VrqorWl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="k21MZ73l";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7VrqorWl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40F6219E0;
	Thu, 29 Aug 2024 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724922713; cv=none; b=QCStBqCueliX9uNFs08XwSpWpKh8olkbsPTQGnExw+oQ3ux3nM1sIuMI7JN1zv1Pr1Gmy6JUiS8w2ZCbXy4PO9/soKRCda9BFlbkFRq7u0Pl/eEhC1068FfVzTMSdezGx4pV/jr5RaGftPHSVWsgg7j6BLpBQyxGSNr48PSRlTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724922713; c=relaxed/simple;
	bh=DjyGYt4zh6XoRL6FxUYWiD0tdZRVKoAmB0YnG6E5v+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKVmtoyRcVfJAscZ31r/nquRppkGiPl5pQuv/nd7N7SHcZEkF192vehHuEZ5CrEfWWDi9SLrKSPueX2TYtC/Fj0HF/iStcLG2HjXrOMQ3rXqLekuwPZa1LG1/v3rF4dSbpgN/IvftmJzfZblOiSDnPvlqK9qbU3K3N5aSxBNoAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=k21MZ73l; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7VrqorWl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=k21MZ73l; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7VrqorWl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 264B921290;
	Thu, 29 Aug 2024 09:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724922710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QSATJhME5RkQjU2PWGZOr26aa4H8WiTKOXyMn0wGnp0=;
	b=k21MZ73lyjHKSWv5vto2qSeutPNZGtbySS4rhFjc1QXGlPQFNek2cJpxG7sfl1Ytps8KGh
	gQ5wA9qHwfWq7LMRk4RGrPf5IK8ZB3cayttgfNdagguflNsUmAaa5XpKSFO4WwcGzRf4ks
	g4kSNl9gXy1Jr8hadtKTzF6K1uBZBg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724922710;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QSATJhME5RkQjU2PWGZOr26aa4H8WiTKOXyMn0wGnp0=;
	b=7VrqorWlT/4D5euGakGbJ1DLGXbmX1uYzbDyTTKz20ljjIfy6j4aCqZZQGedooLYB+mjlr
	wbEhbCPChF1y9xCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724922710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QSATJhME5RkQjU2PWGZOr26aa4H8WiTKOXyMn0wGnp0=;
	b=k21MZ73lyjHKSWv5vto2qSeutPNZGtbySS4rhFjc1QXGlPQFNek2cJpxG7sfl1Ytps8KGh
	gQ5wA9qHwfWq7LMRk4RGrPf5IK8ZB3cayttgfNdagguflNsUmAaa5XpKSFO4WwcGzRf4ks
	g4kSNl9gXy1Jr8hadtKTzF6K1uBZBg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724922710;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QSATJhME5RkQjU2PWGZOr26aa4H8WiTKOXyMn0wGnp0=;
	b=7VrqorWlT/4D5euGakGbJ1DLGXbmX1uYzbDyTTKz20ljjIfy6j4aCqZZQGedooLYB+mjlr
	wbEhbCPChF1y9xCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A3D013408;
	Thu, 29 Aug 2024 09:11:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /IxgBlY70GY9bQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 29 Aug 2024 09:11:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C3A76A0965; Thu, 29 Aug 2024 11:11:34 +0200 (CEST)
Date: Thu, 29 Aug 2024 11:11:34 +0200
From: Jan Kara <jack@suse.cz>
To: zhangshida <starzhangzsd@gmail.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
	ebiggers@kernel.org, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 1/3] ext4: persist the new uptodate buffers in
 ext4_journalled_zero_new_buffers
Message-ID: <20240829091134.rf2fcyqxoxapulbe@quack3>
References: <20240829085407.3331490-1-zhangshida@kylinos.cn>
 <20240829085407.3331490-2-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829085407.3331490-2-zhangshida@kylinos.cn>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo,kylinos.cn:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 29-08-24 16:54:05, zhangshida wrote:
> From: Shida Zhang <zhangshida@kylinos.cn>
> 
> For new uptodate buffers we also need to call write_end_fn() to persist the
> uptodate content, similarly as folio_zero_new_buffers() does it.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 941c1c0d5c6e..a0a55cb8db53 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1389,9 +1389,9 @@ static void ext4_journalled_zero_new_buffers(handle_t *handle,
>  					size = min(to, block_end) - start;
>  
>  					folio_zero_range(folio, start, size);
> -					write_end_fn(handle, inode, bh);
>  				}
>  				clear_buffer_new(bh);
> +				write_end_fn(handle, inode, bh);
>  			}
>  		}
>  		block_start = block_end;
> -- 
> 2.33.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

