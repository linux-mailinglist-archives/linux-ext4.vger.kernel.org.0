Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C59A4624B4
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Nov 2021 23:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhK2WYx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Nov 2021 17:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbhK2WXF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 29 Nov 2021 17:23:05 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD0DC218876
        for <linux-ext4@vger.kernel.org>; Mon, 29 Nov 2021 12:19:42 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id k4so13086642plx.8
        for <linux-ext4@vger.kernel.org>; Mon, 29 Nov 2021 12:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=ZrHuzwj2xsuKt2UDbaSJD4qZRd40xcznRk9SAEmOCSs=;
        b=Z85SdehfoRh9QTpbV8PY+kmTlGaHoU7aOW7w26VlVUOgOyMCODUxNHVv3dLDVOw1Tb
         1oikCkiTp0J3piHTIx2MmhwC1ZXWZ0EXFYJgTDTiBVhVmvInodj3xRSCNrVxXss+fN5O
         WbIGiWcKCg+v+SBvwJQ4CCE5J7DEl63xbu+6wcKT4vNMdXBemkIyxMsf6LX1FXN4kpie
         XIR3cnWc38PlLfjUnsBLuzHAfMd3GWVNDIO7rhoBM6NVUBi7Qes2jY2jJmOQt9lmPi8M
         FzW9T2dG/8fGl9Y0k+qhMxr5LL/WIsnpiwn49Rx+lerpsKZ3HSDYUGZDa+KnMNifjBad
         eCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=ZrHuzwj2xsuKt2UDbaSJD4qZRd40xcznRk9SAEmOCSs=;
        b=np5wp6Q2AG3MKJI1r6YilDTTYjeh69scqlS4h0WWtGBMbqzb3YfMqiCGWAnngDS5GU
         jVmuxE2JXdX5QFJ743GJdddpeGjoJ4D6nkAM/Q52maBkmxOW2vCmOWiyZzRh3bUmo004
         9Di0cFyL0FIGakHicE5Eg+bdpjG6+LJYNR7ulIIUIhz8HU8zmwnYWRN+e5uFX4fSz9+g
         RIzgGiPxsXgGZgN8zaT1cKKl3kseCkJy2+pu56lV2tXKTibS5tWOV138Ag322eMPWyOl
         cm/cosp6B4fWzNZHwvJk9HbniT3Dc/stBbsliI5zEi41t6Dq8FcnZE8cKkYVs+m1aWUH
         BeDQ==
X-Gm-Message-State: AOAM5327QKUuPHTVsWbTaWJARshLzPbaYZxUbk8FYrHna1ALXHiL+Zu9
        eLLLdR4/FRSET9ajYoTIClvNQA==
X-Google-Smtp-Source: ABdhPJyCDtE3fWu7yvc0d9qXIHK96bZV7U2rKZqwp4pZA1wcW/RWrdD9F2iCm55VcqgLRc6Hop7AYw==
X-Received: by 2002:a17:90b:3a83:: with SMTP id om3mr413757pjb.0.1638217181469;
        Mon, 29 Nov 2021 12:19:41 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id t4sm17505269pfj.168.2021.11.29.12.19.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Nov 2021 12:19:40 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <A1C42801-D532-44AC-83E9-4142A9F60548@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_C790DD71-67CA-45C8-80B4-2E8D6B08BF02";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] tune2fs: implement support for set/get label iocts
Date:   Mon, 29 Nov 2021 13:19:35 -0700
In-Reply-To: <20211129093647.5iycxxodael4dkt5@work>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>, tytso@mit.edu
To:     Lukas Czerner <lczerner@redhat.com>
References: <20211124134542.22270-1-lczerner@redhat.com>
 <1563F233-9CCB-486E-AC87-7B752EED8ABA@dilger.ca>
 <20211129093647.5iycxxodael4dkt5@work>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_C790DD71-67CA-45C8-80B4-2E8D6B08BF02
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Nov 29, 2021, at 2:36 AM, Lukas Czerner <lczerner@redhat.com> =
wrote:
>=20
> On Sat, Nov 27, 2021 at 02:23:32PM -0700, Andreas Dilger wrote:
>> On Nov 24, 2021, at 6:45 AM, Lukas Czerner <lczerner@redhat.com> =
wrote:
>>>=20
>>> Implement support for FS_IOC_SETFSLABEL and FS_IOC_GETFSLABEL =
ioctls.
>>> Try to use the ioctls if possible even before we open the file =
system
>>> since we don't need it. Only fall back to the old method in the case =
the
>>> file system is not mounted, is mounted read only in the set label =
case,
>>> or the ioctls are not suppported by the kernel.
>>>=20
>>> The new ioctls can also be supported by file system drivers other =
than
>>> ext4. As a result tune2fs and e2label will work for those file =
systems
>>> as well as long as the file system is mounted. Note that we still =
truncate
>>> the label exceeds the supported lenghth on extN file system family, =
while
>>> we keep the label intact for others.
>>>=20
>>> Update tune2fs and e2label as well.
>>>=20
>>> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
>>> ---
>>> lib/ext2fs/ext2fs.h    |  1 +
>>> lib/ext2fs/ismounted.c |  5 +++
>>> misc/e2label.8.in      |  7 ++-
>>> misc/tune2fs.8.in      |  8 +++-
>>> misc/tune2fs.c         | 96 =
++++++++++++++++++++++++++++++++++++++++++
>>> 5 files changed, 114 insertions(+), 3 deletions(-)
>>>=20
>>> diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
>>> index 0ee0e7d0..68f9c1fe 100644
>>> --- a/lib/ext2fs/ext2fs.h
>>> +++ b/lib/ext2fs/ext2fs.h
>>> @@ -531,6 +531,7 @@ typedef struct ext2_struct_inode_scan =
*ext2_inode_scan;
>>> #define EXT2_MF_READONLY	4
>>> #define EXT2_MF_SWAP		8
>>> #define EXT2_MF_BUSY		16
>>> +#define EXT2_MF_EXTFS		32
>>>=20
>>> /*
>>> * Ext2/linux mode flags.  We define them here so that we don't need
>>> diff --git a/lib/ext2fs/ismounted.c b/lib/ext2fs/ismounted.c
>>> index aee7d726..c73273b8 100644
>>> --- a/lib/ext2fs/ismounted.c
>>> +++ b/lib/ext2fs/ismounted.c
>>> @@ -207,6 +207,11 @@ is_root:
>>> 			close(fd);
>>> 		(void) unlink(TEST_FILE);
>>> 	}
>>> +
>>> +	if (!strcmp(mnt->mnt_type, "ext4") ||
>>> +	    !strcmp(mnt->mnt_type, "ext3") ||
>>> +	    !strcmp(mnt->mnt_type, "ext2"))
>>=20
>> IMHO, using "!strcmp(...)" reads like "not matching the string ...", =
so I prefer
>> to use "strcmp(...) =3D=3D 0".
>=20
> Hi Andreas, thanks for thre review!
>=20
> Ok, I can change that.
>=20
>>=20
>>> +		*mount_flags |=3D EXT2_MF_EXTFS;
>>> 	retval =3D 0;
>>> errout:
>>> 	endmntent (f);
>>> diff --git a/misc/e2label.8.in b/misc/e2label.8.in
>>> index 1dc96199..fa5294c4 100644
>>> --- a/misc/e2label.8.in
>>> +++ b/misc/e2label.8.in
>>> @@ -33,7 +33,12 @@ Ext2 volume labels can be at most 16 characters =
long; if
>>> .I volume-label
>>> is longer than 16 characters,
>>> .B e2label
>>> -will truncate it and print a warning message.
>>> +will truncate it and print a warning message.  For other file =
systems that
>>> +support online label manipulation and are mounted
>>> +.B e2label
>>> +will work as well, but it will not attempt to truncate the
>>> +.I volume-label
>>> +at all.
>>> .PP
>>> It is also possible to set the volume label using the
>>> .B \-L
>>> diff --git a/misc/tune2fs.8.in b/misc/tune2fs.8.in
>>> index 1e026e5f..628dcdc0 100644
>>> --- a/misc/tune2fs.8.in
>>> +++ b/misc/tune2fs.8.in
>>> @@ -457,8 +457,12 @@ Ext2 file system labels can be at most 16 =
characters long; if
>>> .I volume-label
>>> is longer than 16 characters,
>>> .B tune2fs
>>> -will truncate it and print a warning.  The volume label can be used
>>> -by
>>> +will truncate it and print a warning.  For other file systems that
>>> +support online label manipulation and are mounted
>>> +.B tune2fs
>>> +will work as well, but it will not attempt to truncate the
>>> +.I volume-label
>>> +at all.  The volume label can be used by
>>> .BR mount (8),
>>> .BR fsck (8),
>>> and
>>> diff --git a/misc/tune2fs.c b/misc/tune2fs.c
>>> index 71a8e99b..6c162ba5 100644
>>> --- a/misc/tune2fs.c
>>> +++ b/misc/tune2fs.c
>>> @@ -52,6 +52,9 @@ extern int optind;
>>> #include <sys/types.h>
>>> #include <libgen.h>
>>> #include <limits.h>
>>> +#ifdef HAVE_SYS_IOCTL_H
>>> +#include <sys/ioctl.h>
>>> +#endif
>>>=20
>>> #include "ext2fs/ext2_fs.h"
>>> #include "ext2fs/ext2fs.h"
>>> @@ -70,6 +73,15 @@ extern int optind;
>>> #define QOPT_ENABLE	(1)
>>> #define QOPT_DISABLE	(-1)
>>>=20
>>> +#ifndef FS_IOC_SETFSLABEL
>>> +#define FSLABEL_MAX 256
>>> +#define FS_IOC_SETFSLABEL	_IOW(0x94, 50, char[FSLABEL_MAX])
>>> +#endif
>>> +
>>> +#ifndef FS_IOC_GETFSLABEL
>>> +#define FS_IOC_GETFSLABEL	_IOR(0x94, 49, char[FSLABEL_MAX])
>>> +#endif
>>> +
>>> extern int ask_yn(const char *string, int def);
>>>=20
>>> const char *program_name =3D "tune2fs";
>>> @@ -2997,6 +3009,75 @@ fs_update_journal_user(struct =
ext2_super_block *sb, __u8 old_uuid[UUID_SIZE])
>>> 	return 0;
>>> }
>>>=20
>>> +/*
>>> + * Use FS_IOC_SETFSLABEL or FS_IOC_GETFSLABEL to set/get file =
system label
>>> + * Return:	0 on success
>>> + *		1 on error
>>> + *		-1 when the old method should be used
>>> + */
>>> +int handle_fslabel(int setlabel) {
>>> +	errcode_t ret;
>>> +	int mnt_flags, fd;
>>> +	char label[FSLABEL_MAX];
>>> +	int maxlen =3D FSLABEL_MAX - 1;
>>> +	char mntpt[PATH_MAX + 1];
>>> +
>>> +	ret =3D ext2fs_check_mount_point(device_name, &mnt_flags,
>>> +					  mntpt, sizeof(mntpt));
>>> +	if (ret) {
>>> +		com_err(device_name, ret, _("while checking mount =
status"));
>>> +		return 1;
>>> +	}
>>> +	if (!(mnt_flags & EXT2_MF_MOUNTED) ||
>>> +	    (setlabel && (mnt_flags & EXT2_MF_READONLY)))
>>> +		return -1;
>>> +
>>> +	if (!mntpt[0]) {
>>> +		fprintf(stderr,_("Unknown mount point for %s\n"), =
device_name);
>>> +		return 1;
>>> +	}
>>> +
>>> +	fd =3D open(mntpt, O_RDONLY);
>>=20
>> Opening read-only to change the label is a bit strange?  It would be =
better
>> to open in write mode, and verify in the kernel that this is the =
case:
>>=20
>> 	fd =3D open(mntpt, setlabel ? O_WRONLY : O_RDONLY);
>=20
> I am not convinced about this. Sure it may feel strange, but:
>=20
> - we're not operating on the file itself but the file system in =
general
>   and that needs to be rw mounted; kernel will check that
> - no other fslabel implementation requires the file to be opened for
>   writing.
> - we don't even require file to be opened to writing for the most of =
our
>   own special ioctls if they don't deal with the file itself such as
>   EXT4_IOC_MOVE_EXT and EXT4_IOC_SWAP_BOOT
> - btrfs-progs uses O_RDONLY of setting label, fstrim uses O_RDONLY for
>   FITRIM and I am sure there are plenty more examples.
>=20
> So AFAICT the standard seems to be not to require it and just open
> O_RDONLY if we really want a handle of a file system, not the file
> itself. I don't really care either way, but I am not willing to change
> what to me seems to be a standard way of doing this.
>=20
> So if you insist I'll change the code here, but I won't change it on =
the
> kernel side to require FMODE_WRITE.

I see in the kernel patch that it is checking for CAP_SYS_ADMIN, so that
should be enough protection.

You can add my:

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Cheers, Andreas






--Apple-Mail=_C790DD71-67CA-45C8-80B4-2E8D6B08BF02
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmGlNdcACgkQcqXauRfM
H+DRlQ/+IBmGhwDUznSYq+iIpKKhDoyUqqIRhqntyZgWWdRIz7eZuh39yFtu7bx7
4v0YweAQxq2feqUuEOqysnqf3FvYloKbtQ0cMr0wfQ4u1TCBgXaYmgme9FsiQhS1
TTuQfVIcQ3eouGbJ46SNeF+IQGc3Df6aidIB79WBFkks+SYJ5OjVxavbTw03eFiB
fR9h6yj7qvY4eodayBZGv4u+4utfHu3GWiLimb4NEQTdvBWVcBCvknClJAOpPAAE
mBDYZSKgPPoqXikLtp+MumdE1OyfCLAIB1MSjTDP7+Q8gx344QhBhp7zgcIuMoOf
G1gLIWXgJflX7/iehbed1ChX1Dc46kiiGluOdTXDZbxIg3VAqg/C/xz9dP5JlyrW
kvhwHd0FpVduD6jXWqiDK7pMo2z+odB7I4UWogvoGF/7z1D9tGnL8lm1FkR2iKX3
tSH+0oaqY7HrABRVJbhe5IrQ9atPre15sJ58OJuYlyx2nBvV0zg0IqLqudJ/imZu
nup7vPczYruYinMqxnmGDExfo3rmZK7OvffedwrCi6LxhZnFNI41sJN2IFf6og/j
1NGl5I9dMkLgzGVDLI2wYmtboY8Gr0mru9jmFnqJHNAervJbBFfxR9VxJBzCxuch
16A1vPMtd7TawLQ1vjkz0iVgF5kBIyF5BlJz0ohPMk/RrwlBgHA=
=0W77
-----END PGP SIGNATURE-----

--Apple-Mail=_C790DD71-67CA-45C8-80B4-2E8D6B08BF02--
