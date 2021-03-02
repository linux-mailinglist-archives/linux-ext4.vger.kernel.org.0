Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132F432AF4F
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Mar 2021 04:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhCCAQm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Mar 2021 19:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376692AbhCBHsz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Mar 2021 02:48:55 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E99FC06178B
        for <linux-ext4@vger.kernel.org>; Mon,  1 Mar 2021 23:48:10 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id a24so11517111plm.11
        for <linux-ext4@vger.kernel.org>; Mon, 01 Mar 2021 23:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=b4WCHLAu6nY62XY5P2cEi3+nDXRhANwC1GMY1HI2Hx8=;
        b=K3Q4UZwBEYCS1hTk6kEvVY8KeiIYyDSA/WnnVE94ahB5Jmm/d9qVpfTGVWFXRPqCZ3
         KwRZwg5nLhHD31lquwJI98EpaPjEaefgfc/5UNx5Vyewln1lhsiyT8faeYhU2c3f/piR
         7pXCLVkodN1IzY5L1053bZWWpGIKK7UKUkZKt/zUcPRYyTeriee37ey0loiXqvlyik9D
         +bZ7bSJpwk1XwDAAJHdV05DIJEkLqfGfHXiR0hJTUd73YV0K1fMOaRpg4/lA8c3wYStY
         bjy2pqA4xM7cRr6YyNN6imsQY9YD0ks8JrKRpGfhbizEkRdM6W9R0yzilStUHIW0zyvo
         SWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=b4WCHLAu6nY62XY5P2cEi3+nDXRhANwC1GMY1HI2Hx8=;
        b=cGBWpM3smeC/A8aywXBd7mq0QJVJVpmcYFrVJOT+0I1RzpGWrSji0M8GW7zCoBgb+p
         DwkQ6BEBNtsEuSXcM6iQbYA7Zv+2pCwlraOEaWxyPrz7yvLvK5SwHecmQvy2Naw1/QBI
         dvbQIpQF+AKiFB4FHa9axeg5S2QFvJrH3bBjAWkFHhsEfpdHb2kl8Z+mFo2sT+x8pcEQ
         rcbwsgK1TqW91jKKBu3MpqZQLoFBwsHfGVsVBKQWVq0f/ORY0slRTtF6tPkFYJtvv/N4
         /AljbC3+KnhKCPARKMNR78SxC9zoZd/CTtMFJbR1/hQwYggwbyvgfFK0RJXmimAvvTqR
         xgIg==
X-Gm-Message-State: AOAM531KVl9vidsPbBXR+2OwG6PC5YbbrWrYHhePRuTKebwib3EFb5fx
        nXTS5sXTxViCBQtJFaxSNR9bzA==
X-Google-Smtp-Source: ABdhPJww6/rO4ADlum7JURiy2hKSVnB7e9dpefStWvk0Kf4prFzJO6QWErXDXAO1RUDFWjx/OAbOAg==
X-Received: by 2002:a17:902:d64f:b029:e3:8ef6:1775 with SMTP id y15-20020a170902d64fb02900e38ef61775mr2428383plh.28.1614671289581;
        Mon, 01 Mar 2021 23:48:09 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id 137sm18816759pgb.80.2021.03.01.23.48.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Mar 2021 23:48:08 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <11FFFD2A-2FB5-499A-844E-6AA5E8771BCE@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_A9EE95A7-F7CA-426E-8F25-94B946ADCEB2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3 4/5] ext4: improve cr 0 / cr 1 group scanning
Date:   Tue, 2 Mar 2021 00:48:06 -0700
In-Reply-To: <CAD+ocbxSp1XrTFhy9UTu+bSxr-XVqhRQzVqy4mtiRHFbDARuhw@mail.gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Dan Carpenter <dan.carpenter@oracle.com>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
References: <20210226193612.1199321-1-harshadshirwadkar@gmail.com>
 <20210226193612.1199321-5-harshadshirwadkar@gmail.com>
 <C9D3369F-E02F-4D49-A719-6793B70E7D22@dilger.ca>
 <CAD+ocbxSp1XrTFhy9UTu+bSxr-XVqhRQzVqy4mtiRHFbDARuhw@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_A9EE95A7-F7CA-426E-8F25-94B946ADCEB2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 1, 2021, at 6:53 PM, harshad shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> Thanks for the review! Some comments inlined:
>=20
> On Mon, Mar 1, 2021 at 2:22 PM Andreas Dilger <adilger@dilger.ca> =
wrote:
> >
> > On Feb 26, 2021, at 12:36 PM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
> > > Instead of traversing through groups linearly, scan groups in =
specific
> > > orders at cr 0 and cr 1. At cr 0, we want to find groups that have =
the
> > > largest free order >=3D the order of the request. So, with this =
patch,
> > > we maintain lists for each possible order and insert each group =
into a
> > > list based on the largest free order in its buddy bitmap. During =
cr 0
> > > allocation, we traverse these lists in the increasing order of =
largest
> > > free orders. This allows us to find a group with the best =
available cr
> > > 0 match in constant time. If nothing can be found, we fallback to =
cr 1
> > > immediately.
> >
> > Thanks for the updated patch, I think it looks pretty good, with a
> > few suggestions.

Two other things that I wanted to mention in my previous email:

- whether this code should be enabled by default?  I think yes, because
  it is very unlikely that normal users will know this optimization
  exists, and the code will be dead for them, as they continue to suffer
  with long scan times.  If we think it is not a win to use with smaller
  filesystems, then MB_DEFAULT_LINEAR_LIMIT could be increased to where
  it *is* a win (e.g. 1TB =3D 8192 groups).
- rather than having mb_optimize_scan disabled for small filesystems at
  compile time, it would make more sense to allow mb_optimze_scan=3DN as
  a mount option to specify whether the feature is enabled or not.  If
  unset, then filesystems over MB_DEFAULT_LINEAR_SCAN_THRESHOLD would
  be enabled by default, but if =3D0 it is disabled, and =3D1 it is =
enabled
  (regardless of filesystem size).

Cheers, Andreas






--Apple-Mail=_A9EE95A7-F7CA-426E-8F25-94B946ADCEB2
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmA97bYACgkQcqXauRfM
H+AUcxAApXuI7zQrLccBdN/oGfwKqkSy2iDmZaCIoR7zjpnuvMi1lCahwdTYDKwd
intqrX6gabEwTicXt8PnYDSR/H56bUIlfwDBUXKleLzoh8iDnPhTXC9GvFfSlXmT
BZCIDAJaOba5ienbcptTMjTiI+XYAiFqpyvd2nRwfJJM+y280xpox2LWjNDbromP
noT9RssL1mxrWdc6YWrYU57wKnczEpywgZs0XAbA6vxF8dvCRYS/7xrSpHgtekSn
9DN5E5/qEOPcFtS59a/yRLg/ZwdNvMIZA5saHWAdA55xtgZXaJiMQPaX9GbZRzE6
Y96Mzvs2061YA9/f0yM08v78guLM69n66LNZ5yPHs+wKZsZu/6OG4GDU0W4r2B5e
SZOfxvQNqWDy+cGsYro3djQu5dkWKRVV05/3d7eXvCRukODMmTB+0lm+So9uFBWs
RfwXH+v/JT/GylzDe8qfBGarUNASFqzfPfqSEG0+dpBxyAdGMtRZnNyTFsIdYqnp
xmFzbdsAOojYHEYRCMAyhgQXZ91/VPv6qegfy/tdL3h2hECpDM6rec+Ri4WOqPvi
tv1V2m8rBttZ9kyFRvpG5dZxkBEj0U7D4Lm6/bAL0Od+QbdGU2lQ0Jk3bVbecAaV
5ua0TUXHZ6ErBL04DlUuN9uy1cAqu2QO0PFDOCzWDqDfqNlNcpU=
=D1vq
-----END PGP SIGNATURE-----

--Apple-Mail=_A9EE95A7-F7CA-426E-8F25-94B946ADCEB2--
