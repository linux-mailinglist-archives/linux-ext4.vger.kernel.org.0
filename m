Return-Path: <linux-ext4+bounces-10338-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6BAB91290
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Sep 2025 14:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4E516EE41
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Sep 2025 12:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB8B3081B3;
	Mon, 22 Sep 2025 12:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="TMjlb1EN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9592F1FE5
	for <linux-ext4@vger.kernel.org>; Mon, 22 Sep 2025 12:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758544894; cv=none; b=IuUxTBB8ExWyASOwH2UfCeMxkOEZ21wwiUSGLf6aTSxun0p/GJGFIGl6DnogSAwCHEnb5Sozwkw6SEltqU3aCrJZyeJZpth0MUX60e8EORJ0Cs1eOSQxjwvxI6JKk07VY2R54O5jw1CLWvUYhQ/sHltdZVk3Y4xy1RYW6B5dTjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758544894; c=relaxed/simple;
	bh=+9zM8Z0wJMBL/0C4fb6dgOaL1ezJIfjcloYlf/Qa4Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OO37p+u4M1Mt4LIcfRHKmHnqaMBcG2KjDtyZ8x7FPjPfJMQ2t/N0ZFnuftCvixB+VmqnNj//d6eY6YQjlMjaYZzWjpVnSSpT2ZkexKYrowVgLzmjlLe3JlAN4IJG1H6C6Sj6wm32MKRH6M1dhadAndL/rM9GQdfAKLa6J+ih51s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=TMjlb1EN; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-223.bstnma.fios.verizon.net [173.48.111.223])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58MCfTbc016338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 08:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1758544890; bh=F3+BWwj1rXkakMLVijJiD6JcCO1Ht43VWGBCbgK0+1Y=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=TMjlb1ENCqxoHcyVsEqGpFEBQas1uWeEK9SbhuM/XfHx6gKThgXaGDAGT+RmseuX9
	 6/Tbjg3r/0LOYgtLMwmocAMstoTZRGvR1lJ5+htkzdds1eQ7AzFGxJ/jLWUyYYBG+w
	 LSwE5IY5v5gCK0xZDiuRD8Ligf7Itx+xYbdq0yNWXdR7C7FA/W3xkP5iw5kLLM/AHc
	 WQpc0egNPA28MN9LdEfcoEnpY34GFp/x63eAX9vUzm6HNTQ+Fv3alDn6YgFVUb1a8C
	 +USCxQZWP4cqE+c5lro4+KH7kYWcqA4+7TU4pLL9Wn2t0PWd1JtQG6WCSGLduxkHoy
	 s+ra12lesF9CQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id E5F822E00D9; Mon, 22 Sep 2025 08:41:28 -0400 (EDT)
Date: Mon, 22 Sep 2025 08:41:28 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andrea Biardi <Andrea.Biardi@viavisolutions.com>
Cc: linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: ext4: failed to convert unwritten extents (6.12.31 regression)
Message-ID: <20250922124128.GD481137@mit.edu>
References: <BN9PR18MB4219FBD6D79413965DDEFA6D9812A@BN9PR18MB4219.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR18MB4219FBD6D79413965DDEFA6D9812A@BN9PR18MB4219.namprd18.prod.outlook.com>

On Mon, Sep 22, 2025 at 11:11:15AM +0000, Andrea Biardi wrote:
> 
> The CI process of a product that I'm working on involves the creation of a temporary KVM VM which boots a cdrom image containing a custom kernel + busybox in order to flash a filesystem image to /dev/vda, then shuts it down and exports the VM (that's my "deliverable" for the next stage).
>
> [  174.903010] I/O error, dev vda, sector 167922 op 0x1:(WRITE) flags 0x0 phys_seg 2 prio class 0
> [  174.903023] I/O error, dev vda, sector 167938 op 0x1:(WRITE) flags 0x4000 phys_seg 254 prio class 0
> [  174.903027] I/O error, dev vda, sector 169970 op 0x1:(WRITE) flags 0x0 phys_seg 2 prio class 0
> [  174.903031] EXT4-fs warning (device vda1): ext4_end_bio:353: I/O error 10 writing to inode 16 starting block 84985)

The failure is coming from the block device, which in your case, is
the virtio device.  The only causes for this are:

1)  An underlying hardware failure
2)  A bug in the block virtio device
3)  A bug in the VMM (I assume qemu in your case).

The bug might be triggered by a change in the behavior of ext4, but
ultimately, there is nothing that a file system can do that could
result in an I/O error other than (1), (2), or (3), above.

The only thing I can suggest is to do a full bisection between 6.12.30
and 6.12.31.  Or take a look at commits that were landed between
6.12.30 and 6.12.31, focusing on changes in /drivers/block,
/drivers/virtio, and /block.  I doubt that it's /block, given that no
one else is reporting it.

One other thing you might to try is to changing your qemu
configuration to use virtio-scsi or NVMe emulation.  Most commercial
cloud products (e.g., Amazon, Azure, Google Cloud) tend to use
emulated SCSI and NVMe, instead of virtio-blk.  It's true that
virtio-blk is more efficient, but the virtual SCSI and NVMe devices
are more similar to Real Hardware(tm), which is why commercial cloud
products tend to use them; they tend to easier for companies doing
"lift and shift".  As a result, it's likely that issues with
virtio-blk might not be noticed, given that it gets fewer amounts of
testing.

I do regular regression testing of ext4 using Google Cloud[1], and it
uses either SCSI or NVMe devices (depending on whether the VM type
supports SCSI or NVMe --- the more expensive, higher performance VM's
tend to use NVMe because allows better performance for the
high-performance block devices).  While I *can* run kvm-xfstests using
virtio-blk, but when gce-xfstests takes 2-3 hours of wall clock time
(running on a dozen VM's running in parallel), or 24 hours if I were
to run the identical tests using kvm-xfstests, there's a reason why I
rarely use kvm-xfstests/qemu-xfstests.  If I'm someplace without
network access, and all I have is qemu using MacOS's Hypervisor
Framework (hvf) on my Macbook Air, sure, I'll use qemu-xfstests.  But
it's not something I'll do unless I don't have any other alternatives.

[1] https://thunk.org/gce-xfstests

Cheers,

						- Ted

