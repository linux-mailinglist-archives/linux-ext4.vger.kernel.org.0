Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01195320588
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Feb 2021 14:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbhBTNWD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 20 Feb 2021 08:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhBTNWA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 20 Feb 2021 08:22:00 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7494FC061574
        for <linux-ext4@vger.kernel.org>; Sat, 20 Feb 2021 05:21:19 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id u4so40632867ljh.6
        for <linux-ext4@vger.kernel.org>; Sat, 20 Feb 2021 05:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0YhK/5vHhM+YDupyq9I2/pYuB6hRgnnkJJOw50XLkhs=;
        b=ZEqybACxRArao4tAzHS7R31do9z1L6ZojVyuul48v0ZlGY8hnq6OO/Dka4YFakEJ5E
         isJthGBYlDudtCIcdXCVKt3HKkPuBn4B7SSM4l16p6A5UN20p20//pQC06rqLrP6X0/j
         wIrSInD9EoBqgnFsDoP9SPhfKDihVkMPxMZ1vza6yZmv/s3t8Qh3WJ51NairY84+uYeK
         GmYngQ4RfYHjvOoFwi0aLYqV75dePqvy7D1VnPi+fll8+Cv9ChMhtLW5dGDqqgp2ud8b
         YrHSMNuunV2slx4FdjBQXreK39pQO6IEzVEuBf8IoiFOx4/w6feveKn3QrxCz8oH0+OL
         Gx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0YhK/5vHhM+YDupyq9I2/pYuB6hRgnnkJJOw50XLkhs=;
        b=IXc8nKtICgt57Oypn3WZjhywJnwZiVob3GIu5FcTb75lPd50wqH1bLYyTSaoMLV2J6
         p3GaJLHVjrk7J4P9vfDKaEZJUftRcRnCkpEpF/dtbWBUSKuJ58QCCIWqBeXGAf5q/P4i
         seari7oWdxa5kMejYBmSVgTfe4yd8dRryigtsDGU0/VMVixKDmm6mZw25cAx7DUt5bBw
         F99nh3JSZAjAxbjyTeBKZ9rl8FU30CrV58fwS840RyGzVA72S2Oj/+4pCU8Ot4mIgziW
         Kd0hZSiQ4aVa6/KsSgmveLO4S9+P5pVZ8f+hP2SaZYOKMZVUg+0hH9IrJKOI1OJTK9rr
         F8cw==
X-Gm-Message-State: AOAM53334IZ0ui1pubvHsjZ/W+4Jc6yTW98fGH46gufHVEfudqMcbgCJ
        pIiMnCHTEOEaQG2qioDS1tw=
X-Google-Smtp-Source: ABdhPJx3aXDLU09mRe/kLciXdSFRjCSzHQyppCVEvkmZzfF0xz+vd/LO1BFT62Ia+Meh73fom5m5QQ==
X-Received: by 2002:a19:4105:: with SMTP id o5mr8908684lfa.456.1613827277954;
        Sat, 20 Feb 2021 05:21:17 -0800 (PST)
Received: from [192.168.1.5] ([5.8.48.45])
        by smtp.gmail.com with ESMTPSA id z14sm1247062lfh.296.2021.02.20.05.21.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Feb 2021 05:21:17 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH v2] mmp: do not use O_DIRECT when working with regular
 file
From:   Alexey Lyashkov <alexey.lyashkov@gmail.com>
In-Reply-To: <YC/k7YhZNxO7O5PF@mit.edu>
Date:   Sat, 20 Feb 2021 16:21:13 +0300
Cc:     Lukas Czerner <lczerner@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Eric Sandeen <sandeen@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FEFE06F0-36C5-4E5B-AD65-3709DEB8E5F2@gmail.com>
References: <20210212093719.162065-1-lczerner@redhat.com>
 <20210218095146.265302-1-lczerner@redhat.com>
 <BF8274AF-A9C6-40F4-8B99-FEBA82878C36@dilger.ca>
 <99A17D19-8764-4027-8B1E-E7ADBE5E2CEE@gmail.com>
 <20210219105713.uu2mywenytfd2e5j@work>
 <E16FB371-5DFC-4A10-A9E2-36541FCF7D30@gmail.com>
 <20210219133459.vezgrlkjpmaizvb4@work>
 <BB31D81D-F4A9-490E-8F9D-2BC6350CE6B0@gmail.com> <YC/k7YhZNxO7O5PF@mit.edu>
To:     Theodore Ts'o <tytso@mit.edu>
X-Mailer: Apple Mail (2.3445.9.7)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Teodore,

this important because of some points.
metadata for the large devices (>400T without bigalloc enabled) very =
large.=20
Once buffered IO enabled this generate a very large memory consumption.
(12G+ for metadata itself in page cache, and 12G+ for user memory).
I don=E2=80=99t think half of them is useful.



> 19 =D1=84=D0=B5=D0=B2=D1=80. 2021 =D0=B3., =D0=B2 19:18, Theodore Ts'o =
<tytso@mit.edu> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0):
>=20
> Alexey,
>=20
> It'd be helpful to me to understand _why_ this use case is important
> for your workloads.  O_DIRECT support is rarely used as far as I know,
> and fs blocksize !=3D page size is rare as well.  The main use cases I
> know of fs blocksize !=3D page size is on architectures (not terribly
> common) with 16k or 64k page sizes, that want to use 4k file system
> blocksizes for interoperability reasons.
>=20
As i point early - e2fsprogs _FORCE_ a 1k block size in some places.
Like
blk64_t ext2fs_first_backup_sb(blk64_t *superblock, unsigned int =
*block_size,
..
        for (try_blocksize =3D EXT2_MIN_BLOCK_SIZE;
             try_blocksize <=3D EXT2_MAX_BLOCK_SIZE ; try_blocksize *=3D =
2) {
..
errcode_t ext2fs_open2(const char *name, const char *io_options,
                io_channel_set_blksize(fs->io, SUPERBLOCK_OFFSET);


both cases will generate unliagned (from block device view) access.
Without any idea which a block size is in real.

> (And I suppose because mke2fs uses a 4k block size by default.  =
Perhaps
> we should change this so that the default is that mke2fs will use a
> block size =3D=3D page size, unless for some reason the page size is =
not
> one supported by ext4 (although I'm not aware of any architecture
> wanting page sizes > 64k), or the user explicitly specifies the block
> size using "mke2fs -b=C2=BB.)
Nice. AARCH64 / RHEL8 - is 64k page, so what about interoperability?
Should AARCH64 able to read devices which created on x86_64 with 4k page =
size?

>=20
> Are you trying to make O_DIRECT support in e2fsprogs a first class
> reason out of completeness concern?  Or is this a use case which is
> important in production workloads that you are familiar with?
>=20
primary goal - debugfs -D / e2image - both in production on large =
storages.
I looking to the e2fsck because of large memory consumption.

If you think O_DIRECT don=E2=80=99t need to be supported - lets drop =
this code, instead of have this completely broken now.


Thanks,=20
Alex.

> Thanks,
>=20
> 						- Ted

