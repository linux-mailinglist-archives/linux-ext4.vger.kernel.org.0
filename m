Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53930223A36
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jul 2020 13:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgGQLQQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jul 2020 07:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgGQLQP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Jul 2020 07:16:15 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF912C08C5C0
        for <linux-ext4@vger.kernel.org>; Fri, 17 Jul 2020 04:16:15 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t6so6533583pgq.1
        for <linux-ext4@vger.kernel.org>; Fri, 17 Jul 2020 04:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=OtZg4T+GCpdyfY9mz/JitAi1EGPg/FZHw3vueONGIFk=;
        b=JTq1mOhyUZCHfTTjAh11H4ZNm0yV6twMbvc1RslLAaDNtgMdIj8NODxnzhCC0Raqa8
         rsX2cbwbxIk6XHNgu0LfKroO2n52lpbXIJr5eQPKf67ef/yXyA5RNET3D5bnoiwIh7rk
         L8vlKjY4JlpnW1/DE9IZyvkv/iygFsSoeLXZ4DJD/HZSOR2n+4Zo7q9/h/Ml9fZT1sy7
         qftC4Ajm/ALhAvhn3NRMZJFaaASbOvN3vlArPwonJhLikk5FGs/iBqJjFXGYv7dKMA4x
         CFmsJDcJVOZs4utHf3Cmd9Buje3CyPmU0Z1bGDA7xtE0JOKVy130Y4n8WhWGIkJOBEkr
         pHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=OtZg4T+GCpdyfY9mz/JitAi1EGPg/FZHw3vueONGIFk=;
        b=afL8QE356SQjqpN9dO3OdfrjuTqqE6RWfnGcIh7dAx2rh/z/eZ6R6S19y0X+i1RcMo
         oXcM2EuNXhvme1QcOAlSseQgLPskSnydOMOatstmUYJNN7AtJpBbLxHuiIpk37DUiiEY
         XY/dWgG80DTZdwxO4Mx4prAo3vQQZglrX65/xr90cehgcY3rw4QE8Jpd2PtrPjIcBlhz
         +DXglEZ2Cm0FZXwOYAlQUU6MIBzuj5H8sx5+brNQNsorcMwaSm3m3hwaGmTjKBwiX8m6
         Z+RJNBgYLghcylRITvP94VHN76ZJctjzpaNCX5P5UqYpp+AcYCxlSjzcxsLT4B7wecDy
         5sWg==
X-Gm-Message-State: AOAM532vn0rvReVPyDgkKmW1/mKEd4Boh6UW64GaNT8JaJxI/RJo20Q1
        PCWvkjhSoPhtmaJnPNfxJySpOQ==
X-Google-Smtp-Source: ABdhPJwiuHTlY0L77cS6hm9RzbMx/qgMlkS1w9g3jtnvy0+a82DB9s18uhnYlMQkmQP7FkYBKgV23Q==
X-Received: by 2002:a62:6484:: with SMTP id y126mr8080251pfb.166.1594984575035;
        Fri, 17 Jul 2020 04:16:15 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id ia13sm2543935pjb.42.2020.07.17.04.16.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2020 04:16:14 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <188CB614-ADD9-4DE0-AC1A-0DD94043EC76@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_E31CCD68-5750-4BD5-B8EE-26E6F49BB229";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] ext4: handle read only external journal device
Date:   Fri, 17 Jul 2020 05:16:09 -0600
In-Reply-To: <20200717090605.2612-1-lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
To:     Lukas Czerner <lczerner@redhat.com>
References: <20200716183901.5016-1-lczerner@redhat.com>
 <20200717090605.2612-1-lczerner@redhat.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_E31CCD68-5750-4BD5-B8EE-26E6F49BB229
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jul 17, 2020, at 3:06 AM, Lukas Czerner <lczerner@redhat.com> wrote:
>=20
> Ext4 uses blkdev_get_by_dev() to get the block_device for journal =
device
> which does check to see if the read-only block device was opened
> read-only.
>=20
> As a result ext4 will hapily proceed mounting the file system with
> external journal on read-only device. This is bad as we would not be
> able to use the journal leading to errors later on.
>=20
> Instead of simply failing to mount file system in this case, treat it =
in
> a similar way we treat internal journal on read-only device. Allow to
> mount with -o noload in read-only mode.
>=20
> This can be reproduced easily like this:
>=20
> mke2fs -F -O journal_dev $JOURNAL_DEV 100M
> mkfs.$FSTYPE -F -J device=3D$JOURNAL_DEV $FS_DEV
> blockdev --setro $JOURNAL_DEV
> mount $FS_DEV $MNT
> touch $MNT/file
> umount $MNT
>=20
> leading to error like this
>=20
> [ 1307.318713] ------------[ cut here ]------------
> [ 1307.323362] generic_make_request: Trying to write to read-only =
block-device dm-2 (partno 0)
> [ 1307.331741] WARNING: CPU: 36 PID: 3224 at block/blk-core.c:855 =
generic_make_request_checks+0x2c3/0x580
> [ 1307.341041] Modules linked in: ext4 mbcache jbd2 rfkill =
intel_rapl_msr intel_rapl_common isst_if_commd
> [ 1307.419445] CPU: 36 PID: 3224 Comm: jbd2/dm-2 Tainted: G        W I =
      5.8.0-rc5 #2
> [ 1307.427359] Hardware name: Dell Inc. PowerEdge R740/01KPX8, BIOS =
2.3.10 08/15/2019
> [ 1307.434932] RIP: 0010:generic_make_request_checks+0x2c3/0x580
> [ 1307.440676] Code: 94 03 00 00 48 89 df 48 8d 74 24 08 c6 05 cf 2b =
18 01 01 e8 7f a4 ff ff 48 c7 c7 50e
> [ 1307.459420] RSP: 0018:ffffc0d70eb5fb48 EFLAGS: 00010286
> [ 1307.464646] RAX: 0000000000000000 RBX: ffff9b33b2978300 RCX: =
0000000000000000
> [ 1307.471780] RDX: ffff9b33e12a81e0 RSI: ffff9b33e1298000 RDI: =
ffff9b33e1298000
> [ 1307.478913] RBP: ffff9b7b9679e0c0 R08: 0000000000000837 R09: =
0000000000000024
> [ 1307.486044] R10: 0000000000000000 R11: ffffc0d70eb5f9f0 R12: =
0000000000000400
> [ 1307.493177] R13: 0000000000000000 R14: 0000000000000001 R15: =
0000000000000000
> [ 1307.500308] FS:  0000000000000000(0000) GS:ffff9b33e1280000(0000) =
knlGS:0000000000000000
> [ 1307.508396] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1307.514142] CR2: 000055eaf4109000 CR3: 0000003dee40a006 CR4: =
00000000007606e0
> [ 1307.521273] DR0: 0000000000000000 DR1: 0000000000000000 DR2: =
0000000000000000
> [ 1307.528407] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: =
0000000000000400
> [ 1307.535538] PKRU: 55555554
> [ 1307.538250] Call Trace:
> [ 1307.540708]  generic_make_request+0x30/0x340
> [ 1307.544985]  submit_bio+0x43/0x190
> [ 1307.548393]  ? bio_add_page+0x62/0x90
> [ 1307.552068]  submit_bh_wbc+0x16a/0x190
> [ 1307.555833]  jbd2_write_superblock+0xec/0x200 [jbd2]
> [ 1307.560803]  jbd2_journal_update_sb_log_tail+0x65/0xc0 [jbd2]
> [ 1307.566557]  jbd2_journal_commit_transaction+0x2ae/0x1860 [jbd2]
> [ 1307.572566]  ? check_preempt_curr+0x7a/0x90
> [ 1307.576756]  ? update_curr+0xe1/0x1d0
> [ 1307.580421]  ? account_entity_dequeue+0x7b/0xb0
> [ 1307.584955]  ? newidle_balance+0x231/0x3d0
> [ 1307.589056]  ? __switch_to_asm+0x42/0x70
> [ 1307.592986]  ? __switch_to_asm+0x36/0x70
> [ 1307.596918]  ? lock_timer_base+0x67/0x80
> [ 1307.600851]  kjournald2+0xbd/0x270 [jbd2]
> [ 1307.604873]  ? finish_wait+0x80/0x80
> [ 1307.608460]  ? commit_timeout+0x10/0x10 [jbd2]
> [ 1307.612915]  kthread+0x114/0x130
> [ 1307.616152]  ? kthread_park+0x80/0x80
> [ 1307.619816]  ret_from_fork+0x22/0x30
> [ 1307.623400] ---[ end trace 27490236265b1630 ]---
>=20
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> v2: some stylistic and error message changes
>=20
> fs/ext4/super.c | 51 ++++++++++++++++++++++++++++++++-----------------
> 1 file changed, 33 insertions(+), 18 deletions(-)
>=20
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 330957ed1f05..d925a1b16206 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5077,6 +5077,7 @@ static int ext4_load_journal(struct super_block =
*sb,
> 	dev_t journal_dev;
> 	int err =3D 0;
> 	int really_read_only;
> +	int journal_dev_ro;
>=20
> 	BUG_ON(!ext4_has_feature_journal(sb));
>=20
> @@ -5088,7 +5089,31 @@ static int ext4_load_journal(struct super_block =
*sb,
> 	} else
> 		journal_dev =3D =
new_decode_dev(le32_to_cpu(es->s_journal_dev));
>=20
> -	really_read_only =3D bdev_read_only(sb->s_bdev);
> +	if (journal_inum && journal_dev) {
> +		ext4_msg(sb, KERN_ERR,
> +			 "filesystem has both journal inode and journal =
device!");
> +		return -EINVAL;
> +	}
> +
> +	if (journal_inum) {
> +		journal =3D ext4_get_journal(sb, journal_inum);
> +		if (!journal)
> +			return -EINVAL;
> +	} else {
> +		journal =3D ext4_get_dev_journal(sb, journal_dev);
> +		if (!journal)
> +			return -EINVAL;
> +	}
> +
> +	journal_dev_ro =3D bdev_read_only(journal->j_dev);
> +	really_read_only =3D bdev_read_only(sb->s_bdev) | =
journal_dev_ro;
> +
> +	if (journal_dev_ro && !sb_rdonly(sb)) {
> +		ext4_msg(sb, KERN_ERR,
> +			 "journal device read-only, try mounting with =
'-o ro'");
> +		err =3D -EROFS;
> +		goto err_out;
> +	}
>=20
> 	/*
> 	 * Are we loading a blank journal or performing recovery after a
> @@ -5103,27 +5128,14 @@ static int ext4_load_journal(struct =
super_block *sb,
> 				ext4_msg(sb, KERN_ERR, "write access "
> 					"unavailable, cannot proceed "
> 					"(try mounting with noload)");
> -				return -EROFS;
> +				err =3D -EROFS;
> +				goto err_out;
> 			}
> 			ext4_msg(sb, KERN_INFO, "write access will "
> 			       "be enabled during recovery");
> 		}
> 	}
>=20
> -	if (journal_inum && journal_dev) {
> -		ext4_msg(sb, KERN_ERR, "filesystem has both journal "
> -		       "and inode journals!");
> -		return -EINVAL;
> -	}
> -
> -	if (journal_inum) {
> -		if (!(journal =3D ext4_get_journal(sb, journal_inum)))
> -			return -EINVAL;
> -	} else {
> -		if (!(journal =3D ext4_get_dev_journal(sb, =
journal_dev)))
> -			return -EINVAL;
> -	}
> -
> 	if (!(journal->j_flags & JBD2_BARRIER))
> 		ext4_msg(sb, KERN_INFO, "barriers disabled");
>=20
> @@ -5143,8 +5155,7 @@ static int ext4_load_journal(struct super_block =
*sb,
>=20
> 	if (err) {
> 		ext4_msg(sb, KERN_ERR, "error loading journal");
> -		jbd2_journal_destroy(journal);
> -		return err;
> +		goto err_out;
> 	}
>=20
> 	EXT4_SB(sb)->s_journal =3D journal;
> @@ -5159,6 +5170,10 @@ static int ext4_load_journal(struct super_block =
*sb,
> 	}
>=20
> 	return 0;
> +
> +err_out:
> +	jbd2_journal_destroy(journal);
> +	return err;
> }
>=20
> static int ext4_commit_super(struct super_block *sb, int sync)
> --
> 2.21.3
>=20


Cheers, Andreas






--Apple-Mail=_E31CCD68-5750-4BD5-B8EE-26E6F49BB229
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl8RiHoACgkQcqXauRfM
H+ApuBAAtYf94iAzDpf7EDMiQldnkfwxHD891ZOxjhCuuCGJ/suhswuq6slUrjYS
UZiNGgQ+0rqzN2Fuq8DA889vrTfhFZzs2yc8QZInX8gAzTEXpVStSKb2rVvxS5YK
m+nBd9ILIqEdpx4z57dZIyeGD9AsiapFvaeUfBpty04I3L3Y07n0s3RsP/kzDXgX
AA/eXXXjw7fF2ikVgKlEDdlIgQrji8lGteckMt15JOn4sU8Eq+aiCVSRTSZWAkrQ
DrSowIv9CN8mKFP07YEV/tQfLUNzFQwp/1Z/fOeRWAIDto3d6a/i7NO1ERP8v5Rc
BoFdZB+u6ahr8XfsoAybSeYIGAIz7NsIQU8/0pTsv5rKciv5PT+zU3qENzt8blYF
ZJMAfWCgtnCiABWimRquC7o4XOzgC2Z8iw4OsJ6SoXEq3r8tkcvmOp2itHAnrdi2
ueYUqyj7enM+KhvlP7NFBE7cu6qLH8lswR+ltmH7pKBsW9NAk4Jrgrm5xk9s1CAa
IB8YwUgAB0eVz+ZuLH2hf2Aad3X8QarRZPZDqY0fqFSu6Fq6RK08EQpzfiI5l+xl
OvOES5Ca+5YQxAAaBir5IugWgKXcfgHtAhsRL0OB2pgW8b1lKvVu4wsOPWMrNwnd
oLiAUQfIuyG+t/FLiWr6zapHvxFN/h/geby8TusYY9YXZHCDD0U=
=uPgh
-----END PGP SIGNATURE-----

--Apple-Mail=_E31CCD68-5750-4BD5-B8EE-26E6F49BB229--
