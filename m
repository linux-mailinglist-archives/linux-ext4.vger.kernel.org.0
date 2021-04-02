Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C131352514
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Apr 2021 03:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbhDBBWJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Apr 2021 21:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbhDBBWJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Apr 2021 21:22:09 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4086DC0613E6
        for <linux-ext4@vger.kernel.org>; Thu,  1 Apr 2021 18:22:05 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id f17so1884213plr.0
        for <linux-ext4@vger.kernel.org>; Thu, 01 Apr 2021 18:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=E8ffoar+fL+fe86KQoUmq1Ih6v7wT3mkutZg4Ab/B60=;
        b=BKJq2lRvnSp7bYePvIMNoaXQlSqt2NczPI67nUM8Phsv338pezrtymYoxZUYV5785W
         Ngx4jbXKwdpfu8sE1XFA2ZhrQZnPELVOlZ8vse1JFEDlgM6Bgr0UJQbIoPZ6qXHXvedb
         fAwlp1BeZosibu3VCnTl9Tr5hmOJmtEt0f6vdC8mv8IL0rRP3vMjk/a/LMQu9CPwGBsg
         NONz6juJe6ztMnRrJrdg2A4wLuopsrlr4n80bui+neDT4H2Hv0KvD6g/9u++ATIaeCKT
         JnAqWI0dWvVETGj83pakT2NfN4ijG6xAQXc+pe4R+b7hlp3CLfMGN5TiFnDSrFyVGpMc
         pXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=E8ffoar+fL+fe86KQoUmq1Ih6v7wT3mkutZg4Ab/B60=;
        b=ei7nasdaqKpaNURxi+m8rAVEUph4wXXUtDEwUqujdAkLduyFVWjHHJ8cQuZ25vwwOE
         9AO+30BIpMdhVle8mHKhjdLFUFsrlw758PQg+mONVZBOlh0Op33umKG+F3oYzQUNAUpy
         /Dv2fxO0pXbn0axBoNZ/zKn+DpxtxkTI6X28ssVCcckdYlKs/HX1XMrXoPzdQMSypG86
         CxUGAZQus5oWts/VWaH5Br+7dx4FypQzqH+EXEysJJC/KTTPEI0Y6L+BtVXpzzmJpfZV
         5jJwYSYgJPI2onveclP/hDU2I+pBYreFx3dYMfTspCCbGQX25mojtjqunDcAxJLsMjgn
         UAwQ==
X-Gm-Message-State: AOAM533y9FJtud12DWlqRdkpcfRb1lO+sDFrnpIcGE0Y8nnNT/odr4Zm
        pvngb3+fOFqFEz+2n5oDvCeNlSkNCYEpFM+8
X-Google-Smtp-Source: ABdhPJyP53AWpACw5NsWYjVJsCYCxFJIlAs9di76cFB/bZeeUQr0RpaK5YaL6WLQaB6UB/nbXMkb+A==
X-Received: by 2002:a17:90a:39cf:: with SMTP id k15mr1719719pjf.71.1617326524560;
        Thu, 01 Apr 2021 18:22:04 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id k64sm6718934pgk.23.2021.04.01.18.22.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Apr 2021 18:22:03 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <FC1C6625-2E89-4547-B2E4-2D992181309D@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_53BD9715-8557-487D-A7E2-C2F5CB7C369C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] ext4: Fix ext4_error_err save negative errno into
 superblock
Date:   Thu, 1 Apr 2021 19:21:58 -0600
In-Reply-To: <20210401074017.3382721-1-yebin10@huawei.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liu Zhi Qiang <liuzhiqiang26@huawei.com>
To:     Ye Bin <yebin10@huawei.com>
References: <20210401074017.3382721-1-yebin10@huawei.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_53BD9715-8557-487D-A7E2-C2F5CB7C369C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 1, 2021, at 1:40 AM, Ye Bin <yebin10@huawei.com> wrote:
>=20
> As read_mmp_block return 1 when failed. read_mmp_block return -EIO =
when buffer
> isn't uptodate.

Thank you for this second patch.  Unfortunately, the commit message
is still confusing/incorrect because it references read_mmp_block()
in the first usage but is actually changing write_mmp_block().

With that change you could add a Reviewed-by label from me.

Cheers, Andreas

> Fixes: 54d3adbc29f0 ("ext4: save all error info in save_error_info() =
and
> drop ext4_set_errno()")
> Reported-by: Liu Zhi Qiang <liuzhiqiang26@huawei.com>
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
> fs/ext4/mmp.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
> index 795c3ff2907c..68fbeedd627b 100644
> --- a/fs/ext4/mmp.c
> +++ b/fs/ext4/mmp.c
> @@ -56,7 +56,7 @@ static int write_mmp_block(struct super_block *sb, =
struct buffer_head *bh)
> 	wait_on_buffer(bh);
> 	sb_end_write(sb);
> 	if (unlikely(!buffer_uptodate(bh)))
> -		return 1;
> +		return -EIO;
>=20
> 	return 0;
> }
> --
> 2.25.4
>=20


Cheers, Andreas






--Apple-Mail=_53BD9715-8557-487D-A7E2-C2F5CB7C369C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmBmcbcACgkQcqXauRfM
H+Bgzg//WtpR3UQKASYF8Bu8cj7yHzoJC9CQwMcpojKCwcxDHboEXX9z7c9ia0sf
e6sr7nMOJygOL+rS3QdR78fDI3xvaK+wbR1qZNBbCLBffEJ/13ry5YI5YezRIdfe
hz9dhlMwT0WiniB3CpF7fb0/Fs/p30ud7u59Y3yrEMMCdr/WMkMtDs6v2BMZwmMN
K6aR4DaOC9+mF+KjyW25+l4eJgfzS7dja7WiewvP8xfmtSAISHQkIjh/EYRvf1lo
dQ2SW0yDsYrTuefVukavHhKk3dBHBUkKpwBpThcyrfzNdejUJPnpTwQ0YdFNcqRx
9fo9oiMbC4kvmTX4GrHPKYsnr9wYyDLp+uj64kikObUzoO0mDm3mT8c5drAC8vu3
rtmiO4Nze3BpieQYVdgnBHsbxmUWt207gBn/6rjSnuzeWtFIsZFq/CNaFVphHotF
Ma0TC7JDbimaJqusQZ6LGzFx5E0xOZ7Job6En3HVEmwDrbz7yP3ktqxAvwDM/hpZ
V8Bd44OO09mYb73API7AFjVdAG6ZjE26AMfnR1ShIAyJP8EwLioNaanNu+MY4Lcs
+TvIbcZciWnVoCIlOwdLAMAUBqsc7w5AoXBNZ5qrZwRmqGRt4LvC9f7luRrZHiBl
ZCYUjNcxG9s+slUO8MMwwQkA41rfWHYDAQs/uZSX7ZTMf72Sw44=
=/tep
-----END PGP SIGNATURE-----

--Apple-Mail=_53BD9715-8557-487D-A7E2-C2F5CB7C369C--
