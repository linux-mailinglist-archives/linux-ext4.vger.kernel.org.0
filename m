Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBBD65C8CC
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Jan 2023 22:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238249AbjACVRS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Jan 2023 16:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236467AbjACVRO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Jan 2023 16:17:14 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251F11581C
        for <linux-ext4@vger.kernel.org>; Tue,  3 Jan 2023 13:17:09 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id o2so28665855pjh.4
        for <linux-ext4@vger.kernel.org>; Tue, 03 Jan 2023 13:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XjkCPbJ4xICvIDkyToxx5PgYHRj4iHUCug+19P9m0eM=;
        b=v8KwFKtVPPUOv7557i7MYd7gkYPM0BWvcLjbToVbyRMnPVz3AW5s9Sy2/UioHJtB/S
         1TZMnm9f2BCKFLqRfMLDERDNuPofRncYLz0gN4QbogAaK9CkgePq/jOS/4DlSGfMs+D2
         dgds8d1wkmgBXU7Fyu3OHLazEsmTPzW+36F++MMfgMm3Zryhcx0RQOr7p7xV4yvVzZjD
         SFZzYlQkYfYlZYF6Sc8BvagQ72jCs+md0zo+3EImFvvJ8qZ3ruYAOOjVcsAA2hy1Q/OJ
         7qQ0BcK1kZ9vEB93BFeSBvyAICEiFq18QkwHRC+bYtNE6szK4xSCRywRoXhSYKkV1Q6E
         kLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XjkCPbJ4xICvIDkyToxx5PgYHRj4iHUCug+19P9m0eM=;
        b=MNfSAdJ4puPxFHKD9srmhAkS6VGOUpEA0K6dhSItdHiRnEVsedEQDjRGDtPh1/EG6+
         VahwIAbjB2fGiUktDjBiBRwrlgHtTWVjcELfaIizAD4/RJMuknLwr0JS4hppKk9MgECY
         O65ip99E+A3/5CGSNG0T8YN0poPDsYOMFvzrTSJpXaEVM2HmqRUi7q7sHP5zQjjvOP2w
         tHMaic3FowOaMY50THnQxi9/egdzLxhjPshkvNtPTFalVWHVseH3UU/v8LS5Yf0PyLBB
         GoBhDk9P6ZRpZuRfybczljkgLCKL2PrO584ySBQRB6vDRn9+2x9ovyxL1/Mqx3tv7X1v
         G6Tw==
X-Gm-Message-State: AFqh2kr071SNsnEFh/nXX+LaWL84xuq8oXdx57l3qTY+YvU6Th/Ic4Nx
        UK5XAuzAXcftVSk2nYfPBggrDMtOV6QyXg3tUv4=
X-Google-Smtp-Source: AMrXdXsCTMQCP30DL7bMZl75GoPPpR1+T38pxnPxeHFpYeFfu0e6LIkVDTIJt0+8Yz5gPtis3Q67NQ==
X-Received: by 2002:a05:6a21:3942:b0:af:e893:fa52 with SMTP id ac2-20020a056a21394200b000afe893fa52mr54884565pzc.22.1672780628399;
        Tue, 03 Jan 2023 13:17:08 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id f8-20020a655908000000b0047829d1b8eesm19470889pgu.31.2023.01.03.13.17.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jan 2023 13:17:07 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <4D64D012-A469-41FA-9ADC-35EF78BCBD55@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_ECF11A78-5228-4826-8464-6AAC063EA299";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: ext4 superblock checksum invalid after running resize2fs
Date:   Tue, 3 Jan 2023 14:17:04 -0700
In-Reply-To: <VI1PR0302MB2685C0378F00C4CC413B85E6C9F49@VI1PR0302MB2685.eurprd03.prod.outlook.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
To:     Zsolt Murzsa <thxer@thxer.hu>
References: <VI1PR0302MB2685C0378F00C4CC413B85E6C9F49@VI1PR0302MB2685.eurprd03.prod.outlook.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_ECF11A78-5228-4826-8464-6AAC063EA299
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jan 2, 2023, at 5:35 PM, Zsolt Murzsa <thxer@thxer.hu> wrote:
>=20
> Hi!
>=20
> I've had the same issue with twice in the last couple of days with the =
resize2fs online expand function.
> I have a md raid 1, with an LVM volume, which is formatted with ext4. =
I resized the volume (from 4T to 5T), then I ran resize2fs, which ran =
without error, the file system got bigger.
>=20
> After a few hours, I reset the machine (unsafely), due to some zombie =
processes, but after restarting, the system could not mount the =
filesystem.
> I checked the disks, and ran some hardware checks, but I didn't find =
anything wrong. I thought the hard reset caused some problem.
>=20
> That was the problem: "Superblock checksum does not match superblock". =
I tried several superblocks, e2fsck, testdisk, but nothing helped, =
dumpe2fs showed all the data about the superblock.
> I started to restore from a backup.
>=20
> In the meantime, I found the debugfs tool, with which I could skip the =
checksum check and thus see all the folders and files that I restored to =
a separate disk.
> I replaced the two drives, recreated md RAID 1, LVM, then reformatted =
with ext4, started copying the data back.
>=20
> I ran out of space so expanded the LV and ran resize2fs again (from 3T =
to 5T). It ran successfully again, the attached file system is 5T.
> Then I ran an e2fsck.
>=20
> "e2fsck -n /dev/vg1/data
> e2fsck 1.46.5 (30-Dec-2021)
> Warning!  /dev/vg1/data is mounted.
> ext2fs_open2: Superblock checksum does not match superblock
> e2fsck: Superblock invalid, trying backup blocks...
> e2fsck: Superblock checksum does not match superblock while trying to =
open /dev/vg1/data
>=20
> The superblock could not be read or does not describe a valid =
ext2/ext3/ext4
> filesystem.  If the device is valid and it really contains an =
ext2/ext3/ext4
> filesystem (and not swap or ufs or something else), then the =
superblock
> is corrupt, and you might try running e2fsck with an alternate =
superblock:
>    e2fsck -b 8193 <device>
> or
>    e2fsck -b 32768 <device>"

Did you try "e2fsck -fy" to fix the checksum?

> I'm shocked it happened again.
> I can currently write / read the files, but it is suspicious that I =
will not be able to mount the filesystem again.
> In the first case, I couldn't find a simple solution, but is it =
possible to fix the checksum somehow?
> It takes a lot of time to use debugfs to copy everything to another =
drive and back again.
>=20
> My current kernel version: 5.19.17-1-pve.
> I can attach all the superblocks (Both the first and second case), or =
any other information, if needed.


Cheers, Andreas






--Apple-Mail=_ECF11A78-5228-4826-8464-6AAC063EA299
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmO0m1AACgkQcqXauRfM
H+A/BhAAiGvX0jbF3ZKFmUUwnvaQaSo9mxFesxVrDZp4TyGvvzlITyD66lbNM19K
Y2fgJihqC3IAVJwYfPpqPdZWgAZLP1sPIxSReWsjh9s0Jv3bza8opxTOprDeY6WD
U8AS34J4xn+alnNthki82eM43hVKS1KeWolaHPfQnGEcm703KLwwr6dkIHOt2Y+u
eYdH/nt09CDEG+qBsXSh5/9g+cP1ah8BncKESAs64BncHbTVnyCNWH0Vlq1P96AV
71hjo4ZNJke5HyvnBLrm7gnrXnsIBr5BIh5dkXOtFUZOxsuyGPR3pHmsayy6QVsP
LgKU01ZYn12Qf8rCL/rXMVyIGmwaOu/e1ycSpdLzDuFfiNPl+KhF4Kx390iF/7qH
SjqG7OV42hF5WioPht2v3jLuvPUP7mdaflPpRgHqDyo9O9E32/OYb/VxsAieI+oG
p4rn8Ouo55/wVcUdiGYsJm5/rWVVnxGgVFUOQ3j+OxCvY7uxi/2DopR/NeLpVR+T
JPulfp28Zu0UuKQlVZ9Nvg7I0O89wkN4wYB1u18CIEIU2G9uEJ95mymATPyOHvLi
VW16AMvPR/bcGq2slHh8SnnhPm/vFkQaqArtnS7DOGn2cKLTIBd8aYWwvdf7O5MN
FThJOIvkgWh+06//Ow5zOLyrYovigZus0zFr32IEyp+pP64QQNE=
=OS+H
-----END PGP SIGNATURE-----

--Apple-Mail=_ECF11A78-5228-4826-8464-6AAC063EA299--
