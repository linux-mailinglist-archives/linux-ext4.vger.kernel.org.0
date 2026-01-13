Return-Path: <linux-ext4+bounces-12768-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F36D185D2
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jan 2026 12:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DF1F316C1FD
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jan 2026 11:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B7138E126;
	Tue, 13 Jan 2026 11:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nN6MMGMs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B9B38B7B1
	for <linux-ext4@vger.kernel.org>; Tue, 13 Jan 2026 11:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768302235; cv=none; b=og5Pt53WX1LhMzeTCOvEkZe9121nPVI45hfDWkzCqKspmXkjCS0rWpn6ix3X3VzOpgg60V2rfXjJiTHfJbuR9YykMFIBJytRfBSrXxIjaY8dWknPVU0aJ6knz7LPcefqz7rcbbt9jMPHv2NsLW41Dn+gzavOR69Rkwxa2FxQo10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768302235; c=relaxed/simple;
	bh=GOvkA9ym2haRJ7rSmdC68mW+NnCwyKF6uappndPGnv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCvBjUbO3fJCesENcR9sR8tKsNuntsoKln02fRPhmhjJ7mRzvbDtuBNGlCKSLPAHNCbFY8v9SE5F0fXPJ+icTi4DBicdWhkG9Rc1W3hDTdd3B0Q2R1D/b6QR3uTC2GdQRGNq6JKzlUahavapGHbTDZYikvAqOYlsURAoH1VY1M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nN6MMGMs; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6536e4d25e1so458924a12.1
        for <linux-ext4@vger.kernel.org>; Tue, 13 Jan 2026 03:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768302230; x=1768907030; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1yKl/Pgo7Raivop2OmRTYwMbcW+Kn23aOzS6HQ4S0N8=;
        b=nN6MMGMsY4+YnodqJJrV6Jdg8tDEi7C5dMQ7zTn/qpbzoZ5ps2oxcoLvDvLH/p703Q
         KtniUbvq1O9YuxdfUboJoxIkw6Pwt00M/EPJgkc5yHODKcm56YN0rVeTg4iJi8rGrMRf
         JZyaN7vCW5HxVjStPU/3CA65at0FydI80IE45PjfBzrhLtauDwRPIRC8o6YPNBcZDbwz
         r9wuwRK8q3FVjJftt91QI6+Yh+7BLuOs3usGCsKS0/MfmCFHGXbHie4T6TLQZaU4LXnH
         ukKu5g+LvSt/+OIpy8PNYS8p6GETBzzSU3w7xeMSMrJe48ZQ9Gzd6IMcqhCJNc7ibJzH
         dKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768302230; x=1768907030;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yKl/Pgo7Raivop2OmRTYwMbcW+Kn23aOzS6HQ4S0N8=;
        b=NMP6wMnuPAckSKP+2CBaZ+uuhpQ2h+PNKf7Lc88RVFY3YbbXtP9V0elHUF4fikB4nG
         Mc6Sqqhn6l7C7nyeWymiU4D50NVHCAJub6t9V39/SP8ql0qCzLIF7MzR5+NR7Myxcyhe
         QHLP0uFy20xpGFAOGYRVhhruxZgve87PLh8i/D1WtqrMfiTEtIs4RSmxYHP/57NDQ3NA
         Ju09KC3HgBX3ZTo/73QjwAc73Pw++MB9sdMNg20ofM6EpaZWpoUEyRbiKO2HLIm9xY1x
         fzlSYrHXs+JrXjB6XWdklRb/6AbyYBfYllxpC2c5J9QNcNhTXnOViefIhmibiF4f7O1w
         P8jg==
X-Forwarded-Encrypted: i=1; AJvYcCVd933xkjwyRmAllM6harXAoDoJuojLi64qNyonumJ1txk1xTtuTSQrwq1S4zdN81+23bfK+FcA85Cn@vger.kernel.org
X-Gm-Message-State: AOJu0YxPhq/YXK8sQ4ICULnLoo+6awnG0P8xt3b8PxwwW4tm9ye5O1dF
	MSMBRAjhvbKiNCXQ1B85E2tlbXjw13NOL+W5S3frMV1ai6dZE/vVbHi0e6Cy6YZ5/qke/1ovo9t
	DiyHDbNNQYIc1B6cvlFtY/868UffSXa0=
X-Gm-Gg: AY/fxX5O3wgc3gmvZCEzeKNjNScdYeb2QsYj8pWBs49jpCUsIt3CjvlcCdl6KKCRZFg
	rb8Gnafy7+ANJzTmqIVtkrrOs+35F998e5hNgvkeK64aGbypyQxCTb7n3adKbileY5+JO9kKuwt
	bQZRYOj9S+0iIfgIPce/+J4f7nd7Y0/aUnfF4Udd1m99LKK086kWuk7Kszm1mY58XMjLxmyMc9m
	zI4UhoJ7AlUwm9xHIc0CzpusqTiqglQkCKEtgX7jHGDM0prEXpqLC4e4GokFwnFlVpjXPl9+H+s
	df4Kv4JGH187vt2WJ3HMx2SwGkxRdhAhymmOeZrX
X-Google-Smtp-Source: AGHT+IGHaEgIcl6O956q/oR3KprTKLrAIzwQWNnZW6GHFV/gOuiO6RLC6EZuQAaL35CmbUpNO9gUAoXWjlG3/ZomGCY=
X-Received: by 2002:a05:6402:2110:b0:64d:170:79a3 with SMTP id
 4fb4d7f45d1cf-65097e59bfemr21502908a12.20.1768302229797; Tue, 13 Jan 2026
 03:03:49 -0800 (PST)
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
 <20260113-mondlicht-raven-82fc4eb70e9d@brauner>
In-Reply-To: <20260113-mondlicht-raven-82fc4eb70e9d@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 13 Jan 2026 12:03:37 +0100
X-Gm-Features: AZwV_QgaTvXrJUOdIQ16Jho9rlbp9FwpQ0OxyPEQ1mLXrbEA1iJpt9y0FKtnu9k
Message-ID: <CAOQ4uxhkaGFtQRzTj2xaf2GJucoAY5CGiyUjB=8YA2zTbOtFvw@mail.gmail.com>
Subject: Re: [PATCH 00/24] vfs: require filesystems to explicitly opt-in to
 lease support
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	Nicolas Pitre <nico@fluxnic.net>, Christoph Hellwig <hch@infradead.org>, Anders Larsen <al@alarsen.net>, 
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
Content-Type: multipart/mixed; boundary="0000000000004374d1064842f2b9"

--0000000000004374d1064842f2b9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 9:54=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Mon, Jan 12, 2026 at 09:50:20AM -0500, Jeff Layton wrote:
> > On Mon, 2026-01-12 at 09:31 -0500, Chuck Lever wrote:
> > > On 1/12/26 8:34 AM, Jeff Layton wrote:
> > > > On Fri, 2026-01-09 at 19:52 +0100, Amir Goldstein wrote:
> > > > > On Thu, Jan 8, 2026 at 7:57=E2=80=AFPM Jeff Layton <jlayton@kerne=
l.org> wrote:
> > > > > >
> > > > > > On Thu, 2026-01-08 at 18:40 +0100, Jan Kara wrote:
> > > > > > > On Thu 08-01-26 12:12:55, Jeff Layton wrote:
> > > > > > > > Yesterday, I sent patches to fix how directory delegation s=
upport is
> > > > > > > > handled on filesystems where the should be disabled [1]. Th=
at set is
> > > > > > > > appropriate for v6.19. For v7.0, I want to make lease suppo=
rt be more
> > > > > > > > opt-in, rather than opt-out:
> > > > > > > >
> > > > > > > > For historical reasons, when ->setlease() file_operation is=
 set to NULL,
> > > > > > > > the default is to use the kernel-internal lease implementat=
ion. This
> > > > > > > > means that if you want to disable them, you need to explici=
tly set the
> > > > > > > > ->setlease() file_operation to simple_nosetlease() or the e=
quivalent.
> > > > > > > >
> > > > > > > > This has caused a number of problems over the years as some=
 filesystems
> > > > > > > > have inadvertantly allowed leases to be acquired simply by =
having left
> > > > > > > > it set to NULL. It would be better if filesystems had to op=
t-in to lease
> > > > > > > > support, particularly with the advent of directory delegati=
ons.
> > > > > > > >
> > > > > > > > This series has sets the ->setlease() operation in a pile o=
f existing
> > > > > > > > local filesystems to generic_setlease() and then changes
> > > > > > > > kernel_setlease() to return -EINVAL when the setlease() ope=
ration is not
> > > > > > > > set.
> > > > > > > >
> > > > > > > > With this change, new filesystems will need to explicitly s=
et the
> > > > > > > > ->setlease() operations in order to provide lease and deleg=
ation
> > > > > > > > support.
> > > > > > > >
> > > > > > > > I mainly focused on filesystems that are NFS exportable, si=
nce NFS and
> > > > > > > > SMB are the main users of file leases, and they tend to end=
 up exporting
> > > > > > > > the same filesystem types. Let me know if I've missed any.
> > > > > > >
> > > > > > > So, what about kernfs and fuse? They seem to be exportable an=
d don't have
> > > > > > > .setlease set...
> > > > > > >
> > > > > >
> > > > > > Yes, FUSE needs this too. I'll add a patch for that.
> > > > > >
> > > > > > As far as kernfs goes: AIUI, that's basically what sysfs and re=
sctrl
> > > > > > are built on. Do we really expect people to set leases there?
> > > > > >
> > > > > > I guess it's technically a regression since you could set them =
on those
> > > > > > sorts of files earlier, but people don't usually export kernfs =
based
> > > > > > filesystems via NFS or SMB, and that seems like something that =
could be
> > > > > > used to make mischief.
> > > > > >
> > > > > > AFAICT, kernfs_export_ops is mostly to support open_by_handle_a=
t(). See
> > > > > > commit aa8188253474 ("kernfs: add exportfs operations").
> > > > > >
> > > > > > One idea: we could add a wrapper around generic_setlease() for
> > > > > > filesystems like this that will do a WARN_ONCE() and then call
> > > > > > generic_setlease(). That would keep leases working on them but =
we might
> > > > > > get some reports that would tell us who's setting leases on the=
se files
> > > > > > and why.
> > > > >
> > > > > IMO, you are being too cautious, but whatever.
> > > > >
> > > > > It is not accurate that kernfs filesystems are NFS exportable in =
general.
> > > > > Only cgroupfs has KERNFS_ROOT_SUPPORT_EXPORTOP.
> > > > >
> > > > > If any application is using leases on cgroup files, it must be so=
me
> > > > > very advanced runtime (i.e. systemd), so we should know about the
> > > > > regression sooner rather than later.
> > > > >
> > > >
> > > > I think so too. For now, I think I'll not bother with the WARN_ONCE=
().
> > > > Let's just leave kernfs out of the set until someone presents a rea=
l
> > > > use-case.
> > > >
> > > > > There are also the recently added nsfs and pidfs export_operation=
s.
> > > > >
> > > > > I have a recollection about wanting to be explicit about not allo=
wing
> > > > > those to be exportable to NFS (nsfs specifically), but I can't se=
e where
> > > > > and if that restriction was done.
> > > > >
> > > > > Christian? Do you remember?
> > > > >
> > > >
> > > > (cc'ing Chuck)
> > > >
> > > > FWIW, you can currently export and mount /sys/fs/cgroup via NFS. Th=
e
> > > > directory doesn't show up when you try to get to it via NFSv4, but =
you
> > > > can mount it using v3 and READDIR works. The files are all empty wh=
en
> > > > you try to read them. I didn't try to do any writes.
> > > >
> > > > Should we add a mechanism to prevent exporting these sorts of
> > > > filesystems?
> > > >
> > > > Even better would be to make nfsd exporting explicitly opt-in. What=
 if
> > > > we were to add a EXPORT_OP_NFSD flag that explicitly allows filesys=
tems
> > > > to opt-in to NFS exporting, and check for that in __fh_verify()? We=
'd
> > > > have to add it to a bunch of existing filesystems, but that's fairl=
y
> > > > simple to do with an LLM.
> > >
> > > What's the active harm in exporting /sys/fs/cgroup ? It has to be don=
e
> > > explicitly via /etc/exports, so this is under the NFS server admin's
> > > control. Is it an attack surface?
> > >
> >
> > Potentially?
> >
> > I don't see any active harm with exporting cgroupfs. It doesn't work
> > right via nfsd, but it's not crashing the box or anything.
> >
> > At one time, those were only defined by filesystems that wanted to
> > allow NFS export. Now we've grown them on filesystems that just want to
> > provide filehandles for open_by_handle_at() and the like. nfsd doesn't
> > care though: if the fs has export operations, it'll happily use them.
> >
> > Having an explicit "I want to allow nfsd" flag see ms like it might
> > save us some headaches in the future when other filesystems add export
> > ops for this sort of filehandle use.
>
> So we are re-hashing a discussion we had a few months ago (Amir was
> involved at least).
>
> I don't think we want to expose cgroupfs via NFS that's super weird.
> It's like remote partial resource management and it would be very
> strange if a remote process suddenly would be able to move things around
> in the cgroup tree. So I would prefer to not do this.
>
> So my preference would be to really sever file handles from the export
> mechanism so that we can allow stuff like pidfs and nsfs and cgroupfs to
> use file handles via name_to_handle_at() and open_by_handle_at() without
> making them exportable.
>
> Somehow I thought that Amir had already done that work a while ago but
> maybe it was really just about name_to_handle_at() and not also
> open_by_handle_at()...

I don't recall doing anything except talking ;)

How about something like this to safeguard against exporting
the new pidfs/nsfs.

Regarding cgroupfs, we could either use a EXPORT_OP_ flag
or maybe it should have a custom open/permission as well?

Thanks,
Amir.

--0000000000004374d1064842f2b9
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-nfsd-do-not-allow-exporting-of-special-kernel-filesy.patch"
Content-Disposition: attachment; 
	filename="0001-nfsd-do-not-allow-exporting-of-special-kernel-filesy.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mkchdddy0>
X-Attachment-Id: f_mkchdddy0

RnJvbSBiYTRjYjhlZTBiYzIwYWZhNzRiZDY4OWVjY2FmMTFiOGQ2MDYyMTNhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBUdWUsIDEzIEphbiAyMDI2IDExOjQzOjU1ICswMTAwClN1YmplY3Q6IFtSRkNdW1BBVENI
XSBuZnNkOiBkbyBub3QgYWxsb3cgZXhwb3J0aW5nIG9mIHNwZWNpYWwga2VybmVsIGZpbGVzeXN0
ZW1zCgpwaWRmcyBhbmQgbnNmcyByZWNlbnRseSBnYWluZWQgc3VwcG9ydCBmb3IgZW5jb2RlL2Rl
Y29kZSBvZiBmaWxlIGhhbmRsZXMKdmlhIG5hbWVfdG9faGFuZGxlX2F0KDIpL29wYW5fYnlfaGFu
ZGxlX2F0KDIpLgoKVGhlc2Ugc3BlY2lhbCBrZXJuZWwgZmlsZXN5c3RlbXMgaGF2ZSBjdXN0b20g
LT5vcGVuKCkgYW5kIC0+cGVybWlzc2lvbigpCmV4cG9ydCBtZXRob2RzLCB3aGljaCBuZnNkIGRv
ZXMgbm90IHJlc3BlY3QgYW5kIGl0IHdhcyBuZXZlciBtZWFudCB0byBiZQp1c2VkIGZvciBleHBv
cnRpbmcgdGhvc2UgZmlsZXN5c3RlbXMgYnkgbmZzZC4KClRoZXJlZm9yZSwgZG8gbm90IGFsbG93
IG5mc2QgdG8gZXhwb3J0IGZpbGVzeXN0ZW1zIHdpdGggY3VzdG9tIC0+b3BlbigpCm9yIC0+cGVy
bWlzc2lvbigpIG1ldGhvZHMuCgpGaXhlczogYjNjYWJhOGY3YTM0YSAoInBpZGZzOiBpbXBsZW1l
bnQgZmlsZSBoYW5kbGUgc3VwcG9ydCIpCkZpeGVzOiA1MjIyNDcwYjJmYmIzICgibnNmczogc3Vw
cG9ydCBmaWxlIGhhbmRsZXMiKQpTaWduZWQtb2ZmLWJ5OiBBbWlyIEdvbGRzdGVpbiA8YW1pcjcz
aWxAZ21haWwuY29tPgotLS0KIGZzL25mc2QvZXhwb3J0LmMgICAgICAgICB8IDUgKysrLS0KIGlu
Y2x1ZGUvbGludXgvZXhwb3J0ZnMuaCB8IDkgKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDEy
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvbmZzZC9leHBv
cnQuYyBiL2ZzL25mc2QvZXhwb3J0LmMKaW5kZXggMmExNDk5ZjJhZDE5Ni4uOTJhYzhjYjBiZGVj
ZCAxMDA2NDQKLS0tIGEvZnMvbmZzZC9leHBvcnQuYworKysgYi9mcy9uZnNkL2V4cG9ydC5jCkBA
IC00MzcsOCArNDM3LDkgQEAgc3RhdGljIGludCBjaGVja19leHBvcnQoY29uc3Qgc3RydWN0IHBh
dGggKnBhdGgsIGludCAqZmxhZ3MsIHVuc2lnbmVkIGNoYXIgKnV1aWQKIAkJcmV0dXJuIC1FSU5W
QUw7CiAJfQogCi0JaWYgKCFleHBvcnRmc19jYW5fZGVjb2RlX2ZoKGlub2RlLT5pX3NiLT5zX2V4
cG9ydF9vcCkpIHsKLQkJZHByaW50aygiZXhwX2V4cG9ydDogZXhwb3J0IG9mIGludmFsaWQgZnMg
dHlwZS5cbiIpOworCWlmICghZXhwb3J0ZnNfbWF5X25mc19leHBvcnQoaW5vZGUtPmlfc2ItPnNf
ZXhwb3J0X29wKSkgeworCQlkcHJpbnRrKCJleHBfZXhwb3J0OiBleHBvcnQgb2YgaW52YWxpZCBm
cyB0eXBlICglcykuXG4iLAorCQkJaW5vZGUtPmlfc2ItPnNfdHlwZS0+bmFtZSk7CiAJCXJldHVy
biAtRUlOVkFMOwogCX0KIApkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9leHBvcnRmcy5oIGIv
aW5jbHVkZS9saW51eC9leHBvcnRmcy5oCmluZGV4IGYwY2YyNzE0ZWM1MmQuLjNlYzc4MDgwMmMx
NGUgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvZXhwb3J0ZnMuaAorKysgYi9pbmNsdWRlL2xp
bnV4L2V4cG9ydGZzLmgKQEAgLTMxNyw2ICszMTcsMTUgQEAgc3RhdGljIGlubGluZSBib29sIGV4
cG9ydGZzX2Nhbl9kZWNvZGVfZmgoY29uc3Qgc3RydWN0IGV4cG9ydF9vcGVyYXRpb25zICpub3Ap
CiAJcmV0dXJuIG5vcCAmJiBub3AtPmZoX3RvX2RlbnRyeTsKIH0KIAorc3RhdGljIGlubGluZSBi
b29sIGV4cG9ydGZzX21heV9uZnNfZXhwb3J0KGNvbnN0IHN0cnVjdCBleHBvcnRfb3BlcmF0aW9u
cyAqbm9wKQoreworCS8qCisJICogRG8gbm90IGFsbG93IGV4cG9ydGluZyB0byBORlMgZmlsZXN5
c3RlbXMgd2l0aCBjdXN0b20gLT5vcGVuKCkgYW5kCisJICogLT5wZXJtaXNzaW9uKCkgb3BzLCB3
aGljaCBuZnNkIGRvZXMgbm90IHJlc3BlY3QgKGUuZy4gcGlkZnMsIG5zZnMpLgorCSAqLworCXJl
dHVybiBleHBvcnRmc19jYW5fZGVjb2RlX2ZoKG5vcCkgJiYgIW5vcC0+b3BlbiAmJiAhbm9wLT5w
ZXJtaXNzaW9uOworfQorCiBzdGF0aWMgaW5saW5lIGJvb2wgZXhwb3J0ZnNfY2FuX2VuY29kZV9m
aChjb25zdCBzdHJ1Y3QgZXhwb3J0X29wZXJhdGlvbnMgKm5vcCwKIAkJCQkJICBpbnQgZmhfZmxh
Z3MpCiB7Ci0tIAoyLjUyLjAKCg==
--0000000000004374d1064842f2b9--

