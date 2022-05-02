Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E225171C0
	for <lists+linux-ext4@lfdr.de>; Mon,  2 May 2022 16:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238218AbiEBOmt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 May 2022 10:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238156AbiEBOms (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 May 2022 10:42:48 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF0C60F3
        for <linux-ext4@vger.kernel.org>; Mon,  2 May 2022 07:39:18 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id x12so11832980pgj.7
        for <linux-ext4@vger.kernel.org>; Mon, 02 May 2022 07:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=kl9nEeqRLcgu01H4ZOIHZK6NUOxpP53BQCGiLXtjjSE=;
        b=mn6qj/YE55HbrgSIYzGD3VKl1DHOp5rWGlbilRWa6IEa2GwZFz3gTdV0lWTiI2Tlvt
         HS7FJqBEMlUIijMUGmOeaSsovsvhB/0TdTHzUG0j3ZNG3e0qK7CcAd+PrP9NGme+92D6
         mAvRTO/ze8S9GX5B/SyDceX+N3cK77JxsqrXxsesr8PEi/8kDNqLfYG0x3TSBqVaX2TT
         pYgQyxKb0o3NkhcQnAKVIm5qxWI0nIgTcTgJ1EvnYwFipjc1QUOMyAH//rAVymJ9tVhN
         uJRYOg+48zm1d8reGYWHiD7qnFT2/Kx6V59M6SUgpAjYV2MS4O6btgc/XXz8ddgSBDoc
         yeuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=kl9nEeqRLcgu01H4ZOIHZK6NUOxpP53BQCGiLXtjjSE=;
        b=PGULFI308EGEjg6iRW7I7DPMbFtyY/gkunTO0FGQkiO1e9XujRDY6oExYXFIzcts7m
         /4X5ijXp+tIm2rcWnb8o8t0qwWvFeb2AjR9Q3txHLzvr8/ZduvI8/HqhL+ulxb7Cy6pd
         V9M6rdMScOuZK6mKJKXCr4/bcl06VRgfAOKHbdvAbydLQb4N5xGcyxkMeD1qa9U2wXP9
         LH9WwH1t26yOx3z79c8mwmDFHjaWs5jmefOuQO7DkHhACqHtNV/tH4vi8IvS+DX8HjgM
         JQOfX9LX0NIR2JE5UM+A6mSYrcvd3luz5636jvh0HzL0DXZY5lTu3BB6EI5/aEQQwLVF
         Aadw==
X-Gm-Message-State: AOAM5304ELsYLeVCysLOYPmnsEo2nZ4wCI2RglFq2pC9Deu6SmDPkYp5
        oe6FGBZyEN3hZngEYJTT8oUnKUj1XmxlpPMY
X-Google-Smtp-Source: ABdhPJxSkkEkYarCAP+QfG/BJcyArBxP0F8VNzh9yHlG/mjkpl1wpKQyQuNUiJFKEgClJ+aQbmVQwQ==
X-Received: by 2002:a63:2c94:0:b0:3c2:4b0b:e1d0 with SMTP id s142-20020a632c94000000b003c24b0be1d0mr2091800pgs.186.1651502357455;
        Mon, 02 May 2022 07:39:17 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id y17-20020aa78051000000b0050dc76281b2sm4922321pfm.140.2022.05.02.07.39.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 May 2022 07:39:16 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <52AD4874-2819-4613-8E91-39DE3FF98EF1@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_F635B574-C536-438E-8BFD-24ACD83D61C7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC] LUS-10810 e2fsck: use bitmaps for in-use block map
Date:   Mon, 2 May 2022 08:36:37 -0600
In-Reply-To: <20220423014216.34032-1-artem.blagodarenko@gmail.com>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>,
        Artem Blagodarenko <artem.blagodarenko@hpe.com>
To:     Artem Blagodarenko <artem.blagodarenko@gmail.com>
References: <20220423014216.34032-1-artem.blagodarenko@gmail.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_F635B574-C536-438E-8BFD-24ACD83D61C7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 22, 2022, at 7:42 PM, Artem Blagodarenko =
<artem.blagodarenko@gmail.com> wrote:
>=20
> From: Artem Blagodarenko <artem.blagodarenko@hpe.com>
>=20
> EXT2FS_BMAP64_RBTREE is too expensive for fragmented prtition,
> that can lead to situation than e2fsck use swapfile.
>=20
> This patch change EXT2FS_BMAP64_RBTREE to bitmap.
>=20
> Marked as RFC because it must be descussed whether this flags
> should be changed by default or some additional option or
> a heuristic is needed to contol this flags.

Artem, I think switching over to a bitmap would be worse for the
case of relatively empty filesystems, and would likely increase
memory usage for many full filesystems as well.  For a very large
filesystem a full bitmap might take tens of GB of RAM per use.

I think a better (but more complex) solution would be to have a
hybrid model, where an rbtree is used for a group if it is more
efficient, but once there are too many fragments in a group and
it consumes as much memory than a bitmap (4KB) then it would be
flattened into a rbtree leaf that is a 4KB bitmap so it doesn't
keep expanding.  That would give the best of both worlds, but I
have no idea how easy/hard this would be to implement.

Cheers, Andreas

> signed-off-by: Artem Blagodarenko <artem.blagodarenko@hpe.com>
>=20
> Change-Id: I6a906b5e54cf40eaba82624d8e4c2b0f90132813
> ---
> e2fsck/pass1.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
> index 26b9ab71..563dcdc5 100644
> --- a/e2fsck/pass1.c
> +++ b/e2fsck/pass1.c
> @@ -1247,7 +1247,7 @@ void e2fsck_pass1(e2fsck_t ctx)
> 		return;
> 	}
> 	pctx.errcode =3D e2fsck_allocate_subcluster_bitmap(fs,
> -			_("in-use block map"), EXT2FS_BMAP64_RBTREE,
> +			_("in-use block map"), EXT2FS_BMAP64_BITARRAY,
> 			"block_found_map", &ctx->block_found_map);
> 	if (pctx.errcode) {
> 		pctx.num =3D 1;
> @@ -1256,7 +1256,7 @@ void e2fsck_pass1(e2fsck_t ctx)
> 		return;
> 	}
> 	pctx.errcode =3D e2fsck_allocate_block_bitmap(fs,
> -			_("metadata block map"), EXT2FS_BMAP64_RBTREE,
> +			_("metadata block map"), EXT2FS_BMAP64_BITARRAY,
> 			"block_metadata_map", &ctx->block_metadata_map);
> 	if (pctx.errcode) {
> 		pctx.num =3D 1;
> @@ -2456,7 +2456,7 @@ static int check_ext_attr(e2fsck_t ctx, struct =
problem_context *pctx,
> 	if (!ctx->block_ea_map) {
> 		pctx->errcode =3D e2fsck_allocate_block_bitmap(fs,
> 					_("ext attr block map"),
> -					EXT2FS_BMAP64_RBTREE, =
"block_ea_map",
> +					EXT2FS_BMAP64_BITARRAY, =
"block_ea_map",
> 					&ctx->block_ea_map);
> 		if (pctx->errcode) {
> 			pctx->num =3D 2;
> --
> 2.27.0
>=20


Cheers, Andreas






--Apple-Mail=_F635B574-C536-438E-8BFD-24ACD83D61C7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmJv7HUACgkQcqXauRfM
H+BDnQ//evYGmE2GhvfB7BgHqjZVI1UsoSQvpw11PxMcdxDqRcj5corEP3sagIz0
ApnjRbaHLITDCKzwBdr6ktGEQvuuGTByQIkhLP5K68DppWfR4I7G804hMsKg2CG0
3JmRFccMXdRCtRMJkfh0XLaaSaGiVkgPlhMZjTKe9Cx+PhwhdoTLaav/Dm+ljivY
T61JgFjAfiQ945q/VVwma0zlZ/Tllhk1G0j013CXdX6ZsDAlzS29ORhpJTYYC17B
O/M817Z1MPA8SIPd8iqCyFyG6hrXpSWbGZDb4pInkRMIhrMBklE+0Qf8ZIoSk4Qq
DqT+ah0/yoiTfSLxMTCD4kAQLbyEJuvP3drxHIGWvKHxePkfpt1SW/rFEbTXWkli
g3vRXGYmMQEN6i4WorwrNmX3pbfh6g06eNdA2Fa9FClpl0NYl5Y+OeGeuHsKEchU
sUvX54wfopQbxzk55H/wEmgQj1PIdYqCFccpGdIShuSFL36LG8A+m9pV0l9X79V9
f+PUiVeLMvuw3aHy1/2gd7tDsjwlG4lHniojTiATYr7Gn+9F7ssT6LE+A5bsRN/W
iEbTIOquTiEWv82tO7anrGZzXU1LEnjs4lNCguBPNLKik8WsR9c6aFdsuph5y9/y
bMZCYqy2BTTX0JwM0X8iws+xbmo2YUftpxjNtm7J0dXIjUK9jvA=
=4YET
-----END PGP SIGNATURE-----

--Apple-Mail=_F635B574-C536-438E-8BFD-24ACD83D61C7--
