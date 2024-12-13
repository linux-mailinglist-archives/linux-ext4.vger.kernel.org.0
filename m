Return-Path: <linux-ext4+bounces-5628-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D245E9F11D0
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 17:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1E8D169E77
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2024 16:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBEC1E3768;
	Fri, 13 Dec 2024 16:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="QwYuToV9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07402F24
	for <linux-ext4@vger.kernel.org>; Fri, 13 Dec 2024 16:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734106367; cv=none; b=UDOQO9FEWLLnx/REcOXwB9vf2+A1YkW57iw0NG+ib3ARcPWjvu7FuSA3OvFJ+5biJmXHwPMheZuF9RarBWvWZ3XVO2IkOnjya5VR/gTrD+fUHa5IW9B9jKLLrH2h/aRSszGRttu7vabGQJjeWv21Q1aq8MXXjiyDW7sI5MG+c7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734106367; c=relaxed/simple;
	bh=IHKLIwvxCSKRMPWKFaJUk7AjboZXq91gsVNwCF5CDZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzMkcmVm1LZvu5HRFXwcM0iW02J7U0bSy9YufYlGhWSTA1p9x52nIX2h/QofRs7VbPjl5HDlp4j89V+zJG/Xt/d0rQ3SgM/KG80vQoVFki2KmQ22ra9l62SkNp3jm92lbz/solCpxTunUptkpdBihtU+Wx1FLvcUMWHypSfFWwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=QwYuToV9; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-226.bstnma.fios.verizon.net [173.48.82.226])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4BDGCVS9018707
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 11:12:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1734106353; bh=NEm0SCpvUjxoOqFN4Z2pKV8E53Q/3QgqD/lByRVqljs=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=QwYuToV9Zry4EUJjCJeedYQ8xK2r9j9vTNL+W3mHqgjsObrooX6ET0VFALC16B7s5
	 8nvfXMomy6JYmOnQchFQ/0Kg3IjIxDRCCjiXH7z+ZQD3V4aD3UnEo9stWurUuFxhOp
	 2mwuTsxzcRsWgP09sZmW2tfrttsHTNB1b93HdPeHBWSAEECClCiZ084847aIB2ICmh
	 f40pljDaUD/msPetbyNmKXQFNaJxR6GYXlGXbLI5TeoN0A5tpNj4FZ6ixcjU2Fq3tN
	 Phm78XKLO51vVl2YKOrtZ9jI0uXBdh6cWOBV2v8NIQt1Slc6eke1T99PRGi6lToYso
	 yiyuzgNzpv3fw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id D208D15C2045; Fri, 13 Dec 2024 11:12:30 -0500 (EST)
Date: Fri, 13 Dec 2024 11:12:30 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Nikolai Zhubr <zhubr.2@gmail.com>
Cc: linux-ext4@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, jack@suse.cz
Subject: Re: ext4 damage suspected in between 5.15.167 - 5.15.170
Message-ID: <20241213161230.GF1265540@mit.edu>
References: <CALQo8TpjoV8JtuYDH_nBU5i4e-iuCQ1-NORAE8uobpDD_yYBTA@mail.gmail.com>
 <20241212191603.GA2158320@mit.edu>
 <79af4b93-63a1-da4c-2793-8843c60068f5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79af4b93-63a1-da4c-2793-8843c60068f5@gmail.com>

On Fri, Dec 13, 2024 at 01:49:59PM +0300, Nikolai Zhubr wrote:
> 
> Not going to argue, but it'd seem if 5.15 is totally out of interest
> already, why keep patching it? And as long as it keeps receiving patches,
> supposedly they are backported and applied to stabilize, not damage it? Ok,
> nevermind :-)

The Long-Term Stable (LTS) kernels are maintained by the LTS team.  A
description of how it works can be found here[1].

[1] https://docs.kernel.org/process/2.Process.html#the-big-picture

Subsystems can tag patches sent to the development head by adding "Cc:
stable@kernel.org" to the commit description.  However, they are not
obligated to do that, so there is an auxillary system which uses AI to
intuit which patches might be a bug fix.  There is also automated
systems that try to automatically figure out which patches might be
prerequites that are needed.  This system is very automated, and after
the LTS team uses their automated scripts to generate the LTS kernel,
it gets published as an release candidate for 48 hours before it gets
pushed out.

Kernel developers are not obligated to support LTS kernels.  The fact
that they tag commits as "you might want to consider it for
backporting" might be all they do; and in some cases, not even that.
Most kernel maintainers don't even bother testing the LTS candidate
releases.  (I only started adding automated tests earlier this year to
test the LTS release candidates.)

The primary use for LTS kernels are for companies that really don't
want to update to newer kernels, and have kernel teams who can provide
support for the LTS kernels and their customers.  So if Amazon,
Google, and some Android manufacturers want to keep using 5.15, or
6.1, or 6.6, it's provided as a starting point to make life easier for
them, especially in terms of geting security bugs backported.

If the kernel teams for thecompanies which use the LTS kernels find
problems, they can let the LTS team know if there is some regression,
or they can manually backport some patch that couldn't be handled by
the automated scripts.  But it's all on a best-efforts basis.

For hobbists and indeed most kernels, what I generally recommend is
that they switch to the latest LTS kernel once a year.  So for
example, the last LTS kernel released in 2023 was 6.6.  It looks very
much like the last kerel released in 2024 will be 6.12, so that will
likely be the next LTS kernel.  In general, there is more attention
paid to the newer LTS kernels, and although *technically* there are
LTS kernels going back to 5.4, pretty much no one pays attention to
them other than the companies stubbornly hanging on because they don't
have the engineering bandwidth to go to a newer kernel, despite the
fact that many security bug fixes never make it all the way back to
those ancient kernels.

> Yes. That is why I spent 2 days for solely testing hardware, booting from
> separate media, stressing everything, and making plenty of copies. As I
> mentioned in my initial post, this had revealed no hardware issues. And I'm
> enjoying md raid-1 since around 2003 already (Not on this device though). I
> can post all my "smart" values as is, but I can assure they are perfectly
> fine for both raid-1 members. I encounter faulty hdds elsewhere routinely so
> its not something unseen too.

Note that some hardware errors can be caused by one-off errors, such
as cosmic rays causing a bit-flip in memory DIMM.  If that happens,
RAID won't save you, since the error was introduced before an updated
block group descriptor (for example) gets written.  ECC will help;
unfortunately, most consumer grade systems don't use ECC.  (And by the
way, the are systems used in hyperscaler cloud companies which look
for CPU-level failures, which can start with silent bit flips leading
to crashes or rep-invariant failures, and correlating them with
specific CPU cores.  For example, see[2].)

[2] https://research.google/pubs/detection-and-prevention-of-silent-data-corruption-in-an-exabyte-scale-database-system/

> This is a fsck run on a standalone copy taken before repair (after
> successful raid re-check):
> 
> #fsck.ext4 -fn /dev/sdb1
> ext2fs_check_desc: Corrupt group descriptor: bad block for block bitmap
> fsck.ext4: Group descriptors look bad... trying backup blocks...

What this means is that the block group descriptor has for one of
ext4's block groups has the location for its block allcation bitmap to
be a invalid value.  For example, if one of the high bits in the block
allcation gets flipped, the block number will be wildly out of range,
and so it's something that can be noticed very quickly at mount time.
This is a lucky failure, because (a) it can get detected right away,
and (b) it can be very easily fixed by consulting one of the backup
copies of the block group descriptors.  This is what happened in this
case, and rest of fsck transcript is consitent with that.

The location of block allocation bitmaps never gets changed, so this
sort of thing only happens due to hardware-induced corruption.

Looking at the dumpe2fs output, it looks like it was created
relatively recently (July 2024) but it doesn't have the metadata
checksum feature enabled, which has been enabled for quite a long
time.  I'm going to guess that this means that you're using a fairly
old version version of e2fsprogs (it was enabled by default in
e2fsprogs 1.43, released in May 2016[3]).

[3] https://e2fsprogs.sourceforge.net/e2fsprogs-release.html#1.43

You got lucky because it block allocation bitmap location was
corrupted to an obviously invalid value.  But if it had been a
low-order bit that had gotten flipped this could have lead to data
corruption before the data and metadata corruption became obvious
enough that ext4 would flag it.  Metadata checksums would catch that
kind of error much more quickly --- and is an example of how RAID
arrays shouldn't be treated as a magic bullet.

> > Did you check for any changes to the md/dm code, or the block layer?
> 
> No. Generally, it could be just anything, therefore I see no point even
> starting without good background knowledge. That is why I'm trying to draw
> attention of those who are more aware instead. :-)

The problem is that there are millions and millions of Linux users.
If everyone were do that, it just wouldn't scale.  For companies who
don't want to bother with upgrading to newer versions of software,
that's why they pay the big bucks to companies like Red Hat or SuSE or
Canonical.  Or if you are a platinum level customer for Amazon or
Google, you can use Amazon Linux or Google's Container-Optimized OS,
and the cloud company's tech support teams will help you out.  :-)

Otherwise, I strongly encourage you to learn, and to take
responsibility for the health of your own system.  And ideally, you
can also use that knowledge to help other users out, which is the only
way the free-as-in-beer ecosystem can flurish; by having everybody
helping each other.  Who knows, maybe you could even get a job doing
it for a living.  :-) :-) :-)

Cheers,


