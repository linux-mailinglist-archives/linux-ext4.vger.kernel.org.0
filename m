Return-Path: <linux-ext4+bounces-2664-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6308B8D18AD
	for <lists+linux-ext4@lfdr.de>; Tue, 28 May 2024 12:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71411F2269F
	for <lists+linux-ext4@lfdr.de>; Tue, 28 May 2024 10:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5E316B72D;
	Tue, 28 May 2024 10:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N/gr3ipg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0hdfF0cT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gl8IA2xk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qflg+ggn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DD416A39F;
	Tue, 28 May 2024 10:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716892566; cv=none; b=iKRlRmp2sErXcYnTbdW01pZNzppdTlGPmdehFjIVdKyhRjYhSPPsBBbtLrO6o/GXjajXMaqrTFyzF4yJOgthZFayB8s9QmGUVPHTSSBk0bzDZBOk8Ih164SYG9XGAuoiydHEFPbv9uzFn5TetD9jBl8/2Fz+iaaMTHTnXFQ7agQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716892566; c=relaxed/simple;
	bh=e4Tacb0g7ItBREbXUIbltXpa3GLPXxhz5nKnawPTpfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbA/TrkWEw7Qv2dDmg8W9M/BEDx9BP54CwxSltT3x1HGei+Ea8SBdn1rBNbfRWeFSuYFX9izRPkaKd2EBxeIkZsbTBBqPAFT3L4AKfNYSlKijoX4bsmhaTxjFqooHQpZ7aHarYlaSjDYgXsY3fXc0M/gpxLG0XC4dMPgflaon/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N/gr3ipg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0hdfF0cT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gl8IA2xk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qflg+ggn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F119122775;
	Tue, 28 May 2024 10:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716892563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qswTp52Q9fxeW+fWSCeNmwF/WH060c+KKNXM6cNFzgQ=;
	b=N/gr3ipgbrnaZzs9HUtmm2xDkyon6q2BFjjv/XgFokicH4j5+kL3pcFeNMBAMfFckBrlBG
	4E5M4FnhIHImpzNESnx/84bpKGeor4BXWoYxQ8PhUXN1eiWGHGPuxdwnawugY71626uxBA
	0s2KansAhoxlWmcg4ceRjpaFdhQmo8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716892563;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qswTp52Q9fxeW+fWSCeNmwF/WH060c+KKNXM6cNFzgQ=;
	b=0hdfF0cTtCgpqaAesTh59M+RThjdrpl3omy1XS9cKVYDLWntakEBccCvXh5A6Xw7wd6Rga
	Hft6mmAgmCVYN9BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716892562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qswTp52Q9fxeW+fWSCeNmwF/WH060c+KKNXM6cNFzgQ=;
	b=gl8IA2xkjObeKSquUIUWPUyzj727NIeD9GtbFxw1/2JtvbHivE3PtfZXuU5qXb0rR6HRc1
	DP+0KjLAWLwD6atHbUSqoHqLN47LAxNQndhsn8EbSxD3mQXd1pluQlqgB95HTfRsVNoVHV
	FzhozAJXUi2LVG3OKf7TzlwRBCkrGEI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716892562;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qswTp52Q9fxeW+fWSCeNmwF/WH060c+KKNXM6cNFzgQ=;
	b=qflg+ggnXI/6lafeohjutN42qKYRv6X1AAe6F6Zj7I5MiUJfJnnRCDdv60SIyPt89D6UDz
	/xwcecfc9eUEyiAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6D7813A6B;
	Tue, 28 May 2024 10:36:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C71WOJKzVWbeLwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 28 May 2024 10:36:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9301FA07D0; Tue, 28 May 2024 12:36:02 +0200 (CEST)
Date: Tue, 28 May 2024 12:36:02 +0200
From: Jan Kara <jack@suse.cz>
To: Luis Henriques <luis.henriques@linux.dev>
Cc: Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ext4: fix fast commit inode enqueueing during a full
 journal commit
Message-ID: <20240528103602.akx2gui5ownj25l3@quack3>
References: <20240523111618.17012-1-luis.henriques@linux.dev>
 <20240524162231.l5r4niz7awjgfju6@quack3>
 <87h6ej64jv.fsf@brahms.olymp>
 <87msob45o7.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87msob45o7.fsf@brahms.olymp>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.cz,mit.edu,dilger.ca,gmail.com,vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]

On Mon 27-05-24 16:48:24, Luis Henriques wrote:
> On Mon 27 May 2024 09:29:40 AM +01, Luis Henriques wrote;
> >>> +	/*
> >>> +	 * Used to flag an inode as part of the next fast commit; will be
> >>> +	 * reset during fast commit clean-up
> >>> +	 */
> >>> +	tid_t i_fc_next;
> >>> +
> >>
> >> Do we really need new tid in the inode? I'd be kind of hoping we could use
> >> EXT4_I(inode)->i_sync_tid for this - I can see we even already set it in
> >> ext4_fc_track_template() and used for similar comparisons in fast commit
> >> code.
> >
> > Ah, true.  It looks like it could be used indeed.  We'll still need a flag
> > here, but a simple bool should be enough for that.
> 
> After looking again at the code, I'm not 100% sure that this is actually
> doable.  For example, if I replace the above by
> 
> 	bool i_fc_next;
> 
> and set to to 'true' below:
> 
> >>> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> >>> index 87c009e0c59a..bfdf249f0783 100644
> >>> --- a/fs/ext4/fast_commit.c
> >>> +++ b/fs/ext4/fast_commit.c
> >>> @@ -402,6 +402,8 @@ static int ext4_fc_track_template(
> >>>  				 sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING) ?
> >>>  				&sbi->s_fc_q[FC_Q_STAGING] :
> >>>  				&sbi->s_fc_q[FC_Q_MAIN]);
> >>> +	else
> >>> +		ei->i_fc_next = tid;
> 
> 		ei->i_fc_next = true;
> 
> Then, when we get to the ext4_fc_cleanup(), the value of iter->i_sync_tid
> may have changed in the meantime from, e.g., ext4_do_update_inode() or
> __ext4_iget().  This would cause the clean-up code to be bogus if it still
> implements a the logic below, by comparing the tid with i_sync_tid.
> (Although, to be honest, I couldn't see any visible effect in the quick
> testing I've done.)  Or am I missing something, and this is *exactly* the
> behaviour you'd expect?

Yes, this is the behavior I'd expect. The rationale is that if i_sync_tid
points to the running transaction, it means the inode was modified in it,
which means fastcommit needs to write it out. In fact the
ext4_update_inode_fsync_trans() calls usually happen together with
ext4_fc_track_...() calls. This could use some cleanup so that we don't set
i_sync_tid in two places unnecessarily but that's for some other time...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

