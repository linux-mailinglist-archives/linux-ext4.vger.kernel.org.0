Return-Path: <linux-ext4+bounces-12806-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B79D1D9C8
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jan 2026 10:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC88730A27F0
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jan 2026 09:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B63389DE0;
	Wed, 14 Jan 2026 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4R9ZtWz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853DA3876B1
	for <linux-ext4@vger.kernel.org>; Wed, 14 Jan 2026 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768383261; cv=none; b=C/clJLTV2lOxgU5uxpxm8MJ4s6xxVKLqSVEqbX9jSX+jF8cQ5zazMCDZhaD9HxkeG0tCSc7cRt15aWGs1yeMw0ww4ep2mLKRt5AYkKquQrkmqIxDAle6jnajyagX/yFMEPwxZ6LN+e51+HNt+tgeVngMFD2DEetcYZAc/N3l6zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768383261; c=relaxed/simple;
	bh=1et5czBbAtdqXmgJG4CYdcCCm2KxQaiqpQUINwrSInw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCSxhdmoPCmagTWEa4Rp8dr1cf0xRjFzS+qg04UqvuDzXS+fQ5JMw2es69tAqqwwJXz05D+vkL4TkDWe9464Bxdre92GVzWdZJMmeZRIgFm6gmOoVTsoFgD58EsVV+20blHLFJnA8WJduuT9rvaqJDj5J7N4uh80wKIQvSvdPvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4R9ZtWz; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8765b80a52so72419266b.2
        for <linux-ext4@vger.kernel.org>; Wed, 14 Jan 2026 01:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768383257; x=1768988057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cV5qgJhr5qbvOPleJHxrmxwzjsLTEkwpqcVKyAw90ng=;
        b=l4R9ZtWzmll6jo5HBanFLByjlkqXQwG+AsCW4DICvdDo4WF3sDvpj2eJOv3dVPo/iF
         B9OPR6yzN5WOr9LnfVQVQPIaZ5dKfwxv8IoCz8sH0q4qgpIQmlJCiHMiUEgcCYj9cDi3
         LUVEmz63xFT6TSr8KIUhYDMH7bf7fdIC3g1PgC+HFxSzGLjU2b9M5xwvJkmhU9BDl/Ac
         KA0NrfmQQjuFePgQk3BZMgWoAsJUycNFL5UQClkJzuN2LaTt6y/8PyOUMhcfHveom8Vj
         eUcATSwIrI17h12uKrpWWvmBOsQosxRHCi9c46TCRMyvB+pTweoBAZ9/mhr3kiRYuQZf
         09Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768383257; x=1768988057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cV5qgJhr5qbvOPleJHxrmxwzjsLTEkwpqcVKyAw90ng=;
        b=nIB5dN4yG9n/4uSw73bg+4yTrAPtzrvu5qZAn5aSoxpMtp9tqb3nW0lHZhPAsLlqJI
         QIKIMgno4Owh0rIKavzuQNGPBerc8YOw3kzG3W04BuMxT7l5Otr05nTwS6TP/LEMaCBz
         qwMABJg6Q0Sewd43Kss78cc4CwFAepErYQoaNNqudFuB7TZcfgx8QYCV0v7PHXqkdCxO
         aQZBSSWxoBsVD19JN6x55B5efnU0B6Z3mC4+0pGFx2ikWAdAPMSo0Q+B11ToFZUVtdry
         UTDp3HmS5xIPNYQHlCqgGCEL2JJvDGtZ/4fPozD1lyHhNzCtMGBUyUFRzZeWEAOFAmXW
         KGCA==
X-Forwarded-Encrypted: i=1; AJvYcCX+5+kxXR0/0WPNkqhbTIZEDIkFvcsdDrtwCvdGAGJaIQWdfP+z9muMoUwXiKGq4rYlv1n0El4IMxbg@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9qOUvF/xeryCI9tXOKfTyYVObkd3zKsYLWwbSU8JN9Q2fUdYk
	kzlW7UK4hp3qdhw3hodYfiotATE6KCpUYuz9WF6DjT65v9n6Br3Fh7CZGG2ZlvFkdOhF3vZ41+F
	lRSVdF366nKt4jem0KYGugSenhgUTP1Y=
X-Gm-Gg: AY/fxX7K5C1oqJcJZsIrAxjikMSiwdMCNBsM2RSWdI3+CsxAfkjni/3oEDNEugH0Vt/
	xUytX1M6b3sQWrHfQE4CytDTQ+xDAFWTdextgEGLfh+l5jIhbzJ2yDJhTRoVsaY6WDlw4GwVG8S
	VNS6FQBbEJiJYMX0K0vA9s/pVlpT4Uu0fJ/Az7xhAAxnxqlP9fywnvc8Kmu1toM7/+IytORRLs3
	AXc2EpNP1wIwVYpwFx97V5AxcKQ2BKEMycR8Vsl1bDNOzynTrtRkSr+5f2D2J+liy1fS3laKg7J
	bvuQeL2nUId+8VJc9oXONrEOyj41pnzyzQra+lfK
X-Received: by 2002:a17:906:6a02:b0:b87:25a6:a906 with SMTP id
 a640c23a62f3a-b87677e0680mr108491266b.46.1768383255915; Wed, 14 Jan 2026
 01:34:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
 <m3mywef74xhcakianlrovrnaadnhzhfqjfusulkcnyioforfml@j2xnk7dzkmv4>
 <8af369636c32b868f83669c49aea708ca3b894ac.camel@kernel.org>
 <CAOQ4uxgD+Sgbbg9K2U0SF9TyUOBb==Z6auShUWc4FfPaDCQ=rg@mail.gmail.com>
 <ec78bf021fa1f6243798945943541ba171e337e7.camel@kernel.org>
 <cb5d2da6-2090-4639-ad96-138342bba56d@oracle.com> <ce700ee20834631eceededc8cd15fc5d00fee28e.camel@kernel.org>
 <20260113-mondlicht-raven-82fc4eb70e9d@brauner> <aWZcoyQLvbJKUxDU@infradead.org>
 <ce418800f06aa61a7f47f0d19394988f87a3da07.camel@kernel.org> <aWc3mwBNs8LNFN4W@infradead.org>
In-Reply-To: <aWc3mwBNs8LNFN4W@infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 14 Jan 2026 10:34:04 +0100
X-Gm-Features: AZwV_QjTKvsgUAM6BTw2rpBHAs0ymZXhE-dNbh6dt2ll27JlZs1InITXkkYC5Xs
Message-ID: <CAOQ4uxhMjitW_DC9WK9eku51gE1Ft+ENhD=qq3uehwrHO=RByA@mail.gmail.com>
Subject: Re: [PATCH 00/24] vfs: require filesystems to explicitly opt-in to
 lease support
To: Christoph Hellwig <hch@infradead.org>
Cc: Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	Nicolas Pitre <nico@fluxnic.net>, Anders Larsen <al@alarsen.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, Jan Kara <jack@suse.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, Dave Kleikamp <shaggy@kernel.org>, 
	Ryusuke Konishi <konishi.ryusuke@gmail.com>, Viacheslav Dubeyko <slava@dubeyko.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Phillip Lougher <phillip@squashfs.org.uk>, 
	Carlos Maiolino <cem@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>, Alexander Aring <alex.aring@gmail.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, Xiubo Li <xiubli@redhat.com>, 
	Ilya Dryomov <idryomov@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, 
	Hans de Goede <hansg@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org, 
	jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org, 
	ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org, 
	linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org, 
	gfs2@lists.linux.dev, linux-doc@vger.kernel.org, v9fs@lists.linux.dev, 
	ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 7:28=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Tue, Jan 13, 2026 at 12:06:42PM -0500, Jeff Layton wrote:
> > Fair point, but it's not that hard to conceive of a situation where
> > someone inadvertantly exports cgroupfs or some similar filesystem:
>
> Sure.  But how is this worse than accidentally exporting private data
> or any other misconfiguration?
>

My POV is that it is less about security (as your question implies), and
more about correctness.

The special thing about NFS export, as opposed to, say, ksmbd, is
open by file handle, IOW, the export_operations.

I perceive this as a very strange and undesired situation when NFS
file handles do not behave as persistent file handles.

FUSE will gladly open a completely different object, sometimes
a different object type from an NFS client request after server restart.

I suppose that the same could happen with tmpfs and probably some
other fs.

This problem is old and welded into the system, but IMO adding more
kernel filesystems, which consciously export file handles that do not
survive server reboot does not serve users interests well.

One could claim that this is a bug that can be fixed by adding boot_id
to said file handles, but why fix something that nobody asked for?

cgroupfs, pidfs, nsfs, all gained open_by_handle_at() capability for
a known reason, which was NOT NFS export.

If the author of open_by_handle_at() support (i.e. brauner) does not
wish to imply that those fs should be exported to NFS, why object?

We could have the opt-in/out of NFS export fixes per EXPORT_OP_
flags and we could even think of allowing admin to make this decision
per vfsmount (e.g. for cgroupfs).

In any case, I fail to see how objecting to the possibility of NFS export
opt-out serves anyone.

Thanks,
Amir.

