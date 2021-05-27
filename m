Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028B23936A0
	for <lists+linux-ext4@lfdr.de>; Thu, 27 May 2021 21:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbhE0Ttk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 May 2021 15:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbhE0Ttg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 May 2021 15:49:36 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068D8C061760
        for <linux-ext4@vger.kernel.org>; Thu, 27 May 2021 12:48:02 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d16so1376456pfn.12
        for <linux-ext4@vger.kernel.org>; Thu, 27 May 2021 12:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=kuxMhIAnnWS+xhIDY8/Wo8MykHEq6iJW3UMaeh7ZK7U=;
        b=nSRIvoY7lG1cQdvGcqoRcKIsPLZ/lmsyHJptUDK+fVpQONEWA6u6nWQqX09OblW5DT
         zY0CKq3FRFRJuH9s12hJ7/iL3T6JONnuQWR7+SgHwrkN/NhYUG/i28/XqKK13pgpoFqC
         XbEDe+/EUaC41FeTkKz/qwFQDsdiYSIRqHk1aLaIU61AWWV72+yyqgdqmfNwKKTuQb+M
         BVTCBylEx3lyJFblDSPgmW+SaDX/HYnyFjToF7ABCqnip4kGystVP2wYED17n3j4QE1t
         kIZMgvgr+kp6M2iSOZi4/5yDL533TWHQKOzjXwQUTbgor+IwNkcEGOMHUp0Pk1AHvTro
         1MYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=kuxMhIAnnWS+xhIDY8/Wo8MykHEq6iJW3UMaeh7ZK7U=;
        b=OgMUVvMXhbvIjkNHupCHy2PMYB8Q1LwUXBTpnMkufSVUW9BhOkpH+2CPKX7CNIruyp
         gcMEX3khJM4LFnqOu20nw6Ueb3CKl2NW3giQoTRTFvxHZ/Mxcn8iDFZkALBSq6orLB6V
         hDO6k2z4je5AkZk8JF2F++Z0u1AvMnaP2nfa8xMmY5Tyti6KKOCgf9dUhNbTQxro9Ts5
         azq1DVYeQCpmdXUsdMkWBu1NMbw+VtczG9Yy2n9zjddf84f0G2GVqVdqsleFveKcmZOC
         TjqBfVgcfDI4kWUXQJmBOl9XhWDWLmZiwD/kpTUIgiwhEK+B+TqiGFAwjJ28Lr7C88Ih
         oq7w==
X-Gm-Message-State: AOAM531v+mmFc5MMtRg6hpDFNMqGziPGmmunD+QlUTd1+XP9XL8WefT+
        6TNIgK1Spt+6smPI3EmTID98yQ==
X-Google-Smtp-Source: ABdhPJyvW92LZaYFBCZWvHpS+AW5yXFjTx7TFZi+bvoPYNvlSz1hECSMZqyFBqzZx6cb/i4gRaoP1g==
X-Received: by 2002:aa7:800a:0:b029:250:c8c5:64b3 with SMTP id j10-20020aa7800a0000b0290250c8c564b3mr62298pfi.23.1622144881429;
        Thu, 27 May 2021 12:48:01 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id i13sm2545570pgg.30.2021.05.27.12.47.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 May 2021 12:48:00 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <C666AA9C-9CC9-4E3E-B161-C82C7B739E7F@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_396E1356-CA76-4644-BCA7-C3802BBC147A";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH V2 1/7] ext4: remove the 'group' parameter of
 ext4_trim_extent
Date:   Thu, 27 May 2021 13:47:56 -0600
In-Reply-To: <61eceb4c-6e5f-34d0-9317-a833d7c63b6f@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lishujin@kuaishou.com
To:     Wang Jianchao <jianchao.wan9@gmail.com>
References: <164ffa3b-c4d5-6967-feba-b972995a6dfb@gmail.com>
 <61eceb4c-6e5f-34d0-9317-a833d7c63b6f@gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_396E1356-CA76-4644-BCA7-C3802BBC147A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On May 26, 2021, at 2:42 AM, Wang Jianchao <jianchao.wan9@gmail.com> =
wrote:
>=20
> Get rid of the 'group' parameter of ext4_trim_extent as we can get
> it from the 'e4b'.
>=20
> Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/mballoc.c | 9 ++++-----
> 1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index a02fadf..d81f1fd22 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -5650,19 +5650,19 @@ int ext4_group_add_blocks(handle_t *handle, =
struct super_block *sb,
>  * @sb:		super block for the file system
>  * @start:	starting block of the free extent in the alloc. group
>  * @count:	number of blocks to TRIM
> - * @group:	alloc. group we are working with
>  * @e4b:	ext4 buddy for the group
>  *
>  * Trim "count" blocks starting at "start" in the "group". To assure =
that no
>  * one will allocate those blocks, mark it as used in buddy bitmap. =
This must
>  * be called with under the group lock.
>  */
> -static int ext4_trim_extent(struct super_block *sb, int start, int =
count,
> -			     ext4_group_t group, struct ext4_buddy *e4b)
> +static int ext4_trim_extent(struct super_block *sb,
> +		int start, int count, struct ext4_buddy *e4b)
> __releases(bitlock)
> __acquires(bitlock)
> {
> 	struct ext4_free_extent ex;
> +	ext4_group_t group =3D e4b->bd_group;
> 	int ret =3D 0;
>=20
> 	trace_ext4_trim_extent(sb, group, start, count);
> @@ -5738,8 +5738,7 @@ static int ext4_trim_extent(struct super_block =
*sb, int start, int count,
> 		next =3D mb_find_next_bit(bitmap, max + 1, start);
>=20
> 		if ((next - start) >=3D minblocks) {
> -			ret =3D ext4_trim_extent(sb, start,
> -					       next - start, group, =
&e4b);
> +			ret =3D ext4_trim_extent(sb, start, next - =
start, &e4b);
> 			if (ret && ret !=3D -EOPNOTSUPP)
> 				break;
> 			ret =3D 0;
> --
> 1.8.3.1


Cheers, Andreas






--Apple-Mail=_396E1356-CA76-4644-BCA7-C3802BBC147A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmCv92wACgkQcqXauRfM
H+CzwxAAj0DnT91f2yhsPGX4qrxRdauP6pmSe5jSLeOurnHi0fYxMiJ431hQSuyL
KLWaD5x1b2YNUbciBLlsk4qUqX0GMCs9ossJ12I68YWfGr161ZI3xuk6lHipf0nU
jM0p6SKCh8/aS4BhUa611bW68vP+DIg6Qpl0GnUQvn9QWbb6RM6sQaKe4WARISXU
MRrsm62FDrSwiboAHNBgkKuELrAIdES1/h9D+SHn7ko4itXaAW3B3uYc2VP/N9ya
psrFaKhm4BI/wRLc3cbPhaIuoxDU4glep/TZYLemVTjwmQ25wUATfqLNxi5SgSq8
xzvtsOrlX+tYmyqjmRkCamhhdJs0N2h2Pkrngoy1wGHbEaqFy5d3YtZzrKMyof+H
jDgMJWiM87fNCYQZ/6vXhrFNUkyatvvGg1d9wcJtY2VcBiJO0mGQf6tWjOhf0597
bkrzGgqbg+MHbW1PwBbhOY0jFAAUuiLrLrejVlMJhTvo3T5rzEV9jNoRU2s9n6hL
kutxNZtPlYPXHapOk5OeN92TtCbyJecJ2Ul9JF7+9WmZjvABYWZnTzWG9g6aBOoW
1ZF+Qfk8Of4bK8oHmRjW9mPQre/Z7uGHzM0MBBLnUUqIn9FugEiJQOIfqr7np1De
qEwrKamQ5LpY+PAZfR/WXtqJH0SN2dbp3trkMt++jaCTKsZ54KM=
=ij5x
-----END PGP SIGNATURE-----

--Apple-Mail=_396E1356-CA76-4644-BCA7-C3802BBC147A--
