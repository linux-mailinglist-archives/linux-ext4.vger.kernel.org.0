Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E09A7ACFD9
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Sep 2023 08:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjIYGI3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 25 Sep 2023 02:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjIYGI2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 25 Sep 2023 02:08:28 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E6EE3
        for <linux-ext4@vger.kernel.org>; Sun, 24 Sep 2023 23:08:20 -0700 (PDT)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43]) by mx-outbound10-136.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 25 Sep 2023 06:08:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHjLrTAL+4eqQnhLcp2xUDm7A+OOIah5Y0EL08Al4QuX0dVrn2GZgq+4gYurM2/oD4Knii5jD6mEbUaJ+0yq6OtWP2lGPn6HBjUc0E/LoA8Ir0gw+fclifZvnPgl0ujY0dZ+XFV1zJL8EMGajMdX2ZfT2IQ+iy7EXIw+J8JctDOdvP3z3Hko9HQiyHPUNoQBI1g2b8J+FbnJMJdcqJ3SPQhWpLdMCyPMVCQv7L2rBuzHd1TCgvRY05N84/xjrf9CabI6mVLP+taK6rFZGMwy6GxF4+1NTkIpWKKnXrNxhnsXL/i8UIYbp168dUlRwFBSZvZHAy6p41xxGC5tRK4rDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lTNsnMiFvrxHFkPM8M/5PyD6cJyKMPkXa43dHwd/sI=;
 b=Vb/4ETNdgCCskM644XGrQppMkquFMO+3Z7IUlBGdlvnKneufNsVO6LKoGy4T7Dj1vQ5UzayGXK+sDVxpYl55gB+uNf1uFTtyIfBmWV9yVJBs4wsQ9hk6YLR+RQbBhkuNimcnxPXViSZPZvO866fOLwvKq9T9mskJYOe/1exsqftiY31FvVYAnznRqKYSGTJ6Pg8gfOsmG9Rpxk3UGH1JWfj4jh1kv4aOA+PCugrZRqEiDquF5Q7V7VGHBNa/BRN7+2gP9ALRuGS6qyiWqjW3vTImA5rttNfa7W6wmOKy1EQMm7a8MyS8PXSIaYok3sW2+KzSH3i2WsM+bxyvOCRVDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lTNsnMiFvrxHFkPM8M/5PyD6cJyKMPkXa43dHwd/sI=;
 b=c3UBcwIHVjNJQhQ4AMM0gvniNN0bkl8a4viZMoFfE25+zZfqC2kNmqylUPuV1fQKumQPQTWtBxgW5enqFDE9La62RBEJvpD23gxPnuM9qfTovZhtGytt2xzIid+wawr0japw5/kiOEGKnJUtJYIYZoYuU8dlKfgZxuH9kIm+vaU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DS7PR19MB5711.namprd19.prod.outlook.com (2603:10b6:8:72::19) by
 PH8PR19MB7048.namprd19.prod.outlook.com (2603:10b6:510:224::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Mon, 25 Sep 2023 06:08:16 +0000
Received: from DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::e470:7b70:6ca2:4038]) by DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::e470:7b70:6ca2:4038%2]) with mapi id 15.20.6813.017; Mon, 25 Sep 2023
 06:08:16 +0000
From:   Li Dongyang <dongyangli@ddn.com>
To:     linux-ext4@vger.kernel.org
Cc:     adilger@dilger.ca
Subject: [PATCH 2/2] mke2fs: do not set the BLOCK_UNINIT on groups has GDT
Date:   Mon, 25 Sep 2023 16:08:01 +1000
Message-ID: <20230925060801.1397581-2-dongyangli@ddn.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925060801.1397581-1-dongyangli@ddn.com>
References: <20230925060801.1397581-1-dongyangli@ddn.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0034.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:206::14) To DS7PR19MB5711.namprd19.prod.outlook.com
 (2603:10b6:8:72::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB5711:EE_|PH8PR19MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: d94884e5-9ae4-4181-6f27-08dbbd8dcf26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wz7BTD7d0ACqRYob9nrV8BYuL0BGraSxfhQWC/Ofgktu8/iWKNVaLvx/JXfcyv+LkV+dueHHpOVEtWNtaOfS79zGZJr7RwQKEeulo6bRyphKcnJUBow4soFHxPJPzS48zmnKoyobBZiu1CFttncdfNuVedc/bsAlJs4qVhWXcjEFv/iGnq1afG6DkIQvPGgmrWzMT3u3QjOWw6kvYTZUwzSwX9iFn67ZV40hGAo8wW22tNCiIQWD4wIzV4KCCSwBn4TJnpQ89FhNSmzwOufCQETGkuOIQMPsCMH9VehdhErfvKU0bAH3fAbtUom0q937MIHoVKxpRnKLGR4yayeAAkGWolfSu9ZwPz2uh0nh9x5Chtws4KIZIQjQC4ziMXAFOC0RVEUQi6EIJx7YrA2Hzf/52UI52YQGU3Z2+4YMjEXqo3W1rwZSMnIv1RRgV4sm/gRY6TggLYH3E7DtphFC7imz0Lf9yHOpy4HOF93XiGCvETw7/kjcC0cLnzpNePcu3rA5EThx1WFLe2flqd0RwibsmKuY3GAZDJdDQqZlRZ3VacMQwnIInSG0B06pHDGR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB5711.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(39840400004)(366004)(346002)(230922051799003)(451199024)(1800799009)(186009)(30864003)(6486002)(83380400001)(26005)(36756003)(5660300002)(478600001)(8676002)(8936002)(4326008)(2906002)(6666004)(38100700002)(6916009)(316002)(66476007)(66556008)(66946007)(41300700001)(1076003)(2616005)(6506007)(6512007)(55236004)(40140700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?12aEEn88MlH10FgKFaTPcEJZLxkLNmnHFlcuxsmsLAHPPFgo3M69GDD7LTRn?=
 =?us-ascii?Q?UCEG60J6qYtf25X2GKzYKj4vGDr9V3KOg7cIxpY32kCOH9je617IWIQ9s0XO?=
 =?us-ascii?Q?oJEJnbMNrH+f7/m+bF/BHqeVpUh0yjtTwnD7CdLnEDIvNvnWqL3aqS3Bqc2k?=
 =?us-ascii?Q?/4dXodrQqr9LAbHg/yXXKh9t3a+LKYN3EDEctsgu2HLemo7swWwkCczmVXBc?=
 =?us-ascii?Q?OhL6UBAS7ZCOViGu4ptECB8DKvHXwfW5ekcrDQPZq/aLoyuQF8972Oh1DTLU?=
 =?us-ascii?Q?GsGXOzQPqhNF8uJjRlQTIuACDP9WSscevKLfPpY6IgRUuZURCGg3I0SME7ox?=
 =?us-ascii?Q?NRK9tTIY4LjxB16mMiUucDppb5V6UJERL+IBt83+1FCBHxCuLcGpvsF4yFOl?=
 =?us-ascii?Q?xvJhoyhFQ2P0d0X8hizI4RMP49Fn+hVbfGO6kx9BR+xK82riyCp0FOA50dlR?=
 =?us-ascii?Q?mZ4Csdmup/hsZ3ICtASCKPmvbLJ80Yl+D67l7/W021JcFLMBsV4dD6UGxawa?=
 =?us-ascii?Q?gln5L8yZUsCTJ3CT5TacCcy2MRz5YxPa7bRzMM3mlz9fWIP86Ui5qGIry6O3?=
 =?us-ascii?Q?apcRZ9n3GGsnNYXNEPli4Hehdkk/DFOCMP1WUHtLjO3qZYNcNIztQ5o6KmXp?=
 =?us-ascii?Q?3yhwEPAgFjohdv+sBDEf/79/y4WYGFIPuBooSKS5V1I87GOmHCSzlDl9O2I+?=
 =?us-ascii?Q?RGg6bqKUMPsbimUROENDFSyZ+Idb/mbKKxh8ytFWqTs6BGNdkOCzcRAjGdTZ?=
 =?us-ascii?Q?OO3HU+gyrwLVZBN7GZu/tzHUWoWb52EUrk75MV+DDjjk4A+kbBA4AtpiEpV5?=
 =?us-ascii?Q?mhibo2bqVZzCFHc3GZludy0mV8QncQHEJyaI8FjX2dEpy1Dxhf+WHiCaX3bf?=
 =?us-ascii?Q?tioXHjexyyrrfGNw1QX766QXORONz+DWoT5HKw9aOPm3+mm+9Kd5jL6bkd6O?=
 =?us-ascii?Q?DjbBQhcLNRfTVmoTtwmlq32CN1+zIC7RnI0FbHRtH3KIG/VXi9PoQZ9Htx45?=
 =?us-ascii?Q?3laeRuVkUNWEcSAnYyaGL0qlXkUBGFwcHyn+NsGIWbcTnKlcQ+UMVSvvmCYn?=
 =?us-ascii?Q?NGbxSgwwtqgGz53SMNRA8p/VaDUmIGlBGppZ72897nJmK/8vtnr6FMWpcBEr?=
 =?us-ascii?Q?rWkyW31bTJJI/bJRBpf1JoJakz0VhWJPWBlMyntSoBm3/QVpXMQBwSsJbFDN?=
 =?us-ascii?Q?yRmrU26/H82VJUnN6wXaKJkMvmmFum/MFHhBwKAupfRd643beJJIo8mfMa7M?=
 =?us-ascii?Q?hUcu2Pi3BpbNfzeKFijRO+clKba2ftStZjRe2P9TWvOhnaWLJY937OGsBLG8?=
 =?us-ascii?Q?K2TZzj2vgRkeq8zRxj/A6n5/rOj6ztsBfSj36vaJwwQozXoJ2G4/b0nC/ji5?=
 =?us-ascii?Q?bSZcgLAjFoPx+Pa1BAxANtxt5xB0KU0D4lcW1o9HPV3gkHfKzbfWxQBu2yYX?=
 =?us-ascii?Q?pQkzh/9fnrK7WFX1NuqnbO/SRwEICX20VNbTtldMrii/tz8Hn5ylJc+dGavC?=
 =?us-ascii?Q?cqw9+JBXuMkRg06q9YaRb8AcCYwOaYDN2t3WJAWT7/6zBb+/8f65ShGaBsM5?=
 =?us-ascii?Q?Mjc9R0XgzMlDrxeqChY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6jN+hBTys2VIQX4edaHnYy+0iWDDFMKY56Q4cDqPultsYD2XULwIcA8wtJwACNp0bMp37cSncc7doV/Gx4ZVpDwX7gQ3nkSCBGXUJo60BEIt1yFaJgj1JXvsrrD5GHhJNDPAeeu28dsytbdydYdeioh31AMeB9sT1hEs770z6/yvmGRRxXeCDdDLNdTJqmlzYSgiZELEV09IegNK0+w2AW0IDjVW/qWiySufhW1MmjCW4Pe3HW5xw5jnj752CYTTlHwXteMNT4CWWQr1ptxbXNZKeaATO333b3OgO5CP6TakZfR8i7o0IMR+FHJokYYJIbvjZR+Szx2fO/x/fXrWwXmOPZzCUnJ29oKC25Ozor/eKons5xl93VKT/jGRuW+a9Pkmh1dpr9B1N2aCHEd9lRr0mPa4NK2a+01m0FKMSyHGByW5LQZLCKROeFmYPl6FmxlhpKbEXHRBqIx85mZxuzjxHGpDiCvTTAremiJabUVBjGu/fv5bKt3v1UkV4CblSIOvOzvSSMqo9rSXqFAVCCiRAh5qoywySLHRqfoNDpDojQmGQY6lBhNUI1CBuPattVXzNHnIVvwNHXZD5i830TlbUUdoDdeWhPHKgdvff+3VGNnze7lyUNHHUqYWqT4gKAL9+lZBAuxYYcVFdzPXPICK744yhkVt7XiYfhBMEh+weiriwXHWO7CLg8twmdKmhR9YCTDAxPqhG+Pg4VoRBuPhOSbcTqe+XhS2IQqAhWAbfeMoH81neKkjUsrQ5Jk7faNW72A8LkTu3uxryknnXPI0wmCZDPLY5WDuzmtdCya78AXk4aXfuBKA6nNZhSqPpZ0zntYBxG6X7n61oc6ddg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d94884e5-9ae4-4181-6f27-08dbbd8dcf26
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB5711.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 06:08:16.7823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ghWO/xuxL4Ccozi+APqnmK/jPGayFdBB589UyFyyrDviWrhtRX1Ld/YcPdwmUOzl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB7048
X-BESS-ID: 1695622093-102696-26662-4047-2
X-BESS-VER: 2019.1_20230913.1749
X-BESS-Apparent-Source-IP: 104.47.66.43
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmRqaGQGYGUNTI1DzN3MLcON
        XAMskwKcnYzMTEIiXNINnM1MLI0DDFQKk2FgDdCGeLQgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.251066 [from 
        cloudscan13-140.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch prepares the expansion of GDT blocks beyond a
single group, by make mke2fs to not set BLOCK_UNINIT on
groups with GDT blocks, block/inode bitmaps, or inode table
blocks allocated.

Otherwise, we still rely on kernel side to initialize the
block bitmap if the groups has BLOCK_UNINIT set, and the
kernel doesn't know a group could have GDT blocks allocated,
so it would make an bad block bitmap.

As a result, expect output of several tests needs to be changed,
especially if the test uses dumpe2fs to print the group summary.

Signed-off-by: Li Dongyang <dongyangli@ddn.com>
---
 lib/ext2fs/initialize.c                        |  2 +-
 tests/j_ext_long_trans/expect                  |  2 +-
 tests/j_long_trans/expect                      |  2 +-
 tests/j_long_trans_mcsum_32bit/expect          |  2 +-
 tests/j_long_trans_mcsum_64bit/expect          |  2 +-
 tests/j_short_trans_mcsum_64bit/expect         |  2 +-
 tests/j_short_trans_recover_mcsum_64bit/expect |  2 +-
 tests/m_bigjournal/expect.1                    | 16 ++++++++--------
 tests/m_resize_inode_meta_bg/expect.1          |  6 +++---
 tests/m_uninit/expect.1                        | 10 +++++-----
 10 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/lib/ext2fs/initialize.c b/lib/ext2fs/initialize.c
index 90012f732..5560cd3f8 100644
--- a/lib/ext2fs/initialize.c
+++ b/lib/ext2fs/initialize.c
@@ -535,7 +535,7 @@ ipg_retry:
 		 * because the block bitmap needs to be padded.
 		 */
 		if (csum_flag) {
-			if (i != fs->group_desc_count - 1)
+			if (i != fs->group_desc_count - 1 && numblocks == 0)
 				ext2fs_bg_flags_set(fs, i,
 						    EXT2_BG_BLOCK_UNINIT);
 			ext2fs_bg_flags_set(fs, i, EXT2_BG_INODE_UNINIT);
diff --git a/tests/j_ext_long_trans/expect b/tests/j_ext_long_trans/expect
index ea3c87fcb..b95aa9bc2 100644
--- a/tests/j_ext_long_trans/expect
+++ b/tests/j_ext_long_trans/expect
@@ -77,7 +77,7 @@ Root inode not allocated.  Allocate? yes
 
 Pass 4: Checking reference counts
 Pass 5: Checking group summary information
-Block bitmap differences:  +(1--259) +275 +(291--418) +2341
+Block bitmap differences:  +(1--260) +262 +264 +266 +268 +(275--276) +278 +280 +282 +284 +(291--546) +(675--802) +(931--1058) +(1187--1314) +(1443--1570) +2341 +(8193--8450) +(24577--24834) +(40961--41218) +(57345--57602) +(73729--73986)
 Fix? yes
 
 Free blocks count wrong for group #0 (5838, counted=5851).
diff --git a/tests/j_long_trans/expect b/tests/j_long_trans/expect
index 82b3caf17..ee7af96ab 100644
--- a/tests/j_long_trans/expect
+++ b/tests/j_long_trans/expect
@@ -72,7 +72,7 @@ Root inode not allocated.  Allocate? yes
 
 Pass 4: Checking reference counts
 Pass 5: Checking group summary information
-Block bitmap differences:  +(1--259) +273 +275 +289 +(291--418) +(2083--2210) +2341
+Block bitmap differences:  +(1--260) +262 +264 +266 +268 +273 +(275--276) +278 +280 +282 +284 +289 +(291--546) +(675--802) +(931--1058) +(1187--1314) +(1443--1570) +(2083--2210) +2341 +(8193--8450) +(24577--24834) +(40961--41218) +(57345--57602) +(73729--73986)
 Fix? yes
 
 Free blocks count wrong for group #0 (5838, counted=5851).
diff --git a/tests/j_long_trans_mcsum_32bit/expect b/tests/j_long_trans_mcsum_32bit/expect
index ffae07a69..0b6cf499c 100644
--- a/tests/j_long_trans_mcsum_32bit/expect
+++ b/tests/j_long_trans_mcsum_32bit/expect
@@ -108,7 +108,7 @@ Root inode not allocated.  Allocate? yes
 
 Pass 4: Checking reference counts
 Pass 5: Checking group summary information
-Block bitmap differences:  +(1--260) +276 +(292--419) +2342 -(139265--155648)
+Block bitmap differences:  +(1--261) +263 +265 +267 +269 +(276--277) +279 +281 +283 +285 +(292--547) +(676--803) +(932--1059) +(1188--1315) +(1444--1571) +2342 +(8193--8451) +(24577--24835) +(40961--41219) +(57345--57603) +(73729--73987) -(139265--155648)
 Fix? yes
 
 Free blocks count wrong for group #0 (5837, counted=5850).
diff --git a/tests/j_long_trans_mcsum_64bit/expect b/tests/j_long_trans_mcsum_64bit/expect
index e891def16..b520c91bc 100644
--- a/tests/j_long_trans_mcsum_64bit/expect
+++ b/tests/j_long_trans_mcsum_64bit/expect
@@ -107,7 +107,7 @@ Root inode not allocated.  Allocate? yes
 
 Pass 4: Checking reference counts
 Pass 5: Checking group summary information
-Block bitmap differences:  +(1--262) +278 +(294--421) +2344 -(139265--155648)
+Block bitmap differences:  +(1--263) +265 +267 +269 +271 +(278--279) +281 +283 +285 +287 +(294--549) +(678--805) +(934--1061) +(1190--1317) +(1446--1573) +2344 +(8193--8453) +(24577--24837) +(40961--41221) +(57345--57605) +(73729--73989) -(139265--155648)
 Fix? yes
 
 Free blocks count wrong for group #0 (5835, counted=5848).
diff --git a/tests/j_short_trans_mcsum_64bit/expect b/tests/j_short_trans_mcsum_64bit/expect
index d73e28297..5a4f5b94b 100644
--- a/tests/j_short_trans_mcsum_64bit/expect
+++ b/tests/j_short_trans_mcsum_64bit/expect
@@ -28,7 +28,7 @@ Pass 2: Checking directory structure
 Pass 3: Checking directory connectivity
 Pass 4: Checking reference counts
 Pass 5: Checking group summary information
-Block bitmap differences:  +(0--65) +(67--69) +(71--584) +(1097--2126) +(65536--69631) +(98304--98368)
+Block bitmap differences:  +(0--2126) +(32768--32832) +(65536--69631) +(98304--98368)
 Fix? yes
 
 Inode bitmap differences:  +(1--11)
diff --git a/tests/j_short_trans_recover_mcsum_64bit/expect b/tests/j_short_trans_recover_mcsum_64bit/expect
index 8c637f122..7139fd80a 100644
--- a/tests/j_short_trans_recover_mcsum_64bit/expect
+++ b/tests/j_short_trans_recover_mcsum_64bit/expect
@@ -30,7 +30,7 @@ Pass 2: Checking directory structure
 Pass 3: Checking directory connectivity
 Pass 4: Checking reference counts
 Pass 5: Checking group summary information
-Block bitmap differences:  +(0--65) +(67--69) +(71--584) +(1097--2126) +(65536--69631) +(98304--98368)
+Block bitmap differences:  +(0--2126) +(32768--32832) +(65536--69631) +(98304--98368)
 Fix? yes
 
 Inode bitmap differences:  +(1--11)
diff --git a/tests/m_bigjournal/expect.1 b/tests/m_bigjournal/expect.1
index eb0e3bc38..4e6674665 100644
--- a/tests/m_bigjournal/expect.1
+++ b/tests/m_bigjournal/expect.1
@@ -58,7 +58,7 @@ Group 0: (Blocks 0-32767)
   31837 free blocks, 5 free inodes, 2 directories, 5 unused inodes
   Free blocks: 931-32767
   Free inodes: 12-16
-Group 1: (Blocks 32768-65535) [INODE_UNINIT, BLOCK_UNINIT]
+Group 1: (Blocks 32768-65535) [INODE_UNINIT]
   Backup superblock at 32768, Group descriptors at 32769-32769
   Reserved GDT blocks at 32770-33440
   Block bitmap at 674 (bg #0 + 674), Inode bitmap at 758 (bg #0 + 758)
@@ -72,7 +72,7 @@ Group 2: (Blocks 65536-98303) [INODE_UNINIT, BLOCK_UNINIT]
   32768 free blocks, 16 free inodes, 0 directories, 16 unused inodes
   Free blocks: 65536-98303
   Free inodes: 33-48
-Group 3: (Blocks 98304-131071) [INODE_UNINIT, BLOCK_UNINIT]
+Group 3: (Blocks 98304-131071) [INODE_UNINIT]
   Backup superblock at 98304, Group descriptors at 98305-98305
   Reserved GDT blocks at 98306-98976
   Block bitmap at 676 (bg #0 + 676), Inode bitmap at 760 (bg #0 + 760)
@@ -86,7 +86,7 @@ Group 4: (Blocks 131072-163839) [INODE_UNINIT, BLOCK_UNINIT]
   32768 free blocks, 16 free inodes, 0 directories, 16 unused inodes
   Free blocks: 131072-163839
   Free inodes: 65-80
-Group 5: (Blocks 163840-196607) [INODE_UNINIT, BLOCK_UNINIT]
+Group 5: (Blocks 163840-196607) [INODE_UNINIT]
   Backup superblock at 163840, Group descriptors at 163841-163841
   Reserved GDT blocks at 163842-164512
   Block bitmap at 678 (bg #0 + 678), Inode bitmap at 762 (bg #0 + 762)
@@ -100,7 +100,7 @@ Group 6: (Blocks 196608-229375) [INODE_UNINIT, BLOCK_UNINIT]
   32768 free blocks, 16 free inodes, 0 directories, 16 unused inodes
   Free blocks: 196608-229375
   Free inodes: 97-112
-Group 7: (Blocks 229376-262143) [INODE_UNINIT, BLOCK_UNINIT]
+Group 7: (Blocks 229376-262143) [INODE_UNINIT]
   Backup superblock at 229376, Group descriptors at 229377-229377
   Reserved GDT blocks at 229378-230048
   Block bitmap at 680 (bg #0 + 680), Inode bitmap at 764 (bg #0 + 764)
@@ -114,7 +114,7 @@ Group 8: (Blocks 262144-294911) [INODE_UNINIT, BLOCK_UNINIT]
   32768 free blocks, 16 free inodes, 0 directories, 16 unused inodes
   Free blocks: 262144-294911
   Free inodes: 129-144
-Group 9: (Blocks 294912-327679) [INODE_UNINIT, BLOCK_UNINIT]
+Group 9: (Blocks 294912-327679) [INODE_UNINIT]
   Backup superblock at 294912, Group descriptors at 294913-294913
   Reserved GDT blocks at 294914-295584
   Block bitmap at 682 (bg #0 + 682), Inode bitmap at 766 (bg #0 + 766)
@@ -212,7 +212,7 @@ Group 24: (Blocks 786432-819199) [INODE_UNINIT, BLOCK_UNINIT]
   32768 free blocks, 16 free inodes, 0 directories, 16 unused inodes
   Free blocks: 786432-819199
   Free inodes: 385-400
-Group 25: (Blocks 819200-851967) [INODE_UNINIT, BLOCK_UNINIT]
+Group 25: (Blocks 819200-851967) [INODE_UNINIT]
   Backup superblock at 819200, Group descriptors at 819201-819201
   Reserved GDT blocks at 819202-819872
   Block bitmap at 698 (bg #0 + 698), Inode bitmap at 782 (bg #0 + 782)
@@ -226,7 +226,7 @@ Group 26: (Blocks 851968-884735) [INODE_UNINIT, BLOCK_UNINIT]
   32768 free blocks, 16 free inodes, 0 directories, 16 unused inodes
   Free blocks: 851968-884735
   Free inodes: 417-432
-Group 27: (Blocks 884736-917503) [INODE_UNINIT, BLOCK_UNINIT]
+Group 27: (Blocks 884736-917503) [INODE_UNINIT]
   Backup superblock at 884736, Group descriptors at 884737-884737
   Reserved GDT blocks at 884738-885408
   Block bitmap at 700 (bg #0 + 700), Inode bitmap at 784 (bg #0 + 784)
@@ -554,7 +554,7 @@ Group 80: (Blocks 2621440-2654207) [INODE_UNINIT, BLOCK_UNINIT]
   32768 free blocks, 16 free inodes, 0 directories, 16 unused inodes
   Free blocks: 2621440-2654207
   Free inodes: 1281-1296
-Group 81: (Blocks 2654208-2686975) [INODE_UNINIT, BLOCK_UNINIT]
+Group 81: (Blocks 2654208-2686975) [INODE_UNINIT]
   Backup superblock at 2654208, Group descriptors at 2654209-2654209
   Reserved GDT blocks at 2654210-2654880
   Block bitmap at 754 (bg #0 + 754), Inode bitmap at 838 (bg #0 + 838)
diff --git a/tests/m_resize_inode_meta_bg/expect.1 b/tests/m_resize_inode_meta_bg/expect.1
index 7feaed9d8..83c7bc57c 100644
--- a/tests/m_resize_inode_meta_bg/expect.1
+++ b/tests/m_resize_inode_meta_bg/expect.1
@@ -67,7 +67,7 @@ Group 0: (Blocks 0-255) [ITABLE_ZEROED]
   159 free blocks, 53 free inodes, 2 directories, 53 unused inodes
   Free blocks: 97-255
   Free inodes: 12-64
-Group 1: (Blocks 256-511) [INODE_UNINIT, BLOCK_UNINIT, ITABLE_ZEROED]
+Group 1: (Blocks 256-511) [INODE_UNINIT, ITABLE_ZEROED]
   Backup superblock at 256, Group descriptor at 257
   Block bitmap at 3 (bg #0 + 3)
   Inode bitmap at 18 (bg #0 + 18)
@@ -82,7 +82,7 @@ Group 2: (Blocks 512-767) [INODE_UNINIT, BLOCK_UNINIT, ITABLE_ZEROED]
   256 free blocks, 64 free inodes, 0 directories, 64 unused inodes
   Free blocks: 512-767
   Free inodes: 129-192
-Group 3: (Blocks 768-1023) [INODE_UNINIT, BLOCK_UNINIT, ITABLE_ZEROED]
+Group 3: (Blocks 768-1023) [INODE_UNINIT, ITABLE_ZEROED]
   Backup superblock at 768
   Block bitmap at 5 (bg #0 + 5)
   Inode bitmap at 20 (bg #0 + 20)
@@ -97,7 +97,7 @@ Group 4: (Blocks 1024-1279) [INODE_UNINIT, BLOCK_UNINIT, ITABLE_ZEROED]
   256 free blocks, 64 free inodes, 0 directories, 64 unused inodes
   Free blocks: 1024-1279
   Free inodes: 257-320
-Group 5: (Blocks 1280-1535) [INODE_UNINIT, BLOCK_UNINIT, ITABLE_ZEROED]
+Group 5: (Blocks 1280-1535) [INODE_UNINIT, ITABLE_ZEROED]
   Backup superblock at 1280
   Block bitmap at 7 (bg #0 + 7)
   Inode bitmap at 22 (bg #0 + 22)
diff --git a/tests/m_uninit/expect.1 b/tests/m_uninit/expect.1
index 3c2875527..2058de7a9 100644
--- a/tests/m_uninit/expect.1
+++ b/tests/m_uninit/expect.1
@@ -56,7 +56,7 @@ Group 0: (Blocks 1-8192) [ITABLE_ZEROED]
   7406 free blocks, 2037 free inodes, 2 directories, 2037 unused inodes
   Free blocks: 787-8192
   Free inodes: 12-2048
-Group 1: (Blocks 8193-16384) [INODE_UNINIT, BLOCK_UNINIT, ITABLE_ZEROED]
+Group 1: (Blocks 8193-16384) [INODE_UNINIT, ITABLE_ZEROED]
   Backup superblock at 8193, Group descriptors at 8194-8194
   Reserved GDT blocks at 8195-8450
   Block bitmap at 8451 (+258), Inode bitmap at 8452 (+259)
@@ -70,7 +70,7 @@ Group 2: (Blocks 16385-24576) [INODE_UNINIT, BLOCK_UNINIT, ITABLE_ZEROED]
   7678 free blocks, 2048 free inodes, 0 directories, 2048 unused inodes
   Free blocks: 16899-24576
   Free inodes: 4097-6144
-Group 3: (Blocks 24577-32768) [INODE_UNINIT, BLOCK_UNINIT, ITABLE_ZEROED]
+Group 3: (Blocks 24577-32768) [INODE_UNINIT, ITABLE_ZEROED]
   Backup superblock at 24577, Group descriptors at 24578-24578
   Reserved GDT blocks at 24579-24834
   Block bitmap at 24835 (+258), Inode bitmap at 24836 (+259)
@@ -84,7 +84,7 @@ Group 4: (Blocks 32769-40960) [INODE_UNINIT, BLOCK_UNINIT, ITABLE_ZEROED]
   7678 free blocks, 2048 free inodes, 0 directories, 2048 unused inodes
   Free blocks: 33283-40960
   Free inodes: 8193-10240
-Group 5: (Blocks 40961-49152) [INODE_UNINIT, BLOCK_UNINIT, ITABLE_ZEROED]
+Group 5: (Blocks 40961-49152) [INODE_UNINIT, ITABLE_ZEROED]
   Backup superblock at 40961, Group descriptors at 40962-40962
   Reserved GDT blocks at 40963-41218
   Block bitmap at 41219 (+258), Inode bitmap at 41220 (+259)
@@ -98,7 +98,7 @@ Group 6: (Blocks 49153-57344) [INODE_UNINIT, BLOCK_UNINIT, ITABLE_ZEROED]
   7678 free blocks, 2048 free inodes, 0 directories, 2048 unused inodes
   Free blocks: 49667-57344
   Free inodes: 12289-14336
-Group 7: (Blocks 57345-65536) [INODE_UNINIT, BLOCK_UNINIT, ITABLE_ZEROED]
+Group 7: (Blocks 57345-65536) [INODE_UNINIT, ITABLE_ZEROED]
   Backup superblock at 57345, Group descriptors at 57346-57346
   Reserved GDT blocks at 57347-57602
   Block bitmap at 57603 (+258), Inode bitmap at 57604 (+259)
@@ -112,7 +112,7 @@ Group 8: (Blocks 65537-73728) [INODE_UNINIT, BLOCK_UNINIT, ITABLE_ZEROED]
   7678 free blocks, 2048 free inodes, 0 directories, 2048 unused inodes
   Free blocks: 66051-73728
   Free inodes: 16385-18432
-Group 9: (Blocks 73729-81920) [INODE_UNINIT, BLOCK_UNINIT, ITABLE_ZEROED]
+Group 9: (Blocks 73729-81920) [INODE_UNINIT, ITABLE_ZEROED]
   Backup superblock at 73729, Group descriptors at 73730-73730
   Reserved GDT blocks at 73731-73986
   Block bitmap at 73987 (+258), Inode bitmap at 73988 (+259)
-- 
2.41.0

