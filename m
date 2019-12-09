Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A606F1165C3
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Dec 2019 05:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfLIEOB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 8 Dec 2019 23:14:01 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:40051 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfLIEOB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 8 Dec 2019 23:14:01 -0500
Received: by mail-pf1-f174.google.com with SMTP id q8so6513414pfh.7
        for <linux-ext4@vger.kernel.org>; Sun, 08 Dec 2019 20:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=3GvdW2CuuDCjmaIXoH+aO02+O+7dJNZOnUzcKt51VDI=;
        b=bAPALUQnmHMyMv3VeoJ/HRpBirGud1Pulxaf3ZzC/vvQmfxAWe2mTMSpIBXxNCGXiS
         jtALtUUI1kOa3WrX19geTFyCqTiQDARXsA6Y9nY2KR8FNxoVgrFpG7PSMGsvp4tnSH0k
         rnaRuyjieVCZ5jJ8ndO/HFtb0Ue8p39Nj9Kvr00sVMCQ8OKNWeQbAEmO8WOmxB8fzYxu
         9/PxGbA70yYCWvwokZJTUtWwGAvo3tMeGav1Wv5E6Pi4DQb28iv5Zbq2uda1mzx0vQsu
         aKe+ZiMOA3r94adprutXbhHVIHSrtdaTu5wIgHwsJL+fTWlp3S1fAI5PWKGsSfehgfiV
         1YiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=3GvdW2CuuDCjmaIXoH+aO02+O+7dJNZOnUzcKt51VDI=;
        b=c9ddCoipgR1Gf+/0J7Xs+tf2UnkIgmNSLHa7ZmMBimMc8jz35FF9HE2I6++1/bxBz9
         H43//OCgP0Qv05BZQiKWl5h0fSpK8T3/PYHhzAdS4Wm6nOfFclH1lWGout6ESfwzucVw
         qzHskpNaQcYlTJ+gAnhSVJ+BswR5HiPsRow4bUp7yNKZtaY/WahPhhqQOUr1+lxnKmCm
         eLwDnMsBp0uBNErilYjUTq4h1qwiCbkbBkIkfD297DuFDdfIP/S2NDZoMhG+vArqRcPG
         fkiVF3I56OFdyVsKzcwcJTqDYuh8+CWxOmGsjB4GnpwvYu+JNlDr/ol308cA83oslGEo
         6O3w==
X-Gm-Message-State: APjAAAVPcTRwXvEG+veDZT/yii8fCCdpslwCR29a1acQ1p8mLxYtUP8p
        ST0HIuxxkAU5Of6P2BkdTm3/waomEYwhbw==
X-Google-Smtp-Source: APXvYqz2ZSoZdTvIHigjzXZpocwWFisBQ5wG8TNMY8FNUFBoQ6yfmObph2+yw8AI/EgH3xGKxBOZRg==
X-Received: by 2002:a63:ed49:: with SMTP id m9mr16448383pgk.304.1575864840700;
        Sun, 08 Dec 2019 20:14:00 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id k6sm24577977pfi.119.2019.12.08.20.13.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Dec 2019 20:13:59 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <14336F5B-D8D2-4B73-A60C-3B63997F0827@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_304B8726-7F83-4798-A158-4B5701D60DAE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH -v3] ext4: simulate various I/O and checksum errors when
 reading metadata
Date:   Sun, 8 Dec 2019 21:14:08 -0700
In-Reply-To: <20191209012317.59398-1-tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
References: <8504AF0E-39F8-4C56-86EE-9945E15C1A16@dilger.ca>
 <20191209012317.59398-1-tytso@mit.edu>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_304B8726-7F83-4798-A158-4B5701D60DAE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Dec 8, 2019, at 6:23 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> This allows us to test various error handling code paths
>=20
> Previous-Version-Link: =
https://lore.kernel.org/r/20191204032335.7683-2-tytso@mit.edu
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>=20
> +
> +static inline bool ext4_simulate_fail(struct super_block *sb,
> +				     unsigned long code)
> +{
> +#ifdef CONFIG_EXT4_DEBUG
> +	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
> +
> +	if (sbi->s_simulate_fail !=3D code)

This should be marked unlikely(), as it is definitely one of the places
that is legitimately rarely true.  Sorry for not pointing this out on
the previous version of the patch.

Cheers, Andreas






--Apple-Mail=_304B8726-7F83-4798-A158-4B5701D60DAE
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl3tyhEACgkQcqXauRfM
H+BY4Q//VZBqM/Wcy9Y9tICKLkHCtEluB9sPz12GDf7QwpSPT0vqGG+cm7DPm7Y4
/kHNZTn3imM4iN8BuvM4m9I0xEcgUc0U8WbKxa2aXY+x40v3ltelA9Xp5jGyqivv
iLqm3O/d5M2pnfV+1aXab41ulOaKwmryIAIbGBkZo33Kn4wc/jLsjeOtnl7T1XJa
9nleRZ9SfNmwcqLM1WyLAEqd8q/L5hEK7coPXqKoqeV+pnv2qEBCK25oovko6zNT
cha9yWB7pgEVO2/vQfOtpU8ipEurcjKTeMt6w8oDU79APTW2AwEzh4yh54qhfTgA
MPB57yO2k1KZbWEjqGmhcqmFNlrcqAphNtSC6dLy/B+y0YLa2JqfM310IMv9ujeL
ueoVULNHpHeSOAP3UBxBazS4kG5q/2c3Ha+JvTCKR3m1QYM8fVigAhfCbDI/O5K0
h6skJwU6ANJTvgnMUsyvEEhPX4HMVYIMutQFYVw+paASuS3Fe/M2mrjR3/jxM6dA
JEQ6F5TGZmXcNkj2TlHC24hUL40HEb79DFx7xjaBQpG9Ho4+R+JrspyP9YvgXc3H
7iEtXRw+OsqGG+hQjn5U7jFHzjSru9Zx/mw2feYk3y4lu0mXD24hLTARmw5N4+DW
/KQRWijJ5vzm6ohexlUprdImbVchTDFu17tyPclrz9KAvadWjDA=
=TXtr
-----END PGP SIGNATURE-----

--Apple-Mail=_304B8726-7F83-4798-A158-4B5701D60DAE--
