Return-Path: <linux-ext4+bounces-5604-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43459EFEE3
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Dec 2024 23:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D472716C8E4
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Dec 2024 22:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892EA18FDA9;
	Thu, 12 Dec 2024 22:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yxaVwASS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FXxFGNCp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yxaVwASS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FXxFGNCp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2984D186E20
	for <linux-ext4@vger.kernel.org>; Thu, 12 Dec 2024 22:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734040852; cv=none; b=t/sfluj7Nwwwjx7KrsflhQiGB1VM2saiALIOaLcIQx/L6H0+D6l6G4CTx8u0/tmI7cIlS1r/M35vGfvKFwPqm38SFR541aZuarqCEMqozBzHbBEUX6xLOpgZ4OQ98XLJ1S2m+2yq+hf24TkjD1m+BXxWbI585MnJ8jw0CKlZ0Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734040852; c=relaxed/simple;
	bh=20CkJJeixlJ6TWm8Rp2adGMWPDEyHO0ZolohmN8JEa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0FHCn//hGaBbv3N6WWsaXHZ6XEONrBPtHBX9CGLpqXiaW2jYrcUQRC4SKvNjl8BSWWYlfCNLB6Kr3NILz/UsMSa1Mh7Q0JNvO/dqsSzA4SQfsWDByrmxcyayqnAWVyk5+3oyspexnaEZ6DytOBren6id8adyIIPAywv2GF/thM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yxaVwASS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FXxFGNCp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yxaVwASS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FXxFGNCp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3C540211DF;
	Thu, 12 Dec 2024 22:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734040848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X/uUqZdIRT3Bo7mcMyKvZETPMPs/Vj2/4A5kbUmyc8Y=;
	b=yxaVwASSRiFlJ2314lfZFQkvceoytPQpd6FUc+HSPGby8PkQGIESAFQOE/cHJrw8Uh5pF/
	Z8KipdMRZLEjuJEdurUQenJK1r0Ra+wL6f9jel57wDXpcgUF6VijkPD4GOqiT+O0AD9eGi
	5BZSJbm6mc5lklFCJHRy0qwxd6bdOd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734040848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X/uUqZdIRT3Bo7mcMyKvZETPMPs/Vj2/4A5kbUmyc8Y=;
	b=FXxFGNCp/JVtFTvwKlpziNHp381JaOJRkqfSTKnu7S805FZEFrxrbg1Qdg6j2LLLc03hMr
	zHoGdaxsUzdy6tAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734040848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X/uUqZdIRT3Bo7mcMyKvZETPMPs/Vj2/4A5kbUmyc8Y=;
	b=yxaVwASSRiFlJ2314lfZFQkvceoytPQpd6FUc+HSPGby8PkQGIESAFQOE/cHJrw8Uh5pF/
	Z8KipdMRZLEjuJEdurUQenJK1r0Ra+wL6f9jel57wDXpcgUF6VijkPD4GOqiT+O0AD9eGi
	5BZSJbm6mc5lklFCJHRy0qwxd6bdOd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734040848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X/uUqZdIRT3Bo7mcMyKvZETPMPs/Vj2/4A5kbUmyc8Y=;
	b=FXxFGNCp/JVtFTvwKlpziNHp381JaOJRkqfSTKnu7S805FZEFrxrbg1Qdg6j2LLLc03hMr
	zHoGdaxsUzdy6tAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3262F13939;
	Thu, 12 Dec 2024 22:00:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8rZDDBBdW2cFcwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 12 Dec 2024 22:00:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DBC87A0894; Thu, 12 Dec 2024 23:00:43 +0100 (CET)
Date: Thu, 12 Dec 2024 23:00:43 +0100
From: Jan Kara <jack@suse.cz>
To: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
	harshads@google.com
Subject: Re: [PATCH v7 2/9] ext4: for committing inode, make
 ext4_fc_track_inode wait
Message-ID: <20241212220043.a6hiif444v4jwnkm@quack3>
References: <20240818040356.241684-1-harshadshirwadkar@gmail.com>
 <20240818040356.241684-4-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818040356.241684-4-harshadshirwadkar@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Sun 18-08-24 04:03:49, Harshad Shirwadkar wrote:
> If the inode that's being requested to track using ext4_fc_track_inode
> is being committed, then wait until the inode finishes the
> commit. Also, add calls to ext4_fc_track_inode at the right places.
> 
> With this patch, now calling ext4_reserve_inode_write() results in
> inode being tracked for next fast commit. A subtle lock ordering
> requirement with i_data_sem (which is documented in the code) requires
> that ext4_fc_track_inode() be called before grabbing i_data_sem. So,
> this patch also adds explicit ext4_fc_track_inode() calls in places
> where i_data_sem grabbed.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Sorry for the huge delay! Some comments are below:

> @@ -598,6 +601,36 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
>  	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
>  		return;
>  
> +	if (!list_empty(&ei->i_fc_list))
> +		return;
> +
> +#ifdef CONFIG_LOCKDEP
> +	/*
> +	 * If we come here, we may sleep while waiting for the inode to
> +	 * commit. We shouldn't be holding i_data_sem when we go to sleep since
> +	 * the commit path needs to grab the lock while committing the inode.
> +	 */
> +	WARN_ON(lockdep_is_held(&ei->i_data_sem));
> +#endif

We have lockdep_assert_not_held() for this so you can avoid the ifdef.

> +
> +	while (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
> +#if (BITS_PER_LONG < 64)
> +		DEFINE_WAIT_BIT(wait, &ei->i_state_flags,
> +				EXT4_STATE_FC_COMMITTING);
> +		wq = bit_waitqueue(&ei->i_state_flags,
> +				   EXT4_STATE_FC_COMMITTING);
> +#else
> +		DEFINE_WAIT_BIT(wait, &ei->i_flags,
> +				EXT4_STATE_FC_COMMITTING);
> +		wq = bit_waitqueue(&ei->i_flags,
> +				   EXT4_STATE_FC_COMMITTING);
> +#endif
> +		prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
> +		if (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING))
> +			schedule();
> +		finish_wait(wq, &wait.wq_entry);
> +	}

But what protects us from fastcommit setting EXT4_STATE_FC_COMMITTING at
this moment before we call ext4_fc_track_template(). Don't you need
to grab sbi->s_fc_lock and hold it until the inode is attached to the
fastcommit?

I might be missing something so some documentation (like a comment here)
would be nice to explain what are you actually trying to achieve with the
waiting...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

