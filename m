Return-Path: <linux-ext4+bounces-8257-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB57ACA089
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Jun 2025 00:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D8F3B2D9B
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Jun 2025 22:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502C81E1E0C;
	Sun,  1 Jun 2025 22:04:33 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355D4282FA
	for <linux-ext4@vger.kernel.org>; Sun,  1 Jun 2025 22:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748815473; cv=none; b=RRFZ4xJUml5wdFxnaCj7bRObER7hhY1KNAVx5EOHZXvSc+S9YD2G2TRaEc7yIj+X3AghRkySyxuUMmqOpTYTHHY6aJXJOJpx5P6PT/X8TBul2o1evhr2+dPMqYqHMZLRHeKFV0h2chIhOinICyX1Y7Od4xGdlwBvlBGMxXA9VdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748815473; c=relaxed/simple;
	bh=imxTdTnBUZGO0XN/H0Ec4YSt+wTy7W5Jfozf5OWTpY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gb9NdlJxounBrQUOxDqPaOXuM7dodv49EXUUJ6KbBzKC0wW1sbEHGo4Q+GwDijsGgeqSpDGtUEVR/8c1GUwASkqoS1Ageq/lgYY+D4Hy93IvpmNtezo2mBDNIocEdxj9F+fsaHVBv5q3ZNzZbzkatra9Q/Bs2z3cRkD4HIzil/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([193.243.188.32])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 551M4IWq029361
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 1 Jun 2025 18:04:20 -0400
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 36EF5345CC6; Sun, 01 Jun 2025 18:04:18 -0400 (EDT)
Date: Sun, 1 Jun 2025 22:04:18 +0000
From: "Theodore Ts'o" <tytso@mit.edu>
To: Mitta Sai Chaithanya <mittas@microsoft.com>
Cc: "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Nilesh Awate <Nilesh.Awate@microsoft.com>,
        Ganesan Kalyanasundaram <ganesanka@microsoft.com>,
        Pawan Sharma <sharmapawan@microsoft.com>
Subject: Re: EXT4/JBD2 Not Fully Released device after unmount of NVMe-oF
 Block Device
Message-ID: <20250601220418.GC179983@mit.edu>
References: <TYZP153MB06279836B028CF36EB7ED260D761A@TYZP153MB0627.APCP153.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYZP153MB06279836B028CF36EB7ED260D761A@TYZP153MB0627.APCP153.PROD.OUTLOOK.COM>

On Sun, Jun 01, 2025 at 11:02:05AM +0000, Mitta Sai Chaithanya wrote:
> Hi Team,
>
> I'm encountering journal block device (JBD2) errors after unmounting
> a device and have been trying to trace the source of
> these errors. I've observed that these JBD2 errors only
> occur if the entries under /proc/fs/ext4/<device_name> or
> /proc/fs/jbd2/<device_name> still exist even after a
> successful unmount (the unmount command returns success).

What you are seeing is I/O errors, not jbd2 errors.  i.e.,

> 2025-06-01T10:01:11.568304+00:00 aks-nodepool1-44537149-vmss000002 kernel: [30452.346875] nvme nvme0: Failed reconnect attempt 6

These errors may have been caused by the jbd2 layer issuing I/O
requests, but these are not failures of the jbd2 subsystem.  Rather,
that _apparently_ ext4/jbd2 is issuing I/O's after the NVMe-OF
connection has been torn down.

It appears that you are assuming once umount command/system call has
successfuly returned, that the kernel file system will be done sending
I/O requests to the block device.  This is simply not true.  For
example, consider what happens if you do something like:

# mount /dev/sda1 /mnt
# mount --bind /mnt /mnt2
# umount /mnt

The umount command will have returned successfully, but the ext4 file
system is still mounted, thanks to the bind mount.  And it's not just
bind mounts.  If you have one or more processes in a different mount
namespace (created using clone(2) with the CLONE_NEWNS flag) so long
as those processes are active, the file system will stay active
regardless of the file system being unounted in the original mount
namespace.

Internally inside in the kernel, this is the distinction between the
"struct super" object, and the "struct vfsmnt" object.  The umount(2)
system call removes the vfsmnt object from a mount namespace object,
and decrements the refcount of the vfsmnt object.

The "struct super" object can not be deleted so long as there is at
least one vfsmnt object pointing at the "struct super" object.  So
when you say that /proc/fs/ext4/<device_name> still exists, that is an
indication that "struct super" for that particular ext4 file system is
still alive, and so of course, there can still be ext4 and jbd2 I/O
activity happening.

> I'd like to understand how to debug this issue further to determine
> the root cause. Specifically, I’m looking for guidance on what
> kernel-level references or subsystems might still be holding on to
> the journal or device structures post-unmount, and how to trace or
> identify them effectively (or) is this has fixed in latest versions
> of ext4?

I don't see any evidence of anything "wrong" that requires fixing in
the kernel.  It looks something or someone assumed that the file
system was deactivated after the umount and then tore down the NVMe-OF
TCP connection, even though the file system was still active,
resulting in those errors.

But that's not a kernel bug; but rather a bug in some human's
understanding of how umount works in the context of bind mounts and
mount namespaces.

Cheers,

						- Ted

