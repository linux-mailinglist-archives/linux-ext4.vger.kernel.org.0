Return-Path: <linux-ext4+bounces-13340-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKMxCf4NeGmzngEAu9opvQ
	(envelope-from <linux-ext4+bounces-13340-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Jan 2026 01:59:42 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACE88E979
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Jan 2026 01:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19E8E30234DF
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Jan 2026 00:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8731211A09;
	Tue, 27 Jan 2026 00:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3xNGce0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13711A9F93
	for <linux-ext4@vger.kernel.org>; Tue, 27 Jan 2026 00:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769475572; cv=pass; b=dYHwYL0r3YF75J+mtQ+bDwXjx1cRG5w3agff/wdZjAU1vXWGEB6fc/kkI3HZHAK7T3cDECGjT9LN5xYqIFu+1GtkJYS8kFkS9wc4tNjVM7P9fgtamE+pD2ZoIYV4Y6Li6Uuot7zTyo3T4eQlgS/AoEnUWo30w19homyW6jPy7RM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769475572; c=relaxed/simple;
	bh=D69ptwANmBNhCPcucfBrPko3sYR/MuWgcHBB2jRML2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q1+hHrtlGwqEQ37rPyUHQFAaI7loX+VeUQ9PsRN6qxRV8/UoobMdclVOVu0CYja3KBHQ22RtSLn5cCBh/vN3loZgmvFZrUvQHpy+eD/zDzWcWvltFXvlzGo6zH7MrSebj4N8ZtYVd46yYGYfbiuMO9dzoJkOAX8t46OZHMPFHL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3xNGce0; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-502acd495feso60604861cf.2
        for <linux-ext4@vger.kernel.org>; Mon, 26 Jan 2026 16:59:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769475569; cv=none;
        d=google.com; s=arc-20240605;
        b=a1y/P+PhCnGqlNvaljqlcvDmrqRSH5jAmF11CH6ccNcYdpmXK+KR6WGPyTQSsuZ42N
         z1ION96Yfo4KE6Nwqa2DynHrsmnTsnt1DhoQGV/60FNgmcSqfQL76W0uNcNNB12GeZtc
         BcP+ox07M1zT6sfN6EPv+6HTNo8jAUKfGAC0s7znW5kiE+1di5+x0NlXHn0aPHbuHpny
         g4SrKgWhJ/ZZHhSmiDm5RfkjVWNmso0gq8qDvbU1/amz+875tKqQA1OgQ7m1MdzpgX7F
         3EjIbVwfaKPPgDh2PpbyoEmJ0iYQSb5qreJlN6n9ARdn4YjZ+fCNCh+bG5/13p/dv4kf
         /1tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EKK5+XZyBkEjhopnPUGxO9+0bL33NledXPoUaVEI+gE=;
        fh=f4zae1p2g02v5u9MNm4o3PqAqqdIOYxmSJ+4vtfV0TQ=;
        b=IPhNvDQuYOiJuBwObmYt5J3euCJO0QoxpoBDe/M9+AmGeufxUuvrstc67bM9uXlA5O
         P593EeSHCBYC9GXpH0Sp6d4Bx6SLTcxyYtTgR0hjlEP/B2Zjj1CWgSJe9zk4LXe6YKVF
         cM2k4FJ/lDIYgrP492Ntok7NswmLPHwwvs9U0paSlpapDaBHhg0MLciLnizVBScjHr1X
         4kUj1GdsLghQmqI+XJNC76OjLvSYQNe2Iz/ifxY279xoOGP63r604ZWgS+tmWWCU2bVn
         RULl24DEiYxKwMIX8hB5qcZ7tqk4YDziXtnLZoN600KyIRhPSzCRqSB/IE0uU2/5ExbT
         SHtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769475569; x=1770080369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKK5+XZyBkEjhopnPUGxO9+0bL33NledXPoUaVEI+gE=;
        b=G3xNGce0EXr1DrwvZOWn+v7zG9FncV4jn7HwoRQmaXYbusP+eTJo/pBvHo634+qYDN
         wv+eq1gum0nt9RNP7skwTyzl0uU0WVQC7aSdJmp7Ohr0wm30+4KrtsHE+WFB5N/I63lZ
         MfzsHh35Beykp4+zXPZU3PfzPOPLzKwyHGQ3wjb5ISvDVrWmUhNWb7e5QxIbZ2TrXzW3
         jbFIX3Iw6AXQA/mDw5hnsed3b2jrmjHd25qKX4Bmt90H7dJLD7FnuPTCSmpE95dOFnEm
         C1lXqtlwDBOR/eQwGDiIgtuzyc+9Jvq/4Zls9djDzsNIOZoakEbtJxZ7qc0A1nbuacfM
         QdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769475569; x=1770080369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EKK5+XZyBkEjhopnPUGxO9+0bL33NledXPoUaVEI+gE=;
        b=TADksPWl+YM7hKtks0DgfuUCkC1gvFQFTqzXovUTeL/l7TpAkKKqESq1Gyce++LZsq
         qfBJwyzdSBm/LQvNvQ+aNKl9TYmVxKhmvVsSTPfOmcUxJo5a4c2N0soOcF4Ud89OELHJ
         YFle9FNq33t7uuCz74w6H48weSTeHUAylbzbORxAl/H9VOgQB03HuvLvGOfRKelY9nsv
         qRtdksfSUHh3BLtou5SufNmHAYPd2HvscPdZYdM4tOqP+4FbLGcIptV7zBJcX83ifEFc
         pxhwTSjIgPdFUalylDrTEEC15oNxZopMAbpRJUwZQEMsji95c8vE/w8MXeeO9quAj9Ao
         kS9w==
X-Forwarded-Encrypted: i=1; AJvYcCWkcG5rwzORA9koqq03Mv+RjM6oIoIfHsVWBoRX8p4iotUiegty3ie+1XO4dR/uSIbdS2gH/Lgs4WNy@vger.kernel.org
X-Gm-Message-State: AOJu0YzRFYvsEG9qejWyeF4BvnS5e2bGOu5XTifHrVWd+rku+i3LjWf8
	DfSyUeaJxvWh0YxUGcRMMwNp11ZoIqfB/q6oc0fYiwEeSQhwIeih/aZJqgJI4w6p+MMObJCmPRe
	9i6LkjUYZOvGcKFAHx26Um6hQLTuHI+s=
X-Gm-Gg: AZuq6aIMISVm2oxbYk/XTjdVrAf/IEsKA6o7Ul4uq4AZpUsofEhJhCmepB/PYHXIX/A
	qvExg8mZR3VbL54TLdYY8lHUmlu9wswY2z5XJiFZb53gqq3DpzsOlrpSXzexGqeMh0rjW4uXULM
	l9FWLj8oM423fzC9A7ME0rVRHlbOt+pXaLqd8DOTKG/4vfgAp7PZqNsTlfy2KnlsPJgbJpdAVop
	kt8Idiri5negJsFR0x14HzfkKYnuIFiGDhgwbOJD6Kv7H4DASM/jgPuvkZPp3UGMZTbaM3Pc8Ye
	zhhe84kMHvP5E4dlELhPsw==
X-Received: by 2002:ac8:5981:0:b0:4e8:b446:c01b with SMTP id
 d75a77b69052e-50314c690a1mr83731901cf.61.1769475568788; Mon, 26 Jan 2026
 16:59:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029002755.GK6174@frogsfrogsfrogs> <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
In-Reply-To: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 26 Jan 2026 16:59:16 -0800
X-Gm-Features: AZwV_QiCLsW4098i_o1ND3ZAp-I17VKc7jXatwN-zQQrkGhitlVqj3v7SWmqig0
Message-ID: <CAJnrk1Z05QZmos90qmWtnWGF+Kb7rVziJ51UpuJ0O=A+6N1vrg@mail.gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13340-lists,linux-ext4=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8ACE88E979
X-Rspamd-Action: no action

On Tue, Oct 28, 2025 at 5:38=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> Hi all,
>
> This series connects fuse (the userspace filesystem layer) to fs-iomap
> to get fuse servers out of the business of handling file I/O themselves.
> By keeping the IO path mostly within the kernel, we can dramatically
> improve the speed of disk-based filesystems.  This enables us to move
> all the filesystem metadata parsing code out of the kernel and into
> userspace, which means that we can containerize them for security
> without losing a lot of performance.

I haven't looked through how the fuse2fs or fuse4fs servers are
implemented yet (also, could you explain the difference between the
two? Which one should we look at to see how it all ties together?),
but I wonder if having bpf infrastructure hooked up to fuse would be
especially helpful for what you're doing here with fuse iomap. afaict,
every read/write whether it's buffered or direct will incur at least 1
call to ->iomap_begin() to get the mapping metadata, which will be 2
context-switches (and if the server has ->iomap_end() implemented,
then 2 more context-switches). But it seems like the logic for
retrieving mapping offsets/lengths/metadata should be pretty
straightforward? If the extent lookups are table lookups or tree
traversals without complex side effects, then having
->iomap_begin()/->iomap_end() be executed as a bpf program would avoid
the context switches and allow all the caching logic to be moved from
the kernel to the server-side (eg using bpf maps). Is this your
assessment of it as well or do you think the server-side logic for
iomap_begin()/iomap_end() is too complicated to make this realistic?
Asking because I'm curious whether this direction makes sense, not
because I think it would be a blocker for your series.

Thanks,
Joanne

>
> If you're going to start using this code, I strongly recommend pulling
> from my git trees, which are linked below.
>
> This has been running on the djcloud for months with no problems.  Enjoy!
> Comments and questions are, as always, welcome.
>
> --D
>
> kernel git tree:
> https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=
=3Dfuse-iomap-fileio
> ---
> Commits in this patchset:
>  * fuse: implement the basic iomap mechanisms
>  * fuse_trace: implement the basic iomap mechanisms
>  * fuse: make debugging configurable at runtime
>  * fuse: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to add new iomap devices
>  * fuse_trace: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to add new iomap d=
evices
>  * fuse: flush events and send FUSE_SYNCFS and FUSE_DESTROY on unmount
>  * fuse: create a per-inode flag for toggling iomap
>  * fuse_trace: create a per-inode flag for toggling iomap
>  * fuse: isolate the other regular file IO paths from iomap
>  * fuse: implement basic iomap reporting such as FIEMAP and SEEK_{DATA,HO=
LE}
>  * fuse_trace: implement basic iomap reporting such as FIEMAP and SEEK_{D=
ATA,HOLE}
>  * fuse: implement direct IO with iomap
>  * fuse_trace: implement direct IO with iomap
>  * fuse: implement buffered IO with iomap
>  * fuse_trace: implement buffered IO with iomap
>  * fuse: implement large folios for iomap pagecache files
>  * fuse: use an unrestricted backing device with iomap pagecache io
>  * fuse: advertise support for iomap
>  * fuse: query filesystem geometry when using iomap
>  * fuse_trace: query filesystem geometry when using iomap
>  * fuse: implement fadvise for iomap files
>  * fuse: invalidate ranges of block devices being used for iomap
>  * fuse_trace: invalidate ranges of block devices being used for iomap
>  * fuse: implement inline data file IO via iomap
>  * fuse_trace: implement inline data file IO via iomap
>  * fuse: allow more statx fields
>  * fuse: support atomic writes with iomap
>  * fuse_trace: support atomic writes with iomap
>  * fuse: disable direct reclaim for any fuse server that uses iomap
>  * fuse: enable swapfile activation on iomap
>  * fuse: implement freeze and shutdowns for iomap filesystems
> ---
>  fs/fuse/fuse_i.h          |  161 +++
>  fs/fuse/fuse_trace.h      |  939 +++++++++++++++++++
>  fs/fuse/iomap_i.h         |   52 +
>  include/uapi/linux/fuse.h |  219 ++++
>  fs/fuse/Kconfig           |   48 +
>  fs/fuse/Makefile          |    1
>  fs/fuse/backing.c         |   12
>  fs/fuse/dev.c             |   30 +
>  fs/fuse/dir.c             |  120 ++
>  fs/fuse/file.c            |  133 ++-
>  fs/fuse/file_iomap.c      | 2230 +++++++++++++++++++++++++++++++++++++++=
++++++
>  fs/fuse/inode.c           |  162 +++
>  fs/fuse/iomode.c          |    2
>  fs/fuse/trace.c           |    2
>  14 files changed, 4056 insertions(+), 55 deletions(-)
>  create mode 100644 fs/fuse/iomap_i.h
>  create mode 100644 fs/fuse/file_iomap.c
>

