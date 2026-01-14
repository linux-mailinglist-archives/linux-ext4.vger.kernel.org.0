Return-Path: <linux-ext4+bounces-12808-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C70D1F189
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jan 2026 14:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8660330303A2
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jan 2026 13:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DB439C64C;
	Wed, 14 Jan 2026 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpCDoFQV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E52039C641
	for <linux-ext4@vger.kernel.org>; Wed, 14 Jan 2026 13:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768398007; cv=none; b=ZeuHu65Fq5VoGBhK03e8tzkfiMXPsI9/E2mI0obX6W3WF1bwKoTf5F8GRntx+QYf6OpcSCcIzPUL37Ls/YEqgywkM+akIIiaSVm7l26VcZ0sZKeSMP+e/tuPpEWdBR94oxuo6MbCqH1cyh1VA8FjRhJ1Fcc/4rn94Z4a2nJV3qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768398007; c=relaxed/simple;
	bh=YZcrqwDuRyJBCAtxjucK7ekrSuDX8AnZLVJWFUZ9Q/c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rP5TnOR0ZgVM0EWHmQZFP68MlOSFCycGaHpoe4BMD4eq+M8ZXQ5S/zH/7XhuG+arh0FrGUFbgpyPg+X2UC51HE05aRxuG+Ib8c7cF/i6J31p9GT+v6rDczYFLMpNJYF2ZtMfQsOYjAkK/bzIDOLUBskHx0lEigtoSdRTv5mZ3WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpCDoFQV; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-430f2ee2f00so5174291f8f.3
        for <linux-ext4@vger.kernel.org>; Wed, 14 Jan 2026 05:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768398001; x=1769002801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wmwTmp5IFzHOcZYUSrwZ2WCFgEOIoQQbhD/zBC9MXc=;
        b=FpCDoFQVK2u3cOGkeMNLxme+40VwkGfsYrCm4qUWjS2DwShovcBmGgLTeJNAJaLtWv
         BNlyDl+Nq/x8yjYit/HSlROaHkgKGGwHevcUhDI1TuZESN/w5TWGRvo6DqGmEeQlwY4l
         1o2BoecZLrgb564v8TTjgep964GXUVUv/kmHXQI9TeSHteRdQLtZ50TbJhSeprvlH41F
         DVb60IN17TrEsSE/n0hAKHRiepPniG8/yMgf7Eg+TMEtBbPEMSZVl1l/X5UdLQAOam4X
         FZHOd/GOSj+QQT/02oNcD81lt174ls50JZpW+aQEuxxFRpK8u6awjh/qAiuoT6HbRfXu
         YMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768398001; x=1769002801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5wmwTmp5IFzHOcZYUSrwZ2WCFgEOIoQQbhD/zBC9MXc=;
        b=viaA8Cw1hL828+ZZRQHc7WAZjuNaipnTD2JXt1428XTBco+orgm+ySs8lP9YFsq0Np
         hFcmPm6rlsKJW6dN+SJe6TwKUvne1YYTHWrIeD/0SRwr5mVOVwYhVG8nSWCr3j+AUqzj
         BLRYFHy3KhbB1axemi2nLPNOZNdUNv+SxjZGdvrIFwrP4VWniVex5IvsT/pcj9dENRA/
         AxRLNU+YO4O5SZHQAsCV0f3vKTsbhNBN7LZPIT57qWQ6zmTSU2ot2MC8Qs+93ksxXFkd
         4wOq7V9yt6Gu9B1NmS4TpR7710h6WOetdOK7WEzSWUjJRGirl8d+LdqGKm5WaxH+0eG/
         OzvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjPaICKTgtXEUwcBhsdYSoGvK2uh0Mq/FPpW4EaFJdeydNbwJMf60G1Zqw8vRP7MmZxhkJM51aZdrU@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/43pNns+uj6F7YIX57OTxE8zGRf6uj055hsJKR6ymnWh4/OSL
	zvhE9gdvCxd/BYP4Sxw3/oUDK1Loy1K8UIxcNxvx4WtDwyBMRbpwlU3i
X-Gm-Gg: AY/fxX7hfCvwanUK5Os7jxiBIWybZXx26qTtfuAGozgXXDLhxtisPu2Wvpr2r9yBAyX
	uoKZ+WBkICeOHEX4+pKBuJUKnKgSd++elgOEc79oqNE/jJF/mVn2PEqdWMzriV9uXZVLpUsFlkY
	wLQ9IHzptoIRGqVlREJlxZIWNY1Ak/8XvJ4xY8tmwZ5d9gV7+GsDLuGiBM0o0EfrDX99wkNqAQl
	tn98jLsaKnW3sdxFVcXRSkJ2fveiwpRZdE9Br6KDZvywwWqHWdOpumsrC0bC/FgVs+h8Jp2905Z
	CeZwdg2LQmPH/lHPDI5nFh28oCLPlxq8vXKqCDv8m71p4Redg3gkr7t7afJMMD8jFUWbzuDGSW6
	/qjMnEmTGPyQ8SK4cbR3QhrIt2IhWNlwFFuAXBOucLtPNc/GBqSIUq2jsSj30U7OxNUDOIagiwm
	mTry1hSsKLlHl0t1nkgCXpRTO01RHn4Ybeh/rODoyZBRiON7tQoYJU
X-Received: by 2002:a5d:53c9:0:b0:432:5bf9:cf2e with SMTP id ffacd0b85a97d-4342c3ef274mr2643750f8f.13.1768398001040;
        Wed, 14 Jan 2026 05:40:01 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5edd51sm50238105f8f.29.2026.01.14.05.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 05:40:00 -0800 (PST)
Date: Wed, 14 Jan 2026 13:39:55 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Layton <jlayton@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Chuck Lever
 <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>, Luis de Bethencourt
 <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, Nicolas Pitre
 <nico@fluxnic.net>, Anders Larsen <al@alarsen.net>, Alexander Viro
 <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>, Chris Mason
 <clm@fb.com>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue
 Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep
 Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, Chunhai
 Guo <guochunhai@vivo.com>, Jan Kara <jack@suse.com>, "Theodore Ts'o"
 <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim
 <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, David
 Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, Dave
 Kleikamp <shaggy@kernel.org>, Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>, Konstantin Komarov
 <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg
 <martin@omnibond.com>, Miklos Szeredi <miklos@szeredi.hu>, Phillip Lougher
 <phillip@squashfs.org.uk>, Carlos Maiolino <cem@kernel.org>, Hugh Dickins
 <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew
 Morton <akpm@linux-foundation.org>, Namjae Jeon <linkinjeon@kernel.org>,
 Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>,
 Alexander Aring <alex.aring@gmail.com>, Andreas Gruenbacher
 <agruenba@redhat.com>, Jonathan Corbet <corbet@lwn.net>, "Matthew Wilcox
 (Oracle)" <willy@infradead.org>, Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet
 <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>,
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Trond
 Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Steve
 French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, Ronnie
 Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N
 <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, Bharath SM
 <bharathsm@microsoft.com>, Hans de Goede <hansg@kernel.org>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net,
 linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev,
 ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org,
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, gfs2@lists.linux.dev, linux-doc@vger.kernel.org,
 v9fs@lists.linux.dev, ceph-devel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org
Subject: Re: [PATCH 00/24] vfs: require filesystems to explicitly opt-in to
 lease support
Message-ID: <20260114133955.0a9f5cd3@pumpkin>
In-Reply-To: <CAOQ4uxhMjitW_DC9WK9eku51gE1Ft+ENhD=qq3uehwrHO=RByA@mail.gmail.com>
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
	<m3mywef74xhcakianlrovrnaadnhzhfqjfusulkcnyioforfml@j2xnk7dzkmv4>
	<8af369636c32b868f83669c49aea708ca3b894ac.camel@kernel.org>
	<CAOQ4uxgD+Sgbbg9K2U0SF9TyUOBb==Z6auShUWc4FfPaDCQ=rg@mail.gmail.com>
	<ec78bf021fa1f6243798945943541ba171e337e7.camel@kernel.org>
	<cb5d2da6-2090-4639-ad96-138342bba56d@oracle.com>
	<ce700ee20834631eceededc8cd15fc5d00fee28e.camel@kernel.org>
	<20260113-mondlicht-raven-82fc4eb70e9d@brauner>
	<aWZcoyQLvbJKUxDU@infradead.org>
	<ce418800f06aa61a7f47f0d19394988f87a3da07.camel@kernel.org>
	<aWc3mwBNs8LNFN4W@infradead.org>
	<CAOQ4uxhMjitW_DC9WK9eku51gE1Ft+ENhD=qq3uehwrHO=RByA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Jan 2026 10:34:04 +0100
Amir Goldstein <amir73il@gmail.com> wrote:

> On Wed, Jan 14, 2026 at 7:28=E2=80=AFAM Christoph Hellwig <hch@infradead.=
org> wrote:
> >
> > On Tue, Jan 13, 2026 at 12:06:42PM -0500, Jeff Layton wrote: =20
> > > Fair point, but it's not that hard to conceive of a situation where
> > > someone inadvertantly exports cgroupfs or some similar filesystem: =20
> >
> > Sure.  But how is this worse than accidentally exporting private data
> > or any other misconfiguration?
> > =20
>=20
> My POV is that it is less about security (as your question implies), and
> more about correctness.
>=20
> The special thing about NFS export, as opposed to, say, ksmbd, is
> open by file handle, IOW, the export_operations.
>=20
> I perceive this as a very strange and undesired situation when NFS
> file handles do not behave as persistent file handles.
>=20
> FUSE will gladly open a completely different object, sometimes
> a different object type from an NFS client request after server restart.
>=20
> I suppose that the same could happen with tmpfs and probably some
> other fs.
...

You really shouldn't be allowed to nfs export a fs that doesn't have
persistent file handles.

Even file handles containing 'random' numbers can be problematic.
The default used to be 'hard mounts' (not sure it is any more) which
caused the client (not Linux - too long ago) to loop in kernel
forever waiting for the server to recover the filesystem export.
The only resolution on that system was to reboot the client.

At least nfs can now use variable size file-ids.
When I was fixing some code that exported a layered fs (I pretty
much rewrote the fs at the same time) I did randomise the file-ids
so they (hopefully) became invalid after a reboot (only after suffering
some very corrupt filesystems!)
I found nfs (over udp) had some interesting 'features':
- If you export part of a fs you export all of it.
  (Especially since this predated the randomisation of the inode
  generation number.)
- If you give anyone access you give everyone access.
- If you give anyone write access you give everyone write access.
The latter two because the 'mount' protocol wasn't really needed
and the server didn't care where requests came from.

	David



