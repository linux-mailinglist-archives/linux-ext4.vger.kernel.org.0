Return-Path: <linux-ext4+bounces-14697-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLk4Og1Uq2n3cAEAu9opvQ
	(envelope-from <linux-ext4+bounces-14697-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Mar 2026 23:24:13 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 498B0228500
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Mar 2026 23:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7048F306CEE3
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Mar 2026 22:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD0A34FF78;
	Fri,  6 Mar 2026 22:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Kwqb5tDz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023DB34F47E
	for <linux-ext4@vger.kernel.org>; Fri,  6 Mar 2026 22:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772835817; cv=none; b=Oz3h448vNpYIIpiHvQmfDwWr6QvEvhsEUCEhZMRFj7hplINN2fg0j4k20/87ghcz3WfAQPmB6W4G3Fn2Jm2zu3nX469ran3DtjknBHR9TdAjlr+damGJAsK7f/M2kZQsTrVKEtfvWi3CwT/+KuDyeSmgMkvZ3pQK6e7oN5Tv3vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772835817; c=relaxed/simple;
	bh=0p3kv7XuRFY9uuqkeAsyDN+7M3w6SjE6Tc9ei3cOk0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h52v0Nq8ftG38v8mDvI5SeNwnmunQyebMcuszbZgU3YI0YyBdaZ7ZZEEMmoVLnxl/SfYIJI6ADEp/5wTm8r+7QhrpHPmGn85PP3BVUq99Mamlm3p5+ymfSUSqy/IoHWBGrdeQBiFbS0HqZ+ijiImW95PSgEZUaJPB2ntfoxhuaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Kwqb5tDz; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([76.148.192.212])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 626MNF7A010114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Mar 2026 17:23:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1772835798; bh=UJKM9NGO1ko0hUVP3Tv8knnfzRZO8izbjKFF1uJz7nc=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Kwqb5tDz36qcjisMArB4tSqPl8vqoJCz1Ob8XosDVENUAb/9ZeTv+QvETr/Ohzvm2
	 2SgCUOsecOjDTy8nbzJ/rzrH3fOygSndribv2y8veep1JoaDRnWR+XiAEXu2tDDA4u
	 QnamLp0cTKkZW9HxTOCjMr8l3j+nz8tLqgraUmBkIuNDbkzaSxa/e89FLT1LZCTL/n
	 7778A6qwnLOEGB5FjGs3Z7EMTn1TC3vgNHFvVKBh6jqDcEIj92ZBkpmI24NogQwNMY
	 cFxDUb04AyubedF/JEGf5QLLzyfEkbrZqPCSByRZPMlt9XfI18nGbvoJaJeWqxa9cr
	 3hg98ihU3iy1Q==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 1CB5E5BF1174; Fri,  6 Mar 2026 17:23:15 -0500 (EST)
Date: Fri, 6 Mar 2026 17:23:15 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Daniel Tang <danielzgtg.opensource@gmail.com>
Cc: linux-ext4@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH e2fsprogs] e2fsck: preen inline data no attr
Message-ID: <20260306222315.GA42132@macsyma.local>
References: <3188418.mvXUDI8C0e@daniel-desktop3>
 <20260306155108.GA19348@macsyma.local>
 <2415922.vCJZsxu672@daniel-desktop3>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2415922.vCJZsxu672@daniel-desktop3>
X-Rspamd-Queue-Id: 498B0228500
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14697-lists,linux-ext4=lfdr.de];
	DKIM_TRACE(0.00)[mit.edu:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
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
	NEURAL_HAM(-0.00)[-0.963];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,daniel-tablet1:email]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 01:03:19PM -0500, Daniel Tang wrote:
> Today I tested the bug and this time it was a directory in /var,
> unlike the inline-data lockfile in /home last time.
> I reformatted /home with encryption in the meantime.

Thanks for the additional data.  I didn't realize you were also using
fast_commit.  I would not at all be surprised if there might be some
interesting kernel bugs with the intersection of fast_commit and
inline_data.

Does the problem go away if you disable fast_commit?  For that matter,
is there a reason why you enabled inline_data and fast_commit in the
first place?  Was there something specific about how you expect the
file systems will be used that led you to believe they would be
helpful?  Or was this an Arch / Gento style "let's enable the latest
features just because we want to use the latest and greatest?"

It's great to get that kind of extra exposure, and I'm appreciative if
your dedication to use these latest features --- but there is a reason
why many distributions haven't enabled either by default just yet.

Given that you have a (mostly) reliable reproducer, it would be
definitely interesting to see if reproduces without fast_commit
enabled.

> root@daniel-tablet1:~# dumpe2fs -h /dev/nvme0n1p7
> dumpe2fs 1.47.2 (1-Jan-2025)
>    ....
> Filesystem state:         not clean with errors

> root@daniel-tablet1:~# fsck.ext4 -p /dev/nvme0n1p7 # For example
> /dev/nvme0n1p7 contains a file system with errors, check forced.

It appears that either the kernel or a previous run of fsck.ext4 found
that file system had serious issues, and marked the file system as
file system level inconsistency.  What would be really interesting is
to see the logs from the fsck.ext4 or kernel run to see what the
initial complete was, and whether there was some other interesting
information or attempted fix ups if this was from fsck.ext4 before it
threw up its hands and gave up.

If I had to guess, it was a previous fsck.ext4 run.  If it were the
kernel that noticed the problem, then there would be an "EXT4-fs
error" message, for example:

root@kvm-xfstests:~# echo testing > /sys/fs/ext4/vdc/trigger_fs_error
[  235.316299] EXT4-fs error (device vdc): trigger_test_error:130: comm bash: testing

More importantly, information about the source of the inconsistency
report would be written to the superblock, and dumpe2fs would have
displayed it, for example:

FS Error count:           1
First error time:         Fri Mar  6 17:11:51 2026
First error function:     trigger_test_error
First error line #:       130
First error err:          EFSCORRUPTED
Last error time:          Fri Mar  6 17:11:51 2026
Last error function:      trigger_test_error
Last error line #:        130
Last error err:           EFSCORRUPTED

Given that lines like this weren't in your dumpe2fs output, I'm
guessing that it was a previous fsck run --- probably the one that was
run immediately after the boot by the systemd unit file / init
scripts.  Hopefully those would have logged somewhere, such as
journalctl --- any chance you could try to see if you get the output
from that first fsck run?

In any case, while I'm not categorically opposed to your patch of
allowing a missing inline extended attribute from causing the fsck to
halt, since it's not a _lot_ of lost user data (less than 60 bytes),
it's a sign that something isn't quite right, and we really should
debug the underlying problem, since papering over the problem might
mean that we don't hear about it until something *really* critical
gets lost.

Cheers,

						- Ted

