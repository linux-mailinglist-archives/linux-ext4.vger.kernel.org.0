Return-Path: <linux-ext4+bounces-5882-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA91A00AC7
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jan 2025 15:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 049CE1884C6E
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jan 2025 14:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0FA1FA8D7;
	Fri,  3 Jan 2025 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qnBLCV1M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/aaGHRNW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qnBLCV1M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/aaGHRNW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A22C1D61AC;
	Fri,  3 Jan 2025 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735915489; cv=none; b=VNqs68U37vYCudOet3bzDmqw3TfzdNWGCno7ih+jGw4jgZF2xGW2CybpCSxEkbd3ZJFINc/zMmupBAuA8LL5zdZ+qwzc6ciWT38F4kycPgKMjE2fa9uoqa0/VtUAd1LckzRQJSkjQW5986vXfCPtsL3zJK+za+NIFttLLd4zkgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735915489; c=relaxed/simple;
	bh=R/kKI+OAn1RwL+7dPJaf341cjgiRHlD0v4oS0JjpcrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6Ot6YCfWkzY86OuDYd47rr8f6B3xeWYDdVwv2Oi1W1KZcVljosbeRpp1tH87Z5vPSqVFW8B+UOnaBvmb75Ftf8nNajwzteHG04sE/B0VOq9e0sV28ENFnYhL1WpRDFxyy6UtPn4Y0ikOJ/Ra2puwZRSn1RnS3vlrgfq5yd0fIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qnBLCV1M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/aaGHRNW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qnBLCV1M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/aaGHRNW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9AEED21114;
	Fri,  3 Jan 2025 14:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735915485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=msXCVFpE3gRgE4GRKhaleQE/3PzmKgHmoG6msxBvT4I=;
	b=qnBLCV1M2xezclEPIH8I/tI25Ypgjyt4RFQ1vJYxtAXcDM+yOJm88pp0r/6ekJb7UzOb6x
	Psbi16JiyY/RK00dPyPdUFciv5EaGHHh29bjV7BLajJB7+U0bF6NxJnQWlHCCssCn208VV
	kWvyO3BN/gHKsPwlhGsuHc8pk7f6AvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735915485;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=msXCVFpE3gRgE4GRKhaleQE/3PzmKgHmoG6msxBvT4I=;
	b=/aaGHRNWp5cLovGw7f0DhQu6K7LydIvgItDOY65DA+JTbgr32kj80nGhyvYHTfa5Y+vQ2R
	/fCMDdfdDcw+btDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735915485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=msXCVFpE3gRgE4GRKhaleQE/3PzmKgHmoG6msxBvT4I=;
	b=qnBLCV1M2xezclEPIH8I/tI25Ypgjyt4RFQ1vJYxtAXcDM+yOJm88pp0r/6ekJb7UzOb6x
	Psbi16JiyY/RK00dPyPdUFciv5EaGHHh29bjV7BLajJB7+U0bF6NxJnQWlHCCssCn208VV
	kWvyO3BN/gHKsPwlhGsuHc8pk7f6AvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735915485;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=msXCVFpE3gRgE4GRKhaleQE/3PzmKgHmoG6msxBvT4I=;
	b=/aaGHRNWp5cLovGw7f0DhQu6K7LydIvgItDOY65DA+JTbgr32kj80nGhyvYHTfa5Y+vQ2R
	/fCMDdfdDcw+btDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F64E134E4;
	Fri,  3 Jan 2025 14:44:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hd26It33d2cWYQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 03 Jan 2025 14:44:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3D859A0844; Fri,  3 Jan 2025 15:44:41 +0100 (CET)
Date: Fri, 3 Jan 2025 15:44:41 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] jbd2: Correct stale comment of release_buffer_page
Message-ID: <nascjndmcy3dhgb53p3i4khffljxtsigxvkw74dw4x27twre5p@n5bydi6oiahg>
References: <20241224202707.1530558-1-shikemeng@huaweicloud.com>
 <20241224202707.1530558-7-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241224202707.1530558-7-shikemeng@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Wed 25-12-24 04:27:07, Kemeng Shi wrote:
> Update stale lock info in comment of release_buffer_page.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/commit.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 9153ff3a08e7..d812d15f295e 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -57,8 +57,8 @@ static void journal_end_buffer_io_sync(struct buffer_head *bh, int uptodate)
>   * So here, we have a buffer which has just come off the forget list.  Look to
>   * see if we can strip all buffers from the backing page.
>   *
> - * Called under lock_journal(), and possibly under journal_datalist_lock.  The
> - * caller provided us with a ref against the buffer, and we drop that here.
> + * Called under j_list_lock. The caller provided us with a ref against the
> + * buffer, and we drop that here.
>   */
>  static void release_buffer_page(struct buffer_head *bh)
>  {
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

