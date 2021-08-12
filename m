Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F523E9BB7
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Aug 2021 02:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbhHLAsz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Aug 2021 20:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbhHLAsz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Aug 2021 20:48:55 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF835C061765
        for <linux-ext4@vger.kernel.org>; Wed, 11 Aug 2021 17:48:30 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id j1so6504051pjv.3
        for <linux-ext4@vger.kernel.org>; Wed, 11 Aug 2021 17:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=0AG58MWcybh34MbhrEhjmKMfUcGc2nvyrmfRLOtW8pU=;
        b=pFLAce2r7oaAusNAJwImxaw8mEBRFta6r0qss7bTHQ91pISh2MDssPLgCcOao0KO90
         yx9pZsc89gvruB25ZQ0BhIyL4Mo3ePlJbshRQIMTTqAAlxvkqtcYqmqq08sAtFE7lA2G
         hZAEyPfimuvUnpC1Yk81SYKi5OdT46lomppkJ3/wcn8it4O1zT3Dw8aF/HwksCX3MUHp
         cCvycjDGxaHhdFLJK1VQ0dRME5O5ocZ+s3Fxvv+Zm9p3W7Pbe0kV6F8sZpPeagECTiYY
         JGFJFNnIqRFfoICRTIUyE1WJ5vyxQK7EKCsFC27cmIO0RS0cDCvSleLvmP8rL5l1lkRr
         Zy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=0AG58MWcybh34MbhrEhjmKMfUcGc2nvyrmfRLOtW8pU=;
        b=syWa2w1X3eZynQVXB8OUrSQIjbkiey+qqx3NeNkdRQfqdxxg5aPvhwXYh6Am0Of48h
         0b/Az3+in5wyZ1GPdrgtPzefYYUwAnuuOGK0BvrJYwAgETShTZnE5nFKba9Ph6zePKU4
         vFBK+LiO58gLW5V2B3IVBosUWQmVvV5FiJpLYY20NCqd77GWxy7zd4jogQEhewDetxcV
         NbLAVZjt6VY2nPeBktnVPvUdj1FI91ax4svLV94mohHt9MGqxNikvodeWBFQg+PWHydj
         tboygV611iv3Qjkg0fqFtBKg5CV5ZKB82DlgcSL2qwpFKttMb7MJ1wgYQsc95kq6lE1W
         wyoA==
X-Gm-Message-State: AOAM530CPMEPJem/NsdP6AJr0RwEGgjtf0EJ8MgDdgbktQRMYHE0RgJs
        N8RfpaE0cjHNeUN/iXd7/Gjj7g==
X-Google-Smtp-Source: ABdhPJyvzSDUB4Y+wpu2tQEetmmFl/e3GXVLjt8EUk5M/+lSa5IUtM5M8MRMjOzOsPSTi+/OHpbX2Q==
X-Received: by 2002:a05:6a00:80f:b029:30d:82e1:ce14 with SMTP id m15-20020a056a00080fb029030d82e1ce14mr1479467pfk.29.1628729310318;
        Wed, 11 Aug 2021 17:48:30 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id c21sm778607pfo.193.2021.08.11.17.48.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Aug 2021 17:48:28 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <34413996-BBB2-4862-ABFE-BA3420C640F5@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_02CC29B2-F05C-47B3-B871-E2F6BE632219";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] mke2fs: warn about missing y2038 support when formatting
 fresh ext4 fs
Date:   Wed, 11 Aug 2021 18:48:23 -0600
In-Reply-To: <20210811233253.GC3601392@magnolia>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
References: <20210811233253.GC3601392@magnolia>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_02CC29B2-F05C-47B3-B871-E2F6BE632219
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 11, 2021, at 5:32 PM, Darrick J. Wong <djwong@kernel.org> wrote:
>=20
> From: Darrick J. Wong <djwong@kernel.org>
>=20
> Filesystems with 128-byte inodes do not support timestamps beyond the
> year 2038.  Since we're now less than 16.5 years away from that point,
> it's time to start warning users about this lack of support when they
> format an ext4 filesystem with small inodes.
>=20
> First, change the mke2fs.conf file to specify 256-byte inodes even for
> small filesystems, then add a warning to mke2fs itself if someone is
> trying to make us format an ext4 filesystem with 128-byte inodes.
>=20
> Note that we /don't/ warn about these things if the user has signalled
> that they want an old format such as ext2, ext3, or hurd.  Everyone
> should know by now that those are legacy.
>=20
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> misc/mke2fs.c       |   35 +++++++++++++++++++++++++++++++++++
> misc/mke2fs.conf.in |    4 ++--
> 2 files changed, 37 insertions(+), 2 deletions(-)
>=20
> diff --git a/misc/mke2fs.c b/misc/mke2fs.c
> index 92003e11..b16880c2 100644
> --- a/misc/mke2fs.c
> +++ b/misc/mke2fs.c
> @@ -1537,6 +1537,30 @@ static int get_device_geometry(const char =
*file,
> }
> #endif
>=20
> +/*
> + * Returns true if the user is forcing an old format (e.g. ext2, =
ext3).
> + *
> + * If there is no fs_types list, the user invoked us with no explicit =
type and
> + * gets the default (ext4) format.  If we find the latest format =
(ext4) in the
> + * type list, some combination of program name and -T argument put us =
in ext4
> + * mode.  Anything else (ext2, ext3, hurd) and we return false.
> + */
> +static inline int
> +old_format_forced(char **fs_types)
> +{
> +	int found_ext4 =3D 0;
> +	int i;
> +
> +	if (!fs_types)
> +		return 0;
> +
> +	for (i =3D 0; fs_types[i]; i++)
> +		if (!strcmp(fs_types[i], "ext4"))
> +			found_ext4 =3D 1;
> +
> +	return !found_ext4;
> +}
> +
> static void PRS(int argc, char *argv[])
> {
> 	int		b, c, flags;
> @@ -2603,6 +2627,17 @@ static void PRS(int argc, char *argv[])
> 		exit(1);
> 	}
>=20
> +	/* If the user didn't tell us to format with an old ondisk =
format... */
> +	if (!old_format_forced(fs_types)) {
> +		/*
> +		 * ...warn them that filesystems with 128-byte inodes =
will not
> +		 * work properly beyond 2038.
> +		 */
> +		if (inode_size =3D=3D EXT2_GOOD_OLD_INODE_SIZE)
> +			printf(
> +_("128-byte inodes cannot handle dates beyond 2038 and are =
deprecated\n"));
> +	}
> +
> 	/* Make sure number of inodes specified will fit in 32 bits */
> 	if (num_inodes =3D=3D 0) {
> 		unsigned long long n;
> diff --git a/misc/mke2fs.conf.in b/misc/mke2fs.conf.in
> index 01e35cf8..2fa1a824 100644
> --- a/misc/mke2fs.conf.in
> +++ b/misc/mke2fs.conf.in
> @@ -16,12 +16,12 @@
> 	}
> 	small =3D {
> 		blocksize =3D 1024
> -		inode_size =3D 128
> +		inode_size =3D 256
> 		inode_ratio =3D 4096
> 	}
> 	floppy =3D {
> 		blocksize =3D 1024
> -		inode_size =3D 128
> +		inode_size =3D 256
> 		inode_ratio =3D 8192
> 	}
> 	big =3D {


Cheers, Andreas






--Apple-Mail=_02CC29B2-F05C-47B3-B871-E2F6BE632219
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmEUb9gACgkQcqXauRfM
H+CGABAAuRTZL34ewCQJJ8W5WJX8d15rxyw9aei+bkoCFzbNc/bJqloJMv+OW/Xh
ygz608JAAPsv2O05EspoTo9m1BViZVkSNUIb+dlL8E4lApWvE2tEyQ6YnVa74Rm+
g3+kNb6f0bNzEQ+aeC35j7+07eW+cSb2eTnTEFKmKcL/bzBOPqKNu7hZoI5VIafY
G3vzH8pGz64wR9EAfYy+QmBqN0xLJ60z5P2p/fBQwWMssWVIJAD7TLa4tkaFyip7
HyanNzCMLBn22LtjaLgXV+XkFgZ1rwBNOPLN0RqIwlmOJPf827cqT7JBY8HMd5oB
zqUWhbSAPSrZ2pBTZJDkL7u5gmH0ir/SL0lkEYE7yc368trrIvqd2/GNUfQV9V1C
baIH+FQuCbJbyR3ZkUWV7ZvXfZkRld0zdcvsHgvr3x3xfmAXrdVcPTUDwOEWI3aA
e6jklDCeUNO5Mwhe1d9p7hXrJburEDuMbRkn0fzLmQy6I9ucOduEbrepJw0a3v7w
w+Ydt0s4oVAWWxxcmvuIW5LXyyGgkdAnV4nBraF9ucwlm0VS/6Wx3ajzzh9/sUCZ
Y8/vnsgi5551130yHXiCWYKhvLbXYYyLfDoGx8HZkroWuFeGQdbuCq3le81xo1ew
CeoyW6EwiNtUTPnuAVR7Fj6rk42nnN9MIIBbw4z7TbgbgNCRSvY=
=yA5N
-----END PGP SIGNATURE-----

--Apple-Mail=_02CC29B2-F05C-47B3-B871-E2F6BE632219--
