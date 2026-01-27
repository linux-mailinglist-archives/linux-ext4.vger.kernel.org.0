Return-Path: <linux-ext4+bounces-13358-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMIdEWYWeWmyvAEAu9opvQ
	(envelope-from <linux-ext4+bounces-13358-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Jan 2026 20:47:50 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3C69A1C1
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Jan 2026 20:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F11B9302A539
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Jan 2026 19:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E6732E6BF;
	Tue, 27 Jan 2026 19:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/BTSWO3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ED4326949
	for <linux-ext4@vger.kernel.org>; Tue, 27 Jan 2026 19:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769543264; cv=pass; b=j6eWofKLwC5vdH5WCoAb0JCjJTWRI5UDAjJSxLBhZ21B42eYjuhaNWy0DKLRmx8KYfmkUf0qkKPvwBQbCA76cFcRQnMMVtRQKNgwUiyJYB83maS4b4pQi2H9GC3eYxlNpvRcfYRXCk5nr/w/Vh2A+1WGz7mTcYABNTdvoCLniM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769543264; c=relaxed/simple;
	bh=i2+pZ86FG6FGq3oFgpcoC7msWzm4M4xURJdOLb/8a1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SmOnDFfiRzw5SDuA7EYKZuiL7kCjSDz411kA3cAGSiyx3Oyb9N4GY39FO/XSeACWmh9Dfs7SMjaisotBPVyftKGbq4GDkJyocdNM7NbhdC69g3Akn8UrqyRaqYKUPXl3meay6+gCDnvCP56g/wLZyx0sTsisyrOBkvsjd6dbQ1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/BTSWO3; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50143fe869fso64664461cf.1
        for <linux-ext4@vger.kernel.org>; Tue, 27 Jan 2026 11:47:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769543262; cv=none;
        d=google.com; s=arc-20240605;
        b=IOK8dcB/M3skFdNLlO4ShF1pVMKsOVANa/E6LbXCb2tB5S3JyRe+KpevA3s2I3xdqP
         sQ56EU8MA6pdnII5ADaeRFONAGcq5BvXEhPGTbj1Ul2Pmf3ZIEcHJsJK4KqHGBjRHB29
         cCrpNO+46M0Kk+ZmHtmBwJp0Bremk+KvMGI6gE/AIp0bbqazSMUTse+1+vkWcp9OTGch
         2HuTsV9Gqd9jfXXwn5CYPR0aqPt5wkHVrwR4E2Tt/wZZ14NZyHGP6SbW2Ywf2t9KoNGG
         WT+F6lnqX45cp/bmJyvrxHKBSS6nYOQxoh8ho2etbfOUR4prto/YKPXCKCOEX172efjm
         ntjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KlR3B1H0ttH3Rms4Du3XP4sfaNK7yOZH8xq+g1jUK4g=;
        fh=NP5p07dDvtc5XhDpKyfuTc+2J9/6edv2LHCdtbsbP9g=;
        b=LBsdUM+dXSeUpfOI7/6mL2jPueVJSKG7P/i+Ftz33Vcbo4FsN7D/vfGOq/u2bOREr4
         Y4mC8/VtrZowwjRK0iGNek4QOMKCbWQnu0c3n9khog0spKAYQiYWjxJxAL41G/T6OdGc
         jKAYDxitESg2BDXusXrJ1GOKOpvXgxM14fG+kZ+NHNOZPn6LivQfH83NxZFhPBm4mkLB
         CWBltX99BujkiTaQp4QBcy76Cm1c1GE/1lUhb3k92sZ0I6BYKinSFFiJiaLRS61Gz8QZ
         eMDeAwaU+7EZGpYLJ2e0T5gBp+pMg13LVJJfng0L/BRNJ/iwTtlmLcfW6we4SmELTlu/
         9TVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769543262; x=1770148062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlR3B1H0ttH3Rms4Du3XP4sfaNK7yOZH8xq+g1jUK4g=;
        b=m/BTSWO3FAfih6jcIHI0g7xROujuNuMdva93+yMZu78dc//g8t1dpgmE/ouAksJD6o
         T0dFJEu1Taz0x26YFh0ZoDZuXVp5ABhpuig19Abn/EY9i5VYXlDYbDLpRcLT3hpPpV4D
         cePDQfILLmzTE+9UEOwgBFVuMlE1Kpx0WvyqvnMxvNtYpWIsGcqV3eopT3yMrHefyfHk
         S5DuqwrPshoxXdi45h4cQqSnEuDsnGlIGnPRFOxdLPtKI4UuUsGZsxmu7JJo01VGQMoX
         /WcbIPuvWu3hDRClnwmHTG37/aFSCt3ZOaK5p+FG0VXFxuZCNlxeKFkmo2l+j32ljAbm
         AKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769543262; x=1770148062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KlR3B1H0ttH3Rms4Du3XP4sfaNK7yOZH8xq+g1jUK4g=;
        b=M4b7dihx0z9MVBhMzNeVX38mkGPyqi7VGAOEqU5VEtPjZ42hb/FUvfI6DiA0oEm6j0
         dp/mZ10NdFStcN0zCEDnrhwOanFgnJcrptJD0drLRE18Qvp2Y4SGr38yBqfRmSMjQE71
         AQqMlMK/WdbuZnJWV316StYk3LrUwpb4fiDH9I1CR9u4NjTnXSP5QYTxqgTz5tH+5PGV
         1wC7UiMnoRHb42ZGoC+ezO+zf/Ym5BAdSN0ARDSqxORnhheD05/0PqnMRPyGE98qDuK6
         JTRQDQNZTk9/SIXIgvF6MC+P4rq/xaM+geecXWvY+JIUNrg+U/A3j0rz+Kg6e65AS5jX
         VetQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh9+5MapxMqhW/iP5Fomq14nxHjpleisdyIXBKb22Um9kazecbN10bl8VvJfF1QRjX+zAUjXYESvlq@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl3+Mw8RZ/NW3F297ejLsaEiSqkqRtVh1C0mdn1/qPyZa2VFOY
	S+fTL/reCkxpqP6jmFo95WghM7pM2eh0zVyYkFfbY8k9B0AgjpAY+40athqYOL7/4qVC0XqEyNe
	x1sRmCemdvRvnAi4HERqljwe8zSlnLQ4m39X8
X-Gm-Gg: AZuq6aIlLPZqUVHlYpLxqEiZlv8WsbBX0sJmOgUZ/6KPVtsnbU+VsS2eghanZMnifhM
	SglZQSnShPxUov9T7XZUcLVx0sw3UlZCIDdZXt0yNqpkVsicWvAszi8BGoYixXvTlOyjNc/1y1V
	x/Fi6DbXrGMbkip70Jmw6b8zKe+Cn+QEKiyBb25XewLfyby/YXGzHa/rv9jNBc2ugFMc3ZRHl3d
	0EugvYRQrTsCyoe7aE8pwT8NwZKakIuvan0rgLBw4gyHuw+evZZ8mW41zH1BNwpC+rxVA==
X-Received: by 2002:a05:622a:14:b0:4ec:f2e1:483 with SMTP id
 d75a77b69052e-5032f76558cmr34769341cf.26.1769543261931; Tue, 27 Jan 2026
 11:47:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029002755.GK6174@frogsfrogsfrogs> <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <CAJnrk1Z05QZmos90qmWtnWGF+Kb7rVziJ51UpuJ0O=A+6N1vrg@mail.gmail.com> <20260127022235.GG5900@frogsfrogsfrogs>
In-Reply-To: <20260127022235.GG5900@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 27 Jan 2026 11:47:31 -0800
X-Gm-Features: AZwV_QjF9rNfZtsYijV_1NKbqNSFD1bzyLoPT1OLzI0R9ryfxVWNeNQAShqWpHg
Message-ID: <CAJnrk1bSVy4=c=N_FfOajs1FE4o8T=Br=jFm7gBDaCGvRpgGVA@mail.gmail.com>
Subject: Re: [PATCHSET v6 4/8] fuse: allow servers to use iomap for better
 file IO performance
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13358-lists,linux-ext4=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 9B3C69A1C1
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 6:22=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Mon, Jan 26, 2026 at 04:59:16PM -0800, Joanne Koong wrote:
> > On Tue, Oct 28, 2025 at 5:38=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > Hi all,
> > >
> > > This series connects fuse (the userspace filesystem layer) to fs-ioma=
p
> > > to get fuse servers out of the business of handling file I/O themselv=
es.
> > > By keeping the IO path mostly within the kernel, we can dramatically
> > > improve the speed of disk-based filesystems.  This enables us to move
> > > all the filesystem metadata parsing code out of the kernel and into
> > > userspace, which means that we can containerize them for security
> > > without losing a lot of performance.
> >
> > I haven't looked through how the fuse2fs or fuse4fs servers are
> > implemented yet (also, could you explain the difference between the
> > two? Which one should we look at to see how it all ties together?),
>
> fuse4fs is a lowlevel fuse server; fuse2fs is a high(?) level fuse
> server.  fuse4fs is the successor to fuse2fs, at least on Linux and BSD.

Ah I see, thanks for the explanation. In that case, I'll just look at
fuse4fs then.

>
> > but I wonder if having bpf infrastructure hooked up to fuse would be
> > especially helpful for what you're doing here with fuse iomap. afaict,
> > every read/write whether it's buffered or direct will incur at least 1
> > call to ->iomap_begin() to get the mapping metadata, which will be 2
> > context-switches (and if the server has ->iomap_end() implemented,
> > then 2 more context-switches).
>
> Yes, I agree that's a lot of context switching for file IO...
>
> > But it seems like the logic for retrieving mapping
> > offsets/lengths/metadata should be pretty straightforward?
>
> ...but it gets very cheap if the fuse server can cache mappings in the
> kernel to avoid all that.  That is, incidentally, what patchset #7
> implements.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/=
?h=3Dfuse-iomap-cache_2026-01-22
>
> > If the extent lookups are table lookups or tree
> > traversals without complex side effects, then having
> > ->iomap_begin()/->iomap_end() be executed as a bpf program would avoid
> > the context switches and allow all the caching logic to be moved from
> > the kernel to the server-side (eg using bpf maps).
>
> Hrmm.  Now that /is/ an interesting proposal.  Does BPF have a data
> structure that supports interval mappings?  I think the existing bpf map

Not yet but I don't see why a b+ tree like data strucutre couldn't be added=
.
Maybe one workaround in the meantime that could work is using a sorted
array map and doing binary search on that, until interval mappings can
be natively supported?

> only does key -> value.  Also, is there an upper limit on the size of a
> map?  You could have hundreds of millions of maps for a very fragmented
> regular file.

If I'm remembering correctly, there's an upper limit on the number of
map entries, which is bounded by u32

>
> At one point I suggested to the famfs maintainer that it might be
> easier/better to implement the interleaved mapping lookups as bpf
> programs instead of being stuck with a fixed format in the fuse
> userspace abi, but I don't know if he ever implemented that.

This seems like a good use case for it too
>
> > Is this your
> > assessment of it as well or do you think the server-side logic for
> > iomap_begin()/iomap_end() is too complicated to make this realistic?
> > Asking because I'm curious whether this direction makes sense, not
> > because I think it would be a blocker for your series.
>
> For disk-based filesystems I think it would be difficult to model a bpf
> program to do mappings, since they can basically point anywhere and be
> of any size.

Hmm I'm not familiar enough with disk-based filesystems to know what
the "point anywhere and be of any size" means. For the mapping stuff,
doesn't it just point to a block number? Or are you saying the problem
would be there's too many mappings since a mapping could be any size?

I was thinking the issue would be more that there might be other logic
inside ->iomap_begin()/->iomap_end() besides the mapping stuff that
would need to be done that would be too out-of-scope for bpf. But I
think I need to read through the fuse4fs stuff to understand more what
it's doing in those functions.

Thanks,
Joanne

>
> OTOH it would be enormously hilarious to me if one could load a file
> mapping predictive model into the kernel as a bpf program and use that
> as a first tier before checking the in-memory btree mapping cache from
> patchset 7.  Quite a few years ago now there was a FAST paper
> establishing that even a stupid linear regression model could in theory
> beat a disk btree lookup.
>
> --D
>
> > Thanks,
> > Joanne
> >
> > >
> > > If you're going to start using this code, I strongly recommend pullin=
g
> > > from my git trees, which are linked below.
> > >
> > > This has been running on the djcloud for months with no problems.  En=
joy!
> > > Comments and questions are, as always, welcome.
> > >
> > > --D
> > >
> > > kernel git tree:
> > > https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log=
/?h=3Dfuse-iomap-fileio
> > > ---
> > > Commits in this patchset:
> > >  * fuse: implement the basic iomap mechanisms
> > >  * fuse_trace: implement the basic iomap mechanisms
> > >  * fuse: make debugging configurable at runtime
> > >  * fuse: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to add new iomap dev=
ices
> > >  * fuse_trace: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to add new iom=
ap devices
> > >  * fuse: flush events and send FUSE_SYNCFS and FUSE_DESTROY on unmoun=
t
> > >  * fuse: create a per-inode flag for toggling iomap
> > >  * fuse_trace: create a per-inode flag for toggling iomap
> > >  * fuse: isolate the other regular file IO paths from iomap
> > >  * fuse: implement basic iomap reporting such as FIEMAP and SEEK_{DAT=
A,HOLE}
> > >  * fuse_trace: implement basic iomap reporting such as FIEMAP and SEE=
K_{DATA,HOLE}
> > >  * fuse: implement direct IO with iomap
> > >  * fuse_trace: implement direct IO with iomap
> > >  * fuse: implement buffered IO with iomap
> > >  * fuse_trace: implement buffered IO with iomap
> > >  * fuse: implement large folios for iomap pagecache files
> > >  * fuse: use an unrestricted backing device with iomap pagecache io
> > >  * fuse: advertise support for iomap
> > >  * fuse: query filesystem geometry when using iomap
> > >  * fuse_trace: query filesystem geometry when using iomap
> > >  * fuse: implement fadvise for iomap files
> > >  * fuse: invalidate ranges of block devices being used for iomap
> > >  * fuse_trace: invalidate ranges of block devices being used for ioma=
p
> > >  * fuse: implement inline data file IO via iomap
> > >  * fuse_trace: implement inline data file IO via iomap
> > >  * fuse: allow more statx fields
> > >  * fuse: support atomic writes with iomap
> > >  * fuse_trace: support atomic writes with iomap
> > >  * fuse: disable direct reclaim for any fuse server that uses iomap
> > >  * fuse: enable swapfile activation on iomap
> > >  * fuse: implement freeze and shutdowns for iomap filesystems
> > > ---
> > >  fs/fuse/fuse_i.h          |  161 +++
> > >  fs/fuse/fuse_trace.h      |  939 +++++++++++++++++++
> > >  fs/fuse/iomap_i.h         |   52 +
> > >  include/uapi/linux/fuse.h |  219 ++++
> > >  fs/fuse/Kconfig           |   48 +
> > >  fs/fuse/Makefile          |    1
> > >  fs/fuse/backing.c         |   12
> > >  fs/fuse/dev.c             |   30 +
> > >  fs/fuse/dir.c             |  120 ++
> > >  fs/fuse/file.c            |  133 ++-
> > >  fs/fuse/file_iomap.c      | 2230 +++++++++++++++++++++++++++++++++++=
++++++++++
> > >  fs/fuse/inode.c           |  162 +++
> > >  fs/fuse/iomode.c          |    2
> > >  fs/fuse/trace.c           |    2
> > >  14 files changed, 4056 insertions(+), 55 deletions(-)
> > >  create mode 100644 fs/fuse/iomap_i.h
> > >  create mode 100644 fs/fuse/file_iomap.c
> > >
> >

