Return-Path: <linux-ext4+bounces-11008-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0478BF6D5B
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Oct 2025 15:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39C6B3B9976
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Oct 2025 13:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2DE33509E;
	Tue, 21 Oct 2025 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wwNfMRxC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T0+8l+NB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wRLGTpEE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="urd//8Nd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CC52512DE
	for <linux-ext4@vger.kernel.org>; Tue, 21 Oct 2025 13:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054005; cv=none; b=PLpoI+uqCxlMTc5LfCdgtyKZrrys9sW7yarD172YZloIgjBPF/zurI8OEfUoJe78qTUht3THI/QucisQyqwCXcBlAidC+aA8fh7W8es83Bx/80aE0zekRhk8JAqwxZ1lJ4cPEa2Ki2oA36eS4n7/RFn6OilGFP4wnQqiEMCz1ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054005; c=relaxed/simple;
	bh=TqnOG6CB5niqTZnM55OmNTCNfMmDEAduFrNw6JC7jsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vjkb9KhFffUamp1jJk9HZP9Y5ooYoRd85oKsrmG7b2FoPn9UcNUmGDn/qBw7+UiXXgWXdcAFJQBRZlkPp97yK0w7gTFv2ZkRhy0IpKSzhs+hjlSqwFLu+eREQ+ZBu3nbYN54LRZ/XGRBBBfLQsFxphW9zEztx4gByc3xZOkDOCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wwNfMRxC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=T0+8l+NB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wRLGTpEE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=urd//8Nd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7C1EB21168;
	Tue, 21 Oct 2025 13:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761053996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fq08oawCKUImk2GlgyrTT1R6VaeVhmQ+YD5ZgsGp19U=;
	b=wwNfMRxCSY1iWBj5t16Q8SNy7WWTvtENtMVy7x90TiogXMeUWOiaMQBMX9uYqndCvcOYz5
	gT1GnK0C3F1sfJKv02uhDN2H6/JhQBVd1o4yMjnQwFafa4w557j5RvmkHrvUR/rCU9y6FG
	VcnpGGKzeME1xHk27KDQBdwB9t4TdXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761053996;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fq08oawCKUImk2GlgyrTT1R6VaeVhmQ+YD5ZgsGp19U=;
	b=T0+8l+NBbnjXazBH2q7c82ZcyyePA93hHSbvehFaH89yTs58PUJgGhJLbWQ12H1F/dg3Pd
	MaJwtRzVZqjbb/Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761053992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fq08oawCKUImk2GlgyrTT1R6VaeVhmQ+YD5ZgsGp19U=;
	b=wRLGTpEEt9IVGXCcZ1gjBuzf7rqx8N7S6+OpLEWgdh/GQQrbHrsKygMNKEbvKT2NWZPmc2
	86odIglcJtLBmfdQ84EGcO+eiQyjZItM/lkd/sDp5XBle0qFP/LZKHuX3TVUsDR4zX7izk
	+TwvyOkiI1VcxNGCF3UUHAsbi2JQmvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761053992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fq08oawCKUImk2GlgyrTT1R6VaeVhmQ+YD5ZgsGp19U=;
	b=urd//8Nd2WvJ0FE729o1ftT2ekx8IecSz/P8xfY4IJg/+BztS+SbXbyL3G159CFprxLFwB
	ejmYIyGHOaDXY7DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60318139B1;
	Tue, 21 Oct 2025 13:39:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dEcdFyiN92jSPwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 21 Oct 2025 13:39:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E74A2A0990; Tue, 21 Oct 2025 15:39:47 +0200 (CEST)
Date: Tue, 21 Oct 2025 15:39:47 +0200
From: Jan Kara <jack@suse.cz>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] jbd2: assign different lock_class_key for different
 filesystem
Message-ID: <doq4csrkuhpha7v5lunesdrscmqmjvt3flids3iai2gvpbhp3j@mxldi4yvvymw>
References: <e42f1471-a88a-4938-8743-1d5b171c47ec@I-love.SAKURA.ne.jp>
 <fwsxrb7ugi5zeosugo6hyjdbhw36ppa5kekfi6n7we2vvi3r7m@ljrizqoagsg7>
 <93744126-237b-4e36-8a62-a33e1fb52051@I-love.SAKURA.ne.jp>
 <mjzb7q6juxndqtmoaee3con6xtma5vfzkgfcicjjmt7ltv2gtt@ps2np5r36vn3>
 <96c8fca1-7568-46c8-a5ad-af4699b95d5e@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96c8fca1-7568-46c8-a5ad-af4699b95d5e@I-love.SAKURA.ne.jp>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Tue 21-10-25 20:16:53, Tetsuo Handa wrote:
> On 2025/10/20 21:55, Jan Kara wrote:
> > On Mon 20-10-25 20:28:54, Tetsuo Handa wrote:
> >> On 2025/10/20 18:31, Jan Kara wrote:
> >>> On Sun 19-10-25 19:52:43, Tetsuo Handa wrote:
> >>>> syzbot is reporting possibility of deadlock due to sharing lock_class_key
> >>>> for jbd2_handle across ext4 and ocfs2. But one disk partition can't have
> >>>> two filesystems at the same time, and how locks in journal_t interacts
> >>>> with other filesystem specific locks can vary depending on filesystems.
> >>>> Therefore, lockdep should treat locks in journal_t different locks if
> >>>> the filesystem which allocated the journal_t differs.
> >>>
> >>> Thanks for debugging this. I agree with the idea of your solution but the
> >>> implementation is just ugly. Just let the filesystem pass the lockdep key
> >>> into jbd2_journal_init_dev() / jbd2_journal_init_inode() and make ext4 and
> >>> ocfs2 functions initializing the journal each have its own lock_class_key
> >>> declared and pass it to jbd2 functions. That way changes are much simpler
> >>> and also jbd2 doesn't have to be aware about which filesystems are using
> >>> it.
> >>
> >> Well, do you mean something like below diff? If we can assume that only ext4
> >> and ocfs2 are using jbd2, the diff becomes smaller...
> > 
> > Yes, something like this. In fact, I think we could get away with just
> > jbd2_trans_commit_key. There's definitely no need for j_revoke_lock,
> > j_list_lock, j_history_lock, j_state_lock, j_abort_mutex keys as these are
> > internal to jbd2. j_checkpoint_mutex and j_barrier do wrap around some
> > filesystem code so maybe we'll need to specify keys for them but I'd start
> > with just jbd2_trans_commit_key and wait whether syzbot manages to trigger
> > another false positive report with that.
> 
> I tried https://syzkaller.appspot.com/x/patch.diff?x=11b4dde2580000 .
> But I think https://syzkaller.appspot.com/x/patch.diff?x=1644c3cd980000
> pattern which all mutex_init_with_key() users follow seems more simpler
> and easier to apply. What do you think?

Yes, the second version looks nicer. Thanks! BTW, did you verify that
annotating j_barrier, j_checkpoint_mutex, and j_abort_mutex is really
needed? Because I'd be slightly surprised if it really was...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

