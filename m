Return-Path: <linux-ext4+bounces-3888-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF1B95F9BC
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Aug 2024 21:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7AAF282ABB
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Aug 2024 19:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02651991CA;
	Mon, 26 Aug 2024 19:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=infradead.org header.i=@infradead.org header.b="B8kFP9dp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F54F2B9C5;
	Mon, 26 Aug 2024 19:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724700908; cv=none; b=MjBUpSsasQmXdErXK5VvSDx2ZuJ0D7wO3ulINwSxQ126kdQvKMN2gGTs5xlF0Qidx9f8KGDOf02An1yGnU8O3D2YzxREAMIo8aBZuhmqg75LFe7VC9z2C5i0uSRIDN+vd4jG1Xwtq1Y1yvSu2TrGbpobJsnrVpXp7kYPTFuvZ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724700908; c=relaxed/simple;
	bh=k4ybJCK7M0NBIefKLbT7kmgFuCEKaT/XsH34oFmePMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cm6riynSnnvP6IJ2VRB8miJlQ+o6Ez2B83WbIXPdfT8i+/LTwm4uWHkm/tSjeOc7RQFL/4hG5ilUC4kefDWbegZx+cUifRUj3e6THSym8700uLEXh6hD38mnb+FXJ93K35G2XQDoV2NZd3uxgGtJ0aUQVyl0fvLFCp7KGPk5cow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=evilplan.org; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=fail (0-bit key) header.d=infradead.org header.i=@infradead.org header.b=B8kFP9dp reason="key not found in DNS"; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=evilplan.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=x1LUPN3CKx9WPRDOw9yP1hDbYZryxyKVndTj2KQF0/o=; b=B8kFP9dp5wqu5sC8A6LXRLE0+b
	tZazdv9A0tiLeP1ZRCIKSbKvyt998trph3im0Y8GM4CBMvoW3yaC03z8D0KKiGFbUllQtVT4WGBkB
	SEVEBUmm0DymDvU+DaUPCdxrjDK1A9XUp2EB3Bselhqbem9PRf7tTLYFHq5lp32iS+VOlBYKxU+kU
	Uf3hzDAFB5Fem2jC42yPV5hzSb2AiOzd8ypzqbxsXbTyzT8Idzh8qLr+BE0zlinxOTMDZ9rlbmlAC
	Tx3fbTmCR5TP4JRYCtP3xi5uJmZ71QBdkJ9al1RkKw2T0jN5cKzgkdq4u6bVDCewJByYsAgLg9b8o
	hFyFDQYg==;
Received: from jlbec by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sifUO-00000005Nol-3sQE;
	Mon, 26 Aug 2024 19:34:56 +0000
Date: Mon, 26 Aug 2024 12:34:53 -0700
From: Joel Becker <jlbec@evilplan.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Vinicius Peixoto <vpeixoto@lkcamp.dev>,
	syzbot+8512f3dbd96253ffbe27@syzkaller.appspotmail.com,
	jack@suse.com, joseph.qi@linux.alibaba.com,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	mark@fasheh.com, ocfs2-devel@lists.linux.dev,
	syzkaller-bugs@googlegroups.com, ~lkcamp/discussion@lists.sr.ht
Subject: Re: [syzbot] [ext4?] [ocfs2?] kernel BUG in jbd2_cleanup_journal_tail
Message-ID: <ZszY3SHWTp7XfS3z@google.com>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Vinicius Peixoto <vpeixoto@lkcamp.dev>,
	syzbot+8512f3dbd96253ffbe27@syzkaller.appspotmail.com,
	jack@suse.com, joseph.qi@linux.alibaba.com,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	mark@fasheh.com, ocfs2-devel@lists.linux.dev,
	syzkaller-bugs@googlegroups.com, ~lkcamp/discussion@lists.sr.ht
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
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
 come to perfection.
Sender: Joel Becker <jlbec@ftp.linux.org.uk>

On Mon, Aug 26, 2024 at 09:32:08AM -0400, Theodore Ts'o wrote:
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
> The reason why this isn't an issue with ext4 is because the normal
> "right" way to do this is if jbd2_journal_load() returns an error, is
> to call jbd2_journal_destroy() to release the data structures with the
> journal --- and then don't try to use the journal afterwards.
> 
> The weird thing is that there are two code paths in ocfs2 that calls
> jbd2_journal_load().  One is in ocfs2_replay_journal() which does what
> ext4 does.  The other is ocfs2_load_journal() which does *not* do
> this, and this is the one which you saw in the syzkaller reproducer.
> It looks like one codepath is used to replay the ocfs2 for some other
> node, and the is to load (and presumably later, replay) the journal
> for the mounting node.

You are correct, Ted, that one path is for the local journal and the
other is to recover remote journals for other nodes that may have
crashed.

I think the big ordering issue is that we set
osb->journal->j_state=OCFS2_JOURNAL_LOADED in ocfs2_journal_init(),
before we've attempted any replay.  Later in ocfs2_journal_shutdown(),
we check this state and decide to perform cleanup.

Instead, we should not set OCFS2_JOURNAL_LOADED until
ocfs2_journal_load() has called jbd2_journal_load().  Only then do we
actually know we have loaded a valid journal.

Something like:

```
	status = jbd2_journal_load(journal->j_journal);
	if (status < 0) {
		mlog(ML_ERROR, "Failed to load journal!\n");
		BUG_ON(!igrab(journal->j_inode));
		jbd2_journal_destroy(journal->j_journal);
		iput(journal->j_inode)
		goto done;
	}
	journal->j_state = OCFS2_JOURNAL_LOADED;
```

With code like this, when jbd2_journal_load() fails, the future
ocfs2_journal_shutdown() will exit early, because !OCFS2_JOURNAL_LOADED.

I think this is the right spot; a quick audit of the paths (it has been
a while) doesn't find any other outstanding state; the rest of journal
startup, such as the commit thread etc, only happen after this.

> jbd2_journal_destroy().  It would seem like the *right* thing to do is
> to bump the refcount in ocfs2_journal_init(), and if for some reason
> the igrab fails, it can just return an error early, instead of having
> to resort to BUG_ON() later, and if you don't realize that you have to
> do this weird igrab() before calling jbd2_journal_destroy(), you'll
> end up leaking the journal inode.

There are interactions of journal inodes for nodes we don't own, and
also connections to cluster locks for our own journal (don't replay
ourselves while another node has locked it and is recovering us).  So we
do have some state to keep track of.  But it's been so long that I don't
recall if there was a specific reason we do this late via igrab(), or if
it's just that we should have done as you describe and missed it.
You'll note that I copied the igrab/iput game in my snippet above.

Should someone try to audit the igrab/iput thing later?  Yes.  But it's
not a necessary part of this fix.

Thanks,
Joel

-- 

"War doesn't determine who's right; war determines who's left."

			http://www.jlbec.org/
			jlbec@evilplan.org

