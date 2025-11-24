Return-Path: <linux-ext4+bounces-12023-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDD9C8198A
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Nov 2025 17:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B8BB6348A3E
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Nov 2025 16:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F31298987;
	Mon, 24 Nov 2025 16:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="LLRjImyG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AD229B224
	for <linux-ext4@vger.kernel.org>; Mon, 24 Nov 2025 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764002008; cv=none; b=ojRjwyPP+HOVTI38SksLGwZYXnAZMngThPi4kdZeOD4jJUrRscXtn+owClc4YbBSgpanKNyOjmlCUR+JRSY//FgJiYxyro3giLLNDaQWqS6pI47Sm/KnhOfG5C4PpSyjZ0likPvuqaq8GVa2nK7Cbt+ZIjYCSKFQGmAbLWUbwqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764002008; c=relaxed/simple;
	bh=fBR70J8ZDIQTNKG061mrIqt0O0KlihpAPqI+7mFnRUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRMOwzKkhw63XQViJ98NYxMUbgI6z7MyZg0yyyA0mp7z8hj/NhASQ6qrYN8g3brpVOlAHUnOWljuHJs+segVRbUfJnzu+4Z9bL81Mfn8heCwuWsNM3Dm4e5qIdIrvg3TI5NQsZNBZSoaE657h5UZ2eHUjoTNihMiBBKY2XKpe3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=LLRjImyG; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (c-73-9-28-129.hsd1.il.comcast.net [73.9.28.129])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5AOGXHDX020207
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 11:33:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1764001999; bh=bx9+ePl+sWfSpPpukOHtpr+fvog/AJhv2asBBgF3oys=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=LLRjImyGSjcU7j5lurP6lVa+WdgAO9jWbHWk+nF86p+RQP7V59dEBz4DQZ3NV7Ekq
	 7uToJq8u9ePt9ogHFPqMZ/jpA7VtX9LaM/Vj5Zm/WDVbNoxWEnhmGjws8ieYq7DegM
	 tPdo17eUOUZyirgzj1zKnwEC05ucQSj7GKKb5mSXKFmsORvUtvJIN+iy7QhsiP2dG7
	 fWSnYr5KNEBGqMvvtaFL5YZhaDFBLT0Nohubmc1a30K0zKyvHebC2CBGs8IXb1HIMc
	 So1JrhpVeME907Jdvcift9/Q3kFEjg34/N5msBia/zittWq/yKHo8VnQUay4zvgH0V
	 Erc2z9iKC3q4g==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 5C9184C81571; Mon, 24 Nov 2025 10:33:17 -0600 (CST)
Date: Mon, 24 Nov 2025 10:33:17 -0600
From: "Theodore Tso" <tytso@mit.edu>
To: bugzilla-daemon@kernel.org
Cc: linux-ext4@vger.kernel.org
Subject: Re: [Bug 220594] Online defragmentation has broken in 6.16
Message-ID: <20251124163317.GG13687@macsyma-3.local>
References: <bug-220594-13602@https.bugzilla.kernel.org/>
 <bug-220594-13602-a5cboOdpR3@https.bugzilla.kernel.org/>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-220594-13602-a5cboOdpR3@https.bugzilla.kernel.org/>

On Mon, Nov 24, 2025 at 04:13:27PM +0000, bugzilla-daemon@kernel.org wrote:
> > And for the files that were failing, if you unmount the file system
> > and remount it, can you then defrag the file in question?  If the
> 
> No. Tried that thrice.

Can you try that again, and verify using strace that you get the same
EBUSY error (as opposed to some other error) after unmounting and
remounting the file system?  At this point, I don't want to take
*anything* for granted.

Given that past attempts where you've sent me a metadata-only e2image
dump, I haven't been able to reproduce it, are you willing to build an
upstream kernel (as opposed to a Fedora kernel), and demonstrate that
it reproduces on an upstream kernel?  If so, would you be willing to
run an upstream kernel with some printk debugging added so we can see
what is going on --- since again, I still haven't been able to
reprdouce it on my systems.

> > What this means is that if the file has pages which need to be written
> > out to the final location on disk (e.g., if you are in data=journal
> 
> Journalling is disabled on all my ext4 partitions.

So you are running a file system with ^has_journal?  Can you send me a
copy dumpe2fs -h on that file system?

Something else to do.  For those files for which e2defrag is failing
reliably after an unmount/remount, are you reproducing the failure by
running e4defrag on just that one file, or by iterating over the
entire file system?  If it reproduces reliably where you try
defragging just that one file, can you try using debugfs's "stat"
command and see what might be different on that file versus some file
for which e4defrag on just that one file *does* work?

e.g.:

debugfs /dev/hdXX
debugfs:  stat groups
Inode: 177   Type: regular    Mode:  0755   Flags: 0x80000
Generation: 0    Version: 0x00000000:00000000
User:     0   Group:     0   Project:     0   Size: 43432
File ACL: 0
Links: 1   Blockcount: 88
Fragment:  Address: 0    Number: 0    Size: 0
 ctime: 0x6916c804:00000000 -- Fri Nov 14 01:11:16 2025
 atime: 0x6916c879:00000000 -- Fri Nov 14 01:13:13 2025
 mtime: 0x684062bd:00000000 -- Wed Jun  4 11:14:05 2025
crtime: 0x6924883d:00000000 -- Mon Nov 24 11:30:53 2025
Size of extra inode fields: 32
Inode checksum: 0x2e204798
EXTENTS:
(0-10):9368-9378

Finally, I'm curious --- if it's only just a few files out of hundreds
of thousands of files, why do you *care*?  You seem to be emphatic
about calling online defragmentation *broken* and seem outraged that
no one else seems to be discussing or working this issue.  Why is this
a high priority issue for you?

Thanks,

					- Ted

