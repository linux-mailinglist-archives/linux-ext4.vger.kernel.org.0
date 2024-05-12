Return-Path: <linux-ext4+bounces-2484-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6554D8C4243
	for <lists+linux-ext4@lfdr.de>; Mon, 13 May 2024 15:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885021C20F65
	for <lists+linux-ext4@lfdr.de>; Mon, 13 May 2024 13:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E36154451;
	Mon, 13 May 2024 13:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xepq+Oe4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+czjhXGa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xepq+Oe4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+czjhXGa"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA10015356A;
	Mon, 13 May 2024 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607699; cv=none; b=tCoxvSUTdFuJtYecUn5lidIx+8POSYOJJ0qiUq4upeBjmclo1nU/NupbeghR5AP3Nq81oZYri9+WHb+KbrBTwWS0rVAy49Wdn2z/lbHMMtzrBZEyqwU8UGV4gCfVfDAbt2J5AWNTtDEBjwWRgWidXLtIp6W+GbDY8uL4dYFRwLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607699; c=relaxed/simple;
	bh=ROg68CVd2YK9UMZjbcNiB4qATHW00j5eJD3yyf8e5As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShnifTOnmw3g6Hm/I2coMJxotI386vjUgntLt3FnqvhM+2bCD7h3qRTtIV1yTlvearOrz5W3twb9QjpbCtKGGW07cD5wqmdk8Bcw8pKaIdIhljcDeEOWHMFIK4Y7eHrg8SgD93jmifn7Toj1FwsIlVeMVB6He231L3D2T+sX0FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xepq+Oe4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+czjhXGa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xepq+Oe4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+czjhXGa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0736A5C0D4;
	Mon, 13 May 2024 13:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715607696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XjjqaQHHXeEe79ZkhmY/RuA1LRWJALAZFLWjOLQu808=;
	b=xepq+Oe4+lBr46xXJmoWWH4bVt6JLwok/dxNV91Eb4pTMR+1pQv8soJMx78Q3Ern/9b1PD
	tNgch3gELhEK6Ph1qEjk7sdSxHzww4p1PC1H5RXk7nac+ZikJayB5bQ3GGX4P3ToT1unqG
	4qxyZK8/D7KBpsxAIbBqtOu71TFUJis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715607696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XjjqaQHHXeEe79ZkhmY/RuA1LRWJALAZFLWjOLQu808=;
	b=+czjhXGaI5FlJnvmZc+6wXnfacP0rLzzw+s4MY/gLxpt6x6WR/JYnLktjt0MNvrjqDJ71O
	Omw19fwQkNWKNmAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715607696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XjjqaQHHXeEe79ZkhmY/RuA1LRWJALAZFLWjOLQu808=;
	b=xepq+Oe4+lBr46xXJmoWWH4bVt6JLwok/dxNV91Eb4pTMR+1pQv8soJMx78Q3Ern/9b1PD
	tNgch3gELhEK6Ph1qEjk7sdSxHzww4p1PC1H5RXk7nac+ZikJayB5bQ3GGX4P3ToT1unqG
	4qxyZK8/D7KBpsxAIbBqtOu71TFUJis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715607696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XjjqaQHHXeEe79ZkhmY/RuA1LRWJALAZFLWjOLQu808=;
	b=+czjhXGaI5FlJnvmZc+6wXnfacP0rLzzw+s4MY/gLxpt6x6WR/JYnLktjt0MNvrjqDJ71O
	Omw19fwQkNWKNmAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB5EB13A5F;
	Mon, 13 May 2024 13:41:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bkahMY8YQmZHDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 May 2024 13:41:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 430E1A08DE; Sun, 12 May 2024 13:13:58 +0200 (CEST)
Date: Sun, 12 May 2024 13:13:58 +0200
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] jbd2: remove unneeded kmap to do escape in
 jbd2_journal_write_metadata_buffer
Message-ID: <20240512111358.godfwdmyy7ncrfya@quack3>
References: <20240506141801.1165315-1-shikemeng@huaweicloud.com>
 <20240506141801.1165315-6-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506141801.1165315-6-shikemeng@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.com:email]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On Mon 06-05-24 22:17:57, Kemeng Shi wrote:
> The data to do escape could be accessed directly from b_frozen_data,
> just remove unneeded kmap.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Ah, good point. But this deserves a comment at that site that jbd2_alloc()
always provides an address from the direct kernel mapping. Otherwise feel
free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 77fcdc76fdfd..87f558bd2e8a 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -423,11 +423,8 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  	 * Did we need to do an escaping?  Now we've done all the
>  	 * copying, we can finally do so.
>  	 */
> -	if (do_escape) {
> -		mapped_data = kmap_local_folio(new_folio, new_offset);
> -		*((unsigned int *)mapped_data) = 0;
> -		kunmap_local(mapped_data);
> -	}
> +	if (do_escape)
> +		*((unsigned int *)jh_in->b_frozen_data) = 0;
>  
>  	folio_set_bh(new_bh, new_folio, new_offset);
>  	new_bh->b_size = bh_in->b_size;
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

