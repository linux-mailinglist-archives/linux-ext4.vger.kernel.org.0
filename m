Return-Path: <linux-ext4+bounces-3938-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678F796254B
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Aug 2024 12:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B409B219E6
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Aug 2024 10:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C3616BE38;
	Wed, 28 Aug 2024 10:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q5KfTMkc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YJt1uXAz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aI4r+ML2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XECcFiio"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7EF16A37C;
	Wed, 28 Aug 2024 10:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724842501; cv=none; b=qoeaqnI51f2Ufmx7eMDv1EX5GTILBuwChf5V9jBEjZdTbDWurVN4yJFcSGm4zqG+WAWCPUQKwRPFJofAof1hTtDMkD46rwiv8UGFoQQh4bSaTtZEA+ypZGXDP3URiBufEiR8ZrCO2tVP2Zgh7sSIXHmjNWgfn0DePAmkxsvh3Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724842501; c=relaxed/simple;
	bh=S30IzBTvZMfC9d/ElKB9D8NDvjEbQC5vqnWEYkcJimE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6rBTJCWlF1jF3rddMT1xaVqjlGVRg1749LmeCzlk2TyuBcE7eJJEOCkl7GHdRSR3pHmURoquuZwHunNeah821Oc54gWqTnmjIAnE+Ct9aKlFlr1u+r655DmgoTfQu95L7VAtj4kS0p8uJ0xu1e30EbaxdAKpCtsvW34Y5ME00o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q5KfTMkc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YJt1uXAz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aI4r+ML2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XECcFiio; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D77581FC04;
	Wed, 28 Aug 2024 10:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724842497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jB9SfZ0mCFHAKCSMP99d+Ef51sDm553ruU6X+bNK0e4=;
	b=Q5KfTMkcElxsOKMZ5Ba4jG8GXue1FLKsMI9ijOp/XarfGan+v+2/IclBr6AIqygNQunGM+
	rlMnZVqMqa4GNgQoahyNBUpVMsdvAQARLZAAJgqUeHDCVpDxoUzqVfkOTBG6QMPxcK1T7H
	KGLbsQ+qwv+fnxL1aw1ZDVSp3eTXmAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724842497;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jB9SfZ0mCFHAKCSMP99d+Ef51sDm553ruU6X+bNK0e4=;
	b=YJt1uXAz6JoaUlOHdVGJhhtV2wIJNkgfJTPMhQ5CzlIN0Oc43oKQv/PecGfuMKdiY41f2a
	Bbw3w0DEvKBYNTDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aI4r+ML2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XECcFiio
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724842496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jB9SfZ0mCFHAKCSMP99d+Ef51sDm553ruU6X+bNK0e4=;
	b=aI4r+ML2j7+dnebnwxye7zkvZh2Z7HPi6LfF2sIRMWIsJK0+hyTOqpNtgxMvYtWhd5o9aq
	F7jNPTAuqAbhlCbeI1srvwE0cCUXbloRLi6zb908Qk3bzKz2gP2ZicQZKcDuoC1GCjgFhb
	cjGlk/rDAfFdZCcfzO2uSQXmaGNP8yA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724842496;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jB9SfZ0mCFHAKCSMP99d+Ef51sDm553ruU6X+bNK0e4=;
	b=XECcFiio7Bpd/X0jaN/LYv6iatUqlmk0pUqV2eTgCgofIky+GtLIHg54nSztsrnSjbbVTO
	lBVTwS/lUQe8BEBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA031138D2;
	Wed, 28 Aug 2024 10:54:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fBcjLQACz2bNcgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 28 Aug 2024 10:54:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3C6A7A0968; Wed, 28 Aug 2024 12:54:52 +0200 (CEST)
Date: Wed, 28 Aug 2024 12:54:52 +0200
From: Jan Kara <jack@suse.cz>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Vinicius Peixoto <vpeixoto@lkcamp.dev>,
	syzbot+8512f3dbd96253ffbe27@syzkaller.appspotmail.com,
	jack@suse.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	mark@fasheh.com, ocfs2-devel@lists.linux.dev,
	Julian Sun <sunjunchao2870@gmail.com>,
	syzkaller-bugs@googlegroups.com, ~lkcamp/discussion@lists.sr.ht
Subject: Re: [syzbot] [ext4?] [ocfs2?] kernel BUG in jbd2_cleanup_journal_tail
Message-ID: <20240828105452.z6tqwq47bcnmrevd@quack3>
References: <00000000000070a66706204e7698@google.com>
 <d673f289-2385-4949-ac80-f3a502d4deb2@lkcamp.dev>
 <20240826133208.GB424729@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826133208.GB424729@mit.edu>
X-Rspamd-Queue-Id: D77581FC04
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[8512f3dbd96253ffbe27];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[lkcamp.dev,syzkaller.appspotmail.com,suse.com,evilplan.org,linux.alibaba.com,vger.kernel.org,fasheh.com,lists.linux.dev,gmail.com,googlegroups.com,lists.sr.ht];
	DKIM_TRACE(0.00)[suse.cz:+];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Mon 26-08-24 09:32:08, Theodore Ts'o wrote:
> On Mon, Aug 26, 2024 at 01:22:54AM -0300, Vinicius Peixoto wrote:
> > Since the disk data is bogus, journal_reset fails with -EINVAL ("JBD2:
> > Journal too short (blocks 2-1024)"); this leaves journal->j_head == NULL.
> > However, jbd2_journal_load clears the JBD2_ABORT flag right before calling
> > journal_reset. This leads to a problem later when ofcs2_mount_volume tries
> > to flush the journal as part of the cleanup when aborting the mount
> > operation:
> > 
> >   -> ofcs2_mount_volume (error; goto out_system_inodes)
> >     -> ofcs2_journal_shutdown
> >       -> jbd2_journal_flush
> >         -> jbd2_cleanup_journal_tail (J_ASSERT fails)
> > ...
> >
> > I confirmed that setting the JBD2_ABORT flag in journal_reset before
> > returning -EINVAL fixes the problem:
> > 
> >         static int journal_reset(journal_t *journal)
> >                         journal_fail_superblock(journal);
> >         +               journal->j_flags |= JBD2_ABORT;
> >                         return -EINVAL;
> > 
> > You can find a proper patch file + the syzbot re-test result in [1].
> > However, I'm not entirely sure whether this is the correct decision, and I
> > wanted to confirm that this is an appropriate solution before sending a
> > proper patch to the mailing list.
> 
> The reason why this isn't an issue with ext4 is because the normal
> "right" way to do this is if jbd2_journal_load() returns an error, is
> to call jbd2_journal_destroy() to release the data structures with the
> journal --- and then don't try to use the journal afterwards.

Yep. OCFS2 guys are actually looking into fixing this in OCFS2
(https://lore.kernel.org/ocfs2-devel/20240819131120.746077-1-sunjunchao2870@gmail.com/)
Not sure what's the status though. Julian, did you send v2 of your fix?

								Honza

> The weird thing is that there are two code paths in ocfs2 that calls
> jbd2_journal_load().  One is in ocfs2_replay_journal() which does what
> ext4 does.  The other is ocfs2_load_journal() which does *not* do
> this, and this is the one which you saw in the syzkaller reproducer.
> It looks like one codepath is used to replay the ocfs2 for some other
> node, and the is to load (and presumably later, replay) the journal
> for the mounting node.
> 
> There are also some other things which look very confusing, such as the
> fact that ocfs2_journal_shutdown calls igrab:
> 
> 	/* need to inc inode use count - jbd2_journal_destroy will iput. */
> 	if (!igrab(inode))
> 		BUG();
> 
> ... which is *weird*.  Normaly the journal inode refcount is expected
> to be bumped before calling jbd2_journal_init_inode() --- which
> normally is done by an iget() function, and is needed to make sure the
> journal inode isn't released out from under the jbd2 layer.  It looks
> like ocfs2 uses the journal inode for other stuff so get the journal
> inode without calling something like iget().  Which is OK, I guess,
> but it means that there are a whole bunch of places where it has to
> call !BUG_ON(igrab(journal->j_inode) before calling
> jbd2_journal_destroy().  It would seem like the *right* thing to do is
> to bump the refcount in ocfs2_journal_init(), and if for some reason
> the igrab fails, it can just return an error early, instead of having
> to resort to BUG_ON() later, and if you don't realize that you have to
> do this weird igrab() before calling jbd2_journal_destroy(), you'll
> end up leaking the journal inode.
> 
> Anyway, I think the right thing to do is to restructure how ocfs2
> calls the jbd2 journal, but that's going to require a more careful
> examination of the code paths.  Your patch is a bit of a blunt force
> hack that should be harmless, but it's probably not the best way to
> fix the problem, although doing it "right" would be more
> complicated....
> 
> 					- Ted
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

