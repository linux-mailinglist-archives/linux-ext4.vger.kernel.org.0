Return-Path: <linux-ext4+bounces-2711-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D408D33B5
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 11:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B5FDB28B2D
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 09:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB3316E89B;
	Wed, 29 May 2024 09:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O81h11Mu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zhMTQOxB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="d3o3uKIf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pEEaYwYz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2719316ABEB;
	Wed, 29 May 2024 09:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976289; cv=none; b=TJ07mutl2Yz97nxLDIrFS+eBHZQJGotykYmusGbsLBtaIWTkAKN34m9xywkQG5LRlmyBwTUOC4JEZ8Li1WYMYPrAvPINYond98k4yRoq6nXPDH3DzYnS7ZJ0c/UhZBvaUTGDniazlMREoV4fFXJmoxPt3+lje1tL5eU2QUo+zNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976289; c=relaxed/simple;
	bh=YcXMSAiXYTWYD+B9xHrJXe+f9U1uQ4Iaw4UQkhIvGAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWmIR5SYicgDCumw77hXAJKJTGhDWEKGaiI/CooUn4crDXqo4Ayi80PPGfBxA24pvYi/1ub3aidrFUha48IziNpEIx6OO8ybUlz7HlMMbV/mkgC6EOMYUA3J4wgyr+RaJkBHSWTqWlgoN37+xkadBatYttRsOaceo1B3zsDUhOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O81h11Mu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zhMTQOxB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=d3o3uKIf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pEEaYwYz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F072C22D44;
	Wed, 29 May 2024 09:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716976285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FqAdLPrYpeP2hRlhvLGvf4ixrOgf8Ok3KPjSNl4wreY=;
	b=O81h11MusrSEK65a42zVplfa90Fvf9IRoBm6s4dmPb2tgC23vPxTpU6LB8GHS3zKGFFw2e
	hZEM+6Se7Nt497NHkrwOKwoFDmiBgrUNEV7f7qE84EHDKC/eQi0gfQKb7EuP2XSYW96Ko+
	Q26BYt2lOXh8O7A9Py5F+SOk3KcE+hI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716976285;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FqAdLPrYpeP2hRlhvLGvf4ixrOgf8Ok3KPjSNl4wreY=;
	b=zhMTQOxBGd+dbxAuUzrETt32OTvwdvlKfFQcF6NtVQU/GdgUpo9Hrtea2YuNJznMH/Kujv
	uOyeJTOnqsfmZPAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716976284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FqAdLPrYpeP2hRlhvLGvf4ixrOgf8Ok3KPjSNl4wreY=;
	b=d3o3uKIfQtG8+DnLcIjs3jP2se3epXVniyBt3ymIuotoDAhhEfs2agUo0yQnVO6bW3iPOl
	zITwnFqDUnGNPmcVjbFoYgGz7qdVk69CQcnV86PZRVjHjvivc5RvZfANKIUA/IHEuZPq0g
	DiHiJFFErU8cOIg+z+abIddvZ4RAXo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716976284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FqAdLPrYpeP2hRlhvLGvf4ixrOgf8Ok3KPjSNl4wreY=;
	b=pEEaYwYzpuQzWvylxML73HbK4LhXKg5grWGRANfddeEVRbP86ZRSWFKsgO5Rzz5l5HyC5o
	9OAORjAD+LqmKlDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E40BB1372E;
	Wed, 29 May 2024 09:51:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WT6sN5z6VmYfAwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 29 May 2024 09:51:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A91D1A0825; Wed, 29 May 2024 11:51:16 +0200 (CEST)
Date: Wed, 29 May 2024 11:51:16 +0200
From: Jan Kara <jack@suse.cz>
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ext4: fix possible tid_t sequence overflows
Message-ID: <20240529095116.b3arzr5rjz6cs2rb@quack3>
References: <20240529092030.9557-1-luis.henriques@linux.dev>
 <20240529092030.9557-3-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529092030.9557-3-luis.henriques@linux.dev>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[mit.edu,dilger.ca,suse.cz,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,linux.dev:email]

On Wed 29-05-24 10:20:30, Luis Henriques (SUSE) wrote:
> In the fast commit code there are a few places where tid_t variables are
> being compared without taking into account the fact that these sequence
> numbers may wrap.  Fix this issue by using the helper functions tid_gt()
> and tid_geq().
> 
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>

Thanks! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/fast_commit.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 088bd509b116..30d312e16916 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -353,7 +353,7 @@ void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handl
>  		read_unlock(&sbi->s_journal->j_state_lock);
>  	}
>  	spin_lock(&sbi->s_fc_lock);
> -	if (sbi->s_fc_ineligible_tid < tid)
> +	if (tid_gt(tid, sbi->s_fc_ineligible_tid))
>  		sbi->s_fc_ineligible_tid = tid;
>  	spin_unlock(&sbi->s_fc_lock);
>  	WARN_ON(reason >= EXT4_FC_REASON_MAX);
> @@ -1207,7 +1207,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
>  	if (ret == -EALREADY) {
>  		/* There was an ongoing commit, check if we need to restart */
>  		if (atomic_read(&sbi->s_fc_subtid) <= subtid &&
> -			commit_tid > journal->j_commit_sequence)
> +		    tid_gt(commit_tid, journal->j_commit_sequence))
>  			goto restart_fc;
>  		ext4_fc_update_stats(sb, EXT4_FC_STATUS_SKIPPED, 0, 0,
>  				commit_tid);
> @@ -1282,7 +1282,7 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
>  		list_del_init(&iter->i_fc_list);
>  		ext4_clear_inode_state(&iter->vfs_inode,
>  				       EXT4_STATE_FC_COMMITTING);
> -		if (iter->i_sync_tid <= tid) {
> +		if (tid_geq(tid, iter->i_sync_tid)) {
>  			ext4_fc_reset_inode(&iter->vfs_inode);
>  		} else {
>  			/*
> @@ -1322,7 +1322,7 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
>  	list_splice_init(&sbi->s_fc_q[FC_Q_STAGING],
>  				&sbi->s_fc_q[FC_Q_MAIN]);
>  
> -	if (tid >= sbi->s_fc_ineligible_tid) {
> +	if (tid_geq(tid, sbi->s_fc_ineligible_tid)) {
>  		sbi->s_fc_ineligible_tid = 0;
>  		ext4_clear_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
>  	}
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

