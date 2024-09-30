Return-Path: <linux-ext4+bounces-4389-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7638E989F71
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2024 12:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDCA7B20FDB
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2024 10:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094CB180A80;
	Mon, 30 Sep 2024 10:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O9faiVoK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zjmQFZWI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O9faiVoK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zjmQFZWI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E344E189F5C
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 10:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727692363; cv=none; b=gU4d2zoMbtkZ8pyi1FMYyvIueKWTPpE3xcKbAtUZs7BZKAZ02QfW+W+vRjA7sh0y/dKpmRUaixIs/iDjG80mzvYPh0yGx30oaDtr7Pwdn+emWWVdV4X4w7Og2sRj/+sJJzcYpYl419R96cP3nupximPhrBoTP/XyA4J+oIrTGQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727692363; c=relaxed/simple;
	bh=ZjWxJR7sYgJ4y9Dgk+En5fYsjBORSD2nZsPChJZxzQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSAZrooSrNjT6TZNF1KUH3cLIHCN+arsF48dkRR/vAJWNems2C7F/QE1632fJcKbza0EYQZCHgAqxrHNnzS4xVowsdBCX3VTO6uBq2JLqv9D8aIq56c4Cbz8PITIOiCZZVy9DVtHOnI5esgB/zLswFWpPODTjzb/FESuecN2gNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O9faiVoK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zjmQFZWI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O9faiVoK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zjmQFZWI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3624321A3C;
	Mon, 30 Sep 2024 10:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727692360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wUVHSaZ7Lo6UZcPJkKHoR4dhKlIfr8gT4USauuxyNJU=;
	b=O9faiVoKIeIZzFMCQO/flHfKdLeFjPzl3DSPizt+T030jO9IPKAQOCFhe4XM/oMEoUDxOr
	61fYjgQi34GmWSv4HLn9clleLbvpFGXbvrK57xK1GpF3SHsxfdsaJPGufX7y6qKyu3P0Ky
	5wqJ2vXe+hJe35uQokCooHezsp55Q7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727692360;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wUVHSaZ7Lo6UZcPJkKHoR4dhKlIfr8gT4USauuxyNJU=;
	b=zjmQFZWI5eoG2xTjKPRbA2S/VWnMYvt2kBm064b/ToexvFTodXptsYuHUcGfZxkWvQzh45
	p0ebnZUdPS9gdTBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727692360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wUVHSaZ7Lo6UZcPJkKHoR4dhKlIfr8gT4USauuxyNJU=;
	b=O9faiVoKIeIZzFMCQO/flHfKdLeFjPzl3DSPizt+T030jO9IPKAQOCFhe4XM/oMEoUDxOr
	61fYjgQi34GmWSv4HLn9clleLbvpFGXbvrK57xK1GpF3SHsxfdsaJPGufX7y6qKyu3P0Ky
	5wqJ2vXe+hJe35uQokCooHezsp55Q7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727692360;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wUVHSaZ7Lo6UZcPJkKHoR4dhKlIfr8gT4USauuxyNJU=;
	b=zjmQFZWI5eoG2xTjKPRbA2S/VWnMYvt2kBm064b/ToexvFTodXptsYuHUcGfZxkWvQzh45
	p0ebnZUdPS9gdTBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C04813A8B;
	Mon, 30 Sep 2024 10:32:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bcq/Ckh++mYNQwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 30 Sep 2024 10:32:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D2F84A0845; Mon, 30 Sep 2024 12:32:39 +0200 (CEST)
Date: Mon, 30 Sep 2024 12:32:39 +0200
From: Jan Kara <jack@suse.cz>
To: Ye Bin <yebin@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	jack@suse.cz, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH v2 6/6] jbd2: remove the 'success' parameter from the
 jbd2_do_replay() function
Message-ID: <20240930103239.x46nb4txtlofcmfc@quack3>
References: <20240930005942.626942-1-yebin@huaweicloud.com>
 <20240930005942.626942-7-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930005942.626942-7-yebin@huaweicloud.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 30-09-24 08:59:42, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Keep 'success' internally to track if any error happened and then
> return it at the end in do_one_pass(). If jbd2_do_replay() return
> -ENOMEM then stop replay journal.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Nice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/recovery.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index 4f1e9ca34503..9192be7c19d8 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -489,12 +489,11 @@ static __always_inline int jbd2_do_replay(journal_t *journal,
>  					  struct recovery_info *info,
>  					  struct buffer_head *bh,
>  					  unsigned long *next_log_block,
> -					  unsigned int next_commit_ID,
> -					  int *success)
> +					  unsigned int next_commit_ID)
>  {
>  	char *tagp;
>  	int flags;
> -	int err;
> +	int ret = 0;
>  	int tag_bytes = journal_tag_bytes(journal);
>  	int descr_csum_size = 0;
>  	unsigned long io_block;
> @@ -508,6 +507,7 @@ static __always_inline int jbd2_do_replay(journal_t *journal,
>  	tagp = &bh->b_data[sizeof(journal_header_t)];
>  	while (tagp - bh->b_data + tag_bytes <=
>  	       journal->j_blocksize - descr_csum_size) {
> +		int err;
>  
>  		memcpy(&tag, tagp, sizeof(tag));
>  		flags = be16_to_cpu(tag.t_flags);
> @@ -517,7 +517,7 @@ static __always_inline int jbd2_do_replay(journal_t *journal,
>  		err = jread(&obh, journal, io_block);
>  		if (err) {
>  			/* Recover what we can, but report failure at the end. */
> -			*success = err;
> +			ret = err;
>  			pr_err("JBD2: IO error %d recovering block %lu in log\n",
>  			      err, io_block);
>  		} else {
> @@ -539,7 +539,7 @@ static __always_inline int jbd2_do_replay(journal_t *journal,
>  					(journal_block_tag3_t *)tagp,
>  					obh->b_data, next_commit_ID)) {
>  				brelse(obh);
> -				*success = -EFSBADCRC;
> +				ret = -EFSBADCRC;
>  				pr_err("JBD2: Invalid checksum recovering data block %llu in journal block %lu\n",
>  				      blocknr, io_block);
>  				goto skip_write;
> @@ -580,7 +580,7 @@ static __always_inline int jbd2_do_replay(journal_t *journal,
>  			break;
>  	}
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int do_one_pass(journal_t *journal,
> @@ -719,9 +719,12 @@ static int do_one_pass(journal_t *journal,
>  			 * done here!
>  			 */
>  			err = jbd2_do_replay(journal, info, bh, &next_log_block,
> -					     next_commit_ID, &success);
> -			if (err)
> -				goto failed;
> +					     next_commit_ID);
> +			if (err) {
> +				if (err == -ENOMEM)
> +					goto failed;
> +				success = err;
> +			}
>  
>  			continue;
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

