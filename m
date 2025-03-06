Return-Path: <linux-ext4+bounces-6692-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEAAA54E9E
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Mar 2025 16:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63CD2172B30
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Mar 2025 15:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7BA1DDA35;
	Thu,  6 Mar 2025 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SQjm+xL5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FVGyagDA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hecFYaR2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uAxC0tEh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017E1175D48
	for <linux-ext4@vger.kernel.org>; Thu,  6 Mar 2025 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273920; cv=none; b=NVrQb/6B41ypQlh9o0vx2rhvimOWUPLFMTypLd1iamehyQnswiVweG3vuHbHCvDPesOPWYmCwtOr4jk2Q05OMF421aL2uLnJ5XbqVboZ5fMKMiUb9kgly6uRfCuGC+h7eZhGVFbd/XTQ7cTJC1/8bG8g5JR97a/L7ol5fe7B9Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273920; c=relaxed/simple;
	bh=B0YqOulFBZs4kl94JpEHwXvmG224aCryBKAo/hDF2Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1AvnhD9JCeTtekJsH0j9Yhfld59xgO2EN2gVa4Ir2tarl7QseozOVKv8iabfqnr7JNgXwBPhNWN17s3UKuc61AuvBLEG2YJSFEAGQqYDPUONkkmlTJvINl1tl4jw1DtRI/2m5RICQDg++ul/D7OY9UTbjTgLb5gNNPJc+faidI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SQjm+xL5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FVGyagDA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hecFYaR2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uAxC0tEh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EF9391F449;
	Thu,  6 Mar 2025 15:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741273917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wg/Wi/kdXx/ufcC5Y+5aMaONyu2mrUu/2PxWeDkziA8=;
	b=SQjm+xL5/MGUK8LMND8NUgzCc4kxwcScDf5KaOzh+syJesWDXITjneW7wCKVxesyE8AeYb
	Q6l7PsoSlUOrxci17FSLwlQVuRIM8OppTk0l8KRmsgx/SMm13YWCVMslidWsVg+iJqxglu
	+TNjCC91HrHfoWehSCk8tUe1Z/PNkpM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741273917;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wg/Wi/kdXx/ufcC5Y+5aMaONyu2mrUu/2PxWeDkziA8=;
	b=FVGyagDAinLZZINJnsku1+dKx0L2MrqhYEwXSy8zuTOQadh4hGOEuUV35IrfOqCLyC0T81
	e3bhe00pZKaJNYCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hecFYaR2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uAxC0tEh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741273916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wg/Wi/kdXx/ufcC5Y+5aMaONyu2mrUu/2PxWeDkziA8=;
	b=hecFYaR2d7FmApyDJ745sdYdRVctWqGW7PQxfHalP50678QM7XPvNR/oWb9GltWZljEWip
	2hfZ+re+Bj2x5e8SDentBofRtmcNxOOw4lKlWpBka/ISZQF1HsvRlJ1t8nkV/s1GmBHybQ
	ZM9Al99SzMZr9g0Cnrs/JS9micjZqUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741273916;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wg/Wi/kdXx/ufcC5Y+5aMaONyu2mrUu/2PxWeDkziA8=;
	b=uAxC0tEhlLj+L6RJEEI5mVTyFDT3mtunkGZ5k1PET6V24wy8L0vFMX7Obb7A9R9JDZQxAq
	6vqmgQ5Eu87tN+CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6DDA13A61;
	Thu,  6 Mar 2025 15:11:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HWZZODy7yWfbDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 06 Mar 2025 15:11:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A27DEA087F; Thu,  6 Mar 2025 16:11:56 +0100 (CET)
Date: Thu, 6 Mar 2025 16:11:56 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH] jbd2: remove jbd2_journal_unfile_buffer()
Message-ID: <gvuytgoly7wgpvc2frp2vtz2khvsiiwfzlia67vty2l7mygflm@22akaxrpbsuz>
References: <20250306063240.157884-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306063240.157884-1-libaokun@huaweicloud.com>
X-Rspamd-Queue-Id: EF9391F449
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Thu 06-03-25 14:32:40, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Since the function jbd2_journal_unfile_buffer() is no longer called
> anywhere after commit e5a120aeb57f ("jbd2: remove journal_head from
> descriptor buffers"), so let's remove it.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Nice! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
> ---
>  fs/jbd2/transaction.c | 15 ---------------
>  include/linux/jbd2.h  |  1 -
>  2 files changed, 16 deletions(-)
> 
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index 9fe17e290c21..2bc14291a0fb 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -2078,21 +2078,6 @@ static void __jbd2_journal_unfile_buffer(struct journal_head *jh)
>  	jh->b_transaction = NULL;
>  }
>  
> -void jbd2_journal_unfile_buffer(journal_t *journal, struct journal_head *jh)
> -{
> -	struct buffer_head *bh = jh2bh(jh);
> -
> -	/* Get reference so that buffer cannot be freed before we unlock it */
> -	get_bh(bh);
> -	spin_lock(&jh->b_state_lock);
> -	spin_lock(&journal->j_list_lock);
> -	__jbd2_journal_unfile_buffer(jh);
> -	spin_unlock(&journal->j_list_lock);
> -	spin_unlock(&jh->b_state_lock);
> -	jbd2_journal_put_journal_head(jh);
> -	__brelse(bh);
> -}
> -
>  /**
>   * jbd2_journal_try_to_free_buffers() - try to free page buffers.
>   * @journal: journal for operation
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 82ef232935c0..2205c99beff4 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1401,7 +1401,6 @@ JBD2_FEATURE_INCOMPAT_FUNCS(fast_commit,	FAST_COMMIT)
>   */
>  
>  /* Filing buffers */
> -extern void jbd2_journal_unfile_buffer(journal_t *, struct journal_head *);
>  extern bool __jbd2_journal_refile_buffer(struct journal_head *);
>  extern void jbd2_journal_refile_buffer(journal_t *, struct journal_head *);
>  extern void __jbd2_journal_file_buffer(struct journal_head *, transaction_t *, int);
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

