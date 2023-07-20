Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B9C75BA99
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jul 2023 00:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjGTW3P (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Jul 2023 18:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGTW3P (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Jul 2023 18:29:15 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0150210A
        for <linux-ext4@vger.kernel.org>; Thu, 20 Jul 2023 15:29:12 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b89b75dc1cso16672705ad.1
        for <linux-ext4@vger.kernel.org>; Thu, 20 Jul 2023 15:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20221208.gappssmtp.com; s=20221208; t=1689892152; x=1690496952;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZBYvQ+Q7KCi3OcX/BsHTCCcIcEnWb+SsWxZuRP5oDs=;
        b=WWBSUnfbSFAONQmhb+ogFu30MmbVerFnp9DWovMx7BHBvIWFXgjqRl6Y24qIcZewXL
         BxzrsKPRVw4ZraaWY/w9EyC1HUUKmsP+uV393r/8B4LJQMbt+0NP6oXZSvz+wpg2kkjX
         pMv3HnUcSh323Cij2LFsru9cHdu0CA4w1ZmxNaKU1tRniBM8f7z/rIJwX5gIJxjalfvy
         09i0LsMy4dowl2apZfMblszPFP+jSfjlCW5Cmxkt+TsLUrn9OW79BVL7cAoakjBou499
         BMTWc1oe2ik1J4eDUGUYl2071Rjk54bf9bXmh3bSNAUU7XKm7g8h406na4/Lha+SsDz7
         KiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689892152; x=1690496952;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZBYvQ+Q7KCi3OcX/BsHTCCcIcEnWb+SsWxZuRP5oDs=;
        b=BJjLLiv26wsvcskt88VjG/Q+GrOmwLpwWEH6T1QfoFm47aG7rj8YR/k5lhx9Et4dAI
         aK5HU3+MWJjhdAckMuV+XhK757DWyB/91AE1NntkRBJZNGCAb6Pg91loQ8f5dpMLvfBG
         SqtoMdmCB3AqtTsQcRKME3q+8S7F5ZLCQuhFTrGs0LKFgFwZoAzs+mWkX1P2YQljNOi1
         y8g1slOTHutcmIBemasrvn1oCwj9rlxMJC6rXTCSeEtdscXvGR5yym69f1sMcKf2flj5
         gKDBPCVM7aC7/ktFBaM2y/3pufxpJ51pVp07nbad9QXbMeeUPFE06tIvLU6Cnh5xVZCs
         O0xA==
X-Gm-Message-State: ABy/qLaLTPL9sSBTPaF6+TenBUHAaaVigY4IE/Zis5usSVHucr7aepK4
        Wg4iCQJQwH7JvYYLrEi+hftg8Q==
X-Google-Smtp-Source: APBJJlHx8TV1JyD5hU6NSEufn+IYruL9u4tU9X5Sii4ha2GlKlRy7fZlusWdaN4Ie2rLdZKDDcDhwQ==
X-Received: by 2002:a17:90b:1d8c:b0:263:161c:9e9c with SMTP id pf12-20020a17090b1d8c00b00263161c9e9cmr1048933pjb.12.1689892152390;
        Thu, 20 Jul 2023 15:29:12 -0700 (PDT)
Received: from cabot.hitronhub.home (S0106bc4dfb596de3.ek.shawcable.net. [174.0.67.248])
        by smtp.gmail.com with ESMTPSA id rm10-20020a17090b3eca00b00262e604724dsm3068776pjb.50.2023.07.20.15.29.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jul 2023 15:29:11 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <4BAF012D-8C54-4382-8F73-F5628241328B@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_E91825CC-AC33-4EDC-B94E-9EB6A43F086D";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext2fs: make sure we have at least EXT2_FIRST_INO + 1
 inodes
Date:   Thu, 20 Jul 2023 16:30:28 -0600
In-Reply-To: <20230720125012.641504-1-dongyangli@ddn.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Li Dongyang <dongyangli@ddn.com>
References: <20230720125012.641504-1-dongyangli@ddn.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_E91825CC-AC33-4EDC-B94E-9EB6A43F086D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jul 20, 2023, at 6:50 AM, Li Dongyang <dongyangli@ddn.com> wrote:
>=20
> When creating a small fs with 100 1k blocks, mke2fs fails with:
>=20
> Creating filesystem with 100 1k blocks and 8 inodes
>=20
> Allocating group tables: done
> Writing inode tables: done
> ext2fs_mkdir: Could not allocate inode in ext2 filesystem while =
creating /lost+found
>=20
> Increase s_inodes_per_group with a step of 8 to make
> sure we have at least EXT2_FIRST_INO + 1 inodes.
>=20
> Change-Id: Ib885735641dfa0ed9c6f6a4a1f9afec291673126
> Signed-off-by: Li Dongyang <dongyangli@ddn.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>


Cheers, Andreas






--Apple-Mail=_E91825CC-AC33-4EDC-B94E-9EB6A43F086D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmS5tYQACgkQcqXauRfM
H+Av9g/+MgbapoJk39ScY8fVQOJY08vy8De1naPBJf3IGsQXWMnCed2s4CC2Sy/D
nLVZXuPZS7BaO5wmnwe/2nlTh+V56h2RNMJ06vt0YTkbCa3wjTNcdS3ukhTJlS8f
prBryOhxN8LTU77jkhtLai1rertpjeCTEW1sZAudSaf8BNB4vy+F/vaCfaz3L+VJ
IghR1nuPFQDCyJ8JZJPp8xLYqXLdj5a0VMi/5nOc+Ct27jle/DNtcbIidGfY8zQm
xFvVv9YBwdxzA35NNa5T7YapQtrCr+K31tpRfQtbk0G3P++h/aiQ8amEqUCrP9uD
SDDFx3DwE9Xfwolq+5RjMv0qrWF0H4XM9xbDGnvpm60zzfx+Nbyu/gbU5i6672Jy
bMFEsNOkkeygXMwh93PvTLU8yHxbbVqqaLmZlcRB5QjGwRHBgUIKPye4ctgNprEK
Skueuxt2dGxIjo1JUAd19pvUxyCFm6cgu9SvMcN5AO0H/+rYqiVtixorWT9qepbn
8X16aILrpzV5EjRULqakz2zk7w268xGUfi3MTIdLwrMOXqNLFmRIh5HSA0VQf4pC
KativsUVsQJRY0fAnIx1DW1QtQWgizb004NIKomA9+Q626qz5wnjFuDZvC+6brvv
VzF0G9hwBFg25p307ImhlUqJv+W2PX6KRAt3XCqgYAk66dSdbgs=
=ZsR8
-----END PGP SIGNATURE-----

--Apple-Mail=_E91825CC-AC33-4EDC-B94E-9EB6A43F086D--
