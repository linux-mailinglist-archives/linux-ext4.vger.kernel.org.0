Return-Path: <linux-ext4+bounces-3290-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBDC9323DB
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jul 2024 12:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E581F2177F
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Jul 2024 10:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9597143875;
	Tue, 16 Jul 2024 10:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rhgK4Cbd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CJzm1eEm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0CFuARiI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SGwN97yZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4B22BAF0;
	Tue, 16 Jul 2024 10:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721125466; cv=none; b=QNyqe+HqwmfTutYSjBm8clOe1ulnHZQS7Ql5znybPpBTHvBk+rVG+nHFeZekHeqVkYV9+Cnu9h7Sc53EJrkEhFXz+LcoSOQDGt7kDVLAFNprRIJYLRvUO2lnnU4hMVrqwmhTDSwiZwkVgUwbd7dENYIwwmxj7mrLK9CdkNfD+/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721125466; c=relaxed/simple;
	bh=NXOZnkekiyVsuIjOADrk+toWDiA2DAUH1u2Y3mUCJIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGx6Us6sshMZlB8mblTVoS25fHdcVg08PTy7G5RiuNZX2QLrJnHQs0YRR3aKsA4sma7CHllTzZE7dn/YBG4PDDOIu1YuhculO7AdqC7eH+JpOfiTiI/4nftqsmP5lhUnyJUf2hH6Cjp2ApMWnNsXRSCT2NsW/zlcWyd5X7BaJOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rhgK4Cbd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CJzm1eEm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0CFuARiI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SGwN97yZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7F0A31F8AC;
	Tue, 16 Jul 2024 10:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721125462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DPrOEKAiT+WpE+UHCR8Fkie45MEJdb7Gn9tKLiB19Es=;
	b=rhgK4CbdV6it233wlZQ1r2g2dvrd/no4/w8IIDiSMdf7+FLOIqdV3OX56LRogWijX+74gB
	iLjnIWNauEilhjyMe6wzzYPYJ+X2H8pjIgvX0I54Yk57RMzZuB8HX8ehjWflrxogTugYle
	XMAtAEN2mQJ1k+IoCi8Ua7tEU3H8KkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721125462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DPrOEKAiT+WpE+UHCR8Fkie45MEJdb7Gn9tKLiB19Es=;
	b=CJzm1eEmoXcYIMbpaT6pw8mgKfw1VNBoFCtWzsCs6D+NjqJ2xRZoOHReZpHH6+Q0dwJCUz
	HIRuBxovAfsaJXCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721125461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DPrOEKAiT+WpE+UHCR8Fkie45MEJdb7Gn9tKLiB19Es=;
	b=0CFuARiIsq6jMJJPpTcKeRRjpk/ZChpwgMEfIeQM8B2P2HhduJvuLyw0jbCjI5C0UpwdgV
	FX/5JDF/pPgDXrtF0IoVrJfkbOiK6w4opBwwtJecpN26lJ3tjTZF+vmi/51jSXCK1CDyDY
	XZx+AlyqTkKE6ov2hKD/7UTEYVPx2tk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721125461;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DPrOEKAiT+WpE+UHCR8Fkie45MEJdb7Gn9tKLiB19Es=;
	b=SGwN97yZiTtiQBK1FjWa+hoOQzOXtdqc5aLsGiIcUdqXOAXKESQPqCXeOtv2Opg5xbv5Mg
	Ig1A2a1rQLbtY8BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66D3F136E5;
	Tue, 16 Jul 2024 10:24:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IzrUGFVKlmYULgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 16 Jul 2024 10:24:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E28E6A0987; Tue, 16 Jul 2024 12:24:16 +0200 (CEST)
Date: Tue, 16 Jul 2024 12:24:16 +0200
From: Jan Kara <jack@suse.cz>
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ext4: fix fast commit inode enqueueing during a full
 journal commit
Message-ID: <20240716102416.jublpma3qiltlrbr@quack3>
References: <20240711083520.6751-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711083520.6751-1-luis.henriques@linux.dev>
X-Spam-Flag: NO
X-Spam-Score: 0.20
X-Spamd-Result: default: False [0.20 / 50.00];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[mit.edu,dilger.ca,suse.cz,gmail.com,vger.kernel.org];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,linux.dev:email]
X-Spam-Level: 

On Thu 11-07-24 09:35:20, Luis Henriques (SUSE) wrote:
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

...

> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 3926a05eceee..facbc8dbbaa2 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -1290,6 +1290,16 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
>  				       EXT4_STATE_FC_COMMITTING);
>  		if (tid_geq(tid, iter->i_sync_tid))
>  			ext4_fc_reset_inode(&iter->vfs_inode);
> +		} else if (tid) {
> +			/*
> +			 * If the tid is valid (i.e. non-zero) re-enqueue the
> +			 * inode into STAGING, which will then be splice back
> +			 * into MAIN
> +			 */
> +			list_add_tail(&EXT4_I(&iter->vfs_inode)->i_fc_list,
> +				      &sbi->s_fc_q[FC_Q_STAGING]);
> +		}

I don't think this is going to work (even if we fix the tid 0 being special
assumption). With this there would be a race like:

Task 1					Task2
modify inode I
ext4_fc_commit()
  jbd2_fc_begin_commit()
  commits changes
  jbd2_fc_end_commit()
    __jbd2_fc_end_commit(journal, 0, false)
      jbd2_journal_unlock_updates(journal)
					jbd2_journal_start()
					modify inode I
					...
					ext4_mark_iloc_dirty()
					  ext4_fc_track_inode()
					    ext4_fc_track_template()
					      - doesn't add inode anywhere
					      because i_fc_list is not empty
      ext4_fc_cleanup(journal, 0, 0)
        removes inode I from i_fc_list => next fastcommit will not properly
flush it.

To avoid this race I think we could move the
journal->j_fc_cleanup_callback() call to happen before we call
jbd2_journal_unlock_updates(). Then we are sure that inode cannot be
modified (journal is locked) until we are done processing the fastcommit
lists when doing fastcommit. Hence your patch could then be changed like:

+		} else if (full) {
+			/*
+			 * We are called after a full commit, inode has been
+			 * modified while the commit was running. Re-enqueue
+			 * the inode into STAGING, which will then be splice
+			 * back into MAIN. This cannot happen during
+			 * fastcommit because the journal is locked all the
+			 * time in that case (and tid doesn't increase so
+			 * tid check above isn't reliable).
+			 */
+			list_add_tail(&EXT4_I(&iter->vfs_inode)->i_fc_list,
+				      &sbi->s_fc_q[FC_Q_STAGING]);
+		}

Later, Harshad's patches change the code to use EXT4_STATE_FC_COMMITTING
for protecting inodes during fastcommit and that will also deal with these
races without having to keep the whole journal locked.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

