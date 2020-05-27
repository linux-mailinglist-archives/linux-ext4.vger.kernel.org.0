Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B101E4E22
	for <lists+linux-ext4@lfdr.de>; Wed, 27 May 2020 21:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbgE0T3c (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 May 2020 15:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgE0T3b (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 May 2020 15:29:31 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8F3C05BD1E
        for <linux-ext4@vger.kernel.org>; Wed, 27 May 2020 12:29:31 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y18so12304420pfl.9
        for <linux-ext4@vger.kernel.org>; Wed, 27 May 2020 12:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=4p+nA9mw6EVQZP3hTgJwpd09HQCRbHSj02+mnrC8rFk=;
        b=dd4q4O0o/9jDy51a7QORUlenBi8ymD2hXmZFBUaCSHncPX1KnpC9c+t9+X+U11phCd
         XY3LMKsEwrCLKGV1NS/oHx6Foe1YebtWvmfwv8svHhpVE71BvBc6yOq+mPIXuTO88zNV
         cgccbFC0uF81E7VtoCCiwfmembtsJXnt/TwLs4YmDeJYBrWM3UeIsDfnSSAassMJKXJg
         D6SEE5uDtq5PZWlGF5JIBlfivVXrD4drWL80dItxGbo+alB3nJP5XLF6cLZxVBPFfuWv
         tsqasyHB+u6+Sxalmp6SDRfGZwdv6lt8AwWIvLHmR1esjsiyQToJ1Dvos5hZuwsAIRPC
         Ao9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=4p+nA9mw6EVQZP3hTgJwpd09HQCRbHSj02+mnrC8rFk=;
        b=pCaumrp3M5oBCTwS79L1rJuzWm4848D0C/MqEII9jp99tSnUsujrM0Wv0Z7ph7BVeH
         ZfF5lYfbGu7OQ4N0eJ9HCPCNiZpj6ikMZRVTRnDbpTX6Sol5enwXHacrRRVlDqjLDXIe
         Xd4SZgh3IBB5BYPicSmS2rtHq2SSvVkUyirEE3dfGkfKVLuolN+x10Q0kJeUxc+RaSLJ
         Ve9jCWQb/lABfdBhYtuXz9Q2z8ro2YdMSTYwiyFrXZKEav4AKizI9RtATreMdcgbcGPJ
         I+m20ZZ3m9CBa7DvERh+2VTuGDOTsaA2ec9PNdPlP7pDnInNmvPC1qRyMHy95fkuXY80
         DVow==
X-Gm-Message-State: AOAM530hF6/wmzDWgbtMix/lWjGGBeRCnM0psTHSUorVEUP+apHuf9VN
        OSa1hUeFbI4TAFve3MkdatSGglv4t5Q3Ww==
X-Google-Smtp-Source: ABdhPJxj/jVkmsbuRg5igppBp9sDcg3QGZXX+uxpf3VAchWybFHind4vmWrxBPnVhZ0BXgFWP1R3ng==
X-Received: by 2002:a62:1dd3:: with SMTP id d202mr5143708pfd.99.1590607770849;
        Wed, 27 May 2020 12:29:30 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id c24sm2708465pfo.124.2020.05.27.12.29.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2020 12:29:30 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <491688EC-8C7C-45D1-B165-D1166554F01B@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_9AF19B1A-40AB-4273-8768-FA70C40287DB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] ext4: introduce EXT4_BG_WAS_TRIMMED to optimize trim
Date:   Wed, 27 May 2020 13:29:26 -0600
In-Reply-To: <1590588525-29669-3-git-send-email-wangshilong1991@gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Wang Shilong <wshilong@ddn.com>,
        Shuichi Ihara <sihara@ddn.com>,
        Lukas Czerner <lczerner@redhat.com>
To:     Wang Shilong <wangshilong1991@gmail.com>
References: <1590588525-29669-1-git-send-email-wangshilong1991@gmail.com>
 <1590588525-29669-3-git-send-email-wangshilong1991@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_9AF19B1A-40AB-4273-8768-FA70C40287DB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On May 27, 2020, at 8:08 AM, Wang Shilong <wangshilong1991@gmail.com> =
wrote:
>=20
> From: Wang Shilong <wshilong@ddn.com>
>=20
> Currently WAS_TRIMMED flag is not persistent, whenever filesystem was
> remounted, fstrim need walk all block groups again, the problem with
> this is FSTRIM could be slow on very large LUN SSD based filesystem.
>=20
> To avoid this kind of problem, we introduce a block group flag
> EXT4_BG_WAS_TRIMMED, the side effect of this is we need introduce
> extra one block group dirty write after trimming block group.
>=20
> And When clearing TRIMMED flag, block group will be journalled
> anyway, so it won't introduce any overhead.

> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index ad2dbf6e4924..23c2dc529a28 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -357,6 +357,7 @@ struct flex_groups {
> #define EXT4_BG_INODE_UNINIT	0x0001 /* Inode table/bitmap not in use =
*/
> #define EXT4_BG_BLOCK_UNINIT	0x0002 /* Block bitmap not in use */
> #define EXT4_BG_INODE_ZEROED	0x0004 /* On-disk itable initialized to =
zero */
> +#define EXT4_BG_WAS_TRIMMED	0x0008 /* block group was trimmed */
>=20
> /*
>  * Macro-instructions used to manage group descriptors
> @@ -3112,9 +3113,8 @@ struct ext4_group_info {
> };
>=20
> #define EXT4_GROUP_INFO_NEED_INIT_BIT		0
> -#define EXT4_GROUP_INFO_WAS_TRIMMED_BIT		1
> -#define EXT4_GROUP_INFO_BBITMAP_CORRUPT_BIT	2
> -#define EXT4_GROUP_INFO_IBITMAP_CORRUPT_BIT	3
> +#define EXT4_GROUP_INFO_BBITMAP_CORRUPT_BIT	1
> +#define EXT4_GROUP_INFO_IBITMAP_CORRUPT_BIT	2

(minor) I don't think you need to renumber these bits, just remove the
WAS_TRIMMED_BIT and leave the others as-is.  Not a big deal either way.

> diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
> index 4b9002f0e84c..4094a5b247f7 100644
> --- a/fs/ext4/ext4_jbd2.h
> +++ b/fs/ext4/ext4_jbd2.h
>=20
> @@ -4939,6 +4929,14 @@ void ext4_free_blocks(handle_t *handle, struct =
inode *inode,
> 	ret =3D ext4_free_group_clusters(sb, gdp) + count_clusters;
> 	ext4_free_group_clusters_set(sb, gdp, ret);
> 	ext4_block_bitmap_csum_set(sb, block_group, gdp, bitmap_bh);
> +	/*
> +	 * Clear the trimmed flag for the group so that the next
> +	 * ext4_trim_fs can trim it.
> +	 * If the volume is mounted with -o discard, online discard
> +	 * is supported and the free blocks will be trimmed online.
> +	 */
> +	if (!test_opt(sb, DISCARD))
> +		EXT4_MB_GDP_CLEAR_TRIMMED(gdp);

As discussed in my other email, I think a follow-on patch should track =
(in
ext4_group_info in-memory counter) the number of blocks freed in each =
group,
and only clear the WAS_TRIMMED flag if there are several blocks freed, =
or if
the group becomes totally "empty" (i.e. free < num_itable_blocks + 2).  =
That
will avoid overly-aggressive full group trim operations (i.e. we don't =
want
to trim if only a single block was freed).

Cheers, Andreas






--Apple-Mail=_9AF19B1A-40AB-4273-8768-FA70C40287DB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl7Ov5cACgkQcqXauRfM
H+CZAw/8D8Dl6pHqhchFns1pzjOkkNU5JgFgbIO2bLN5r5OutLUCnZMALezFy25N
GMrk17mRlmqzEJPPS0g5KqncfQhsmxjXwrsdAnju7wWA/8Nl8ZXXO0BJrWxs2Hau
I8IMIvmX063phl0C05hgZ7IaVw8x/oOwAxGVUdcKdtwifBHi6H8fq2tVZuHSnn7/
CPSwP9ad89SktYx2Nnpc7vgB6AuyfPQ4fIOkULBNJg8rmBjgvwiN9dUeFFzntUUR
cQx9PEvV8cPGR6UwsPJuCDRBxrwL6Rw150ZMgXRIgjlDJip3LMnBOiLJga7l2vgv
d2IM6oGptoEM4VqitLC03DRG6c11I20gMW2etnpUAOoWBrRPTUNtlKHni05KyXzH
V6a4j9lxVpx/wFtK918dQofg+LnsqnQy1bq3Ox/CuuebQ3GWUHbDnYzXuEDPpkD2
+7pZTnpKO6q0+pOjc1zU+0JUr9KvnWXjsnwR2l39dNHccegk5smyPxCkdbAOTt3r
UrbcSJAGDV5N9mFL9/VxgOp9F7Rxe1F0CjrlWScoJ/RYZkuGfJgfFscoPFkZ91sb
il9HiYG8OcOfvmdDu8mvZOC3sB0zxbyx71Zej8eblQYYyoEqabIgRdAbg8okuVzr
u3Lv8aUZbznM3C+NHkyGzVhD8agMJZmahz7+2A0TTb+kke4WaJ8=
=8HA6
-----END PGP SIGNATURE-----

--Apple-Mail=_9AF19B1A-40AB-4273-8768-FA70C40287DB--
