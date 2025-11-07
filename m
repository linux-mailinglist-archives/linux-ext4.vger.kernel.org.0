Return-Path: <linux-ext4+bounces-11679-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 389BFC41960
	for <lists+linux-ext4@lfdr.de>; Fri, 07 Nov 2025 21:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6D218894F1
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Nov 2025 20:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3532430BF59;
	Fri,  7 Nov 2025 20:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5EGbW91"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443E518E1F
	for <linux-ext4@vger.kernel.org>; Fri,  7 Nov 2025 20:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762547357; cv=none; b=ar3Ov+lGKD3x9bpT6B0PJo/tVsHksxMxd1/DLuNm2+AJUsPcZrgJQNyj0e7z9km33Smab/iqa9xNHCPjnjRwj2Niwg9zfMZvrwyDP6a+9ZdI/tsuyf1pwhvTiLkrhmKkNjpi5e0/Le4kj46hEQmIsqBBJzLzP1BTnv4YawMOjEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762547357; c=relaxed/simple;
	bh=xrNMcMljnkU4shizQu6E/3fnfyrJLUbYnYB9foY90B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mwXbQSssTJQCnPxTHRFnwMQv/iYSgXihwVu4tRnUsRZ0YbMKJ9s6u2r8uN1ZtnS3PUePKCXB/ecaiZLFanYRT52ZtykouV3WcSAyIvSKWs3pfTYe4D0ozPGGOSpY4LtY6KK7jEQ9GwMD2iaMeEINodQtafH+Go8az4vqerdH2cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5EGbW91; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ed9c1924adso5679451cf.1
        for <linux-ext4@vger.kernel.org>; Fri, 07 Nov 2025 12:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762547355; x=1763152155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUU1NRMFjEAu/Jp6zbFkzbopK3BLE+djAoRc+VPripk=;
        b=c5EGbW913pg58PWfy7KAVBrAUazdPSXudmCIK0NB2rm1aWidFBoy5DtRpClRg9jNTT
         dVHu1OzWy+OOLMqMqiMZClZlGMa3SwDF3toIhcZNsIC8MjPtpbLPrkqgvy8i8IQQKVXx
         qgHp9IBbOYk8SwRA1ixuOHG6264kMF1wV2N+TNshW7ibxwgv0zOJgx0DDvENF8J1WHDL
         WUeQt3JaYkykozCUc9ioi6jFEIZTy7jh17uZEuxUwnTI9yJ6p6WKirNP2u+GSTNg9G80
         wMvUIvvTSUyP1+fmf93Bf/PWQJm3Xrev/kogoczl+t3rYRzGafpllCuh3i5JGU+gSVXu
         lvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762547355; x=1763152155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MUU1NRMFjEAu/Jp6zbFkzbopK3BLE+djAoRc+VPripk=;
        b=rYcjbPd53W96iSh7b3knl2j1ku3di+MNjqy6VNij2G9vVBEvh060o3OT/RfvkBn8ZZ
         J/mMHYblqq4WCo5Ey04erOAyfNfusrlQR8jizCc2j/wqGN8zoueAsVACDuoQOW6dDUIn
         l3xXtlj/6T7wmhSU0ckphNiTvqUF5KtdMjPFbyx+65V8k8dcFXT1puHTqhhF3zQmqw9F
         Ra2M6eF9KdJ8HvQbwfCEbT4gfyppggGWq10dhlvPWtz5nbhN7uOGBok5ztYOP13SyJ6/
         y2jM+H6M92O4Mofoue3qZtP4aEkneN1EeGEugNIkf7e5sr05z/ZwRCYLPz95YS1D9Yu0
         mGQg==
X-Forwarded-Encrypted: i=1; AJvYcCWv/gXxAp7CSc2uYYDjZl9G6Ed1mtmaaHDOtaDk7PyyVt9IpsvoXKs7D/709eQsk6sjpumAW31+R5Bw@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2RB28BIn1724NXsLpSrBMqOyPcZnEgbQ8hvc5x2MviIBi8wu+
	vY0NXSgOXdk18YGViFWuAqiE3246vRwmReCoe+t/wz+gB4kEaZbUNrKA87Dmhcr5ic9pg6hlQus
	2AJqMOqni+Ml0lugaCX40ZZdcN6xXAI8=
X-Gm-Gg: ASbGncvvuLnLN9hUq8Madok9LstT59pd65m+pS7izkp+WUL525Uot6XycwtAyZgp+iG
	IrsAWp0gRMSoJvnMk0rJsMUgtdRld4y5Nfx5C9od/i0XCFqrb8+59A5DkUVLuA2k6a4MTd6WZHK
	8LBYYhVDZwpoNpc3iLUAVmGskE3wJLQR3gC3Ybz8tezwLwYMUc5usTY5/zW4KUSB5tDaNevtT6Z
	RYvSHsFBOz/kZhvktLZFsLTZHxvDOZlHpFh7bwJPfzoRu+jA0uxNjYq8gzTH/KyABd71QO9JvWE
	FRHVJMBM0lAClpqv8mF95CQym2a+cqd7oOmq
X-Google-Smtp-Source: AGHT+IHixkARPlTHHvCp/UKGr0JQOjtmSbXhYfVUl8tLacVauUj/Le+z4WvhwByMUHWQJ+gNyOVStCKnkQA7oyXy8h4=
X-Received: by 2002:a05:622a:389:b0:4e8:a1eb:3e2d with SMTP id
 d75a77b69052e-4eda4e733e4mr6276641cf.2.1762547355148; Fri, 07 Nov 2025
 12:29:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169809222.1424347.16562281526870178424.stgit@frogsfrogsfrogs> <176169809339.1424347.12261722424900811903.stgit@frogsfrogsfrogs>
In-Reply-To: <176169809339.1424347.12261722424900811903.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 7 Nov 2025 12:29:04 -0800
X-Gm-Features: AWmQ_bmXVow5z-6eczbqjoGM2gOJ-0n5euhSkho1W4aXUrHDv--HLfbvcpvqMQc
Message-ID: <CAJnrk1apJbki7aZq2tNnnBcbkGKUmWDfmXVBD5YaMKUH2Fd-FA@mail.gmail.com>
Subject: Re: [PATCH 4/5] fuse: update file mode when updating acls
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 5:43=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> If someone sets ACLs on a file that can be expressed fully as Unix DAC
> mode bits, most local filesystems will then update the mode bits and
> drop the ACL xattr to reduce inefficiency in the file access paths.
> Let's do that too.  Note that means that we can setacl and end up with
> no ACL xattrs, so we also need to tolerate ENODATA returns from
> fuse_removexattr.
>
> Note that here we define a "local" fuse filesystem as one that uses
> fuseblk mode; we'll shortly add fuse servers that use iomap for the file
> IO path to that list.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_i.h |    2 +-
>  fs/fuse/acl.c    |   43 ++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 43 insertions(+), 2 deletions(-)
>
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 8c47d103c8ffa6..d550937770e16e 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1050,7 +1050,7 @@ static inline struct fuse_mount *get_fuse_mount(str=
uct inode *inode)
>         return get_fuse_mount_super(inode->i_sb);
>  }
>
> -static inline struct fuse_conn *get_fuse_conn(struct inode *inode)
> +static inline struct fuse_conn *get_fuse_conn(const struct inode *inode)
>  {
>         return get_fuse_mount_super(inode->i_sb)->fc;
>  }
> diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
> index 8f484b105f13ab..72bb4c94079b7b 100644
> --- a/fs/fuse/acl.c
> +++ b/fs/fuse/acl.c
> @@ -11,6 +11,18 @@
>  #include <linux/posix_acl.h>
>  #include <linux/posix_acl_xattr.h>
>
> +/*
> + * If this fuse server behaves like a local filesystem, we can implement=
 the
> + * kernel's optimizations for ACLs for local filesystems instead of pass=
ing
> + * the ACL requests straight through to another server.
> + */
> +static inline bool fuse_inode_has_local_acls(const struct inode *inode)
> +{
> +       const struct fuse_conn *fc =3D get_fuse_conn(inode);
> +
> +       return fc->posix_acl && fuse_inode_is_exclusive(inode);
> +}
> +
>  static struct posix_acl *__fuse_get_acl(struct fuse_conn *fc,
>                                         struct inode *inode, int type, bo=
ol rcu)
>  {
> @@ -98,6 +110,7 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentr=
y *dentry,
>         struct inode *inode =3D d_inode(dentry);
>         struct fuse_conn *fc =3D get_fuse_conn(inode);
>         const char *name;
> +       umode_t mode =3D inode->i_mode;
>         int ret;
>
>         if (fuse_is_bad(inode))
> @@ -113,6 +126,18 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct den=
try *dentry,
>         else
>                 return -EINVAL;
>
> +       /*
> +        * If the ACL can be represented entirely with changes to the mod=
e
> +        * bits, then most filesystems will update the mode bits and dele=
te
> +        * the ACL xattr.
> +        */
> +       if (acl && type =3D=3D ACL_TYPE_ACCESS &&
> +           fuse_inode_has_local_acls(inode)) {
> +               ret =3D posix_acl_update_mode(idmap, inode, &mode, &acl);
> +               if (ret)
> +                       return ret;
> +       }

nit: this could be inside the if (acl) block below.

I'm not too familiar with ACLs so i'll abstain from adding my
Reviewed-by to this.

Thanks,
Joanne

> +
>         if (acl) {
>                 unsigned int extra_flags =3D 0;
>                 /*
> @@ -143,7 +168,7 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dent=
ry *dentry,
>                  * through POSIX ACLs. Such daemons don't expect setgid b=
its to
>                  * be stripped.
>                  */
> -               if (fc->posix_acl &&
> +               if (fc->posix_acl && mode =3D=3D inode->i_mode &&
>                     !in_group_or_capable(idmap, inode,
>                                          i_gid_into_vfsgid(idmap, inode))=
)
>                         extra_flags |=3D FUSE_SETXATTR_ACL_KILL_SGID;
> @@ -152,6 +177,22 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct den=
try *dentry,
>                 kfree(value);
>         } else {
>                 ret =3D fuse_removexattr(inode, name);
> +               /* If the acl didn't exist to start with that's fine. */
> +               if (ret =3D=3D -ENODATA)
> +                       ret =3D 0;
> +       }
> +
> +       /* If we scheduled a mode update above, push that to userspace no=
w. */
> +       if (!ret) {
> +               struct iattr attr =3D { };
> +
> +               if (mode !=3D inode->i_mode) {
> +                       attr.ia_valid |=3D ATTR_MODE;
> +                       attr.ia_mode =3D mode;
> +               }
> +
> +               if (attr.ia_valid)
> +                       ret =3D fuse_do_setattr(idmap, dentry, &attr, NUL=
L);
>         }
>
>         if (fc->posix_acl) {
>

