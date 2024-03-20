Return-Path: <linux-ext4+bounces-1715-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CC9881171
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Mar 2024 13:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7E291C230F1
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Mar 2024 12:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA21A3F9F8;
	Wed, 20 Mar 2024 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZpVb0LnH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eaJcA+HE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZpVb0LnH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eaJcA+HE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B99E3FB9E;
	Wed, 20 Mar 2024 12:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710936207; cv=none; b=KWSL7UmShtvVX3fU3Xvsi7zGWYkYi9ZPUxGPqTxjqrDedZdF7g8qGLtON8vrLMY0ONJ5/SkS7uDD/1r1eGgnEG34gnD9b2+qaFPVpsKb4dSoIq2l0JgNjgKLn3NA0BD9vwsGY0kctXR+GtYUX0Pg9vG2DZmt3kJU6u+Ux3r1pUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710936207; c=relaxed/simple;
	bh=sopO1fpSfjTzw3a42axKs81IPvXYntCtDX23loN5684=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lE9jMAXvOuZ8QcEmRHorOFN9p5WIc268g3rli3OJYrkU+phzNkE4domdHcasdXbwQkUDFpjxm6vwI4TXz5k15AtZGpPSSVPak7R9K3y4Do5KciXNfFCqMhP5R8YHaO5tGuzjRmQ6qQLPzmTCChyCfeqOqPva94Y9MOKPTx81jn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZpVb0LnH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eaJcA+HE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZpVb0LnH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eaJcA+HE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 23BF020EC3;
	Wed, 20 Mar 2024 12:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710936200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s4XwlyAiD3Ez2lefEC8xe8BeNwhre0ktqIglnQH0J1Y=;
	b=ZpVb0LnHlr+OHc4X/JEiIqAPuv2U3EpiCeIv20nhTu/nnJfDFy9td7IrJws3Tqe5tQ/CXU
	AIKWRIgsflfnPBMqkaQztTzTF1Mht0lcsdzrffvWE4PLRM1BAXfgCcDR06QOM/5V2ezm9X
	O/X6KqmmY7PrQj5ea46OYVlfBhlhoNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710936200;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s4XwlyAiD3Ez2lefEC8xe8BeNwhre0ktqIglnQH0J1Y=;
	b=eaJcA+HEexDkm2lTwb1S1HSb8Z7+4nxwnoU6s/jhSarmzb3eeR1bk3CSRH5eR2pXiWa9V2
	sX2YrD8gW4e0OICw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710936200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s4XwlyAiD3Ez2lefEC8xe8BeNwhre0ktqIglnQH0J1Y=;
	b=ZpVb0LnHlr+OHc4X/JEiIqAPuv2U3EpiCeIv20nhTu/nnJfDFy9td7IrJws3Tqe5tQ/CXU
	AIKWRIgsflfnPBMqkaQztTzTF1Mht0lcsdzrffvWE4PLRM1BAXfgCcDR06QOM/5V2ezm9X
	O/X6KqmmY7PrQj5ea46OYVlfBhlhoNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710936200;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s4XwlyAiD3Ez2lefEC8xe8BeNwhre0ktqIglnQH0J1Y=;
	b=eaJcA+HEexDkm2lTwb1S1HSb8Z7+4nxwnoU6s/jhSarmzb3eeR1bk3CSRH5eR2pXiWa9V2
	sX2YrD8gW4e0OICw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18A46136D6;
	Wed, 20 Mar 2024 12:03:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uF7/BYjQ+mWpDAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 20 Mar 2024 12:03:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BF088A07D6; Wed, 20 Mar 2024 13:03:19 +0100 (CET)
Date: Wed, 20 Mar 2024 13:03:19 +0100
From: Jan Kara <jack@suse.cz>
To: Jongseok Kim <ks77sj@gmail.com>
Cc: tytso@mit.edu, jack@suse.com, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: remove checks for data=ordered and
 journal_async_commit options
Message-ID: <20240320120319.4zsbzgehz4swdisr@quack3>
References: <20240320105808.1184826-1-ks77sj@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320105808.1184826-1-ks77sj@gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

On Wed 20-03-24 19:58:08, Jongseok Kim wrote:
> On Tue, Nov 25, 2014 at 04:56:15PM +0100, Jan Kara wrote:
> > Option journal_async_commit breaks gurantees of data=ordered mode as it
> > sends only a single cache flush after writing a transaction commit
> > block. Thus even though the transaction including the commit block is
> > fully stored on persistent storage, file data may still linger in drives
> > caches and will be lost on power failure. Since all checksums match on
> > journal recovery, we replay the transaction thus possibly exposing stale
> > user data.
> >
> > To fix this data exposure issue, remove the possibility to use
> > journal_async_commit in data=ordered mode.
> >
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> In employing the journal_async_commit feature, the approach involves
> slightly early submission of a request for a transaction commit block
> without the inclusion of PREFLUSH and FUA. Instead, once all the blocks of
> the transaction have been written, the journal device is flushed once.
> This methodology, even under data=ordered mode, due to the procedure of
> flushing the j_fs_dev, guarantees that the file data is permanently stored
> by the time the commit block request is initiated.
> 
> This discussion pertains to scenarios where the file data device and
> the journal device are distinct. If the devices are the same,
> then all file data is written before the flush of the journal device,
> making a single flush sufficient in this context.
> 
> Consequently, it remains entirely permissible to activate
> the journal_async_commit option, even when operating in ordered mode.

So I agree that when journal is on a different device jbd2 will flush the
data device before writing commit record so we are safe in data=ordered
mode even with async commit. Good idea. But:

1) For dealing with this complication we need to have a sensible usecase.
Do you have performance numbers from this combination that show async
commit brings noticeable performance benefit? Please include them in the
changelog.

2) The code should make sure we are really using external journal device
before allowing async commit in data=ordered mode.

Thanks!

								Honza


> Should my interpretation deviate in any manner,
> I earnestly request your guidance and correction.
> 
> Signed-off-by: Jongseok Kim <ks77sj@gmail.com>
> ---
>  fs/ext4/super.c | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index cfb8449c731f..2141c2eb4bf0 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4954,13 +4954,6 @@ static int ext4_load_and_init_journal(struct super_block *sb,
>  		break;
>  	}
>  
> -	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_ORDERED_DATA &&
> -	    test_opt(sb, JOURNAL_ASYNC_COMMIT)) {
> -		ext4_msg(sb, KERN_ERR, "can't mount with "
> -			"journal_async_commit in data=ordered mode");
> -		goto out;
> -	}
> -
>  	set_task_ioprio(sbi->s_journal->j_task, ctx->journal_ioprio);
>  
>  	sbi->s_journal->j_submit_inode_data_buffers =
> @@ -6510,13 +6503,6 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
>  			err = -EINVAL;
>  			goto restore_opts;
>  		}
> -	} else if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_ORDERED_DATA) {
> -		if (test_opt(sb, JOURNAL_ASYNC_COMMIT)) {
> -			ext4_msg(sb, KERN_ERR, "can't mount with "
> -				"journal_async_commit in data=ordered mode");
> -			err = -EINVAL;
> -			goto restore_opts;
> -		}
>  	}
>  
>  	if ((sbi->s_mount_opt ^ old_opts.s_mount_opt) & EXT4_MOUNT_NO_MBCACHE) {
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

