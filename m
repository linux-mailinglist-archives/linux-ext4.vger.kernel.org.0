Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371546454CC
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 08:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiLGHoj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 02:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiLGHof (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 02:44:35 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA08C270E;
        Tue,  6 Dec 2022 23:44:33 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id t18so6478426pfq.13;
        Tue, 06 Dec 2022 23:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TYcJedqceCKJCpFPFxJow6CSmDipVKauFhPeqGOV/Tg=;
        b=PdDjmJl5uuQye6jtbYIsbO1a4xzZy49l/O6OZlD+8bdEJmqnjD/zsM9HMr530wRvT6
         hnVfFXsI6cXv77hgZcdffmalC0t18vNtbH465BaymYLGVdGr0kp4/Hj7vhv3OZrMovup
         NznZeyKou9WrKo4T7pqmM6YpYV/O+rYMhYj00ZyxJEse2DDiy9w+zW6Hho/xJzF/WMDa
         4gk3gy8E3JFpkrvLfdOhdDHQzLVIhsCiPoLcjGVo9f/tS4f2zZ4UzzaJduTZ7ACs58kl
         tgvDk+/MA0cH9SuKsbm0z8KuRcAS72XKzofUwIR2kJtm47t3/6qJv7BxvdWf7YP3Vjyg
         rLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYcJedqceCKJCpFPFxJow6CSmDipVKauFhPeqGOV/Tg=;
        b=nqEOf8Wkn+qMxdf5hUiGt9L6rblCdSOrFfojHIXf6gbJNJYg6/7EwT+StZCJB/6rVb
         G3lAo7qDD5LkpWAt47QolU4GA2xCAEA41IAlVA/MWhS4nm0j5y3kl3mqLMgiUjRzRn/F
         n2KGCtP6/OSZrGu4A9cSnVtG/shKLVbuHKn91oWWgSNGsGpO5eDNsSjmLecTqGwG4v1c
         txB4wl+bolYZk5321SVd1D+U13Q29XxxhhyK/qqoiocaUpyrbS035Z9bZXQdxZia6GJc
         TnhlR8GwcGIz5dnc5iPIye6F1D3VUADDDryZZ6B8i1NaWnhKm/oX9xsE7V018KgJ2TbB
         4Xbw==
X-Gm-Message-State: ANoB5pkPqbtiB5lt6fahw90IMDrl5QC51VjoW9k4alo06YiTZ7rYuXqk
        Qi0C7G02NH/JW6wPMXZ1Pgk=
X-Google-Smtp-Source: AA0mqf4cpKsnKtBYCs/kxCCvXfCAD7/3g9icCNgsAVArpgoFDFUzzvBfcI/io0QmO69Nv/QMGGCeaQ==
X-Received: by 2002:a63:4d2:0:b0:478:95ed:5d6d with SMTP id 201-20020a6304d2000000b0047895ed5d6dmr17942333pge.162.1670399073237;
        Tue, 06 Dec 2022 23:44:33 -0800 (PST)
Received: from debian.me (subs02-180-214-232-19.three.co.id. [180.214.232.19])
        by smtp.gmail.com with ESMTPSA id l11-20020a170903244b00b0017f592a7eccsm13855818pls.298.2022.12.06.23.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 23:44:32 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 084541042C6; Wed,  7 Dec 2022 14:44:29 +0700 (WIB)
Date:   Wed, 7 Dec 2022 14:44:29 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH v2 6/6] ext4: fix inode leak in
 'ext4_xattr_inode_create()'
Message-ID: <Y5BEXTyXkVh+XZW1@debian.me>
References: <20221207074043.1286731-1-yebin@huaweicloud.com>
 <20221207074043.1286731-7-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3ch33433gQYX2hYg"
Content-Disposition: inline
In-Reply-To: <20221207074043.1286731-7-yebin@huaweicloud.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--3ch33433gQYX2hYg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 07, 2022 at 03:40:43PM +0800, Ye Bin wrote:
> Above issue occur in 'ext4_xattr_inode_create()', if 'ext4_mark_inode_dir=
ty()'
> failed need to drop inode's i_nlink. Or will lead to inode leak.
>=20

What about "This occurs in ... . If ... fails, dropping i_nlink of the
inode is needed, otherwise inode leak can occur."?

--=20
An old man doll... just what I always wanted! - Clara

--3ch33433gQYX2hYg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY5BEXQAKCRD2uYlJVVFO
o9S/APwNWBjguUmtCD77SDwA2SlTP2eRYnR7mT11nojNnMH+BQD/R1DMOhfiOy73
HCaHV+bfSnnne6L5P8T7i/fYkP6oHAU=
=V10K
-----END PGP SIGNATURE-----

--3ch33433gQYX2hYg--
