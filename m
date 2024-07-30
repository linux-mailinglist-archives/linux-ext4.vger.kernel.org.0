Return-Path: <linux-ext4+bounces-3528-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC06094134D
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 15:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71081281CB4
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 13:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29C119F499;
	Tue, 30 Jul 2024 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zS76HCuX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xOb8lntt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zS76HCuX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xOb8lntt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78EB173;
	Tue, 30 Jul 2024 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722346741; cv=none; b=b7xjAnFqu2afb9E9qmLljINdtQOa4nIn0FJzgqzdSiZocZHfmc0A+hbuB+a2Nt/Mhebn+WY53+pRg35gaPlY7WjGTDKbi1CJbPQNaWsAACkmBjm+DaViPjBVRM7/EiMK6enZW2gt7sZoppbBHy5onj8oMrHo9hGUdpXfbXeeEHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722346741; c=relaxed/simple;
	bh=HnzZ7Ko/X/1Il25j0HU1vpiFlhrP2AFVZFWPqEOo+QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QF93l7Afs9+/UixW6lB4KmqZIziI5Soql4Cz0Q64P/Ij8f1FROMOG9ZMDC/UzvPpOezV4U8wBcNF5GI4RlAHoNY0s5Z4lYX8qg6dNur4Fr2jdQvca/OCR0PMlJITwk/t67CgFJW7dOojFjtmyT1GsJxqT8+LxU5LYsVl7OfBYqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zS76HCuX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xOb8lntt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zS76HCuX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xOb8lntt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2D6541F7E2;
	Tue, 30 Jul 2024 13:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722346738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xD5RQ/pYc1zZMmbz2/yDKlbK3B7eplQegixM++Nb2gs=;
	b=zS76HCuXxWHPDNI9dVL/Zdr4cRwPvSgQorEM1OR++Y0tWCC/2JImYI6FrrKOxZEzjq6Wui
	JmcT4/PQbjv+EEZLKwyVWvmwlYWWtUQYBFe5NflRNRf2LV3yT3scRnF7iKf97rDA9TnJWu
	KtQv7Q4je9B8nucTJZdAtIhK0EEGJXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722346738;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xD5RQ/pYc1zZMmbz2/yDKlbK3B7eplQegixM++Nb2gs=;
	b=xOb8lntt55um9VAzUma8VOk6HGoD3lHBXH+laCEdByseoHvizaUV+WVZc9MFWInqfDmxDO
	NH8GwEW73fCsNFDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722346738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xD5RQ/pYc1zZMmbz2/yDKlbK3B7eplQegixM++Nb2gs=;
	b=zS76HCuXxWHPDNI9dVL/Zdr4cRwPvSgQorEM1OR++Y0tWCC/2JImYI6FrrKOxZEzjq6Wui
	JmcT4/PQbjv+EEZLKwyVWvmwlYWWtUQYBFe5NflRNRf2LV3yT3scRnF7iKf97rDA9TnJWu
	KtQv7Q4je9B8nucTJZdAtIhK0EEGJXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722346738;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xD5RQ/pYc1zZMmbz2/yDKlbK3B7eplQegixM++Nb2gs=;
	b=xOb8lntt55um9VAzUma8VOk6HGoD3lHBXH+laCEdByseoHvizaUV+WVZc9MFWInqfDmxDO
	NH8GwEW73fCsNFDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10BA913983;
	Tue, 30 Jul 2024 13:38:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c1cUBPLsqGa0XQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 30 Jul 2024 13:38:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AC70CA099C; Tue, 30 Jul 2024 15:38:53 +0200 (CEST)
Date: Tue, 30 Jul 2024 15:38:53 +0200
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] jbd2: remove unneeded check of ret in jbd2_fc_get_buf
Message-ID: <20240730133853.h7y6uj4e5eaxsmxt@quack3>
References: <20240730113335.2365290-1-shikemeng@huaweicloud.com>
 <20240730113335.2365290-8-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730113335.2365290-8-shikemeng@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-0.60 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,huaweicloud.com:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -0.60

On Tue 30-07-24 19:33:35, Kemeng Shi wrote:
> Simply return -EINVAL if j_fc_off is invalid to avoid repeated check of
> ret.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index dc18b9f7c999..6f90f7b8e9e5 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -842,12 +842,8 @@ int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out)
>  		fc_off = journal->j_fc_off;
>  		blocknr = journal->j_fc_first + fc_off;
>  		journal->j_fc_off++;
> -	} else {
> -		ret = -EINVAL;
> -	}
> -
> -	if (ret)
> -		return ret;
> +	} else
> +		return -EINVAL;
>  
>  	ret = jbd2_journal_bmap(journal, blocknr, &pblock);
>  	if (ret)
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

