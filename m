Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6F034B273
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Mar 2021 00:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhCZXFb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 26 Mar 2021 19:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbhCZXFV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 26 Mar 2021 19:05:21 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DF1C0613AA
        for <linux-ext4@vger.kernel.org>; Fri, 26 Mar 2021 16:05:21 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 11so5837859pfn.9
        for <linux-ext4@vger.kernel.org>; Fri, 26 Mar 2021 16:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=7coS29yz2GD1ftmYqvzesh7nIr8132SkSRd/wZM49T0=;
        b=THvsebxKgL2S8gltzzudMx4zWt7RavVyjeT7D9ExAMubelXsKdhIS7y8D4kQ2WtPem
         +2cZy793enlYyvWzf8xRmhQs/GtMsZzEksHRXfvdmoL+wrM89m25lWeMFsd1LEhbs5yj
         /8aX4zUxQIqK6Ftfb8+vSH/eSLJ+6deJYFoDBdqJiHiSk7ZQLGRE/BycnXlTU65zzzyH
         OaRSMNnecFifWIdGupacXQmhbakjs+L9zccbjKVBmtT0iwZsL6HTxN6G0rvfKOf1bwtI
         mDJR1oUYUbuSR2nD8RX+DiUQ+2YOacEJsnfQ263emQsJjwvACAx42PQnkxR06369ynq7
         nF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=7coS29yz2GD1ftmYqvzesh7nIr8132SkSRd/wZM49T0=;
        b=eIbg0NAOqPngJ5FmeMgGoXB3c4GQKweHA9oAJXtT1nrxPL0rXFOE+PJ/vxD1ziftes
         T9b6ml6tTH+i+e+h07nBD3t8Kbh1UkIekXyxLLGeXJBiMVKLf4Vg2Ldd1kEmTtcJDJln
         PayrRn7L4va9k9FyN+cFabflInKMm0UtjIbmpxdkGhXbedaicwYqTGFjqze742zLeNyT
         vfprctgTcpg59Pk/jrAD/7axFMNNg5wZF9Py6eaG4lwJQIKX6qshmkhqDQMy8OuXv5NW
         c/oNval+A2KqVBQzvZx0lPANiwISl6gz5HcKzxjNwVVMMDx153XBzOlPlW4lw4RxR6hN
         2aYQ==
X-Gm-Message-State: AOAM533rsYo5QJBiL70kZQWmNDHdmHC3rPBJzKGK28fjufTbfzODZOiY
        lB/AR/C646MJKCemFq0moTE33g==
X-Google-Smtp-Source: ABdhPJwzZl9J9Zz75Q7VRcnms+8XAhYYsH9yNEIfVm9SeIlGsDw8OGlAFgbEeCU7dw28hbhswIB+8g==
X-Received: by 2002:a65:6a0c:: with SMTP id m12mr13993974pgu.161.1616799921161;
        Fri, 26 Mar 2021 16:05:21 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id t125sm9591813pgt.71.2021.03.26.16.05.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Mar 2021 16:05:20 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <A08FAD7B-899F-4B40-9881-2ACD45399471@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_CCF7291D-06B5-4958-B224-FDE3E7584013";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/2] ext4: wipe filename upon file deletion
Date:   Fri, 26 Mar 2021 17:05:16 -0600
In-Reply-To: <20210325181220.1118705-1-leah.rumancik@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
To:     Leah Rumancik <leah.rumancik@gmail.com>
References: <20210325181220.1118705-1-leah.rumancik@gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_CCF7291D-06B5-4958-B224-FDE3E7584013
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 25, 2021, at 12:12 PM, Leah Rumancik <leah.rumancik@gmail.com> =
wrote:
>=20
> Zero out filename field when file is deleted. Also, add mount option
> nowipe_filename to disable this filename wipeout if desired.

I would personally be against "wipe out entries on delete" as the =
default
behavior.  I think most users would prefer that their data is maximally
recoverable, rather than the minimal security benefit of erasing deleted
content by default.

I think that Darrick made a good point that using the EXT4_SECRM_FL on
the inode gives users a good option to enable/disable this on a per
file or directory basis.

> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> ---
> fs/ext4/ext4.h  |  1 +
> fs/ext4/namei.c |  4 ++++
> fs/ext4/super.c | 11 ++++++++++-
> 3 files changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 826a56e3bbd2..8011418176bc 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1247,6 +1247,7 @@ struct ext4_inode_info {
> #define EXT4_MOUNT2_JOURNAL_FAST_COMMIT	0x00000010 /* Journal =
fast commit */
> #define EXT4_MOUNT2_DAX_NEVER		0x00000020 /* Do not allow =
Direct Access */
> #define EXT4_MOUNT2_DAX_INODE		0x00000040 /* For printing =
options only */
> +#define EXT4_MOUNT2_WIPE_FILENAME       0x00000080 /* Wipe filename =
on del entry */
>=20
>=20
> #define clear_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt &=3D \
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 883e2a7cd4ab..ae6ecabd4d97 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -2492,6 +2492,10 @@ int ext4_generic_delete_entry(struct inode =
*dir,
> 			else
> 				de->inode =3D 0;
> 			inode_inc_iversion(dir);
> +
> +			if (test_opt2(dir->i_sb, WIPE_FILENAME))
> +				memset(de_del->name, 0, =
de_del->name_len);
> +
> 			return 0;
> 		}
> 		i +=3D ext4_rec_len_from_disk(de->rec_len, blocksize);
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index b9693680463a..5e8737b3f171 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1688,7 +1688,7 @@ enum {
> 	Opt_dioread_nolock, Opt_dioread_lock,
> 	Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
> 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
> -	Opt_prefetch_block_bitmaps,
> +	Opt_prefetch_block_bitmaps, Opt_nowipe_filename,
> #ifdef CONFIG_EXT4_DEBUG
> 	Opt_fc_debug_max_replay, Opt_fc_debug_force
> #endif
> @@ -1787,6 +1787,7 @@ static const match_table_t tokens =3D {
> 	{Opt_test_dummy_encryption, "test_dummy_encryption"},
> 	{Opt_inlinecrypt, "inlinecrypt"},
> 	{Opt_nombcache, "nombcache"},
> +	{Opt_nowipe_filename, "nowipe_filename"},
> 	{Opt_nombcache, "no_mbcache"},	/* for backward compatibility */
> 	{Opt_prefetch_block_bitmaps, "prefetch_block_bitmaps"},
> 	{Opt_removed, "check=3Dnone"},	/* mount option from ext2/3 */
> @@ -2007,6 +2008,8 @@ static const struct mount_opts {
> 	{Opt_max_dir_size_kb, 0, MOPT_GTE0},
> 	{Opt_test_dummy_encryption, 0, MOPT_STRING},
> 	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
> +	{Opt_nowipe_filename, EXT4_MOUNT2_WIPE_FILENAME, MOPT_CLEAR | =
MOPT_2 |
> +		MOPT_EXT4_ONLY},
> 	{Opt_prefetch_block_bitmaps, EXT4_MOUNT_PREFETCH_BLOCK_BITMAPS,
> 	 MOPT_SET},
> #ifdef CONFIG_EXT4_DEBUG
> @@ -2621,6 +2624,10 @@ static int _ext4_show_options(struct seq_file =
*seq, struct super_block *sb,
> 	} else if (test_opt2(sb, DAX_INODE)) {
> 		SEQ_OPTS_PUTS("dax=3Dinode");
> 	}
> +
> +	if (!test_opt2(sb, WIPE_FILENAME))
> +		SEQ_OPTS_PUTS("nowipe_filename");
> +
> 	ext4_show_quota_options(seq, sb);
> 	return 0;
> }
> @@ -4161,6 +4168,8 @@ static int ext4_fill_super(struct super_block =
*sb, void *data, int silent)
> 	if (def_mount_opts & EXT4_DEFM_DISCARD)
> 		set_opt(sb, DISCARD);
>=20
> +	set_opt2(sb, WIPE_FILENAME);
> +
> 	sbi->s_resuid =3D make_kuid(&init_user_ns, =
le16_to_cpu(es->s_def_resuid));
> 	sbi->s_resgid =3D make_kgid(&init_user_ns, =
le16_to_cpu(es->s_def_resgid));
> 	sbi->s_commit_interval =3D JBD2_DEFAULT_MAX_COMMIT_AGE * HZ;
> --
> 2.31.0.291.g576ba9dcdaf-goog
>=20


Cheers, Andreas






--Apple-Mail=_CCF7291D-06B5-4958-B224-FDE3E7584013
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmBeaKwACgkQcqXauRfM
H+D3PxAAnZLZTVDC4x476mfPsstd9H7pika+OjM6YrbnjjiKqQwxOmWzHSFUrGjN
xn0RJzwlo/5iqiLlTDMwQVvtSmvUont/7PMnSUIwsOELmdN07cpNvT0OOWXx44AC
6FFESxCRxg3f3uy3/3tzwlG0S1j6UTFqEHDR8NpfrhRp3nqf9bTMqJ7n+Y1hYAkJ
GltugyFdd9SpV3/B48MUDuEeAL4rb0S5zYjOJSWdJKnY6XszS/44QQeLvHXxJiQD
PeZttR8lHiZE6Ey7IEhWEUhcvsemgk3X1psu0LE4LTs/8I8YzD6C/2w+dxjXpk3R
NgiIUJuqa9x4hwjAe2Bt+Ht0DsyKNiZAutXIee81WjWP4iDSmA7c24REwxz5p22M
yzidkItx2wddYNm5u9tAfs+PbtlraHfBu3yMXEHlZHVo4VoN6mmABlTxam7SQvNs
CkqkBbsvX2Hzw7phW6gmd1eOuqLVyFkBMFdmVOsM8ZKzZLUgqTqz0hPvXbFe5NSI
ZHBDhQ/vsvr53c6yUvEKqXafDFAIXkHtmG0LgIul0UpL4xfHFuQ1QSH953kFwyhD
T7qSW/tDwlCr53PT0TLDeLVD9gkdGUHA2fS/++msSLTNBPwAUKn6hKfJBVJsbONY
WNA0HD5PepP2eQH6xETWPTJwk+6iODxJiuvHTyO8oSeFpRCTfYU=
=mZZP
-----END PGP SIGNATURE-----

--Apple-Mail=_CCF7291D-06B5-4958-B224-FDE3E7584013--
