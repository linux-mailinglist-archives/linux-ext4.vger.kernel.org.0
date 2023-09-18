Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7037A54EE
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Sep 2023 23:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjIRVUP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Sep 2023 17:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjIRVUP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Sep 2023 17:20:15 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6796D111
        for <linux-ext4@vger.kernel.org>; Mon, 18 Sep 2023 14:20:05 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c46b30a1ceso17434255ad.3
        for <linux-ext4@vger.kernel.org>; Mon, 18 Sep 2023 14:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1695072005; x=1695676805; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CuuvT7tNCCFuMLpJPyHV19VEFRoGJMK+hT2OY7Q+Wo8=;
        b=cDjebU6l+or6mHcA2RVvPEks8PBI6PUGgCpPLI0dfw5A2kFTKzutahV3b06ncRR1c3
         rAr5KQtzdhEIEYkpe7biCjNDUgphCMyPP7eLneviAkdA+xGxTUATbpu1gb0hh2jdW827
         Zv+H3iy1BWlrS099b+5vdhemm1PhWXWD/kDRy9jCB80bGj0EKhCTop8uqvaWk5LKhF8K
         og/Un+py61KFPpHtzAb/hkUGEhpdeJQujd0SjpRPRO3AwBldNnC1qR/skoFobmkc5p9z
         BBtPI8/a7MbS2QpJwTh5MravMhoMZjp14nIXWD1BY0+DGDIehHaZ3xZf9qdxJ1ONHvD1
         hUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695072005; x=1695676805;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CuuvT7tNCCFuMLpJPyHV19VEFRoGJMK+hT2OY7Q+Wo8=;
        b=SogxvJDwMzSgPJm3B4m87kvOcELugXPn6TKVZ+ZzUBv2ln+mf9b5XvlaOzzxeaYYTy
         gVKfncHAmggWYNlDaeUbpyaIcovIdUh7V+W81CeuQ2dNSB5l2tnEWuivDNEPtQCJECoa
         jy2gGdKmPK/7GKVYmWeL1Kdaq6I59d/GadWfsMv4YjedE2fyd7AeITVVhPqQqkaS6MDm
         2bsWCJM0hLqZU5rlGdZl2JT1gtSFZmXdr74k3e8y+wqmK0B8WTZSrS8463biMN5fXQTT
         05TP01p6TbAwy8mWnVUUdClkhSz4SzdfaS1wEGmKGM+iF7Rgxv41Zp8quJ4UEsHNqLdQ
         3G2Q==
X-Gm-Message-State: AOJu0Yz3WuGcmWUtFMw2Ha0VAWzav09RAfQdFZ1rh1fj06hIzkH+jp/9
        wI954Pu/+Ied2ZBglOv/l9GmIw==
X-Google-Smtp-Source: AGHT+IGFTCDbsh/RDAcudfQdY6HTdHJh2vp7ydjnii64aF/XH/awdR66Uf7knZryNjcIQ7xq8tJHow==
X-Received: by 2002:a17:902:ea08:b0:1c3:73aa:618b with SMTP id s8-20020a170902ea0800b001c373aa618bmr13584800plg.9.1695072004757;
        Mon, 18 Sep 2023 14:20:04 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902968700b001bc675068e2sm8690484plp.111.2023.09.18.14.20.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Sep 2023 14:20:03 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <729CDEF6-F6B3-4290-8120-F73C990B0D9F@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_68A3AE40-B6AB-437C-A9F0-620A7F257F44";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [e2fsprogs PATCH v2] resize2fs: use directio when reading
 superblock
Date:   Mon, 18 Sep 2023 15:20:01 -0600
In-Reply-To: <20230911183905.GA1960@templeofstupid.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org
To:     Krister Johansen <kjlx@templeofstupid.com>
References: <20230911183905.GA1960@templeofstupid.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_68A3AE40-B6AB-437C-A9F0-620A7F257F44
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Sep 11, 2023, at 12:39 PM, Krister Johansen <kjlx@templeofstupid.com> =
wrote:
>=20
> Invocations of resize2fs intermittently report failure due to =
superblock
> checksum mismatches in this author's environment.  This might happen a =
few
> times a week.  The following script can make this happen within =
minutes.
> (It assumes /dev/nvme1n1 is available and not in use by anything =
else).

Krister,
thanks for submitting the patch.  This particular issue was already =
fixed
in commit v1.46.6-16-g43a498e93888, apparently based on your previous =
report:

    commit 43a498e938887956f393b5e45ea6ac79cc5f4b84
    Author:     Theodore Ts'o <tytso@mit.edu>
    AuthorDate: Thu Jun 15 00:17:01 2023 -0400
    Commit:     Theodore Ts'o <tytso@mit.edu>
    CommitDate: Thu Jun 15 00:17:01 2023 -0400

    resize2fs: use Direct I/O when reading the superblock for online =
resizes

    If the file system is mounted, the superblock can be changing while
    resize2fs is trying to read the superblock, resulting in checksum
    failures.  One way of avoiding this problem is read the superblock
    using Direct I/O, since the kernel makes sure that what gets written
    to disk is self-consistent.

    Suggested-by: Krister Johansen <kjlx@templeofstupid.com>
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

So it is landed on the e2fsprogs maint branch, but there has not been a
maintenance release since the patch was landed.

Cheers, Andreas

>   #!/usr/bin/bash
>   set -euxo pipefail
>=20
>   while true
>   do
>           parted /dev/nvme1n1 mklabel gpt mkpart primary 2048s =
2099200s
>           sleep .5
>           mkfs.ext4 /dev/nvme1n1p1
>           mount -t ext4 /dev/nvme1n1p1 /mnt
>           stress-ng --temp-path /mnt -D 4 &
>           STRESS_PID=3D$!
>           sleep 1
>           growpart /dev/nvme1n1 1
>           resize2fs /dev/nvme1n1p1
>           kill $STRESS_PID
>           wait $STRESS_PID
>           umount /mnt
>           wipefs -a /dev/nvme1n1p1
>           wipefs -a /dev/nvme1n1
>   done
>=20
> After trying a few possible solutions, adding an O_DIRECT read to the =
open
> path in resize2fs eliminated the occurrences on test systems. =
ext2fs_open2
> uses a negative count value when calling io_channel_read_blk to get =
the
> superblock.  According to unix_read_block, negative offsets are to be =
read
> direct.  However, when strace-ing a program without this fix, the
> underlying device was opened without O_DIRECT.  Adding the flags in =
the
> patch ensures the device is opend with O_DIRECT and that the =
superblock
> read appears consistent.
>=20
> Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> ---
> v2:
>  - Only set DIRECT_IO flag when resizing a mounted filesystem. =
(Feedback from
>    Theodore Ts'o)
> ---
> resize/main.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/resize/main.c b/resize/main.c
> index 94f5ec6d..f914c050 100644
> --- a/resize/main.c
> +++ b/resize/main.c
> @@ -409,6 +409,8 @@ int main (int argc, char ** argv)
>=20
> 	if (!(mount_flags & EXT2_MF_MOUNTED) && !print_min_size)
> 		io_flags =3D EXT2_FLAG_RW | EXT2_FLAG_EXCLUSIVE;
> +	if (mount_flags & EXT2_MF_MOUNTED)
> +		io_flags |=3D EXT2_FLAG_DIRECT_IO;
>=20
> 	io_flags |=3D EXT2_FLAG_64BITS | EXT2_FLAG_THREADS;
> 	if (undo_file) {
> --
> 2.25.1


Cheers, Andreas






--Apple-Mail=_68A3AE40-B6AB-437C-A9F0-620A7F257F44
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmUIvwIACgkQcqXauRfM
H+AyCA/9Ev51deHY2Q+FZOIBr5M5nliWYUcFWx1ecaVB/tii/b77nbVoHhdIV8rW
xZ1LsguYZnh+Sb8hngmpNyu2iXLzC6zy/y2OXStea7rtozXwq3rbrZZ5sSaJ++fF
RCDrNj7RxveNdRcJdx8A504ag88ZfoHFCU7tJojIgLrCOJc5/IXNIq/rx/5kpVlO
dUTywkDU/DWsFUl/N09Gj/6MCo3q5BzHwzEa6GzesO8jKWjdzNx/9nUAFOqaptjA
GwRKgeXw5m2WbzjGscG0oRttUzSdBB9D9L1ls7f7ZuySC9tyIvMGMj9uK6SJqpS4
wxBJC83Gs90J6rOAILuFoySkIYPUq7TSNZEwRttnGFzwi+CDX7/t/QbRnKBxprMC
gWCvVOjHBRJnio/aZF/sFA4q7RIvNICnJ56TeFzt0Wd/oMUylZyZWRA2clIxXPms
WCHdb7X+d7ed3+aS69rNR6CTNReUuzuxFdOy5q4oqwpX7wUbwv0z8fMEAnADGucG
rk/bhhKa6BOhqPpurjHT9vCP7SzHJggLGb7HLH2546JsyHonEoKVYJKWZPvOlisb
ymcPOVn69ccWK9XdTjXJBJLmTrWrCBA6X1xMjeXGWSzD0kXetJGDuI8k1P6SaFtH
api1O2X2mSG4lw3Xl//UrXvB7/trQ29WnnYxFrME/1KjGnmWfbs=
=J6F4
-----END PGP SIGNATURE-----

--Apple-Mail=_68A3AE40-B6AB-437C-A9F0-620A7F257F44--
