Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6DA61A4627
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Apr 2020 14:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgDJMMN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Apr 2020 08:12:13 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:53956 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgDJMMN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Apr 2020 08:12:13 -0400
Received: by mail-pj1-f68.google.com with SMTP id l36so719699pjb.3
        for <linux-ext4@vger.kernel.org>; Fri, 10 Apr 2020 05:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=gqg7eLNRFdl8KCrDA464hce4qyTzbV5TElzKCGkBZvs=;
        b=rdiQRnSUc6Ki0ww7VSO4alw/VnEbvIhLjM5hX3RXk7AgVlZDaOEcltJVe2NZoxus2f
         wfN5KVtXlk8QaVphBxRKgW8npVqqHbM5TAibla/PfOqQB128j/GMfoL9E69XQQyMFsz6
         bGMURQ+UOf2/e/q+H+fNbHjayQ3WkLcnFCg5zMyZLyIVqXiZUVLxZbqUChdwvnxu+sZa
         aV23GNu4NVylsSPgk999vjP2vn3Fegthk1K9TRupcLktrF1Cz5debG2Mc+a26KdBCj8P
         jTTITEDyy32S5OPb9wgngxTSRnk494+xsVi/QMdNY8IJyMBSK4in/PSO6kuH6HhvETH4
         g9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=gqg7eLNRFdl8KCrDA464hce4qyTzbV5TElzKCGkBZvs=;
        b=Fn1EspddzB4nPkPT8SSTnSZ1DgFBEuIMaz0nfgr7Gaa5O30b9ny+9CU6rER9A7RRC3
         d2iYgtvRVDacIg80ks4ezVPG/IsetIO+7khZyJjBDGep+UkySSL19VttZm4OeBd337nY
         A4gJt3g8T/v2JuAvxglgkSovrtYHREd2XMOIpD7LjWBeOczievP7Z6o3lt7xKd6TsRBu
         DnuACbp8PhWso8zMG3GjEQ8aEYjn4AsAVUpoUapoiiFDmhwNYt4CUPCPrOEhpvn5NjNU
         bxb/6R3J5O1+Qh23yPw8XFnVTY4YPFd6jeBh5iWEQEPVNwAbnbVrDJqQEjun4Sd7Xqxb
         LmCg==
X-Gm-Message-State: AGi0PuaeLf7rtRxxFJa+ucBMgso/7b9SYLcdIl6LAQQzWGERIQUhDwlY
        gIlKd1p9Z7XyLMyAuQorc8NTvw==
X-Google-Smtp-Source: APiQypJTKZKH1ffLiKCte2FjHOlsE/QXWpU4QIja9/VJRTYKFAbKf5F/mWpVnzbasUc01y+m6O/vjQ==
X-Received: by 2002:a17:90a:d589:: with SMTP id v9mr5061804pju.159.1586520732569;
        Fri, 10 Apr 2020 05:12:12 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id j1sm1622049pfg.64.2020.04.10.05.12.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2020 05:12:11 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <C29FFBAA-43A0-4307-B0A3-ED91A572308F@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_A59F6264-73B6-4739-86B7-EB880DD1914F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v6 03/20] ext4, jbd2: add fast commit initialization
 routines
Date:   Fri, 10 Apr 2020 06:12:09 -0600
In-Reply-To: <20200408215530.25649-3-harshads@google.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20200408215530.25649-1-harshads@google.com>
 <20200408215530.25649-3-harshads@google.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_A59F6264-73B6-4739-86B7-EB880DD1914F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 8, 2020, at 3:55 PM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>=20
> Define feature flags for fast commits and add routines to allow ext4 =
to
> initialize fast commits. Note that we allow 128 blocks to be used for
> fast commits. As of now, that's the default constant value.
>=20
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

> +static inline int ext4_should_fast_commit(struct super_block *sb)
> +{
> +	if (!ext4_has_feature_fast_commit(sb))
> +		return 0;
> +	if (!test_opt2(sb, JOURNAL_FAST_COMMIT))
> +		return 0;
> +	if (test_opt(sb, QUOTA))
> +		return 0;
> +	return 1;
> +}

This function seems more complex than it should be.  In this patch the
ext4_should_fast_commit() function is only called once during mount, but
in later patches it looks like it is called many times per file/inode.

Why not just check JOURNAL_FAST_COMMIT, and clear it at mount/remount
time if the other conditions prevent fast commits being used at all?
It seems that JOURNAL_FAST_COMMIT is only set if the FAST_COMMIT feature
is already in the superblock, so always doing both checks seems =
redundant.

Also, maybe I missed the discussion, but why does having quotas enabled
on the filesystem disable fast commits entirely?  I see in patch 11/20
that EXT4_FC_REASON_QUOTA is a reason not to do fast commit on the quota
inodes themselves, which seems like a reasonable limitation if needed,
but the above check disables FC for any filesystem with quota, and I
can't find anywhere that this line is later removed in this series.

Cheers, Andreas






--Apple-Mail=_A59F6264-73B6-4739-86B7-EB880DD1914F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl6QYpkACgkQcqXauRfM
H+CZEBAAtyHEdx6GtauLjtOxpXpqYP772ViwP1iWCAY3ZgjTR8+nuQgwGeEIu9oe
bcKkKDeNnTcF+G01rCedLX4N7mpZglKFf6j8M/SHBX9yGLEFF3Hu+1yZ3DHZH8tx
f0TANgVRHvtbOfLVXHlilCYma1Ao5MqhJziwfC28JjuyFIlC31PMRfCQ73yM8kQk
Vd4YR1tsIKcAw5UD7SoZK5Lt+9uq2N27ZLpnox0TfHZbrKvn1VL3yeCz+GXexwu/
ZiiElPD46AzNGMM9hsE2LRgiMK8Rr+XElsvrA2iAjntLGLzkVJjrM9zNCom8oCfE
RWEmDhfiU+lsM24xCjJOWnbvsx9nm6O4cGV2SPrqsQCsfVdNb/YAwrbYf33Zb2wN
TrpMjKwX8dZQoZlKnGzNZ04EHeR6zykBKQtOdkp6JDO7uwgQwsq2FMa8MigbSE9g
Te/FJXIxbEjjn0w4cjigdvisYh9Ng572Gp4wXze/9cNzT9K94S3tJdmnucRqoWMs
YxuYAgN4EAs/cBUTxp7UkmBIPp8hMmUdq7O9CKl+uaLqeVrQS+2OCic7+LiD9jN/
QR09b2N2KzwCUEGIcHYHHuWYSdrL7MvTG2PxJWYtQ4yPRB4dGWfzGOydQFEKa1ju
btX6RKPJVROst2f+Uxo11A3B1X6MuHNFFBggKeN6qn9x6I5lkmc=
=hcjI
-----END PGP SIGNATURE-----

--Apple-Mail=_A59F6264-73B6-4739-86B7-EB880DD1914F--
