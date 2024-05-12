Return-Path: <linux-ext4+bounces-2486-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BA18C4248
	for <lists+linux-ext4@lfdr.de>; Mon, 13 May 2024 15:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 714CAB2456B
	for <lists+linux-ext4@lfdr.de>; Mon, 13 May 2024 13:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCCD1552F8;
	Mon, 13 May 2024 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yscqq52g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="frk7FtBJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yscqq52g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="frk7FtBJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CEB153BEB;
	Mon, 13 May 2024 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607701; cv=none; b=QZ+fQpJVE9idrSNuGVLbOCAWJ522loaLtUKKJMiPA5YWr94G/bi3uKUoQRJ0kO9lduDi53Ud2LUMU6UOkaCqS1lZ8m8ag0a58o3msLQeN1/KjPxJNSQG61JcjGDZ0ReM++HHe8FljolCMXCWSNzTX8Dc5L4xOksXxoKIY7TUZ8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607701; c=relaxed/simple;
	bh=aw5WPM3aFlIOaWw9AJg/YePoEq4atoc4Eb3nJMZVA60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cL9l0Uo+hvc1jwgdZMqdULulDOZkJdwU7Ye9f21wAXyORNp4LXyfK6DJ2Lb0+cgtCaEDNd9Qf0WVs77lJuFW47l6AHzku958bP0nXsSK+IlU+av+f8SphXEJvJ5YDAaJikPYWEpnip4HXgOkPCG0dEOGO6f/s4HYXpZalH8Gvc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yscqq52g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=frk7FtBJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yscqq52g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=frk7FtBJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 18FDA5C0D7;
	Mon, 13 May 2024 13:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715607696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Y/Lro9PlXtrN0PhkABEJ223H0GYtzxoCpXd9VJXsAY=;
	b=Yscqq52gfwHRqKs88uZkI5MjSq7JmFyrHsS8N7pexgvPd3zJiMvfcxYbk1vwfKLpzdBrHt
	8KFuSvX2jito610xOvSF5Ia81dvSwC32B9j1FDbEs9j+Duborjb+UdniouKfJy/Ax8VgX0
	9QAJ0o51CugQBghll1E18XoByxSNQUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715607696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Y/Lro9PlXtrN0PhkABEJ223H0GYtzxoCpXd9VJXsAY=;
	b=frk7FtBJsehkeLH/kUPfRd11F+ybW9XP8UWN/5taKbfA+Rv88ftfDnWAIM6yPbTXSBzT7Q
	dJzCZGZ3r9BDAKAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715607696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Y/Lro9PlXtrN0PhkABEJ223H0GYtzxoCpXd9VJXsAY=;
	b=Yscqq52gfwHRqKs88uZkI5MjSq7JmFyrHsS8N7pexgvPd3zJiMvfcxYbk1vwfKLpzdBrHt
	8KFuSvX2jito610xOvSF5Ia81dvSwC32B9j1FDbEs9j+Duborjb+UdniouKfJy/Ax8VgX0
	9QAJ0o51CugQBghll1E18XoByxSNQUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715607696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Y/Lro9PlXtrN0PhkABEJ223H0GYtzxoCpXd9VJXsAY=;
	b=frk7FtBJsehkeLH/kUPfRd11F+ybW9XP8UWN/5taKbfA+Rv88ftfDnWAIM6yPbTXSBzT7Q
	dJzCZGZ3r9BDAKAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD4B313A6A;
	Mon, 13 May 2024 13:41:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EtPwNY8YQmZQDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 May 2024 13:41:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C34C5A08E1; Sun, 12 May 2024 13:14:53 +0200 (CEST)
Date: Sun, 12 May 2024 13:14:53 +0200
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] jbd2: use bh_in instead of jh2bh(jh_in) to simplify
 code
Message-ID: <20240512111453.gwuw34voa57uccct@quack3>
References: <20240506141801.1165315-1-shikemeng@huaweicloud.com>
 <20240506141801.1165315-7-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506141801.1165315-7-shikemeng@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DATE_IN_PAST(1.00)[26];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On Mon 06-05-24 22:17:58, Kemeng Shi wrote:
> We save jh2bh(jh_in) to bh_in, so use bh_in directly instead of
> jh2bh(jh_in) to simplify the code.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 87f558bd2e8a..01e33b643e4d 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -363,8 +363,8 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  		new_folio = virt_to_folio(jh_in->b_frozen_data);
>  		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
>  	} else {
> -		new_folio = jh2bh(jh_in)->b_folio;
> -		new_offset = offset_in_folio(new_folio, jh2bh(jh_in)->b_data);
> +		new_folio = bh_in->b_folio;
> +		new_offset = offset_in_folio(new_folio, bh_in->b_data);
>  	}
>  
>  	mapped_data = kmap_local_folio(new_folio, new_offset);
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

