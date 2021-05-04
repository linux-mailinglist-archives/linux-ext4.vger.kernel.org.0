Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3837A3725D2
	for <lists+linux-ext4@lfdr.de>; Tue,  4 May 2021 08:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhEDGaU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 May 2021 02:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhEDGaU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 May 2021 02:30:20 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7537C061574
        for <linux-ext4@vger.kernel.org>; Mon,  3 May 2021 23:29:25 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 10so6458717pfl.1
        for <linux-ext4@vger.kernel.org>; Mon, 03 May 2021 23:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=LPP+kOQDtuHvfxXy2Umkuvpta6rGax0pfm4Sn1j2xBE=;
        b=HlxjFHy7uqOscGTT0RgydPxBzdmwrOz7xBsZZgSuhXNm6kdzbGPmtyNIPCrHjCXCNJ
         YdxiGBgMC6oNOkNg53x8xzQdKY23x6Yu4aYzlVV7lE6v57sCCeOrb83vImjptIY04mzw
         7beV8MaP4idId06pcROEJtQD8vFo0/zHT66KS3N1kz7ctMTBYteogJI9FRDf/vMGYqls
         fzh+OGndfMrclDluXzhA909okiMCEZFdRQ0VxMM8fvS7LcKAfdlBDiSqnuQVAkXkGUg9
         G8VmFxzdBl6vfJm/ShQxFCO8avzQa7iiFdbFduViAofOMlUPCVTecs80fUXMTmb1oaNd
         KTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=LPP+kOQDtuHvfxXy2Umkuvpta6rGax0pfm4Sn1j2xBE=;
        b=HqHQkbjP/SpZv8mmA0wyFVVz6O+WLM/eXZ+9K20FgymwQjTxXvkbOrPLWhkTR8osaS
         nCD0q8UogScXnB3KUtXAsO6uQAy4gCfUwSXu8PajCnJ1zqz+NHqMB5LZL9INQ1bZCnLt
         6C4fhir8lY8mfspRM9/8Ufp7yBdHrB8qMzzUXeI/Q2QqiKjBfFbIxrcztb6YqUbAFRIb
         brHDoAKcgpryMhRtQzIoX9b/mui/iw6KrwoI58t1fnulRCdt+TiHDT/C9nXULkztvuBk
         xQ7gFavFgAyhipkMktJc/87g4PrGKJKtDM/ie1LgIQKV/SdYSj6K5n1O0BxDSFWpTlZF
         lWCA==
X-Gm-Message-State: AOAM532aLawX/TmuH1+vhc5Jp6Tn+RIWK/ewA+Ga/EgGR77b5r6Z3iH6
        OtNB8Ph0OAwX92z8KJJVbDGSxw==
X-Google-Smtp-Source: ABdhPJzZQGYQmTHsIFmncm6HROnNZJabGpoUQEXj4cEDddaLfpxCFxdBCjxxKFM0nt2PZYfL1S59Qg==
X-Received: by 2002:a17:90a:17a2:: with SMTP id q31mr3236382pja.32.1620109765165;
        Mon, 03 May 2021 23:29:25 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id n25sm11001751pff.154.2021.05.03.23.29.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 May 2021 23:29:23 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <8E9C71E8-FE5F-4CB8-BA62-8D8895DCA92A@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_C284836E-6200-4499-87A3-D73A73A2E2E3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] e2fsck: fix portability problems caused by unaligned
 accesses
Date:   Tue, 4 May 2021 00:29:21 -0600
In-Reply-To: <20210504031024.3888676-1-tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        harshads@google.com
To:     Theodore Ts'o <tytso@mit.edu>
References: <20210504031024.3888676-1-tytso@mit.edu>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_C284836E-6200-4499-87A3-D73A73A2E2E3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On May 3, 2021, at 9:10 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> The on-disk format for the ext4 journal can have unaigned 32-bit
> integers.  This can happen when replaying a journal using a obsolete
> checksum format (which was never popularly used, since the v3 format
> replaced v2 while the metadata checksum feature was being stablized),
> and in the fast commit feature (which landed in the 5.10 kernel,
> although it is not enabled by default).
>=20
> This commit fixes the following regression tests on some platforms
> (such as running 32-bit arm architectures on a 64-bit arm kernel):
> j_recover_csum2_32bit, j_recover_csum2_64bit, j_recover_fast_commit.
>=20
> https://github.com/tytso/e2fsprogs/issues/65

Minor style comments inline.

> Addresses-Debian-Bug: #987641
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
> e2fsck/journal.c                   | 41 ++++++++++++++++++++---------
> e2fsck/recovery.c                  | 42 +++++++++++++++++++++++++-----
> tests/j_recover_fast_commit/script |  1 -
> 3 files changed, 65 insertions(+), 19 deletions(-)
>=20
> diff --git a/e2fsck/journal.c b/e2fsck/journal.c
> index a425bbd1..2231b811 100644
> --- a/e2fsck/journal.c
> +++ b/e2fsck/journal.c
> @@ -344,10 +361,10 @@ static int ext4_fc_replay_scan(journal_t *j, =
struct buffer_head *bh,
> 						offsetof(struct =
ext4_fc_tail,
> 						fc_crc));
> 			jbd_debug(1, "tail tid %d, expected %d\n",
> -					le32_to_cpu(tail->fc_tid),
> +					get_le32(&tail->fc_tid),
> 					expected_tid);
> -			if (le32_to_cpu(tail->fc_tid) =3D=3D =
expected_tid &&
> -				le32_to_cpu(tail->fc_crc) =3D=3D =
state->fc_crc) {
> +			if (get_le32(&tail->fc_tid) =3D=3D expected_tid =
&&
> +				get_le32(&tail->fc_crc) =3D=3D =
state->fc_crc) {

(style) better to align continued line after '(' on previous line?  That =
way
it can be distinguished from the next (body) line more easily

> 				state->fc_replay_num_tags =3D =
state->fc_cur_tag;
> 			} else {
> 				ret =3D state->fc_replay_num_tags ?
> @@ -357,12 +374,12 @@ static int ext4_fc_replay_scan(journal_t *j, =
struct buffer_head *bh,
> 			break;
> 		case EXT4_FC_TAG_HEAD:
> 			head =3D (struct ext4_fc_head =
*)ext4_fc_tag_val(tl);
> -			if (le32_to_cpu(head->fc_features) &
> +			if (get_le32(&head->fc_features) &
> 				~EXT4_FC_SUPPORTED_FEATURES) {

(style) same

> 				ret =3D -EOPNOTSUPP;
> 				break;
> 			}
> -			if (le32_to_cpu(head->fc_tid) !=3D expected_tid) =
{
> +			if (get_le32(&head->fc_tid) !=3D expected_tid) {
> 				ret =3D -EINVAL;
> 				break;
> 			}


Cheers, Andreas






--Apple-Mail=_C284836E-6200-4499-87A3-D73A73A2E2E3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmCQ6cEACgkQcqXauRfM
H+DqTBAAgSwr4v+zcY0REBQp1pMx1RXF0rKSggBCVlSwCSAPHQRvwoD/3JBhz3Rr
MZXXe5G8Wrwv1t+2ETORLYEhwcVfXIbabxJpo2Ud0sOaULh1gB6xf+H7kXrLhEKo
eva5aqmEBneMm+Vv0+I1u3mu8wYawcUr2kiBWkzWvhs7j6bnGsq6N4Bs40zdwQkO
G8aupbGCfnLJCRCsbqQ51mrZrDNdiGxiSpbB+QPtoCNt9MP1s079Xa09H9+XacDG
cECXxMDVcipBciqCvHe1V/7ID7MR0T+obimq4pD0M1aiwrfkPOuwJXZ0twQmAshX
1DPmjAXuvu0A9pYC9yM4VKOGAiZlDdBGe9oCjLD/0C2YXPs7AJJGE80wHUO8vYoH
lyHGJ4gh634fv34GrQpWw8/+FrRODEkXnY0uA5uiYWkLKK8UjchCS4kcf95FtvGO
gehqUdXaCG2Ohnuz5RPopyNj8XOBPDqmOFO4kCzzP7OdleLRka8A7oZvJLvoEhZJ
KEnrUQmCyRDBTeLlxsw1jqHSLobdVUritQCetSyFxsdb90BAy95s/+RAiCH4unC9
BCG4cu0RVoSLbIVdzOouZN5IdfQmE1QHA0ydudRZrtY3YLaPmP5Q2Bq9Nykn9f5Y
zj754XYNySMHQ6OY3CKAOun/tR6CEgwIfyW8Wxy2eNbZsr90eOs=
=4bdD
-----END PGP SIGNATURE-----

--Apple-Mail=_C284836E-6200-4499-87A3-D73A73A2E2E3--
