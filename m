Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C4064D1B1
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Dec 2022 22:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiLNVXC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Dec 2022 16:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiLNVWu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Dec 2022 16:22:50 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EE836D4B
        for <linux-ext4@vger.kernel.org>; Wed, 14 Dec 2022 13:22:49 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id fa4-20020a17090af0c400b002198d1328a0so4863900pjb.0
        for <linux-ext4@vger.kernel.org>; Wed, 14 Dec 2022 13:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jCaNrrOUktAJ66VCvUIOGQpKPUDI0FYu8AzWwGjXkAs=;
        b=XMiUmRA4ULv7UmZlBVCnEMrkWLAxb4tkpnGqGdUJLv539x+Kl39yCqi84gN2vywLzw
         L9fvl0pOlhbLeb6yAE0BSnODs9th7NDRnLndhJWWLuY7vltZsOdwVfgLbdijcNVZU2XT
         bzxPha48GzSlfgwA61tAo7sD3RNMFILw/2hBAR9+9iBRmbfWxpzkRzMtvmkxaByOFR2x
         PcbeY39df7dey3dhC+HLILYBxAbeStL61DSp7WsL46qeXHzcqf59e87Jwex72uNfA1Bl
         aJVnq8rA2ZjFeCUwOQdrOVyksjNuIBdLTq4UZTmTwca4YZvL/Huw7cfQr9hwH5UAl0Ya
         Mj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCaNrrOUktAJ66VCvUIOGQpKPUDI0FYu8AzWwGjXkAs=;
        b=zx8DRF0+yJnPOEq4hPwjS8zn1hDOZ82UlLg2hrtbtQnp+lZDmpdnG7OYz5NcOQlZLf
         cPobo2Gx5fyMN7xNv93pt2lz/DeuNP3AKH8AnB+XZkagB/3gJGm6imNE7OE9VwluZ3rC
         ZmRJBYq9eSYHZNOL1cKCO4hPqzTQG6TxfiX7zH7iwSnXR0N+AmKIWaXKM6Kvl3gqNdtO
         4N404WfwaXUPEzkfyEnNLGEjp1jGDc+HdJQleMWcUpMsNsWI6R2sGsgaLGl9zTZ0G50H
         9uVHCI1zlXVz7wTl6L+xNzvb9hdfsRZf2cP5m1Vs560EcaQABg2j2eZj/3fq5JZzn5dw
         /Iqg==
X-Gm-Message-State: ANoB5pk5eNzNnqEixjZ9b2r2ChL7ZncNv9QlM0IpY59EwldRVQPe9b0y
        EB+Re14lBFIo8cdBVSnDZ/OeRA==
X-Google-Smtp-Source: AA0mqf75upGG053cpR7gyjNWBzGVb/Uz+kRTs06Yv340fOd2n8A4mWtpi8OqvXUyduFq5MdBnjHfOg==
X-Received: by 2002:a17:902:efc2:b0:189:76ef:e112 with SMTP id ja2-20020a170902efc200b0018976efe112mr25326667plb.41.1671052968458;
        Wed, 14 Dec 2022 13:22:48 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902784500b001885d15e3c1sm2314435pln.26.2022.12.14.13.22.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Dec 2022 13:22:47 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <37DB544F-6224-4513-AF46-E1DFF06E5E01@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_B909F056-4FC8-45C8-A831-3836BA4D19AD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFCv1 19/72] libext2fs: Misc fixes for struct_ext2_filsys
Date:   Wed, 14 Dec 2022 14:22:45 -0700
In-Reply-To: <d9c1ee96a026bfa4652e1c57d7c7dc40bdf049df.1667822611.git.ritesh.list@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Li Xi <lixi@ddn.com>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
References: <cover.1667822611.git.ritesh.list@gmail.com>
 <d9c1ee96a026bfa4652e1c57d7c7dc40bdf049df.1667822611.git.ritesh.list@gmail.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_B909F056-4FC8-45C8-A831-3836BA4D19AD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Nov 7, 2022, at 5:21 AM, Ritesh Harjani (IBM) <ritesh.list@gmail.com> =
wrote:
>=20
> From: Andreas Dilger <adilger@whamcloud.com>
>=20
> Move ext2_filsys fs_num_threads to fit into the __u16 "pad" field
> to avoid consuming one of the few remaining __u32 reserved fields.

This should be merged into the previous patch.

> Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
> lib/ext2fs/ext2fs.h | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
> index 6b4926ce..950ab042 100644
> --- a/lib/ext2fs/ext2fs.h
> +++ b/lib/ext2fs/ext2fs.h
> @@ -278,12 +278,11 @@ struct struct_ext2_filsys {
> 	time_t				now;
> 	int				cluster_ratio_bits;
> 	__u16				default_bitmap_type;
> -	__u16				pad;
> -	__u32				fs_num_threads;
> +	__u16				fs_num_threads;
> 	/*
> 	 * Reserved for future expansion
> 	 */
> -	__u32				reserved[4];
> +	__u32				reserved[5];
>=20
> 	/*
> 	 * Reserved for the use of the calling application.
> --
> 2.37.3
>=20


Cheers, Andreas






--Apple-Mail=_B909F056-4FC8-45C8-A831-3836BA4D19AD
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmOaPqUACgkQcqXauRfM
H+A+vhAAvyqASEu3eiiQzm2Ki4DOo26JuS2zAotNibxDTTploPr+HIxsSs6h/RdO
Wt02IOD1DoIy3j6QsVf2qLEvWBYtrJI/r4VDKS8cOQ8mtQpUbw5BRxmCVRCTRz0l
JTkiCyQe/6FCDRGT/zSZzWRC18N/okODoUOpWpsrNsE/3QqLAizgsk/7HidPue+E
XBlE4SW7XuM+ExqZiFGr1YLS4l1PtJY3xNg+vFVBw2MsFkOE+VLkZ2bXxAtb3esa
pQs0kja5HhprdFpYVXS9WhFrWruHPkNshC5xh/9TdPC71HQdLuy/lQRli0P+ERIU
NuAEs92FVDf9OcAxBHTkCkSb90Wu1YcUaH4SRv8OvcvQjz/Y1z+diI5mR2Yc3oyM
25P8plnsUnL/BB1v9BDivytHD9kWx0qwPOveSZ+vkGmrJD38te5rG2HBCHcoqxgv
W8X8QRBBA6Q96disSDvmVaTO3V8kImGbAgtFlHwPsu079Peq3ZSN4wL4rdJpbrXG
VYHChcfXO4qGI0/6eQqvkoPbj3daQV4AIxAD2yEh82AXR99CzgkkVLvRUJUe56hu
2wpJnAz9WAgUc8uk+vjywAyYEEIrK22CtjSNJYS+zc1wVGOotpGzAGN21JNvNHad
8keamNL6D740eOD8Qk1leAkh7y4b8xxFbg7Tl+T7DetDfiVVZCU=
=Zt10
-----END PGP SIGNATURE-----

--Apple-Mail=_B909F056-4FC8-45C8-A831-3836BA4D19AD--
