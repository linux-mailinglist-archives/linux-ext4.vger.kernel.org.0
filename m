Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590B2297977
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Oct 2020 01:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758433AbgJWXAZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Oct 2020 19:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758431AbgJWXAZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Oct 2020 19:00:25 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290E3C0613CE
        for <linux-ext4@vger.kernel.org>; Fri, 23 Oct 2020 16:00:25 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y1so1806203plp.6
        for <linux-ext4@vger.kernel.org>; Fri, 23 Oct 2020 16:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=mVFRWwhdQ5d+tipnd/O9BxEyqZI6k5TynuhB8SxfJAY=;
        b=ZdndiHJy5HEZWic+1M1pWhZVj2QN2R0iYyS0+RbRxnEOyzXA60zCUh5Qw7oVpxKjk6
         i5XRDAVsNYyXXaRjoh/kuhGJYxQ+KGRroKtm38hd3Gbkj3jhiRw84IejLLJkIJJgeRXJ
         9QjCHgsj2FSmun9bzgZ6uYmWn+lBkjMoWCHasBeZORDKeurkObIhpID7/RZ74ejSuvUG
         SEkRGjbJgPOheoXbXTt9Xjx/mB11kTe3C65BcRHJ102c2qhrJRwRdZnRxORyOeiupD6F
         itU1HYakPADReg3lwfCuIVu6bg/WWWR0mkCI91dl5WiNH34tBFHQYRkuuwnQbiJEBaKB
         zndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=mVFRWwhdQ5d+tipnd/O9BxEyqZI6k5TynuhB8SxfJAY=;
        b=brpwHgOOgUNWwXlUkmi0RQJUtSZiiVXNCKdttgckPdU1IKJB8RAk6Zw8JKQKGxhf5s
         4xgGe7Kc7g3d0Q6SStWMn7V7KXjCPA9N90Ki9yUth53anmGP2sofQtBSD20JA6ooI+NJ
         zoJvfZ8bHqVEAPW8AlM8WfRQgSRWYx8egH50/NpXvlwq0mBG2q/ZnaNqqwGKZTG//yEw
         daxA2dJX5v9anCd6XliUR70pdhaE2EE//2k6ZHaUnLyS0pk8f6EYuZlTlm9w1Jj79KMF
         KcF7MLm2FfeYBTAOS22gHbtMnkLGJPEw3qlhlVfVlAiJGG7C1vCscBap+Thd/Go0m1aG
         yfrQ==
X-Gm-Message-State: AOAM532SSHuz7h2RpIDDr6G8hMmQybp1TSeA2zTj0DH6rdaEkD5BCLgI
        TMtbd94O3YeftyNZJ+WAN1vu3w==
X-Google-Smtp-Source: ABdhPJyeeE2Q61ujcfggpr83U0Qh4OZAsgi+S0lnTCZ2Dt2+zFRVRdYaOLkWkFIfdmczc1TDNbB+ig==
X-Received: by 2002:a17:90a:ec11:: with SMTP id l17mr5052880pjy.104.1603494024533;
        Fri, 23 Oct 2020 16:00:24 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id 145sm3024874pga.46.2020.10.23.16.00.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Oct 2020 16:00:23 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <0B73CF4D-188C-4DAA-8D98-3C49303370FE@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_0572DA9F-C0B0-44DE-BA87-9A52A4249691";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/8] ext4: remove redundant mb_regenerate_buddy()
Date:   Fri, 23 Oct 2020 16:58:42 -0600
In-Reply-To: <1603271728-7198-2-git-send-email-brookxu@tencent.com>
Cc:     Ted Tso <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Chunguang Xu <brookxu.cn@gmail.com>
References: <1603271728-7198-1-git-send-email-brookxu@tencent.com>
 <1603271728-7198-2-git-send-email-brookxu@tencent.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_0572DA9F-C0B0-44DE-BA87-9A52A4249691
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Oct 21, 2020, at 3:15 AM, Chunguang Xu <brookxu.cn@gmail.com> wrote:
>=20
> From: Chunguang Xu <brookxu@tencent.com>
>=20
> After this patch (163a203), if an abnormal bitmap is detected, we
> will mark the group as corrupt, and we will not use this group in
> the future. Therefore, it should be meaningless to regenerate the
> buddy bitmap of this group, It might be better to delete it.
>=20
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>


> ---
> fs/ext4/mballoc.c | 19 -------------------
> 1 file changed, 19 deletions(-)
>=20
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 85abbfb..22301f3 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -822,24 +822,6 @@ void ext4_mb_generate_buddy(struct super_block =
*sb,
> 	spin_unlock(&sbi->s_bal_lock);
> }
>=20
> -static void mb_regenerate_buddy(struct ext4_buddy *e4b)
> -{
> -	int count;
> -	int order =3D 1;
> -	void *buddy;
> -
> -	while ((buddy =3D mb_find_buddy(e4b, order++, &count))) {
> -		ext4_set_bits(buddy, 0, count);
> -	}
> -	e4b->bd_info->bb_fragments =3D 0;
> -	memset(e4b->bd_info->bb_counters, 0,
> -		sizeof(*e4b->bd_info->bb_counters) *
> -		(e4b->bd_sb->s_blocksize_bits + 2));
> -
> -	ext4_mb_generate_buddy(e4b->bd_sb, e4b->bd_buddy,
> -		e4b->bd_bitmap, e4b->bd_group);
> -}
> -
> /* The buddy information is attached the buddy cache inode
>  * for convenience. The information regarding each group
>  * is loaded via ext4_mb_load_buddy. The information involve
> @@ -1512,7 +1494,6 @@ static void mb_free_blocks(struct inode *inode, =
struct ext4_buddy *e4b,
> 				sb, e4b->bd_group,
> 				EXT4_GROUP_INFO_BBITMAP_CORRUPT);
> 		}
> -		mb_regenerate_buddy(e4b);
> 		goto done;
> 	}
>=20
> --
> 1.8.3.1
>=20


Cheers, Andreas






--Apple-Mail=_0572DA9F-C0B0-44DE-BA87-9A52A4249691
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl+TYH8ACgkQcqXauRfM
H+DMlBAAj0an8mS4GxptpD3mPW70P3Ix36qRHz2QASfhCNIt5NfdF0jsrdc64yRq
ZxC78C2slp1/ZcnqnESPzIY67vl+rkc4WG6M84oNusdR/YWkSgY6xNWkXmW3bOMT
NVoxG04qxlWOL8NcBCFvZxihWqkSRbz8FGd0581O0uOIeuQ1OrCk3HaMA58fBrvV
VbZGu+NIjrOqSHKzMbcYcDj2ty66hdByeHfIZ/bSNWTxvjAP/1mPLgByh3oNTLmC
jAyfYbbpRSSPY4g7cu5B1TeVrQfNAS8d9TfXW4EXE/D7Ky7NbDS2A+21rnKivR1h
t2NJZmzHkuIMrHp4Fr0I4xxLJfvL0I1WsgdcIWD16Kge81a1lXy/F/wZJVqkZDTu
2rGBw6PEjZAbRnu5xQaXUopu7+BdwjZQD/lIOdZwQI7BrTeJiPAlPAom9q78Noxk
HCJ0SVBkaVEPntI6P2VCy5639/4S5NaRiKe+73A1etUnRstDrzmeLYc+f825cvhg
fabbAw81spUSW86Wbywa3FEese29Ln06mCEm1B4nyzDHlkGJcq4RJ/BoM/0l3qMA
essF+QwSbS1ajEWIovEtcQzZym+zGoSUPaLQ043O14i0f3+jrvtrNazIZKUX8s6w
qOPEil7eiTFFwCn4YL1V14oeZTglTH8R0TeLYDJIXFPjOvsLVTE=
=nYEe
-----END PGP SIGNATURE-----

--Apple-Mail=_0572DA9F-C0B0-44DE-BA87-9A52A4249691--
