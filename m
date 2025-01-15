Return-Path: <linux-ext4+bounces-6127-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40E9A12A3D
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jan 2025 18:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9BBE166828
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jan 2025 17:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F491A239C;
	Wed, 15 Jan 2025 17:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oemHJOWQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zU/9scZ6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oemHJOWQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zU/9scZ6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972ED189F5C;
	Wed, 15 Jan 2025 17:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736963625; cv=none; b=uxdj/TeIlNjgcuNsgfe1b/Phjh57TNaB/zPfyWaWqAC3lT1Kll16kb6EfKjETrXfHUAJ2FSKDnZl5mxx5C3KdPoAUqLDQqYHKaHYefkpeRp8XXoJecGkzpEle8BvniNWFMfBgJXGlVM7X4lYYfPS25KCknE0uoPSoiUBEjYdUHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736963625; c=relaxed/simple;
	bh=sWEri19tFWrg9x/k0QqtnM9RMkhU+X2vqpuoSovB64Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TH97jKbYCKRNCYMGzzBtdm6EnMFDoe1wg4Q/0YyxinqQ+N0O2D/EWKLG4gXPmhMA3bowe+cX058CKwtbSr5RbV1UVLGwL9bij7bC4JhR9P6L7kuOl4/kELjL2Uf4FBcmcIms6FWLGDO9U4AkGwkk9hG6EIY4dS+FyNOOnL9blzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oemHJOWQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zU/9scZ6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oemHJOWQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zU/9scZ6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CF2F92126E;
	Wed, 15 Jan 2025 17:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736963621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w514Fsifov2itNHvnUBqKFDClY1s7qWmgbyDAkHc+cQ=;
	b=oemHJOWQEwSN8LatTtxyC4LXsQRxfwQnDKeLULrhW+Yf0p4HaS0B49kQ9dJ9lte1f09Gi/
	xc3Ijlvlcukjrgip8cvkXpEgP37cmJITLU+3S64mUu2UwPwIxecnvELrw1+5ed1Q9wyZcy
	B6Q+k6YXqayLPm/QQKO78SfDR5IMXjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736963621;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w514Fsifov2itNHvnUBqKFDClY1s7qWmgbyDAkHc+cQ=;
	b=zU/9scZ6ZsTYoOT//PhSf7EVbxUOvmwdmGcHLGKfZ4FXLJ6rSPpX8xfoDJqZbiC7rqGomP
	Zo+LctTCFd6kEHAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736963621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w514Fsifov2itNHvnUBqKFDClY1s7qWmgbyDAkHc+cQ=;
	b=oemHJOWQEwSN8LatTtxyC4LXsQRxfwQnDKeLULrhW+Yf0p4HaS0B49kQ9dJ9lte1f09Gi/
	xc3Ijlvlcukjrgip8cvkXpEgP37cmJITLU+3S64mUu2UwPwIxecnvELrw1+5ed1Q9wyZcy
	B6Q+k6YXqayLPm/QQKO78SfDR5IMXjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736963621;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w514Fsifov2itNHvnUBqKFDClY1s7qWmgbyDAkHc+cQ=;
	b=zU/9scZ6ZsTYoOT//PhSf7EVbxUOvmwdmGcHLGKfZ4FXLJ6rSPpX8xfoDJqZbiC7rqGomP
	Zo+LctTCFd6kEHAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB73E139CB;
	Wed, 15 Jan 2025 17:53:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kDaALSX2h2cMNgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 15 Jan 2025 17:53:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5112FA08E2; Wed, 15 Jan 2025 18:53:41 +0100 (CET)
Date: Wed, 15 Jan 2025 18:53:41 +0100
From: Jan Kara <jack@suse.cz>
To: Heming Zhao <heming.zhao@suse.com>
Cc: Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, 
	li.kai4@h3c.com, jack@suse.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, ocfs2-devel@lists.linux.dev, 
	Liebes Wang <wanghaichi0403@gmail.com>, syzbot <syzbot+96ee12698391289383dd@syzkaller.appspotmail.com>
Subject: Re: WARNING in jbd2_journal_update_sb_log_tail
Message-ID: <2htuqhxolgddrwm5ka7ad4axu3gz7nprqnmspdtkwld7mzch3r@tqhjlxfidxsb>
References: <CADCV8sq0E9_tmBbedYdUJyD4=yyjSngp2ZGVR2VfZfD0Q1nUFQ@mail.gmail.com>
 <mzypseklhk6colsb5fh42ya74x43z5mmkzdjdyluesx6hb744a@hycbebanf7mv>
 <24f378c8-7a27-47b8-bd79-dba4a2e92f6d@suse.com>
 <20250114133815.GA1997324@mit.edu>
 <3655551d-b881-4f2b-8419-03efe4d3aca7@suse.com>
 <CADCV8srwww_--oOvi1sdS4JfUafidPOPr0srG1bWO66py2WTtQ@mail.gmail.com>
 <db4da8db-d501-4181-994b-c25845908161@suse.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db4da8db-d501-4181-994b-c25845908161@suse.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[96ee12698391289383dd];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,mit.edu,h3c.com,suse.com,vger.kernel.org,googlegroups.com,linux.alibaba.com,lists.linux.dev,gmail.com,syzkaller.appspotmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Wed 15-01-25 13:00:23, Heming Zhao wrote:
> Hello Jan,
> 
> On 1/15/25 09:32, Liebes Wang wrote:
> > The bisection log shows the first cause commit is a09decff5c32060639a685581c380f51b14e1fc2:
> > a09decff5c32 jbd2: clear JBD2_ABORT flag before journal_reset to update log tail info when load journal
> > 
> > The full bisection log is attached. Hope this helps.
> 
> This bisearch commit a09decff5c32 appears to be the root cause
> of this issue. It fixed one issue but introduced another.
> 
> Syzbot tested the patch with calling jbd2_journal_wipe() with 'write=1'.
> The Syzbot test result [1] shows that the same WARN_ON() is triggered
> in a subsequent routine – the classic whack-a-mole!
> 
> Back to commit a09decff5c32, it opened a door to allow jbd2 to update
> sb regardless of whether the value of sb items are correct.
> 
> To fix a09decff5c32, it seems that jbd2 needs to add more sanity check
> codes in a sub-routine of jbd2_journal_load().
> 
> btw, in my view, this is a jbd2 issue not ocfs2/ext4 issue.
> 
> [1]: https://lore.kernel.org/ocfs2-devel/04a9ad29-51de-4b50-a5bb-56f91817639d@suse.com/T/#m86d01f83d808868bb5e6548d30f79b4f9f889b13

Thanks for debugging this! So I'm not 100% convinced this is only jbd2 bug
because jbd2_journal_recover() was never intended to be called after
jbd2_journal_skip_recovery() (called from jbd2_journal_wipe()). You're
supposed to call either jbd2_journal_wipe() or jbd2_journal_recover() but
not both. So IMO this needs fixing in OCFS2 code. That being said you've
also pointed at one bug in jbd2 code - the WARN_ON(!sb->s_sequence) in
jbd2_journal_update_sb_log_tail() is indeed wrong. We were inconsistent
inside jbd2 whether TID 0 is considered valid or not and relatively
recently we've decided to accept TID 0 as valid but this place was left
out. I'll send a fix for that.

								Honza

> > Heming Zhao <heming.zhao@suse.com <mailto:heming.zhao@suse.com>> 于2025年1月14日周二 22:51写道：
> > 
> >     Hi Ted,
> > 
> >     On 1/14/25 21:38, Theodore Ts'o wrote:
> >      > On Tue, Jan 14, 2025 at 02:25:21PM +0800, Heming Zhao wrote:
> >      >>
> >      >> The root cause appears to be that the jbd2 bypass recovery logic
> >      >> is incorrect.
> >      >
> >      > Heming, thanks for taking a look.
> >      >
> >      > I'm not convinced the root cause is what you've stated.  When
> >      > jbd2_journal_wipe() calls jbd2_mark_journal_empty(), s_start gets set
> >      > to zero:
> > 
> >     Actually, ocfs2 calls jbd2_journal_wipe() with 'write=0' (hard coded),
> >     so jbd2_mark_journal_empty() isn't called during the ocfs2 mount
> >     phase. This means the following deduction won't apply in this case.
> > 
> >     -- Heming
> > 
> >      >
> >      >       sb->s_start    = cpu_to_be32(0);
> >      >
> >      > This then gets checked in jbd2_journal_recovery:
> >      >
> >      >       if (!sb->s_start) {
> >      >               jbd2_debug(1, "No recovery required, last transaction %d, head block %u\n",
> >      >                         be32_to_cpu(sb->s_sequence), be32_to_cpu(sb->s_head));
> >      >               journal->j_transaction_sequence = be32_to_cpu(sb->s_sequence) + 1;
> >      >               journal->j_head = be32_to_cpu(sb->s_head);
> >      >               return 0;
> >      >       }
> >      >
> >      > I suspect that there is something else wrong with jbd2's superblock,
> >      > since this normally works in the absence of malicious fs image
> >      > fuzzing, such that when jbd2_journal_load() calls reset_journal()
> >      > after jbd2_journal_recover() correctly bypasses recovery, the WARN_ON
> >      > gets triggered.
> >      >
> >      > I'd suggest that you enable jbd2 debugging so we can see all of the
> >      > jbd2_debug() message to understand what might be going on.
> >      >
> >      > By the way, given that this is only a WARN_ON, and it involves
> >      > malicious image fuzzing, this is probably a valid jbd2 bug, but it's
> >      > not actually a security bug.  Sure, someone silly enough to pick up a
> >      > maliciously corrupted USB thumb drive dropped in a parking lot and
> >      > insert it into their desktop, and the distribution is silly enoough to
> >      > allow automount, the worse that can happen is that the system to
> >      > reboot if the system is configured to panic on a WARNING.  So feel
> >      > free to prioritize your investigation appropriately.  :-)
> >      >
> >      > Cheers,
> >      >
> >      >                                               - Ted
> > 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

