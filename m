Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AB6223A39
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jul 2020 13:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgGQLRK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jul 2020 07:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgGQLRK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Jul 2020 07:17:10 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E26BC061755
        for <linux-ext4@vger.kernel.org>; Fri, 17 Jul 2020 04:17:10 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id o1so5323510plk.1
        for <linux-ext4@vger.kernel.org>; Fri, 17 Jul 2020 04:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=GsHHxyiBSRaBbYJ+AvuslScDkvf4IbfdS2GJHS2XIE4=;
        b=JIVcEfbT9uajjjKet4zk9FEpO70qX0IVScs6m5qjFtpNFq4uBq0VOLF5YFWuYMrJ7+
         9FJhHhht4vKydqvC7ih4Nyt9A9obWczhXyS2c21+hZLsdfft1tLk3BcBBISo5fa9YvXE
         mv2I+Wmj6/7dDX49EKcr/M7rxjqp5YcvA/PG+rrZxCdFbScixOqh8k1+jaXNZGzeKHGi
         KWgkzTadRGJ5yW6ul+GGWT8iuojNW1Eb+fEgqr2uqnYDhpRnXkAWrUL5VBn5+zkAdJv3
         hsy4ssgpreGap84EoLImotyqYx73Tqc6IQ2hYF/gR1LNllxOnut5iqZZ4gkt9z95cutK
         xTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=GsHHxyiBSRaBbYJ+AvuslScDkvf4IbfdS2GJHS2XIE4=;
        b=pQfOOH6rul4Pj7B2QaL0wvO100rRNjxlOkB23MoamQByZqQHPMphfJog7OYgnFtjsk
         u8QTgGymtc1+8TvKto6RUEW7lT2ETn8azBbUvjz41wgTHpcrK+SXDeN/QegqeKLU9F6E
         7NOsX+M0ckGK3/KFIoCoJ8untAgjGU3rjGYfI12gPmz60JnMXGve8lIZo09XnP8+scZH
         sW3O+FnB7n56Ka2QKSXZ3bvzvce96R2u8DJMxyhNUHSQe/hrNGczt/+/MmSABt1VMA1Y
         I1pjJfTNfr9Ly+1CgVPXXHpTvdVC9Vuv9MCaCgqhe/LZ8zRa0Gmdj6oYcgq4dz6ICDS2
         B+0g==
X-Gm-Message-State: AOAM531mp7+uOM8NahM2ghMEWsKNDFfaenUreJ0rqOeNuc5OSQ13hpHs
        +4jt0e6X8UeqtsGh92+VMhx99z08dxQ=
X-Google-Smtp-Source: ABdhPJw6+BDAeUI6o/EdEUuacXVfElxvUTEMTqycysUrDyFre8kRZ8GHvcnB51WXfo4SQY6eUBi+ew==
X-Received: by 2002:a17:90a:ea84:: with SMTP id h4mr9511326pjz.128.1594984629586;
        Fri, 17 Jul 2020 04:17:09 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id ia13sm2543935pjb.42.2020.07.17.04.17.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2020 04:17:08 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <B2EE7AC5-BEC0-46A8-8C37-D3085645F94C@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_B05D3CE0-3082-46F1-A907-D0604B1D3567";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] create_inode: set xattrs to the root directory as well
Date:   Fri, 17 Jul 2020 05:17:08 -0600
In-Reply-To: <20200717100846.497546-1-antoine.tenart@bootlin.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        matthew.weber@rockwellcollins.com, thomas.petazzoni@bootlin.com
To:     Antoine Tenart <antoine.tenart@bootlin.com>
References: <20200717100846.497546-1-antoine.tenart@bootlin.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_B05D3CE0-3082-46F1-A907-D0604B1D3567
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Jul 17, 2020, at 4:08 AM, Antoine Tenart =
<antoine.tenart@bootlin.com> wrote:
>=20
> populate_fs do copy the xattrs for all files and directories, but the
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

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
>=20
> Since v1:
>  - Moved the set_inode_xattr logic for the root directory
>    from __populate_fs to populate_fs2.
>=20
> misc/create_inode.c | 8 ++++++++
> 1 file changed, 8 insertions(+)
>=20
> diff --git a/misc/create_inode.c b/misc/create_inode.c
> index e8d1df6b55a5..fe66faf1b53d 100644
> --- a/misc/create_inode.c
> +++ b/misc/create_inode.c
> @@ -1050,9 +1050,17 @@ errcode_t populate_fs2(ext2_filsys fs, =
ext2_ino_t parent_ino,
> 	file_info.path_max_len =3D 255;
> 	file_info.path =3D calloc(file_info.path_max_len, 1);
>=20
> +	retval =3D set_inode_xattr(fs, root, source_dir);
> +	if (retval) {
> +		com_err(__func__, retval,
> +			_("while copying xattrs on root directory"));
> +		goto out;
> +	}
> +
> 	retval =3D __populate_fs(fs, parent_ino, source_dir, root, =
&hdlinks,
> 			       &file_info, fs_callbacks);
>=20
> +out:
> 	free(file_info.path);
> 	free(hdlinks.hdl);
> 	return retval;
> --
> 2.26.2
>=20


Cheers, Andreas






--Apple-Mail=_B05D3CE0-3082-46F1-A907-D0604B1D3567
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl8RiLQACgkQcqXauRfM
H+Bgcw/9FOPu7TNydPwYUY1dzem+oTApjqrjzahDf956ZnJqAPhrQlZQegX7cbgy
U+ncEE26Vlc+YKYxpHSPFS6MYWDCooTzbqCkys9QVQbyORHG3PsVrpNRSms2kxNT
dlz1wubXPEyAPXl1WefldefwDkx5fXr8xFUUxJJRKHRtVnddwV3v2OqQMjx7Avl/
eh7F7skwZueItBAtoyCIF2QWCRgMpjxjy1okMh+PXXP4ToBiK3L+HFw0tGkf8q1D
ERoQPMY/Q5HnZ41X7i+7Obdo5lomM+rW1kVvahpRBvdUlEyWymMGSlNL5zZn60cs
29/FszhO5stI4gPvXQZj1ajQ2A0bmfizZCBJ78MUhFpMumSYyZW6SnhtODDo2EK1
8Gl6umhrFyd05Q99j3OctIBlm1iVs8/IaZZdQ47lmuvNQKmWtqJYdnE3ul6fUncy
jLBOF+vnbRwFh2gXoHaKSoGaSj/u6VlM/h+OPAv4l1w+nQzJf8tFKNUaro8fM8HF
veYk2FFaNIusOfK8mybGsyLUazKs5MfNykRRAuuQs8xBinLAmM/szAX5VAaPkcgj
b0Lheg2q2DH2pDc1BQc3G4zYw94ayH4x71g3exa36PUpND/TgT9GeYnmsC9j6Dn5
J4BYYJSlh+E9D9fQHpZbO06Y4PC4fHpWvXh9nWvK4DjurhkNZSk=
=1tbh
-----END PGP SIGNATURE-----

--Apple-Mail=_B05D3CE0-3082-46F1-A907-D0604B1D3567--
