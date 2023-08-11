Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E3B77875C
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Aug 2023 08:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjHKGTZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Aug 2023 02:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjHKGTZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Aug 2023 02:19:25 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6260E2D48
        for <linux-ext4@vger.kernel.org>; Thu, 10 Aug 2023 23:19:19 -0700 (PDT)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168]) by mx-outbound13-154.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 11 Aug 2023 06:19:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4lk1N0aLR9sg2rdlwKY3jO5wVncenCG/sS+McmMt00Vzcif3xyEacpC5cO846PppoY6uiZaYZKCRZXG43sXgRc2g90lMubqWd64Yu+3QwBkM13XAJImKFUOhYco+MAMWw8OWoMD0AF+IhNYyrwCP04bKcQmk8wgtoo5wpe9+vJjxF6pyyqz9myCuyKU3b3lkbSRU/F1ApwLq1Wcy8q677E0+htiuf4TbjRE29Ce1Pc83zKWjQBPj/lUFotAIfNjPh+Oalxp9xSI8kCwya3s3h2QtYmlXGvZ2I9YD8bOeO25GBHS+YPFkqrcECL5F+AoTOs3usOasQmmjtVAXR+BKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mkmMjXs0W6ouV8qPZst8XZYtbvco68h3TGAFsOjTko=;
 b=OvVm9Z6QRNy2GS/1KuhGHWEwP257Hj2+shisXzf/C6+jpXXAwtNpFUIqbuvW9Ej/e8PW4v1ev17AIOdW1pDeIcMCQxWuluY8txmJmtkRuXA2nBEjDpWcKFksVeQa3//539+Cq74A3ckYuqbtID3r4K0cGlDnnkvxvJaNUn7+kJZ34zCtGxnHi8C27sEg3kCly+FJnA6aZHW7uZiR/26C6C8iNQ2MgnrJ9LZ5tSF6XPCbLd0RsAKVawZUeQVNEFGSYyPMMVYzIHCnSVBvnY/VzGHkpolicXUTLN5/vYBmcTKupGESQh1su9mi5TdKrdKeQZ0tXKQXUvlYXpLTRRp/Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mkmMjXs0W6ouV8qPZst8XZYtbvco68h3TGAFsOjTko=;
 b=OBoXFaD1JF8LOXZe23Wsy5TMgvYucmvP6dxSDOfpKd8r5Tl6DC0XMVWRz/0gqy9LKtJE/O+ql78uMRBdEkozmcLlBlpg6DDFTYhk2Ch6BjHBVqNPJU0B78NUxud1/WQSDBn4xn5c5plXaxejyrx3m0SpmOxaJ0HT4g1RhM9DU2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DS7PR19MB5711.namprd19.prod.outlook.com (2603:10b6:8:72::19) by
 PH7PR19MB7340.namprd19.prod.outlook.com (2603:10b6:510:27b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Fri, 11 Aug
 2023 06:19:14 +0000
Received: from DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::3110:9950:e5d9:af44]) by DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::3110:9950:e5d9:af44%7]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 06:19:14 +0000
From:   Li Dongyang <dongyangli@ddn.com>
To:     linux-ext4@vger.kernel.org
Cc:     adilger@dilger.ca, sihara@ddn.com, wangshilong1991@gmail.com
Subject: [PATCH 1/2] ext4: introduce EXT4_BG_TRIMMED to optimize fstrim
Date:   Fri, 11 Aug 2023 16:19:04 +1000
Message-ID: <20230811061905.301124-1-dongyangli@ddn.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0007.ausprd01.prod.outlook.com
 (2603:10c6:10:1fa::12) To DS7PR19MB5711.namprd19.prod.outlook.com
 (2603:10b6:8:72::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB5711:EE_|PH7PR19MB7340:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cbfa391-9585-40b5-11a7-08db9a32e22b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bnY5C01ra4WL1Pqbk+BZQcwZU9NNTwAt9NaseiRuuFSCnqXpTc8niRpbFtgVxGtSvpC6/o4+vPP5hokX5vM6cwRYMnPrq8rljyw+NOyF0+RqSab3MPAqwz1M0vW4vjyecypwxvEHda15YDZRkunFZwnDR09HMRZUXhaFBCChKbiLxEpL8sNaZ68LLFW+XlHuaojo4y6AMjh/iBbY3IftMk16ddfDspk+2Lx7pz7XH6RgBn4JRFU++NiDjJerwjhTs/G24kRigMAanAbpR0bmpd9gbaW+uSSUBwuAcmwPbEARoHLLBmSGNo9QnROefyb+uAVI5zYpko8WNKxQsDz8MEHwOW24zfXaYGktsiaOQ/WWBra6nLdW6Zb8elMlX0EZO1BkGyY7Lb18zGjR5Xzk9EqExVAUmoFhdB6uYvzUCKOtwRWlVHZ1IsRnDLPQ1/I7pgrr9zLjaOpU/UuY+1wAGnoHSGmYHMAV4vv/j+ygmmVYUZLNX696sqD0MQclFq6xKnaXpngpr6qXdYTov/inEWq+6KmTuzuq6HangblWrBXU22RM1iTSpYGmEiIsK+fi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB5711.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39850400004)(366004)(451199021)(186006)(1800799006)(6666004)(6486002)(6506007)(478600001)(55236004)(36756003)(38100700002)(26005)(1076003)(2906002)(6512007)(83380400001)(2616005)(4326008)(66476007)(66556008)(6916009)(5660300002)(8936002)(8676002)(66946007)(316002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CQrtcShlX8DZ88anJBFdVsDyV3VmJOHayPqHC6tZnoeOp3Nf0Et9j7Iy3pBm?=
 =?us-ascii?Q?OzjM9Pyqcq1mYJ1L2resQE+lj5jEZ7XTkpXZLbsbe4m5RRWA1vQQkWtoXjJg?=
 =?us-ascii?Q?bSud1NBe2I8dZsNBxpbwrq1yF1QhjfCFkXV7dwgxvmsdHaFdYh2elBQowrTJ?=
 =?us-ascii?Q?5ScNBAARXzi3MU1eCXzSng6yj+SttYOPclcPc6cjsC/Dv+/6UALXU0jHOgQ6?=
 =?us-ascii?Q?Hx7inihPW05j6VDDmvoEUEa+8IKooW8t3iTLfBMPMTD6j/G7WIDIgG1HRRiB?=
 =?us-ascii?Q?KZP6nOXyoHhJyu8ELcAKAiHgHYtxcm4WwOB4oT8ekLP2MpOYgF8GYqsF26bb?=
 =?us-ascii?Q?YdmGeqgK8naLJ6//JG+bIEe1TeWHKuZKxfK1arGMO8+kqIbSIYthCFt92HDC?=
 =?us-ascii?Q?IUBm9K7ZnW5RBTXnDTlTch2XHP2i4+5RT/i8Pmh91ue53hlr4WLTWErqiTjq?=
 =?us-ascii?Q?bQ0arQQlPcmMaqhM4bQrjDJEQkJN4ivCBYDH9nJCMocg28eV2DTuJ7ftV3DD?=
 =?us-ascii?Q?B+SqVIAQQc/ZcbunK9Xljx/oTcl3/PDsX32aKfJ6pYhd52bHbMuBvJ1cNIEC?=
 =?us-ascii?Q?EBlto62Lq4nqyLLE7AbaRdkjOQkbmO9oiJMXWFwiIZYBsYELVNFhh8odHwff?=
 =?us-ascii?Q?l0elrN20tK+C8Iu4ljpjFySJ8ureGk52KVEtYsnXcNVIC3CzYsd8Bx6DvQ/U?=
 =?us-ascii?Q?MxrdDJ3RgJY+ru/XOVzLtfced/jd8ewCYocKzbB6okWCmcp9mU4rF83EhNhw?=
 =?us-ascii?Q?006KMHLdh1r3HLVF1AEGJn1c0c6s4PrHSZcY4yLfmrPelmp30JbfvkzMSrhf?=
 =?us-ascii?Q?zaKPCgfFloSkxiCdHLMy9ZoFJVTv/q47zV+Sb8cTqmicqisr1mLImoLuOOlt?=
 =?us-ascii?Q?1VqgZHex0HQSOII2iaD+6YIjsaSPJQ10ptrS2NcniMCTkqVjylfWoXrpQV4A?=
 =?us-ascii?Q?eeUNyfJ6zOdFfhdPXFQ3nw419eXkHR8FUssqoyOuy2v1tRJy+KQYIuFyJgyJ?=
 =?us-ascii?Q?MEvCbLzbaitAmfwv851LjmDn+XiHnER3AFEkD4kOiKkD402Y39THNji6lpp5?=
 =?us-ascii?Q?9nZyZHJ+mqY4bKqgMkqV11uVu1kjRgqwwEojsRm5dP6CDcn5b3QIMorvhEUU?=
 =?us-ascii?Q?K60AYhZIa0jbBYRlzfPmwV/ZMktTD4dSdloaUg/wSQVOyBRSSZjmoi5CTqFr?=
 =?us-ascii?Q?OxLkr7v/CTM+TXAidVnIQ+rMtX1mkRzC8wnmh7gVeZuPWuXg8T+5Szo7hgop?=
 =?us-ascii?Q?v6m5mGPuLuotZ3mj21FR9b9oef8T8l4bQ045mH+zFFCSU/A9aF2PXkZ0uy22?=
 =?us-ascii?Q?38Ol4DAgF7fQtHujRzU9YXB4pqnqWaZOJSP07xGweMgNbvwg/l+GpXVwdXtq?=
 =?us-ascii?Q?zgoPhJ69lnTbYNUK/UQr9CI0XVcIUOmStMJmMy3+cJhNURAQUdzpyTEgwKn8?=
 =?us-ascii?Q?1jHUWqa5l6iSvwDCgTsgcx7RKaqCYdN+C+386glL997KWJcAaiYHOWxHTcyt?=
 =?us-ascii?Q?Vd89jXw5M0ukn3agytqCCMXWEHJA+iyxCCaKE2Dyb7FeGM1HaTUE/vwBJyGY?=
 =?us-ascii?Q?1BWY+LOc+hAoasA1BS4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: w4zKot0Rk1u7tkKPSvAvwCdpd8al5+AfIUumFYRMZ+isKizdHyXEFCk3/yywh/zfLTWPrH0n/4h1WQ4jhU6VaWkJVewqZpq8124vsWhyj1TAxfTZMHpMHuePbAArk7Dx5eu7FaLdO7k/ES+EjR4eRnCgcuq59F0kmi+upsdpkqAHFSvBAtb6IcYRa6jFtFgWpKwk9SJD4DBIqCKKfIIcjhEdmdv7WajWie01qCNjMQULdW4fPKDjBWMecNXnlutoQ1jIXuHv+2alInMLqdtjXIoWkUmQkVkuPGMPzZlaZQzECbLP91hrHTpsl0FMjol7xCdcL82m592aCDDYkXvhCyFkojjRYHTEZxZNappAfNWFKrErqEHH+J3ZR9cHTonTtOFmhuGdO8Sjy/ijG0H4Iy0r0V6lc3yBXuSD8DarYs1p1xcOQv6Rs6T0ft24GpyLmchZaUr/NxFf7+SIQbEBIU2T4WAATMRlTo9IPjjQ3VS+S2frr1ueiyaO51zWGkiBJ46FWW/UueYtHjFH88BXoIjPpkSqYCVKWcAq+kM5t96ocF17Lnlm5x6Ajvmp3xGLRZ5vzrIZx6qNJmKvb3C3EYtJY6EqW5FXuUBVD/RXheMTcts8CcPphPCY8oKBkDO+OvBBX8HlI5QpIIEcq3txsigq6fHYLNZW0xShQIVlmpOR/3qOYJzucYYagbB93lnDCpn5bDUCXFE/TNmY19KjM5ub8atNx+715MP8xaISmyU6vhumXI17ZTZiI0VLS4fm77VcPld+ypEDpYmLgUpO8U/hICX7NsWAqhW55zGhZ0nPSJUhtp5x/aApTrrBFtPmlNI4JJ209pWuz4+KYeouZGia/4mOT1z7CbuMEyESBSg=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cbfa391-9585-40b5-11a7-08db9a32e22b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB5711.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 06:19:13.9858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: thTknfZDPXjL2okkRwwHyvDx3qpuF3yQSLxEg8ZLw/fPuDTUpauKFPdatFD8dkV7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB7340
X-BESS-ID: 1691734757-103482-12728-84411-1
X-BESS-VER: 2019.1_20230807.1901
X-BESS-Apparent-Source-IP: 104.47.59.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuaGhgZAVgZQMMkwKckgzdQoyS
        zVMtky0dDCwiDRODnRzMTQODnNwCRRqTYWAB6Ow35BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250067 [from 
        cloudscan18-224.us-east-2b.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 MAILTO_TO_SPAM_ADDR    META: Includes a link to a likely spammer email 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=MAILTO_TO_SPAM_ADDR, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Currently the flag indicating block group has done fstrim is not
persistent, and trim status will be lost after remount, as
a result fstrim can not skip the already trimmed groups, which
could be slow on very large devices.

This patch introduces a new block group flag EXT4_BG_TRIMMED,
we need 1 extra block group descriptor write after trimming each
block group.
When clearing the flag, the block group descriptor is journalled
already so no extra overhead.

Add a new super block flag EXT2_FLAGS_TRACK_TRIM, to indicate if
we should honour EXT4_BG_TRIMMED when doing fstrim.
The new super block flag can be turned on/off via tune2fs.

Cc: Shuichi Ihara <sihara@ddn.com>
Cc: Andreas Dilger <adilger@dilger.ca>
Cc: Wang Shilong <wangshilong1991@gmail.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Li Dongyang <dongyangli@ddn.com>
---
 fs/ext4/ext4.h      | 10 ++------
 fs/ext4/ext4_jbd2.h |  3 ++-
 fs/ext4/mballoc.c   | 62 +++++++++++++++++++++++++++++++++++----------
 3 files changed, 52 insertions(+), 23 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 0a2d55faa095..a990fb49b24f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -437,6 +437,7 @@ struct flex_groups {
 #define EXT4_BG_INODE_UNINIT	0x0001 /* Inode table/bitmap not in use */
 #define EXT4_BG_BLOCK_UNINIT	0x0002 /* Block bitmap not in use */
 #define EXT4_BG_INODE_ZEROED	0x0004 /* On-disk itable initialized to zero */
+#define EXT4_BG_TRIMMED		0x0008 /* block group was trimmed */
 
 /*
  * Macro-instructions used to manage group descriptors
@@ -1166,6 +1167,7 @@ struct ext4_inode_info {
 #define EXT2_FLAGS_SIGNED_HASH		0x0001  /* Signed dirhash in use */
 #define EXT2_FLAGS_UNSIGNED_HASH	0x0002  /* Unsigned dirhash in use */
 #define EXT2_FLAGS_TEST_FILESYS		0x0004	/* to test development code */
+#define EXT2_FLAGS_TRACK_TRIM		0x0008  /* Track trim status in each bg */
 
 /*
  * Mount flags set via mount options or defaults
@@ -3412,7 +3414,6 @@ struct ext4_group_info {
 };
 
 #define EXT4_GROUP_INFO_NEED_INIT_BIT		0
-#define EXT4_GROUP_INFO_WAS_TRIMMED_BIT		1
 #define EXT4_GROUP_INFO_BBITMAP_CORRUPT_BIT	2
 #define EXT4_GROUP_INFO_IBITMAP_CORRUPT_BIT	3
 #define EXT4_GROUP_INFO_BBITMAP_CORRUPT		\
@@ -3427,13 +3428,6 @@ struct ext4_group_info {
 	(test_bit(EXT4_GROUP_INFO_BBITMAP_CORRUPT_BIT, &((grp)->bb_state)))
 #define EXT4_MB_GRP_IBITMAP_CORRUPT(grp)	\
 	(test_bit(EXT4_GROUP_INFO_IBITMAP_CORRUPT_BIT, &((grp)->bb_state)))
-
-#define EXT4_MB_GRP_WAS_TRIMMED(grp)	\
-	(test_bit(EXT4_GROUP_INFO_WAS_TRIMMED_BIT, &((grp)->bb_state)))
-#define EXT4_MB_GRP_SET_TRIMMED(grp)	\
-	(set_bit(EXT4_GROUP_INFO_WAS_TRIMMED_BIT, &((grp)->bb_state)))
-#define EXT4_MB_GRP_CLEAR_TRIMMED(grp)	\
-	(clear_bit(EXT4_GROUP_INFO_WAS_TRIMMED_BIT, &((grp)->bb_state)))
 #define EXT4_MB_GRP_TEST_AND_SET_READ(grp)	\
 	(test_and_set_bit(EXT4_GROUP_INFO_BBITMAP_READ_BIT, &((grp)->bb_state)))
 
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 0c77697d5e90..ce529a454b2a 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -120,7 +120,8 @@
 #define EXT4_HT_MOVE_EXTENTS     9
 #define EXT4_HT_XATTR           10
 #define EXT4_HT_EXT_CONVERT     11
-#define EXT4_HT_MAX             12
+#define EXT4_HT_FS_TRIM		12
+#define EXT4_HT_MAX             13
 
 /**
  *   struct ext4_journal_cb_entry - Base structure for callback information.
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 21b903fe546e..80283be01363 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3849,15 +3849,6 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
 	rb_erase(&entry->efd_node, &(db->bb_free_root));
 	mb_free_blocks(NULL, &e4b, entry->efd_start_cluster, entry->efd_count);
 
-	/*
-	 * Clear the trimmed flag for the group so that the next
-	 * ext4_trim_fs can trim it.
-	 * If the volume is mounted with -o discard, online discard
-	 * is supported and the free blocks will be trimmed online.
-	 */
-	if (!test_opt(sb, DISCARD))
-		EXT4_MB_GRP_CLEAR_TRIMMED(db);
-
 	if (!db->bb_free_root.rb_node) {
 		/* No more items in the per group rb tree
 		 * balance refcounts from ext4_mb_free_metadata()
@@ -6587,8 +6578,7 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 					 " group:%u block:%d count:%lu failed"
 					 " with %d", block_group, bit, count,
 					 err);
-		} else
-			EXT4_MB_GRP_CLEAR_TRIMMED(e4b.bd_info);
+		}
 
 		ext4_lock_group(sb, block_group);
 		mb_clear_bits(bitmap_bh->b_data, bit, count_clusters);
@@ -6598,6 +6588,14 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 	ret = ext4_free_group_clusters(sb, gdp) + count_clusters;
 	ext4_free_group_clusters_set(sb, gdp, ret);
 	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
+	/*
+	 * Clear the trimmed flag for the group so that the next
+	 * ext4_trim_fs can trim it.
+	 * If the volume is mounted with -o discard, online discard
+	 * is supported and the free blocks will be trimmed online.
+	 */
+	if (!test_opt(sb, DISCARD))
+		gdp->bg_flags &= cpu_to_le16(~EXT4_BG_TRIMMED);
 	ext4_group_desc_csum_set(sb, block_group, gdp);
 	ext4_unlock_group(sb, block_group);
 
@@ -6995,10 +6993,19 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 		   ext4_grpblk_t minblocks, bool set_trimmed)
 {
 	struct ext4_buddy e4b;
+	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
+	struct ext4_group_desc *gdp;
+	struct buffer_head *gd_bh;
 	int ret;
 
 	trace_ext4_trim_all_free(sb, group, start, max);
 
+	gdp = ext4_get_group_desc(sb, group, &gd_bh);
+	if (!gdp) {
+		ret = -EIO;
+		return ret;
+	}
+
 	ret = ext4_mb_load_buddy(sb, group, &e4b);
 	if (ret) {
 		ext4_warning(sb, "Error %d loading buddy information for %u",
@@ -7008,11 +7015,10 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 
 	ext4_lock_group(sb, group);
 
-	if (!EXT4_MB_GRP_WAS_TRIMMED(e4b.bd_info) ||
+	if (!(es->s_flags & cpu_to_le16(EXT2_FLAGS_TRACK_TRIM) &&
+	      gdp->bg_flags & cpu_to_le16(EXT4_BG_TRIMMED)) ||
 	    minblocks < EXT4_SB(sb)->s_last_trim_minblks) {
 		ret = ext4_try_to_trim_range(sb, &e4b, start, max, minblocks);
-		if (ret >= 0 && set_trimmed)
-			EXT4_MB_GRP_SET_TRIMMED(e4b.bd_info);
 	} else {
 		ret = 0;
 	}
@@ -7020,6 +7026,34 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 	ext4_unlock_group(sb, group);
 	ext4_mb_unload_buddy(&e4b);
 
+	if (ret > 0 && set_trimmed) {
+		int err;
+		handle_t *handle;
+
+		handle = ext4_journal_start_sb(sb, EXT4_HT_FS_TRIM, 1);
+		if (IS_ERR(handle)) {
+			ret = PTR_ERR(handle);
+			goto out_return;
+		}
+		err = ext4_journal_get_write_access(handle, sb, gd_bh,
+						    EXT4_JTR_NONE);
+		if (err) {
+			ret = err;
+			goto out_journal;
+		}
+		ext4_lock_group(sb, group);
+		gdp->bg_flags |= cpu_to_le16(EXT4_BG_TRIMMED);
+		ext4_group_desc_csum_set(sb, group, gdp);
+		ext4_unlock_group(sb, group);
+		err = ext4_handle_dirty_metadata(handle, NULL, gd_bh);
+		if (err)
+			ret = err;
+out_journal:
+		err = ext4_journal_stop(handle);
+		if (err)
+			ret = err;
+	}
+out_return:
 	ext4_debug("trimmed %d blocks in the group %d\n",
 		ret, group);
 
-- 
2.41.0

