Return-Path: <linux-ext4+bounces-12908-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CAFD283AE
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jan 2026 20:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24A723067F6F
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jan 2026 19:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B91D31AF2C;
	Thu, 15 Jan 2026 19:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQTl8FxW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CA7320A37
	for <linux-ext4@vger.kernel.org>; Thu, 15 Jan 2026 19:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768506463; cv=none; b=XKDsZgWU2cgiZ2fbCYV5UnvSup6HeLc1V0M4ubuyQuQbp6bEnZlYugCQj8oXy4CqfqLiXSe0kNfY+gvMr5KJi3bf+Klox8ELe5k6Y1KqVe43BOnDLt3ijrVPk6tgdmOlpJkk9Cll28TaH3DLDacjxb8mYBvJAFtK0c8YUID909c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768506463; c=relaxed/simple;
	bh=1fbOaze7IPYZl8+Bgvhkjjlp1Q2kYcGwrr+7KvvQzAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mrrcLRzPxsr7x7lJAiC/35RFuFytgEcmxknGSbypDU0/9ew325M2F+1UGy6Su7yf+sFKflkCnh+81Ah5Xu/ptSM9TFgnmWMdluI7xehgnAJJKICxSW9KENGC9Z3QKpni07U9tY2qo5DvsaiUvJuO8M+SAzarTvbMKeXOqmOtw9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQTl8FxW; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64b4b35c812so2009367a12.0
        for <linux-ext4@vger.kernel.org>; Thu, 15 Jan 2026 11:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768506459; x=1769111259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/OO8RKyY0YoEvp6ZTLVXNCVFpOv1g0hFAjXGWT4AHc=;
        b=mQTl8FxWoC6x6GxyMogLEar4dsG2sS46i359vIWZutXSIDEn67W7iqZ+tqtyHE93nu
         dWP/7hnYpWMy1arwS87yyAckHyiLyVM7UTkHfeq/ugTQR/jYY8TzBEm0LbOylTdcIEEt
         +jCPj+yGpD8NFrkr47uyHKjl5a490fomdjZStqNlIKnjulLrbtaYcsBRzU6mCi22qofO
         rKLTB16vBxFhFPUCsNkLJPyejY7urHccHfmr2eaD4zPHTGitgfmi9NPsmZSohozFuCx3
         J503xFyxfDoQU0YDOc8jJVA5x3w8nXIwo6AVJeL0lSLJ2TB4IUVu7Riu9q8ApVZaoEze
         tK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768506459; x=1769111259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3/OO8RKyY0YoEvp6ZTLVXNCVFpOv1g0hFAjXGWT4AHc=;
        b=KOtB3Q0ByGOjKsQ1/L9MLGKyr8r6dMZASxgHEzpx9/14HkIBgf2Y7g4nPcVeTjOPTu
         gdxL4Ay/SrV0pIHiqQuEEkNCLsdCqppZv+y94/MbSBVmqAxgcUZfT7XVfBus8X0n3FzA
         EXFFzrSggIW21uhjL1mNLWqdZQiQkftyMw43IuCtgnkquDogf+opZlxxAsFxDMY+WPNq
         +2vKonTcpgxcXVNQD9qeE2AXfkeF9W/ry3ZtL0BAGIL3jy+X2wtSLCXDr+iijb872GBR
         XR+FoI05p9Wo7PtyxYxzYZJkE2sxzeIahIyFc9PRtyYDL3T3sICSk84LpU6LnMncFJD2
         mefQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg5+PUd3lzllwR5lxCoOVNjb1OTzer9r7WKz91BxR0PncTXYMgmywtNg+oI1bQGabFSYEGVuO3G3zT@vger.kernel.org
X-Gm-Message-State: AOJu0YypSDaNc71GfFSp1T4O3PS8SfxsoZHaFwn6Nu3mc4D+NiTHDDAB
	Pin2EsYWlFymipANAOEFy6MF8vzjPpeh+FyVG4zE+WGUvr68+FmThJGHWprL6hSprC3AauSoMdj
	OTi6mwV1sx6uphvMk5zxLmkVtHxTvcKU=
X-Gm-Gg: AY/fxX7CO/C2pU1S92G+3QTxJQPGcnx0l3wBM4KbZQjiae9s3bTPzEvvZekiRMWpCFP
	KSjW4v5pFRd2kDhd/3i7Qq3zJZwkeNcv61j62jF2i8MlurCOhw2fCO57uQTxXJs6JvcvoZ2WLs+
	CSoUiMtrYilrEyvKMQeiLw8UKs2DxdVHb8N9Jt1v/+C+NoKwF0mIdFBwJj151Dbf50E/ifEsi81
	jQouFfK1zYTShfeDGpXxMbpme2DW07oyJMIcsDO5FbX7eM1nH/2kp9PFHvDm7yckqC1syR7SJN6
	fcCTNt21PnZNuYrqSUZD0P/+GnAlEw==
X-Received: by 2002:a05:6402:268e:b0:64b:7231:da3d with SMTP id
 4fb4d7f45d1cf-654b955cf01mr167575a12.9.1768506459177; Thu, 15 Jan 2026
 11:47:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>
 <d486fdb8-686c-4426-9fac-49b7dbc28765@app.fastmail.com> <CAOQ4uxhnoTC6KBmRVx2xhvTXYg1hRkCJWrq2eoBQGHKC3sv3Hw@mail.gmail.com>
 <4d9967cc-a454-46cf-909b-b8ab2d18358d@kernel.org>
In-Reply-To: <4d9967cc-a454-46cf-909b-b8ab2d18358d@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 15 Jan 2026 20:47:27 +0100
X-Gm-Features: AZwV_QhMfL4hQaeUnA-dk4TL1Qjc8lTmxpbV_QcnWyLhkyyZFquuhwL6kPGc4Cw
Message-ID: <CAOQ4uxhtorpd6FVsaGO=NdRD72MxeDyabip84ctQYSNufobS8w@mail.gmail.com>
Subject: Re: [PATCH 00/29] fs: require filesystems to explicitly opt-in to
 nfsd export support
To: Chuck Lever <cel@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Chuck Lever <chuck.lever@oracle.com>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Theodore Tso <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, 
	Carlos Maiolino <cem@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	Phillip Lougher <phillip@squashfs.org.uk>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Bharath SM <bharathsm@microsoft.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Mike Marshall <hubcap@omnibond.com>, 
	Martin Brandenburg <martin@omnibond.com>, Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Ryusuke Konishi <konishi.ryusuke@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Dave Kleikamp <shaggy@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>, 
	Andreas Gruenbacher <agruenba@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-unionfs@vger.kernel.org, 
	devel@lists.orangefs.org, ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	linux-mtd@lists.infradead.org, gfs2@lists.linux.dev, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 8:37=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> On 1/15/26 2:14 PM, Amir Goldstein wrote:
> > On Thu, Jan 15, 2026 at 7:32=E2=80=AFPM Chuck Lever <cel@kernel.org> wr=
ote:
> >>
> >>
> >>
> >> On Thu, Jan 15, 2026, at 1:17 PM, Amir Goldstein wrote:
> >>> On Thu, Jan 15, 2026 at 6:48=E2=80=AFPM Jeff Layton <jlayton@kernel.o=
rg> wrote:
> >>>>
> >>>> In recent years, a number of filesystems that can't present stable
> >>>> filehandles have grown struct export_operations. They've mostly done
> >>>> this for local use-cases (enabling open_by_handle_at() and the like)=
.
> >>>> Unfortunately, having export_operations is generally sufficient to m=
ake
> >>>> a filesystem be considered exportable via nfsd, but that requires th=
at
> >>>> the server present stable filehandles.
> >>>
> >>> Where does the term "stable file handles" come from? and what does it=
 mean?
> >>> Why not "persistent handles", which is described in NFS and SMB specs=
?
> >>>
> >>> Not to mention that EXPORT_OP_PERSISTENT_HANDLES was Acked
> >>> by both Christoph and Christian:
> >>>
> >>> https://lore.kernel.org/linux-fsdevel/20260115-rundgang-leihgabe-1201=
8e93c00c@brauner/
> >>>
> >>> Am I missing anything?
> >>
> >> PERSISTENT generally implies that the file handle is saved on
> >> persistent storage. This is not true of tmpfs.
> >
> > That's one way of interpreting "persistent".
> > Another way is "continuing to exist or occur over a prolonged period."
> > which works well for tmpfs that is mounted for a long time.
>
> I think we can be a lot more precise about the guarantee: The file
> handle does not change for the life of the inode it represents. It
> has nothing to do with whether the file system is mounted.
>
>
> > But I am confused, because I went looking for where Jeff said that
> > you suggested stable file handles and this is what I found that you wro=
te:
> >
> > "tmpfs filehandles align quite well with the traditional definition
> >  of persistent filehandles. tmpfs filehandles live as long as tmpfs fil=
es do,
> >  and that is all that is required to be considered "persistent".
>
> I changed my mind about the name, and I let Jeff know that privately
> when he asked me to look at these patches this morning.
>
>
> >> The use of "stable" means that the file handle is stable for
> >> the life of the file. This /is/ true of tmpfs.
> >
> > I can live with STABLE_HANDLES I don't mind as much,
> > I understand what it means, but the definition above is invented,
> > whereas the term persistent handles is well known and well defined.
>
> Another reason not to adopt the same terminology as NFS is that
> someone might come along and implement NFSv4's VOLATILE file
> handles in Linux, and then say "OK, /now/ can we export cgroupfs?"
> And then Linux will be stuck with overloaded terminology and we'll
> still want to say "NO, NFS doesn't support cgroupfs".
>
> Just a random thought.

Good argument. I'm fine with stable as well :)

Thanks,
Amir.

