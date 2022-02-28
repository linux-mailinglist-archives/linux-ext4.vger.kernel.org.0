Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00084C61AA
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Feb 2022 04:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbiB1DQP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 27 Feb 2022 22:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbiB1DQN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 27 Feb 2022 22:16:13 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300090.outbound.protection.outlook.com [40.107.130.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954C049F9D;
        Sun, 27 Feb 2022 19:15:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUN1+WgZypR5Ra95ktC5fXd0ULLyVuzZFKTKAfC9aXMYigaobqc9KjRWLBgVZV/FgRb0ujEkbR+RKMpc2iDBaV5P2AVqZ9oLLoLVpxVOvh58P4m6iJ30J+uiz7hd4zO9AGvSPDgwe8zgxKEncmrg8axpFXXCcl8YeeAARNOALu57mQOluFTGiiMl+Equ5URw/g9ctmuI+FrNXLwPGy+YHihC/g8/4d1dkQA4/ly5+hi3RCRYhlBlILLtbKnngE3+CZJ3JQLHAjZAzDMHLDWvGnY5Dpb2+bIKm7Prhc53e1jR777nEctz5aCpIY/jMHxnieFAQsJNazUcfZf1rb+wBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRzUaiNWJAXT3p13xI/YHXW21d2xzgh9ZYln3zRz/dc=;
 b=U6Tn5YAPQ9LQuAxZi+Me20YiJN258ItH2/VDa7lZZ6ZoFZeCULS3Xtd7VQw8UxwMjns+bkQ4DZjxJV0tGAijY8f2ZtFD+Pr7c1oh9m1VyInjxV+rxguHgUB1vWpu8yCxzS06i/UlT8P4IiPItlpmOFPWLxqrhnIpXzXxqEUciRslEsYhmVMKc0/87pxX5+kvBXnv0DUYvOex1A4fiZQBNQQOk4USNJnRgUbiXN3b+dln/m7S7vn5XKiO875AF11s2JnZrpIb0M5Z1k4GLhPXfk2aAC4KIh6iRXKZOU/0//i0/9m0I/F0T9vqU1p2OgCLsHbnAD4VQ1x/kNy/wRYCqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRzUaiNWJAXT3p13xI/YHXW21d2xzgh9ZYln3zRz/dc=;
 b=CGxpsqWMSjq+8YK6IJ/z9crF+SQGILe0ZtMzuQ6b0vxN85RDD/cKaYZSiXtJaNTUFsqo/I1lIWotZbVqrmKNkxK1cL2/+MeYfMLdc9tOuAGZVlMMcJ0/2jjfK/FitGoTJBKlohKcdFUfhaMSCT3Kd+7iMau5dsqDfatywA9Jhhc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by TYAPR06MB2191.apcprd06.prod.outlook.com (2603:1096:404:25::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Mon, 28 Feb
 2022 03:15:33 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::49ef:baa:8c3b:cb3d]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::49ef:baa:8c3b:cb3d%5]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 03:15:33 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] ext4: use time_is_before_jiffies() instead of open coding it
Date:   Sun, 27 Feb 2022 19:15:20 -0800
Message-Id: <1646018120-61462-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0108.apcprd03.prod.outlook.com
 (2603:1096:203:b0::24) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8c76c9d-269d-4260-b4d4-08d9fa6894c3
X-MS-TrafficTypeDiagnostic: TYAPR06MB2191:EE_
X-Microsoft-Antispam-PRVS: <TYAPR06MB21910DE4C36B3653C7260EEBBD019@TYAPR06MB2191.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R/VnNL9j5dbTWcUtsloDyeZFbkvnELqSlZlEyBrRP+hNXURdFEfwJgQ0LjKtGT6VrkXfWgVOEVrOYzedrhHWJASD+F/hBowsZc7XYZGmabMdEkc5yARYf4sh/Y/JxzpNSeFrSry0SbvpoL4f/uZ+4210dd0ZOxh96w0WWdokdWGbwRJ/vB1pBPm6N3mbGKijI0l996mV96dieaV/7QNuwQhtHlGlsXYdV7AlHgGH5Lh77ChMbgPff+mwiFVRS/k0rb4S0UyeOQYPqitmG09qqGt5MZt82ciIh/Ci6yHPWSkLViMTItia1pGq//bWfVTbylrmu0wTqfjwEwtMBpegX9CVwcDiK1gpobdFYgJlvUdl4azzo4pY+iFQhS/jsNCU916rlTAQxlRJ1Cic36eaV2wvCrbErlARzGuRr/2XrhACACBgPzQTrbhGE5BwzzQm0ECTNByLkGAL+PCRQlb9w8N1jcTtqevZEWpjqkofl9qlsfT53JW+gdHSzL+yCtlyIQUYwd7SBLiQGB9TppXXRfO5Jnw6g95zL79/kRE28e4ykbrzGyPgUPB9aqurnEZRF9qQR0oH1WJObxhQ6dQq6134mKZDPLUUwdtOd3c2pMPlqPkuQmeePttSOG/t44qgvRFnFG70bKuj+dhj0v2ccNVZ7oBwvGjXZ2tgF/8jDK+48zlqE+YidtPdjt8q2G/sR9RXW5XABYwhJAH7QkBMxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(38100700002)(107886003)(6486002)(6512007)(8676002)(8936002)(4326008)(66556008)(66476007)(508600001)(6666004)(36756003)(83380400001)(110136005)(2906002)(52116002)(316002)(26005)(2616005)(4744005)(86362001)(186003)(5660300002)(6506007)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cfJ504z3oTatC2dwDEbasa2VLduSfR/8/iQL1zPDi6XumBZj6Uc3T3VF6eKR?=
 =?us-ascii?Q?oHts08aZZB6FST+TrRY83vSrKPXbksq8L/nOyrVwJPZw7bb2r0z6JIEC4OzF?=
 =?us-ascii?Q?xqZ3FNKJvG5ZqTzfALn9fC8yubSp+Oo8vCoSsXUqhyc6dbDGtgrUpSR49YDD?=
 =?us-ascii?Q?CUQnEm1V9C3ZSkVkpU2KmfhI/xZiDNNxHpyqXcQULdv5mRKPg+l2g4uXTaUF?=
 =?us-ascii?Q?P3sEPN6/2v3Po0cX5jvNQ6u2JsBPtWXdkzHwCwY6eqECS10SKhPQKqbgldBg?=
 =?us-ascii?Q?u7keHQitwjMqfWKd22jJhboY/sFHDFzvDPVLkAe9Hps8/C3dr1BBbG1EGYLn?=
 =?us-ascii?Q?xKcwBEXL82hcxx0Hr35MjA9Ih2ZBJUYvS82I31eYo97KWuB20PHCwlVTlAiW?=
 =?us-ascii?Q?BGWcxGQMmuw2yQ/EKNJo+sd0txMXLn3hG5Rpzfk2HKTwq0yoeX8ubtUNBMZr?=
 =?us-ascii?Q?oN78NU9Hs9w5XmeBK6RSbomXf11CAmOiKjx0ngQbfhM/nYH2p0QbuWGMqdaE?=
 =?us-ascii?Q?ys2AGEJxIAdHtUL7FtE5W2tffeCYbpPjGQaszX9xuZOs8FsY2uo5DXhpaK2G?=
 =?us-ascii?Q?Lf+kaYCmHHFtzW+B1rRsn33gk5uSR4bTdyNUCeKFMrnQ3slHPRC3Q5q1R+Qd?=
 =?us-ascii?Q?F+gbMNseqOy90367SWp1IMAnHHvWAnpuAyw8HCFJsqr+yEAzdDjeig9Oykk/?=
 =?us-ascii?Q?fHKkAQoqBYJnWDtXOBisUyG3mCkayX4qn5dg3Cn+MM46F2LnSvZW9VEy7WmQ?=
 =?us-ascii?Q?xn1tpOrk1KPo28ErX/zS0vdtTmDaE8c6liddI2/GbGJksrZQFTstqRU8OaD3?=
 =?us-ascii?Q?A+avsE2kmbwVY+cqT+7IbeJSUlPYKd8ttwZdr1bFyTxYuzKUBi80njCqRN9m?=
 =?us-ascii?Q?x3YNH6PGBzrWbt6EWxYHrwS4D3b0q05PRUo/n6XoEn4KadC2tWB0hNYerK14?=
 =?us-ascii?Q?iqNHnwp6Mwi81zE6ER+4ifoEwo2FOfWYQpMhfWEnvckly2OXei03fBvsNZsg?=
 =?us-ascii?Q?K8Ml2tJzW2Eg+kg7QRhPBt3xJgt6x7mV6B7anJIJWCiHKRN5hfHyx8Ye8lTU?=
 =?us-ascii?Q?FeaG0JIzL+S6CU0vM8SN/fYgMUrxSMmlO2W3IICHhQP2p29C+aR4smqAjfbC?=
 =?us-ascii?Q?u2MRPg1EFumTeugEtGUCg9CG4ASKTIfOByGtbx5yipULn1nzH/AYmRHwNuJd?=
 =?us-ascii?Q?gErZmBLWDnMd1cZMjPKqGb7GxbluGMgESeKA0+bsOH5Uy+kfxu3GKE+cDh9/?=
 =?us-ascii?Q?B/91i4qClNc6gebKOIMYxd00/SU+NEJ+XyhMqnPiL0AJCa/NBemWj1ygmg3r?=
 =?us-ascii?Q?pmSuvQ64lwY6NMR/BP2AI7u19c6a4MbF8cV3VWCiH9blib2dXQBmqIFpLRCm?=
 =?us-ascii?Q?G3cXip6hJ0mutiuZpTlzvYGDY6SI5gr/qZPFdqH3mwqUmiNd9chHoN18j3J6?=
 =?us-ascii?Q?p9qhXXWl98b8VtfpuGXEzRnvt9PHYCIWhvPhw0725DDq5jRL14nte8Pq/UO4?=
 =?us-ascii?Q?5G74jeD3UgNSYJ+X+C8F5l6J/NxMUfSCnEHThUG04XCR98A1IFoDINiQvDEL?=
 =?us-ascii?Q?nInaOguoPB0+pqsMtd07pvu1Ussl4Hfo4GR0+XUZh+Bymn8ta3R8WHwxceBu?=
 =?us-ascii?Q?i8YGciQ+yoMqGFfcSFZikcQ=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c76c9d-269d-4260-b4d4-08d9fa6894c3
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 03:15:33.0751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ebvw/IHgDEDhJSn2CdSUw+eXRTwe1B5Pc0y8bHTdOVS5hAnLieuUpF3Phl/CmFJ3fX7JeawQhWckHXEsG68fUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR06MB2191
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

Use the helper function time_is_{before,after}_jiffies() to improve
code readability.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 fs/ext4/resize.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index ee8f02f..4a80d9b
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -14,6 +14,7 @@
 
 #include <linux/errno.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 
 #include "ext4_jbd2.h"
 
@@ -2100,7 +2101,7 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count)
 	 */
 	while (ext4_setup_next_flex_gd(sb, flex_gd, n_blocks_count,
 					      flexbg_size)) {
-		if (jiffies - last_update_time > HZ * 10) {
+		if (time_is_before_jiffies(last_update_time + HZ * 10)) {
 			if (last_update_time)
 				ext4_msg(sb, KERN_INFO,
 					 "resized to %llu blocks",
-- 
2.7.4

