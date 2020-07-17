Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077992236A2
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jul 2020 10:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgGQIKW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jul 2020 04:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgGQIKW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Jul 2020 04:10:22 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4748DC061755
        for <linux-ext4@vger.kernel.org>; Fri, 17 Jul 2020 01:10:22 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id b9so5134526plx.6
        for <linux-ext4@vger.kernel.org>; Fri, 17 Jul 2020 01:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=P5Be4RB63NJBKQdPoBjs0phkusoaGyQMRtdaoigR1Mo=;
        b=H8K87V/sk2Exd08aCrMXIOxxLMAtbdjcjUl547qi/ArU6/QuqbpFGQL2psx/dw/BYF
         RNIEO5f5GYtHZtKzB+Adsr9Jf04hgm7I5gHX9eO9V8MPgWAQLumWXhgn99Me26chaPPf
         oHXNDKIEQcpSXlgu8INlhzsCS4uRcH4T7Uc4uwc5KXmfAo3NMaUNlc7383OfJdsqIsKH
         PVnowjiJsArMGpkurBLJmFcwXMf8qQ2/UhmL1SBbVPl4QoyZqbRYdHpKpKjF7z2lzDsh
         Q+BR4brga1F+vNKIeBjqrjkh+qD/9W2ARH2roIYiHzy6JGPjaLaNtrDqgZeLJnqhKi68
         7EqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=P5Be4RB63NJBKQdPoBjs0phkusoaGyQMRtdaoigR1Mo=;
        b=XIJkvBwFVdmbgsQHYfVNOhoX7bbuVBWEgMbs4tcbFeejj2TOIOn8dne1wktf50PaIn
         qt08Bw+8Tj8AdxghKveA/+bxZhgPKwFYRFyv25jkUtXfXUY8UI/qx6zaX4lL9S/+J/qH
         6/QWX3SSscycnX/xqNNuW5suiFdm/b5HPhc9KveUfup6T/hzwXufKCWtU4gALuS4V5XK
         NRI1QJkXhfCEdL7kX0D+8MYTv6N/okdT2GQ0n9TDHm1nRLq0VrCtZ5RYfqHEv3qZDYeC
         FE9Ray9op/KrgpdWqHcahOZFb4Ug3ulclVpSfzWTGChVBkR9fRbLzi+B6/UAMEp+ddvT
         QXaA==
X-Gm-Message-State: AOAM532DrCkZ6e9NRdaQ69rRk0d+NUN7jLjTJgPML72rkdonKRkKG6K1
        eIV+jHMUtAvnvYhY/B3HXDmPjA==
X-Google-Smtp-Source: ABdhPJziTLUVERJ7awvzAj7No8ezQcol7i0ZHLrnbO4VUKGa9OLtVBxVp3HmS0C6WdsRklQZVcRvoQ==
X-Received: by 2002:a17:90a:a60a:: with SMTP id c10mr9307574pjq.117.1594973421556;
        Fri, 17 Jul 2020 01:10:21 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id e5sm1968871pjy.26.2020.07.17.01.10.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2020 01:10:20 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <43F86B80-4895-4146-B65B-788D16161323@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_D6B841F3-6F72-4611-8223-9215FA9D0BCE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: handle read only external journal device
Date:   Fri, 17 Jul 2020 02:10:18 -0600
In-Reply-To: <20200716183901.5016-1-lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
To:     Lukas Czerner <lczerner@redhat.com>
References: <20200716183901.5016-1-lczerner@redhat.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_D6B841F3-6F72-4611-8223-9215FA9D0BCE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jul 16, 2020, at 12:39 PM, Lukas Czerner <lczerner@redhat.com> wrote:
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
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> ---
> fs/ext4/super.c | 55 ++++++++++++++++++++++++++++++-------------------
> 1 file changed, 34 insertions(+), 21 deletions(-)
>=20
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 330957ed1f05..a15e3c751766 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5088,7 +5089,30 @@ static int ext4_load_journal(struct super_block =
*sb,
> 	} else
> 		journal_dev =3D =
new_decode_dev(le32_to_cpu(es->s_journal_dev));
>=20
> -	really_read_only =3D bdev_read_only(sb->s_bdev);
> +	if (journal_inum && journal_dev) {
> +		ext4_msg(sb, KERN_ERR, "filesystem has both journal "
> +		       "and inode journals!");

(style) keep error string on a single line.  Also, "journal and inode =
journal"
is not very clear what the problem is.  Maybe something like:

+		ext4_msg(sb, KERN_ERR,
+			 "filesystem has both journal inode and =
device!");

> +		return -EINVAL;
> +	}
> +
> +	if (journal_inum) {
> +		if (!(journal =3D ext4_get_journal(sb, journal_inum)))
> +			return -EINVAL;
> +	} else {
> +		if (!(journal =3D ext4_get_dev_journal(sb, =
journal_dev)))
> +			return -EINVAL;
> +	}
> +
> +	journal_dev_ro =3D bdev_read_only(journal->j_dev);
> +	really_read_only =3D bdev_read_only(sb->s_bdev) | =
journal_dev_ro;
> +
> +	if (journal_dev_ro && !sb_rdonly(sb)) {
> +		ext4_msg(sb, KERN_ERR, "write access "
> +			"unavailable, cannot proceed "
> +			"(try mounting read-only)");

(style) should keep error strings on a single line.  Also, this isn't =
very
obvious that that this is because of the read-only journal device.  =
Maybe:

		ext4_msg(sb, KERN_ERR,
			 "journal device read-only, try mounting with =
'-o ro'");

> @@ -5141,11 +5152,8 @@ static int ext4_load_journal(struct super_block =
*sb,
> 		kfree(save);
> 	}
>=20
> -	if (err) {
> -		ext4_msg(sb, KERN_ERR, "error loading journal");
> -		jbd2_journal_destroy(journal);
> -		return err;
> -	}
> +	if (err)
> +		goto err_out;
>=20
> 	EXT4_SB(sb)->s_journal =3D journal;
> 	ext4_clear_journal_err(sb, es);
> @@ -5159,6 +5167,11 @@ static int ext4_load_journal(struct super_block =
*sb,
> 	}
>=20
> 	return 0;
> +
> +err_out:
> +	ext4_msg(sb, KERN_ERR, "error loading journal");

Is there any error case that doesn't already print its own error =
message?
Maybe better to leave the ext4_msg() in the original location, and only
do cleanup here.


Cheers, Andreas






--Apple-Mail=_D6B841F3-6F72-4611-8223-9215FA9D0BCE
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl8RXOoACgkQcqXauRfM
H+CgyQ//Z4bRix6W++mVft8j2yfFlWSYmrRlBBlx2WQ1wlAi+8gSOIP4qh+NuAwk
QrjR1vQuHt6OSK3LILlFRDoYdI/Sn0vyw8QbCa5PHTwKHDFCi3E1irX8bWzm1OnE
GSDJ8ywyWUkS/uivTJLFncxFkNSSiomovpr2w7By6V/9d1IzoCMKwedruTqPuW32
CFRdNk6xLZ9Z+7xXhGyF4pzXPgjAbDE6LSSsVZ9HVd8AEcmP7rP18tUERPc+lh+O
pDEIF8HLM8F0Vj1BtV80GPU+HP4dk8lvTnkYzI+2w0V0Q5iTw/oAHrVaI+4DOMtn
pS9ErRtf9i9ln16JOcOMBBFLmUilfKFxXyHjeFUh1J55RceZknprdykjWUUPJ9XV
d1+YsxJ93IlNp51B9zLAhxIT4XDyOpP99J9xR0ttePHCnfePVrPdvpvd5B9tilp1
OzGd78bAIRl8VEq57sC4rVtZaEDsxwX04NgyaKFsKwcpZPSjGaIe3Y6g7VPK6NPV
0xkDrvndZwsT3YK2mpIuHyH4RzXeYc5VbCr/iAk4zIJ8poSVrdzOJ+Ia1o8xTyA0
QW8dsOJ0hpdszjTrIeFaCkhT4uV9q2IhsmTLthA9I5TmrkIo/zFvuvME1VM0cWjD
sLeFTaP+X9BcBLj/hrsZ5cEkc17lOUqT5/K2FZsCk6c4TCGuz+I=
=HTZo
-----END PGP SIGNATURE-----

--Apple-Mail=_D6B841F3-6F72-4611-8223-9215FA9D0BCE--
