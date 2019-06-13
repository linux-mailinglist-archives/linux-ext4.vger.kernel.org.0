Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1D244E7B
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Jun 2019 23:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfFMVaR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Jun 2019 17:30:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44864 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfFMVaR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 13 Jun 2019 17:30:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id n2so220370pgp.11
        for <linux-ext4@vger.kernel.org>; Thu, 13 Jun 2019 14:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=F/exPpIiYNX4VKXgJIOhJyToF3TMptEBGXJInmvnJRU=;
        b=dHUxVNSalqw/VpLCDefHkRuZOCh+0yr2i2ZE2ORrkY/Y6+HNmzKqqIR7hppQnw3xHf
         YqVPdF91xfW0or/tlZTrnXDyCra1Le0tC4T32xne3vAgbis4zYyqIQbDtVqBLYYSqkqV
         ui6T8xTCk7e+e1H6VhqicqA5E9hDroZQET0pE9eApKd7Z+3rDoJGkK2CEss7XRnPsJVJ
         n1Xh5V45kuPVQFvemglVg3iPsu98rPZ4cCnDwac5llI9ZrlfbgncIPuM3Y0YpDBSdNTd
         NhhHnnLl9jMGXXXxTnqnUlECPNGsY1TAFhm2LCcjZCvxtuXUfMZG+DnvV1BuODnD9+7x
         RbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=F/exPpIiYNX4VKXgJIOhJyToF3TMptEBGXJInmvnJRU=;
        b=Dwj1IBajqBrcdNb5kb0luzbM8xlSSb6tx+K0At4cb6IQt+cvQ1hzb3Ui9np7bkGQr7
         nf9ljXN3yc6y12kEypfSH/sKdScDYc6yOKJsxah2TGhmDXH82TVZiF/YNrTluLujENh/
         qpG4NxMBj/HXgJHshhFE+lGaQa6oD0PigaOHGfAfUrJPmtCtEEJmKL83Pmuib4KWuXk0
         CKU7yYeD9AFI50HCZlCG/P5JkV9/qjaM07rs6gr3xEBUUHQ0mvQOUVcBVoGSlqG68Xm/
         Ysmn4norYrMZd+X3s8T8Tj8Yt9p8c8owR/u3MunObKJBwkholOQvXPvgJKY7u5z4KIki
         psQg==
X-Gm-Message-State: APjAAAVyABaFyV8adiZXkVpUVw7n1m3KdWCeFhmB4ZYv34eKxUFantvv
        YdNU1axNz8SN7lum+4VvBjmQuw==
X-Google-Smtp-Source: APXvYqwrI15uEbmGG1xPaLM+kzqFoYZcK5b7HQQCUPfcxFauA0clSxta1mMc8DX0dd3rTqaC4GWnEA==
X-Received: by 2002:aa7:8c52:: with SMTP id e18mr26696506pfd.233.1560461416638;
        Thu, 13 Jun 2019 14:30:16 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id q20sm734414pgq.66.2019.06.13.14.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 14:30:15 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <C58B3116-8BE1-49F5-93ED-A73E8E72703E@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_36FDB1BD-2748-4281-A6C4-EEDA633E8F5B";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH v2 7/8] fscrypt: wire up fscrypt to use blk-crypto
Date:   Thu, 13 Jun 2019 15:30:13 -0600
In-Reply-To: <20190613185556.GD686@sol.localdomain>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>,
        Sebastien Buisson <sbuisson@ddn.com>
To:     Eric Biggers <ebiggers@kernel.org>
References: <20190605232837.31545-1-satyat@google.com>
 <20190605232837.31545-8-satyat@google.com>
 <20190613185556.GD686@sol.localdomain>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_36FDB1BD-2748-4281-A6C4-EEDA633E8F5B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

[reduced CC list, since I don't think this is interesting outside ext4]

On Jun 13, 2019, at 12:55 PM, Eric Biggers <ebiggers@kernel.org> wrote:
>=20
> What it really enables is a cryptosystem and on-disk format change =
where, for
> the purpose of working better with inline encryption, file contents =
are
> encrypted with the master key directly (or for v2 encryption policies =
it will be
> a per-mode derived key as it really should be, once we can actually =
get the v2
> encryption policy support reviewed and merged), and the inode numbers =
are added
> to the IVs.  As we know, when ext4 support is added, this will also =
preclude the
> filesystem from being resized.

Just as an aside, I thought that the inode number would *not* be added =
to the IV,
exactly so that ext4 filesystem resize would work?

I guess it shouldn't *strictly* preventing filesystem resizing, only the =
case of
shrinking the filesystem and having to relocate encrypted inodes.  =
Expanding the
filesystem shouldn't have that problem at all, nor should shrinking if =
there isn't
a need to relocate the encrypted inodes.  Moving encrypted blocks should =
be OK,
since the logical block numbers (and hence derived block IV) would stay =
the same.

Something like https://patchwork.ozlabs.org/patch/960766/ "Add =
block_high_watermark
sysfs tunable" would allow pre-migrating encrypted files in userspace =
via data copy
(read/decrypt+write/encrypt) before doing the resize, if necessary, so =
that files
do not use inode numbers that will be cut off the end of the filesystem.

Cheers, Andreas






--Apple-Mail=_36FDB1BD-2748-4281-A6C4-EEDA633E8F5B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl0CwGUACgkQcqXauRfM
H+DRkxAAguQoei75QIFtHRMjjKhbwe7XlaVA9cxt1znGGa9UDYET+EP9RvDgaeDW
k/tz7Id55t+ky+xnJdN5tjtyLnNYNl8BetmwnckTESfbLfDmEfWI+kqGcV1S4Tzq
ysaYo6NOUp1E8YhRMgjknpPxRHfZFshYiDoGrLONPsDkt50MWIPamDKklOAYb3zp
q3roVc5L9XLYOYQ8BafAD0sArkOlWCwvszayoiUZ4cRRjqyoRuBxNBlF+y21Rwp/
e720J9zF77de6Vv7ZRV3Elu2UuvpKKGHYiFoKOPXfDtXy65RDuHBg4uxRuajJuzt
uGORvBdGWaZGn9+PLLmoWTUVM8+f//Ktm1VHSGfFjBXE6mHXHtkDLRGHJ6LaCR26
w7I09LBVd5Y8B8rZ/1+pL+GljADm4XEdu/6N0BvpgGcXFe3Fb5IQCTfBZQeYb8pW
wDwnCndAU7RelcwCxTBj0RaBROsARjVIm4OZbMJb32a/wPtP2oPg0+L8f6OaUvlI
60iM+8p+oJD/BzmHhuMbDopD3nIL6/lfqjf7BkqrZfxxfuLPskDCD4xz1aJLXTiV
mfTf3eKdYSZCUtScAUTiYNILqhVp3Fsc0c+pfraBY+TnDSM63bGoK+qLamVwUeH0
ofdwr0P0sX8zsAFOU+YEUwdLAKjQ9D2aG5LzUiVk34/NvsN5CIU=
=g1cI
-----END PGP SIGNATURE-----

--Apple-Mail=_36FDB1BD-2748-4281-A6C4-EEDA633E8F5B--
