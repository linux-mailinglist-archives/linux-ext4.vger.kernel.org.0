Return-Path: <linux-ext4+bounces-12912-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BEBD29624
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jan 2026 01:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F79930360EE
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jan 2026 00:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCAA2472AE;
	Fri, 16 Jan 2026 00:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9UCSurE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6C643147
	for <linux-ext4@vger.kernel.org>; Fri, 16 Jan 2026 00:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768522262; cv=none; b=FVbPyegKptSYT3qQggwZ4P5sF/xPIk1qWs3kZ3uycdZ65nF3xyFAklJ5B/1kf5mvPq02W/9p4R6UvJn6DVN+PePhSxqPhAvD7Rydkh2CWhJG09h/uNg2FKL9xXotXpAcaFxhTcyqSbB4EjGk+rYoBpsaJzkS/l9aInU59t4+rkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768522262; c=relaxed/simple;
	bh=wyZTSNaahlwJAh0cMf67fv0LFlau0J3pldiB0gJ7Ut0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DgLbUGQRrvjlDhYoy1hfbK00o9TFM199upmPxxhvwY4p+yX87t7In1HcIHzdlq902NTQjA7WyjDuR2B5W6ovHPG2EZ+2ULyUVGjN0LCgJi3VD4m/Qox0d7748hHI5LEW5XjF52tQSniY+XMvmi6hrsvmX1wc/nj2aw8XSbKZNkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9UCSurE; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64d30dc4ed7so2990438a12.0
        for <linux-ext4@vger.kernel.org>; Thu, 15 Jan 2026 16:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768522259; x=1769127059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuYXJTx9p8g5I9PbL+x4hBzLoIE63ueUkinqkyb6yNs=;
        b=F9UCSurEc/E/o0qrZv0sJm6R5M1k2LJgGRjY/IS1XCv9udvC9a0uLfY4ZesOCfx3VF
         PEARcHPgGVygvjB/l0v21FpXEV3fBb7nrHlM7mTsq+3RE9SeduadAZr+ynJ80UIpC1ph
         8dCV9hDcgJRSjsYgGGVDdvAWOktyvsRT1ucSCDmlKSAIfs4a8p0WpMVz+nK3WWVkZTaE
         WeVHKXCR3/Y9gcGxBaHCKewdCnyIXEy4W9uE6VfaBGVbfDu75r8u6WAT3MqHZZ44gt8h
         EjZYjkQiFW7PTzbuUgA3PnQPazG+WGBUxZHl/5H+ah9eiBIVe4IdnUOkxqO7PsYGMft6
         lN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768522259; x=1769127059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LuYXJTx9p8g5I9PbL+x4hBzLoIE63ueUkinqkyb6yNs=;
        b=GGcZ1QlNLR5Aua3JeDjMLnU4kqiriz8uFStsAiCc8IMkWb0wsucFpe08Io8ZovHFgF
         kpuvzMh5qoMI6/B/b1IDqRLe3CXsMCVou79bQ8nqy2irFoW1dlx1C1RL7wU5kEVGpSc+
         HCvgQTtglozH6OrBhOB5U3b5RC39W+cq5yhCXmPiI1/hratMA9iZE0YmBA0vc3mkeYEK
         7tRm1J+x3QN5bdZLsdlK7ehdARAoeuO7O0B7Eqfp0pb0uD8g/Qafv5v4uNK6CKsfP8qp
         R8aaEeIvrFY76JK7Qy4cMMXdldRRHUKc0xGWBR+BaMvDKOA0D1oKC1zXLm3cyyLllKxP
         78Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUfQIcVCcL3DdZbwVvyf+/kfA+fmC/1ZhR0mmIAewQnaobZ/F0UrbCvm6bguPI83Kt2k6D1k+8f+xQl@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5/byY94+LsNbHuOL+FJox3dW6/ss2m14uDcAac++A5CVCm8UL
	vYg8HJoLZPobqHnaUqKSTxcOf3h7Ynl5r+qrUftaSkASsXhh5qZr10lmNN5Mnw==
X-Gm-Gg: AY/fxX5tuqhquB3+JKRg9fhXdVKmh0WH7Z+wG9/qeVe657QIPWSSFTA+WsPamto7hJC
	4c/A0/ehp2/VbWT7/dhWRpGnqMikIBOez9dJYWh6CtqiFKvlDEI03Jl+1BVf2vQyfN5XKCCwXwp
	w7mubIIF/94kNhA03JbUkc8cMzoQC6eoQt7tDZvdU+ht18HIdjr5VUWMmoyr/0Zg8U/sZTj0uyK
	9X4NiJGHki/gowH0aD88ugqvFeVNjgLlxEwNJHvtWNtGSY4YWrRKNPo6pxXiSETtev3xmbtYzA9
	K9lhUIDVid9oDbf6xLnWoCQxLNsO7EetLyqbrrmLFPJ66qqVlvI5s5+0wCM0UnHOdaMSsuP5as+
	f5+mhOzgErB8SwwQpppaue87h5ugYSCmdQHPDbnnEqgNAdHtxvO3xD8MMULwSCDlhBA2QDqqk0l
	KA0PQNqsFvLRSnHJL6QsPwFm295bdZtKQQ8OI+uame9fwq7wicy0J1
X-Received: by 2002:a05:600d:8445:10b0:480:1a22:fce8 with SMTP id 5b1f17b1804b1-4801e3494acmr11682565e9.26.1768516821247;
        Thu, 15 Jan 2026 14:40:21 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996dad0sm1443737f8f.27.2026.01.15.14.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 14:40:20 -0800 (PST)
Date: Thu, 15 Jan 2026 22:40:18 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Dave Chinner" <david@fromorbit.com>, "Amir Goldstein"
 <amir73il@gmail.com>, "Jeff Layton" <jlayton@kernel.org>, "Christian
 Brauner" <brauner@kernel.org>, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, "Olga
 Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom
 Talpey" <tom@talpey.com>, "Hugh Dickins" <hughd@google.com>, "Baolin Wang"
 <baolin.wang@linux.alibaba.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Theodore Tso" <tytso@mit.edu>, "Andreas
 Dilger" <adilger.kernel@dilger.ca>, "Jan Kara" <jack@suse.com>, "Gao Xiang"
 <xiang@kernel.org>, "Chao Yu" <chao@kernel.org>, "Yue Hu"
 <zbestahu@gmail.com>, "Jeffle Xu" <jefflexu@linux.alibaba.com>, "Sandeep
 Dhavale" <dhavale@google.com>, "Hongbo Li" <lihongbo22@huawei.com>,
 "Chunhai Guo" <guochunhai@vivo.com>, "Carlos Maiolino" <cem@kernel.org>,
 "Ilya Dryomov" <idryomov@gmail.com>, "Alex Markuze" <amarkuze@redhat.com>,
 "Viacheslav Dubeyko" <slava@dubeyko.com>, "Chris Mason" <clm@fb.com>,
 "David Sterba" <dsterba@suse.com>, "Luis de Bethencourt"
 <luisbg@kernel.org>, "Salah Triki" <salah.triki@gmail.com>, "Phillip
 Lougher" <phillip@squashfs.org.uk>, "Steve French" <sfrench@samba.org>,
 "Paulo Alcantara" <pc@manguebit.org>, "Ronnie Sahlberg"
 <ronniesahlberg@gmail.com>, "Shyam Prasad N" <sprasad@microsoft.com>,
 "Bharath SM" <bharathsm@microsoft.com>, "Miklos Szeredi"
 <miklos@szeredi.hu>, "Mike Marshall" <hubcap@omnibond.com>, "Martin
 Brandenburg" <martin@omnibond.com>, "Mark Fasheh" <mark@fasheh.com>, "Joel
 Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>,
 "Konstantin Komarov" <almaz.alexandrovich@paragon-software.com>, "Ryusuke
 Konishi" <konishi.ryusuke@gmail.com>, "Trond Myklebust"
 <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>, "Dave Kleikamp"
 <shaggy@kernel.org>, "David Woodhouse" <dwmw2@infradead.org>, "Richard
 Weinberger" <richard@nod.at>, "Jan Kara" <jack@suse.cz>, "Andreas
 Gruenbacher" <agruenba@redhat.com>, "OGAWA Hirofumi"
 <hirofumi@mail.parknet.co.jp>, "Jaegeuk Kim" <jaegeuk@kernel.org>,
 "Christoph Hellwig" <hch@infradead.org>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-ext4@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-unionfs@vger.kernel.org, devel@lists.orangefs.org,
 ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev,
 linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 linux-mtd@lists.infradead.org, gfs2@lists.linux.dev,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 00/29] fs: require filesystems to explicitly opt-in to
 nfsd export support
Message-ID: <20260115224018.2988ca25@pumpkin>
In-Reply-To: <06dcc4b6-7457-4094-a1c6-586ce518020f@app.fastmail.com>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
	<CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>
	<d486fdb8-686c-4426-9fac-49b7dbc28765@app.fastmail.com>
	<CAOQ4uxhnoTC6KBmRVx2xhvTXYg1hRkCJWrq2eoBQGHKC3sv3Hw@mail.gmail.com>
	<4d9967cc-a454-46cf-909b-b8ab2d18358d@kernel.org>
	<aWlXfBImnC_jhTw4@dread.disaster.area>
	<06dcc4b6-7457-4094-a1c6-586ce518020f@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Jan 2026 16:37:27 -0500
"Chuck Lever" <cel@kernel.org> wrote:

> On Thu, Jan 15, 2026, at 4:09 PM, Dave Chinner wrote:
> > On Thu, Jan 15, 2026 at 02:37:09PM -0500, Chuck Lever wrote: =20
> >> On 1/15/26 2:14 PM, Amir Goldstein wrote: =20
> >> > On Thu, Jan 15, 2026 at 7:32=E2=80=AFPM Chuck Lever <cel@kernel.org>=
 wrote: =20
> >> >>
> >> >>
> >> >>
> >> >> On Thu, Jan 15, 2026, at 1:17 PM, Amir Goldstein wrote: =20
> >> >>> On Thu, Jan 15, 2026 at 6:48=E2=80=AFPM Jeff Layton <jlayton@kerne=
l.org> wrote: =20
> >> >>>>
> >> >>>> In recent years, a number of filesystems that can't present stable
> >> >>>> filehandles have grown struct export_operations. They've mostly d=
one
> >> >>>> this for local use-cases (enabling open_by_handle_at() and the li=
ke).
> >> >>>> Unfortunately, having export_operations is generally sufficient t=
o make
> >> >>>> a filesystem be considered exportable via nfsd, but that requires=
 that
> >> >>>> the server present stable filehandles. =20
> >> >>>
> >> >>> Where does the term "stable file handles" come from? and what does=
 it mean?
> >> >>> Why not "persistent handles", which is described in NFS and SMB sp=
ecs?
> >> >>>
> >> >>> Not to mention that EXPORT_OP_PERSISTENT_HANDLES was Acked
> >> >>> by both Christoph and Christian:
> >> >>>
> >> >>> https://lore.kernel.org/linux-fsdevel/20260115-rundgang-leihgabe-1=
2018e93c00c@brauner/
> >> >>>
> >> >>> Am I missing anything? =20
> >> >>
> >> >> PERSISTENT generally implies that the file handle is saved on
> >> >> persistent storage. This is not true of tmpfs. =20
> >> >=20
> >> > That's one way of interpreting "persistent".
> >> > Another way is "continuing to exist or occur over a prolonged period=
."
> >> > which works well for tmpfs that is mounted for a long time. =20
> >>=20
> >> I think we can be a lot more precise about the guarantee: The file
> >> handle does not change for the life of the inode it represents. It =20
> >
> > <pedantic mode engaged>
> >
> > File handles most definitely change over the life of a /physical/
> > inode. Unlinking a file does not require ending the life of the
> > physical object that provides the persistent data store for the
> > file.
> >
> > e.g. XFS dynamically allocates physical inodes might in a life cycle
> > that looks somewhat life this:
> >
> > 	allocate physical inode
> > 	insert record into allocated inode index
> > 	mark inode as free
> >
> > 	while (don't need to free physical inode) {
> > 		...
> > 		allocate inode for a new file
> > 		update persistent inode metadata to generate new filehandle
> > 		mark inode in use
> > 		...
> > 		unlink file
> > 		mark inode free
> > 	}
> >
> > 	remove inode from allocated inode index
> > 	free physical inode
> >
> > i.e. a free inode is still an -allocated, indexed inode- in the
> > filesystem, and until we physically remove it from the filesystem
> > the inode life cycle has not ended.
> >
> > IOWs, the physical (persistent) inode lifetime can span the lifetime
> > of -many- files. However, the filesystem guarantees that the handle
> > generated for that inode is different for each file it represents
> > over the whole inode life time.
> >
> > Hence I think that file handle stability/persistence needs to be
> > defined in terms of -file lifetimes-, not the lifetimes of the
> > filesystem objects implement the file's persistent data store. =20
>=20
> Fair enough, "inode" is the wrong term to use here.

Usually there is 'generation number' changes when the inode is used for
a new file.
IIRC the original nfs file handle was the major/minor for the disk partitio=
n,
the index into the 'on-disk inode table' (the inode number) and the
'generation number' (but I'm sure the length was a power of 2...).

It's not surprising Unix uses inode number and file handles.
K&R would have used RSM-11/M where 'file directory lookup' was a userspace
operation and the kernel only supported 'open by file handle'.
Although that got lost between there and ntfs.
(Windows IO is definitely based on RSM-11/M though.)

	David



