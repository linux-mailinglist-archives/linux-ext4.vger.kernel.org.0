Return-Path: <linux-ext4+bounces-775-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF1D82B4F8
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jan 2024 19:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5786B2239D
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jan 2024 18:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA54654BD7;
	Thu, 11 Jan 2024 18:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ZkTHIsZp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5FF524A8
	for <linux-ext4@vger.kernel.org>; Thu, 11 Jan 2024 18:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-100.bstnma.fios.verizon.net [173.48.116.100])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 40BIxUMO029748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 13:59:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1704999572; bh=gcMsWKBHfHITg90LTV5PJyLcI8YcXQhS+yVAEbZ7a1Q=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=ZkTHIsZpdNnL3WQfqmiUyWvO6IYSdWBC+aI5ThXCi3D8fYjJnstaa3jiX1WBQIW/+
	 ROdWOY8SsW1AuFec7bsdnroWT6Xaiqq8hmyCEGrjfEAtA1/zGcN1O/SHgWkxTZjNe6
	 wb5K4/M1wEwd/XsVhNWafA96OJLmu9LODNO3Ej1uYV2gXPceYgIwDqegUZ7VUXsyOD
	 UO5q3RGUneAIHALri3/jZKdBGK+x5fRDH13GOjcb1h1JM8KdqIUwF7efTUKQmICeuk
	 2xv0jeyfQdUy9hSMHbPe16KIPlyQWyVswJ1IhRtzshh30lwIqQ/YDQGTlOo4DjvA1o
	 q+n/LZ3so5Cng==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 12EBB15C0276; Thu, 11 Jan 2024 13:59:30 -0500 (EST)
Date: Thu, 11 Jan 2024 13:59:30 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Allen <allen.lkml@gmail.com>
Cc: linux-ext4@vger.kernel.org, jack@suse.cz,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Allen Pais <apais@linux.microsoft.com>,
        kelseysteele@linux.microsoft.com, tyhicks@linux.microsoft.com
Subject: Re: EXT4-fs: Intermitent segfault with memory corruption
Message-ID: <20240111185930.GA911245@mit.edu>
References: <CAOMdWS+A8-5yT+_O+7xmyVvAfZmEsDr7nDwWHtLWLeefmDFqOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMdWS+A8-5yT+_O+7xmyVvAfZmEsDr7nDwWHtLWLeefmDFqOA@mail.gmail.com>

On Thu, Jan 11, 2024 at 07:26:06AM -0800, Allen wrote:
> 
> I hope this email finds you well. We are reaching out to report a
> persistent issue that we have been facing on Windows Subsystem for
> Linux (WSL)[1] with various kernel versions. We have encountered the
> problem on kernel versions v5.15, v6.1, v6.6 stable kernels, and also
> the current upstream kernel. While the issue takes longer to reproduce
> on v5.15, it is consistently observable across these versions.

You've tried reproducing (successfully) the problem across multiple
kernel versions.  Have you tried reproducing this on multiple
different hardware platforms?  e.g., with different desktops and/or
servers, and with different storage devices?

The symptoms you are reporting are very highly correlated with
hardware problems, or in the case where you are running under
virtualization, with bugs in the VMM and/or the host OS's storage
stack.

In particular, these errors:

> EXT4-fs error (device sdc): ext4_find_dest_de:2092: inode #32168:
> block 2334198: comm dpkg: bad entry in directory: rec_len is smaller
> than minimal - offset=0, inode=0, rec_len=0, size=4084 fake=0
> 
> and
> 
> EXT4-fs warning (device sdc): dx_probe:890: inode #27771: comm dpkg:
> dx entry: limit 0 != root limit 508
> EXT4-fs warning (device sdc): dx_probe:964: inode #27771: comm dpkg:
> Corrupt directory, running e2fsck is recommended
> EXT4-fs error (device sdc): ext4_empty_dir:3098: inode #27753: block
> 133944722: comm dpkg: bad entry in directory: rec_len is smaller than
> minimal - offset=0, inode=0, rec_len=0, size=4096 fake=0

... sesem to hint that ext4 has read a directory block where all or
part of its contents have been replaced with all zeros (hence the
record length, or the hash tree index, is zero).  That typically is
caused by a hardware and/or VMM problem.

> or we see a segfault message where the source can change depending on
> which command we're testing with (dpkg, apt, gcc..):
> 
> dpkg[135]: segfault at 0 ip 00007f9209eb6a19 sp 00007ffd8a6a0b08 error
> 4 in libc-2.31.so[7f9209d6e000+159000] likely on CPU 1 (core 0, socket
> 0)

And this could very well be because a data block has been replaced
with garbage, or the wrong data block, or all zeroes.

It might also be load related --- that is, the problem only shows up
the system is more heavily loaded, which might explain when enabling
debugging causes the problem to be harder to reproduce.


I am very doubtful that the problem is in the ext4 code proper,
especially since no one else has reported this problem, and at $WORK,
we are running continuous testing where we are running fstests runs on
ext4 against a wide range of hardware (e.g., HDD's, SSD's, iscsi,
etc.) and hardware platforms (arm64 and x86).  And that's just for our
data center kernels which are based on various LTS kernels.  For
Google's Compute Optimized OS, which is used in both 1st party and 3rd
party VM's in Google Cloud VM's, we are doing similar testing using
gce-xfstests[1] on a continuous basis, and we haven't seen the kind of
bugs that you are reporting.

[1] https://thunk.org/gce-xfstests.

For that matter, I am regularly running gce-xfstests for ext4's
upstream development, and other ext4 developers run fstests using
kvm-xfstests and fstests on a varriety of different hardware devices
and virtualization environments.  So that tends to suggest that the
problem is either in the hardware or virtualization environment (WSL)
that you are using.


So to that end, you might want to consider running some lower-level
tests --- for example using fio with data verification enabled.  We
also get a huge amount of mileage using fstests to detect problems
lower in the file system stack.  This is why we use fstests/xfstests
on ext4 for essentially every single storage device (such as iSCSI,
HDD, Flash, etc.)  So setting up fstesets on a variety of file systems
and storage devices is not a bad idea.

It shouldn't be difficult to take the test appliance in
kvm-xfstests[2][3] and getting it to work under WSL.  (For example,
over the holidays, I've gotten fstests running on MacOS on a Macbook
Air M2 15" using the hvf framework.)  However, I suggest that you
focus on lower-level block and memory stress testing before worrying
about how to run fstests under WSL.

[2] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md
[3] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-xfstests.md

Cheers,

					- Ted

