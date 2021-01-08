Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368F32EEB43
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Jan 2021 03:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbhAHC04 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Jan 2021 21:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbhAHC0z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Jan 2021 21:26:55 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75414C0612F5
        for <linux-ext4@vger.kernel.org>; Thu,  7 Jan 2021 18:26:15 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id b8so4914478plx.0
        for <linux-ext4@vger.kernel.org>; Thu, 07 Jan 2021 18:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=luDdg7XXyDwvXnZdD6ygdGvp+3kTJU9lQeguNQTRpqU=;
        b=yp1ETCZQTCsO1E6aEVnIIPr71KsyUtIol1gvDChcfdldWH9z/jo3rzKoGhiPLLNjUJ
         drJ8q57u8m+bH5ZaBWkRJT3qP6uwdarhDXb5bvFbPjJEdT6Ceg+m8nZ6huO6yOd6SIJc
         /Cz2grG2gZZ9fE+Y8dAh2WBfyyamOpQkvVqcjXvnwGIiWC5Iujf5lX+iYj7g0UIyP3oF
         UwZmJbzmZ7FdGtlIrlcR97wpXzdGtU9ng5yihyuUquYTFXfdyY0vXpuiin3QK8nNepLn
         gA4YqUaHjOm8JbmrJDSN+YgwHDSNdk6O1Jz3v3v11Oi0NSHwSaKPzJqGCFjz0rxp5U9O
         l1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=luDdg7XXyDwvXnZdD6ygdGvp+3kTJU9lQeguNQTRpqU=;
        b=IR1sJ+Z96iJx3tCIvO3S4nPXoibfmqIG/X0m2Pk3WtjwCcY05p5skGcH5PWOXw0zSv
         CSoHmX9sCPRp2O2UjwnXYm5bjPyw+Mkm8+ZoU2u+qdFk1aRMNt8kRQvScirAopxl7rz/
         fWNMY7kAq8y4bi/E+wheb4f5fhDYgVNGOkj+qm/69LUuc0BNeLEKc8BU99Jvb8t9GyPl
         MrL1yHXITvwyE9U1VsLb3n9lihnPuj/qKrMFGZGH1CiuTlDvEP8RdzwpOqgn0xgzeCpa
         ajYUuWGZ4emVlBrp+yddCl2mCu32uEzj1I6tt9HAYx9c6jzTOk0mfXnlw2O5JKy9mkB5
         fb/A==
X-Gm-Message-State: AOAM5301mE5xj1fvKOj6I59dllxjfZj95X9wwuMa1sJCzt/RU3lvM1/D
        JM+i71jn0Wd7DCf5rrSr4ePuEg==
X-Google-Smtp-Source: ABdhPJxoy0OOAPYHD0E0wy/5EXKLXB/liUsySyu/vCSGyL99vHHJSYSWHPe/9yXbvOlSKRR8miLFNg==
X-Received: by 2002:a17:90a:a24:: with SMTP id o33mr1373554pjo.191.1610072774908;
        Thu, 07 Jan 2021 18:26:14 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id x1sm6756810pfc.112.2021.01.07.18.26.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jan 2021 18:26:14 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <8A3C241B-9536-447B-B22D-F922D64731C7@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_336CE80D-E491-4ADD-ADCD-5E4DA97ECF62";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: Remove expensive flush on fast commit
Date:   Thu, 7 Jan 2021 19:26:11 -0700
In-Reply-To: <CAD+ocbyp+SOzpDDYsJVpd+t+UcjanZRtR85dHLgykLdURhV5wA@mail.gmail.com>
Cc:     "tytso@mit.edu" <tytso@mit.edu>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To:     daejun7.park@samsung.com,
        harshad shirwadkar <harshadshirwadkar@gmail.com>
References: <CGME20210106013242epcms2p5b6b4ed8ca86f29456fdf56aa580e74b4@epcms2p5>
 <20210106013242epcms2p5b6b4ed8ca86f29456fdf56aa580e74b4@epcms2p5>
 <CAD+ocbyp+SOzpDDYsJVpd+t+UcjanZRtR85dHLgykLdURhV5wA@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_336CE80D-E491-4ADD-ADCD-5E4DA97ECF62
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Tue, Jan 5, 2021 at 5:32 PM Daejun Park <daejun7.park@samsung.com> =
wrote:
>=20
> In the fast commit, it adds REQ_FUA and REQ_PREFLUSH on each fast =
commit
> block when barrier is enabled. However, in recovery phase, ext4 =
compares
> CRC value in the tail. So it is sufficient adds REQ_FUA and =
REQ_PREFLUSH
> on the block that has tail.

Does the tail block *always* contain a CRC, or is that dependent on
EXT4_FEATURE_RO_COMPAT_METADATA_CSUM, JBD2_FEATURE_INCOMPAT_CSUM_V2,
or JBD2_FEATURE_INCOMPAT_CSUM_V3 being enabled?

If one of those features is *required* before the FAST_COMMIT feature
can be used, then this patch looks OK.  Otherwise, the CSUM feature
should be checked before the FUA is skipped for non-tail blocks.

Cheers, Andreas

> Signed-off-by: Daejun Park <daejun7.park@samsung.com>
> ---
> fs/ext4/fast_commit.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 4fcc21c25e79..e66507be334c 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -604,13 +604,13 @@ void ext4_fc_track_range(handle_t *handle, =
struct inode *inode, ext4_lblk_t star
>        trace_ext4_fc_track_range(inode, start, end, ret);
> }
>=20
> -static void ext4_fc_submit_bh(struct super_block *sb)
> +static void ext4_fc_submit_bh(struct super_block *sb, bool is_tail)
> {
>        int write_flags =3D REQ_SYNC;
>        struct buffer_head *bh =3D EXT4_SB(sb)->s_fc_bh;
>=20
> -       /* TODO: REQ_FUA | REQ_PREFLUSH is unnecessarily expensive. */
> -       if (test_opt(sb, BARRIER))
> +       /* Add REQ_FUA | REQ_PREFLUSH only its tail */
> +       if (test_opt(sb, BARRIER) && is_tail)
>                write_flags |=3D REQ_FUA | REQ_PREFLUSH;
>        lock_buffer(bh);
>        set_buffer_dirty(bh);
> @@ -684,7 +684,7 @@ static u8 *ext4_fc_reserve_space(struct =
super_block *sb, int len, u32 *crc)
>                *crc =3D ext4_chksum(sbi, *crc, tl, sizeof(*tl));
>        if (pad_len > 0)
>                ext4_fc_memzero(sb, tl + 1, pad_len, crc);
> -       ext4_fc_submit_bh(sb);
> +       ext4_fc_submit_bh(sb, false);
>=20
>        ret =3D jbd2_fc_get_buf(EXT4_SB(sb)->s_journal, &bh);
>        if (ret)
> @@ -741,7 +741,7 @@ static int ext4_fc_write_tail(struct super_block =
*sb, u32 crc)
>        tail.fc_crc =3D cpu_to_le32(crc);
>        ext4_fc_memcpy(sb, dst, &tail.fc_crc, sizeof(tail.fc_crc), =
NULL);
>=20
> -       ext4_fc_submit_bh(sb);
> +       ext4_fc_submit_bh(sb, true);
>=20
>        return 0;
> }
> --
> 2.25.1


Cheers, Andreas






--Apple-Mail=_336CE80D-E491-4ADD-ADCD-5E4DA97ECF62
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl/3wsMACgkQcqXauRfM
H+Bvsg//Y5fdGY7LiAoLcJ27WC3ILhpqMd8TaA06bove8p8+rlCQFFYDXC7lUWKE
BagTLsNKzvFSB5EeuO2lXb2uWdCGb+eS5mkfGmUQDljBS/Ls7QHJlxFKjAnOmsK0
bboRfDWGxDwj9kSUCbkRHYwxJOAPTBbDfYkcB1uc1wzACWH8lTy5conL18WAQECS
PGxvFduSxRdyoSGueD7TPOsWEZQcZA0LPkVEYTgRufwJYhGwtTKYPt0fBq5n1beo
WC8EtKPdudEE3jD+S1THuDrhnxmekZZu2h/JCtDa15N396qQt1HzPJ7AAdSgLIxk
v+ltaC3K9g+zok4Yxokhq3kdghe/3/Wp5CCrp+vTx/ywmlZc31nfpxdqJi5HPSyK
zNGTdUEeaMh9aJpeLwpDUtMSbrBHMR5A/Yy2vKMheyvEZQ1dR5NjFj3wPoWUSZAA
G6pCRoB8UQNPPNQztquAhNEEp4LXVfdufTgg3GhsU7Ye6qDpQy15z2Dwxce4LGyW
XzO31lrX5pYJgplYVfplNgdFwDx7APGFOOlpY9P4Kix/GQLgmrKkP8dSGCvq8/Vc
LTr3a+1QAvUKWRL03vZv6knGRUNJ9vTJkW/TxbTBR6cq8xQx9ZhF4RVloxm/iMsH
+Ij8RM+7RNmEYDUGsQCMsahr+LwdlzkiKzY1QDcK7nDaR+CcV/I=
=d8v7
-----END PGP SIGNATURE-----

--Apple-Mail=_336CE80D-E491-4ADD-ADCD-5E4DA97ECF62--
