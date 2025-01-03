Return-Path: <linux-ext4+bounces-5880-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD2AA00AB2
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jan 2025 15:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B88216400F
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jan 2025 14:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DF81FAC34;
	Fri,  3 Jan 2025 14:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EjQrnd5M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7ySt6Zh1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Cbw0/g/s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1Vu1ZaVT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D021FA8CF;
	Fri,  3 Jan 2025 14:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735915150; cv=none; b=FeIWvoTTZAwJ0yj/ni5COiEam1kZzpeqfd2XXd6W6qMkmGfCF/3ocq69WZYmrn5wcb8+R/E9HHg7rv6/h+ugGxZG37oags3ATI8rReZUMZ5xOxxWPZttQysfnPUlBGfu253Zk7Btf8w05DmBeCMFYKm5wCTOj6AFJOZLqb77Uv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735915150; c=relaxed/simple;
	bh=HqPVzoVBiJQjxbXHkHQQQRP/+n8e5YyHxp0SAsH7vns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFUlpgagJFjp6MBsl6KCejnWNynGqQe6KYpVFMZww/JFXWpZmhnIyCcCL04I9ucfHwZFyDVPm+eX2DLdob2+59ZGC0r1Sc+jXhh882cO5e8TrogD34yKw3Y5aBUaSfOJCH4FoqpBH03ejj/BDct9RP5xEA8BDBmHtLse/rxQrf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EjQrnd5M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7ySt6Zh1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Cbw0/g/s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1Vu1ZaVT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4F2C41F38E;
	Fri,  3 Jan 2025 14:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735915144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mL5i2zgJC6OrqYCG3uqpKh1HPTQbURS7kNRJFy+tOdM=;
	b=EjQrnd5MPSJMZaiMLOtlR+98C3zVMONj5s3X/28j3We+aJ3SegKIY4/tRaNvy6ucY6eBAG
	D7r+yGdHBPUBn3iAYsDZDP8SfARRZ5UPn1pe820QirZK2XUQwp8Sr1yDyc8KC+cOc/Nb56
	57CoaH+N0cFOvndP4gbyd3ZEtWJNPew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735915144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mL5i2zgJC6OrqYCG3uqpKh1HPTQbURS7kNRJFy+tOdM=;
	b=7ySt6Zh1za3OzLMPohrK7/Ao+dMrXZDc59VqMc5LbCGqny5fs1nIuiWl+ZtoBQWTsBiT9o
	pZIlWoRz5fONzQAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735915143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mL5i2zgJC6OrqYCG3uqpKh1HPTQbURS7kNRJFy+tOdM=;
	b=Cbw0/g/sNGnmiiEIYHwac1WbObpeftvahhUqtvwQ8xS0ZvE/J4hNXkoiB/fC6TPx2AJ9eZ
	nC0wnXqZ9yluSsoydiWJTYAnOSGlK8oIyANxKHR3WIX67ngszErSXUeuBQSQI63vkYDAA0
	QHvF0sBQfPf1KhqurhDe5cjUcN6XOyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735915143;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mL5i2zgJC6OrqYCG3uqpKh1HPTQbURS7kNRJFy+tOdM=;
	b=1Vu1ZaVT13W8f/7GpG2IRQm7zUj+TDhuODsJEXZosPaqkgUpMygJIsbR+HgABNw+L/eddl
	fLpFRTweRGebVUCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 35B3D134E4;
	Fri,  3 Jan 2025 14:39:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dAnQDIf2d2exXwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 03 Jan 2025 14:39:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D8955A0844; Fri,  3 Jan 2025 15:39:00 +0100 (CET)
Date: Fri, 3 Jan 2025 15:39:00 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] jbd2: remove unused return value of do_readahead
Message-ID: <nheimrse4p6rdmvtrx7hxuvvn4th6tfjn2ga36vaht3xypfyce@r4dwfe2uahbg>
References: <20241224202707.1530558-1-shikemeng@huaweicloud.com>
 <20241224202707.1530558-4-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241224202707.1530558-4-shikemeng@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email,huaweicloud.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Wed 25-12-24 04:27:04, Kemeng Shi wrote:
> Remove unused return value of do_readahead.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Yeah, we are unlikely to act on errors from readahead. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/recovery.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index 9192be7c19d8..a671f8ee7dd2 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -65,9 +65,8 @@ static void journal_brelse_array(struct buffer_head *b[], int n)
>   */
>  
>  #define MAXBUF 8
> -static int do_readahead(journal_t *journal, unsigned int start)
> +static void do_readahead(journal_t *journal, unsigned int start)
>  {
> -	int err;
>  	unsigned int max, nbufs, next;
>  	unsigned long long blocknr;
>  	struct buffer_head *bh;
> @@ -85,7 +84,7 @@ static int do_readahead(journal_t *journal, unsigned int start)
>  	nbufs = 0;
>  
>  	for (next = start; next < max; next++) {
> -		err = jbd2_journal_bmap(journal, next, &blocknr);
> +		int err = jbd2_journal_bmap(journal, next, &blocknr);
>  
>  		if (err) {
>  			printk(KERN_ERR "JBD2: bad block at offset %u\n",
> @@ -94,10 +93,8 @@ static int do_readahead(journal_t *journal, unsigned int start)
>  		}
>  
>  		bh = __getblk(journal->j_dev, blocknr, journal->j_blocksize);
> -		if (!bh) {
> -			err = -ENOMEM;
> +		if (!bh)
>  			goto failed;
> -		}
>  
>  		if (!buffer_uptodate(bh) && !buffer_locked(bh)) {
>  			bufs[nbufs++] = bh;
> @@ -112,12 +109,10 @@ static int do_readahead(journal_t *journal, unsigned int start)
>  
>  	if (nbufs)
>  		bh_readahead_batch(nbufs, bufs, 0);
> -	err = 0;
>  
>  failed:
>  	if (nbufs)
>  		journal_brelse_array(bufs, nbufs);
> -	return err;
>  }
>  
>  #endif /* __KERNEL__ */
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

