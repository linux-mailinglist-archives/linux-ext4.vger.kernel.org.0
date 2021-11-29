Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2BC462692
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Nov 2021 23:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbhK2WyV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Nov 2021 17:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235764AbhK2Wx0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 29 Nov 2021 17:53:26 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3733FC09E2A6
        for <linux-ext4@vger.kernel.org>; Mon, 29 Nov 2021 12:28:14 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id b13so13138460plg.2
        for <linux-ext4@vger.kernel.org>; Mon, 29 Nov 2021 12:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=YlAOBJnN8pARSbTBccP8m+HjjTPCE7JEv0JnCEqcVSg=;
        b=2rIyBJ6H/aJx8RFRVHux3kaXIYXPmelPAVRJCkTFmGhrCqV+jFGOGOwjCEL1qzyoPt
         VXni0Gqzpdckq0f9+DGUlCLvbaNBgAUzRFMWVFyPPTkOCgenGHUDOYlJbLmtP/S5NBPS
         H182Qqb1lU+Ltvy0sv+lxjHE5Kd260fXHUd+9XNW7/7XcNzmW1Iu09oUSan3ud9IoCr8
         c5TRXbA/f9GQDB62QqVqVy3PArc04xoExqhtpf7bHnViW1DNwsReyDgf2IZOJ9uJwtnT
         Zqp3oBXxkkp4uRl3F7WgLuI78gfgZqiUtskelzeFcL4ntkc+j3k/jW4W0sxAvEQQBwfE
         zNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=YlAOBJnN8pARSbTBccP8m+HjjTPCE7JEv0JnCEqcVSg=;
        b=aLYUvtQOujTHqZvlkXd5QbTcnvdSmqJDd/LZxYuRd+6254jcKYh825PWxIL/IzkIoS
         Ofk1zZYO9mLknqENhH3tMnmb4IO3q5PPtlQU2K5ix+6Vc9IPEB7HVDHajP3FNWnQvcGn
         CiUAOAIbr2kOPQa6jK3q6gXYksJIpwKQehanq0ea5/q2j0NmxkgQuma6uplaLGDiafjs
         2B10R4At5fftba6dtjfRGEh5ik5nFWOUpPguS8W8LacIU1Ghf1pB7GBifDbmSzEeENHI
         oCQM4MmYdi5xFB9gS8D29VbRz+MaA9W0o2l98TpRfrKcRO8MPn/LBkWKgPn2T+PQbSwN
         kTDA==
X-Gm-Message-State: AOAM530zPRY+njRikSrvW0Y0lAnOotZPCuvKtstdh+Xp21OrBx44R5OT
        0YQi2Gte5b+JEqqq5iAqfuY1PA==
X-Google-Smtp-Source: ABdhPJzRgnN7LIhZVkZ6Msk+uPk/tZArWDJ9wWh/ugIj3z4A72ZA3tZB8Bn8Gsq4UM6GZtfS/miwRQ==
X-Received: by 2002:a17:90a:ca81:: with SMTP id y1mr357802pjt.231.1638217693586;
        Mon, 29 Nov 2021 12:28:13 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id o2sm19756094pfu.206.2021.11.29.12.28.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Nov 2021 12:28:13 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <5E8B9CB8-9EEE-4CB2-8DB6-DE995103B513@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_08F01A67-6CAF-4598-B20F-9E3FE2F35BC7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] ext4: implement support for get/set fs label
Date:   Mon, 29 Nov 2021 13:28:09 -0700
In-Reply-To: <20211112082019.22078-1-lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
To:     Lukas Czerner <lczerner@redhat.com>
References: <20211111215904.21237-1-lczerner@redhat.com>
 <20211112082019.22078-1-lczerner@redhat.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_08F01A67-6CAF-4598-B20F-9E3FE2F35BC7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Nov 12, 2021, at 1:20 AM, Lukas Czerner <lczerner@redhat.com> wrote:
>=20
> Implement support for FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls =
for
> online reading and setting of file system label.
>=20
> ext4_ioctl_getlabel() is simple, just get the label from the primary
> superblock bh. This might not be the first sb on the file system if
> 'sb=3D' mount option is used.
>=20
> In ext4_ioctl_setlabel() we update what ext4 currently views as a
> primary superblock and then proceed to update backup superblocks. =
There
> are two caveats:
> - the primary superblock might not be the first superblock and so it
>   might not be the one used by userspace tools if read directly
>   off the disk.
> - because the primary superblock might not be the first superblock we
>   potentialy have to update it as part of backup superblock update.
>   However the first sb location is a bit more complicated than the =
rest
>   so we have to account for that.
>=20
> Tested with generic/492 with various configurations. I also checked =
the
> behavior with 'sb=3D' mount options, including very large file systems
> with and without sparse_super/sparse_super2.
>=20
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> ---

One minor issue/question inline.

> +static int ext4_ioctl_setlabel(struct file *filp, const char __user =
*user_label)
> +{
> +	size_t len;
> +	handle_t *handle;
> +	ext4_group_t ngroups;
> +	ext4_fsblk_t sb_block;
> +	struct buffer_head *bh;
> +	int ret =3D 0, ret2, grp;
> +	unsigned long offset =3D 0;
> +	char new_label[EXT4_LABEL_MAX + 1];
> +	struct super_block *sb =3D file_inode(filp)->i_sb;
> +	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
> +	struct ext4_super_block *es =3D sbi->s_es;
> +
> +	/* Sanity check, this should never happen */
> +	BUILD_BUG_ON(sizeof(es->s_volume_name) < EXT4_LABEL_MAX);
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +	/*
> +	 * Copy the maximum length allowed for ext4 label with one more =
to
> +	 * find the required terminating null byte in order to test the
> +	 * label length. The on disk label doesn't need to be null =
terminated.
> +	 */
> +	if (copy_from_user(new_label, user_label, EXT4_LABEL_MAX + 1))
> +		return -EFAULT;
> +
> +	len =3D strnlen(new_label, EXT4_LABEL_MAX + 1);
> +	if (len > EXT4_LABEL_MAX)
> +		return -EINVAL;
> +
> +	ret =3D mnt_want_write_file(filp);
> +	if (ret)
> +		return ret;
> +
> +	handle =3D ext4_journal_start_sb(sb, EXT4_HT_MISC, =
EXT4_MAX_TRANS_DATA);
> +	if (IS_ERR(handle)) {
> +		ret =3D PTR_ERR(handle);
> +		goto err_out;
> +	}
> +	/* Update the primary superblock first */
> +	ret =3D ext4_journal_get_write_access(handle, sb,
> +					    sbi->s_sbh,
> +					    EXT4_JTR_NONE);
> +	if (ret)
> +		goto err_journal;
> +
> +	lock_buffer(sbi->s_sbh);
> +	memset(es->s_volume_name, 0, sizeof(es->s_volume_name));
> +	memcpy(es->s_volume_name, new_label, len);

(minor) this introduces a very small window where s_volume_name is =
unset.
Since "new_label" is already a temporary buffer of the correct size, it
would be better IMHO to zero it out, copy the new label from userspace
into it, and then copy EXT4_LABEL_MAX bytes of new_label to =
s_volume_name.

It still isn't perfect, but reduces the window significantly.

> +	/* Update backup superblocks */
> +	ngroups =3D ext4_get_groups_count(sb);
> +	for (grp =3D 0; grp < ngroups; grp++) {

		:
		:

> +		ext4_debug("update backup superblock %llu\n", sb_block);
> +		BUFFER_TRACE(bh, "get_write_access");
> +		ret =3D ext4_journal_get_write_access(handle, sb,
> +						    bh,
> +						    EXT4_JTR_NONE);
> +		if (ret) {
> +			brelse(bh);
> +			break;
> +		}
> +
> +		es =3D (struct ext4_super_block *) (bh->b_data + =
offset);
> +		lock_buffer(bh);
> +		if (ext4_has_metadata_csum(sb) &&
> +		    es->s_checksum !=3D ext4_superblock_csum(sb, es)) {
> +			ext4_msg(sb, KERN_ERR, "Invalid checksum for =
backup "
> +				 "superblock %llu\n", sb_block);
> +			unlock_buffer(bh);
> +			brelse(bh);
> +			ret =3D -EFSBADCRC;
> +			break;
> +		}
> +		memset(es->s_volume_name, 0, sizeof(es->s_volume_name));
> +		memcpy(es->s_volume_name, new_label, len);

Same here.

The rest looks fine.

Cheers, Andreas






--Apple-Mail=_08F01A67-6CAF-4598-B20F-9E3FE2F35BC7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmGlN9oACgkQcqXauRfM
H+B1TRAAhHQ/mJpb5ncqwkp+fSoU35FCgFg+D0Qm3eRz2C4ZaY8mbcy07o1zO5+q
8v/buIYjcD953U019F/v++CF21N26gwogZOzJROz+aKVPr5g7RqZv+YmWIQGepTj
yefZ6JatmdnBIXTeJGhkYBKKjNG+7J8NWtSClww62vv5Xb7SLURMVyw9WNN0K4q1
JLTKDTTAfylBLBhZoBxOm8dXrfMa6AZVsZVJhsyc0tCmM5BWmZ7fwaQdRvereZ28
WpIwrJ/GlfvEmTKNiDS8b+mXaOycmlWL1sRv7u6GibHsEheF8l/c7OVo4n+pMw75
SuSiO3GWgqJlC14b4BBAMYUD7sEMvAByWopg8joJ6VKx+7svB7rzH8GmJtItv7ef
0+Kp5gWLz8nd6BiSQTWIgtrQANm5QKJm89puPbrDoZTReKCal6MhzPvwZGEmHuS3
zqTorMIU1WpEph6VwmER2JEcYTWMGMnQucVQcEj6adntSy2YBpZf+jC79VOZOpmf
PNge95gpibEJeDofFP/rJJ6KD098sRcEevaAWbwn3KBK/oQjs9vYT4modQnWJ0b7
Xk2FAgSaEzzEIs1ardhNoRU9vsaLusqTlrpQtlKqHvepZ4DGKSAK+CFcnQAHdEiu
rytuhcM0MwJnnx1RtzhfH4T59SEjSJ9G7a95690dN3n0NH7GRvE=
=csU0
-----END PGP SIGNATURE-----

--Apple-Mail=_08F01A67-6CAF-4598-B20F-9E3FE2F35BC7--
