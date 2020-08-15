Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2F7245260
	for <lists+linux-ext4@lfdr.de>; Sat, 15 Aug 2020 23:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgHOVrp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 15 Aug 2020 17:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgHOVrp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 15 Aug 2020 17:47:45 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32098C03D1C5
        for <linux-ext4@vger.kernel.org>; Sat, 15 Aug 2020 14:47:45 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o13so6209416pgf.0
        for <linux-ext4@vger.kernel.org>; Sat, 15 Aug 2020 14:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=5XX8unz1SdbyMJ6j+/Y2aJ1EwDHodmlem3chMnkN1Vw=;
        b=TdOGvzrZUJ0e0bJ95QZoPcvofENlAFIDHqAUqDvMiR6QndP+PVFh3mx5XSd9r90aOy
         tr+X/74BisELsCC3HkO3ed7RmEx24KeAk8BLswck9bGVVmfhI/elBlc3PenWkfpcy9S7
         ++a9fRgnJNa3K2E/rM26jsnXi50APs4o/EetLHWdG0rtcAiJEG4H+iSsfn0d+UnbkE8a
         YOMui7TkRhjJ8LXh2PwnpHI1sQaAqEnUtDiXWEITf8ZQW8C5nYRG3/4oCEp78aOsTx0M
         UCholouiwQSUagC45Wnw6USf2aVTcMZ9JGfd3gctv5w7ewkXRRvtDa5mvljOxCVAxtrV
         +AJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=5XX8unz1SdbyMJ6j+/Y2aJ1EwDHodmlem3chMnkN1Vw=;
        b=dP8KFdafVESAs2BwDb7CqykHmzhZvchD1oICdriejdFEJT85qeqOUFzhVNSahPD89S
         blmnw+iiDhXk4Leq4KOfCM6M+zAmvHcOE2Gal6YZw5XDacPWNtdNjhobuQXlgjAHymum
         020ASLpy/1T53npUUJiZoGYRQnYXyuxGYs1hMlL5QxUl8KjDFJpJ1mY0Y1dKnynJTWPp
         7cvjQVstBbuulDoD9DDaGWy+CZbzqcuYiB2oUNtQtr8lSUO+azVrFZcfT8tCiFI45k0I
         ZTxQtHDQ3wDGW+4CtjPg4EXPuY9+YDK/7Lr7rzfim4Dz+1Ld9HwoYcSYGzoWMmwWRb+t
         TNGA==
X-Gm-Message-State: AOAM5311RfTnd2kruJvQLVZjzdRps5/LYcEdeGqffzBzRgYp3ocJClJ6
        uDmZ1SDVg45b1KZEGZ1NHbuj4w==
X-Google-Smtp-Source: ABdhPJxNTagAUQHGUKAQ838sYM8Sj/TeXgMv8m8GHuBeZXevEOGddMo5nfmz/RqnxzyvZFjbepNaBA==
X-Received: by 2002:a63:5f8b:: with SMTP id t133mr5782923pgb.340.1597528063551;
        Sat, 15 Aug 2020 14:47:43 -0700 (PDT)
Received: from cabot.hitronhub.home (S0106bc4dfb596de3.ek.shawcable.net. [174.0.67.248])
        by smtp.gmail.com with ESMTPSA id s29sm11649439pgo.68.2020.08.15.14.47.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Aug 2020 14:47:42 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <59DAEB04-75CD-4018-AA65-60EC98D2383B@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_9FCB3B88-2ECB-4C67-B99E-38E1C230EAC9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3] ext4: fix log printing of ext4_mb_regular_allocator()
Date:   Sat, 15 Aug 2020 15:47:51 -0600
In-Reply-To: <0a165ac0-1912-aebd-8a0d-b42e7cd1aea1@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
To:     brookxu <brookxu.cn@gmail.com>
References: <0a165ac0-1912-aebd-8a0d-b42e7cd1aea1@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_9FCB3B88-2ECB-4C67-B99E-38E1C230EAC9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Aug 14, 2020, at 6:10 PM, brookxu <brookxu.cn@gmail.com> wrote:
>=20
> Fix log printing of ext4_mb_regular_allocator()=EF=BC=8Cit may be an
> unintentional behavior.
>=20
> V3:
> It may be better to add a comma between start and len, which is
> convenient for script processing.
>=20
> V2:
> Add more valuable information, such as group, start, len, lost.
>=20
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

A very minor cleanup possible, but not really worthwhile to resubmit if
Ted wants to apply it.  Either way, it looks good.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/mballoc.c | 9 ++++++---
> 1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index c0a331e..70b110f 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2218,6 +2218,7 @@ static int ext4_mb_good_group_nolock(struct =
ext4_allocation_context *ac,
> 	struct ext4_sb_info *sbi;
> 	struct super_block *sb;
> 	struct ext4_buddy e4b;
> +	unsigned int lost;
>=20
> 	sb =3D ac->ac_sb;
> 	sbi =3D EXT4_SB(sb);
> @@ -2341,22 +2342,24 @@ static int ext4_mb_good_group_nolock(struct =
ext4_allocation_context *ac,
> 		 * We've been searching too long. Let's try to allocate
> 		 * the best chunk we've found so far
> 		 */
> -
> 		ext4_mb_try_best_found(ac, &e4b);
> 		if (ac->ac_status !=3D AC_STATUS_FOUND) {
> 			/*
> 			 * Someone more lucky has already allocated it.
> 			 * The only thing we can do is just take first
> 			 * found block(s)
> -			printk(KERN_DEBUG "EXT4-fs: someone won our =
chunk\n");
> 			 */
> +			lost =3D (unsigned =
int)atomic_inc_return(&sbi->s_mb_lost_chunks);

(minor) no need for a typecast here?  The return type is already "int", =
so it
would be better to declare "int lost" and that would make the line a bit =
shorter.

> +			mb_debug(sb, "lost chunk, group: %u, start: %d, =
len: %d, lost: %u\n",
> +				 ac->ac_b_ex.fe_group, =
ac->ac_b_ex.fe_start,
> +				 ac->ac_b_ex.fe_len, lost);
> +
> 			ac->ac_b_ex.fe_group =3D 0;
> 			ac->ac_b_ex.fe_start =3D 0;
> 			ac->ac_b_ex.fe_len =3D 0;
> 			ac->ac_status =3D AC_STATUS_CONTINUE;
> 			ac->ac_flags |=3D EXT4_MB_HINT_FIRST;
> 			cr =3D 3;
> -			atomic_inc(&sbi->s_mb_lost_chunks);
> 			goto repeat;
> 		}
> 	}
> --
> 1.8.3.1
>=20
>=20


Cheers, Andreas






--Apple-Mail=_9FCB3B88-2ECB-4C67-B99E-38E1C230EAC9
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl84WAgACgkQcqXauRfM
H+BITw/+Ms4i7PeIgGlwTyyQyaLNjPiNAgcqBWnCTYL3syI9QIRMV8hbtgAWnUvJ
QRuEbYuKiCs5w5zJWdzcxDWEC1nPO2IQOLfh7H+pjVWb3L+Fhi+Fj4i22yTIKLkd
WReEU1iLxP1sErnK6ULYqE0PDGt2FfxR2rkb/XZkVp0wg5JzHwu7axryIymAl2Dz
nORKu/jA9YDy3JvNtzQy7s0TZYWYEl8WyTEpmGSkt6LvbIHkELVAO/oo5aOAZ/2l
3oz56edmAm9ivzR18MPm1KFzUnejBP/hQHwemVzoJjfZVzNsq4psx5INJyCpTTFc
mwp1xuli72Tkqe4PJGxmWGv06ruN6zL+etkPqfVS9tn0WottMc4B47avikw1xSpD
KbSGHv0sskyV0tyeAEXmf57mDJ8f6QtthPo06G3nlgK2rWM3bSivoDYerWVd4EkI
MjXxexiMCdQaKAGWHUJS+QMrnEbhnxfka3Ojho3mbqih/O27uzW/4Hi9qpQA98ae
F8ngMJo3HO3PBKU3XGRvk5WPHEyIWhmBThCVv14Z2nnnhrueCuP5XpSRqUNfsLvW
DixZ4vsmfPNRR5FR8TxkJQFbVtvocvfC0OXQxLMSX/05mv3sFMb1rRk43O0JZ6/U
l3l4iJ0IX074GKRlj+O20ckGeyx01ruzA7Zc+WQJaqknKLyMFOY=
=y6Q8
-----END PGP SIGNATURE-----

--Apple-Mail=_9FCB3B88-2ECB-4C67-B99E-38E1C230EAC9--
