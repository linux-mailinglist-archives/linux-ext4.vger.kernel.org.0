Return-Path: <linux-ext4+bounces-3023-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 453ED91C14C
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Jun 2024 16:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCC3F1F24CD7
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Jun 2024 14:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2601C006C;
	Fri, 28 Jun 2024 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V+PGma0C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a8bBszsi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V+PGma0C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a8bBszsi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E576155321
	for <linux-ext4@vger.kernel.org>; Fri, 28 Jun 2024 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719585754; cv=none; b=MRFgAi7sg/KuSLtpQWG8lAVDQiIcThbHiUAf7IO2HjV/mnDksruVz+3HB69JF9v8dtmXS5/oZaQ58rs2fRcH9VIdRnD0jeGVCAHgK5i4j/9NMD9xc2bO76VBn67N5blHkvPkb74yM3KG/kZSrmGPVKz/WETgi+a03Q3QgtyvurQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719585754; c=relaxed/simple;
	bh=KITFxYNfZFGr53zpp9Ujj+PM6gLPPjygpfttCC4fXmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0i7eHIPQJXvJrMlc/k22cgKtEy97yZrnFNbBqflNhVkfeZ1PaYD+7SJkb9RRGLwJMBqDSrf/be6NChjSKLpss+yVBlNWJjIj4cFCCoU0ve6gAuT2qlQe3Kl01fYVwQfxmCCUyekkubBzAjAmZKaXlVKVf89+vOl6TLLXU+BRg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V+PGma0C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a8bBszsi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V+PGma0C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a8bBszsi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 868D221B25;
	Fri, 28 Jun 2024 14:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719585750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sjE40CyeZPBFBx5s7g4DThQ+RZll0+QKTyOQRPcwEIY=;
	b=V+PGma0CLQdftDEAI4jOXa3DnwhoR8c70kmQZiHSDFFDHq6A9eMmAnNcZ728pnhxReEqBQ
	iKiUjaICxyDe+AAgtzb9RtJLDMJvzoXpJhLRr9/6ipy8TqWFsZMEAc8GM4ABes/mRbvcEi
	9TQbHSNdvz7HUd6H4AqJWJwxaPG0aek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719585750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sjE40CyeZPBFBx5s7g4DThQ+RZll0+QKTyOQRPcwEIY=;
	b=a8bBszsiFsTqn7Bmh21XriiamItyoMweFXDp3JZJkDYnJAMa6W1iRC9SLkWidL58wvPzVV
	Ejk5NMYdJZppDgDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=V+PGma0C;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=a8bBszsi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719585750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sjE40CyeZPBFBx5s7g4DThQ+RZll0+QKTyOQRPcwEIY=;
	b=V+PGma0CLQdftDEAI4jOXa3DnwhoR8c70kmQZiHSDFFDHq6A9eMmAnNcZ728pnhxReEqBQ
	iKiUjaICxyDe+AAgtzb9RtJLDMJvzoXpJhLRr9/6ipy8TqWFsZMEAc8GM4ABes/mRbvcEi
	9TQbHSNdvz7HUd6H4AqJWJwxaPG0aek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719585750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sjE40CyeZPBFBx5s7g4DThQ+RZll0+QKTyOQRPcwEIY=;
	b=a8bBszsiFsTqn7Bmh21XriiamItyoMweFXDp3JZJkDYnJAMa6W1iRC9SLkWidL58wvPzVV
	Ejk5NMYdJZppDgDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A3D01373E;
	Fri, 28 Jun 2024 14:42:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0hLQHdbLfmZ6FwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 28 Jun 2024 14:42:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 18557A0887; Fri, 28 Jun 2024 16:42:30 +0200 (CEST)
Date: Fri, 28 Jun 2024 16:42:30 +0200
From: Jan Kara <jack@suse.cz>
To: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, saukad@google.com,
	harshads@google.com
Subject: Re: [PATCH v6 09/10] ext4: temporarily elevate commit thread priority
Message-ID: <20240628144230.cknr266ckzyjmtry@quack3>
References: <20240529012003.4006535-1-harshadshirwadkar@gmail.com>
 <20240529012003.4006535-10-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529012003.4006535-10-harshadshirwadkar@gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 868D221B25
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Wed 29-05-24 01:20:02, Harshad Shirwadkar wrote:
> Unlike JBD2 based full commits, there is no dedicated journal thread
> for fast commits. Thus to reduce scheduling delays between IO
> submission and completion, temporarily elevate the committer thread's
> priority to match the configured priority of the JBD2 journal
> thread.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

This makes some sense although I'd note that io priority is getting less
and less use these days since IO is now mostly controlled through cgroup
controllers and they don't give a damn about IO priority. E.g. blk-iocost
controller uses bio_issue_as_root_blkg() (which boils down to bio->bi_opf &
(REQ_META | REQ_SWAP)) to determine whether it should avoid throttling IOs
to avoid priority inversion (exactly the case of fast-commit). So I think
properly annotating journal IO with REQ_META will bring much more tangible
benefit in common configurations that bother to control IO and then this
needn't be even needed. But I'm not really opposed either so feel free to
add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h        |  4 +++-
>  fs/ext4/fast_commit.c | 13 +++++++++++++
>  fs/ext4/super.c       |  5 ++---
>  3 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 3721daea2890..d52df8a85271 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2287,10 +2287,12 @@ static inline int ext4_forced_shutdown(struct super_block *sb)
>  #define EXT4_DEFM_NODELALLOC	0x0800
>  
>  /*
> - * Default journal batch times
> + * Default journal batch times and ioprio.
>   */
>  #define EXT4_DEF_MIN_BATCH_TIME	0
>  #define EXT4_DEF_MAX_BATCH_TIME	15000 /* 15ms */
> +#define EXT4_DEF_JOURNAL_IOPRIO (IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, 3))
> +
>  
>  /*
>   * Minimum number of groups in a flexgroup before we separate out
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 35c89bee452c..55a13d3ff681 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -1205,6 +1205,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
>  	int subtid = atomic_read(&sbi->s_fc_subtid);
>  	int status = EXT4_FC_STATUS_OK, fc_bufs_before = 0;
>  	ktime_t start_time, commit_time;
> +	int old_ioprio, journal_ioprio;
>  
>  	if (!test_opt2(sb, JOURNAL_FAST_COMMIT))
>  		return jbd2_complete_transaction(journal, commit_tid);
> @@ -1212,6 +1213,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
>  	trace_ext4_fc_commit_start(sb, commit_tid);
>  
>  	start_time = ktime_get();
> +	old_ioprio = get_current_ioprio();
>  
>  restart_fc:
>  	ret = jbd2_fc_begin_commit(journal, commit_tid);
> @@ -1242,6 +1244,15 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
>  		goto fallback;
>  	}
>  
> +	/*
> +	 * Now that we know that this thread is going to do a fast commit,
> +	 * elevate the priority to match that of the journal thread.
> +	 */
> +	if (journal->j_task->io_context)
> +		journal_ioprio = sbi->s_journal->j_task->io_context->ioprio;
> +	else
> +		journal_ioprio = EXT4_DEF_JOURNAL_IOPRIO;
> +	set_task_ioprio(current, journal_ioprio);
>  	fc_bufs_before = (sbi->s_fc_bytes + bsize - 1) / bsize;
>  	ret = ext4_fc_perform_commit(journal);
>  	if (ret < 0) {
> @@ -1256,6 +1267,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
>  	}
>  	atomic_inc(&sbi->s_fc_subtid);
>  	ret = jbd2_fc_end_commit(journal);
> +	set_task_ioprio(current, old_ioprio);
>  	/*
>  	 * weight the commit time higher than the average time so we
>  	 * don't react too strongly to vast changes in the commit time
> @@ -1265,6 +1277,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
>  	return ret;
>  
>  fallback:
> +	set_task_ioprio(current, old_ioprio);
>  	ret = jbd2_fc_end_commit_fallback(journal);
>  	ext4_fc_update_stats(sb, status, 0, 0, commit_tid);
>  	return ret;
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 77173ec91e49..18d9d2631559 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1833,7 +1833,6 @@ static const struct fs_parameter_spec ext4_param_specs[] = {
>  	{}
>  };
>  
> -#define DEFAULT_JOURNAL_IOPRIO (IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, 3))
>  
>  #define MOPT_SET	0x0001
>  #define MOPT_CLEAR	0x0002
> @@ -5211,7 +5210,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  
>  	/* Set defaults for the variables that will be set during parsing */
>  	if (!(ctx->spec & EXT4_SPEC_JOURNAL_IOPRIO))
> -		ctx->journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
> +		ctx->journal_ioprio = EXT4_DEF_JOURNAL_IOPRIO;
>  
>  	sbi->s_inode_readahead_blks = EXT4_DEF_INODE_READAHEAD_BLKS;
>  	sbi->s_sectors_written_start =
> @@ -6471,7 +6470,7 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
>  			ctx->journal_ioprio =
>  				sbi->s_journal->j_task->io_context->ioprio;
>  		else
> -			ctx->journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
> +			ctx->journal_ioprio = EXT4_DEF_JOURNAL_IOPRIO;
>  
>  	}
>  
> -- 
> 2.45.1.288.g0e0cd299f1-goog
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

