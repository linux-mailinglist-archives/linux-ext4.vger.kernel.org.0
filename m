Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907F84601AF
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Nov 2021 22:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbhK0V2w (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 27 Nov 2021 16:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243015AbhK0V0v (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 27 Nov 2021 16:26:51 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA84AC061574
        for <linux-ext4@vger.kernel.org>; Sat, 27 Nov 2021 13:23:36 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v23so9503570pjr.5
        for <linux-ext4@vger.kernel.org>; Sat, 27 Nov 2021 13:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=cvw1YpihZ4jObJpp77VpNrlYmoajI3VmowkGT+lWqkI=;
        b=5y310rrN79DCPfro8snMtFNNuJHmjYuc3XtC54Hiid5cBILSXmHprgEzUwN7FIIqxY
         MtBquy5qcS7PEtbJMl4gckez7E7AYx/41ZpiMJ55fjg1o7ryHx2510Nb/HLYKgdj2nIT
         nNS+B1SClZaBXxGoIK0zUrlSwbhK4NZNBDjwEKUM2ULAbhQbpXpNZCc7unxgtrOf7T7h
         La5e4xG9evPUdlM5QnXzaIiIt8nN1gtrvsKOaAw+vK6QpYLyXJ+b5zcUYfHuOHCzbFfb
         8QV5URjZJRWgxwxSipREbkQWk9+YtvaF4vy6AIDFcgLhcV3x8DzRZIBaEAPb8I0qV7D6
         uaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=cvw1YpihZ4jObJpp77VpNrlYmoajI3VmowkGT+lWqkI=;
        b=vubWJBxqf0YhIJpEV8tVGc+iDckq9SywR3D5TjWqoMXDdvWWc4L7GzVSgno59HrDPT
         z5p2pK54+N/YXNbUPxF9qbd2fgYS1eUkJldOovbrVR/s8yrE+D10ml5wq+KWFBx7r9Ll
         tp6Lb5UAmMgNzEw6T33E3vTTUO14QhfZVOWZT1EVLcEQm0wXTZJgc2gJuO7mzCRPElo4
         II4vAH9cjxgwUfKFHOx2n/uHpoow4Ru0m8QWceszLkz8fGeBTPXu+twKaDRrnaZl3MCs
         3jCHgxM5XwBXcH29/PkmMmqWYrIbEmvHqG7528G3EfPiFdhEREWUTva/vDIT+DGgRTO4
         gNtQ==
X-Gm-Message-State: AOAM5301PHcJf+bfX9BSzvws+rgZeZMNSyrhfucMcjhnfRKdTj1iT+OK
        2uTgsl2hYn6rNNBdBF38vSoORA==
X-Google-Smtp-Source: ABdhPJw86MoeLwv2JdYgdkgfGQX6KQKxAm5w01H4AJy4/2ohJXGAGEaPafibvJFffsKkIs3OlyHZCQ==
X-Received: by 2002:a17:903:11cd:b0:143:d220:fdd8 with SMTP id q13-20020a17090311cd00b00143d220fdd8mr47749019plh.79.1638048216058;
        Sat, 27 Nov 2021 13:23:36 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id d19sm12009207pfv.199.2021.11.27.13.23.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Nov 2021 13:23:35 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <1563F233-9CCB-486E-AC87-7B752EED8ABA@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_CEA46630-9276-4CE4-99FD-0D8AED223B04";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] tune2fs: implement support for set/get label iocts
Date:   Sat, 27 Nov 2021 14:23:32 -0700
In-Reply-To: <20211124134542.22270-1-lczerner@redhat.com>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>, tytso@mit.edu
To:     Lukas Czerner <lczerner@redhat.com>
References: <20211124134542.22270-1-lczerner@redhat.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_CEA46630-9276-4CE4-99FD-0D8AED223B04
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Nov 24, 2021, at 6:45 AM, Lukas Czerner <lczerner@redhat.com> wrote:
>=20
> Implement support for FS_IOC_SETFSLABEL and FS_IOC_GETFSLABEL ioctls.
> Try to use the ioctls if possible even before we open the file system
> since we don't need it. Only fall back to the old method in the case =
the
> file system is not mounted, is mounted read only in the set label =
case,
> or the ioctls are not suppported by the kernel.
>=20
> The new ioctls can also be supported by file system drivers other than
> ext4. As a result tune2fs and e2label will work for those file systems
> as well as long as the file system is mounted. Note that we still =
truncate
> the label exceeds the supported lenghth on extN file system family, =
while
> we keep the label intact for others.
>=20
> Update tune2fs and e2label as well.
>=20
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> ---
> lib/ext2fs/ext2fs.h    |  1 +
> lib/ext2fs/ismounted.c |  5 +++
> misc/e2label.8.in      |  7 ++-
> misc/tune2fs.8.in      |  8 +++-
> misc/tune2fs.c         | 96 ++++++++++++++++++++++++++++++++++++++++++
> 5 files changed, 114 insertions(+), 3 deletions(-)
>=20
> diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
> index 0ee0e7d0..68f9c1fe 100644
> --- a/lib/ext2fs/ext2fs.h
> +++ b/lib/ext2fs/ext2fs.h
> @@ -531,6 +531,7 @@ typedef struct ext2_struct_inode_scan =
*ext2_inode_scan;
> #define EXT2_MF_READONLY	4
> #define EXT2_MF_SWAP		8
> #define EXT2_MF_BUSY		16
> +#define EXT2_MF_EXTFS		32
>=20
> /*
>  * Ext2/linux mode flags.  We define them here so that we don't need
> diff --git a/lib/ext2fs/ismounted.c b/lib/ext2fs/ismounted.c
> index aee7d726..c73273b8 100644
> --- a/lib/ext2fs/ismounted.c
> +++ b/lib/ext2fs/ismounted.c
> @@ -207,6 +207,11 @@ is_root:
> 			close(fd);
> 		(void) unlink(TEST_FILE);
> 	}
> +
> +	if (!strcmp(mnt->mnt_type, "ext4") ||
> +	    !strcmp(mnt->mnt_type, "ext3") ||
> +	    !strcmp(mnt->mnt_type, "ext2"))

IMHO, using "!strcmp(...)" reads like "not matching the string ...", so =
I prefer
to use "strcmp(...) =3D=3D 0".

> +		*mount_flags |=3D EXT2_MF_EXTFS;
> 	retval =3D 0;
> errout:
> 	endmntent (f);
> diff --git a/misc/e2label.8.in b/misc/e2label.8.in
> index 1dc96199..fa5294c4 100644
> --- a/misc/e2label.8.in
> +++ b/misc/e2label.8.in
> @@ -33,7 +33,12 @@ Ext2 volume labels can be at most 16 characters =
long; if
> .I volume-label
> is longer than 16 characters,
> .B e2label
> -will truncate it and print a warning message.
> +will truncate it and print a warning message.  For other file systems =
that
> +support online label manipulation and are mounted
> +.B e2label
> +will work as well, but it will not attempt to truncate the
> +.I volume-label
> +at all.
> .PP
> It is also possible to set the volume label using the
> .B \-L
> diff --git a/misc/tune2fs.8.in b/misc/tune2fs.8.in
> index 1e026e5f..628dcdc0 100644
> --- a/misc/tune2fs.8.in
> +++ b/misc/tune2fs.8.in
> @@ -457,8 +457,12 @@ Ext2 file system labels can be at most 16 =
characters long; if
> .I volume-label
> is longer than 16 characters,
> .B tune2fs
> -will truncate it and print a warning.  The volume label can be used
> -by
> +will truncate it and print a warning.  For other file systems that
> +support online label manipulation and are mounted
> +.B tune2fs
> +will work as well, but it will not attempt to truncate the
> +.I volume-label
> +at all.  The volume label can be used by
> .BR mount (8),
> .BR fsck (8),
> and
> diff --git a/misc/tune2fs.c b/misc/tune2fs.c
> index 71a8e99b..6c162ba5 100644
> --- a/misc/tune2fs.c
> +++ b/misc/tune2fs.c
> @@ -52,6 +52,9 @@ extern int optind;
> #include <sys/types.h>
> #include <libgen.h>
> #include <limits.h>
> +#ifdef HAVE_SYS_IOCTL_H
> +#include <sys/ioctl.h>
> +#endif
>=20
> #include "ext2fs/ext2_fs.h"
> #include "ext2fs/ext2fs.h"
> @@ -70,6 +73,15 @@ extern int optind;
> #define QOPT_ENABLE	(1)
> #define QOPT_DISABLE	(-1)
>=20
> +#ifndef FS_IOC_SETFSLABEL
> +#define FSLABEL_MAX 256
> +#define FS_IOC_SETFSLABEL	_IOW(0x94, 50, char[FSLABEL_MAX])
> +#endif
> +
> +#ifndef FS_IOC_GETFSLABEL
> +#define FS_IOC_GETFSLABEL	_IOR(0x94, 49, char[FSLABEL_MAX])
> +#endif
> +
> extern int ask_yn(const char *string, int def);
>=20
> const char *program_name =3D "tune2fs";
> @@ -2997,6 +3009,75 @@ fs_update_journal_user(struct ext2_super_block =
*sb, __u8 old_uuid[UUID_SIZE])
> 	return 0;
> }
>=20
> +/*
> + * Use FS_IOC_SETFSLABEL or FS_IOC_GETFSLABEL to set/get file system =
label
> + * Return:	0 on success
> + *		1 on error
> + *		-1 when the old method should be used
> + */
> +int handle_fslabel(int setlabel) {
> +	errcode_t ret;
> +	int mnt_flags, fd;
> +	char label[FSLABEL_MAX];
> +	int maxlen =3D FSLABEL_MAX - 1;
> +	char mntpt[PATH_MAX + 1];
> +
> +	ret =3D ext2fs_check_mount_point(device_name, &mnt_flags,
> +					  mntpt, sizeof(mntpt));
> +	if (ret) {
> +		com_err(device_name, ret, _("while checking mount =
status"));
> +		return 1;
> +	}
> +	if (!(mnt_flags & EXT2_MF_MOUNTED) ||
> +	    (setlabel && (mnt_flags & EXT2_MF_READONLY)))
> +		return -1;
> +
> +	if (!mntpt[0]) {
> +		fprintf(stderr,_("Unknown mount point for %s\n"), =
device_name);
> +		return 1;
> +	}
> +
> +	fd =3D open(mntpt, O_RDONLY);

Opening read-only to change the label is a bit strange?  It would be =
better
to open in write mode, and verify in the kernel that this is the case:

	fd =3D open(mntpt, setlabel ? O_WRONLY : O_RDONLY);

> +	if (fd < 0) {
> +		com_err(mntpt, errno, _("while opening mount point"));
> +		return 1;
> +	}
> +
> +	/* Get fs label */
> +	if (!setlabel) {
> +		if (ioctl(fd, FS_IOC_GETFSLABEL, &label)) {
> +			close(fd);
> +			if (errno =3D=3D ENOTTY)
> +				return -1;
> +			com_err(mntpt, errno, _("while trying to get fs =
label"));
> +			return 1;
> +		}
> +		close(fd);
> +		printf("%.*s\n", EXT2_LEN_STR(label));
> +		return 0;
> +	}
> +
> +	/* If it's extN file system, truncate the label to appropriate =
size */
> +	if (mnt_flags & EXT2_MF_EXTFS)
> +		maxlen =3D EXT2_LABEL_LEN;
> +	if (strlen(new_label) > maxlen) {
> +		fputs(_("Warning: label too long, truncating.\n"),
> +		      stderr);
> +		new_label[maxlen] =3D '\0';
> +	}
> +
> +	/* Set fs label */
> +	if (ioctl(fd, FS_IOC_SETFSLABEL, new_label)) {
> +		close(fd);
> +		if (errno =3D=3D ENOTTY)
> +			return -1;
> +		com_err(mntpt, errno, _("while trying to set fs =
label"));
> +		return 1;
> +	}
> +	close(fd);
> +	return 0;
> +}
> +
> #ifndef BUILD_AS_LIB
> int main(int argc, char **argv)
> #else
> @@ -3038,6 +3119,21 @@ int tune2fs_main(int argc, char **argv)
> #endif
> 		io_ptr =3D unix_io_manager;
>=20
> +	/*
> +	 * Try the get/set fs label using ioctls before we even attempt
> +	 * to open the file system.
> +	 */
> +	if (L_flag || print_label) {
> +		rc =3D handle_fslabel(L_flag);
> +		if (rc !=3D -1) {
> +#ifndef BUILD_AS_LIB
> +			exit(rc);
> +#endif
> +			return rc;
> +		}
> +		rc =3D 0;
> +	}
> +
> retry_open:
> 	if ((open_flag & EXT2_FLAG_RW) =3D=3D 0 || f_flag)
> 		open_flag |=3D EXT2_FLAG_SKIP_MMP;
> --
> 2.31.1
>=20


Cheers, Andreas






--Apple-Mail=_CEA46630-9276-4CE4-99FD-0D8AED223B04
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmGiodQACgkQcqXauRfM
H+CA/w/9EhMJnMqJ8vdZN2ZWIt92lqnW2XbTkq03FtQeWir6t1fJuzbcr2miG/Np
oLPitDYUWYENDYdvXkUEGjISlJBF41n9Kp9yWzwKhdY+/JmZtpAeynRN3MZWqoPE
MM8mmzyEtJPl89/azDmWz+z6UyE+hC5tL7FNMu6N2iipFNNM1xUywkS81eNy0291
xNlK27LKGir5waSH9O0sZFPPqN1NC5S4USDxR85/JG3HX4t7AoVHurxXpD/VIxyM
ftd2071qoW22UwwGLc2f2tKweRzK43N/Lj4RsIkD0o4nNeB19db0/HfgP7/5dxi3
WwVn6TnQRnUtarLRqv869SNHG1QeU4uyrvIbb3B2U+O2ePgAKEWGgomudUnlsSSy
cmFFUU0s4LjliETgK5uZ8k94CYX1oRxx0LGFjvI+mB7VzAOS26Xjiih30ngPVFvd
4wFjIJ1emC1ZLgcpGSnGKctcZ/tf6WmXkSqJKBnh23LayaE1Z1iuf5oGgWDr6CLd
m8Gba51LC3CPIlqtF6jfrSsfOQ3D06qBSqI4TPbBz8KK2QoadSooW3koPvMsXqHH
QV/7foWuSFUH+sDKJE1hEYktuUzWKZ22zHeXfuK9y1Q2VMYEyt7oMkzDwo3nek+Q
vRCKYzqoKWuQW1EGQj3KCMi6w86U1saM/Tuz1TkVGyunFiYh1IM=
=S6gH
-----END PGP SIGNATURE-----

--Apple-Mail=_CEA46630-9276-4CE4-99FD-0D8AED223B04--
