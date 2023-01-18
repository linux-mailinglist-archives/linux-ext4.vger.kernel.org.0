Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CBF672B53
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Jan 2023 23:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjARWbE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Jan 2023 17:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjARWak (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Jan 2023 17:30:40 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B0F47EFC
        for <linux-ext4@vger.kernel.org>; Wed, 18 Jan 2023 14:30:38 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id gz9-20020a17090b0ec900b002290bda1b07so2716388pjb.1
        for <linux-ext4@vger.kernel.org>; Wed, 18 Jan 2023 14:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7OY4SVyDHbPXPmELzxGWZvLWHcBKrssPf/Mtp+I4izc=;
        b=6TLQCxQL6I/G77EHa4/Odz0PEQvq/bL5gLmZmYqyyMOxgGUDwuKGE7cyUEpDhr/siB
         Wc7jTtAw/VTSP73Q52D/umduuOAVWY/SCUxNSf2CHZ3GtU68Eq70LIxk8gyvEar74/9o
         y8QgVk4p5s2yghS125BbbSWvyY70Z9sZa/P18J5AnUKeGG7IDo13d1zh31niZCbPL338
         UkhNPe4eqSgg2QJZtMrz8Pi6r4CK9UqLmNB6wDImWq7xoZjj+Dxt8PH0vI5xr+sJ7wn1
         wHTu1WPjcpvs4HEOaB4a+rkIoM+9I1mfNLTdibsWmxJmkCn2flWtEkz4hokBr0Qj9C4H
         ZwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7OY4SVyDHbPXPmELzxGWZvLWHcBKrssPf/Mtp+I4izc=;
        b=5QLtLIfPWt6+lJ5rGRPvuFnmMuCYJ/wyFISN8rA+xw0qnlwUoJAV/GbUjsYji/l0/g
         baooWWlZpwUmveXHcd/mwdVVwy3rlq/YgnBQ/Ch7WyxQcVjllKylNjAsF7ij0Ni2INhL
         I52yM7/P8fnFo9WU+OcUUKMT4LM1ZNhSgvUHcPuCwgk7+5iBH9SH81X+JEc6OZJXb/no
         ih49AUXpjcJ6YCKaFRh22NvICDpaHoq0o1G8pMnxkhPwDZt1WmeTulFmZXSlEB5iYcIn
         ov9c12ySyldbFy9TOjpY/6nDApXU7aOETJvWYUCGChZ+kk4ZzUfzYepYGVZMAe8oCaC5
         crFg==
X-Gm-Message-State: AFqh2krLzcu7N64yHLfsis5RtaxC1zMsXdfWqnfXzl6HyKWMqJyRLPHK
        Sy9KE4b6lJU0wygn9WkRzFq9PA==
X-Google-Smtp-Source: AMrXdXvCsQCFN2iRIdni450XmoRojnm7DiO6pBWBDqyypQ0q7Ry5jZswSVJhLEUtimeq+OlH8MT17Q==
X-Received: by 2002:a17:90b:1048:b0:226:cefc:2709 with SMTP id gq8-20020a17090b104800b00226cefc2709mr9240518pjb.9.1674081038074;
        Wed, 18 Jan 2023 14:30:38 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id x9-20020a17090a294900b00225bc0e5f19sm1860243pjf.1.2023.01.18.14.30.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jan 2023 14:30:37 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <BCB61FA2-9D1E-4E2D-8515-78AB6105785D@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_5EF56060-5C97-454D-A573-026513A705FF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] resize2fs: resize2fs disk hardlinks will be error
Date:   Wed, 18 Jan 2023 15:30:34 -0700
In-Reply-To: <Y8d+B4RHTkqYpG4g@mit.edu>
Cc:     zhanchengbin <zhanchengbin1@huawei.com>,
        linux-ext4@vger.kernel.org, liuzhiqiang26@huawei.com
To:     Theodore Ts'o <tytso@mit.edu>
References: <9dcadf7a-b12a-c977-2de2-222e20f0cebe@huawei.com>
 <Y8d+B4RHTkqYpG4g@mit.edu>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_5EF56060-5C97-454D-A573-026513A705FF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jan 17, 2023, at 10:05 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> On Tue, Jan 04, 2022 at 10:23:52PM +0800, zhanchengbin wrote:
>> Resize2fs disk hardlinks which mounting after the same name as tmpfs
>>  filesystem it will be error. The items in /proc/mounts are =
traversed,
>> when you get to tmpfs,file!=3Dmnt->mnt_fsname, therefore, the
>> stat(mnt->mnt_fsname, &st_buf) branch is used, however, the values of
>>  file_rdev and st_buf.st_rdev are the same. As a result, the system
>> mistakenly considers that disk is mounted to /root/tmp. As a result
>> , resize2fs fails.

Rather than doing ever more complex processing of /proc/mounts, it
would make more sense to have resize2fs take the *mountpoint* of
the filesystem to be resized, and then run the ioctl directly on
the given path.  That avoids the need to process /proc/mounts at
all, and unambiguously specifies which filesystem should be resized.

For compatibility, resize2fs would need to accept either the device
or mountpoint (really any directory in the filesystem would work),
and it could check either the mnt_fsname or mnt_dir matches.

Cheers, Andreas

> Apologies for the delay in getting to this patch.  The original
> patch[1] was corrupted (looks like you used Mozilla Thunderbird as
> your Mail User Agent, which line-wrapped the patch and thus confused
> patchwork[2] as well making it impossible for b4 and git am to handle
> the patch).
>=20
> [1] =
https://lore.kernel.org/all/9dcadf7a-b12a-c977-2de2-222e20f0cebe@huawei.co=
m/
> [2] =
http://patchwork.ozlabs.org/project/linux-ext4/patch/9dcadf7a-b12a-c977-2d=
e2-222e20f0cebe@huawei.com/
>=20
> I also rewrite the commit description to make it more clear:
>=20
>    libext2fs: add extra checks to ext2fs_check_mount_point()
>=20
>    A pseudo-filesystem, such as tmpfs, can have anything at all in its
>    mnt_fsname entry.  Normally, it is just "tmpfs", like this:
>=20
>    tmpfs /tmp tmpfs rw,relatime,inode64 0 0
>    ^^^^^
>=20
>    but in a pathological or malicious case, a system administrator can
>    specify a block device as its mnt_fsname which is the same as some
>    other block device.  For example:
>=20
>    /dev/loop0 /tmp/test-tmpfs tmpfs rw,relatime,inode64 0 0
>    ^^^^^^^^^^
>    /dev/loop0 /tmp/test-mnt ext4 rw,relatime 0 0
>=20
>    In this case, ext2fs_check_mount_point() may erroneously return
>    that the mountpoint for the file system on /dev/loop0 is mounted on
>    /tmp/test-tmpfs, instead of the correct /tmp/test-mnt.  This causes
>    problems for resize2fs, since in order to do an online resize, it
>    needs to open the directory where the file system is mounted, and
>    trigger the online resize ioctl.  If it opens the incorrect =
directory,
>    then resize2fs will fail.
>=20
>    So we need to add some additional checking to make sure that
>    directory's st_dev matches the block device's st_rdev field.
>=20
>    An example shell script which reproduces the problem fixed by this
>    commit is as follows:
>=20
>       loop_file=3D/tmp/foo.img
>       tmpfs_dir=3D/tmp/test-tmpfs
>       mnt_dir=3D/tmp/test-mnt
>=20
>       mkdir -p $tmpfs_dir $mnt_dir
>       dd if=3D/dev/zero of=3D$loop_file bs=3D1k count=3D65536
>       test_dev=3D$(losetup --show -f $loop_file)
>       mke2fs -t ext4 -F -b 1024 $test_dev 32768
>       mount -t tmpfs $test_dev $tmpfs_dir  # create the evil =
/proc/mounts entry
>       mount -t ext4 $test_dev $mnt_dir
>       ln -f ${test_dev} ${test_dev}-ln
>       resize2fs ${test_dev}-ln
>=20
>    [ Fixed up the corrupted patch and rewrote the commit description =
to
>      be more clear -- tytso ]
>=20
>    Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
>    Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>    Signed-off-by: Theodore Ts'o <tytso@mit.edu>
>=20
> As you can see, the best commit description describes *why* a
> particular change is needed, and gives the background so the reader
> can understand what problem is being fixed.  The one-line change makes
> it clear that the change is to libext2fs's ismounted.c, and *not* to
> resize2fs, although you were making this bug to fix resize2fs after a
> system administrator did something non-standard and/or malicious.
>=20
> Also note how I rewrote the reproducer to be simpler and more
> portable.
>=20
> Cheers,
>=20
> 						- Ted


Cheers, Andreas






--Apple-Mail=_5EF56060-5C97-454D-A573-026513A705FF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmPIcwoACgkQcqXauRfM
H+Asdw//RbPYH6QIs14OTsLpZ/g+rxfdG/KZ9mve31Rw4iMDoKm3N6vVsW7c/kYN
0ICD1QVPo7jyvurJKszXcCGGNzIq3RjQSrGRCCZGvmdfoU7nsJPHFWfsbjs+duaQ
ojHRVhsvSx7avwdZrMGo/IEAD3xkJbXke0Vf8gU4m4X7q5ieFF7xlWvR6ebslMXS
leBavFXCjyOT4+LV81cctzTguSNpgn8miLgPQhND8z/awdPo4SNa61ivtp6pmOxf
z/RY+kkbVLxHNjcepjvamHTuXBgWXxoj0ae6reaH2KpyK9tDXSEYUM1igX22lDtM
c/q2tRdifE2V5h8LT175U4bJVAV80uZTMODRwYVA2tJtcTL0uw0fyHnzpfp2yDp4
SSSuKHZAGrR0ffKBQDL3CJwgQlg38MkRjUaL3FqDkQH+JfPmfFbuLO0a/opwgGUm
21MtoV2PZEUHIhVXDceBJCbkCYiX++U3uZFMzHjy6xCLGOrheyXt2L2haq1OZCr+
IC5slxpgy/GAwXzcoXU8xdRR/5JDBxR5vXWXgxOaTN2K+WWvad8NjplA+Be4x3vz
DIaxaQIguCed3TyYiq+OafA801dJ6ISHSWx06Ldky6EWKma6/nne6isqKjSKdOJt
kNP+jiHW5XEJ+sGFVcVazNiXcKwkrrmWpi58HMFv77kQC/sTeNE=
=gN2w
-----END PGP SIGNATURE-----

--Apple-Mail=_5EF56060-5C97-454D-A573-026513A705FF--
