Return-Path: <linux-ext4+bounces-5804-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44C89F902B
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 11:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5819B165042
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 10:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D511A1C1F07;
	Fri, 20 Dec 2024 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ChsGnPcz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zm6+57aZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ChsGnPcz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zm6+57aZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B8D1BFDEC;
	Fri, 20 Dec 2024 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734690384; cv=none; b=pjxriImXdDbGOEzRitgwJcNoTrdPM5sor1o2witNl82JpDO2ivYrwYyVudJt8mxMchtqnHTvIJCcgYu27PVqvoZkpXY5ivNYLx2Oq/4sElTi6xPg+G+w4B1fScyft/B8rfDrjsrUMYSIHuXfZT5x/2MMyWDog7wV50rW1zxbZsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734690384; c=relaxed/simple;
	bh=KGehlqDyx6gOkjp1AGviCIojs/c42VAXD2B4PcsHogU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FN6EVVHniSnRqX18SGWUXLc6pyGon5twN0wGD/0oZaC47UcLhcWkz0t2rOmcnbCGxDKGT2X0NpGQM2mhb+8bO3CEQEK6+IAJDXFGHTfiDTCTx83HGwPZBwQIiSjA4wQ74quoBXe2wgt+qgaABlf/0Akuhaj8YoPHTAIbU8UuxOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ChsGnPcz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zm6+57aZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ChsGnPcz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zm6+57aZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A16FD1F396;
	Fri, 20 Dec 2024 10:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734690380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5++1W5FNokdRogTJ39MicXDgFNOQAvZk43rm9Mg1Tko=;
	b=ChsGnPczbzMc+Pu1avoNTpUAQujYuKgmOqSbW7O+2Z5HJ6FBO4S07/+mnDJxfbFM5jc0JF
	ex8C4l5r2DL0PngXjYnkVKJm0wHbFtAS42+AyZIK6jGeQU4CQlVQGmEEJ/RUc6X6x6/hG0
	pAu8IISNKSA9CloZYJ4XQ9X+5al9ueo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734690380;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5++1W5FNokdRogTJ39MicXDgFNOQAvZk43rm9Mg1Tko=;
	b=Zm6+57aZbs321n2MwrSCcc3ofG1VVeJPtPBwbhvODdMhPvQoZXukgVI7ELOMedI7oJ0mTZ
	bxx/aVWzZ7ltF/AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734690380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5++1W5FNokdRogTJ39MicXDgFNOQAvZk43rm9Mg1Tko=;
	b=ChsGnPczbzMc+Pu1avoNTpUAQujYuKgmOqSbW7O+2Z5HJ6FBO4S07/+mnDJxfbFM5jc0JF
	ex8C4l5r2DL0PngXjYnkVKJm0wHbFtAS42+AyZIK6jGeQU4CQlVQGmEEJ/RUc6X6x6/hG0
	pAu8IISNKSA9CloZYJ4XQ9X+5al9ueo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734690380;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5++1W5FNokdRogTJ39MicXDgFNOQAvZk43rm9Mg1Tko=;
	b=Zm6+57aZbs321n2MwrSCcc3ofG1VVeJPtPBwbhvODdMhPvQoZXukgVI7ELOMedI7oJ0mTZ
	bxx/aVWzZ7ltF/AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9763B13AE6;
	Fri, 20 Dec 2024 10:26:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NN/wJExGZWfNBgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 20 Dec 2024 10:26:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 52AB5A08CF; Fri, 20 Dec 2024 11:26:16 +0100 (CET)
Date: Fri, 20 Dec 2024 11:26:16 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 1/5] ext4: replace opencoded ext4_end_io_end() in
 ext4_put_io_end()
Message-ID: <20241220102616.atkrgagnew5mf7vh@quack3>
References: <20241220060757.1781418-1-libaokun@huaweicloud.com>
 <20241220060757.1781418-2-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241220060757.1781418-2-libaokun@huaweicloud.com>
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 20-12-24 14:07:53, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> This reduces duplicate code and ensures that a “potential data loss”
> warning is available if the unwritten conversion fails.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/page-io.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> index 69b8a7221a2b..f53b018ea259 100644
> --- a/fs/ext4/page-io.c
> +++ b/fs/ext4/page-io.c
> @@ -299,18 +299,13 @@ void ext4_put_io_end_defer(ext4_io_end_t *io_end)
>  
>  int ext4_put_io_end(ext4_io_end_t *io_end)
>  {
> -	int err = 0;
> -
>  	if (refcount_dec_and_test(&io_end->count)) {
> -		if (io_end->flag & EXT4_IO_END_UNWRITTEN) {
> -			err = ext4_convert_unwritten_io_end_vec(io_end->handle,
> -								io_end);
> -			io_end->handle = NULL;
> -			ext4_clear_io_unwritten_flag(io_end);
> -		}
> +		if (io_end->flag & EXT4_IO_END_UNWRITTEN)
> +			return ext4_end_io_end(io_end);
> +
>  		ext4_release_io_end(io_end);
>  	}
> -	return err;
> +	return 0;
>  }
>  
>  ext4_io_end_t *ext4_get_io_end(ext4_io_end_t *io_end)
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

