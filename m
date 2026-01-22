Return-Path: <linux-ext4+bounces-13179-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HhHMz+HcWk1IAAAu9opvQ
	(envelope-from <linux-ext4+bounces-13179-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Jan 2026 03:11:11 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7918D60BBC
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Jan 2026 03:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4DE414422AB
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Jan 2026 02:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662BE34CFA1;
	Thu, 22 Jan 2026 02:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXr59vdq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABD31A9F88
	for <linux-ext4@vger.kernel.org>; Thu, 22 Jan 2026 02:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769047647; cv=pass; b=upt+CnsyTY3L2VkxacsHAqgQvAe1S8Sx7wRr2V0dB/s3AE7dMQVF/InUZIQ4XA9NB/CqhsZ3pYe4oHnZ7hhyn4RimK/Mkis8kGK0QQxrPzXO+d8vY3jY57pVmD5H0UNW2Ic8Q7KfDOxCmPiYVFwXSB0CD51u19pnkWZix+wZZ+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769047647; c=relaxed/simple;
	bh=Y6ljLvg48i3b1N9KN1v1Rm5dqdMrOeodbfvOYAP28aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PVleV6VQtnI9Azdz6zU5znHFFpxMQ/OtRI7OyNzFwvqH3WFtUm4x+vFMuHGD/B9OKcMhMHgpsZaqKTBOcJI4cl5tECi1eILi3fdXn1M65Hm/U6/BmNEIACVPLCYctPXza4jiANB+JJO226VN/O4r/JZnXIe9LdEuJg2DwQwq3QE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXr59vdq; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5014b7de222so5380751cf.0
        for <linux-ext4@vger.kernel.org>; Wed, 21 Jan 2026 18:07:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769047644; cv=none;
        d=google.com; s=arc-20240605;
        b=REkhz0rZMFoNkZ+dlO7Wu7ENMRJG+bOlXxL9NiFSK8UMTlR8MI7onMiMt3ykZYMU3x
         L9wnzHs+G+4SlGU+PxcSh5Pb4bUnF3DMI0F1FdMjBMuhAySv4CIwrpsiS5HMdKnkQrtY
         jFdUBGhrOZICNnHCgTkALP8keXNhgZZFV7tr/+k+tElz+Y7hRx9AH5Kp6M6p0zrBpIzg
         nsTvrTWdILHBSVHPXhcS7lr/nI8yUE1WISGk6DokppYQ7HfM0Jjpt1tCST1kCpMjITOb
         MXHXsgXrXgZ8WpVVmNg+4/TY1lJnsd7d9g9O0tECtHuzVtN5jmglk8ecy3rAkySceGeK
         lfyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+8rdTk3hQrnZKOFpAO7QycwSQJVKoagcpHPwKaebE6o=;
        fh=ne1Y56ipOCjqOYX+W6C8zWDstNiOEWqDL4fj8N8dLdg=;
        b=L3oPQJ0HE29J2ZrHFxkpcCXn43tqElpivnfLQ0pr0v6Bbw5xm+kERSW+CmXnd0Gs01
         QPRJkiXhrlc+AY+AEpeIPlQGJ0k/rk+PLcftqdDRQ1STzAch7x/bv4LfJTJ5PuBc8/2p
         bGHcV2q5o2TFDMDSPftsEwbC9L8R9HfUxIBxVZY6CkByPOd9RtQesyowmzQHafOz42fP
         PJKItmoYMeCNwWuuzo+LpsTJGEoLwieIK1UtgrY5R0pQp48waMU+J5HStuSsdTIeuaPb
         1IjZplC+E5rkxgbO1G7EGB9q6lBUhnScKKKS+EH8TWEngNhYBkCb+MHim6s+A4gK5ouu
         p18g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769047644; x=1769652444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8rdTk3hQrnZKOFpAO7QycwSQJVKoagcpHPwKaebE6o=;
        b=aXr59vdqmKzUcmY2tFjQJg3qSjDJ0IADTaRFqXU+Zzr3+fASeKBPjxrR80T0pUNC0O
         Z7RZ5V3fku2ZGmSegjgk5+KHwuergZ3oikL24vAxz8bjeStcmpekBkV5uUfAk41gMqrX
         cOR/h8blgy6+cJT4p74HDpws3bJj4ZY/JJTlk27yFe/yFbATKzj1tmyaRXtyC4/2vnCl
         zK1sQ2j3OlNwgitXuNasx+a18Eq9G08y3rHdtLrNO9PRxE2hZ+8DivuQlNqNQ6ziq5lA
         dvRoFUIbhFQIAdf1/62/mMTernRdX/ASllxlWRqO22ZhWasrYAboNdRyfVILb1eiw76v
         xjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769047644; x=1769652444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+8rdTk3hQrnZKOFpAO7QycwSQJVKoagcpHPwKaebE6o=;
        b=pDGqHvZBvZxz7cHt01vKgT9sCpSeZ5lHcfOcANmV9dCCkHlNEMplWQyyPDzqpAKKHO
         rzjk4Sne4jEbJcIl7Wm1iLZaoDaKuNrZlXHnA8ysc9rIGVhlQAif2xtnhlQbdr96SvNT
         NxCJI5eYMouHrm7MOn8KSBMtOlFbd4mJEbq64hbDaSO/v9ErKuMh7XjbUicSnoMvyVA7
         2B99216McGpCtGxgFXKLwKBn4YiALuGjP3/aKY4ip/Z2UWJxUtm7MSK79iBb3Y6bHsHp
         oFo0aF6JBvqAG8HikQ2PCjKArdL3gruUlyS1AJfkEDcUrOG7/08sZtHuW7h+fYAh4Um/
         mMiA==
X-Forwarded-Encrypted: i=1; AJvYcCUNG+EGnHoEUVjc7jjNm8E2JNbGeGJFQKjkRBlvs8f1XmIS7AMtBDTYPxyEo/KPJy0lKC0FtpEQ9GSR@vger.kernel.org
X-Gm-Message-State: AOJu0YzHmFBj/aGfFwUpd/zxzB/sbKPJgAq/Cn12gaBOuYZ3f4sbPlL6
	dwQk65JkfQ+3c07DAYqxJDtb4SagfIEfo7CJrmRr7xA/arMNomt+lja5bqqaLgOIikiMlpS/M6s
	oNQCH6gF1h4rPKKF/uxQBK8VO0DwqP2Q=
X-Gm-Gg: AZuq6aLH/m5IiHR0KIaBu754jsw4/ezCrJGA5vGqqMu6XNAz5MDhta5HhtSVZCmKMvd
	YXmYNbC37DoFEPXJRdaKHWsZCvkRayQOv5xYm/TTn481/9iLbDhPbdIChpVfROojVk7OT5DsTrU
	aZB9sH80facbAyiJ6rV0xOvTTD0Gi1Wg4Gz6mXb/CAJfXU++92OJUtWpDCfd7RcyUfLlq/4nEbG
	kqlwTOJLDdZu0PakLPO2FC6FPQYahvXabHUQGoWGbXlI3Gc9ngnUmIDzE+fuKbOySmRIg==
X-Received: by 2002:ac8:5dc9:0:b0:4ee:2984:7d93 with SMTP id
 d75a77b69052e-502a1652b7cmr228472581cf.17.1769047644168; Wed, 21 Jan 2026
 18:07:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs> <176169810568.1424854.4073875923015322741.stgit@frogsfrogsfrogs>
In-Reply-To: <176169810568.1424854.4073875923015322741.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 21 Jan 2026 18:07:12 -0800
X-Gm-Features: AZwV_QgoK3RTteN4i0D884plVDnteDhgPN2E7eEuueAfxxEN0Wwf3HfnKt32BqU
Message-ID: <CAJnrk1Y8Fi7ZgY15WDtKZ1kVAsh-kzfNbEOvHKNwCxtA6iWzWA@mail.gmail.com>
Subject: Re: [PATCH 10/31] fuse: implement basic iomap reporting such as
 FIEMAP and SEEK_{DATA,HOLE}
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13179-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-ext4];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7918D60BBC
X-Rspamd-Action: no action

On Tue, Oct 28, 2025 at 5:47=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> Implement the basic file mapping reporting functions like FIEMAP, BMAP,
> and SEEK_DATA/HOLE.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_i.h     |    8 ++++++
>  fs/fuse/dir.c        |    1 +
>  fs/fuse/file.c       |   13 ++++++++++
>  fs/fuse/file_iomap.c |   68 ++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  4 files changed, 89 insertions(+), 1 deletion(-)
>
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index c7aeb324fe599e..6fe8aa1845b98d 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1730,6 +1730,11 @@ static inline bool fuse_inode_has_iomap(const stru=
ct inode *inode)
>
>         return test_bit(FUSE_I_IOMAP, &fi->state);
>  }
> +
> +int fuse_iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fi=
einfo,
> +                     u64 start, u64 length);
> +loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence);
> +sector_t fuse_iomap_bmap(struct address_space *mapping, sector_t block);
>  #else
>  # define fuse_iomap_enabled(...)               (false)
>  # define fuse_has_iomap(...)                   (false)
> @@ -1739,6 +1744,9 @@ static inline bool fuse_inode_has_iomap(const struc=
t inode *inode)
>  # define fuse_iomap_init_nonreg_inode(...)     ((void)0)
>  # define fuse_iomap_evict_inode(...)           ((void)0)
>  # define fuse_inode_has_iomap(...)             (false)
> +# define fuse_iomap_fiemap                     NULL
> +# define fuse_iomap_lseek(...)                 (-ENOSYS)
> +# define fuse_iomap_bmap(...)                  (-ENOSYS)
>  #endif
>
>  #endif /* _FS_FUSE_I_H */
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 18eb1bb192bb58..bafc386f2f4d3a 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -2296,6 +2296,7 @@ static const struct inode_operations fuse_common_in=
ode_operations =3D {
>         .set_acl        =3D fuse_set_acl,
>         .fileattr_get   =3D fuse_fileattr_get,
>         .fileattr_set   =3D fuse_fileattr_set,
> +       .fiemap         =3D fuse_iomap_fiemap,
>  };
>
>  static const struct inode_operations fuse_symlink_inode_operations =3D {
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index bd9c208a46c78d..8a981f41b1dbd0 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -2512,6 +2512,12 @@ static sector_t fuse_bmap(struct address_space *ma=
pping, sector_t block)
>         struct fuse_bmap_out outarg;
>         int err;
>
> +       if (fuse_inode_has_iomap(inode)) {
> +               sector_t alt_sec =3D fuse_iomap_bmap(mapping, block);
> +               if (alt_sec > 0)
> +                       return alt_sec;
> +       }
> +
>         if (!inode->i_sb->s_bdev || fm->fc->no_bmap)
>                 return 0;
>
> @@ -2547,6 +2553,13 @@ static loff_t fuse_lseek(struct file *file, loff_t=
 offset, int whence)
>         struct fuse_lseek_out outarg;
>         int err;
>
> +       if (fuse_inode_has_iomap(inode)) {
> +               loff_t alt_pos =3D fuse_iomap_lseek(file, offset, whence)=
;
> +
> +               if (alt_pos >=3D 0 || (alt_pos < 0 && alt_pos !=3D -ENOSY=
S))

I don't think you technically need the "alt_pos < 0" part here since
the  "alt_pos >=3D 0 ||" part already accounts for that

> +                       return alt_pos;
> +       }
> +
>         if (fm->fc->no_lseek)
>                 goto fallback;
>
> diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
> index 66a7b8faa31ac2..ce64e7c4860ef8 100644
> --- a/fs/fuse/file_iomap.c
> +++ b/fs/fuse/file_iomap.c
> @@ -4,6 +4,7 @@
>   * Author: Darrick J. Wong <djwong@kernel.org>
>   */
>  #include <linux/iomap.h>
> +#include <linux/fiemap.h>
>  #include "fuse_i.h"
>  #include "fuse_trace.h"
>  #include "iomap_i.h"
> @@ -561,7 +562,7 @@ static int fuse_iomap_end(struct inode *inode, loff_t=
 pos, loff_t count,
>         return err;
>  }
>
> -const struct iomap_ops fuse_iomap_ops =3D {
> +static const struct iomap_ops fuse_iomap_ops =3D {
>         .iomap_begin            =3D fuse_iomap_begin,
>         .iomap_end              =3D fuse_iomap_end,
>  };
> @@ -690,3 +691,68 @@ void fuse_iomap_evict_inode(struct inode *inode)
>         if (conn->iomap && fuse_inode_is_exclusive(inode))
>                 clear_bit(FUSE_I_EXCLUSIVE, &fi->state);
>  }
> +
> +int fuse_iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fi=
einfo,
> +                     u64 start, u64 count)
> +{
> +       struct fuse_conn *fc =3D get_fuse_conn(inode);
> +       int error;
> +
> +       /*
> +        * We are called directly from the vfs so we need to check per-in=
ode
> +        * support here explicitly.
> +        */
> +       if (!fuse_inode_has_iomap(inode))
> +               return -EOPNOTSUPP;
> +
> +       if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR)

I don't see where FIEMAP_FLAG_SYNC and FIEMAP_FLAG_CACHE are supported
either, should these return -EOPNOTSUPP if they're set as well?

> +               return -EOPNOTSUPP;
> +
> +       if (fuse_is_bad(inode))
> +               return -EIO;
> +
> +       if (!fuse_allow_current_process(fc))
> +               return -EACCES;
> +
> +       inode_lock_shared(inode);
> +       error =3D iomap_fiemap(inode, fieinfo, start, count, &fuse_iomap_=
ops);
> +       inode_unlock_shared(inode);
> +
> +       return error;
> +}
> +
> +sector_t fuse_iomap_bmap(struct address_space *mapping, sector_t block)
> +{
> +       ASSERT(fuse_inode_has_iomap(mapping->host));
> +
> +       return iomap_bmap(mapping, block, &fuse_iomap_ops);
> +}
> +
> +loff_t fuse_iomap_lseek(struct file *file, loff_t offset, int whence)
> +{
> +       struct inode *inode =3D file->f_mapping->host;
> +       struct fuse_conn *fc =3D get_fuse_conn(inode);
> +
> +       ASSERT(fuse_inode_has_iomap(inode));
> +
> +       if (fuse_is_bad(inode))
> +               return -EIO;
> +
> +       if (!fuse_allow_current_process(fc))
> +               return -EACCES;
> +
> +       switch (whence) {
> +       case SEEK_HOLE:
> +               offset =3D iomap_seek_hole(inode, offset, &fuse_iomap_ops=
);
> +               break;
> +       case SEEK_DATA:
> +               offset =3D iomap_seek_data(inode, offset, &fuse_iomap_ops=
);
> +               break;
> +       default:

Does it make sense to have the default case just call generic_file_llseek()=
?

Thanks,
Joanne

> +               return -ENOSYS;
> +       }
> +
> +       if (offset < 0)
> +               return offset;
> +       return vfs_setpos(file, offset, inode->i_sb->s_maxbytes);
> +}
>

