Return-Path: <linux-ext4+bounces-2916-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02130912D32
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jun 2024 20:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 301FAB27B7E
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jun 2024 18:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F421684AA;
	Fri, 21 Jun 2024 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NCbsF8oT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0aCppgDq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NCbsF8oT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0aCppgDq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FBBB65F
	for <linux-ext4@vger.kernel.org>; Fri, 21 Jun 2024 18:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718994681; cv=none; b=qO4zmrpUelMpm+nG/Nt4Kq77f3YG9WBFjwqTsgPY3UPUBeRREFKLgjm/CC48ybIWVrS35jZC5R7+za4Rq9dJcpFUMYQUQtcNEojxHvMpTkKVSdXwCX7XjeuaGkw5wUp4OwmXeW0MaGboGhWP4GE2ZyrmNjz66vblJsRSI72XUQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718994681; c=relaxed/simple;
	bh=TbTT+dfp5l/22+/JRAI6d7UYwzyfXrDUjisHTsQ3LjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBLxhjStUDCyUui3IyxkQK3YUxjxifaiM3N4Ddf5eeHacXLrkHgzP2a2wi7IzyKxy6P4eu2R1F3sGJSBkbn9dbC9A/0bqokcu/7xXLn6WgEdjET39M7X0RhHMOjIs1csiB1/sdDTkMF5nWVFPCTYQGJXInyLmG2uD06ICXk3Azo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NCbsF8oT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0aCppgDq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NCbsF8oT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0aCppgDq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9C97121B43;
	Fri, 21 Jun 2024 18:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718994671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3ewZ/afJNn47Tw7sxtmIADME91iCLFgZA9neHreVuKw=;
	b=NCbsF8oTSX2vnktTMrpVZUmFcpd3QKjCUYFovoDd1WG3svgwgHcHL956ACLWqF6D70KQlp
	JR7skNJE4t7Cf24o98+q00CRkAZmRjQqYOY378hNlDglj3A0Z2ziRVbEMKMUydpvTIeW82
	vqJ2TD7q3/6bY/JeX1t+GPHuf9U3GJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718994671;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3ewZ/afJNn47Tw7sxtmIADME91iCLFgZA9neHreVuKw=;
	b=0aCppgDqhBThlypSDWAuB2UWuHBOykSf1PJUWHue1d5oRI4H8+ZP/2GPlpY4VuO9UJAFQw
	VVHiAPf0o1QCGzDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718994671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3ewZ/afJNn47Tw7sxtmIADME91iCLFgZA9neHreVuKw=;
	b=NCbsF8oTSX2vnktTMrpVZUmFcpd3QKjCUYFovoDd1WG3svgwgHcHL956ACLWqF6D70KQlp
	JR7skNJE4t7Cf24o98+q00CRkAZmRjQqYOY378hNlDglj3A0Z2ziRVbEMKMUydpvTIeW82
	vqJ2TD7q3/6bY/JeX1t+GPHuf9U3GJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718994671;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3ewZ/afJNn47Tw7sxtmIADME91iCLFgZA9neHreVuKw=;
	b=0aCppgDqhBThlypSDWAuB2UWuHBOykSf1PJUWHue1d5oRI4H8+ZP/2GPlpY4VuO9UJAFQw
	VVHiAPf0o1QCGzDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F75A13ABD;
	Fri, 21 Jun 2024 18:31:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id clD/Iu/GdWZIdQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 21 Jun 2024 18:31:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EEA13A0829; Fri, 21 Jun 2024 18:33:13 +0200 (CEST)
Date: Fri, 21 Jun 2024 18:33:13 +0200
From: Jan Kara <jack@suse.cz>
To: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, saukad@google.com,
	harshads@google.com
Subject: Re: [PATCH v6 02/10] ext4: for committing inode, make
 ext4_fc_track_inode wait
Message-ID: <20240621163313.equbxelyeetrxb6w@quack3>
References: <20240529012003.4006535-1-harshadshirwadkar@gmail.com>
 <20240529012003.4006535-3-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529012003.4006535-3-harshadshirwadkar@gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Wed 29-05-24 01:19:55, Harshad Shirwadkar wrote:
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
> ---
>  fs/ext4/fast_commit.c | 34 ++++++++++++++++++++++++++++++++++
>  fs/ext4/inline.c      |  3 +++
>  fs/ext4/inode.c       |  4 ++++
>  3 files changed, 41 insertions(+)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index a1aadebfcd66..fa93ce399440 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -581,6 +581,8 @@ static int __track_inode(struct inode *inode, void *arg, bool update)
>  
>  void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
>  {
> +	struct ext4_inode_info *ei = EXT4_I(inode);
> +	wait_queue_head_t *wq;
>  	int ret;
>  
>  	if (S_ISDIR(inode->i_mode))
> @@ -598,6 +600,38 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
>  	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
>  		return;
>  
> +	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
> +	    (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY) ||
> +		ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE) ||
> +		!list_empty(&ei->i_fc_list))

Indentation here is wrong (we never indent conditions by the same amount as
subsequent code block). Also EXT4_MF_FC_INELIGIBLE was just tested above so
why repeat it and ext4_fc_disabled() tested the EXT4_FC_REPLAY and
JOURNAL_FAST_COMMIT flags. So list_empty() should be the only thing needed
here.

BTW a separate helper for ext4_fc_disabled() + EXT4_MF_FC_INELIGIBLE test
would be a nice cleanup as it is a pattern happening in quite a few places.

> +		return;
> +
> +	/*
> +	 * If we come here, we may sleep while waiting for the inode to
> +	 * commit. We shouldn't be holding i_data_sem in write mode when we go
> +	 * to sleep since the commit path needs to grab the lock while
> +	 * committing the inode.
> +	 */
> +	WARN_ON(lockdep_is_held_type(&ei->i_data_sem, 1));

Actually even holding it in read mode is problematic. rwsems can block
other readers from acquiring rwsem if there's some writer waiting to
acquire the lock (and that will be blocked behind us). Shortly, this should
be just lockdep_is_held().

Otherwise the patch looks good.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

