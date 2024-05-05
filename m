Return-Path: <linux-ext4+bounces-2298-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4648BBEE1
	for <lists+linux-ext4@lfdr.de>; Sun,  5 May 2024 02:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC7C21C20CC1
	for <lists+linux-ext4@lfdr.de>; Sun,  5 May 2024 00:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2DE393;
	Sun,  5 May 2024 00:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="AjaBLyRz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EEDEDB
	for <linux-ext4@vger.kernel.org>; Sun,  5 May 2024 00:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714867840; cv=none; b=EnTol9XLVYI2EMdQJZ3ks/+6SirEAr0f3lI+JHOb1EmkA0h62qFXA3GjwgSfAKPtLUlb2YsJJR1lEoXn5qIGppOo83u1zx2NaEsOISxm3YEqzyMt0zqIZqrnMM6lwQ6z4LUbauB1yjdP8zf7wImzWj3nCGFqyOosIsXTFK9sssg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714867840; c=relaxed/simple;
	bh=jF2NdUALa8sual+a6XSSrwsYeAXH+PUBBB2vBEM/lvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYpnVsZHYwoYW+r+fgeJXknQTBPvQMQ0l/QEf86l2FX5NzAY0K72BrGZPq7aL0IHyXPJFU39Tub1gUu65drV23bO/C/m6e51FrFUREG0gRuCy/if+ATzhZbQpesWncmbTEMJ1lh+Mdu3yFHfxo5FZITbXX7oseUEsuEZhirnLJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=AjaBLyRz; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4450AKxt020303
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 4 May 2024 20:10:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1714867822; bh=01efa2dyqYmsYf0FCXXN7naReTzTT/BKirs1cMVGVXs=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=AjaBLyRza7+12xlWDxXN7RJNYibYkb9akv3uBhFRv2cUDP/fcU54wSiS0zAtGIw+Z
	 5DSqq9k2TiAGby25cT+4UGbYJktUYUFh+UhIWd8X9cPNhkS1NhmE2Ob757GDNlGDcl
	 L5jW/Y5ObtslfmC6lrKIwsYw/9+6P8dNnzcbrBfHIOTchueBEcVWxMCVscyqME5Vq0
	 P79e1+pstIVyVAmF56r22pzBEMz7UDj7AmrRX8IWl13TbtW6n60Fg29DSPv11YutJT
	 RN3WRtpO9qlODN6fX1cAKQBptAu10d/Ggugss3EoIlesy/0biVpPyIn7ADysCutbOL
	 czvON0GKZ5l7g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 795FF15C02F7; Sat, 04 May 2024 20:10:20 -0400 (EDT)
Date: Sat, 4 May 2024 20:10:20 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Johannes Schauer Marin Rodrigues <josch@mister-muffin.de>
Cc: linux-ext4@vger.kernel.org
Subject: Re: created ext4 disk image differs depending on the underlying
 filesystem
Message-ID: <20240505001020.GA3035072@mit.edu>
References: <171483317081.2626447.5951155062757257572@localhost>
 <171484520952.2626447.2160419274451668597@localhost>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171484520952.2626447.2160419274451668597@localhost>

On Sat, May 04, 2024 at 07:53:29PM +0200, Johannes Schauer Marin Rodrigues wrote:
> > 
> > Any idea what is going on?

The fundamental issue has to do with how ext2fs_zero_blocks() in
lib/ext2fs/mkjournal.c is implemented.

> The "Lifetime writes" being much higher on fat32 suggests that despite
> "nodiscard", less zeroes were written out when ext4 or tmpfs are the underlying
> FS?

Yes, that's exactly right.

The ext2fs_zero_blocks() function will attempt to call the io
channel's zeroout function --- for Unix systems, that's
lib/ext2fs/unix_io.c's __unix_zeroout() function.  This will attempt
to use fallocate's FALLOC_FL_ZERO_RANGE or FALLOCATE_FL_PUNCH_HOLE to
zero a range of blocks.  Now, exactly how ZERO_RANGE and PUNCH_HOLE is
implemented depends on whether the "storage device" being accessed via
unix_io is a block device or a file, and if it is a file, whether the
underlying file system supports ZERO_RANGE or PUNCH_HOLE.

Depending on how the underlying file system supports ZERO_RANGE and/or
PUNCH_HOLE, it may simply manipulate metadata blocks (e.g., ext4's
extent tree) so that the relevant file offsets will return zero --- or
if the file system doesn't support unitialized extent range, and/or
doesn't support sparse files, the file system MAY write all zeros, or
the file system MAY simply return an EOPNOTSUPP error, or the file
system MAY issue a SCSI WRITE SAME or moral equivalent for UFS, NVMe,
etc., if the block device supports it (and this might turn into a
SSD-level discard, so long as it is a reliable discard).  And of
course, if unix_io is accessing a block device, depending on the
capabilities of the storage device and its connection bus, this might
also turn into a SCSI WRITE SAME, or some other zeroout command.

Now, the zeroout command doesn't actually increment the lifetime
writes counter.  Whether or not it should is an interesting
philosophical question, since it might actually result in writes to
the device, or it might just simply involve metadata updates, either
on the underlying file (if the file system supports it), or
potentially in the metadata for the SSD's Flash Translation Layer.  At
the userspace level, we simply don't know how FALLOC_FL_ZERO_RANGE and
FALLOC_FL_PUNCH_HOLE will be implemented.

In the case of FAT32, the file system doesn't support sparse files,
and it also doesn't support unitialized extents.  So
FALLOC_FL_ZERO_RANGE and FALLOC_FL_PUNCH_HOLE will fail on a fat32
file system.  As a result, ext2fs_zero_blocks() will fall back to
explicitly writing zeros using io_channel_write_blk64(), and this
*does* increment the lifetime writes counter.

If you enhance the script by adding "ls -ls "$imgpath" and "filefrag
-v "$imgpath" || /bin/true", you can see that the disk space consumed
by the image file varies, and it varies even more if you use the
original version of the script that doesn't disable lazy_itable_init,
discard, et.al.

Unfortunately tmpfs and fat don't support filefrag -v, but you could
see the difference if you write a debugging program which used lseek's
SEEK_HOLE and SEEK_DATA to see which parts of the file are sparse
(although it won't show which parts of the file are marked
unitialized, assuming the file system supported it).


If your goal is to create completely reproducible image files, one
question is whether keeping the checksums identical is enough, or do
you care about whether the underlying file is being more efficiently
stored by using sparse files or extents marked unitialized?

Depending on how much you care about reproducibility versus file
storage efficiency, I could imagine adding some kind of option which
disables the zeroout function, and forces e2fsprogs to always write
zeros, even if that increases the write wearout rate of the underlying
flash file system, and increasing the size of the image file.  Or I
could imageine some kind of extended option which hacks mke2fs to zero
out the lifetime writes counter.;

Cheers,

						- Ted

