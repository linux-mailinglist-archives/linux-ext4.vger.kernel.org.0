Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21BBD2D2640
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Dec 2020 09:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgLHIeM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Dec 2020 03:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgLHIeM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Dec 2020 03:34:12 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E721DC061749
        for <linux-ext4@vger.kernel.org>; Tue,  8 Dec 2020 00:33:31 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id y22so3331435ljn.9
        for <linux-ext4@vger.kernel.org>; Tue, 08 Dec 2020 00:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Xz+DsYSx1DsdN8Vkzzlv5zo0KaLtkyHO+BETBq+6dro=;
        b=IkZSv61XVW8sKClIBhPj2vd8kI5FJowupGbjdd1lreW4QIQ62k17YLd4cUW1lqI0qz
         TlDEI3v+ePmfNMqgOG0ET4oX1W7GAF9prIYe0quMmyrsPB9eanfU+H22Yo4esag/pjj2
         V/eP2eUvUjLC1cOI5DC5Wew+OMaqLDPzSzgavNNuPQDrdHrhBJ5lgn3woWl249SEtAtQ
         qacsMoDMOs0769Jlw/CjsbZx8Y5raB1cCiSqhOITxaodgn6iRYaHlWwHltX23MsIp6yH
         +R/SUMq0QefSGb+i7pakwCMCUDwOFlryPCTb9fAWSv+GMusB3sp18wbAqgnxO6cFEz/a
         Cckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Xz+DsYSx1DsdN8Vkzzlv5zo0KaLtkyHO+BETBq+6dro=;
        b=oU6KFE64m3TNU+Dv5qooHJ2j01Gl8tu4edceIpDgI5RnUGq+p4nUuWAh+KFdybeTpa
         V3ncBP0pSzxDF1N5MUxj9d/Cdy5X1tQvsiLG2XJwsyDniLlUGgy7A19hXIiM+S6EYL6a
         kcq1RvKxiWqMe87Q3d1Shy85L39FAGQwLKMLjOD3RfD3votAElxVRNvPcG76EXouDKCy
         2G/kGZYIeffjCd0+kxbpr1uSQ/FgG54kRNFiWH/L+QOyGweh5BHCqsF09jigK5Vh+7Rh
         ZH0uqKzYt3vOcV8LWW4jpP0cPiHD3jg10QyxaTgBK8sayzx1ic7oqXkTdcGdSh/0ccg8
         Ma+w==
X-Gm-Message-State: AOAM531nr824TAnKczC7Ox2V768etKhlCdQIYBJCV9hEajgTm0H2qfZQ
        jXGUIA+8+46sGtyBAAC7Fk8=
X-Google-Smtp-Source: ABdhPJy7Cf3H/s5n3B5/c6fCn+ZWqc+IE1N1dGnxM9a7ToNRuwOB6d/fpjPm7g05k2yEa5vXOuGMww==
X-Received: by 2002:a05:651c:1213:: with SMTP id i19mr10012230lja.407.1607416410447;
        Tue, 08 Dec 2020 00:33:30 -0800 (PST)
Received: from [192.168.2.192] ([62.33.36.35])
        by smtp.gmail.com with ESMTPSA id e27sm3146011lfc.155.2020.12.08.00.33.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 00:33:29 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.17\))
Subject: Re: [PATCH] libfs: Fix DIO mode aligment
From:   =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
In-Reply-To: <B8DE3834-1B3F-4E1E-B342-51E04E4FD278@hpe.com>
Date:   Tue, 8 Dec 2020 11:33:27 +0300
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        Theodore Tso <tytso@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1485E4F8-618E-408C-B390-E4B093EC89EF@gmail.com>
References: <20201023112659.1559-1-artem.blagodarenko@gmail.com>
 <19A3D721-93C0-42F3-ACBA-DE15B4685F9F@gmail.com>
 <20201117191918.GB529216@mit.edu>
 <B8DE3834-1B3F-4E1E-B342-51E04E4FD278@hpe.com>
To:     "Lyashkov, Alexey" <alexey.lyashkov@hpe.com>
X-Mailer: Apple Mail (2.3445.104.17)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Theodore,

Is this case important enough to fix the code?

Thanks.
Best regards,
Artem Blagodarenko.


> On 19 Nov 2020, at 15:26, Lyashkov, Alexey <alexey.lyashkov@hpe.com> =
wrote:
>=20
> Tso,
>=20
> This situation hit with modern hdd with 4k block size and e2image =
changed to use DIRECT IO instead of buffered.
> e2fsprogs tries to read a super lock on offset 1k and it caused to set =
FS block size to 1k and second block reading.
> (many other places exist, but it simplest).
>>>=20
>        if (superblock) {
>                if (!block_size) {
>                        retval =3D EXT2_ET_INVALID_ARGUMENT;
>                        goto cleanup;
>                }
>                io_channel_set_blksize(fs->io, block_size);
>                group_block =3D superblock;
>                fs->orig_super =3D 0;
>        } else {
>                io_channel_set_blksize(fs->io, SUPERBLOCK_OFFSET); =
<<<<< this is problem
>                superblock =3D 1;
>                group_block =3D 0;
>                retval =3D ext2fs_get_mem(SUPERBLOCK_SIZE, =
&fs->orig_super);
>                if (retval)
>                        goto cleanup;
>        }
>        retval =3D io_channel_read_blk(fs->io, superblock, =
-SUPERBLOCK_SIZE,
>                                     fs->super);
>>>=20
> It caused errors like
> # e2image -Q /dev/md65 /tmp/node05_image_out
> e2image 1.45.6.cr1 (14-Aug-2020)
> e2image: Attempt to read block from filesystem resulted in short read =
while trying to open /dev/md65
> Couldn=E2=80=99t find valid filesystem superblock.
>=20
> It looks like I don't first person to found a bug, as someone was add=20=

>=20
> Alex
>=20
> =EF=BB=BFOn 17/11/2020, 22:19, "Theodore Y. Ts'o" <tytso@mit.edu> =
wrote:
>=20
>    On Tue, Nov 17, 2020 at 06:30:11PM +0300, =D0=91=D0=BB=D0=B0=D0=B3=D0=
=BE=D0=B4=D0=B0=D1=80=D0=B5=D0=BD=D0=BA=D0=BE =D0=90=D1=80=D1=82=D1=91=D0=BC=
 wrote:
>> Hello,
>>=20
>> Any thoughts about this change? Thanks.
>=20
>    I'm trying to think of situations where this could actually trigger =
in
>    real life.  The only one I can think of is if a file system with a =
1k
>    block file system is located on an an Advanced FormatDrive with a =
4k
>    sector size.
>=20
>    What was the use case where this was actually an issue?
>=20
>         	     	      	    	     - Ted
>=20

