Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8681A7666
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Apr 2020 10:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436922AbgDNIr5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Apr 2020 04:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729391AbgDNIr4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 14 Apr 2020 04:47:56 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F453C0A3BDC
        for <linux-ext4@vger.kernel.org>; Tue, 14 Apr 2020 01:47:56 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id k15so5768602pfh.6
        for <linux-ext4@vger.kernel.org>; Tue, 14 Apr 2020 01:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=VuOx3h+povgTeH4hzjcBa3pdXLjO06jDS+uO2zecAT8=;
        b=NXE556r5hrcVvQfPje3Zuw+QEqjnTuJJKjNh2c4V83lLP+g4vBe4Y4GdGsaFHdoYl5
         9LOEFuv4OTn09BJH/qxGEFrPQl1rYOKX5sxs3iIZcJ2Xa5spmd+9EJ4DB5Ke+LqOVXwr
         2Wp1vhSlOhjCP0xMnbWnsP2uK73s0NkddIirZZAHQ1Y6hkQLsBsSYYqLJvLBRC4kHB87
         W8IMUmjzxVGDk9TygM+WuVQUV6t5OR9nByMsvixnypiep9AFKqoLJKskndk323zU7Q9e
         XSsmQAZZYtfIgp7v25PkNwRkllVXHW82vMlLgnWrJldojXR3kTVk7SoATQSBzOczdDCw
         sBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=VuOx3h+povgTeH4hzjcBa3pdXLjO06jDS+uO2zecAT8=;
        b=HUQDSc2X/RGqKEHIdJ8ZMk3mCgdOjtvwsP3WkbmWOLazJ0nVRJ63GPQkYGSFiqf0oE
         h86Knp+0dkEYesgBQTiiesTLtbGxgcPrDLPQf3OKp9BH9Y2ofjcl3gHVdXM1PXWhaioX
         KBNjg9xPCL0VGZDKCvGmMvXus2XTQN/OS+rqh38eb3JiRZmpkn5JR3+IWsObwpv15PQX
         inZjWNRDJrOMgXkndasCCoAIFh09BgKoLuHA2TkpDHAlsvEu8KTGgm/XRd8LFubtMYp7
         SgllSp6djHEfBqNMTco4jkNBmhWLRqXlhqx/JpYEO9fn6mEDt00+9CJStj9vClTKc2vY
         GRXQ==
X-Gm-Message-State: AGi0Pub/eZwuSWtWPdEuwym/SkPwR//IRkxvJhX5jlK66uCQ1sNvXrND
        SIEPuuz2jh5hnNi4ooj6aZdstA==
X-Google-Smtp-Source: APiQypJJRoSVE10HFP9gw+nX+qdvBoADA2l5Xh+yAiOYgXqjc24YDxdELHZnSHb8d9IeGfhfR6MQBg==
X-Received: by 2002:aa7:818b:: with SMTP id g11mr660148pfi.85.1586854075498;
        Tue, 14 Apr 2020 01:47:55 -0700 (PDT)
Received: from [192.168.10.175] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id q200sm9816389pgq.68.2020.04.14.01.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 01:47:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] e2image: add option to ignore fs errors
Date:   Tue, 14 Apr 2020 02:47:52 -0600
Message-Id: <40B2CF84-E1EC-46FB-B788-F957638C8ED8@dilger.ca>
References: <20200414072602.53290-1-artem.blagodarenko@hpe.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        Alexey Lyashkov <alexey.lyashkov@hpe.com>
In-Reply-To: <20200414072602.53290-1-artem.blagodarenko@hpe.com>
To:     Artem Blagodarenko <artem.blagodarenko@gmail.com>
X-Mailer: iPhone Mail (17E255)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

My suggestion would be to use a different option for this. The "-i"
option is used for "inode ratio" for mke2fs, and also used by debugfs
to read e2image file as input.

Is it not OK to use "-f" for this also? That is normally the "force" option.=

Alternately, does it make sense to start using "-E ignore_error" or
similar extended option, so that there can be better fine-grained error
handling added in the future?

Cheers, Andreas

> On Apr 14, 2020, at 01:26, Artem Blagodarenko <artem.blagodarenko@gmail.co=
m> wrote:
>=20
> =EF=BB=BFFrom: Alexey Lyashkov <alexey.lyashkov@hpe.com>
>=20
> While running into RAID corruption issues e2image fails.
> The problem is that having an e2image in this instance is really
> helpful, no matter if there is an error so having the ability
> to skip these errors messages to create an e2image seem warranted.
>=20
> Add "-i" option to be more tolerant to fs errors while scanning inode
> extents.
>=20
> Signed-off-by: Alexey Lyashkov <alexey.lyashkov@hpe.com>
> Signed-off-by: Artem Blagodarenko <artem.blagodarenko@hpe.com>
> hpe-bug-id: LUS-1922
> Change-Id: Ib79300656726839b1d3b7ee1dd0793c60679d296
> ---
> misc/e2image.8.in                |  3 +++
> misc/e2image.c                   | 12 +++++++++---
> tests/i_error_tolerance/expect.1 | 23 +++++++++++++++++++++++
> tests/i_error_tolerance/expect.2 |  7 +++++++
> tests/i_error_tolerance/script   | 38 ++++++++++++++++++++++++++++++++++++=
++
> 5 files changed, 80 insertions(+), 3 deletions(-)
> create mode 100644 tests/i_error_tolerance/expect.1
> create mode 100644 tests/i_error_tolerance/expect.2
> create mode 100644 tests/i_error_tolerance/script
>=20
> diff --git a/misc/e2image.8.in b/misc/e2image.8.in
> index ef12486..0ac41d4 100644
> --- a/misc/e2image.8.in
> +++ b/misc/e2image.8.in
> @@ -73,6 +73,9 @@ for the image file to be in a consistent state.  This re=
quirement can be
> overridden using the
> .B \-f
> option, but the resulting image file is very likely not going to be useful=
.
> +If you going to grab an image from a corrupted FS
> +.B \-i
> +option to ignore fs errors, allows to grab fs image from a corrupted fs.
> .PP
> If
> .I image-file
> diff --git a/misc/e2image.c b/misc/e2image.c
> index 56183ad..13cc517 100644
> --- a/misc/e2image.c
> +++ b/misc/e2image.c
> @@ -78,6 +78,7 @@ static char move_mode;
> static char show_progress;
> static char *check_buf;
> static int skipped_blocks;
> +static int fs_error_tolerant =3D 0;
>=20
> static blk64_t align_offset(blk64_t offset, unsigned int n)
> {
> @@ -1368,7 +1369,8 @@ static void write_raw_image_file(ext2_filsys fs, int=
 fd, int type, int flags,
>                com_err(program_name, retval,
>                    _("while iterating over inode %u"),
>                    ino);
> -                exit(1);
> +                if (fs_error_tolerant =3D=3D 0)
> +                    exit(1);
>            }
>        } else {
>            if ((inode.i_flags & EXT4_EXTENTS_FL) ||
> @@ -1381,7 +1383,8 @@ static void write_raw_image_file(ext2_filsys fs, int=
 fd, int type, int flags,
>                if (retval) {
>                    com_err(program_name, retval,
>                    _("while iterating over inode %u"), ino);
> -                    exit(1);
> +                    if (fs_error_tolerant =3D=3D 0)
> +                        exit(1);
>                }
>            }
>        }
> @@ -1507,7 +1510,7 @@ int main (int argc, char ** argv)
>    if (argc && *argv)
>        program_name =3D *argv;
>    add_error_table(&et_ext2_error_table);
> -    while ((c =3D getopt(argc, argv, "b:B:nrsIQafo:O:pc")) !=3D EOF)
> +    while ((c =3D getopt(argc, argv, "b:B:nrsIQafo:O:pci")) !=3D EOF)
>        switch (c) {
>        case 'b':
>            superblock =3D strtoull(optarg, NULL, 0);
> @@ -1552,6 +1555,9 @@ int main (int argc, char ** argv)
>        case 'c':
>            check =3D 1;
>            break;
> +        case 'i':
> +            fs_error_tolerant =3D 1;
> +            break;
>        default:
>            usage();
>        }
> diff --git a/tests/i_error_tolerance/expect.1 b/tests/i_error_tolerance/ex=
pect.1
> new file mode 100644
> index 0000000..8d5ffa2
> --- /dev/null
> +++ b/tests/i_error_tolerance/expect.1
> @@ -0,0 +1,23 @@
> +Pass 1: Checking inodes, blocks, and sizes
> +Inode 12 has illegal block(s).  Clear? yes
> +
> +Illegal indirect block (1000000) in inode 12.  CLEARED.
> +Inode 12, i_blocks is 34, should be 24.  Fix? yes
> +
> +Pass 2: Checking directory structure
> +Pass 3: Checking directory connectivity
> +Pass 4: Checking reference counts
> +Pass 5: Checking group summary information
> +Block bitmap differences:  -(31--34) -37
> +Fix? yes
> +
> +Free blocks count wrong for group #0 (62, counted=3D67).
> +Fix? yes
> +
> +Free blocks count wrong (62, counted=3D67).
> +Fix? yes
> +
> +
> +test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
> +test_filesys: 12/16 files (8.3% non-contiguous), 33/100 blocks
> +Exit status is 1
> diff --git a/tests/i_error_tolerance/expect.2 b/tests/i_error_tolerance/ex=
pect.2
> new file mode 100644
> index 0000000..7fd4231
> --- /dev/null
> +++ b/tests/i_error_tolerance/expect.2
> @@ -0,0 +1,7 @@
> +Pass 1: Checking inodes, blocks, and sizes
> +Pass 2: Checking directory structure
> +Pass 3: Checking directory connectivity
> +Pass 4: Checking reference counts
> +Pass 5: Checking group summary information
> +test_filesys: 12/16 files (8.3% non-contiguous), 33/100 blocks
> +Exit status is 0
> diff --git a/tests/i_error_tolerance/script b/tests/i_error_tolerance/scri=
pt
> new file mode 100644
> index 0000000..aeb4581
> --- /dev/null
> +++ b/tests/i_error_tolerance/script
> @@ -0,0 +1,38 @@
> +if test -x $E2IMAGE_EXE; then
> +if test -x $DEBUGFS_EXE; then
> +
> +SKIP_GUNZIP=3D"true"
> +
> +TEST_DATA=3D"$test_name.tmp"
> +dd if=3D/dev/urandom of=3D$TEST_DATA bs=3D1k count=3D16 > /dev/null 2>&1=20=

> +
> +dd if=3D/dev/zero of=3D$TMPFILE bs=3D1k count=3D100 > /dev/null 2>&1
> +$MKE2FS -Ft ext4 -O ^extents $TMPFILE > /dev/null 2>&1
> +$DEBUGFS -w $TMPFILE << EOF  > /dev/null 2>&1
> +write $TEST_DATA testfile
> +set_inode_field testfile block[IND] 1000000
> +q
> +EOF
> +
> +$E2IMAGE -r $TMPFILE $TMPFILE.back
> +
> +ls -l $TMPFILE.back
> +
> +$E2IMAGE -i -r $TMPFILE $TMPFILE.back
> +
> +ls -l $TMPFILE.back
> +
> +mv $TMPFILE.back $TMPFILE
> +
> +. $cmd_dir/run_e2fsck
> +
> +rm -f $TEST_DATA
> +
> +unset E2FSCK_TIME TEST_DATA
> +
> +else #if test -x $DEBUGFS_EXE; then
> +    echo "$test_name: $test_description: skipped"
> +fi
> +else #if test -x $E2IMAGE_EXE; then
> +    echo "$test_name: $test_description: skipped"
> +fi
> --=20
> 1.8.3.1
>=20
