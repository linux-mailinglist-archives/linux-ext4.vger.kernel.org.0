Return-Path: <linux-ext4+bounces-3022-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2154F91C10A
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Jun 2024 16:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB511F21A84
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Jun 2024 14:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F821C0046;
	Fri, 28 Jun 2024 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BB/uVNTb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lxoh0rmg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rWqbGmrb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aNqPihL7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7126B645
	for <linux-ext4@vger.kernel.org>; Fri, 28 Jun 2024 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719585223; cv=none; b=RX0Jzfc19/k/+/ODY1OaOhm52jipCbol1K2cKQf/SWEg4fsNUf7vldlziM3g2hJNaD9VU0wj6xL4nWKoT4Oy0BPRhGrldsQ0UXzuPm7w/mAn6To2tYM/bH3q9PVU/BaXnlK9h0vI3c1tG6CiNeluAc9Pk/EMZyf2dRkNllumWPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719585223; c=relaxed/simple;
	bh=/RH7kNFBMtFaRlNvjb5v6QiejmiYZBHSAiueJ9JHYAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/DXzPSSe+d0hEns3+18sJI/ruZN80R0hx8NUXJ4Sabhl2Af197GHYsHL1CeOJOFKBxgMLIhmJ7wo10lMYrCyZeJnh5DUpXHiQec65VpS02FC0T1u06bnXp6j/CGfP7dI2FcUD2/19M44YCH1ew+bvFehxbRNkjAfb5r8OkNKig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BB/uVNTb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lxoh0rmg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rWqbGmrb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aNqPihL7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CBE601F454;
	Fri, 28 Jun 2024 14:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719585220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4/7TubeuunFoGnRuHNiu+8onzafZNkH8UZPl4ORZ8FI=;
	b=BB/uVNTbn12VoGEvCyCr0XWZY3OBAcZTxRstP+4yARWvezm1p74dxV5CxNl60xWVU6YnvM
	CZtDdpD1CHWGOQo23tuTcPmqzQHGSijQvHUdM10GmtC97XTnuLwvxHGNwEm+UKKEum2Kvp
	RWQXnPDpI4aIFjy+uAuVB+Gfr8UK7ts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719585220;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4/7TubeuunFoGnRuHNiu+8onzafZNkH8UZPl4ORZ8FI=;
	b=lxoh0rmg3WHtIDYg2mHoTWpo3ENPxEg4DkMBCdwnjCOWtdNuYd3qpG3cL5Wrs10MNc9Yxv
	2EukgoPpM6Qr+rBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719585218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4/7TubeuunFoGnRuHNiu+8onzafZNkH8UZPl4ORZ8FI=;
	b=rWqbGmrb2LYdsxYV9O2HjZDl0JpeVki2uAOuQHp1tDHJkxe1vA2vlzEovVSUDpbaKS84uO
	+XbwpmpBaQRG0uJYnrhtaMjOxH9Hq/0O4CEMDrZvtPevrRjOtsa4QHJsvC1AEiJ4/sPtu0
	QpbIdRCxYepxT6/oW84/++g+LeJAT1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719585218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4/7TubeuunFoGnRuHNiu+8onzafZNkH8UZPl4ORZ8FI=;
	b=aNqPihL7WUI3Sx3ETQsfEESW+inb168SX0dBxWQ0sU5h8SeQ+aTKJxxjTbY7mx55+dTSDA
	5YToL46eEpg5oDDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF0D913375;
	Fri, 28 Jun 2024 14:33:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PeecLsLJfmb2FAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 28 Jun 2024 14:33:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 539CEA088E; Fri, 28 Jun 2024 16:33:38 +0200 (CEST)
Date: Fri, 28 Jun 2024 16:33:38 +0200
From: Jan Kara <jack@suse.cz>
To: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, saukad@google.com,
	harshads@google.com
Subject: Re: [PATCH v6 08/10] ext4: introduce selective flushing in fast
 commit
Message-ID: <20240628143338.gqsza77qqnlyazgc@quack3>
References: <20240529012003.4006535-1-harshadshirwadkar@gmail.com>
 <20240529012003.4006535-9-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529012003.4006535-9-harshadshirwadkar@gmail.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Wed 29-05-24 01:20:01, Harshad Shirwadkar wrote:
> With fast commits, if the entire commit is contained within a single
> block and there isn't any data that needs a flush, we can avoid sending
> expensive cache flush to disk. Single block metadata only fast commits
> can be written using FUA to guarantee consistency.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> ---
>  fs/ext4/ext4.h        | 12 ++++++++++++
>  fs/ext4/ext4_jbd2.h   | 20 ++++++++++++--------
>  fs/ext4/fast_commit.c | 23 ++++++++++++++++++-----
>  3 files changed, 42 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 196c513f82dd..3721daea2890 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1744,6 +1744,13 @@ struct ext4_sb_info {
>  					 */
>  	struct list_head s_fc_dentry_q[2];	/* directory entry updates */
>  	unsigned int s_fc_bytes;
> +
> +	/*
> +	 * This flag indicates whether a full flush is needed on
> +	 * next fast commit.
> +	 */
> +	int fc_flush_required;

I think this storing of fastcommit specific info in the superblock is a bad
practice and actually leads to subtle bugs (see below). I believe you
should have a dedicated structure tracking the fast commit info (and you
would actually have two of them - for the running and the committing fast
transaction).

> @@ -2905,6 +2912,11 @@ void ext4_fc_del(struct inode *inode);
>  bool ext4_fc_replay_check_excluded(struct super_block *sb, ext4_fsblk_t block);
>  void ext4_fc_replay_cleanup(struct super_block *sb);
>  int ext4_fc_commit(journal_t *journal, tid_t commit_tid);
> +static inline void ext4_fc_mark_needs_flush(struct super_block *sb)
> +{
> +	EXT4_SB(sb)->fc_flush_required = 1;
> +}
> +
>  int __init ext4_fc_init_dentry_cache(void);
>  void ext4_fc_destroy_dentry_cache(void);
>  int ext4_fc_record_regions(struct super_block *sb, int ino,
> diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
> index 0c77697d5e90..e3a4f5c49b6e 100644
> --- a/fs/ext4/ext4_jbd2.h
> +++ b/fs/ext4/ext4_jbd2.h
> @@ -420,19 +420,23 @@ static inline int ext4_journal_force_commit(journal_t *journal)
>  static inline int ext4_jbd2_inode_add_write(handle_t *handle,
>  		struct inode *inode, loff_t start_byte, loff_t length)
>  {
> -	if (ext4_handle_valid(handle))
> -		return jbd2_journal_inode_ranged_write(handle,
> -				EXT4_I(inode)->jinode, start_byte, length);
> -	return 0;
> +	if (!ext4_handle_valid(handle))
> +		return 0;
> +
> +	ext4_fc_mark_needs_flush(inode->i_sb);
> +	return jbd2_journal_inode_ranged_write(handle,
> +			EXT4_I(inode)->jinode, start_byte, length);
>  }

I think this handling of fc_flush_required introduces a subtle bug. While
fast commit is running, next transaction can be already running in parallel
and thus set fc_flush_required = 1. When fast commit completes, it does
cache flush and sets fc_flush_required = 0. But the data added here in
ext4_jbd2_inode_add_write() is not written out yet so the cache flush
didn't include them and the next fast commit need not flush caches causing
subtle data integrity issues after power failure.

I actually think it will be much less error prone if you track whether we
need to flush or not while writing out the fast commit to the journal. No
need to track it early when things are just being added to the transaction.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

