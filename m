Return-Path: <linux-ext4+bounces-2477-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDADF8C422F
	for <lists+linux-ext4@lfdr.de>; Mon, 13 May 2024 15:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13899B225BE
	for <lists+linux-ext4@lfdr.de>; Mon, 13 May 2024 13:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF9A153589;
	Mon, 13 May 2024 13:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0QC3sOm4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S42fgk9+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0QC3sOm4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S42fgk9+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6A6153500;
	Mon, 13 May 2024 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607697; cv=none; b=SaiokIV1blbYOU+ug78IEqHG16IqT00xVc571mhnzWl8F3hCcEIV8LF+BrIBEDJbnHx0jdWi4+RraPh8KskvecJQ/M6dE5mCFZVsSCEodK0XMNMoBtzDrm3ZvInNz9nWuIr92rDu1UpY5uYdCDfjYJMVQ7Rzeq3zxss/77wJGgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607697; c=relaxed/simple;
	bh=trheXddaiEdfLrELnD3wTUNe0KrBMDYC+vggIcIMqB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=By2nhmMdKp78e/7ffjmAQsb+UNyfR5crOmTiHuj6ZkaOTdbSGkM/Tr0QiNQszf/w0irhiAjOwBXROW3NP2c+y3bCfveYZ6x8ueFLJfKp+HjKRhKxoD3u0mKK5wdm8HD+nnxByjNPduMGVnkm9RtNwHefrCBU8X/U5fvrlEMettI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0QC3sOm4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S42fgk9+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0QC3sOm4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S42fgk9+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 47CDD34A04;
	Mon, 13 May 2024 13:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715607694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kd4DRq9qVstTu8IM1frFe8wCSYGv4REY+hKqbmhP4w4=;
	b=0QC3sOm4rPnX9/xHC5xPWMpa7h9PVI2tC2nTEbzHwLbjbn1Q+IDy9jBm4/ph7H7ihbI2T8
	WFLNP4usSduDAoGHS82NNF7KGOJ+myDAXs64VgKHdWSssg//fWqythsK0y7cLwmzxDOFnd
	Qk1043UChA7jYSmzwLWqKV9/hY7mF8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715607694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kd4DRq9qVstTu8IM1frFe8wCSYGv4REY+hKqbmhP4w4=;
	b=S42fgk9+CR7qj0VQ6zjDgKNlLAs1BEoJjxZNlEhVfao6DeD9mqN4zvTYx140r/dqaIsXQ3
	0pa6bL0yMD9pd2BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0QC3sOm4;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=S42fgk9+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715607694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kd4DRq9qVstTu8IM1frFe8wCSYGv4REY+hKqbmhP4w4=;
	b=0QC3sOm4rPnX9/xHC5xPWMpa7h9PVI2tC2nTEbzHwLbjbn1Q+IDy9jBm4/ph7H7ihbI2T8
	WFLNP4usSduDAoGHS82NNF7KGOJ+myDAXs64VgKHdWSssg//fWqythsK0y7cLwmzxDOFnd
	Qk1043UChA7jYSmzwLWqKV9/hY7mF8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715607694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kd4DRq9qVstTu8IM1frFe8wCSYGv4REY+hKqbmhP4w4=;
	b=S42fgk9+CR7qj0VQ6zjDgKNlLAs1BEoJjxZNlEhVfao6DeD9mqN4zvTYx140r/dqaIsXQ3
	0pa6bL0yMD9pd2BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D15A13A5D;
	Mon, 13 May 2024 13:41:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oa0nA44YQmYcDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 May 2024 13:41:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 09ABFA08BF; Sun, 12 May 2024 12:09:31 +0200 (CEST)
Date: Sun, 12 May 2024 12:09:30 +0200
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] jbd2: avoid memleak in
 jbd2_journal_write_metadata_buffer
Message-ID: <20240512100930.7p5pylbazn5etw7k@quack3>
References: <20240506141801.1165315-1-shikemeng@huaweicloud.com>
 <20240506141801.1165315-2-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506141801.1165315-2-shikemeng@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 47CDD34A04
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DATE_IN_PAST(1.00)[27];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]

On Mon 06-05-24 22:17:53, Kemeng Shi wrote:
> The new_bh is from alloc_buffer_head, we should call free_buffer_head to
> free it in error case.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index b6c114c11b97..207b24e12ce9 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -399,6 +399,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  		tmp = jbd2_alloc(bh_in->b_size, GFP_NOFS);
>  		if (!tmp) {
>  			brelse(new_bh);
> +			free_buffer_head(new_bh);
>  			return -ENOMEM;
>  		}
>  		spin_lock(&jh_in->b_state_lock);
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

