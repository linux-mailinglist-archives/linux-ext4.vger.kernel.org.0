Return-Path: <linux-ext4+bounces-3524-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 474BE94130C
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 15:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDD2D1F24C1A
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 13:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3BB1A00C9;
	Tue, 30 Jul 2024 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LkS2vp3Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jEkxkY8i";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LkS2vp3Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jEkxkY8i"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4DA19F471;
	Tue, 30 Jul 2024 13:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722345784; cv=none; b=WQql47Y/9CewKf0QrnxlEnHkxOpzSkx6DZFwl4T3mvgfWv+H1SjozFWIxEhg32TM5AymBUMJcf9BO+kNVVKT8fl2ySG295x8+NuQH5eUirKOy38bksuunPiKDGS38R9V/M+pzZMPsxuwS7oG1dnL9XFWVyXkTz4SGlk17YXeAGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722345784; c=relaxed/simple;
	bh=dHhs4lAr2eowWfzNN+WCKMZB69CaKBNwPT9Y13YykVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEUlg5XcVUPKltFpiqEZqSV3tOw6l/svIZSyLTMIdaYToB4r33Lpf7FrSBa9BDEajE8pFCres/AnaYSsYKVyvu/HhDBoMMWGdu1wX47lXv43wBwPmaVKBdTOVJVxi2AuhXMw3UnaaMPYTSFthD2cOoWHfMoCsV47sPz4iyThVaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LkS2vp3Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jEkxkY8i; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LkS2vp3Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jEkxkY8i; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ABC2F1F7E2;
	Tue, 30 Jul 2024 13:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722345780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TgZXYIH8kCOVZYjyJoF48AuzeHFdOeND5k+5pEfSCqk=;
	b=LkS2vp3Qixp9hGEwNFZjHLJusjrrEXrnF4csk86wqbnf208/ndVxQu9pGoi3C3N2TRJcUX
	DmdArjxSUPUssLl/bSf/Ttp0uvMouqmnX3VPXtw8tBEWw9mIMbzq5uTcihFapB+eVe7bsL
	yL6H/WN8NcEBw1zwxsh6PF+gB0aK7A4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722345780;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TgZXYIH8kCOVZYjyJoF48AuzeHFdOeND5k+5pEfSCqk=;
	b=jEkxkY8ih+0J55d0gPdh0GzRAZa7oDp9+SRAErenvh4Lp4JQ1ZdRUeSOCYLlGrYcckU9lM
	p0JfxICPtXmRT6Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722345780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TgZXYIH8kCOVZYjyJoF48AuzeHFdOeND5k+5pEfSCqk=;
	b=LkS2vp3Qixp9hGEwNFZjHLJusjrrEXrnF4csk86wqbnf208/ndVxQu9pGoi3C3N2TRJcUX
	DmdArjxSUPUssLl/bSf/Ttp0uvMouqmnX3VPXtw8tBEWw9mIMbzq5uTcihFapB+eVe7bsL
	yL6H/WN8NcEBw1zwxsh6PF+gB0aK7A4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722345780;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TgZXYIH8kCOVZYjyJoF48AuzeHFdOeND5k+5pEfSCqk=;
	b=jEkxkY8ih+0J55d0gPdh0GzRAZa7oDp9+SRAErenvh4Lp4JQ1ZdRUeSOCYLlGrYcckU9lM
	p0JfxICPtXmRT6Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D09813983;
	Tue, 30 Jul 2024 13:23:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OodqIjTpqGakWAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 30 Jul 2024 13:23:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3E2AEA099C; Tue, 30 Jul 2024 15:23:00 +0200 (CEST)
Date: Tue, 30 Jul 2024 15:23:00 +0200
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] jbd2: remove dead check in journal_alloc_journal_head
Message-ID: <20240730132300.wglmpo66n25p5crm@quack3>
References: <20240730113335.2365290-1-shikemeng@huaweicloud.com>
 <20240730113335.2365290-3-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730113335.2365290-3-shikemeng@huaweicloud.com>
X-Spamd-Result: default: False [-3.60 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.60

On Tue 30-07-24 19:33:30, Kemeng Shi wrote:
> We will alloc journal_head with __GFP_NOFAIL anyway, test for failure
> is pointless.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Why not. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index da5a56d700f1..b5d02de1ffff 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -2866,8 +2866,7 @@ static struct journal_head *journal_alloc_journal_head(void)
>  		ret = kmem_cache_zalloc(jbd2_journal_head_cache,
>  				GFP_NOFS | __GFP_NOFAIL);
>  	}
> -	if (ret)
> -		spin_lock_init(&ret->b_state_lock);
> +	spin_lock_init(&ret->b_state_lock);
>  	return ret;
>  }
>  
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

