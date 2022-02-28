Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887F94C7EBD
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Mar 2022 00:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiB1Xvp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Feb 2022 18:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiB1Xvp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Feb 2022 18:51:45 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A01E129B8D
        for <linux-ext4@vger.kernel.org>; Mon, 28 Feb 2022 15:51:05 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id w37so12920151pga.7
        for <linux-ext4@vger.kernel.org>; Mon, 28 Feb 2022 15:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=JIFhTZQYfXGzvj3o2oiPah4uDpidN+4Vk8BgfQIYtYc=;
        b=CkDKiCRgjenAQuEIRmaZdz5ZCHOSFyeDjhmtm1p3EyBVru+NuNmP0UU7u3+HcHwJh/
         k5gu/QfOIy/5rD9k7A/7o6Ijp1zTcujwuHqvtGzMV5gRWDrhuUPyttrS/045CktUqmsA
         4pATxE286U4/SRU+o+Epxs6gyosmw2vLzHNaFgZxUPWzMSf4+qdxSYpt5J+m2RhFm7YX
         6SuZGsqWiZa2o8ztNNUGucI1IDJNb2KPqfnM3Mbo1H4cxjE9Q/CrJbC9dm+Fv0+P6LCH
         ambJT8EA1JtmXi9SF9UQuGgaIHqY9eWAHJKEXmLtyn6727H01oNq2SkczVaGAnfJe8I8
         bdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=JIFhTZQYfXGzvj3o2oiPah4uDpidN+4Vk8BgfQIYtYc=;
        b=nVy6CKW4HJGupVyosDOf4cu/eX7sT3AJ6347qTP77Tb6b6/koWVK7TrwqR/5h7IyXX
         mBujbvBFJIW0LGXIHx2Wx+t/6xctYdvrM2JycP8nwHZh/2qQkLIxk6JQyyp5pjZM9eXM
         jRO43yAzv2f0FDXYFk36DqADW/MW7TENXrj6qfan8ujsjFm6voUYh55MiyQwjiFxJdDL
         lE0ZN+qwTwSS0dRa1JD1HdVLfFg09z559ABRhB+2htiiIoK6JV625YdiB3u2jkWks8O8
         d89un0u7oXjsl53EKBAUpNSZk8mn5CEjefroivmUdMa5t8HkjbxNUuQbPf4frXhB2ogE
         0UXA==
X-Gm-Message-State: AOAM532FiM23Z08S4TNgCj6xKbxN+dSG+vJ/aRnubv/eHWS55d72gRZk
        kPZSE3fDsf39MK6i8SBbiybuXRQ3wsqHag==
X-Google-Smtp-Source: ABdhPJw4frKCkE0KA0JkWYXCFt3Hk5TMyA4wRFWQQIijaKlY288fl9OVR/yGmSNrACBNPQTOW+QN2A==
X-Received: by 2002:a65:6d87:0:b0:374:2525:dcb0 with SMTP id bc7-20020a656d87000000b003742525dcb0mr19694058pgb.248.1646092264815;
        Mon, 28 Feb 2022 15:51:04 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id u25-20020a62ed19000000b004f140515d56sm14213333pfh.46.2022.02.28.15.51.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Feb 2022 15:51:04 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <80033488-0412-42F1-B63B-3C2E118A5A74@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_E0D88842-DB4D-4414-B28D-FA9C1B92CAEF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/3] resize2fs: remove unused variable 'c'
Date:   Mon, 28 Feb 2022 16:51:03 -0700
In-Reply-To: <20220217092500.40525-1-lczerner@redhat.com>
Cc:     tytso@mit.edu, linux-ext4@vger.kernel.org
To:     Lukas Czerner <lczerner@redhat.com>
References: <20220217092500.40525-1-lczerner@redhat.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_E0D88842-DB4D-4414-B28D-FA9C1B92CAEF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 17, 2022, at 2:24 AM, Lukas Czerner <lczerner@redhat.com> wrote:
>=20
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> resize/resize2fs.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/resize/resize2fs.c b/resize/resize2fs.c
> index b9783e8c..d69cb01e 100644
> --- a/resize/resize2fs.c
> +++ b/resize/resize2fs.c
> @@ -2847,7 +2847,7 @@ static errcode_t =
resize2fs_calculate_summary_stats(ext2_filsys fs)
> 	errcode_t	retval;
> 	blk64_t		blk =3D fs->super->s_first_data_block;
> 	ext2_ino_t	ino;
> -	unsigned int	n, c, group, count;
> +	unsigned int	n, group, count;
> 	blk64_t		total_clusters_free =3D 0;
> 	int		total_inodes_free =3D 0;
> 	int		group_free =3D 0;
> --
> 2.34.1
>=20


Cheers, Andreas






--Apple-Mail=_E0D88842-DB4D-4414-B28D-FA9C1B92CAEF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmIdX+cACgkQcqXauRfM
H+DyYhAAgCidfN3VyApCZyu5XgoLnK6AzNtMhuLMnxd6tRn3YM90+zD/Musn8RD4
LFFEafLAWV0WuArFzPKG463cS80lFKBpWiy3PZapjE3NF44kMeWM9vOINdK7NyGw
71kp2lfwKB63iiGMux8ilI7jl2h/WHB5uYjjRWm0unJ+lz8qoh7HDspaQId0dSpG
Q/x7bzYAdyeD6CztjuL8/i0mOTfYl27BtWXa8u6UIel+6TLi61lipdlv10VWM33l
nA21svJ8RECs2Ci9eWJMeXtfWzPoegAsYx92iXTwbwQWlEtXkhBUdbajAr9cc+m9
OggCbO6sFtmxBJEtnVKMNm4wgDmFV8Hd6DGBqUpQTyfiTNwGy/wiPvxtdzOxOGeJ
BkIL58qaJ8HJWYzqm3FsGJYddSkhyAPzNVdjXMbpJlDgD+4/uozctXiC2I7FzlVU
6VdoVaoXrte6YemXM3VNgp0o5oAoV/Y/69w+fBey8k2N/oZHTU8PuzwgurKErMFj
Msx1Ycrf7hLFPE4iFdNnb9wSlT5GSV2z4ly93KTfTNSjQBBBQDKa6q6GZQm3rhOh
mzm1dMjWSMXsZa8kq0p4nlmrSE1p5bgv5l6wHQilMXTFUPbIoKD8bzN0DTXPYdeZ
jeR48j1e4LI2BF045bMd7GuMxcLj7DH2byPiPdyoMcYtLX/NT6g=
=sRXX
-----END PGP SIGNATURE-----

--Apple-Mail=_E0D88842-DB4D-4414-B28D-FA9C1B92CAEF--
