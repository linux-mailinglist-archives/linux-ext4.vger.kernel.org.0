Return-Path: <linux-ext4+bounces-2710-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09138D33B0
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 11:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98B71C22D4B
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 09:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E11173359;
	Wed, 29 May 2024 09:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yeeX4CeN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TuLERx3o";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u8+7SfNd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ITls/fBz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88CD16A360;
	Wed, 29 May 2024 09:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976241; cv=none; b=kOUNuLjdsEqHu0P4nvUYvO4TPqMAJ/+zY7Z08o2+z+498UAwFVHNpTDKuYwg3WNN0BPpPAsK4s1MBEn6dw5ixDoPfHpCuO3otpxZdl0NKb9iMJfWqxKApuoslX3qeoiIoJozpw7SathOvE+uVe1SpL74aSOH/nXrj5f8TLdkWMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976241; c=relaxed/simple;
	bh=nfr/lIzDZ2ptmjXaU71o5YMnL/MYxS1fb0TD4ogVaMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxzY7IGYIibgjmh8pGRTZiPpDyR1mbLdlsdAmu2ipwlmqg+trFp6va1o6jyjLOn0ugt1nvKS5eIk98m7pPJ6gvcdKtB6/IiKIOip2XAsRfLAwWnu6OIMn6UukBqqjoHNSfm9pgPskF94dhKNCHWstAz1cd3cLFmXIooIxGCgQBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yeeX4CeN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TuLERx3o; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u8+7SfNd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ITls/fBz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EEA4522D99;
	Wed, 29 May 2024 09:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716976237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UZwwNXTNDYwR0XUlWFA2bgWgdfLGH7rBgdpHiyDCoc0=;
	b=yeeX4CeN7Sh14+rL6X32bKnLNaJwMqjrpxv7gK6tqQmYvX8s1TK0HIQTtXHMRF6kS/vr/J
	IRwjPWxZMRt9zy+PUgem24Gke+DirJrMJO+aZAk4f+DcIehHGK1gicvE8+DHtGxHpvMoyM
	upDMT3cU+vfuEBXLsiVRz8H9TOqNHhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716976237;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UZwwNXTNDYwR0XUlWFA2bgWgdfLGH7rBgdpHiyDCoc0=;
	b=TuLERx3okrGpScHs94gbtWGa2DKQllhDJMOHY0Ccc5YNHBAnbJYoUTLFPkF3BHP5u4AuN6
	cxec7IfEurtUWWDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=u8+7SfNd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="ITls/fBz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716976236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UZwwNXTNDYwR0XUlWFA2bgWgdfLGH7rBgdpHiyDCoc0=;
	b=u8+7SfNdfjIgNTpNENIAEAwzwm9t+73N4eS8UOg3xQkTqzGYwIGmVMscNrEXGt609qWmp1
	o1ikTogrH7Gob/NIs78SeBo7IcQOghaOoeyzLGniqe8U6PxHU14d6NHriGrFuN7eZ4s/VI
	Cdv9cVuzeyjx4Tgz7bfnMH1zKjkRmOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716976236;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UZwwNXTNDYwR0XUlWFA2bgWgdfLGH7rBgdpHiyDCoc0=;
	b=ITls/fBznZWSlj1XwORgrofp+3u0TYUIjeXfhRP5fWwCNsAcyDzzpHaBzO0dF2FIsWjDma
	mdcmK6HrBEjvocAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E28721372E;
	Wed, 29 May 2024 09:50:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QlBMN2z6VmbvAgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 29 May 2024 09:50:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 84128A0825; Wed, 29 May 2024 11:50:32 +0200 (CEST)
Date: Wed, 29 May 2024 11:50:32 +0200
From: Jan Kara <jack@suse.cz>
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] ext4: fix fast commit inode enqueueing during a
 full journal commit
Message-ID: <20240529095032.kax3nwtsofyk6qxz@quack3>
References: <20240529092030.9557-1-luis.henriques@linux.dev>
 <20240529092030.9557-2-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529092030.9557-2-luis.henriques@linux.dev>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[mit.edu,dilger.ca,suse.cz,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,linux.dev:email,suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EEA4522D99
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Wed 29-05-24 10:20:29, Luis Henriques (SUSE) wrote:
> When a full journal commit is on-going, any fast commit has to be enqueued
> into a different queue: FC_Q_STAGING instead of FC_Q_MAIN.  This enqueueing
> is done only once, i.e. if an inode is already queued in a previous fast
> commit entry it won't be enqueued again.  However, if a full commit starts
> _after_ the inode is enqueued into FC_Q_MAIN, the next fast commit needs to
> be done into FC_Q_STAGING.  And this is not being done in function
> ext4_fc_track_template().
> 
> This patch fixes the issue by re-enqueuing an inode into the STAGING queue
> during the fast commit clean-up callback if it has a tid (i_sync_tid)
> greater than the one being handled.  The STAGING queue will then be spliced
> back into MAIN.
> 
> This bug was found using fstest generic/047.  This test creates several 32k
> bytes files, sync'ing each of them after it's creation, and then shutting
> down the filesystem.  Some data may be loss in this operation; for example a
> file may have it's size truncated to zero.
> 
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>

Looks good to me! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Just a typo correction below.

> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 87c009e0c59a..088bd509b116 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -1282,8 +1282,17 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
>  		list_del_init(&iter->i_fc_list);
>  		ext4_clear_inode_state(&iter->vfs_inode,
>  				       EXT4_STATE_FC_COMMITTING);
> -		if (iter->i_sync_tid <= tid)
> +		if (iter->i_sync_tid <= tid) {
>  			ext4_fc_reset_inode(&iter->vfs_inode);
> +		} else {
> +			/*
> +			 * re-enqueue inode into STAGING, which later will be
> +			 * splice back into MAIN
			   ^^^ spliced

> +			 */
> +			list_add_tail(&EXT4_I(&iter->vfs_inode)->i_fc_list,
> +				      &sbi->s_fc_q[FC_Q_STAGING]);
> +		}
> +

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

