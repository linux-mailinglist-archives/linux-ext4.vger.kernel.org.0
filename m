Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D2C353543
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Apr 2021 20:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236397AbhDCSe5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 3 Apr 2021 14:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhDCSe5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 3 Apr 2021 14:34:57 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455EBC0613E6
        for <linux-ext4@vger.kernel.org>; Sat,  3 Apr 2021 11:34:54 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id d2so7065810ilm.10
        for <linux-ext4@vger.kernel.org>; Sat, 03 Apr 2021 11:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=RiFVEOtmhK6v3jADkRB2OISYfs/BkvXr/eKHaTU3MG8=;
        b=va2aP+sXQBUARG1wN5Wf76LbWYHOtYztk5nuKPDqVKzFxVBV7LHRyQ01/ox0nr0g3h
         a2d4YxOXQvOmD21wRwFjYZOTPXs9KZPaNEW8m0Ujqf2X/cClutmRHl+5n62ehPjhx9xX
         E1VnSSpXFHX3mwVYg2gmoRrYTBJdnXDm/rrLakprQUdIid/BCCnLbFZMH9NDdz7tRr33
         6W6Gx8OqA//SdE7ZPnqZgNvqn6dHJIfxlTAPjyrUNCbqGbTeljpitgkhlMCdn0pFNRJh
         vMFclJUSlDpDuZLLTAuFBIf3q46Akr5hMlvWvyMdYEM7V7p5QnKbEcW2DgM3Y89udLoX
         7QLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=RiFVEOtmhK6v3jADkRB2OISYfs/BkvXr/eKHaTU3MG8=;
        b=o/KAvfeM8foZusVIhzenUFZiyKnE4flvWIcKojaQEpNDlAXbpRejPqC378tY1OItnq
         iYjw2omLXFfhuaBNzj8MOzyzAuMvHMWcUyFRrJ8j6ORz7GoLw4+3METQPI3jtEBhorHc
         QN3VaU06z5gMTSZVoEYOkFLn2yW2prmUh2U9GpUtrzpv913YRMn3O9T7t2OQMs9BU2XE
         RQHXcfz1xnCdBTub+LtyPMG+vF20u27RPYle0VL8TugGNMYNDzrHJzL7ImFMDXtXNeeG
         5guSZtnK4L3fyeHZzP9l5xMa6NapxsnbM3RcXvrm6nA15/wIJ0eaTpvO99oalrAktBI8
         GmHA==
X-Gm-Message-State: AOAM532Ee1afzoHfEFbkgtKQ8sNYFYZypw1en3jtzbeO9sd8V9oW2tPa
        xpjJ+FwDtqtwZFTqt9c7Mo7EyaOWOHunVKn7
X-Google-Smtp-Source: ABdhPJzab41IB1Im30aP8YCd4PuMqdf3t+6ooxv3SmuVdWpk7y9hVCOluBFQsxVSiq/xU3d5Y/9wLQ==
X-Received: by 2002:a92:cd51:: with SMTP id v17mr15321988ilq.146.1617474893512;
        Sat, 03 Apr 2021 11:34:53 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id w2sm5415542iot.29.2021.04.03.11.34.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Apr 2021 11:34:53 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <F552F506-E58D-4705-A2B5-FA2DD8BA2F92@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_EA129647-FA77-45A5-9410-01EC45CE21F2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] ext4: fix error code in ext4_commit_super
Date:   Sat, 3 Apr 2021 12:34:50 -0600
In-Reply-To: <20210402101631.561-1-changfengnan@vivo.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Fengnan Chang <changfengnan@vivo.com>
References: <20210402101631.561-1-changfengnan@vivo.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_EA129647-FA77-45A5-9410-01EC45CE21F2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 2, 2021, at 4:16 AM, Fengnan Chang <changfengnan@vivo.com> wrote:
>=20
> We should set the error code when ext4_commit_super check argument =
failed.
> Found in code review.
> Fixes: c4be0c1dc4cdc ("filesystem freeze: add error handling of =
write_super_lockfs/unlockfs").
>=20
> Signed-off-by: Fengnan Chang <changfengnan@vivo.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/super.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 03373471131c..1130599c87dc 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5500,8 +5500,10 @@ static int ext4_commit_super(struct super_block =
*sb, int sync)
> 	struct buffer_head *sbh =3D EXT4_SB(sb)->s_sbh;
> 	int error =3D 0;
>=20
> -	if (!sbh || block_device_ejected(sb))
> -		return error;
> +	if (!sbh)
> +		return -EINVAL;
> +	if (block_device_ejected(sb))
> +		return -ENODEV;
>=20
> 	/*
> 	 * If the file system is mounted read-only, don't update the
> --
> 2.29.0
>=20


Cheers, Andreas






--Apple-Mail=_EA129647-FA77-45A5-9410-01EC45CE21F2
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmBotUsACgkQcqXauRfM
H+Avcw//bzhOUVjNmUXu/k9UovCfRVlnylqXWkaHL1CWaEQ7kbk1wDht0JZamEIX
PHhvkIMVgdMx/ICKtzomDJDYnr2TRT/s6smZ0tOCiixynCCWoFcyQ8BOA5zBf6zz
w5W0bokUeNnAJpWENx4ujvH0X0msg07b10HYLv0h1U0240tBTbOiRhVNJhI3P0EB
Tm+8F2WEA1TBtHp1/weeAl1ENSOAvZFUMKyTIAzIi4paVfO5S8EgYQmqLGAfRM3g
NkWnlUhjdYM2oJZp75Cg0VMGdg5+tEn6wm/pEBBMKPzC8Lb4Y2wDOWTSgKQyOM9/
SRSGqkZ3pqLfA7US4skdCIdtzYFVtBXB1v4M78alN+dmV0oTYSzg3PWKXk2idB7u
geQ2EXdr3YrPvUW79coiaNqFWTxOlSAtDCm21gL3mz8Bk6TwMOnB05hkaOHTccbm
WWa2sO6Gv5jMlpLQKZy/Lq8UihvuAtNSYZ5r6GXGSdSTCVtLsjh0vUJ+itkRe5Ql
lVUpyDql4rAq+Xm3TdFs9/Tz5fSt6DbwIey0sQwOD+l3ufd+h5oHh1f8JseEPlDe
Svx6zGBv8sIyB6YxtyjznB4UiJZ8lvKa1ODXyNLSMgtRIMTu5ivpsJgoWekGbpyk
D5tAd3IECRs6yY9z4yWkMCJUZ4rjAYEzKzHk2/y6XNVqGr93i7o=
=IjHS
-----END PGP SIGNATURE-----

--Apple-Mail=_EA129647-FA77-45A5-9410-01EC45CE21F2--
