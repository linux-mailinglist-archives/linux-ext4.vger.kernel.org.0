Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007237AF57F
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Sep 2023 22:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbjIZUqk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Sep 2023 16:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235855AbjIZUqk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 26 Sep 2023 16:46:40 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78FDE4
        for <linux-ext4@vger.kernel.org>; Tue, 26 Sep 2023 13:46:31 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-690f9c787baso7528768b3a.1
        for <linux-ext4@vger.kernel.org>; Tue, 26 Sep 2023 13:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1695761191; x=1696365991; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pm5SgegrWPK0U8aU9OivV9YxzENAZPaUJZg9Cdeazcs=;
        b=en+KE5mLXV+A47u9l5sSX6vXv2tDqYtQweuIuBIi/mjEJxrzJm33eJACSSZCrqKG6T
         4WCzTrdUK6DuN1+yY6+9Wc8XR0BVvaQUV3rAJQVLNhQKBNGf/sL1f090LBXwSXKs+hE+
         pRdBrPbrjo1q9fHAjO98J54I4xblN2YIBXUSd9PSTXH1zuqshR2DsjU+jGFvWpfiTCpu
         TwS5I+joVhfnmghrASDC4oVOC61jaBGJci28zVHUershUU0mnPFu3Qi+9eXUmX2oI+c9
         BWb495FPrEFk4hnA5to9wD39o6GzNP3EmGnc2VMPyXuKx2z3IVpO0f4ywn0tiVn3h7yY
         nPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695761191; x=1696365991;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pm5SgegrWPK0U8aU9OivV9YxzENAZPaUJZg9Cdeazcs=;
        b=HkzS+w0bvU0Je36ZHyWBEsS6IWgyXUh7uSXVCZ8VnMZM2j3uhZSuxuHlPrzB5FkfCo
         /ZGa/AN29+20Vy7fxDQUwxfqWS9+EiPtO+WN+Uo9oc6vkx+53UZV7IcyGv3+qtubtOqM
         dcniNwq3hvoftW8aid+9fmWJd+Mwro3b07b4Xcd/ahvP2eYrt0gfROvqVUoLl+FmDwI5
         9b47S/0FaeqdbjrZe5cWQKNHNX61RW2T+FfzMjMsf1dsDOcoSs8DhMLNRqK/LazG2utG
         VDCdj+aRPBWo1w4dORS20HzfES+IP9L/i2Qi8cd+ddQ9918Z9HLdY9LM4fZH8v0CxWeS
         2Gcw==
X-Gm-Message-State: AOJu0YwN/3xzMhf3chjRsseaBpTQ1s4VscCDxUmj2xU6zZCbwvEnCBkX
        uJCOj3ehBzBTkdfrC/GwcAdLxWzHw05s4+OmrSs=
X-Google-Smtp-Source: AGHT+IEWBu/09RPHCWuBk53ZuK/oSe+DznViWO8/bHIKpbeW77SzWFPf9TC9XbXSH2cnln/dg53u/g==
X-Received: by 2002:a05:6a20:3ca7:b0:15e:2d9f:cae0 with SMTP id b39-20020a056a203ca700b0015e2d9fcae0mr24361pzj.10.1695761191241;
        Tue, 26 Sep 2023 13:46:31 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902b28500b001c62b9a51a4sm2539724plr.239.2023.09.26.13.46.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Sep 2023 13:46:30 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <10D5BD79-5D21-4C64-AE9E-52BDC2504619@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_65E48731-9EAF-4CB6-8754-71AAB408ADD2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/2] mke2fs: do not set the BLOCK_UNINIT on groups has GDT
Date:   Tue, 26 Sep 2023 14:46:28 -0600
In-Reply-To: <20230925060801.1397581-2-dongyangli@ddn.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Li Dongyang <dongyangli@ddn.com>
References: <20230925060801.1397581-1-dongyangli@ddn.com>
 <20230925060801.1397581-2-dongyangli@ddn.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_65E48731-9EAF-4CB6-8754-71AAB408ADD2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Sep 25, 2023, at 12:08 AM, Li Dongyang <dongyangli@ddn.com> wrote:
>=20
> This patch prepares the expansion of GDT blocks beyond a
> single group, by make mke2fs to not set BLOCK_UNINIT on
> groups with GDT blocks, block/inode bitmaps, or inode table
> blocks allocated.
>=20
> Otherwise, we still rely on kernel side to initialize the
> block bitmap if the groups has BLOCK_UNINIT set, and the
> kernel doesn't know a group could have GDT blocks allocated,
> so it would make an bad block bitmap.
>=20
> As a result, expect output of several tests needs to be changed,
> especially if the test uses dumpe2fs to print the group summary.
>=20
> Signed-off-by: Li Dongyang <dongyangli@ddn.com>

AFAIK, this patch is totally fine to use even in the absence
of the large GDT functionality.  It just avoids setting the
BLOCK_UNINIT on any groups that have GDT blocks allocated, and
is making life a bit simpler for the kernel online resize.

At most this is 45 groups' block bitmaps, even for a 576PB
filesystem that is maxing out the 32-bit group descriptor limit.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> lib/ext2fs/initialize.c                        |  2 +-
> tests/j_ext_long_trans/expect                  |  2 +-
> tests/j_long_trans/expect                      |  2 +-
> tests/j_long_trans_mcsum_32bit/expect          |  2 +-
> tests/j_long_trans_mcsum_64bit/expect          |  2 +-
> tests/j_short_trans_mcsum_64bit/expect         |  2 +-
> tests/j_short_trans_recover_mcsum_64bit/expect |  2 +-
> tests/m_bigjournal/expect.1                    | 16 ++++++++--------
> tests/m_resize_inode_meta_bg/expect.1          |  6 +++---
> tests/m_uninit/expect.1                        | 10 +++++-----
> 10 files changed, 23 insertions(+), 23 deletions(-)
>=20
> diff --git a/lib/ext2fs/initialize.c b/lib/ext2fs/initialize.c
> index 90012f732..5560cd3f8 100644
> --- a/lib/ext2fs/initialize.c
> +++ b/lib/ext2fs/initialize.c
> @@ -535,7 +535,7 @@ ipg_retry:
> 		 * because the block bitmap needs to be padded.
> 		 */
> 		if (csum_flag) {
> -			if (i !=3D fs->group_desc_count - 1)
> +			if (i !=3D fs->group_desc_count - 1 && numblocks =
=3D=3D 0)
> 				ext2fs_bg_flags_set(fs, i,
> 						    =
EXT2_BG_BLOCK_UNINIT);
> 			ext2fs_bg_flags_set(fs, i, =
EXT2_BG_INODE_UNINIT);
> diff --git a/tests/j_ext_long_trans/expect =
b/tests/j_ext_long_trans/expect
> index ea3c87fcb..b95aa9bc2 100644
> --- a/tests/j_ext_long_trans/expect
> +++ b/tests/j_ext_long_trans/expect
> @@ -77,7 +77,7 @@ Root inode not allocated.  Allocate? yes
>=20
> Pass 4: Checking reference counts
> Pass 5: Checking group summary information
> -Block bitmap differences:  +(1--259) +275 +(291--418) +2341
> +Block bitmap differences:  +(1--260) +262 +264 +266 +268 +(275--276) =
+278 +280 +282 +284 +(291--546) +(675--802) +(931--1058) +(1187--1314) =
+(1443--1570) +2341 +(8193--8450) +(24577--24834) +(40961--41218) =
+(57345--57602) +(73729--73986)
> Fix? yes
>=20
> Free blocks count wrong for group #0 (5838, counted=3D5851).
> diff --git a/tests/j_long_trans/expect b/tests/j_long_trans/expect
> index 82b3caf17..ee7af96ab 100644
> --- a/tests/j_long_trans/expect
> +++ b/tests/j_long_trans/expect
> @@ -72,7 +72,7 @@ Root inode not allocated.  Allocate? yes
>=20
> Pass 4: Checking reference counts
> Pass 5: Checking group summary information
> -Block bitmap differences:  +(1--259) +273 +275 +289 +(291--418) =
+(2083--2210) +2341
> +Block bitmap differences:  +(1--260) +262 +264 +266 +268 +273 =
+(275--276) +278 +280 +282 +284 +289 +(291--546) +(675--802) =
+(931--1058) +(1187--1314) +(1443--1570) +(2083--2210) +2341 =
+(8193--8450) +(24577--24834) +(40961--41218) +(57345--57602) =
+(73729--73986)
> Fix? yes
>=20
> Free blocks count wrong for group #0 (5838, counted=3D5851).
> diff --git a/tests/j_long_trans_mcsum_32bit/expect =
b/tests/j_long_trans_mcsum_32bit/expect
> index ffae07a69..0b6cf499c 100644
> --- a/tests/j_long_trans_mcsum_32bit/expect
> +++ b/tests/j_long_trans_mcsum_32bit/expect
> @@ -108,7 +108,7 @@ Root inode not allocated.  Allocate? yes
>=20
> Pass 4: Checking reference counts
> Pass 5: Checking group summary information
> -Block bitmap differences:  +(1--260) +276 +(292--419) +2342 =
-(139265--155648)
> +Block bitmap differences:  +(1--261) +263 +265 +267 +269 +(276--277) =
+279 +281 +283 +285 +(292--547) +(676--803) +(932--1059) +(1188--1315) =
+(1444--1571) +2342 +(8193--8451) +(24577--24835) +(40961--41219) =
+(57345--57603) +(73729--73987) -(139265--155648)
> Fix? yes
>=20
> Free blocks count wrong for group #0 (5837, counted=3D5850).
> diff --git a/tests/j_long_trans_mcsum_64bit/expect =
b/tests/j_long_trans_mcsum_64bit/expect
> index e891def16..b520c91bc 100644
> --- a/tests/j_long_trans_mcsum_64bit/expect
> +++ b/tests/j_long_trans_mcsum_64bit/expect
> @@ -107,7 +107,7 @@ Root inode not allocated.  Allocate? yes
>=20
> Pass 4: Checking reference counts
> Pass 5: Checking group summary information
> -Block bitmap differences:  +(1--262) +278 +(294--421) +2344 =
-(139265--155648)
> +Block bitmap differences:  +(1--263) +265 +267 +269 +271 +(278--279) =
+281 +283 +285 +287 +(294--549) +(678--805) +(934--1061) +(1190--1317) =
+(1446--1573) +2344 +(8193--8453) +(24577--24837) +(40961--41221) =
+(57345--57605) +(73729--73989) -(139265--155648)
> Fix? yes
>=20
> Free blocks count wrong for group #0 (5835, counted=3D5848).
> diff --git a/tests/j_short_trans_mcsum_64bit/expect =
b/tests/j_short_trans_mcsum_64bit/expect
> index d73e28297..5a4f5b94b 100644
> --- a/tests/j_short_trans_mcsum_64bit/expect
> +++ b/tests/j_short_trans_mcsum_64bit/expect
> @@ -28,7 +28,7 @@ Pass 2: Checking directory structure
> Pass 3: Checking directory connectivity
> Pass 4: Checking reference counts
> Pass 5: Checking group summary information
> -Block bitmap differences:  +(0--65) +(67--69) +(71--584) =
+(1097--2126) +(65536--69631) +(98304--98368)
> +Block bitmap differences:  +(0--2126) +(32768--32832) +(65536--69631) =
+(98304--98368)
> Fix? yes
>=20
> Inode bitmap differences:  +(1--11)
> diff --git a/tests/j_short_trans_recover_mcsum_64bit/expect =
b/tests/j_short_trans_recover_mcsum_64bit/expect
> index 8c637f122..7139fd80a 100644
> --- a/tests/j_short_trans_recover_mcsum_64bit/expect
> +++ b/tests/j_short_trans_recover_mcsum_64bit/expect
> @@ -30,7 +30,7 @@ Pass 2: Checking directory structure
> Pass 3: Checking directory connectivity
> Pass 4: Checking reference counts
> Pass 5: Checking group summary information
> -Block bitmap differences:  +(0--65) +(67--69) +(71--584) =
+(1097--2126) +(65536--69631) +(98304--98368)
> +Block bitmap differences:  +(0--2126) +(32768--32832) +(65536--69631) =
+(98304--98368)
> Fix? yes
>=20
> Inode bitmap differences:  +(1--11)
> diff --git a/tests/m_bigjournal/expect.1 b/tests/m_bigjournal/expect.1
> index eb0e3bc38..4e6674665 100644
> --- a/tests/m_bigjournal/expect.1
> +++ b/tests/m_bigjournal/expect.1
> @@ -58,7 +58,7 @@ Group 0: (Blocks 0-32767)
>   31837 free blocks, 5 free inodes, 2 directories, 5 unused inodes
>   Free blocks: 931-32767
>   Free inodes: 12-16
> -Group 1: (Blocks 32768-65535) [INODE_UNINIT, BLOCK_UNINIT]
> +Group 1: (Blocks 32768-65535) [INODE_UNINIT]
>   Backup superblock at 32768, Group descriptors at 32769-32769
>   Reserved GDT blocks at 32770-33440
>   Block bitmap at 674 (bg #0 + 674), Inode bitmap at 758 (bg #0 + 758)
> @@ -72,7 +72,7 @@ Group 2: (Blocks 65536-98303) [INODE_UNINIT, =
BLOCK_UNINIT]
>   32768 free blocks, 16 free inodes, 0 directories, 16 unused inodes
>   Free blocks: 65536-98303
>   Free inodes: 33-48
> -Group 3: (Blocks 98304-131071) [INODE_UNINIT, BLOCK_UNINIT]
> +Group 3: (Blocks 98304-131071) [INODE_UNINIT]
>   Backup superblock at 98304, Group descriptors at 98305-98305
>   Reserved GDT blocks at 98306-98976
>   Block bitmap at 676 (bg #0 + 676), Inode bitmap at 760 (bg #0 + 760)
> @@ -86,7 +86,7 @@ Group 4: (Blocks 131072-163839) [INODE_UNINIT, =
BLOCK_UNINIT]
>   32768 free blocks, 16 free inodes, 0 directories, 16 unused inodes
>   Free blocks: 131072-163839
>   Free inodes: 65-80
> -Group 5: (Blocks 163840-196607) [INODE_UNINIT, BLOCK_UNINIT]
> +Group 5: (Blocks 163840-196607) [INODE_UNINIT]
>   Backup superblock at 163840, Group descriptors at 163841-163841
>   Reserved GDT blocks at 163842-164512
>   Block bitmap at 678 (bg #0 + 678), Inode bitmap at 762 (bg #0 + 762)
> @@ -100,7 +100,7 @@ Group 6: (Blocks 196608-229375) [INODE_UNINIT, =
BLOCK_UNINIT]
>   32768 free blocks, 16 free inodes, 0 directories, 16 unused inodes
>   Free blocks: 196608-229375
>   Free inodes: 97-112
> -Group 7: (Blocks 229376-262143) [INODE_UNINIT, BLOCK_UNINIT]
> +Group 7: (Blocks 229376-262143) [INODE_UNINIT]
>   Backup superblock at 229376, Group descriptors at 229377-229377
>   Reserved GDT blocks at 229378-230048
>   Block bitmap at 680 (bg #0 + 680), Inode bitmap at 764 (bg #0 + 764)
> @@ -114,7 +114,7 @@ Group 8: (Blocks 262144-294911) [INODE_UNINIT, =
BLOCK_UNINIT]
>   32768 free blocks, 16 free inodes, 0 directories, 16 unused inodes
>   Free blocks: 262144-294911
>   Free inodes: 129-144
> -Group 9: (Blocks 294912-327679) [INODE_UNINIT, BLOCK_UNINIT]
> +Group 9: (Blocks 294912-327679) [INODE_UNINIT]
>   Backup superblock at 294912, Group descriptors at 294913-294913
>   Reserved GDT blocks at 294914-295584
>   Block bitmap at 682 (bg #0 + 682), Inode bitmap at 766 (bg #0 + 766)
> @@ -212,7 +212,7 @@ Group 24: (Blocks 786432-819199) [INODE_UNINIT, =
BLOCK_UNINIT]
>   32768 free blocks, 16 free inodes, 0 directories, 16 unused inodes
>   Free blocks: 786432-819199
>   Free inodes: 385-400
> -Group 25: (Blocks 819200-851967) [INODE_UNINIT, BLOCK_UNINIT]
> +Group 25: (Blocks 819200-851967) [INODE_UNINIT]
>   Backup superblock at 819200, Group descriptors at 819201-819201
>   Reserved GDT blocks at 819202-819872
>   Block bitmap at 698 (bg #0 + 698), Inode bitmap at 782 (bg #0 + 782)
> @@ -226,7 +226,7 @@ Group 26: (Blocks 851968-884735) [INODE_UNINIT, =
BLOCK_UNINIT]
>   32768 free blocks, 16 free inodes, 0 directories, 16 unused inodes
>   Free blocks: 851968-884735
>   Free inodes: 417-432
> -Group 27: (Blocks 884736-917503) [INODE_UNINIT, BLOCK_UNINIT]
> +Group 27: (Blocks 884736-917503) [INODE_UNINIT]
>   Backup superblock at 884736, Group descriptors at 884737-884737
>   Reserved GDT blocks at 884738-885408
>   Block bitmap at 700 (bg #0 + 700), Inode bitmap at 784 (bg #0 + 784)
> @@ -554,7 +554,7 @@ Group 80: (Blocks 2621440-2654207) [INODE_UNINIT, =
BLOCK_UNINIT]
>   32768 free blocks, 16 free inodes, 0 directories, 16 unused inodes
>   Free blocks: 2621440-2654207
>   Free inodes: 1281-1296
> -Group 81: (Blocks 2654208-2686975) [INODE_UNINIT, BLOCK_UNINIT]
> +Group 81: (Blocks 2654208-2686975) [INODE_UNINIT]
>   Backup superblock at 2654208, Group descriptors at 2654209-2654209
>   Reserved GDT blocks at 2654210-2654880
>   Block bitmap at 754 (bg #0 + 754), Inode bitmap at 838 (bg #0 + 838)
> diff --git a/tests/m_resize_inode_meta_bg/expect.1 =
b/tests/m_resize_inode_meta_bg/expect.1
> index 7feaed9d8..83c7bc57c 100644
> --- a/tests/m_resize_inode_meta_bg/expect.1
> +++ b/tests/m_resize_inode_meta_bg/expect.1
> @@ -67,7 +67,7 @@ Group 0: (Blocks 0-255) [ITABLE_ZEROED]
>   159 free blocks, 53 free inodes, 2 directories, 53 unused inodes
>   Free blocks: 97-255
>   Free inodes: 12-64
> -Group 1: (Blocks 256-511) [INODE_UNINIT, BLOCK_UNINIT, ITABLE_ZEROED]
> +Group 1: (Blocks 256-511) [INODE_UNINIT, ITABLE_ZEROED]
>   Backup superblock at 256, Group descriptor at 257
>   Block bitmap at 3 (bg #0 + 3)
>   Inode bitmap at 18 (bg #0 + 18)
> @@ -82,7 +82,7 @@ Group 2: (Blocks 512-767) [INODE_UNINIT, =
BLOCK_UNINIT, ITABLE_ZEROED]
>   256 free blocks, 64 free inodes, 0 directories, 64 unused inodes
>   Free blocks: 512-767
>   Free inodes: 129-192
> -Group 3: (Blocks 768-1023) [INODE_UNINIT, BLOCK_UNINIT, =
ITABLE_ZEROED]
> +Group 3: (Blocks 768-1023) [INODE_UNINIT, ITABLE_ZEROED]
>   Backup superblock at 768
>   Block bitmap at 5 (bg #0 + 5)
>   Inode bitmap at 20 (bg #0 + 20)
> @@ -97,7 +97,7 @@ Group 4: (Blocks 1024-1279) [INODE_UNINIT, =
BLOCK_UNINIT, ITABLE_ZEROED]
>   256 free blocks, 64 free inodes, 0 directories, 64 unused inodes
>   Free blocks: 1024-1279
>   Free inodes: 257-320
> -Group 5: (Blocks 1280-1535) [INODE_UNINIT, BLOCK_UNINIT, =
ITABLE_ZEROED]
> +Group 5: (Blocks 1280-1535) [INODE_UNINIT, ITABLE_ZEROED]
>   Backup superblock at 1280
>   Block bitmap at 7 (bg #0 + 7)
>   Inode bitmap at 22 (bg #0 + 22)
> diff --git a/tests/m_uninit/expect.1 b/tests/m_uninit/expect.1
> index 3c2875527..2058de7a9 100644
> --- a/tests/m_uninit/expect.1
> +++ b/tests/m_uninit/expect.1
> @@ -56,7 +56,7 @@ Group 0: (Blocks 1-8192) [ITABLE_ZEROED]
>   7406 free blocks, 2037 free inodes, 2 directories, 2037 unused =
inodes
>   Free blocks: 787-8192
>   Free inodes: 12-2048
> -Group 1: (Blocks 8193-16384) [INODE_UNINIT, BLOCK_UNINIT, =
ITABLE_ZEROED]
> +Group 1: (Blocks 8193-16384) [INODE_UNINIT, ITABLE_ZEROED]
>   Backup superblock at 8193, Group descriptors at 8194-8194
>   Reserved GDT blocks at 8195-8450
>   Block bitmap at 8451 (+258), Inode bitmap at 8452 (+259)
> @@ -70,7 +70,7 @@ Group 2: (Blocks 16385-24576) [INODE_UNINIT, =
BLOCK_UNINIT, ITABLE_ZEROED]
>   7678 free blocks, 2048 free inodes, 0 directories, 2048 unused =
inodes
>   Free blocks: 16899-24576
>   Free inodes: 4097-6144
> -Group 3: (Blocks 24577-32768) [INODE_UNINIT, BLOCK_UNINIT, =
ITABLE_ZEROED]
> +Group 3: (Blocks 24577-32768) [INODE_UNINIT, ITABLE_ZEROED]
>   Backup superblock at 24577, Group descriptors at 24578-24578
>   Reserved GDT blocks at 24579-24834
>   Block bitmap at 24835 (+258), Inode bitmap at 24836 (+259)
> @@ -84,7 +84,7 @@ Group 4: (Blocks 32769-40960) [INODE_UNINIT, =
BLOCK_UNINIT, ITABLE_ZEROED]
>   7678 free blocks, 2048 free inodes, 0 directories, 2048 unused =
inodes
>   Free blocks: 33283-40960
>   Free inodes: 8193-10240
> -Group 5: (Blocks 40961-49152) [INODE_UNINIT, BLOCK_UNINIT, =
ITABLE_ZEROED]
> +Group 5: (Blocks 40961-49152) [INODE_UNINIT, ITABLE_ZEROED]
>   Backup superblock at 40961, Group descriptors at 40962-40962
>   Reserved GDT blocks at 40963-41218
>   Block bitmap at 41219 (+258), Inode bitmap at 41220 (+259)
> @@ -98,7 +98,7 @@ Group 6: (Blocks 49153-57344) [INODE_UNINIT, =
BLOCK_UNINIT, ITABLE_ZEROED]
>   7678 free blocks, 2048 free inodes, 0 directories, 2048 unused =
inodes
>   Free blocks: 49667-57344
>   Free inodes: 12289-14336
> -Group 7: (Blocks 57345-65536) [INODE_UNINIT, BLOCK_UNINIT, =
ITABLE_ZEROED]
> +Group 7: (Blocks 57345-65536) [INODE_UNINIT, ITABLE_ZEROED]
>   Backup superblock at 57345, Group descriptors at 57346-57346
>   Reserved GDT blocks at 57347-57602
>   Block bitmap at 57603 (+258), Inode bitmap at 57604 (+259)
> @@ -112,7 +112,7 @@ Group 8: (Blocks 65537-73728) [INODE_UNINIT, =
BLOCK_UNINIT, ITABLE_ZEROED]
>   7678 free blocks, 2048 free inodes, 0 directories, 2048 unused =
inodes
>   Free blocks: 66051-73728
>   Free inodes: 16385-18432
> -Group 9: (Blocks 73729-81920) [INODE_UNINIT, BLOCK_UNINIT, =
ITABLE_ZEROED]
> +Group 9: (Blocks 73729-81920) [INODE_UNINIT, ITABLE_ZEROED]
>   Backup superblock at 73729, Group descriptors at 73730-73730
>   Reserved GDT blocks at 73731-73986
>   Block bitmap at 73987 (+258), Inode bitmap at 73988 (+259)
> --
> 2.41.0
>=20


Cheers, Andreas






--Apple-Mail=_65E48731-9EAF-4CB6-8754-71AAB408ADD2
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmUTQyQACgkQcqXauRfM
H+AOfw/7BmlgD96f0bW7NzKCVdDHIrc9vXHPmDD7tHjixoaN7Bt5yEOerX9Z6oeK
toMr5DjcmYH2ZzBSLP+3DgYit+uuCUxlGOPQA7lTrrVYfCXyOXzx76auFfQYWtfy
F4HopAZQl2K+7sRHCh4oGYSQWXlaMhXij1e8g6V6H5+3gH7Bhjd2/aKpoePG2tUh
VYqSIkeH9/EDiaQ4HuLw/C2OU0uV4uGTkrGvo9GEQpuNXy3754tqOkfJDl8Z3pnC
hlg3ZvUv2vv3TfOBrPdgst81Wy43FFq6oZwq/d+2aOlX4LKuk9WmfhtDIuwbT3eF
BETDacyf7gFaT32I/bqpx+OBagiWTIGb5qbTNlQZAFPWBCKEQ7aZTLsaPOc3/ojJ
qLrRFuk09yd5szL2W1uMtuwe7VSaPzbFt0Z0yyf9DveE75BnXjx5vFLXIuscfPbS
NLrbKpiM1CzIzEJLjpEmszv81gUKOn+QzlKhoWaaQpDtgUx7qtX3AlEEcO9CL+vS
6UWINh2zf6blasBHmbBGtA6/i4HFb9w/fsFtZy0PLvFyCf0saRtjN6ZijyHLnSBl
KH5iTfg8Tk7fYRrjIvHwY9jaBn3+ARS9yiJm9MOmA1m0Ylpa8ymTYGsTbZYxyMPn
NRpLy86jxvpSOIWwkEW+QhaWbipawb+dlv7BGTBMOh7dMvFk4ag=
=6UB8
-----END PGP SIGNATURE-----

--Apple-Mail=_65E48731-9EAF-4CB6-8754-71AAB408ADD2--
