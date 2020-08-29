Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9A3256592
	for <lists+linux-ext4@lfdr.de>; Sat, 29 Aug 2020 09:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgH2HVz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 29 Aug 2020 03:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgH2HVv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 29 Aug 2020 03:21:51 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C44EC061239
        for <linux-ext4@vger.kernel.org>; Sat, 29 Aug 2020 00:21:51 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 5so1531542pgl.4
        for <linux-ext4@vger.kernel.org>; Sat, 29 Aug 2020 00:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=G2MSpHN+OgTuVkTkfaadPVZ4uyPRsDUXgqMIPwUf15Q=;
        b=MEmYW1wqlSUD9Uuaolj+MncB61scGjgDT7gQ74efYuAXck0fQealA2w0Nt+F1jJqxd
         k/tj4IovJZhVFoliXYgkzPQ6MTkUa0SYM0cm1xVn+7mJCYP/kJUPML+w+2KtfZELnpS4
         WG0x1ayVTHNKigKSUHF5YpIC/nWFV+ki1Ol1wLDkO318r49VgJ3yFz1vJlSei7sp79uG
         OivU7HOqIq1nMU9tTXqnM2XqGYe6xqfz9W9+X3Qb/D96hel09pE8arde9F+ML07SmVlz
         j4lPoNLb2/c01UZcExrp+3wEBMQb/5Gowpfr3RWRZP+eRvuEfPX48TBCCrnLZ2VfiSgb
         7y0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=G2MSpHN+OgTuVkTkfaadPVZ4uyPRsDUXgqMIPwUf15Q=;
        b=fcClRc39JxYA1iog1hpfnxBlccmE6dbRUR5u7Bq1y+EZYegeHLqFkkGD281IKtrynS
         6oQH8xR0Cmcuf1sroNY0GhJ7gbXCkl8RaNIcqxofhztyY9xnK2bPQyjZNP6F6eKzJ1qV
         U9Fc1CgZGGA3d3zUTciMmb2WFTuc4e8HC9csuXO98+r8NPg84qMlzDQHPa+u7o7YwIoc
         TsZRjNEgh9uOmlB4V5OkS3GSdeTFl03CRHh4BfYIJDCRD7AD0o6zeCQgMgtQGP7VbFbG
         qCrZ6e9STg4tf1AT5h+8KZdTYNbIGPxVfYVLUlDeHHiEFYAiwWuxF5RE8mVDhAXXuL4I
         PIZQ==
X-Gm-Message-State: AOAM531U09E3GnEsEU3kXcvCP9cfWAenluNYTMxnAbsCfuWiJx4Mwakn
        i1V+ZHsmCyhbp3fQmVKMHJFGaQ==
X-Google-Smtp-Source: ABdhPJywGbjAovBweNF37d+UBZ1ETPn4IZ31WDdUnnLqR+lNbOv3OZiu64yDFjPl3Up3W0PBo7XKng==
X-Received: by 2002:a62:9215:: with SMTP id o21mr2156994pfd.268.1598685710666;
        Sat, 29 Aug 2020 00:21:50 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id y128sm1582419pfy.74.2020.08.29.00.21.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Aug 2020 00:21:49 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <9EDDAFAC-52D2-4FE3-958C-5F57DD0792C0@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_A34A9549-DC04-4DFB-8572-37CBD4BC080F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] [v2] ext4: Fix error handling code in add_new_gdb
Date:   Sat, 29 Aug 2020 01:21:46 -0600
In-Reply-To: <20200829025403.3139-1-dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
References: <20200829025403.3139-1-dinghao.liu@zju.edu.cn>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_A34A9549-DC04-4DFB-8572-37CBD4BC080F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 28, 2020, at 8:54 PM, Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
>=20
> When ext4_journal_get_write_access() fails, we should
> terminate the execution flow and release n_group_desc,
> iloc.bh, dind and gdb_bh.
>=20
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Looks good.  I also reviewed the other error conditions in this function
and didn't see any similar problems.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
>=20
> Changelog:
>=20
> v2: - Remove changes to ext4_handle_dirty_super()'s
>      error handling path.
> ---
> fs/ext4/resize.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index a50b51270ea9..71bf600e5b42 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -843,8 +843,10 @@ static int add_new_gdb(handle_t *handle, struct =
inode *inode,
>=20
> 	BUFFER_TRACE(dind, "get_write_access");
> 	err =3D ext4_journal_get_write_access(handle, dind);
> -	if (unlikely(err))
> +	if (unlikely(err)) {
> 		ext4_std_error(sb, err);
> +		goto errout;
> +	}
>=20
> 	/* ext4_reserve_inode_write() gets a reference on the iloc */
> 	err =3D ext4_reserve_inode_write(handle, inode, &iloc);
> --
> 2.17.1
>=20


Cheers, Andreas






--Apple-Mail=_A34A9549-DC04-4DFB-8572-37CBD4BC080F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl9KAgoACgkQcqXauRfM
H+DdZg//a+1K6sGK8/H73C8h7/R9fnvH6cntaUve5o1D4TwrC7iWqSE2deP5VWLt
XU5nbIqQ0ZQjBTXm3Iio+P1kG7l73xdoxnummeswPmgzJYkx30Ll0ll5AvWlGYC9
NU/FVnvxkEBpAV8LCx4F0oYQOTS4ohQ4F6EBZ3LYQ1nzR6Gwp0hGlucYCZLvo/rd
DXCHzfAViptT5UZnXkFtp3acGvtbf7Bkm6/4UTf9UzEKasLL3kTX5TFs5yZsh4R8
IDHRY8mVFATf1dccyk6cScLHGp1NuHct7nW6O36c5Mh42tMoWCXsg4exwt/+OF30
aVvrQ338qtm5nlGjJ41gMwJ5CK/UaW6ik38ncd2Z4+jskWkjBk+1NK78XHShgDp+
NtqmuvKAJljzlUI/7E8VfhayiPug86ZPic+hH37p+EcN59NqvWWTSWfQCBMSICmY
6zvjB9CFw46bWLeEAdj8W3aIMWTXa0eOIrrxlIzHlR+3ob26TL9W5981XKOXuX1V
Hkc2i7Ib6WP37bDEqQj2qzhVtd+YLFmkKvVnXZ+oeN0fHQlzyAUltgW0UATiCbZT
3Maby+r04JlS2EwHMWSg9dGVql8H72b5/1b33SYDIaDmke7jB3/fYY0LFG5o1GU6
xdwRa1K37omaAhVNOG6/iGQua5e+kCdaoTD6WK0iO9w+0WTQfpA=
=4rkn
-----END PGP SIGNATURE-----

--Apple-Mail=_A34A9549-DC04-4DFB-8572-37CBD4BC080F--
