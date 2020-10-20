Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552432933AA
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Oct 2020 05:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391168AbgJTDhN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Oct 2020 23:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391165AbgJTDhN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 19 Oct 2020 23:37:13 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57178C0613CE
        for <linux-ext4@vger.kernel.org>; Mon, 19 Oct 2020 20:37:13 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a17so197972pju.1
        for <linux-ext4@vger.kernel.org>; Mon, 19 Oct 2020 20:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=jzNgi27nU+p0uN86AO/B1aGFhpyBHnBmRWcfAR7XLHQ=;
        b=LEePMUAsIgWR/oywidC44a3ND7efBz0b8x50IqgzTRmYzAGiK0O+rzpE8Fx5tgK/aq
         lDGn1OirYp/MVAi5ke1wC8hrch3iBGRN56XKZ6xKrV7VqCYn8xombkI8VEn8Ntt7qfSO
         3isWpSiUaQY4D3CIygYVgmiiiUaIOYqZ4WXKsW5F5a/BLHPUoMl8siKFyGDywOEi3wys
         21SaxJyAI/JQ9T9nic2KwyWkvdhdjwPsktSGWQSxvEHAuahyViTo3yh4SeUJWUvXBQLN
         WoY+niRMXdp+MUCRJl7uikwE+ePEu87VKy/VwlJgK0pyZVLWswlsBN+Amm+9SzaNEgPG
         JVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=jzNgi27nU+p0uN86AO/B1aGFhpyBHnBmRWcfAR7XLHQ=;
        b=nl3HZRg9oPmoq2/XQOpjirXMwtgnDcnNeN2SQGBuoB33fFhUbj5lvOnvJBB6E+UpIg
         qxOlv53kWE0Up1EYcaEQvWVwF+IDPaIfD+qxyYxtdB+wL/nAS3NAQG1lQZeyWGeXtN7g
         W5DB0EvvvwfnosMu1t6cbFBr5K60D2JLRfyfAVb0TV2rdZeDQKZM5r6MkMipbTgmSv1V
         /YI8NfoF/30bAxbljFSWvnKBgwvpM8W4uArWoHBJ4vpfMA/KaCfpa7/9/ZLow7lgmDRt
         Je3/sv2S9k7gmVWWXyXLu3W2ZHIm7iY7X+HJ1HyY0hCRczvnO9G9++1d0+TFT/wK6BFI
         AYOQ==
X-Gm-Message-State: AOAM533o4sYuk0bRCO+OGan/sJMHE6YxF1eg+JuMxqYuvJD2ZTy1baW3
        CHbgOOtdcWLoBwNs2L3DpRw1Ojy9RZUrAhIw
X-Google-Smtp-Source: ABdhPJwlg1Iwh+GqjT0hyV9ILt3ovdqjGGjPi3ky3HmkQtXo6zjnfPO+wSZSUK30NeetbBXnX/kY8g==
X-Received: by 2002:a17:90a:f013:: with SMTP id bt19mr956012pjb.24.1603165032728;
        Mon, 19 Oct 2020 20:37:12 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id z142sm378619pfc.179.2020.10.19.20.37.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Oct 2020 20:37:11 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <849873AE-1880-45D6-B987-C5DD42967D4D@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_19DF4111-B1C7-4FCD-AC26-C4202BDFD7FF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 1/8] ext4: use ASSERT() to replace J_ASSERT()
Date:   Mon, 19 Oct 2020 21:37:01 -0600
In-Reply-To: <1603098158-30406-1-git-send-email-brookxu@tencent.com>
Cc:     Ted Tso <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Chunguang Xu <brookxu.cn@gmail.com>
References: <1603098158-30406-1-git-send-email-brookxu@tencent.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_19DF4111-B1C7-4FCD-AC26-C4202BDFD7FF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Oct 19, 2020, at 3:02 AM, Chunguang Xu <brookxu.cn@gmail.com> wrote:
>=20
> There are currently multiple forms of assertion, such as J_ASSERT().
> J_ASEERT is provided for the jbd module, which is a public module.

(typo) "J_ASSERT()"

> Maybe we should use custom ASSERT() like other file systems, such as
> xfs, which would be better.

My one minor complaint is that "ASSERT()" is a very generic name and is
likely to cause conflicts with ASSERT in other headers.  That said, I
also see many other filesystems using their own ASSERT() macro, so I
guess they are all in private headers only?

Some minor comments/questions below, but not worth changing the patch
unless you think they are important...

You can add:

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> @@ -185,7 +185,7 @@ static int ext4_init_block_bitmap(struct =
super_block *sb,
> 	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
> 	ext4_fsblk_t start, tmp;
>=20
> -	J_ASSERT_BH(bh, buffer_locked(bh));
> +	ASSERT(buffer_locked(bh));

I thought J_ASSERT_BH() did something useful, but J_ASSERT_BH() just =
maps
to J_ASSERT() internally anyway.

> +#define ASSERT(assert)							=
\
> +do {									=
\
> +	if (unlikely(!(assert))) {					=
\
> +		printk(KERN_EMERG					=
\
> +		       "Assertion failure in %s() at %s:%d: \"%s\"\n",	=
\

(style) better to use single quotes '%s' to avoid the need to escape \".

Cheers, Andreas






--Apple-Mail=_19DF4111-B1C7-4FCD-AC26-C4202BDFD7FF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl+OW14ACgkQcqXauRfM
H+BuJA//cqWDRV9ziaDEuAqFlNXn4u7EjEsazK7GNxfCy28/W773SQVMEAIn8qxE
ej5B4uwkeukg/fak29a9GPmhvFtt/5x3IISV62bsziftzqbiKclEObfttvWr2SAt
IX4BLhgbyXxOndBabId7BO7xUQ5orRWqlhNOVFSXENeGE3kfrseXsr92DL0ozQEp
km3T/VTX4KYIbGnPpmLI76xT1cjsvFzu53pmlrVYBl6BzcMUYrr5OOOF9BC0uvjN
eNovviuLc7JD9XlM6aEia2m4uMlLN4HAspBHZBApVSRNKLurjIxEJXbTNsaB1nvp
jb1OnxK+N8GWhzK0EZk2L1FemxASMUxMflY+9/1em9yZq/ruZsMCBYlXCbJXxUfD
tWgyD2qxEB/rM/YhRINEWcJHzSeXCfn4avzEQ4dwP3S1IuRZBwbYkoqZ7H6IOQ5P
mPUU6ch5mGkhxt73GixAKugPPPi8rhN086liJsBQaUTiKfjI/lxS7uArhgrBJrdB
OuQPYcHUr+KOuc7+yl+CS1QqDv5oRoSfPa51Hzlvz99Q2c0SNQbeIVIBPEeImwYc
F97mDZrpH4iUCjbRIGvfQqUBTcOX7PA/p9R9yJgQoWUEwNorcqkk3v1wkwchwRaq
1jDCTpJcEpf8Opiha+2j7fBLNRT3WegEL1nR+L3t3oRb9uwwlik=
=rpoQ
-----END PGP SIGNATURE-----

--Apple-Mail=_19DF4111-B1C7-4FCD-AC26-C4202BDFD7FF--
