Return-Path: <linux-ext4+bounces-1599-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E30D2878851
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Mar 2024 19:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8168C1F21525
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Mar 2024 18:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D069858229;
	Mon, 11 Mar 2024 18:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yl3wj+Gr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aQ4JHdPE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yl3wj+Gr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aQ4JHdPE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5877E58217
	for <linux-ext4@vger.kernel.org>; Mon, 11 Mar 2024 18:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182796; cv=none; b=g3rEeYqrRlKFUxLysAGKTG5NRElf1nq9yl8BZuDsf9SEexOhuI2FADTanfa4kwPes0ZnC2ygXWlRCXVec5uTquQtoultzrx3+1dv728vwCCihk/QfPfGz3nu6G8dy7L35vWA7CjolQhqlL08c4Dmjw8d8oIz13//DRTbzf0DqZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182796; c=relaxed/simple;
	bh=iIJu6VClFmpMaYfjO1EcyezbYRVbfl3WJA5BI2WOS6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ex/IZIfNQHzAyq7FUyHDiDwwEfUA00eomDhpYslbShC/zhc6hiBJq2baAsYmgo9kbNVcQHoNOPcZzzZtMUxORBcszTc0IDeBejShd4m8AftimDj2jd9F2if8kvN7Q6IA1GDSeu1na2jesPUmRMgM7aI6Zx8aRyHedBKLZ8VGyAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yl3wj+Gr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aQ4JHdPE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yl3wj+Gr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aQ4JHdPE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4087B5C9EF;
	Mon, 11 Mar 2024 18:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710182791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WiQxqgWogAFp/GY7O8rn4PPuWeX7LuuENSQMFjC0nkQ=;
	b=yl3wj+GrLC4h2LpaKbZU/rxgYgUTxVuFdYym4Uj+TLpdGjhSDmL1rkHdKWZ8/tFRmnAIm2
	5sc4dIdf4atU4fJ1x9ZXu2U4W7vva1bAnZjoimE+5H91fSDwTyo/mACOm/lvirg/rTi7pS
	MYTyR1nXVOdT6K6qlS6ruvoBnqR8AuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710182791;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WiQxqgWogAFp/GY7O8rn4PPuWeX7LuuENSQMFjC0nkQ=;
	b=aQ4JHdPErTpxZ53wEPtYAuGCZYR2PFSqJUiS6W9AZLrsobW3tgZ3ce99z6r8zgXcNerNO8
	h8FPU7evtY/vteBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710182791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WiQxqgWogAFp/GY7O8rn4PPuWeX7LuuENSQMFjC0nkQ=;
	b=yl3wj+GrLC4h2LpaKbZU/rxgYgUTxVuFdYym4Uj+TLpdGjhSDmL1rkHdKWZ8/tFRmnAIm2
	5sc4dIdf4atU4fJ1x9ZXu2U4W7vva1bAnZjoimE+5H91fSDwTyo/mACOm/lvirg/rTi7pS
	MYTyR1nXVOdT6K6qlS6ruvoBnqR8AuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710182791;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WiQxqgWogAFp/GY7O8rn4PPuWeX7LuuENSQMFjC0nkQ=;
	b=aQ4JHdPErTpxZ53wEPtYAuGCZYR2PFSqJUiS6W9AZLrsobW3tgZ3ce99z6r8zgXcNerNO8
	h8FPU7evtY/vteBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 364A113695;
	Mon, 11 Mar 2024 18:46:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iNU+DYdR72XOQQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 11 Mar 2024 18:46:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C3ED2A080A; Mon, 11 Mar 2024 19:46:30 +0100 (CET)
Date: Mon, 11 Mar 2024 19:46:30 +0100
From: Jan Kara <jack@suse.cz>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 2/2] ext4: Remove PAGE_MASK dependency on
 mpage_submit_folio
Message-ID: <20240311184630.lhlwntksaoskcco6@quack3>
References: <cff4953b5c9306aba71e944ab176a5d396b9a1b7.1709182250.git.ritesh.list@gmail.com>
 <d6eadb090334ea49ceef4e643b371fabfcea328f.1709182251.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6eadb090334ea49ceef4e643b371fabfcea328f.1709182251.git.ritesh.list@gmail.com>
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yl3wj+Gr;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=aQ4JHdPE
X-Spamd-Result: default: False [-0.78 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TO_DN_SOME(0.00)[];
	 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.97)[86.87%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
X-Spam-Score: -0.78
X-Rspamd-Queue-Id: 4087B5C9EF
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Thu 29-02-24 11:40:14, Ritesh Harjani (IBM) wrote:
> This patch simply removes the PAGE_MASK dependency since
> mpage_submit_folio() is already converted to work with folio.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index bab9223d94ac..e8b0773e5d2d 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1865,7 +1865,7 @@ static int mpage_submit_folio(struct mpage_da_data *mpd, struct folio *folio)
>  	len = folio_size(folio);
>  	if (folio_pos(folio) + len > size &&
>  	    !ext4_verity_in_progress(mpd->inode))
> -		len = size & ~PAGE_MASK;
> +		len = size & (len - 1);
>  	err = ext4_bio_write_folio(&mpd->io_submit, folio, len);
>  	if (!err)
>  		mpd->wbc->nr_to_write--;
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

