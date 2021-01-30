Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B081430933B
	for <lists+linux-ext4@lfdr.de>; Sat, 30 Jan 2021 10:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhA3JW3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 30 Jan 2021 04:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbhA3JVI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 30 Jan 2021 04:21:08 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A6AC061786
        for <linux-ext4@vger.kernel.org>; Fri, 29 Jan 2021 22:51:19 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id s15so6679045plr.9
        for <linux-ext4@vger.kernel.org>; Fri, 29 Jan 2021 22:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=lNcd/WNbwGhj5zdRJWX4Pu2b1ght3iPEBDeAyYCBVbE=;
        b=1bObEDc5FLBK3ldJ86sKdGXkoIhEiY/n1UJRDZXAPYlf307OQxWw8CUZG7BXlNKz/h
         oar9mNHBdzL8WhHjFwEIDXtq6NE8SpAoemqoi2Ug+rNnajEMKXct1zaNOicS3tuB+1P9
         LNljg/9LH5TUG2R44OHWccTgF2MoP/OXS31hyiW42KjwUpUjtiNyT+6seRVvkafKDcuZ
         qVTeE7MSDddxXqmbh9D3I1Bklnc/dsdKcAX+ePNW3r3ooBvqvii8CchUaBF7Np9/B8PF
         auVCFk3gRRRcAvIQ5rdYJoE8wI6ajpRZJZ85Jm8Hdtt6YYcLbxYwq9EMIIi6SQGIDHM1
         21qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=lNcd/WNbwGhj5zdRJWX4Pu2b1ght3iPEBDeAyYCBVbE=;
        b=VPBWfz40W47CJXLV78jDqkuPy8AR7gr+HNAovx2CVRo4SxUQ6bagRvExMArqvWnHHN
         MNJB0dSaJPPoZB7FqvUmlpWpkH9iY9K61PYcK6UpKrrqTgtd56MN6D6xzY+AlZdsCwjt
         jSp48T0N1+C0RdoRR1qXKSySyLr3raBoAJ5cj7MEOFE5OdpeP6jLl9VafW0A1jBxpDWh
         +DJ8Wk2jgKoGyXrshvRRlMKuqSxRHZZfWlOg/eXeDiPB5OypFsmKxYOAUEQ7DSlq+a9V
         RfPyFFTqW9Lf0GqBw0QkA1QEwvVIzW/loL1nhgHP6mFziTLo4tG5px6/8mQOTzc36NXh
         7HVw==
X-Gm-Message-State: AOAM5327wiRF+1Z9QRevXy7nGTYlWZWIcjZKAxt13DtR4SlXFtkTvWwK
        8UtGmcTK4jH+RZYqp8rMycOHzg==
X-Google-Smtp-Source: ABdhPJzk0n7+p40XQx+HxpCyg24CrPDLXvFyZowB0wWwk7gWoQZXdTgdHnN2qeuAnzAlTYG0peRa8w==
X-Received: by 2002:a17:90a:ce10:: with SMTP id f16mr7909767pju.136.1611989478508;
        Fri, 29 Jan 2021 22:51:18 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id s2sm10727298pfd.203.2021.01.29.22.51.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jan 2021 22:51:17 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <D7CE0220-C513-4AC0-A29A-825E8708BB1F@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_31083411-FB9A-4DA1-93D7-AB2464E07701";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 0/4] Improve group scanning in CR 0 and CR 1 passes
Date:   Fri, 29 Jan 2021 23:51:16 -0700
In-Reply-To: <20210129222931.623008-1-harshadshirwadkar@gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alex Zhuravlev <bzzz@whamcloud.com>,
        =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>, Shuichi Ihara <sihara@ddn.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20210129222931.623008-1-harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_31083411-FB9A-4DA1-93D7-AB2464E07701
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jan 29, 2021, at 3:29 PM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
> This patch series improves cr 0 and cr 1 passes of the allocator
> signficantly. Currently, at cr 0 and 1, we perform linear lookups to
> find the matching groups. That's very inefficient for large file
> systems where there are millions of block groups. At cr 0, we only
> care about the groups that have the largest free order >=3D the
> request's order and at cr 1 we only care about groups where average
> fragment size > the request size. so, this patch introduces new data
> structure that allow us to perform cr 0 lookup in constant time and cr
> 1 lookup in log (number of groups) time instead of linear.

I've added Alex and Artem to the CC list, since they've both been =
working
on this code recently and hopefully they can review these patches.  =
Also,
I've added Shuichi in the hopes that he can give this a test on a very
large filesystem to see what kind of improvement it shows.

Cheers, Andreas

> For cr 0, we add a list for each order and all the groups are enqueued
> to the appropriate list. This allows us to lookup a match at cr 0 in
> constant time.
>=20
> For cr 1, we add a new rb tree of groups sorted by largest fragment
> size. This allows us to lookup a match for cr 1 in log (num groups)
> time.
>=20
> Verified that there are no regressions in smoke tests (-g quick -c =
4k).
>=20
> Also, to demonstrate the effectiveness for the patch series, following
> experiment was performed:
>=20
> Created a highly fragmented disk of size 65TB. The disk had no
> contiguous 2M regions. Following command was run consecutively for 3
> times:
>=20
> time dd if=3D/dev/urandom of=3Dfile bs=3D2M count=3D10
>=20
> Here are the results with and without cr 0/1 optimizations:
>=20
> |---------+------------------------------+---------------------------|
> |         | Without CR 0/1 Optimizations | With CR 0/1 Optimizations |
> |---------+------------------------------+---------------------------|
> | 1st run | 5m1.871s                     | 2m47.642s                 |
> | 2nd run | 2m28.390s                    | 0m0.611s                  |
> | 3rd run | 2m26.530s                    | 0m1.255s                  |
> |---------+------------------------------+---------------------------|
>=20
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>=20
> Harshad Shirwadkar (4):
>  ext4: add MB_NUM_ORDERS macro
>  ext4: drop s_mb_bal_lock and convert protected fields to atomic
>  ext4: improve cr 0 / cr 1 group scanning
>  ext4: add proc files to monitor new structures
>=20
> fs/ext4/ext4.h    |  12 +-
> fs/ext4/mballoc.c | 330 ++++++++++++++++++++++++++++++++++++++++++----
> fs/ext4/mballoc.h |   6 +
> fs/ext4/sysfs.c   |   2 +
> 4 files changed, 324 insertions(+), 26 deletions(-)
>=20
> --
> 2.30.0.365.g02bc693789-goog
>=20


Cheers, Andreas






--Apple-Mail=_31083411-FB9A-4DA1-93D7-AB2464E07701
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmAVAeQACgkQcqXauRfM
H+ALkA/9GwIU/Bkb6ftwK4JBVgaUbCG/vFo7nohAHEy1SOld6fOX3AUcl606h0Gm
JU1Lk94xYBqJ+QCETRDHhZm8OL/B50bqCtmCZuK9HkF5gfa2zUOUwylg6J61LkIz
wDw8t+/MIQ+cSAxjCs7TTaXeY6SjWBd2omwKt9jf8hqjqsfq/D7IIEYjJVlyhhA/
MFyx/qTcaqd0ID3OOITSuLe/VAkYYkdCkuEVEkbo3LwKDDz22/7Wx7sgvBUHeguY
9o5Bbg2+v27D34KmTmTqq4aqj0B4xAqALth9yxZWH9wMrbqUXzvAQvQYjKm8Mjdm
IUzASI+HxX4WbZdkvUYLxADJtXteOksk0OlCqraqpAWVZBBdJN0CUB0xA3HvSIiZ
sindVEWhjGadMLah2ocaGbV9HoiSu7LmKWWxXQ4i/rBMn1IYI7/cy7G4CqIvaNOF
si0LkctKEWoyVYzicJv22MdLZdYelXhkTl0HJgdWqB7J2rDHpnlvd2mnWMlnCrEq
0c9EPcBaE6Br7C66LfvUNxJC8p67tovgQYiNFadqHA/xJ4ZNpMYAUfDOLxTRToN3
DlOECYGbOdXy5at/G6ajD5ZO+XbE4hQWk0SJcXIJYzjLRos7S69l0PtutePsrGdB
l8FUjeTAiAT5eIchZuqvtkAQ1h/zDMzbQDNkCDMODUOZ/MesjBg=
=5i0k
-----END PGP SIGNATURE-----

--Apple-Mail=_31083411-FB9A-4DA1-93D7-AB2464E07701--
