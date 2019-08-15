Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 991598E4CB
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Aug 2019 08:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbfHOGJf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Aug 2019 02:09:35 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36242 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730358AbfHOGJf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Aug 2019 02:09:35 -0400
Received: by mail-oi1-f194.google.com with SMTP id c15so664620oic.3
        for <linux-ext4@vger.kernel.org>; Wed, 14 Aug 2019 23:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=XMIi+LTmaNSNmwfCZY1OMBoSoI8r8SgdSt1UqT4cQ6o=;
        b=HCgw2LvPLZY6Jje0S9YSU88e7NPnFdEBTiqiAf2lQCWESEXuwYShME2coIXZg6zQny
         +850/t+eXxXFzHO824NwYL9Z5msm3oMWOyQ3EnavaObzQEC16xK1W9QeNjQ5BfiXYp81
         UXd/ZdnyGovwesM3haxAQTf/kVfBngrp4fXqhNijkX7IMTIuEfaNDWA+Rkz3Q04Xu2SE
         nS+fy0nNi3lztEAvayY5NarRcmmlMSq8h2/ZlCYd9ZUkINNvc50hjlfTib8IX4KLzoIp
         QcYWdiRaHrb9ZevecwEjEaBxg94pnJ24QUorMTprOte6KCUNG1oDa3DyYnnMMmaKFrXj
         xvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=XMIi+LTmaNSNmwfCZY1OMBoSoI8r8SgdSt1UqT4cQ6o=;
        b=WjSSMCDlGx2g8ek3iA8wYG8J0a9NAZ6mhpQR21icVEjKuqLN3/J5EgMPM0DDnQ20UF
         IAHF6fZewVj0kwxCoDJxtJGudHiIK7lobKFw4hDV4ECgDs0Hfj3EnNyWPavV3nC+qFde
         vbbxKziakhWtjHu4duXZu29zJ8fxukiLlD8Fi+3eXBHLhDt34L7Q/daX0WzNMtROTp2b
         31h/nNAH+XeJ12ypbmmrLNXjHsiMvMmDxEYBHBKmljcV7/UenCm+kiAxuFc1F2wRc2DQ
         F9DhEq0hqutsgfzd6IZa+k2zNbf5s/rYpR09rO0fka8wVsAEJ/eufIzNnrtt0s48mBQ4
         0y6w==
X-Gm-Message-State: APjAAAWJAFVFLqBWHzSxMjVaa+uf0yAo6G6D7K9jvf+YKkG0jr52c95W
        SLOxeLwJqDO347q/n2AOcMz9vw==
X-Google-Smtp-Source: APXvYqz5PKkXLgKIlPsZMU2gikFKRrR0ZkkZvQJRxFYRufHlAOCOfTU3LeUn1EsOvdwJgbZ1Xh6gdA==
X-Received: by 2002:a02:b713:: with SMTP id g19mr3332113jam.77.1565849374267;
        Wed, 14 Aug 2019 23:09:34 -0700 (PDT)
Received: from [172.20.10.10] ([24.114.82.65])
        by smtp.gmail.com with ESMTPSA id p3sm1186690iog.70.2019.08.14.23.09.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 23:09:33 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <1FBF4302-FA3E-49BE-B9AA-F380518AB263@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_8279D554-5136-4116-923A-7ADF706F607E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Ext4 documentation fixes.
Date:   Thu, 15 Aug 2019 00:09:27 -0600
In-Reply-To: <CA+UE=SNWDBGuFpS9Y7g5iurJEJX41c+LMwis3ZGotbJ=DSSaJA@mail.gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jonathan Corbet <corbet@lwn.net>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Ayush Ranjan <ayushr2@illinois.edu>
References: <CA+UE=SNWDBGuFpS9Y7g5iurJEJX41c+LMwis3ZGotbJ=DSSaJA@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_8279D554-5136-4116-923A-7ADF706F607E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 14, 2019, at 6:47 PM, Ayush Ranjan <ayushr2@illinois.edu> wrote:
> diff --git a/Documentation/filesystems/ext4/inodes.rst =
b/Documentation/filesystems/ext4/inodes.rst
> index 6bd35e506..c468a3171 100644
> --- a/Documentation/filesystems/ext4/inodes.rst
> +++ b/Documentation/filesystems/ext4/inodes.rst
> @@ -470,8 +470,8 @@ inode, which allows struct ext4\_inode to grow for =
a new kernel without
>  having to upgrade all of the on-disk inodes. Access to fields beyond
>  EXT2\_GOOD\_OLD\_INODE\_SIZE should be verified to be within
>  ``i_extra_isize``. By default, ext4 inode records are 256 bytes, and =
(as
> -of October 2013) the inode structure is 156 bytes
> -(``i_extra_isize =3D 28``). The extra space between the end of the =
inode
> +of October 2013) the inode structure is 160 bytes

This should be changed to "as of August 2019", or possibly the date on
which the last field (i_projid) was added, namely "October, 2015".

Cheers, Andreas






--Apple-Mail=_8279D554-5136-4116-923A-7ADF706F607E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl1U9xgACgkQcqXauRfM
H+AigRAAjBT1bQ1441POojCHsdf5ekCI3YdUU3mc+ZlXpLiJEINu/s5yASrE+Sv/
8ZQ7Y9I6QjuRptKQYe5bmdBULxwBSrH5XOdRSgdaHUQV6Tme1ypYmltYt4sRmbXN
GHTATVXs0YVoO1WO9RXbf6y1FcdC6yLd3mmqPrY/S9d1HHPDJET780butz8J/JjA
D0EIVVpa+xoGpqT4coAqSbXmlkhKhtmqxwqfsSiEvGpJpZgNbuCKFwasnKGMIypY
Fzc6waSFyjZYCzzvd2d+OLybaM7GVrD6Z1NvZ7r1nQ6qqHiZuYxohUllFzrZ45Ti
Z8nSMViJOz/VHfxIddt3PaE8U6XGHsayAh8FvKAVnco3zr3CUlKG5knP9aDr5nk9
ZabmwSvcNcYfGS5O02asMQPmoIXPP2pHAVUebp3d+v697oz33dcbR0A3+xwsD4Yt
C1C4KyPNaEWScrCARWhqJY6O7iHDY4dpAGyZJAUfj0vN6Y93vXnLi1obHgoyg9ZV
A4UfbFFClvPl3/1TiSumnfh3YgSGUex4fnO04bs+3kVY0ALg6dZi1iSpkqj7zuTG
sNc9zD4gJkGsoF5Pc1kjpyPit+lzA6JORqOb4n7bMY9kDKZS/hTwl5+EbI9mUphm
m0k4LNclBsy5wFP/x77LR225ARd5VKqJfcHr20c5ok8NbZnVVIw=
=fx1V
-----END PGP SIGNATURE-----

--Apple-Mail=_8279D554-5136-4116-923A-7ADF706F607E--
