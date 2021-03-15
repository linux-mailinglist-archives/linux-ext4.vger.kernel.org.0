Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B80933C80F
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Mar 2021 21:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbhCOU5D (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 Mar 2021 16:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbhCOU46 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 15 Mar 2021 16:56:58 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF598C06174A
        for <linux-ext4@vger.kernel.org>; Mon, 15 Mar 2021 13:56:58 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id w8so9464009pjf.4
        for <linux-ext4@vger.kernel.org>; Mon, 15 Mar 2021 13:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=PzCJOaJmovHeARj1+EKzCZZg6wuUeNVUfrd9qnp2s2k=;
        b=UA2/PkuTXmBhuXOeeEVRmaE6hSqIT4hXvK2JfsHBwc6jMPaS3D4B1pm8X9deD0vrTb
         wmdI1erc8F6CN2KRW1tvIqq/c9N6ze8DfdNc3wsKITZrQI3ARNGLEC0WPkny34eD6eW2
         xsiI/U6HyDq6UgNKptLFZdnzL/2lfNg7RRmLIcqxqXQHhHJoc+iJTm6Qwm0FsR0Yi97B
         3nph+iaNDFRZuxdTvcVSO0seTmfHsb0aJF90Od68S/wYhYjpIh/vhW7wNWkE8S/bxM7O
         cvAn6PkD09dvvyIc+subE5p5/qlz8uSvl9M60il5pyu7VZtH09XHKJngWggSshZgVHa9
         Beqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=PzCJOaJmovHeARj1+EKzCZZg6wuUeNVUfrd9qnp2s2k=;
        b=DGq8COoGJ7QOnd5AyTa8pUPadRsLOiXxJfEvRQEV49oYweTkQ5Md6TAOIG7QiuiHKp
         B8aQ6lGscE5mXjNgnwuFIZ779EIr3g9TneEYanu4qBAi1S8k7Tw+POAa54+S6veOgjo5
         fHeFiAbxvpPQvNgsDzCPEQRDJSHRURlsye2zJTJEGde767ADo4jDE20xmhpQ4135CCy3
         kSri9n8CV8i2VAmHFWOe2T1w1DvLtxH59cEP1wgo81DtoKyO7rydJ9jdZBzlN6bJD5ET
         +6/Qh+C0KDj7nHInbawyt9mu4NAe48CkARjc7HpXlhYg5FHfUWUszzswAih1kuci7wdC
         ht4w==
X-Gm-Message-State: AOAM531+tE4qo1NCjdgqLatra2JCjhtLmQ7xdxCrwbmazAdLV9lW0sPF
        /n9H+Q6g71iJ9jEu2OXkAZ8bEA==
X-Google-Smtp-Source: ABdhPJyPEs4NasBQIR0e/d7oOQf2heohF8DyBA3n8NKkSA/H0S87P5x3frlyn3qbEy1b0hugzYgeow==
X-Received: by 2002:a17:902:bb83:b029:e5:dacc:9035 with SMTP id m3-20020a170902bb83b02900e5dacc9035mr13112784pls.80.1615841818240;
        Mon, 15 Mar 2021 13:56:58 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id n126sm13419148pgn.66.2021.03.15.13.56.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Mar 2021 13:56:57 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <097F004D-AA61-4732-85BE-5CC3611B9B9A@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_8C826B41-FC7F-4492-99B5-49F369B87E46";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v4 5/6] ext4: improve cr 0 / cr 1 group scanning
Date:   Mon, 15 Mar 2021 14:56:53 -0600
In-Reply-To: <20210315173716.360726-6-harshadshirwadkar@gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20210315173716.360726-1-harshadshirwadkar@gmail.com>
 <20210315173716.360726-6-harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_8C826B41-FC7F-4492-99B5-49F369B87E46
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 15, 2021, at 11:37 AM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> Instead of traversing through groups linearly, scan groups in specific
> orders at cr 0 and cr 1. At cr 0, we want to find groups that have the
> largest free order >=3D the order of the request. So, with this patch,
> we maintain lists for each possible order and insert each group into a
> list based on the largest free order in its buddy bitmap. During cr 0
> allocation, we traverse these lists in the increasing order of largest
> free orders. This allows us to find a group with the best available cr
> 0 match in constant time. If nothing can be found, we fallback to cr 1
> immediately.
>=20
> At CR1, the story is slightly different. We want to traverse in the
> order of increasing average fragment size. For CR1, we maintain a rb
> tree of groupinfos which is sorted by average fragment size. Instead
> of traversing linearly, at CR1, we traverse in the order of increasing
> average fragment size, starting at the most optimal group. This brings
> down cr 1 search complexity to log(num groups).
>=20
> For cr >=3D 2, we just perform the linear search as before. Also, in
> case of lock contention, we intermittently fallback to linear search
> even in CR 0 and CR 1 cases. This allows us to proceed during the
> allocation path even in case of high contention.
>=20
> There is an opportunity to do optimization at CR2 too. That's because
> at CR2 we only consider groups where bb_free counter (number of free
> blocks) is greater than the request extent size. That's left as future
> work.
>=20
> All the changes introduced in this patch are protected under a new
> mount option "mb_optimize_scan".
>=20
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Cheers, Andreas






--Apple-Mail=_8C826B41-FC7F-4492-99B5-49F369B87E46
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmBPyhYACgkQcqXauRfM
H+DUmRAAkFJcjahASN4B4WS33yDLIpldOKai+I79pTMKLyE5gkKMQA6uGukZ0yzG
HyVc6h/Wi+Hm4j9zJ8aaWpR8Xu6Qv57d7RBdEt0ap/ppinw0B7qzrat1QM4mbGRr
VOCyg/gOj3aL6VonOzCMv8jWhtfilRpS7JwyHLq+5rcKEb9HYfrChG4sUHMXvyn5
oPUmHoRGMuNatfY8yalo1AFE3X22/MVUNDN8vJKPbW356TuxTkEOmJuZrXzkaumR
NacrcWZuTVL/g3o7Yl0fvxmq9NBZKVG7CHGSfOsOyyconybTY403EQJ/RvRo9+XU
YSqnUU57qVyK4eOyIhpVMdEQe4mIzU1PzY8qoib9HxSeP4Th5CBfRIONGN6X5tkX
8iRPg8duzZGsLYfIaqFXeEPAbUqcnnIorJvENjJlbw5kv54LwhdVDa8AYMAGW8hE
76bLaQyAboUwvnUfhFJVHD9M4WKOCPXmreFk9V7N0lvAz+3qAljl34OOJhOw3U0X
Yj3lgIGNRVzIx8sEzE3nZWW3AgG4C49i6+D1Dr1wPQrEtgwMt5UGowSvFAn610iL
+6jEuyR6gOyCn7JV75Wxqg7wdoVgyDHBXwFqcfx/jmBbYh6dZMO7p+eUIQJ02zJP
t8596G1WuY9dBK8cbGKPhfq1YRfs8ahq5BK1fo7yjnkMsnfPwjs=
=Tsfp
-----END PGP SIGNATURE-----

--Apple-Mail=_8C826B41-FC7F-4492-99B5-49F369B87E46--
