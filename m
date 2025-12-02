Return-Path: <linux-ext4+bounces-12117-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77581C99B7B
	for <lists+linux-ext4@lfdr.de>; Tue, 02 Dec 2025 02:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373413A458A
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Dec 2025 01:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845591B3925;
	Tue,  2 Dec 2025 01:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="nYd5GKSk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E70E125A0
	for <linux-ext4@vger.kernel.org>; Tue,  2 Dec 2025 01:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764638162; cv=none; b=eyYd712SozGrBSBQ9IhFOyvrlUp5YnlJjB1vMg77PKhoiT/rQ7LO5HNO6s1ZKcoSTEtVrhK9cbLtnn8/md6p3k/gNjJj46g3c/uyKlOoSaVbnDyZOuy2xebrEOD14vEwr8UnYBSRHV5me6z3AuM2zxpZh03VGmIUz5KDdCtWHsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764638162; c=relaxed/simple;
	bh=EUbBqGHqKFguew41j77lIDqTbGWWgY+P/6wa62jYQVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+YG/ia39pujmcW4EWX7qVlnctSz2YiasMyyhidnvU48QkD2fpn4FThfhg5afH3URP9H1lyYiRbz79CDXM1QKjtLdAE859DLInv+kQ/XX/r6w0QayQIeFRHI0RF8fyRO0YnAPwVMkFrEEDVM4MDqWESU7CDFRmoFEoXEFzzubA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=nYd5GKSk; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-121-67.bstnma.fios.verizon.net [173.48.121.67])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5B21FseM000938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Dec 2025 20:15:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1764638156; bh=ocWuW/zXb8yO5BV86qfodC9tz77XrmbKqDo9PhzS37k=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=nYd5GKSkHu8tC4SqDbfz0F5htV5NBOYSUtby9EbT4tqYSN8qdESBZ59dr2Axduzap
	 Ex6h4M3bUg/DFvgmM331tx+CN9cCc47gj+v40iQW1BA9M3WIWdbNc0hXC1WdkxJtco
	 0DXagHVMifoSEISbFzNO8wEy58QoCK2YN7fp5CKor/uRigC8DXOcilWyiQaGTZIJiw
	 rnD8hTtt634yi9Aofbla3rp8GfHcEr1+DinO9hM0sxQ/ANETgRtSuzX0+FtBxG2jwO
	 b8QBMdLAfm6gAvP2zsPAsgQ6kwHs2KCrfc+RD+TWwgm4YNSklU+CuspZVq3HWDsFpq
	 NsxcyMTBYm5oA==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id BDFA34DBE8C7; Mon,  1 Dec 2025 20:14:53 -0500 (EST)
Date: Mon, 1 Dec 2025 20:14:53 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Andreas Dilger <adilger@dilger.ca>
Cc: syzbot <syzbot+bb2455d02bda0b5701e3@syzkaller.appspotmail.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_destroy_inline_data
 (2)
Message-ID: <20251202011453.GA29113@macsyma.lan>
References: <690bcad7.050a0220.baf87.0076.GAE@google.com>
 <20251201161648.GA52186@macsyma.lan>
 <2ED9BD8E-9A4D-4800-8633-9FEAD464049D@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ED9BD8E-9A4D-4800-8633-9FEAD464049D@dilger.ca>

On Mon, Dec 01, 2025 at 04:17:02PM -0700, Andreas Dilger wrote:
> I think we would regret removing this if/when we *do* expand the inode
> size.  We used this functionality to upgrade filesystems online when
> i_projid was first added and users suddenly wanted to use project quotas.
> If we need some new inode field in the future it will be good to have it.

I wasn't proposing to remove the code.  I was just saying that from
the perspective of prioritization, it's not a high priority for me to
pay attention to syzbot complaints that involve this code path ---
just as it's not high priority for me to pay attentiont to syzbot
complaints that involve assuming that you should allow random
untrusted users to mount maliciously corrupted file systems --- we
should be encouraging users who want to allow people who allow their
users to pick up random USB sticks scattered in the parking lot by the
CIA or MSS and automount them as root to use fuse2fs instead.

(And by the way, it's not hard to prohibit USB sticks from being
allowed to be attached and thus making it impossible for them to be
mounted; that's how we protect things at $WORK for all desktop
systems, and ChromeOS has knobs which allow enterprise administrators
to prevent this.  It's just basically a good idea if you are a
paranoid adminstrator and are worried about nation-state attacks...
It's also makes life much easier if you are an intelligence agency and
you are worried about Snowden-style exfiltration threats; if they have
to send it out over the network, you can at least do more to detect
such activities.  :-)

In this particular syzbot complaint, it requires using a debugging
mount options that is in practice never used in the real world *and* a
malciously corrupted file system.  So it's not super high priority for
me to fix, but if we have a quick and easy fix, we should definitely
go for it, if only to shut up syzbot --- not that it will make any
difference for production use cases assuming sensible system administrators.

> This could check in ext4_orphan_cleanup()->ext4_evict_inode() path
> that this is orphan cleanup with EXT4_ORPHAN_FS and skip the expansion?
> As you write, it doesn't make sense to do that when the file is being
> deleted anyway.  Something like the following, which adds unlikely() to
> that branch since it may happen only once or never in the lifetime of
> any inode:

Something like this, but we should also skip trying to expand the
inode if i_links_count is zero.  That way, we won't try to expand an
inode if we are running rm -rf on a directory hierarchy composed of
hundreds or thousands of inodes where trying to expand the inode is a
complete waste of time.  :-)

					- Ted

