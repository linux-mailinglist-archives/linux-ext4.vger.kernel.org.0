Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B852325C7
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Jul 2020 22:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgG2UD0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Jul 2020 16:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2UDZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Jul 2020 16:03:25 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DD9C061794
        for <linux-ext4@vger.kernel.org>; Wed, 29 Jul 2020 13:03:25 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ha11so2717738pjb.1
        for <linux-ext4@vger.kernel.org>; Wed, 29 Jul 2020 13:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=utvlBvW269AzAi7LIG4uo8SfygHmdhvlAapvComi/ts=;
        b=W5GWskFRi9CxnAjJggPCPEWK0nDM5O1QSgN4+rukP04u73pH6tB+/MNWWQMPQsjGnb
         nOQg44nDh/BMIlOunxXTq1aY1GVRvL+AsP/roFCdMQQHEjUmx+qA1dOOttY4juWFnvu5
         NIDAcxoAVYFSBMSvvNAS/DcdKDz1kvePcC2b4nmn9LBY8lXf7PcplUnqfyDjcFNOqzXz
         avwK930l/Sa6Mu6nSMJZPmEl4qhPffdDObUG8zb/w7LsD3XC5uybIeyMaTBH6zZM5l/W
         9T+U7yzTWYMVK972mdUUHBeHT18QjHzBF/3ecrsFavrf2owmQRj+eOtJGFh2x5/rL94b
         LF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=utvlBvW269AzAi7LIG4uo8SfygHmdhvlAapvComi/ts=;
        b=UkYnBiqdB0b4CCynk5nJEjsMAYk3MlfC/8QugkPGM2Hd2SD7iXW5mfVJMeh2HIw0FV
         8cM4F13hism+9XxyTufl3VO5H6kaNntyH3LnQFLaXXXKR2fmTDhqsIxzLvknJXREj/u+
         +wFaJVt5D03cBh2k3ZFqQRrl5iRobX/a1VizrnaGcS5VNvZVIp1l9/XXK3SvbjEPkrv8
         RFWXWqmFwIrkHAufcTG5kGEwQqpQ0nQ9jdjzRs3QfPJ3dC3hxCZPXqoMJkOAIinMbohp
         G/yfjLqjB0crsoA3L057jeB9+LSky3bglEb9ERUQnLAkc9d1Bt6lqTXYR5wNwKwoogtq
         RJUA==
X-Gm-Message-State: AOAM532hW9wJTzr2NKstwjgv+GYgTPFGh6Jc3IQL1lIwwIpcedaA2swW
        dIjIxYnnwMMj6sdxF10AAZNG/A==
X-Google-Smtp-Source: ABdhPJzuonPcIKu+AIAE56abl1An0nooF+okyLrIiREWIvDPyNQ6LfvDo/T08sWe1FSqW9roPcpXdg==
X-Received: by 2002:a17:902:8f83:: with SMTP id z3mr27332119plo.162.1596053005217;
        Wed, 29 Jul 2020 13:03:25 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id nk22sm3035098pjb.51.2020.07.29.13.03.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jul 2020 13:03:24 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <16D764F3-A1C9-4CFB-9151-19562FCA2064@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_3F55AF71-66B1-4128-BD97-5CD3AEE20469";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/2] ext4: rename system_blks to s_system_blks inside
 ext4_sb_info
Date:   Wed, 29 Jul 2020 14:03:23 -0600
In-Reply-To: <6af737ee-e16f-9d2b-5045-fb5b8995a6d6@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     brookxu <brookxu.cn@gmail.com>
References: <6af737ee-e16f-9d2b-5045-fb5b8995a6d6@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_3F55AF71-66B1-4128-BD97-5CD3AEE20469
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jul 29, 2020, at 12:19 AM, brookxu <brookxu.cn@gmail.com> wrote:
>=20
> Rename system_blks to s_system_blks inside ext4_sb_info, keep
> the naming rules consistent with other variables, which is
> convenient for code reading and writing.
>=20
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
>  fs/ext4/block_validity.c | 14 +++++++-------
>  fs/ext4/ext4.h           |  2 +-
>  2 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
> index 16e9b2f..69240b4 100644
> --- a/fs/ext4/block_validity.c
> +++ b/fs/ext4/block_validity.c
> @@ -138,7 +138,7 @@ static void debug_print_tree(struct ext4_sb_info =
*sbi)
>=20
>      printk(KERN_INFO "System zones: ");
>      rcu_read_lock();
> -    system_blks =3D rcu_dereference(sbi->system_blks);
> +    system_blks =3D rcu_dereference(sbi->s_system_blks);
>      node =3D rb_first(&system_blks->root);
>      while (node) {
>          entry =3D rb_entry(node, struct ext4_system_zone, node);
> @@ -263,11 +263,11 @@ int ext4_setup_system_zone(struct super_block =
*sb)
>      int ret;
>=20
>      if (!test_opt(sb, BLOCK_VALIDITY)) {
> -        if (sbi->system_blks)
> +        if (sbi->s_system_blks)
>              ext4_release_system_zone(sb);
>          return 0;
>      }
> -    if (sbi->system_blks)
> +    if (sbi->s_system_blks)
>          return 0;
>=20
>      system_blks =3D kzalloc(sizeof(*system_blks), GFP_KERNEL);
> @@ -308,7 +308,7 @@ int ext4_setup_system_zone(struct super_block *sb)
>       * with ext4_data_block_valid() accessing the rbtree at the same
>       * time.
>       */
> -    rcu_assign_pointer(sbi->system_blks, system_blks);
> +    rcu_assign_pointer(sbi->s_system_blks, system_blks);
>=20
>      if (test_opt(sb, DEBUG))
>          debug_print_tree(sbi);
> @@ -333,9 +333,9 @@ void ext4_release_system_zone(struct super_block =
*sb)
>  {
>      struct ext4_system_blocks *system_blks;
>=20
> -    system_blks =3D =
rcu_dereference_protected(EXT4_SB(sb)->system_blks,
> +    system_blks =3D =
rcu_dereference_protected(EXT4_SB(sb)->s_system_blks,
>                      lockdep_is_held(&sb->s_umount));
> -    rcu_assign_pointer(EXT4_SB(sb)->system_blks, NULL);
> +    rcu_assign_pointer(EXT4_SB(sb)->s_system_blks, NULL);
>=20
>      if (system_blks)
>          call_rcu(&system_blks->rcu, ext4_destroy_system_zone);
> @@ -353,7 +353,7 @@ int ext4_data_block_valid(struct ext4_sb_info =
*sbi, ext4_fsblk_t start_blk,
>       * mount option.
>       */
>      rcu_read_lock();
> -    system_blks =3D rcu_dereference(sbi->system_blks);
> +    system_blks =3D rcu_dereference(sbi->s_system_blks);
>      ret =3D ext4_data_block_valid_rcu(sbi, system_blks, start_blk,
>                      count);
>      rcu_read_unlock();
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 8ca9adf..d60a462 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1470,7 +1470,7 @@ struct ext4_sb_info {
>      int s_jquota_fmt;            /* Format of quota to use */
>  #endif
>      unsigned int s_want_extra_isize; /* New inodes should reserve # =
bytes */
> -    struct ext4_system_blocks __rcu *system_blks;
> +    struct ext4_system_blocks __rcu *s_system_blks;
>=20
>  #ifdef EXTENTS_STATS
>      /* ext4 extents stats */
> --
> 1.8.3.1
>=20


Cheers, Andreas






--Apple-Mail=_3F55AF71-66B1-4128-BD97-5CD3AEE20469
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl8h1gsACgkQcqXauRfM
H+CvFg//Vi2damzegj7lADd0q4Tp4HczZx/6GNtDoNsMK9Rqo6723K15cnhXkdZt
8fpkk7Ayb5Vn+A6VLnRmN/KzmsPmUL5hAVg17zMC1qsz9PV18ypTFb8qxKhL8gBC
sgtrfbyJcbAar0YZQbuePCSP7KboUHrDJwWyCUyvBOrCzhR3Fg2EXz6gyRjKeuK4
8VHi4yEXhM5BTYATOfjyVQq2vZe4h6IVyb1M5h4ST8isf10v3BC/PpyGQ16Z1AbJ
Fl6DlYQtZeRebuKsPx39d1R2kimReyIjsh9DeW7l3LHcU7HlKLmNebsQclwoZNGu
WjfHzmTnLPUeOn9BVfx0FqsM/CNIuuxXJrBZHjxwXnaqL9WJ+ognsMgFwtTwC6qG
a5MZeFuEGRqBdevLIlsTxYGDKbB2ayYgMysP47meNAaI7NT3hQMGLeCPvtiSrEMG
rAYtn+ZyNeAIWJS1CrJL8JePKAwSM4J4WEYwHvztRC2XPLw4/473m6OncftlALyN
yJ2au5MuTznYuRNeM0OPFSYS2B+tXJIJ787+mDg9fExtGW2WbZ7PV8/xlcdiqamW
v0Xo8UPfatLIozu77d/S8dOdIfSVS1/Gphbnr2lv69bNB4/nIQ6v6DVstCY+Ohjt
DwUN8O3mw5gIWmskBqcWuBzAzUxxKrk2PNaLFxfbCYztRRM48gU=
=g/25
-----END PGP SIGNATURE-----

--Apple-Mail=_3F55AF71-66B1-4128-BD97-5CD3AEE20469--
