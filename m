Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF7477D2B3
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Aug 2023 20:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239564AbjHOS6c (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Aug 2023 14:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239678AbjHOS6P (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Aug 2023 14:58:15 -0400
Received: from fulda116.server4you.de (mister-muffin.de [144.76.155.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7BE11BD1
        for <linux-ext4@vger.kernel.org>; Tue, 15 Aug 2023 11:58:04 -0700 (PDT)
Received: from localhost (ip2504e722.dynamic.kabel-deutschland.de [37.4.231.34])
        by mister-muffin.de (Postfix) with ESMTPSA id 23CAB16C
        for <linux-ext4@vger.kernel.org>; Tue, 15 Aug 2023 20:58:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mister-muffin.de;
        s=mail; t=1692125884;
        bh=nLYmIzlK/+vzJWmaVmgJGVneuClKyYRo5sfakujS5cU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=JYS0cYrw9nVuEDOYKp18XJF8I+t+wUN1sy3QEANhhH7K9xwBaPqyzvlYrmDA2bHPK
         KsFPiBJOe/i5rb8uVdw3X5ewldYGQRJmS3PLVpAiOvm7L6VBvUtb/CO7TH26l1L1xa
         4NBR6dBCMBVetPm7NuvFEZMraXpsPTc17dMcs4Ig=
Content-Type: multipart/signed; micalg="pgp-sha512"; protocol="application/pgp-signature"; boundary="===============9123211068900050776=="
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230815175717.781425-1-josch@mister-muffin.de>
References: <1FD4874D-0E9C-442C-9FC1-AC35DCFD0A3C@dilger.ca> <20230815175717.781425-1-josch@mister-muffin.de>
Subject: Re: [PATCH v3 0/1] mke2fs: the -d option can now handle tarball input
From:   Johannes Schauer Marin Rodrigues <josch@mister-muffin.de>
To:     linux-ext4@vger.kernel.org
Date:   Tue, 15 Aug 2023 20:58:03 +0200
Message-ID: <169212588361.4033323.8262921065474317997@localhost>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--===============9123211068900050776==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Quoting Johannes Schauer Marin Rodrigues (2023-08-15 19:57:16)
> > Rather than having an inline #ifdef here, this could be structured like=
 the
> > following in create_file_libarchive.c:
>=20
> I now see that you already tried to tell me how you'd like to see this in=
 an
> earlier mail but I didn't understand what you wanted to tell me. Thank yo=
u for
> spelling it out for me. I hope my changes now look as you expected. I agr=
ee
> that it looks much better now.

whoops, my refactoring accidentally killed the ability to build without
archive.h. Please imagine my latest patch with the following on top. The gi=
thub
pull request contains the fixed version and the github actions succeed now.
Sorry for the noise!

diff --git a/misc/create_inode_libarchive.c b/misc/create_inode_libarchive.c
index c147828f..deed65e8 100644
--- a/misc/create_inode_libarchive.c
+++ b/misc/create_inode_libarchive.c
@@ -20,6 +20,8 @@
 #include "create_inode.h"
 #include "support/nls-enable.h"
=20
+#ifdef HAVE_ARCHIVE_H
+
 /* 64KiB is the minimum blksize to best minimize system call overhead. */
 //#define COPY_FILE_BUFLEN 65536
 //#define COPY_FILE_BUFLEN 1048576
@@ -536,6 +538,7 @@ static errcode_t handle_entry(ext2_filsys fs, ext2_ino_=
t root_ino,
        }
        return 0;
 }
+#endif
=20
 errcode_t __populate_fs_from_tar(ext2_filsys fs, ext2_ino_t root_ino,
                                 const char *source_tar, ext2_ino_t root,
--===============9123211068900050776==
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Description: signature
Content-Type: application/pgp-signature; name="signature.asc"; charset="us-ascii"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElFhU6KL81LF4wVq58sulx4+9g+EFAmTbyrgACgkQ8sulx4+9
g+HtZA/+Kq7s5K6wRdpgnYrJ/X9mWcCmHCxTkIbtzVj3B6bJK4q+ryxdjN83bb2R
BhIBSHm7eL+SEvNBE2QAI2vwfORl7jzwYGj6GNE1/LYLX7twBohpcXM2h9ZweKgp
40B1i3InKk1h3+wo3UwqGboycZVsYYqgFfQ5MXjCZpuwvF6zgU1LlbEd38AXCpN/
MlHBDvix+JymvC6lB7/gwwd9ACjWrVtEbfuAl10R0BCAYj7+R1DQajiYwjLCUMTh
YEO+eS9/+/XNLkDwYBR1UdDPDqp1Gwu5DsWHfL2MnJkHZ7q3jsW0CEoqDqhbZ/D7
1KJuj7A0660nrVEbyI0KtZaf6B970+yNtN6qwdaGjFODduWJreV4MS/MMQR4YTb1
KcT30/2eQxHKzQsbVwt/dwtqCW4i+k7IsCmfMKDt99b0iZ2zY+WJZ8fn5565DhUk
wda3oJ4xvsBzQnVdTyeyN5MJLldHeQGu9X4RzevMblhASpgRII/xWtMR4/JeXZwG
LYbuMGKRrQoK78XrKg4N+hf6bAwH44S8ZL3T9LpECAeucH4W2X363FS1MSnia8f/
VEUQrHhs6t03DwWXbPnCubR4d789AR0KB3LRyJtIVmbBd/spHd+LwzeVYFE1ciIu
NT2US+F6uS6H9PuTMmFoa7C8fXEZc4fs4P9VD6FqFWSjPMxNoBA=
=gVZm
-----END PGP SIGNATURE-----

--===============9123211068900050776==--
