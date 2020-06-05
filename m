Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6371F010C
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jun 2020 22:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgFEUii (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Jun 2020 16:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbgFEUii (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Jun 2020 16:38:38 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215ABC08C5C2
        for <linux-ext4@vger.kernel.org>; Fri,  5 Jun 2020 13:38:38 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id n2so4144684pld.13
        for <linux-ext4@vger.kernel.org>; Fri, 05 Jun 2020 13:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=MRK+nECM427h9NWAm0m20lCEejNMAIO4hZa13ZQXlP8=;
        b=p7Csyg16JxH2m9YcTQwhIFjfkGtxQptRlIFkZofctPA8Mex5Q0gKsgm9jJd/KvakDe
         bHUVlif/7l0qxXp1TdG3epuwEPgh56QNjwL3onnj2BppMbz8AtXESYujuPqG3iginKDc
         fn+nWKikMcTirw0AAbMx3qONWLF0smWJgEHWZzXafZNIzLx58mLtbwvmAoOIjXzqbae5
         XEDJNhpoo48frX6jxV+pafGezjcXQR1hH/uGpijk8P9wrsT7DzYgs0mFycLYZf2uAq5D
         ek7gkN1wb9HsFiAYETnlOCth/To03PNWFIqi/mHTEv+/sDo++NJtpBH/p7VKdolVx7Vg
         RIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=MRK+nECM427h9NWAm0m20lCEejNMAIO4hZa13ZQXlP8=;
        b=rHyPnNXn5pX1WIeSEDue9VkTeMGOT/P8zZNB5b+v47yKDrD2OJif3zEEkH/dFE8Clw
         JfpniFqwWwk+O6QdAA4nBfw/Mt6xFyIOO5Mdor3jqj5i/iJ4UivYXimq9Cg8LexNU23r
         1CuFPec5CD4bemx0jAns6aeTN2ISGqAgoVESxoaOYuTWnSkYeXwaN9JhtbZY6GPi0a5d
         iHaHVG8Q64OsdMfpSBMYQZ6T0GoxkupaskkJybdOeoM48TDz9YPXQP3AaIEPiUVBFi1W
         rcBp+ZeQf1QnKIx9qlI2xx67wBs2CxtVWqKyqCJEGbipfJdWD0o6SRsYQOldS7mcNDpT
         OqLA==
X-Gm-Message-State: AOAM5315WVfybiokw2MgJmJ0kxNqeKcpohO4t7BWGLiTzxZnJff3AiU+
        M5L7+yOQK4lFZsMgR3jlPlHEXkAk5NQ=
X-Google-Smtp-Source: ABdhPJwfK+kzFhYptvWb6V/PDEriBGffYCGFJQGRtgNHw7oHa9vAsZvepc8TfCSubDtGUEC3v/Sr5A==
X-Received: by 2002:a17:902:a711:: with SMTP id w17mr11408141plq.173.1591389517503;
        Fri, 05 Jun 2020 13:38:37 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id z20sm8864413pjn.53.2020.06.05.13.38.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jun 2020 13:38:36 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <4204B3A3-A7FF-41AB-8F24-F8B8363FB1A6@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_FBDFB1E4-559D-49D8-8D91-43EED647F40A";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/4] e2fsck: remove unused variable 'new_array'
Date:   Fri, 5 Jun 2020 14:38:33 -0600
In-Reply-To: <20200605081442.13428-1-lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org
To:     Lukas Czerner <lczerner@redhat.com>
References: <20200605081442.13428-1-lczerner@redhat.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_FBDFB1E4-559D-49D8-8D91-43EED647F40A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Jun 5, 2020, at 2:14 AM, Lukas Czerner <lczerner@redhat.com> wrote:
>=20
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> ---
> e2fsck/rehash.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/e2fsck/rehash.c b/e2fsck/rehash.c
> index 1616d07a..b356b92d 100644
> --- a/e2fsck/rehash.c
> +++ b/e2fsck/rehash.c
> @@ -109,7 +109,7 @@ static int fill_dir_block(ext2_filsys fs,
> 			  void *priv_data)
> {
> 	struct fill_dir_struct	*fd =3D (struct fill_dir_struct *) =
priv_data;
> -	struct hash_entry 	*new_array, *ent;
> +	struct hash_entry 	*ent;

PS - there is a space before the tab after "hash_entry" that could be =
removed.
Ted could fix this when the patch is applied.

Cheers, Andreas






--Apple-Mail=_FBDFB1E4-559D-49D8-8D91-43EED647F40A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl7arUkACgkQcqXauRfM
H+A17BAAlVjgNk5azHzQoPgd9mlAimA83VTqL13MRvKNPG0gj282TVXUJYgtl/bX
dTSCCRl0ReMgYuEKxKCmYvhMua5OEU8BwSZB7a3FfqRio3JyUE8AF3pWZClYA3ff
NwFkgbctajt8lspvDf18M42/IohKmnj1fBk/5irfsfYeVXUkHK5PezqfTwU3z94U
YELT2PUi4vJaGkap+uCK1wHDvNpvj6261q4WU/BAfWEyi1WAZmYTi+HCOAwVImqO
oK5u6h8y5sA4y20d4iVOV8LwUTo2hc9I+1GrpHKaC9gu6hmgWWviH6uyyCiqYGMD
qq4XiTdYq4/YRi8G2bF+6ySCuW9eXzFSMPXgPFs8NYe2zvlnwY4PUWLMgfI6uicx
U4aqJq+7X1nZXbh/zDxadHvLMqdXa/Oic0xpAxujsLfr1G+hLRORFRfpPn6wwTU0
ao0hlDGHoB8VldVraPq2IRp4GnzvV9PsvjF+5mz7TZNNqRTWfrDu5yeba+qtEBcN
htSJxDHbwtHLq/vjoqAU2iDvBttzgSIr8XxDBDM8FrDTWopWb0Mg6HGRVeb99f0/
5OkvJRCbdBnSKr8yaeE0uQ8BP4tEF/0RjwhQ14WRFRdus2yfua6ZydoB46UVt6zl
3oDzrfggLlcFUCa3lEpdvQE2Ms34qn3ljMg2RgJCh2Ocla9c260=
=dlyv
-----END PGP SIGNATURE-----

--Apple-Mail=_FBDFB1E4-559D-49D8-8D91-43EED647F40A--
