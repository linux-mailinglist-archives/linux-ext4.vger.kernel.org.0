Return-Path: <linux-ext4+bounces-2644-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E32F38CE898
	for <lists+linux-ext4@lfdr.de>; Fri, 24 May 2024 18:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692D51F2243A
	for <lists+linux-ext4@lfdr.de>; Fri, 24 May 2024 16:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06E012EBC0;
	Fri, 24 May 2024 16:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O7OqNbK5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bhwwlCRS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kbwXvE8i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="85DicWDe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5379381BB;
	Fri, 24 May 2024 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716567760; cv=none; b=ipojXVoVkBCCzgFz1mDeUjT1FY8VpZeZK2BHChRmHGfzMzu0BCBvcgA/ywRLLrqfue+ZpkHKm0DLFHiJJTRbdFO9pnVeD2hs3LeKZfNY02yj+NkET0VlksTObAfeGdOAfMPdmlVV3UoLsIF/bjmSk5LS9OJM82/JLq8Ki49LrSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716567760; c=relaxed/simple;
	bh=iFZpV7CkR3cwZMbp91sg+RlX+hMKFzAL0gyw81GNBUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0T3dLM6/5t3YUAbvtRCkAWgWjdCXrkjkO4sqSpkBNZGOs9lwUxNG/6BPuS4H8GbxGmmVKkVLM4D7eY3x8cMNQc0kVHm/uoBgfUHoBLcvNDdCXZ3uPbod4SyKosEcexsfMsGLCjnPWY2sQ1O+3ybfaGR92KWCEt/62jEQ5jauQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O7OqNbK5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bhwwlCRS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kbwXvE8i; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=85DicWDe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E3FF720B84;
	Fri, 24 May 2024 16:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716567756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6LER4DlKj7/Cd1I076cZl4KFbNFaWY4zTJ12iLqvBP8=;
	b=O7OqNbK5EP1Cc8HsrsH0LCJXvyCMdg5eyC1ll618XZO13Qvu+4YhapEsIO6XTVraDkZunw
	M7P94uzBoHcA42oSfxDnNcpfTVgepPUSaogWj950H94MXJ+Xh2yfKptO3NChJC6jqIwU+f
	2Kaadr47Sz6Mh7LV9PAEnN349th+exs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716567756;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6LER4DlKj7/Cd1I076cZl4KFbNFaWY4zTJ12iLqvBP8=;
	b=bhwwlCRSlcV9iltxJeraomTiYEBDlnDbC6ue3GInmvep7ITGMVHKLGXqbndDFA9Y3YmOw5
	HU/gVf03e5g068Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716567755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6LER4DlKj7/Cd1I076cZl4KFbNFaWY4zTJ12iLqvBP8=;
	b=kbwXvE8iJQ8gjOf/v3bD2Nv33spVQdPFzIc1YDI0cvMDOybBCkPHpFeIAeYZq/aHbFgiS5
	KT/Y4Wy/OB7XJTwyVx6HK4JeElZOVp0tXqhHFti9amzYl1hONdRS3YSeCxcMPp4Y0j7siD
	XiyR85dqMwOixju2M3DogX3N9wA0lno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716567755;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6LER4DlKj7/Cd1I076cZl4KFbNFaWY4zTJ12iLqvBP8=;
	b=85DicWDea8JNcYFvJVLrrmlLyWmX93rTmKs5k5JiVh23MjVvvnMfN1JbfkHHJEHtAJq4fB
	HWdTNFrIEP8Y2LBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7EDD13A6B;
	Fri, 24 May 2024 16:22:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1gexNMu+UGbCUAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 24 May 2024 16:22:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 32F87A0825; Fri, 24 May 2024 18:22:31 +0200 (CEST)
Date: Fri, 24 May 2024 18:22:31 +0200
From: Jan Kara <jack@suse.cz>
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ext4: fix fast commit inode enqueueing during a full
 journal commit
Message-ID: <20240524162231.l5r4niz7awjgfju6@quack3>
References: <20240523111618.17012-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523111618.17012-1-luis.henriques@linux.dev>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]

On Thu 23-05-24 12:16:18, Luis Henriques (SUSE) wrote:
> When a full journal commit is on-going, any fast commit has to be enqueued
> into a different queue: FC_Q_STAGING instead of FC_Q_MAIN.  This enqueueing
> is done only once, i.e. if an inode is already queued in a previous fast
> commit entry it won't be enqueued again.  However, if a full commit starts
> _after_ the inode is enqueued into FC_Q_MAIN, the next fast commit needs to
> be done into FC_Q_STAGING.  And this is not being done in function
> ext4_fc_track_template().
> 
> This patch fixes the issue by flagging an inode that is already enqueued in
> either queues.  Later, during the fast commit clean-up callback, if the
> inode has a tid that is bigger than the one being handled, that inode is
> re-enqueued into STAGING and the spliced back into MAIN.
> 
> This bug was found using fstest generic/047.  This test creates several 32k
> bytes files, sync'ing each of them after it's creation, and then shutting
> down the filesystem.  Some data may be loss in this operation; for example a
> file may have it's size truncated to zero.
> 
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>

Thanks for the fix. Some comments below:

> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 983dad8c07ec..4c308c18c3da 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1062,9 +1062,18 @@ struct ext4_inode_info {
>  	/* Fast commit wait queue for this inode */
>  	wait_queue_head_t i_fc_wait;
>  
> -	/* Protect concurrent accesses on i_fc_lblk_start, i_fc_lblk_len */
> +	/*
> +	 * Protect concurrent accesses on i_fc_lblk_start, i_fc_lblk_len,
> +	 * i_fc_next
> +	 */
>  	struct mutex i_fc_lock;
>  
> +	/*
> +	 * Used to flag an inode as part of the next fast commit; will be
> +	 * reset during fast commit clean-up
> +	 */
> +	tid_t i_fc_next;
> +

Do we really need new tid in the inode? I'd be kind of hoping we could use
EXT4_I(inode)->i_sync_tid for this - I can see we even already set it in
ext4_fc_track_template() and used for similar comparisons in fast commit
code.

> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 87c009e0c59a..bfdf249f0783 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -402,6 +402,8 @@ static int ext4_fc_track_template(
>  				 sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING) ?
>  				&sbi->s_fc_q[FC_Q_STAGING] :
>  				&sbi->s_fc_q[FC_Q_MAIN]);
> +	else
> +		ei->i_fc_next = tid;
>  	spin_unlock(&sbi->s_fc_lock);
>  
>  	return ret;
> @@ -1280,6 +1282,15 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
>  	list_for_each_entry_safe(iter, iter_n, &sbi->s_fc_q[FC_Q_MAIN],
>  				 i_fc_list) {
>  		list_del_init(&iter->i_fc_list);
> +		if (iter->i_fc_next == tid)
> +			iter->i_fc_next = 0;
> +		else if (iter->i_fc_next > tid)
			 ^^^ careful here, TIDs do wrap so you need to use
tid_geq() for comparison.

> +			/*
> +			 * re-enqueue inode into STAGING, which will later be
> +			 * splice back into MAIN
> +			 */
> +			list_add_tail(&EXT4_I(&iter->vfs_inode)->i_fc_list,
> +				      &sbi->s_fc_q[FC_Q_STAGING]);
>  		ext4_clear_inode_state(&iter->vfs_inode,
>  				       EXT4_STATE_FC_COMMITTING);
>  		if (iter->i_sync_tid <= tid)
				     ^^^ and I can see this is buggy as
well and needs tid_geq() (not your fault obviously).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

