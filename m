Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280FF1AB065
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Apr 2020 20:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406638AbgDOSMs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Apr 2020 14:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406366AbgDOSMo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 15 Apr 2020 14:12:44 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7E7C061A0C
        for <linux-ext4@vger.kernel.org>; Wed, 15 Apr 2020 11:12:43 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id v2so301673plp.9
        for <linux-ext4@vger.kernel.org>; Wed, 15 Apr 2020 11:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=uc8SZkyHO7+oKEkd6D0y/6FmW2OcOEGi/HZVZSbsjao=;
        b=dk8jxG5H8ATkLxvYMV60haNIjxuJv09oUKV0xihOfmffTD197LNaaOWnomdGaw84YU
         8CJAnxD+vKL/I76rXh6nhBWPqVUp1L1RcqRzYTHzctym2z0LJ+JrigLA/KzUi4qZZaSI
         rCPmdpPjZ7NebCzCwvlYEfUJCqah6d4KS2wyRFf0a/LCLmlxjonSXkBZQwBqNM5PPxpw
         WtbxMTh0HkFdexI2g8Nly/DcxnPnCjKQVlLPM+Q6f0ywfDfqGddAnb2c5ccPYDIAznA2
         AA+9XIjn9VadyaF40MDahoqSIJWnAgDKlybzMQjGcJATUAK2exT8cdu5Vjad1UqIzbYJ
         UqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=uc8SZkyHO7+oKEkd6D0y/6FmW2OcOEGi/HZVZSbsjao=;
        b=eyAjss/Mj/Iq1MLZqhwTLMvMvRM/IQu71T68OcGEz0zlasXKAnAjCC1wmk3SEGzohf
         Viw/Ig5o70ywGn5OTDgHVxqNPIvi77nyqtspmjxzlNb4QQUM684bXHVJITikC2Zdtq9M
         1J2gujcOSyBNe2Lje/LrtKk5XQHrTQkqffx7lThHZgb4XpHS5ZY+VspyE/ChJHJw6/v+
         qa6d78/JQdNJvHLbtrpq22VC6x/nq48C684S4kOL0ODUOWJim3ZMXzwe2uNnqC6m3rvZ
         G8fOwdjatoszd86XdbRx86gVrs4srr5MgiW2yOctQmP73kOj+R9XZ7w3neWS0BWIgp9U
         59jA==
X-Gm-Message-State: AGi0PubKIcSWckoMdvkX9o+JvuOA+FIOF5yjBpP7rDGjD3reuVhtmIPO
        cvOoZ/H1oWl62YTd7BEIh1UF8Q==
X-Google-Smtp-Source: APiQypKZEMdUIj/8AClBZdkAfr7IICta8FclcaI/ATfvpPeaEXHvJXkb5A/XGxCP6GLxes7BkNkcuA==
X-Received: by 2002:a17:90b:1953:: with SMTP id nk19mr555143pjb.16.1586974362750;
        Wed, 15 Apr 2020 11:12:42 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id 22sm4954909pfb.132.2020.04.15.11.12.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2020 11:12:41 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <A4EF2AAD-8C59-4C8B-B6BA-7544522315E8@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_2B9743FD-B5D8-4046-91B1-5B161F7E6236";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: reject mount options not supported when remounting
 in handle_mount_opt()
Date:   Wed, 15 Apr 2020 12:12:39 -0600
In-Reply-To: <20200415174839.461347-1-tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        stable@kernel.org
To:     Theodore Ts'o <tytso@mit.edu>
References: <to=00000000000098a5d505a34d1e48@google.com>
 <20200415174839.461347-1-tytso@mit.edu>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_2B9743FD-B5D8-4046-91B1-5B161F7E6236
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 15, 2020, at 11:48 AM, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> Rejecting the mount options in ext4_remount() means that some mount
> options would be enabled for a small amount of time, and then the
> mount option change would be reverted.  In the case of "mount -o
> remount,dax", this can cause a race where files would temporarily
> treated as DAX --- and then not.
>=20
> Cc: stable@kernel.org
> Reported-and-tested-by: =
syzbot+bca9799bf129256190da@syzkaller.appspotmail.com
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/super.c | 37 +++++++++++--------------------------
> 1 file changed, 11 insertions(+), 26 deletions(-)
>=20
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index bf5fcb477f66..6fe32f9aa889 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1726,6 +1726,7 @@ static int clear_qf_name(struct super_block *sb, =
int qtype)
> #define MOPT_NO_EXT3	0x0200
> #define MOPT_EXT4_ONLY	(MOPT_NO_EXT2 | MOPT_NO_EXT3)
> #define MOPT_STRING	0x0400
> +#define MOPT_NO_REMOUNT	0x0800
>=20
> static const struct mount_opts {
> 	int	token;
> @@ -1775,12 +1776,12 @@ static const struct mount_opts {
> 	{Opt_min_batch_time, 0, MOPT_GTE0},
> 	{Opt_inode_readahead_blks, 0, MOPT_GTE0},
> 	{Opt_init_itable, 0, MOPT_GTE0},
> -	{Opt_dax, EXT4_MOUNT_DAX, MOPT_SET},
> +	{Opt_dax, EXT4_MOUNT_DAX, MOPT_SET | MOPT_NO_REMOUNT},
> 	{Opt_stripe, 0, MOPT_GTE0},
> 	{Opt_resuid, 0, MOPT_GTE0},
> 	{Opt_resgid, 0, MOPT_GTE0},
> -	{Opt_journal_dev, 0, MOPT_NO_EXT2 | MOPT_GTE0},
> -	{Opt_journal_path, 0, MOPT_NO_EXT2 | MOPT_STRING},
> +	{Opt_journal_dev, 0, MOPT_NO_EXT2 | MOPT_GTE0 | =
MOPT_NO_REMOUNT},
> +	{Opt_journal_path, 0, MOPT_NO_EXT2 | MOPT_STRING | =
MOPT_NO_REMOUNT},
> 	{Opt_journal_ioprio, 0, MOPT_NO_EXT2 | MOPT_GTE0},
> 	{Opt_data_journal, EXT4_MOUNT_JOURNAL_DATA, MOPT_NO_EXT2 | =
MOPT_DATAJ},
> 	{Opt_data_ordered, EXT4_MOUNT_ORDERED_DATA, MOPT_NO_EXT2 | =
MOPT_DATAJ},
> @@ -1817,7 +1818,7 @@ static const struct mount_opts {
> 	{Opt_jqfmt_vfsv1, QFMT_VFS_V1, MOPT_QFMT},
> 	{Opt_max_dir_size_kb, 0, MOPT_GTE0},
> 	{Opt_test_dummy_encryption, 0, MOPT_GTE0},
> -	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
> +	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET | =
MOPT_NO_REMOUNT},
> 	{Opt_err, 0, 0}
> };
>=20
> @@ -1915,6 +1916,12 @@ static int handle_mount_opt(struct super_block =
*sb, char *opt, int token,
> 			 "Mount option \"%s\" incompatible with ext3", =
opt);
> 		return -1;
> 	}
> +	if ((m->flags & MOPT_NO_REMOUNT) && is_remount) {
> +		ext4_msg(sb, KERN_ERR,
> +			 "Mount option \"%s\" not supported when =
remounting",
> +			 opt);
> +		return -1;
> +	}
>=20
> 	if (args->from && !(m->flags & MOPT_STRING) && match_int(args, =
&arg))
> 		return -1;
> @@ -1994,11 +2001,6 @@ static int handle_mount_opt(struct super_block =
*sb, char *opt, int token,
> 		}
> 		sbi->s_resgid =3D gid;
> 	} else if (token =3D=3D Opt_journal_dev) {
> -		if (is_remount) {
> -			ext4_msg(sb, KERN_ERR,
> -				 "Cannot specify journal on remount");
> -			return -1;
> -		}
> 		*journal_devnum =3D arg;
> 	} else if (token =3D=3D Opt_journal_path) {
> 		char *journal_path;
> @@ -2006,11 +2008,6 @@ static int handle_mount_opt(struct super_block =
*sb, char *opt, int token,
> 		struct path path;
> 		int error;
>=20
> -		if (is_remount) {
> -			ext4_msg(sb, KERN_ERR,
> -				 "Cannot specify journal on remount");
> -			return -1;
> -		}
> 		journal_path =3D match_strdup(&args[0]);
> 		if (!journal_path) {
> 			ext4_msg(sb, KERN_ERR, "error: could not dup "
> @@ -5427,18 +5424,6 @@ static int ext4_remount(struct super_block *sb, =
int *flags, char *data)
> 		}
> 	}
>=20
> -	if ((sbi->s_mount_opt ^ old_opts.s_mount_opt) & =
EXT4_MOUNT_NO_MBCACHE) {
> -		ext4_msg(sb, KERN_ERR, "can't enable nombcache during =
remount");
> -		err =3D -EINVAL;
> -		goto restore_opts;
> -	}
> -
> -	if ((sbi->s_mount_opt ^ old_opts.s_mount_opt) & EXT4_MOUNT_DAX) =
{
> -		ext4_msg(sb, KERN_WARNING, "warning: refusing change of =
"
> -			"dax flag with busy inodes while remounting");
> -		sbi->s_mount_opt ^=3D EXT4_MOUNT_DAX;
> -	}
> -
> 	if (sbi->s_mount_flags & EXT4_MF_FS_ABORTED)
> 		ext4_abort(sb, EXT4_ERR_ESHUTDOWN, "Abort forced by =
user");
>=20
> --
> 2.24.1
>=20


Cheers, Andreas






--Apple-Mail=_2B9743FD-B5D8-4046-91B1-5B161F7E6236
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl6XTpcACgkQcqXauRfM
H+Cfqw/8D0819pxcoVWRoLlML0AV8YdxiTJ3wUds/sq4IBIZogD1IfEpTVuvZsZG
8jurzdG87E+AoJXcd8wm9OcKT9OvOdAkD2SWbw0kfE79oBLHZ1p9NN+oLkJN0B+U
lODf0cmVrSXF1kwhWuU9XkAQML8HYZQ+93v8utCQqDqf+6t5MQKHZJe2JswEe1+6
vM9eVAP/msm5ywpX79Ctc63NgshnAK7w9Jie6zEd93KOLtr/Rtk6vt1pbt5WPTzQ
UxABhxYcY9cPOOxhmrziMMbjwVRnBBmI9DtAvzwEQAbZEBcwF8S/4FQEqAf4SPyG
1aLta8LgtNRx/HRuYZBqez301FUIfS8PgkE+o5e1oJpmY7v2DmhCwYrZnGM8jjbD
7a6ZSeAi2nmAYqoNHWkFo0AED+DNiES18LpQeC7Bcq3ut7s3GHT7mcS2XgsgP0jU
BydrI0gb7BS8jDDYCOIFQjBMJeMtP8EqYAL0GeKYV6845zQmgbkdcq+VymtOG9Xw
XMlb55Q1+gtZkODWtoxtKKPDnmmeIFDJ8eJl7f596x4QLEoUF0FYKtwbVPOAfQja
+gW/TsGoRofn9eRZZW5sn+mmog4Xs0pYB1hT7ar6JAWaxJnpeeUcXkgRCqu9iN20
CD1exlY7FVlnIFBv93zqjrCL9Z+wMlJeiRaM2WGrh3hppsu6YKg=
=0gti
-----END PGP SIGNATURE-----

--Apple-Mail=_2B9743FD-B5D8-4046-91B1-5B161F7E6236--
