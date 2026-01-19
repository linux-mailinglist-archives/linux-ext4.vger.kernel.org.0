Return-Path: <linux-ext4+bounces-13043-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D23CD3B299
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jan 2026 17:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0B31314845D
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jan 2026 16:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48709396D17;
	Mon, 19 Jan 2026 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ab0Y4kSR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597942EB5CD
	for <linux-ext4@vger.kernel.org>; Mon, 19 Jan 2026 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840895; cv=pass; b=a4aarkOQ8tKTZDpq07DIYRrn50G0xs0JX/M7Ce3U86LH3RtrkZ2nF1fcpVADMnabMtQSb3NNLhPRe6cKg0d+PZ68w8MIYbT7GSx60IxOm1xjEwk7xan9Qto8ii7bxVp4QXnWqvjI+LZzvMx0DxDpuuZ5k+s8M6JA8Oba7HVtusw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840895; c=relaxed/simple;
	bh=uciaFAPM3zh+7wmp1MXpjWZDIMz+W0jcWQemczxhFSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5/jkrqVjD04dGKTI/KqyywP3aC/3TcpL7SReUH34J7/Xv8S9ylfYJhS2e9oD6/hkwQestxRAbxzd+XYCpbxb/yDLbGVOAYpp4I9wsuBSDvMgJE1JgVCY0NyqOoSGD2fqkj/gsj0v+wUbGKMoNX/VILcU9/bG22uf4Qw++zUGE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ab0Y4kSR; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64d30dc4ed7so8567421a12.0
        for <linux-ext4@vger.kernel.org>; Mon, 19 Jan 2026 08:41:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768840890; cv=none;
        d=google.com; s=arc-20240605;
        b=ky61kj/No9PHNlMaQG2BDv3imznVqHz9DzevKiqhgy8GtIPNyE9QUmGQwsK2Y9cj9s
         JyA+K0hEbPHUl665Il3f3DnL8UsoYBzT9YGVD8Bzebxd+l/1A1xukn4q5NeTI3NIekV2
         lwtVISMyadBFT77rKHPMP/cZkc4KkWi//bbnnoOhjW8SiVIy0Zo8kzg3hhvh98wQzbNr
         DQTb0bsDgqimELvuxnG511zjQ4BBzwWXZpW8xpulc+DM/V1X5CiKHr19oP67yXuL9LZF
         Bs5bdQZbYL35R74x1KwZVN7gXh9oCh5FFaB+jIX6Ht9CG2kR5S6y376IH4y8MO3A8S0A
         MIwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fTdB35vgqJbH8V4J4HP1Mukd5M1Q72aH7//uMfZpgyU=;
        fh=0E0yJbKJLX8HfLtwEhk4R1oHvZi5dEt5FCQ/s+EO+fA=;
        b=NUeSxqyVMdIwRyKy6SBBJYfreLIpx4eXVaI0m+UjnGrqVC+kQUrj/jAX65U0SZ2bdl
         xbkET1GTZ97f+SQ+O0/06UKPtucz5bZ5Ey5fy8VZ0pcAdEZBnPWA4Ix55Kaq0UgKQGcz
         lfUADLP2N8yluCHh7qqtjrTi6gSoif+/jdgEIrtb56Vk5K6N5YQ8Ukvl9bUmNh1JOfyQ
         uVf2nh56MMfPYlPG8biz7nsLD8vIrgILQCCdeuGanWZt0uSNHOd/+8dk9NkPFokirnFD
         Mm2fb8C4v/yMt6cDmfm49d7JkRN/NTM/7TmkNiq8fkFvADRNhy/Y1//GQREUttD2yOXq
         rUwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768840890; x=1769445690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTdB35vgqJbH8V4J4HP1Mukd5M1Q72aH7//uMfZpgyU=;
        b=Ab0Y4kSRdlCDzFDISOShNcLZDpfAcCeDBRvMi0cjAWQkJV+oRiv0css6DqzbACQwRd
         3QH58xRjysSJXrwo/vyJS8BI3icg0//tqdqdc7tdiv0yFt43YGaicJoMqT2HZQSi9Tpr
         +VgpXStxruBBNuK7BmmBKfEut7fdMIdnpIuMMw2Bn/Ut4URgpmZVrd1NymgfXN5lVOwO
         DVfA7kE+ws0cPJd5q5GhICiAzb/7Zow85cmGC243uE1K9bifhPWgCHaw3G++YZlJLqE9
         RXh4skbTnrcnUvc0HPuosOna55LWooi6u7kaX2u0TWmoyvYXWC5OTuYpfSVeYrwK5b9F
         rzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768840890; x=1769445690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fTdB35vgqJbH8V4J4HP1Mukd5M1Q72aH7//uMfZpgyU=;
        b=K4AS89P7rzuRitGY5Hn5QcwZUM30skmJAXBaozrOi31LJJVc7HtgMLfAOU/5BssUFY
         7oW8PGVRsyb7KVdGtx4wPhDHAAFfYCBnAxLFAoiGavBFnGZC5uOUIm6gAjs5mnVr5OJH
         EKWcBKFt1kVzT95+T6mCeUfVIMf/eOy+9UCCaa027d6wUrMULhcXsa6NhDnmUAJtedaj
         TIkEgqtqu4ew9oueVfHVqeu++FVs4nBGJ7qmXE8xRqECTQ0C1yLwJXWXrmPXytb8VjwS
         AeiQCX1hZo/dLrT2ZxwaVCOuODsXjDjCAKJQtXBepKQci5Vp8J2/i2cvD+Xp7cvVJprK
         9dIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzww3vAL3PdC5vJX5YGCG7Rajt+644InC7GywESjkNYFe4kS+qn+yXMrLIYNO4CVWKd2oKjMlM2qv1@vger.kernel.org
X-Gm-Message-State: AOJu0YwNMgrNEYN+C+MZZH/L4oFgeJJuVhpUGzbIpN5iEl45kmyjTBAx
	TeNZ+00Ew9xSZa4i8Utq97GdbSUVh2qVl0XXd8Npx4XxRF8cywgY9sXCTygQsRdSMhdI9y4xdIe
	PUuGabRyOdtPQlZ5IiJTEGwktdJdcKUY=
X-Gm-Gg: AZuq6aLP+QBPK7fCtEzBZvu1g5xfMYrooQe3ay+eJdYC/3mdFgs+XgqJQumTeisKny6
	emM1fJ1Q+1dF55WUfZF7Lrbbb9N+UNK63VxWi8b2xW2db48WU7amWhsy2Lf1eRxiNyirK3zDD9N
	aBk3Nn/qSrnJj1xQaMiQHfTk3IJNnVWCLDazhuldoRcfzAmTMKChDSZxR+H8ztwq4HO2+5Q0N12
	wbQxBiJDVYYeWlr4ERnld0ci5Bl1/X6BDIfiMnDrwDmI49Rc0iHjFvGm9AB1uhFleGoAVlNINwo
	dEv/hImMFCuGsQ+qDq0bc0guiuU9sg==
X-Received: by 2002:a05:6402:518b:b0:64e:f6e1:e517 with SMTP id
 4fb4d7f45d1cf-65452cd98e9mr9387079a12.32.1768840889299; Mon, 19 Jan 2026
 08:41:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119-exportfs-nfsd-v2-0-d93368f903bd@kernel.org> <20260119-exportfs-nfsd-v2-2-d93368f903bd@kernel.org>
In-Reply-To: <20260119-exportfs-nfsd-v2-2-d93368f903bd@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 19 Jan 2026 17:41:16 +0100
X-Gm-Features: AZwV_QgHvJ6NvIXON-eIYvnT5PkMvN0FHfW-0LujoZ3K-fhpCrZ1N6375iX4_4Y
Message-ID: <CAOQ4uxjX8EcG5XssJ91u8Kn0gY9Rb0qCwnte_7j6Q6knvZ1shw@mail.gmail.com>
Subject: Re: [PATCH v2 02/31] exportfs: add new EXPORT_OP_STABLE_HANDLES flag
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
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
	Jaegeuk Kim <jaegeuk@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	David Laight <david.laight.linux@gmail.com>, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	linux-unionfs@vger.kernel.org, devel@lists.orangefs.org, 
	ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	linux-mtd@lists.infradead.org, gfs2@lists.linux.dev, 
	linux-f2fs-devel@lists.sourceforge.net, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 5:27=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> At one time, nfsd could take the presence of struct export_operations to
> be an indicator that a filesystem was exportable via NFS. Since then, a
> lot of filesystems have grown export operations in order to provide
> filehandle support. Some of those (e.g. kernfs, pidfs, and nsfs) are not
> suitable for export via NFS since they lack filehandles that are
> stable across reboot.
>
> Add a new EXPORT_OP_STABLE_HANDLES flag that indicates that the
> filesystem supports perisistent filehandles,

persistent still here?
"...are stable across the lifetime of a file"?

> a requirement for nfs
> export. While in there, switch to the BIT() macro for defining these
> flags.

Maybe you want to move that cleanup to patch 1 along with the
export.rst sync? not a must.

>
> For now, the flag is not checked anywhere. That will come later after
> we've added it to the existing filesystems that need to remain
> exportable.
>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  Documentation/filesystems/nfs/exporting.rst |  7 +++++++
>  include/linux/exportfs.h                    | 16 +++++++++-------
>  2 files changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/=
filesystems/nfs/exporting.rst
> index 0583a0516b1e3a3e6a10af95ff88506cf02f7df4..0c29ee44e3484cef84d2d3d47=
819acf172d275a3 100644
> --- a/Documentation/filesystems/nfs/exporting.rst
> +++ b/Documentation/filesystems/nfs/exporting.rst
> @@ -244,3 +244,10 @@ following flags are defined:
>      nfsd. A case in point is reexport of NFS itself, which can't be done
>      safely without coordinating the grace period handling. Other cluster=
ed
>      and networked filesystems can be problematic here as well.
> +
> +  EXPORT_OP_STABLE_HANDLES - This filesystem provides filehandles that a=
re
> +    stable across the lifetime of a file. This is a hard requirement for=
 export
> +    via nfsd. Any filesystem that is eligible to be exported via nfsd mu=
st
> +    indicate this guarantee by setting this flag. Most disk-based filesy=
stems
> +    can do this naturally. Pseudofilesystems that are for local reportin=
g and
> +    control (e.g. kernfs, pidfs, nsfs) usually can't support this.
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index f0cf2714ec52dd942b8f1c455a25702bd7e412b3..c4e0f083290e7e341342cf0b4=
5b58fddda3af65e 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -3,6 +3,7 @@
>  #define LINUX_EXPORTFS_H 1
>
>  #include <linux/types.h>
> +#include <linux/bits.h>
>  #include <linux/path.h>
>
>  struct dentry;
> @@ -277,15 +278,16 @@ struct export_operations {
>                              int nr_iomaps, struct iattr *iattr);
>         int (*permission)(struct handle_to_path_ctx *ctx, unsigned int of=
lags);
>         struct file * (*open)(const struct path *path, unsigned int oflag=
s);
> -#define        EXPORT_OP_NOWCC                 (0x1) /* don't collect v3=
 wcc data */
> -#define        EXPORT_OP_NOSUBTREECHK          (0x2) /* no subtree check=
ing */
> -#define        EXPORT_OP_CLOSE_BEFORE_UNLINK   (0x4) /* close files befo=
re unlink */
> -#define EXPORT_OP_REMOTE_FS            (0x8) /* Filesystem is remote */
> -#define EXPORT_OP_NOATOMIC_ATTR                (0x10) /* Filesystem cann=
ot supply
> +#define EXPORT_OP_NOWCC                        BIT(0) /* don't collect v=
3 wcc data */
> +#define EXPORT_OP_NOSUBTREECHK         BIT(1) /* no subtree checking */
> +#define EXPORT_OP_CLOSE_BEFORE_UNLINK  BIT(2) /* close files before unli=
nk */
> +#define EXPORT_OP_REMOTE_FS            BIT(3) /* Filesystem is remote */
> +#define EXPORT_OP_NOATOMIC_ATTR                BIT(4) /* Filesystem cann=
ot supply
>                                                   atomic attribute update=
s
>                                                 */
> -#define EXPORT_OP_FLUSH_ON_CLOSE       (0x20) /* fs flushes file data on=
 close */
> -#define EXPORT_OP_NOLOCKS              (0x40) /* no file locking support=
 */
> +#define EXPORT_OP_FLUSH_ON_CLOSE       BIT(5) /* fs flushes file data on=
 close */
> +#define EXPORT_OP_NOLOCKS              BIT(6) /* no file locking support=
 */
> +#define EXPORT_OP_STABLE_HANDLES       BIT(7) /* fhs are stable across r=
eboot */
>         unsigned long   flags;
>  };
>
>
> --
> 2.52.0
>

