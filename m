Return-Path: <linux-ext4+bounces-3525-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC397941311
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 15:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91433284E11
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 13:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E16619F48D;
	Tue, 30 Jul 2024 13:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VzUK5gJW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r9kbbwug";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VzUK5gJW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="r9kbbwug"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1941218FC6E;
	Tue, 30 Jul 2024 13:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722345869; cv=none; b=meF34r8GBCfJzKfxSm+FudFAo+ezwIIVxZDAPjqO7HVGOH6Uf8ugo5wWf3p9yBy6xwNNVrihxR8e3Xk/8DIi52x2QZdUSjyvVsD0UdMWUvZef/JN+8rqrvtFYcqgkCjoJtGXxrt2ldVzUg13z/ATtkRQ1Pz6VF8Xm4wej8BQY2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722345869; c=relaxed/simple;
	bh=0nzwucZf/UnR3lR+fBoHfvcPfVbl0MDGRDCs9RnPFRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IL+ShIqGZ37vWwtG7Boz+GT6f0M6ItjmP3+O+gIZ7m2mR5x02nLfz+lQYx7CAlc68kCnhAPYs3hRbdYHnSSCq+HoJiiOjPHnGPnOFNFIVQPXIhfhrf16FpD3G47+V9G6IUr17P8+96krUw0JnvaXWm0jbln3tiN2GLt8dxc4eME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VzUK5gJW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r9kbbwug; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VzUK5gJW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=r9kbbwug; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3566C1F7E2;
	Tue, 30 Jul 2024 13:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722345866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Tz20vg4yDuRcYFda0wL+ovMuwWR5VKY2CsYEfxoyLY=;
	b=VzUK5gJWfrugW7NK6ARqcGABhlUB3a0T6UT02trtQTqzrR93gh8/1z/Y1SO1+C1du+BXQg
	aR+wOmvbglUgW0+LoDyO1gfI/+B4mHK30bi3xTrwdOX552ryNsUf750r5eHQ7HxmiH2CPk
	usGyqj9F81z5qn8i1TdXRTrxZSaW7d0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722345866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Tz20vg4yDuRcYFda0wL+ovMuwWR5VKY2CsYEfxoyLY=;
	b=r9kbbwugy+EFFiir39tW7CFSm7Jj+0xYpiGTz3atfRv6NRHcP/N9WdNFwGy8FZ4xrGbIwL
	yFdORUbrrQMDY3Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722345866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Tz20vg4yDuRcYFda0wL+ovMuwWR5VKY2CsYEfxoyLY=;
	b=VzUK5gJWfrugW7NK6ARqcGABhlUB3a0T6UT02trtQTqzrR93gh8/1z/Y1SO1+C1du+BXQg
	aR+wOmvbglUgW0+LoDyO1gfI/+B4mHK30bi3xTrwdOX552ryNsUf750r5eHQ7HxmiH2CPk
	usGyqj9F81z5qn8i1TdXRTrxZSaW7d0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722345866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Tz20vg4yDuRcYFda0wL+ovMuwWR5VKY2CsYEfxoyLY=;
	b=r9kbbwugy+EFFiir39tW7CFSm7Jj+0xYpiGTz3atfRv6NRHcP/N9WdNFwGy8FZ4xrGbIwL
	yFdORUbrrQMDY3Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E9FC13983;
	Tue, 30 Jul 2024 13:24:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0sp3B4rpqGb7WAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 30 Jul 2024 13:24:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D5E51A099C; Tue, 30 Jul 2024 15:24:25 +0200 (CEST)
Date: Tue, 30 Jul 2024 15:24:25 +0200
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] jbd2: remove unused return value of
 jbd2_fc_release_bufs
Message-ID: <20240730132425.gkskeg4hwsciwczj@quack3>
References: <20240730113335.2365290-1-shikemeng@huaweicloud.com>
 <20240730113335.2365290-4-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730113335.2365290-4-shikemeng@huaweicloud.com>
X-Spamd-Result: default: False [-3.60 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.60

On Tue 30-07-24 19:33:31, Kemeng Shi wrote:
> Remove unused return value of jbd2_fc_release_bufs.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c    | 4 +---
>  include/linux/jbd2.h | 2 +-
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index b5d02de1ffff..312c7575b54f 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -903,7 +903,7 @@ int jbd2_fc_wait_bufs(journal_t *journal, int num_blks)
>  }
>  EXPORT_SYMBOL(jbd2_fc_wait_bufs);
>  
> -int jbd2_fc_release_bufs(journal_t *journal)
> +void jbd2_fc_release_bufs(journal_t *journal)
>  {
>  	struct buffer_head *bh;
>  	int i, j_fc_off;
> @@ -917,8 +917,6 @@ int jbd2_fc_release_bufs(journal_t *journal)
>  		put_bh(bh);
>  		journal->j_fc_wbuf[i] = NULL;
>  	}
> -
> -	return 0;
>  }
>  EXPORT_SYMBOL(jbd2_fc_release_bufs);
>  
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index b900c642210c..735229e8ad17 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1665,7 +1665,7 @@ int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out);
>  int jbd2_submit_inode_data(journal_t *journal, struct jbd2_inode *jinode);
>  int jbd2_wait_inode_data(journal_t *journal, struct jbd2_inode *jinode);
>  int jbd2_fc_wait_bufs(journal_t *journal, int num_blks);
> -int jbd2_fc_release_bufs(journal_t *journal);
> +void jbd2_fc_release_bufs(journal_t *journal);
>  
>  /*
>   * is_journal_abort
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

