Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9836B223624
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jul 2020 09:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgGQHqo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jul 2020 03:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgGQHqn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Jul 2020 03:46:43 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487F1C061755
        for <linux-ext4@vger.kernel.org>; Fri, 17 Jul 2020 00:46:43 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t15so5996902pjq.5
        for <linux-ext4@vger.kernel.org>; Fri, 17 Jul 2020 00:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=qM2iBo7NnNBtFQV9XSqFyPJFVe/hzQ5MHAwJ9DhUw3Y=;
        b=cEtVPWr1oyqd++tknPc8um8lg1Tteby6XR8Ge29TQvqgIveE9M7hYZmO2ToXKG/lEc
         Ot8uYSaFdcLVXDBVz2Z4kFtduOguuuPd69Mg6Kh1MpqK0fIhuxJKiYqdI/R7GUcGOU4e
         FJ69vJiIQ+uEXfojVAZW0b8tNek87IBx/+5WBFj8+Tih3Nddc40YWfeDh5Ix1S3T+R9P
         FeEG+KO4tMOis8YxDAmKqw6yxnHUCIhAwle3zHEKI/c3t2L8A2Di2qbu4WB/0bGvibH8
         HidGYzUT5286j74qwLQ1jZrNnuz10PiEMT0SVBXRz48sc6kDeD2TRqi8/rDeRFrrNpaM
         V/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=qM2iBo7NnNBtFQV9XSqFyPJFVe/hzQ5MHAwJ9DhUw3Y=;
        b=Spt1dpKn2u3lyjvO2BdSH0f1h8b8MLNvWbsfmcjBLKXg32CGoRUBoZru2mlhmUZwRe
         IWCXtGGAjIZS/RNOVgdY+1W9SqS6r+yRxmgRS+jue9tFNWj9/bSGFXvr4iA5ilaD0q7t
         +F3rmyEmIXxqz3/xBjwTDp/taFshBkqz0jq+HcsKOYenLaa0VGIbfc36oKS5BrPlqwTY
         3yw1y4zjD6M2/M5lRrt2DZYJPs6D9dDiRegqbdB/JC5/TOjhhPjqeG6kOpgVCBa7hIGF
         PzUZWqe6vPJwUO1KxsQ5CrUwSo3sKbsJhxoJun8Kzze8x3sbKnXqej5HwvoMCraGm2XH
         XsJA==
X-Gm-Message-State: AOAM5312y19IAX26CGG/juAZPxqxXvZlNpwt4MeXhSrPkS/88s1fQlx5
        94g8h2sblQNKy0/EfgFpALEpStEDBXQ=
X-Google-Smtp-Source: ABdhPJy+mdbE/Qxl0wLtmJrI/osubpFM0rQP5fIcgUP+AIeW/vAleyJcd+7l9j086dv2LdopUa4aAg==
X-Received: by 2002:a17:90a:c915:: with SMTP id v21mr8708884pjt.48.1594972002497;
        Fri, 17 Jul 2020 00:46:42 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id y19sm6922518pgj.35.2020.07.17.00.46.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2020 00:46:41 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <7234E28B-C60F-4AB0-BCD9-4018B1A10B8D@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_97FF91DD-4F64-443B-A61C-20AE738E0C4E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] create_inode: set xattrs to the root directory as well
Date:   Fri, 17 Jul 2020 01:46:37 -0600
In-Reply-To: <20200701153404.1647002-1-antoine.tenart@bootlin.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>, tytso@mit.edu,
        matthew.weber@rockwellcollins.com, thomas.petazzoni@bootlin.com
To:     Antoine Tenart <antoine.tenart@bootlin.com>
References: <20200701153404.1647002-1-antoine.tenart@bootlin.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_97FF91DD-4F64-443B-A61C-20AE738E0C4E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jul 1, 2020, at 9:34 AM, Antoine Tenart <antoine.tenart@bootlin.com> =
wrote:
>=20
> __populate_fs do copy the xattrs for all files and directories, but =
the
> root directory is skipped and as a result its extended attributes =
aren't
> set. This is an issue when using mkfs to build a full system image =
that
> can be used with SElinux in enforcing mode without making any runtime
> fix at first boot.
>=20
> This patch adds logic to set the root directory's extended attributes.
>=20
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> ---
> misc/create_inode.c | 24 +++++++++++++++++++++++-
> 1 file changed, 23 insertions(+), 1 deletion(-)
>=20
> diff --git a/misc/create_inode.c b/misc/create_inode.c
> index e8d1df6b55a5..0a6e4dc23d16 100644
> --- a/misc/create_inode.c
> +++ b/misc/create_inode.c
> @@ -820,7 +820,29 @@ static errcode_t __populate_fs(ext2_filsys fs, =
ext2_ino_t parent_ino,
>=20
> 	for (i =3D 0; i < num_dents; free(dent[i]), i++) {
> 		name =3D dent[i]->d_name;
> -		if ((!strcmp(name, ".")) || (!strcmp(name, "..")))
> +		if (!strcmp(name, ".")) {

(style) despite what was previously in the code, I think it is clearer
to write "if (strcmp(name, ".") =3D=3D 0)", because it doesn't read like
"if not string compare" since that incorrectly seems like the strings
are *not* matching.

> +			retval =3D ext2fs_namei(fs, root, parent_ino, =
".", &ino);
> +			if (retval) {
> +				com_err(name, retval, 0);
> +					goto out;
> +			}
> +
> +			/*
> +			 * Take special care for the root directory, to =
copy its
> +			 * extended attributes.
> +			 */
> +			if (ino =3D=3D root) {

Rather than checking this for every directory, it would be more =
efficient
to copy the root xattrs only at the start of the copy in populate_fs2(),
before the tree walk has started.  Something like:

	file_info.path_len =3D 0;
	file_info.path_max_len =3D 255;
	file_info.path =3D calloc(file_info.path_max_len, 1);

+	retval =3D set_inode_xattr(fs, parent_ino, source_dir);
+	if (retval) {
+		com_err(__func__, retval,
+			_("while copying xattrs on root directory"));
+		goto out;
+	}
+
	retval =3D __populate_fs(fs, parent_ino, source_dir, root, =
&hdlinks,
                               &file_info, fs_callbacks);

That is an even less code added, which is always good.

Cheers, Andreas






--Apple-Mail=_97FF91DD-4F64-443B-A61C-20AE738E0C4E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl8RV10ACgkQcqXauRfM
H+BRpQ/+O/ZEEm/CHJu9Yu0XhlD0NBQWe4qd/mbeKGnEWp7/mooeW0YZn11QN3f+
wZokF8BUjkxieoJG2qaspY+73/bpppTx2KeQc5J9v263+Raliw9EUqJGhJpuvbHh
jIfoIYKgOPCNhkNITu3i34T5kE0fYbVqxKrTRXe60Y3vdIOsUszlj9c6az4JzrzA
v1+ER5K0vKSZbQ43jjXn0Ip6Tq8v3G5/Kclpz/pl82foT+jz9pINuL7g+UL80Jq0
TakM2Kf3zHZnGvx+jZnDjwD5EJ7d7DNWRyDPlAvpnpts5UoOlI49pknXou1C+u6b
sa6ucfq6Ik9U54WIHcp55TX4SLo0K5T9EEiyvqsDlGASy3ztW6jUfvJAgL+XGrY/
2vB7HoRigTOK3RqapR/s2TxHovlbCGhwEazQJyJg/kjlfHf4xg4YwpzAQli26UwG
wGiI/OkwnJ1b/LHn3692bN9KwjDTOEXutdL4VTp3Flx2qDd2yQ6ubjR4Q+G20Wod
SLJxagIBPIe3LUKEIguMJQt/xWF4l2eOtL5+SgkaW3hI3kYqGn2IA8Aursef3ioq
5mIPqne69IBpyRazRUKaEiUwkzMIQTSsZqThvu93ars8qtAqgywd1iAeRj3VHHJx
zqMg2hOQfXJxCxtLo15PBVUW/YuFFjm6l+oz5JGjVOwUvC7fvtw=
=iMjF
-----END PGP SIGNATURE-----

--Apple-Mail=_97FF91DD-4F64-443B-A61C-20AE738E0C4E--
