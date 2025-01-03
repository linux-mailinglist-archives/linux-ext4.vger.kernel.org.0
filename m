Return-Path: <linux-ext4+bounces-5879-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40492A00AA1
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jan 2025 15:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CB451638C5
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jan 2025 14:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1088A1FA257;
	Fri,  3 Jan 2025 14:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PQC4Cl9c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HJx1fHxj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HPQDnXZ/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oshnV4JL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0CE1FA158;
	Fri,  3 Jan 2025 14:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735915044; cv=none; b=FFkxnDz5Fh6cAW0otBAue1+hqBORcx5iT+iqB9+NMOxnuqKmnhBWI25EUCa53zKOw/U6kLaRBwD13Bsnn04hb8e6eNpYDUugRrefFGKX0tlTjHkuGL8936gWmFUhLkc26qfWwZdaqueuMjZGaOO1Dt5IA1q3GaBaaZWwjkqqt+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735915044; c=relaxed/simple;
	bh=VLYWBQrV+gyefRAP9TSmWTv+g5cBfLfRLFH6Oj/W9NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+/UbEv23BIp6VfOqYV3HYPUomjI2vnK280T7mS57FIve6+31LjC7C4xGS7AKUb5zdYaS3/m4XbRa84BtyxzB7hNHR+Y0zcofiMIwC/YWutzrpfVKPoi1/VKsJpkEEeOt5IJ5MWSpnhPI2ocoZ3rzxFBB3/jFUXWZWJuWEEcpSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PQC4Cl9c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HJx1fHxj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HPQDnXZ/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oshnV4JL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B046E1F38E;
	Fri,  3 Jan 2025 14:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735915041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P+FxqAP29Wp9VDcRjpXxOqwcxB8OSoetiTX3lW8ADbQ=;
	b=PQC4Cl9cx4MCws6E8hmzUeCLn7h72HcHpeYyWSLLbw74GHWj034Ms5EjacuoU85Tlu/yqb
	CP+32gu3ujgcw1oDHFUf1rSkAWgE3FGQi2wQlgY/dGAXhn7Mi5RQgJ0IeJEEp+TKl2+WbA
	sbZTf30B074FlO/IpBDU7PA6a6otrv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735915041;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P+FxqAP29Wp9VDcRjpXxOqwcxB8OSoetiTX3lW8ADbQ=;
	b=HJx1fHxjRwlmrjtpLJLnxIQXhHx5xjR3oQAQwvqbGpWXrQq6N7eZ+sIrHFZmMJa8KIddMo
	y9ppp/r9P3gSW/Bw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="HPQDnXZ/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=oshnV4JL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735915039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P+FxqAP29Wp9VDcRjpXxOqwcxB8OSoetiTX3lW8ADbQ=;
	b=HPQDnXZ/VKBg7Hl9C6L/46iwL5xwfDUGn+54GAf8cfmvyMLDChvCQNjKE2N4uMC/CNfk0D
	0OTxmq21EMaIG755VanIod3HSRZiV7pO2n8HXpxb69sX/ZxlS8zo35Zv69q4IrcKEqjEyv
	UQz6yCXVvbTJV2dqPSpbavRWEtb6vpk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735915039;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P+FxqAP29Wp9VDcRjpXxOqwcxB8OSoetiTX3lW8ADbQ=;
	b=oshnV4JLK3Nm43a7rUyyGzuLm9Ik5fyfVjLGMZ1E79VnWetnwzbLheyRaDD7UuNPZKZEA7
	+HqE2Z98NH44KaBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5286134E4;
	Fri,  3 Jan 2025 14:37:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +uxQKB/2d2c/XwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 03 Jan 2025 14:37:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 49CACA0844; Fri,  3 Jan 2025 15:37:11 +0100 (CET)
Date: Fri, 3 Jan 2025 15:37:11 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] jbd2: remove unused return value of
 jbd2_journal_cancel_revoke
Message-ID: <ty2rk5pz5t54xgud3fuxa5zguedkckcjsdp32tw5vnwmpove7m@ljoh3k5yzzjm>
References: <20241224202707.1530558-1-shikemeng@huaweicloud.com>
 <20241224202707.1530558-3-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241224202707.1530558-3-shikemeng@huaweicloud.com>
X-Rspamd-Queue-Id: B046E1F38E
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email,huaweicloud.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 25-12-24 04:27:03, Kemeng Shi wrote:
> Remove unused return value of jbd2_journal_cancel_revoke.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Yeah, nobody used it for years. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/revoke.c     | 5 +----
>  include/linux/jbd2.h | 2 +-
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
> index 4556e4689024..af0208ed3619 100644
> --- a/fs/jbd2/revoke.c
> +++ b/fs/jbd2/revoke.c
> @@ -420,12 +420,11 @@ int jbd2_journal_revoke(handle_t *handle, unsigned long long blocknr,
>   * do not trust the Revoked bit on buffers unless RevokeValid is also
>   * set.
>   */
> -int jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
> +void jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
>  {
>  	struct jbd2_revoke_record_s *record;
>  	journal_t *journal = handle->h_transaction->t_journal;
>  	int need_cancel;
> -	int did_revoke = 0;	/* akpm: debug */
>  	struct buffer_head *bh = jh2bh(jh);
>  
>  	jbd2_debug(4, "journal_head %p, cancelling revoke\n", jh);
> @@ -450,7 +449,6 @@ int jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
>  			list_del(&record->hash);
>  			spin_unlock(&journal->j_revoke_lock);
>  			kmem_cache_free(jbd2_revoke_record_cache, record);
> -			did_revoke = 1;
>  		}
>  	}
>  
> @@ -473,7 +471,6 @@ int jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
>  			__brelse(bh2);
>  		}
>  	}
> -	return did_revoke;
>  }
>  
>  /*
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index c7fdb2b1b9a6..e2d1426d3e06 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1635,7 +1635,7 @@ extern int __init jbd2_journal_init_revoke_table_cache(void);
>  
>  extern void	   jbd2_journal_destroy_revoke(journal_t *);
>  extern int	   jbd2_journal_revoke (handle_t *, unsigned long long, struct buffer_head *);
> -extern int	   jbd2_journal_cancel_revoke(handle_t *, struct journal_head *);
> +extern void	   jbd2_journal_cancel_revoke(handle_t *, struct journal_head *);
>  extern void	   jbd2_journal_write_revoke_records(transaction_t *transaction,
>  						     struct list_head *log_bufs);
>  
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

