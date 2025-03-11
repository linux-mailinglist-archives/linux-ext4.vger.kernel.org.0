Return-Path: <linux-ext4+bounces-6760-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB25A5B38D
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Mar 2025 01:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 956D13AC2B1
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Mar 2025 00:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4B117991;
	Tue, 11 Mar 2025 00:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="K9upOOfD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EF62F56;
	Tue, 11 Mar 2025 00:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741653084; cv=none; b=EPdrlz6oY6459w5g2NzMjDbokYGSk0RxznCczbsyn0z5qNsm+OM2ag5Tb2okHR+nwxAIPgYzjVC7y1yCzc8MGNoNnVWa+V978ehbS2095rRts3T1zJJ7/khm6jF5ISlns6UOPBCQuzXK4znMjZLKp0v1NJeAV9E/Tal/fWc61SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741653084; c=relaxed/simple;
	bh=T9w6KihRoX8bgA8hWx1apTzRQCqkiWATn7fZq5th0d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpKiYY1OzTm6eWz4fMRNP3YqpqiL/gysZ0aV5C5z/Sjj+RTOpsQ9Kc8/nRNnZRwfH3jTRwh6gIRw4iy/6DgWwK620bQpwd/ZCa9oQBXs9qb9xu8Q2TeASWJU3dc1j9J79l9446Pmu1YyDcWkOP5wOgB/rB4QEYItSTgEgp4217A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=K9upOOfD; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gqRNEveY7/5xwtxtJNyROpZPd6ag4ZqoCv2uixoebdg=; b=K9upOOfDO52LArB/3G4STeiQzx
	G9NIjiM3tozZf+i+0Vqr50yyoxR9AyNeXvSw0NbJMAyXAizEF0/mHtAjoUGSgVnwLoq+/dtzTlCv7
	K4CDquUSSrVvVlWWikGlIXpgW64q3pSxkJI5DsfxW5AEStcaVfRwV7yAVXsfqCEa/gNil+mxeiuVJ
	1bFRJNmZAqxrfBBm/5NmDPtXp3s46WjSA+3SK+10vgMXK8wRjHbdM0qRrJPZLM2mSWEXWHeXPAwXK
	zmqKUNIuiO8baRsi+kZSJvwqpBYxHAEUG09rvo7TVClD+ZJJi6Zv35FL9//7dqnxHQVp06q0DTfFD
	mCxW7H7g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1trnWh-00000002wZS-2S3y;
	Tue, 11 Mar 2025 00:31:19 +0000
Date: Tue, 11 Mar 2025 00:31:19 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: David Laight <david.laight.linux@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>, "Artem S. Tashkinov" <aros@gmx.com>,
	linux-ext4@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A syscall for changing birth time
Message-ID: <20250311003119.GM2023217@ZenIV>
References: <bda3fa3f-dd12-40de-841a-e4c216ab533f@gmx.com>
 <20250310135828.GB8837@mit.edu>
 <20250310221243.0d5db7b3@pumpkin>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310221243.0d5db7b3@pumpkin>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Mar 10, 2025 at 10:12:43PM +0000, David Laight wrote:
> On Mon, 10 Mar 2025 09:58:28 -0400
> "Theodore Ts'o" <tytso@mit.edu> wrote:
> 
> > On Mon, Mar 10, 2025 at 07:26:00AM +0000, Artem S. Tashkinov wrote:
> > > 
> > > Why is it that the Linux kernel supports reading btime, but there's no
> > > syscall to change it? At least for ext4 there's the debugfs utility, but
> > > for other filesystems there's just nothing. And even debugfs is not a
> > > solution, since it requires root privileges and an unmounted/mounted RO
> > > filesystem.  
> > 
> > POSIX and Single Unix Specification also doesn't provide a way to
> > allow userspace to set ctime (inode change time).  That's because the
> > definition of "change time" is defined to include the time to change
> > anything about the inode metadata --- including the inode timestamps.
> > 
> 
> I'm sure that hadn't used to be the case.

You are incorrect.

> But as some point the 'ctime' changed from something that was usually
> the file create time (for some definition of create) to a pretty useless
> time that is almost a waste of disk space.

Which point would that be, considering that v6 inodes have only two timestamps
(atime and mtime), while in v7 e.g. chmod() definitely does update ctime?

sys/sys4.c:chmod():
        ip->i_flag |= ICHG;
	...
	iput(ip);
sys/iget.c:iput():
        if(ip->i_count == 1) {
		...
		iupdat(ip, &time, &time);
sys/iget.c:iupdat():
                if(ip->i_flag&ICHG)
			dp->di_ctime = time;

And filesys(5) has this:
.I Di_ctime
records the time of last modification
to the inode or to the file, and is used
to determine whether it should be dumped.

... which ought to answer the question about the intended use of that thing.
Hopefully useful mnemonics for your next attempt at UNIX101:
	A: Accessed
	M: contents Modified
	C: Changed in any way, including metadata

