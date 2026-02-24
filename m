Return-Path: <linux-ext4+bounces-13998-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEWIHf8knmn5TgQAu9opvQ
	(envelope-from <linux-ext4+bounces-13998-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 23:23:59 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCBB18D1BB
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 23:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5103F305F7FE
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Feb 2026 22:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE913446CE;
	Tue, 24 Feb 2026 22:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaBiDpVY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177F833E346;
	Tue, 24 Feb 2026 22:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771971821; cv=none; b=XOMtRwHU8uhIm8E9dqfLTJoUl+1wZEgYweWEbYJ1MO+W2d7H/Cm+9xKep5l1NvqbdjSkDQvqNORd0jT4S3MyID8nOk1OFbKq3VsBelsvAW4C0x1pOF5TVb+kfQ8gttO3lf8mcyu7uLZ6eDpc0XiZcV0QgRb/FY2cb9EBPfYeQj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771971821; c=relaxed/simple;
	bh=CpcMS+Xsz40lEJsMSut0/p9gAz9vj4fhBKWBg0+TCi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4TsUSKcADuuBgl/6UelqGwtfeBqTEgwjphWcZdE8iTVBlikwZTrRW/xCTM4eiR6I+VZPuCnxQIXPJGcq2ob2A9B+ExY3atAThaAcjQvJPWROaEmGq//pgtVRr4zGCeT6qRNb6XPM9UUnChHwpTPN1ompns30t7mlVq0RNlFynA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaBiDpVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F36AC116D0;
	Tue, 24 Feb 2026 22:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771971820;
	bh=CpcMS+Xsz40lEJsMSut0/p9gAz9vj4fhBKWBg0+TCi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SaBiDpVYIovuzWHBF7yVzTZreyYH3f1j+T6NUuuD6EKeN5uAHrmg22coLg7EFsC/4
	 d1DIDx1zORXhjecLAeGyJihaiYC/IB9LvzKzH604Z7WJ0K/UD9oNylWYz8h5ygXDrZ
	 C/1p4PxFMjfjcXzUXoXZNdTc8DvC9ujBtVCr6G14AuVYs+Fz9LeExZObLhKbioJR5f
	 3akG51HdRedCwRJj3iofhewatQg/9jV21lPLywiomAEEe8sbimVqqn/I7l8ImXDfos
	 //Y0UZQxAUcPvw+PLJQOOV+NN2drk/dz5rxSjw6y9up985H/ciLsuKJfCGzUojzqUH
	 x8yFiWMs0fvEw==
Date: Tue, 24 Feb 2026 14:23:39 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>, tytso@mit.edu,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Writing more than 4096 bytes with O_SYNC flag does not persist
 all previously written data if system crashes
Message-ID: <20260224222339.GA13823@frogsfrogsfrogs>
References: <3d8f73f4-3a64-4a86-8fc9-d910d4fa3be1@gmail.com>
 <aZ2599dwNuqPQgzB@infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ2599dwNuqPQgzB@infradead.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13998-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,mit.edu,dilger.ca,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-ext4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ECCBB18D1BB
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 06:47:19AM -0800, Christoph Hellwig wrote:
> A lot of folks have already explained the O_SYNC semantics correctly,
> but I have another major question about your test case.
> 
> On Wed, Feb 18, 2026 at 04:29:30PM +0300, Vyacheslav Kovalevsky wrote:
> > Detailed description
> > ====================
> > 
> > Hello, there seems to be an issue with ext4 crash behavior:
> > 
> > 1. Create and sync a new file.
> > 2. Open the file and write some data (must be more than 4096 bytes).
> > 3. Close the file.
> > 4. Open the file with O_SYNC flag and write some data.
> > 
> > After system crash the file will have the wrong size and some previously
> > written data will be lost.
> 
> The wrong size here seems incorrect.  Even if the old data written
> through the non-O_SYNC fd wasn't written out I absolutely can't see how
> the file would have an incorrect size here.  Can you please share your
> test case?

He did, way at the beginning: open a file, write 5000 bytes, close it,
open again with O_SYNC, write 300 bytes, close it, force-reboot, and
watch the file come back up with only 4096 bytes written.

I /think/ that's because generic_write_sync only flushes the range that
was dirtied by the write() call, so only the first 4k gets written back
to disk.  xfs and ext4 exhibit this behavior; vfat and btrfs persist all
50000 bytes.

--D

#!/bin/bash -x

# Let's see if a small O_SYNC write flushes the rest of the file?

dev="${1:-/dev/sda}"
mnt="${2:-/mnt}"
fstyp="${3:-xfs}"

devsz=$(blockdev --getsz $dev)
test -z "$devsz" && exit 1

umount $dev $mnt

dmsetup remove crap
dmsetup create crap --table "0 $devsz linear $dev 0"
dmdev=/dev/mapper/crap
test -b "$dmdev" || exit 1

rmmod $fstyp

wipefs -a $dmdev
mkfs.$fstyp $dmdev
mount $dmdev $mnt

xfs_io -f -c 'pwrite -S 0x58 0 50000' $mnt/a
xfs_io -s -c 'pwrite -S 0x42 10 300' $mnt/a

dmsetup suspend crap --noflush
dmsetup load crap --table "0 $devsz error"
dmsetup resume crap
dmsetup table
umount $mnt

dmsetup suspend crap
dmsetup load crap --table "0 $devsz linear $dev 0"
dmsetup resume crap

mount $dmdev $mnt
od -tx1 -Ad -c $mnt/a
stat $mnt/a
umount $mnt
dmsetup remove crap

