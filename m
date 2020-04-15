Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA621AB06C
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Apr 2020 20:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411722AbgDOSPb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Apr 2020 14:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406366AbgDOSP3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 15 Apr 2020 14:15:29 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66281C061A0C
        for <linux-ext4@vger.kernel.org>; Wed, 15 Apr 2020 11:15:29 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id e16so196166pjp.1
        for <linux-ext4@vger.kernel.org>; Wed, 15 Apr 2020 11:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=QUr+OeVYcB28uE2Z+pYpdhHxwXESsvjMUD23f0TqR28=;
        b=bTwKqaDdNtIuUdbGqcjb1aHpCQszGysyIx7xZNwSqpMOXRzDQaKyboonUEr+VW5FFN
         4hah47lxoELYZ+qEdU0p/tCaHnlt8o75a7wdYbQg0fMkJiWfWj/SEqGtUYuuQDiZEAI2
         ubVxxlf6exmIRpYOXsOXvVKtQrAXsHfWjzG0A5VrDhIsL0Tsd9ecLlh1ziXG6938cFil
         4fGXP/9Eo5geohl2N4ULJ1zhKUWSJ6tPZE4F2+pwCiZZmKbcdmSAqgdo60sUs749d3Jo
         pe2TB7w/ypQ4Rr+iEkigL3Boc2N5T0JPJcOZkvnOpUEkn3WwjZa56ykgV4CofIuGRCrQ
         eYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=QUr+OeVYcB28uE2Z+pYpdhHxwXESsvjMUD23f0TqR28=;
        b=BvuM+QAkEOYrPEUG+23kSNLOaBqMhJpObbQDazKh/goGRj2MQ+s4UiG8ekNj+yDzEP
         NlCbHo/rVH0L6x3QSBW1N+WeZ2A0d0N5E/i4BNw+JEs+78coct5PIQtPCeBB3Tt+Kr6Z
         02AbbK7NSDkNobxiLsANJey73pdc/QlWirFVRd7GFhQqkFnzd0PzfWA4LOFqT84GyuvE
         5Le3MZJMq+8Y/jSAF/8UlrurUsmvInMvlCtE+5zWntl2/YSkgQhA0IUU5pokyF9VhJFC
         71HIsP9pcdQ+wN8n/IzIEvdFh8I/HU1AorF4FfMk0pFae9QJHhokCtl5WLCEQV5XSClX
         myjQ==
X-Gm-Message-State: AGi0PubsBa8140Tys2nmXh4m+kFy30LwfgTmkA46f8cgBeXCcEHmlxqI
        vcdwIK0ABF8H3IVKsnqDADwJp6fcV08=
X-Google-Smtp-Source: APiQypKbb4EOLIWOO8888FTp/EbX1mBcygefxz/KdNuSFhn9QRPLQz1Sb/LbD3skVRm6CtRl2S0V3Q==
X-Received: by 2002:a17:90a:138c:: with SMTP id i12mr577158pja.36.1586974528607;
        Wed, 15 Apr 2020 11:15:28 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id u24sm11238493pgo.65.2020.04.15.11.15.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2020 11:15:27 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <E6C93199-73FE-46B0-9001-7D43D4FDEA26@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_A080154A-8C9A-4B39-8C4B-AC6E286C4005";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: remove redundant variable has_bigalloc in
 ext4_fill_super
Date:   Wed, 15 Apr 2020 12:15:24 -0600
In-Reply-To: <1586935542-29588-1-git-send-email-kaixuxia@tencent.com>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Kaixu Xia <kaixuxia@tencent.com>
To:     xiakaixu1987@gmail.com
References: <1586935542-29588-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_A080154A-8C9A-4B39-8C4B-AC6E286C4005
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 15, 2020, at 1:25 AM, xiakaixu1987@gmail.com wrote:
>=20
> From: Kaixu Xia <kaixuxia@tencent.com>
>=20
> We can use the ext4_has_feature_bigalloc() function directly to check
> bigalloc feature and the variable has_bigalloc is reduncant, so remove
> it.
>=20
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/super.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 855874ea4b29..60bb3991304e 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -3681,7 +3681,7 @@ static int ext4_fill_super(struct super_block =
*sb, void *data, int silent)
> 	int blocksize, clustersize;
> 	unsigned int db_count;
> 	unsigned int i;
> -	int needs_recovery, has_huge_files, has_bigalloc;
> +	int needs_recovery, has_huge_files;
> 	__u64 blocks_count;
> 	int err =3D 0;
> 	unsigned int journal_ioprio =3D DEFAULT_JOURNAL_IOPRIO;
> @@ -4196,8 +4196,7 @@ static int ext4_fill_super(struct super_block =
*sb, void *data, int silent)
>=20
> 	/* Handle clustersize */
> 	clustersize =3D BLOCK_SIZE << =
le32_to_cpu(es->s_log_cluster_size);
> -	has_bigalloc =3D ext4_has_feature_bigalloc(sb);
> -	if (has_bigalloc) {
> +	if (ext4_has_feature_bigalloc(sb)) {
> 		if (clustersize < blocksize) {
> 			ext4_msg(sb, KERN_ERR,
> 				 "cluster size (%d) smaller than "
> --
> 2.20.0
>=20


Cheers, Andreas






--Apple-Mail=_A080154A-8C9A-4B39-8C4B-AC6E286C4005
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl6XTz0ACgkQcqXauRfM
H+BZHA/9FHNlLnuk4j9U5nBHaygdAd2D6374Vg8VFHr2MJkv9tDw6MTbn78PJAji
LyaLkkGvqryk7X0B4lys/JzwIOKsGgvHabfWCJ8NLKJOpUKs/nNFEJWN+ZFUleZv
2lBFDGmgf39ZIIXSvs5NtkIQNjKw/9PBliWaHMW242MgnGenfr+C1nt/l7RinbR/
hm006NLNJaLfW1nJ9VCnNzu6RHFT9utZaTSQeCJM9ddqsdO/yeioCs+4l9mM4790
u2/HtKJJf93xcrfBtBK4HKJsnBiGrMd9Oop1l1WPWw7ijK2/Eb84UfChZlNSwURB
/6lp+G97XY8s0wYxdzLyfD8ub5kXSnFUZHBZ1NETQFuJUoFMg9a5+p6N0J5gCmCg
gs6TlGv4parkgbb5+eK00HellQI5T/NFpv632iH6mDO3mE//fHu6SSsRA+ayED9Z
RbwU7EPTMT6JuKSxLtBbgcxAKZmOS9Qb1J6NNEgRRk1fPgU69gZkjKR93tvUVEzI
MmUToEK1haLuyPH4WFqZPCihtlaM5jzeUIKv0FRYHTOPh8rmY9w9zxSLTJJv5PVw
A2mX9hSuQ3rJtpuFwl0LOsVGI1MsbDMkkXdZU4jkmsTvtKv54v03ZRSQbqhsdIRF
c+VmdiqHJLuOB4oT0rPG/bcAnOoBJX/6S+0KfMwp0ohFRo3sBS4=
=/ew3
-----END PGP SIGNATURE-----

--Apple-Mail=_A080154A-8C9A-4B39-8C4B-AC6E286C4005--
