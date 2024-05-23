Return-Path: <linux-ext4+bounces-2634-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB688CCD3C
	for <lists+linux-ext4@lfdr.de>; Thu, 23 May 2024 09:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB0E81C2128A
	for <lists+linux-ext4@lfdr.de>; Thu, 23 May 2024 07:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CA413CA81;
	Thu, 23 May 2024 07:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dJsGiVzE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bT/5Rrsi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dJsGiVzE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bT/5Rrsi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2F513BAFE;
	Thu, 23 May 2024 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716450278; cv=none; b=D1zKO9Rp2QdNNUl4KXf1PafLzKqQF7Auz7uYoowfjrWvIYnSC7gu7VjhEN9J0YMA5xuLPXiBhV+X2+nV6CyGC7XrYF77UxkvZq7IwyCsxlucAqI4LBMnkC7/19RV5EDSdeDaHcnKuGd4Qwlio+sU3FFauoLouEPb1pWhMQd2KCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716450278; c=relaxed/simple;
	bh=FkWsxJsUCyg1I1EBmpnZ1Cou5Ibt2llv0P05zVskbQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+WxrZXi2Hjeb1cYpVmidyWHhzO59o0a45DX0k0bKt2wVEyFz9zrjLxFB3MvTz8L8NwK4BQEhqrk4kVWwEI2Oe2GLb0+1SLV1NLPwIgVGBUPmjHMDLa7bgSxY1UNtMSuTY+3CR05nMA3bqxfOrSNF8L9et245olgHu9aRb0G5DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dJsGiVzE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bT/5Rrsi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dJsGiVzE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bT/5Rrsi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2C68022304;
	Thu, 23 May 2024 07:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716450275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k6MvdHoOp3ina+pl85dJt5etpS6R/rzn9r2h6GRkL34=;
	b=dJsGiVzE043vdPvF4XLVfB5hlmA/ithXT7afY8YwAHGeyGprQrSflsExWko89JrJ63Gr9w
	4+QQqZkPc9H0P13yjs64fJKfj+09eEadCMHatDLH9UuKS3pfBCDgDtXPICVn4CNi+sW6m7
	C7LQcHD9MQqNK5nBJqlOtO9UlvH2DpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716450275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k6MvdHoOp3ina+pl85dJt5etpS6R/rzn9r2h6GRkL34=;
	b=bT/5RrsiU6NftYlREQoYHQLi5BsfvsUU8yytLUnWOVjgTc9r1KYYfLvKO02SdCS/ZISl7z
	eeIqBWDJTZ3KUPCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716450275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k6MvdHoOp3ina+pl85dJt5etpS6R/rzn9r2h6GRkL34=;
	b=dJsGiVzE043vdPvF4XLVfB5hlmA/ithXT7afY8YwAHGeyGprQrSflsExWko89JrJ63Gr9w
	4+QQqZkPc9H0P13yjs64fJKfj+09eEadCMHatDLH9UuKS3pfBCDgDtXPICVn4CNi+sW6m7
	C7LQcHD9MQqNK5nBJqlOtO9UlvH2DpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716450275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k6MvdHoOp3ina+pl85dJt5etpS6R/rzn9r2h6GRkL34=;
	b=bT/5RrsiU6NftYlREQoYHQLi5BsfvsUU8yytLUnWOVjgTc9r1KYYfLvKO02SdCS/ZISl7z
	eeIqBWDJTZ3KUPCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 220A113A6C;
	Thu, 23 May 2024 07:44:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3nFJCOPzTmawSAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 23 May 2024 07:44:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C0AD9A0770; Thu, 23 May 2024 09:44:34 +0200 (CEST)
Date: Thu, 23 May 2024 09:44:34 +0200
From: Jan Kara <jack@suse.cz>
To: Luis Henriques <luis.henriques@linux.dev>
Cc: Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>, Jan Kara <jack@suse.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] jbd2: reset fast commit offset only after fs
 cleanup is done
Message-ID: <20240523074434.xdpyso46v5l6qvze@quack3>
References: <20240521154535.12911-1-luis.henriques@linux.dev>
 <20240521154535.12911-3-luis.henriques@linux.dev>
 <20240522104500.z343a6xqfduuq5i3@quack3>
 <87le42dl4b.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87le42dl4b.fsf@brahms.olymp>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Wed 22-05-24 14:36:20, Luis Henriques wrote:
> On Wed 22 May 2024 12:45:00 PM +02, Jan Kara wrote;
> 
> > On Tue 21-05-24 16:45:35, Luis Henriques (SUSE) wrote:
> >> When doing a journal commit, the fast journal offset (journal->j_fc_off) is
> >> set to zero too early in the process.  Since ext4 filesystem calls function
> >> jbd2_fc_release_bufs() in its j_fc_cleanup_callback (ext4_fc_cleanup()),
> >> that call will be a no-op exactly because the offset is zero.
> >> 
> >> Move the fast commit offset further down in the journal commit code, until
> >> it's mostly done, immediately before clearing the on-going commit flags.
> >> 
> >> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
> >
> > Did you see any particular failure because of this? Because AFAICS the
> > buffers cleaned up by jbd2_fc_release_bufs() are only allocated during fast
> > commit (from ext4_fc_reserve_space()). And the code in
> > jbd2_journal_commit_transaction() is making sure fast commit isn't running
> > before we set journal->j_fc_off to 0.
> 
> No, I did not see any failure caused by this, this patch is simply based
> on my understanding of the code after spending some time reviewing it.
> 
> The problem I saw was that jbd2_journal_commit_transaction() will run the
> clean-up callbacks, which includes ext4_fc_cleanup().  One of the first
> things that this callback will do is to call jbd2_fc_release_bufs().
> Because journal->j_fc_off is zero, this call is useless:
> 
> 	j_fc_off = journal->j_fc_off;
> 
> 	for (i = j_fc_off - 1; i >= 0; i--) {
> 		[...]
> 	}
> 
> (It's even a bit odd to start the loop with 'i = -1'...)
> 
> So the question is whether this call is actually useful at all.  Maybe the
> thing to do is to simply remove the call to jbd2_fc_release_bufs()?  (And
> in that case, remove the function too, as this is the only call site.)

What is I guess confusing for you (and somewhat for me as well) is that
journal->j_fc_cleanup_callback() gets called from __jbd2_fc_end_commit()
*and* from jbd2_journal_commit_transaction(). I agree the
jbd2_fc_release_bufs() is useless for the call from
jbd2_journal_commit_transaction(), it is however needed for the call from
__jbd2_fc_end_commit(). There are however other bits - namely the
s_fc_dentry_q and s_fc_q list handling that need to happen both for normal
and fast commit...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

