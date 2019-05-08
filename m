Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE8AF1743E
	for <lists+linux-ext4@lfdr.de>; Wed,  8 May 2019 10:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfEHIuP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 May 2019 04:50:15 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43365 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfEHIuO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 May 2019 04:50:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id n8so9585346plp.10
        for <linux-ext4@vger.kernel.org>; Wed, 08 May 2019 01:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=5d5V17MGkkXhbQVooPZEeK3rI9GaTjxWKgrgfO4W7NU=;
        b=oK2VbdchfMN/Z121aI4DpnGVX7I/toPDA2VH+EAhjcemagVSNXQSlkpDJEbOUDDaUC
         Bb2+K7gdaWaVhkJF9Yez6IFRT0BsJafLXd2GY8LRtPPkORX5lPsZUEd4b40EWTyAoN/N
         YUWo7Gx1cSVf97JdqUmzZnVfhPzIRNPD0hqbAp7+hwj8XgXjtjYTLc816mom2haBgiRg
         5tMZEQBK0rtab7Be1yJUVwUeT0JnD+vyOj831CxwraL5bG2kwXrMnwQZa5nODT8Vs7PV
         MjPTotY1vxKd27ZCpOAJd8W6sRL8DFBarCfBCyTcufFNtzlO9Qe5jPbjBuofCL0/33vz
         N0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=5d5V17MGkkXhbQVooPZEeK3rI9GaTjxWKgrgfO4W7NU=;
        b=BW7j5S/akm6+XVBpvyEyLoN8Ahj1ihVC6lNfZK/psHdwGBAwyo50f8ncYGL3AngNJN
         r9wx/xmOQ0hUUzm3o8UNCXwKNtdt9UWaz5ZtkjOmtPUIEY06tYGARs5bULnNum/BCt1V
         +LoAR6Ra01WPPq3mYbGUPkjgx5Tb0Ge9YEZQi1E1gDnP/E12cCaE4sJuJzl98A57GulN
         ewxZ+j2t5NYChfhWmn/O4LBjfS5itLACd/W40bnT0hJRUBanDXXQHNcNEJruYTyaLdo1
         1CAm5IxA0By0j7O3w2Gbp/CH/s28EaGbgAxtwDIsPwOLVC8FbwbAA9KJnKAAx1QxUBha
         QvRg==
X-Gm-Message-State: APjAAAUo1kkAQ180blRVM1OsC0G1oQGbINdTfgzbsGuSXDUGKlWjn5qe
        h3gj1Pq+6KPF1gFkeAJ2MjUXCtGHd7w=
X-Google-Smtp-Source: APXvYqxoqw2Z5LwfOytfUEt2U9rKNSv1fk+E/0dHO2gWkSP9GR53UaQWI5Qc5WE5Q2WBA3eDmkJ+TQ==
X-Received: by 2002:a17:902:4503:: with SMTP id m3mr43072190pld.97.1557305414030;
        Wed, 08 May 2019 01:50:14 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id u123sm13464530pfu.67.2019.05.08.01.50.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 01:50:13 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <E7B70E7E-BE5D-4FD0-91CC-CED63146A43B@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_5E3DF030-97EF-40A5-998C-7DB64C39A74F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] ext4: fix use-after-free in dx_release()
Date:   Wed, 8 May 2019 02:49:25 -0600
In-Reply-To: <1557304443-18653-1-git-send-email-stummala@codeaurora.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Sahitya Tummala <stummala@codeaurora.org>
References: <1557304443-18653-1-git-send-email-stummala@codeaurora.org>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_5E3DF030-97EF-40A5-998C-7DB64C39A74F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On May 8, 2019, at 2:34 AM, Sahitya Tummala <stummala@codeaurora.org> =
wrote:
>=20
> The buffer_head (frames[0].bh) and it's corresping page can be
> potentially free'd once brelse() is done inside the for loop
> but before the for loop exits in dx_release(). It can be free'd
> in another context, when the page cache is flushed via
> drop_caches_sysctl_handler(). This results into below data abort
> when accessing info->indirect_levels in dx_release().
>=20
> Unable to handle kernel paging request at virtual address =
ffffffc17ac3e01e
> Call trace:
> dx_release+0x70/0x90
> ext4_htree_fill_tree+0x2d4/0x300
> ext4_readdir+0x244/0x6f8
> iterate_dir+0xbc/0x160
> SyS_getdents64+0x94/0x174
>=20
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> v2:
> add a comment in dx_release()
>=20
> fs/ext4/namei.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 980166a..5d9ffa8 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -871,12 +871,15 @@ static void dx_release(struct dx_frame *frames)
> {
> 	struct dx_root_info *info;
> 	int i;
> +	unsigned int indirect_levels;
>=20
> 	if (frames[0].bh =3D=3D NULL)
> 		return;
>=20
> 	info =3D &((struct dx_root *)frames[0].bh->b_data)->info;
> -	for (i =3D 0; i <=3D info->indirect_levels; i++) {
> +	/* save local copy, "info" may be freed after brelse() */
> +	indirect_levels =3D info->indirect_levels;
> +	for (i =3D 0; i <=3D indirect_levels; i++) {
> 		if (frames[i].bh =3D=3D NULL)
> 			break;
> 		brelse(frames[i].bh);
> --
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation =
Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a =
Linux Foundation Collaborative Project.
>=20


Cheers, Andreas






--Apple-Mail=_5E3DF030-97EF-40A5-998C-7DB64C39A74F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlzSmC8ACgkQcqXauRfM
H+Ce0xAAifydZyrx2PdbxVMOPr5hn78hZeezdDA/4f64tYel8rejddFxlXmVIAIc
AoRjDXZcKMF80VxJ9yhp+lXSh5BLmOD7s//LnvmYgzSIX/FzG/13lzeuotaUprv3
sOyh7eNYCaBtq6zI3/MmN6rYBNU/heoqMioX+RYtpayLGsqNiDM0brh0e4Q57HBB
X8TEFO7oC2ZItxP+fbHs0SPSaaa5Ho+DhLwUXWNt/T0AgWFLnYwUoYSGf9b20hAm
1g1+267dmtuNWWe6bcif9QFEA045FoFnPGSF69AJvx54wWMXzBz5qzLWtJx94ftk
L1H8xuZVtiEk4KVkbwMyPK4ZtOr/yWb/1ly0Pgh1oZxdoxhMrS/eSGcBi7rhE4Oo
yTRFec5X2ZiOVr/aah+d7GhhFkfyClbpOHlHiBv7RkrNQ11LMxOWtGtrZ2O/v3lJ
3PjZLQUp47X1CJo1vQxwLCDPeGXjkduVewmZ/6BEIeOrdqNHm4mHABYV5fLrn9X5
R+yio8kjkQNyIQt9yjwvb4KrbBDUt1FUDKUziRudlS82POJa9LGtlSJd8VbqjByX
ZGpXg9/ey2lXjVgMYgSaavr4pwgRJWDpDxFNUX3x4xdI+MlFOP/ZgLrPcPeIWLBK
SB46f8TCbnfSLF0fJvwyHo4qk6iZB4CuJNGkHjjE38bwMzu/LHU=
=xufe
-----END PGP SIGNATURE-----

--Apple-Mail=_5E3DF030-97EF-40A5-998C-7DB64C39A74F--
