Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2922325C6
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Jul 2020 22:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgG2UC7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Jul 2020 16:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgG2UC6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Jul 2020 16:02:58 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3195C061794
        for <linux-ext4@vger.kernel.org>; Wed, 29 Jul 2020 13:02:58 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k4so12387833pld.12
        for <linux-ext4@vger.kernel.org>; Wed, 29 Jul 2020 13:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=sBuctEYl60t5X4wYqbcbP3/raJJwR1f2w2UesCM/YGw=;
        b=NI+wmA5j2RXLvFp7AB5BHRWULg3ULgx4aEOIxqCob/aQjEYgtEjVUhIIuIgdDgctNy
         UKj8RJZnBpbgxK4s5ON8Pw4C/RzNo9+1oe1dHl8m/i+rNd+UGVfmf0gachnnxnFfJJpL
         buCgLU0Id8AaYiI5wxwkhR53zK5Ir795r8FgMo+fgE60DpTnesPUDS0ey3Tecm7X+zDX
         Wequrq+GLkEmxsy70Yvm8Eo9bvc85P16wNzPD1JwgHevG6qfWB4umQUmweBwHYT72OpY
         gGtqV+qFAzgQzLM5aK433isf8YkOAxIyejl/iQMbPdousZ2pWFbUEB0gQ5tN1BVBZjkq
         0rhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=sBuctEYl60t5X4wYqbcbP3/raJJwR1f2w2UesCM/YGw=;
        b=g4dMA74YKUnjzZGaAVqxV5SEz6rzydNoDhPVVH4UVtAM7CE5TxnW/dqyg3B68XgwLt
         tMmh4rPf8xUs8vVncbMRbV2z6xhTmMLrvNUOBw0s6R04MG77DeLzzZBtWHQU8XZcEgz0
         R6KW97PPhCHYLqkgUcwEuQYSrePkDGB4G9DtB2DtXilKLxLuUOzNkb/e/sQv0V5LR0o2
         2PCWAY+iPF38az1alB63Gbe63NU1RUecxHPCTFQxSTZ6yKYNG5HqmvxxlEdm4IXDH5Wb
         RZQu7KiiSX6Fj+v4HvTxeSX6Hwtgt1ef1/4rJkyp93VgIrpEKv480JTh5Jyn2mLomAcP
         IMqA==
X-Gm-Message-State: AOAM530k3s3OHwSMHW4o4W0a0dh5LMRsRhWWDAu7T3Y5vLdDQfzTrbTN
        nZgUMzR3Ry7Hh+d7D5HLK7xl65CI8Q4=
X-Google-Smtp-Source: ABdhPJxE6MkStpwUfSQvzR9MRMlB+oBMtyEyd6rF1llNDt0+RMv+R8yOcAiYlQSepZBvq51zMRr51Q==
X-Received: by 2002:a17:90a:8d12:: with SMTP id c18mr146428pjo.222.1596052978212;
        Wed, 29 Jul 2020 13:02:58 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id nk22sm3035098pjb.51.2020.07.29.13.02.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jul 2020 13:02:57 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <F4F2A1EB-7AD0-42E3-A1AE-AA78B0B46FB7@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_DB93FEE7-0BE2-4D2E-AB0D-E52FEE6A7DBF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/2] ext4: rename journal_dev to s_journal_dev inside
 ext4_sb_info
Date:   Wed, 29 Jul 2020 14:02:46 -0600
In-Reply-To: <74c2a122-5a6c-ac97-614a-043038d61623@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     brookxu <brookxu.cn@gmail.com>
References: <74c2a122-5a6c-ac97-614a-043038d61623@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_DB93FEE7-0BE2-4D2E-AB0D-E52FEE6A7DBF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jul 29, 2020, at 12:19 AM, brookxu <brookxu.cn@gmail.com> wrote:
>=20
> Rename journal_dev to s_journal_dev inside ext4_sb_info, keep
> the naming rules consistent with other variables, which is
> convenient for code reading and writing.
>=20
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

I'm generally in favour of cleanups like this for consistency.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
>  fs/ext4/ext4.h  |  2 +-
>  fs/ext4/fsmap.c |  8 ++++----
>  fs/ext4/super.c | 14 +++++++-------
>  3 files changed, 12 insertions(+), 12 deletions(-)
>=20
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 68e0ebe..8ca9adf 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1463,7 +1463,7 @@ struct ext4_sb_info {
>      unsigned long s_commit_interval;
>      u32 s_max_batch_time;
>      u32 s_min_batch_time;
> -    struct block_device *journal_bdev;
> +    struct block_device *s_journal_bdev;
>  #ifdef CONFIG_QUOTA
>      /* Names of quota files with journalled quota */
>      char __rcu *s_qf_names[EXT4_MAXQUOTAS];
> diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
> index dbccf46..005c0ae 100644
> --- a/fs/ext4/fsmap.c
> +++ b/fs/ext4/fsmap.c
> @@ -571,8 +571,8 @@ static bool ext4_getfsmap_is_valid_device(struct =
super_block *sb,
>      if (fm->fmr_device =3D=3D 0 || fm->fmr_device =3D=3D UINT_MAX ||
>          fm->fmr_device =3D=3D new_encode_dev(sb->s_bdev->bd_dev))
>          return true;
> -    if (EXT4_SB(sb)->journal_bdev &&
> -        fm->fmr_device =3D=3D =
new_encode_dev(EXT4_SB(sb)->journal_bdev->bd_dev))
> +    if (EXT4_SB(sb)->s_journal_bdev &&
> +        fm->fmr_device =3D=3D =
new_encode_dev(EXT4_SB(sb)->s_journal_bdev->bd_dev))
>          return true;
>      return false;
>  }
> @@ -642,9 +642,9 @@ int ext4_getfsmap(struct super_block *sb, struct =
ext4_fsmap_head *head,
>      memset(handlers, 0, sizeof(handlers));
>      handlers[0].gfd_dev =3D new_encode_dev(sb->s_bdev->bd_dev);
>      handlers[0].gfd_fn =3D ext4_getfsmap_datadev;
> -    if (EXT4_SB(sb)->journal_bdev) {
> +    if (EXT4_SB(sb)->s_journal_bdev) {
>          handlers[1].gfd_dev =3D new_encode_dev(
> -                EXT4_SB(sb)->journal_bdev->bd_dev);
> +                EXT4_SB(sb)->s_journal_bdev->bd_dev);
>          handlers[1].gfd_fn =3D ext4_getfsmap_logdev;
>      }
>=20
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 8ce61f3..f785aee7 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -935,10 +935,10 @@ static void ext4_blkdev_put(struct block_device =
*bdev)
>  static void ext4_blkdev_remove(struct ext4_sb_info *sbi)
>  {
>      struct block_device *bdev;
> -    bdev =3D sbi->journal_bdev;
> +    bdev =3D sbi->s_journal_bdev;
>      if (bdev) {
>          ext4_blkdev_put(bdev);
> -        sbi->journal_bdev =3D NULL;
> +        sbi->s_journal_bdev =3D NULL;
>      }
>  }
>=20
> @@ -1069,14 +1069,14 @@ static void ext4_put_super(struct super_block =
*sb)
>=20
>      sync_blockdev(sb->s_bdev);
>      invalidate_bdev(sb->s_bdev);
> -    if (sbi->journal_bdev && sbi->journal_bdev !=3D sb->s_bdev) {
> +    if (sbi->s_journal_bdev && sbi->s_journal_bdev !=3D sb->s_bdev) {
>          /*
>           * Invalidate the journal device's buffers.  We don't want =
them
>           * floating about in memory - the physical journal device may
>           * hotswapped, and it breaks the `ro-after' testing code.
>           */
> -        sync_blockdev(sbi->journal_bdev);
> -        invalidate_bdev(sbi->journal_bdev);
> +        sync_blockdev(sbi->s_journal_bdev);
> +        invalidate_bdev(sbi->s_journal_bdev);
>          ext4_blkdev_remove(sbi);
>      }
>=20
> @@ -3712,7 +3712,7 @@ int ext4_calculate_overhead(struct super_block =
*sb)
>       * Add the internal journal blocks whether the journal has been
>       * loaded or not
>       */
> -    if (sbi->s_journal && !sbi->journal_bdev)
> +    if (sbi->s_journal && !sbi->s_journal_bdev)
>          overhead +=3D EXT4_NUM_B2C(sbi, sbi->s_journal->j_maxlen);
>      else if (ext4_has_feature_journal(sb) && !sbi->s_journal && =
j_inum) {
>          /* j_inum for internal journal is non-zero */
> @@ -5057,7 +5057,7 @@ static journal_t *ext4_get_dev_journal(struct =
super_block *sb,
>              be32_to_cpu(journal->j_superblock->s_nr_users));
>          goto out_journal;
>      }
> -    EXT4_SB(sb)->journal_bdev =3D bdev;
> +    EXT4_SB(sb)->s_journal_bdev =3D bdev;
>      ext4_init_journal_params(sb, journal);
>      return journal;
>=20
> --
> 1.8.3.1
>=20


Cheers, Andreas






--Apple-Mail=_DB93FEE7-0BE2-4D2E-AB0D-E52FEE6A7DBF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl8h1ecACgkQcqXauRfM
H+CQXhAAmI4GYSkzaRpjjFKQXrtOlW1y9KBQJlfVe4BR5Ia9aOQk8uWuB86Jh38L
D8P1aZLExnrMKukB2QnjLHYq/vqs4VonEQoXosCzNVxn3Pn5kgyul9KyQ+YPUuMg
8HJkJW+JcEXTefNVpYn0LH/eac8wn8U/8zQZX1Xrfbh3vqiHzjzgWl+tCsA8H5nn
hIkix9kG4KMJ0+9uq828iRZWxGE6zlylz/0DBRqut2ZPM+3cOKTSMFzHpcaTdFE1
xSv6wOQLoA4MkAlAMZZMwvwCoWOXifhD6DA2ig8ODatgWutmimuK8hLDBPIh+Lgm
JcofIRWhs2oThG5JMG+tMFBzJuDbrJU4Mwvmx6WLEVWbZPLRX91FiqVByKzuFBjx
hMDrspRULoHAOZhBqeoEjEZ0aFEHHFvgjur9b47WSb1uISDKiIY4B2Van2doy2D8
nijZjnhChxP1OGsAwkikedHalAADWN0IFFvhldjctj91JAOR5hSGT5E3QvzXJakr
tizKqOjYpIdXKVCLCfSu7rCfXOgCs3wi9hBriOBl9wg2IkkkAAFkuM6xjduo8d18
3VwZl932iuY4GMQX2IMubX7ursAx/kuynfVeGMvHIf6XTLGKvdorbNXq0kv3v6iQ
L3HRjcx7Amcx5oD0y1D2B1Ik98zauuuEhou6zoiRZBUpTilZcn4=
=QlSq
-----END PGP SIGNATURE-----

--Apple-Mail=_DB93FEE7-0BE2-4D2E-AB0D-E52FEE6A7DBF--
