Return-Path: <linux-ext4+bounces-14704-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id x5H9ImEDrWncxAEAu9opvQ
	(envelope-from <linux-ext4+bounces-14704-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sun, 08 Mar 2026 06:04:33 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD90222E8AE
	for <lists+linux-ext4@lfdr.de>; Sun, 08 Mar 2026 06:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17A003024507
	for <lists+linux-ext4@lfdr.de>; Sun,  8 Mar 2026 05:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD0C23EA8B;
	Sun,  8 Mar 2026 05:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="j6JPit4J"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2DC1548C
	for <linux-ext4@vger.kernel.org>; Sun,  8 Mar 2026 05:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772946268; cv=none; b=mK+AKLnRflUOVXSdNNEtCjpvtz5CnJC4V2CIVodu52uHPigUMZzMpY7DLKyNez3sjQ2WFmGWX1cSTZnDytTN+68Z8SaVjf/t+ENQXXqY2zJY+1EKcPfI9ePeHf/ozat2wQCDuyLYczC3cJocXwG57cEKnGrPMRIv7D9xlJHW0o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772946268; c=relaxed/simple;
	bh=6EYJJa7iQzv4zQEfg5Ye/lzcHHUN67TUE8+g+2SBajc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNWOLa4SjfGSbxJ3byiQ9uYRvZucyoQvA4zY3nM75cX1HJ+hLv6BLlCI5N0GgsOtHcniYJv3z0DMidNUq9joKzVgYaxEXzTfxUxwE5EvyQR/vVSlKModpp4a3OQhHDgNsDMY8h0nRVMa83ogXL4i7XQKhybWyULhLmml+YdsbOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=j6JPit4J; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([76.148.192.212])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 6285447q022335
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 8 Mar 2026 00:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1772946249; bh=V1j++RJnmClxNB3myTBSIav7vvmuiq7Jeu39DTxtlo0=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=j6JPit4JYsE4nsEl8uQpOfLt7SN1DhKI1A52S7xJkfVadHSIbt0B5PFuMwUEGQMh0
	 cVdH+W+OCdJQphLFSAePYhX/7pgtVV62cAAHqQ4ORM40qKz/9GCK45i9hEs5v03sg6
	 cnVKMLlWEa1iWpFGyon4mvAkqAg5qGSGUUeYLkiqn0yL0QTfWAhkLYAkDworCc7slt
	 1q3/U/cNyJ9764QWYbEWn0EZ9F6zo0xFxYJGyI9lkVdyTgnSbvdZ3URq6emVbX2ZEO
	 LUf2u1OkXA/fqf7aT7GcCGIfrtUNr2Mne60QvTx+uQKFzeUeUU02v6U6vfL1Yiks6C
	 toOFPgk+NlhKw==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 5CA8E5C13172; Sun,  8 Mar 2026 00:04:03 -0500 (EST)
Date: Sun, 8 Mar 2026 00:04:03 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Daniel Tang <danielzgtg.opensource@gmail.com>
Cc: linux-ext4@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH e2fsprogs] e2fsck: preen inline data no attr
Message-ID: <20260308050403.GA61017@macsyma.local>
References: <3188418.mvXUDI8C0e@daniel-desktop3>
 <2415922.vCJZsxu672@daniel-desktop3>
 <20260306222315.GA42132@macsyma.local>
 <25105329.ouqheUzb2q@daniel-desktop3>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25105329.ouqheUzb2q@daniel-desktop3>
X-Rspamd-Queue-Id: CD90222E8AE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14704-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[mit.edu:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-ext4];
	NEURAL_HAM(-0.00)[-0.965];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kronis.dev:url]
X-Rspamd-Action: no action

On Sat, Mar 07, 2026 at 08:42:04PM -0500, Daniel Tang wrote:
> 
> 
> > More importantly, information about the source of the inconsistency
> > report would be written to the superblock
> 
> What could have the opportunity to write anything to the superblock?
> Before a panic, there's no inconsistency.

I don't know that.  It's possible that the kernel could have detected
an inconsistency, and if you've left the default errors=continue
behavior, this will cause a EXT4-fs error log, but if people don't pay
attention to the console log messages, they might not realize it.
That's why I needed to rule it out.

> After a panic, Linux would
> say "not syncing", or after a panic, hardware stops before new writes
> can reach the disk. systemd, as shown by `systemd-analyze plot` runs
> fsck before attempting any `.mount`.

The problem is that *if* the file system does not have ERROR_FS set
before the crash, *then* the fsck log that you sent me can't
*possibly* have been the first fsck run after the crash.

That's because this message:

root@daniel-tablet1:~# fsck.ext4 -p /dev/nvme0n1p7 # For example
/dev/nvme0n1p7 contains a file system with errors, check forced.

... means that the ERROR_FS bit has already been set.  And the only
two entities that could have set that bit is (a) the kernel, or (b)
fsck.ext4.

Now yes, most distributions will run fsck before mounting.  But
normally, all fsck.ext4 will do is replay the journal (if necessary),
and then perform basic sanity checks on the superblock.  It doesn't do
a full check of the file system unless (1) something is obviously
wrong with the superblock, (2) the ERROR_FS bit is set (check forced
message above), or (3) the user has explicitly requested a full fsck
by running fsck with the -f flag.

So if the theory that the ERROR_FS bit was not set by the kernel is
correct, then there must be an fsck run where (a) the "check forced"
message is not present (so the ERROR_FS bit is not yet set), and (b)
the fsck log shows that the fsck ran into some kind of major
difficulty or something obviously wrong with the file system leading
to the ERROR_FS bit being set.  It was this log that I was asking if
you could find, since the one that you sent me had the "checked force"
message, meaning ERROR_FS was already set.

> Inline data is for mostly-reading
> 30,000 mostly-small Javascript files totalling 100 MiB.

You actually have a lot of Javascript files which are smaller than 160
bytes or so?  That's.... surprising.

>  Fast commit is
> for monthly-apt-upgrading 250,000-max (TeX Live) 300-average
> (google-chrome-stable) files totaling 64 GiB-max 2 GiB-average.

Fast commit only happes if you have workloads where you need fsync(2)
to be fast, and you don't mind writing some extra blocks 5 seconds
later when the large (non-fast) journal commit takes place.

> * apt-get is 7% (48.018 s) faster with fast_commit writes

That's.... surprising.

Ah... looking at what you were doing, it appears you were setting
fast_commit not on the root file system itself, but on the file system
where /var/lib/containerd is located.  I'm going to guess that fsync's
being issued by apt are getting amplified by whatever
docker/containerd is doing with the writes plus fsync's to the
writeable image layer file.

If that's your actual use case, try installing the apt-eatmydata
package in your Dockerfile, and/or before you do this:

# time docker run --rm -v /run/archives:/mnt ubuntu:24.04 bash -c 'dpkg --force-all -i /mnt/*.deb ; sync'

If you were just using this as a proxy for your real world use
case.... I'd suggest finding a different way of measuring the benefits
of fast commit.  That is, if what you *really* care about is running
"apt get" on real, bare metal system (and not in your containers),
then you need to measure that.  Trying to use docker run as a proxy is
going to be misleading.

But if you are really trying to improve container build times, see this article:

https://blog.kronis.dev/blog/increase-container-build-speeds-when-you-use-apt

It uses the eatmydata package directly, instead of using
"apt-eatmydata", but it basically points out why having apt issue a
huge number of fsync on what are generally disposable images in a CI
run, or while building new docker images, is just waste of resources.

Cheers,

						- Ted

