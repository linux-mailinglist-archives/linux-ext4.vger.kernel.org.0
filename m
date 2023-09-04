Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B887910A9
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Sep 2023 06:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244604AbjIDE6W (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Sep 2023 00:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242273AbjIDE6V (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Sep 2023 00:58:21 -0400
Received: from outbound-ip7a.ess.barracuda.com (outbound-ip7a.ess.barracuda.com [209.222.82.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EADAD9
        for <linux-ext4@vger.kernel.org>; Sun,  3 Sep 2023 21:58:17 -0700 (PDT)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43]) by mx-outbound9-53.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 04 Sep 2023 04:58:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKwqaQyznfOx1LZNH/kFtQDkG/Avux6wo4I2dPSUEY+DeSvb4lKD1O3pwP4IHHbcuJCmbO2b9Ja3FOR9NN3SLgL/fR1o/WEMtMag7Xcc88KHSw35Hcui6yLJ/GDESMRGy9M04q/rA5aXId/QcdPhSwAA4RtIpq5Z16RAr6Nm5QhOLW7IHqwVe/cJRv54JmS6nczj04/JhkX9FNGcPmBm81ZT3mZu/wzHNsuliDnYdpWknaoiX+LgglecGahpNeulYdFO6AI0v8tXv3kkvE2eWkSGaNaAK1VEodMkiA8gqEBCwphwTb8OjFKKxChu9aMejbQkmDNmz3MJJ03QsEpwog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRbraqzaPPEBMBJNxPeAs1LuaaIlHwvheB99jK3cvuQ=;
 b=Vxbm7IjhXRxAPhvWIx9UowsH91YK6SzRA+o9VBPqroGCXKo4QrGiBzioyXb9oWOXlWtaWdigQb+EI3zHl7fC0Ma3Jb68q8f4zJ+5du4gSu6EtfikTlR7Sjssu0lKaZCEdyuc5XLABg3migkjU752PXlWg9j1D6xDvD8YUd6TF/Ch8VMvpTUXjGndHfxMzPPp/ICVmksHwHIVKQFsNwAgl93HRJaVOy6KfFGbxUIVZ8fsj0VpJBW4XaxasCTk68Rg08HKtOUMtACSNZtnGzvjdUGL2aKA3stBAZFPKbESx+yUliDLS7TIS1fT+GYRyqhQ99mzXNnsQLOOd4VHVqAUlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRbraqzaPPEBMBJNxPeAs1LuaaIlHwvheB99jK3cvuQ=;
 b=nWRsOzOEVnUNImKnNBj7/1ETTn1w6rq4zGSKV3//ddQJXKisKNK3kipvJGjWpp3o0IMp8KJSWuIYJO49funHBghGiXt/P1B8J+TE0/AGsvGqPfEbmhLDCestVsLEh3RZeD/WsPf6JRzF8ap//YA0w1q2ttOwYBNbeXk+phvqyvc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DS7PR19MB5711.namprd19.prod.outlook.com (2603:10b6:8:72::19) by
 PH7PR19MB6635.namprd19.prod.outlook.com (2603:10b6:510:1aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.28; Mon, 4 Sep
 2023 04:58:14 +0000
Received: from DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::3110:9950:e5d9:af44]) by DS7PR19MB5711.namprd19.prod.outlook.com
 ([fe80::3110:9950:e5d9:af44%7]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 04:58:14 +0000
From:   Li Dongyang <dongyangli@ddn.com>
To:     linux-ext4@vger.kernel.org
Cc:     adilger@dilger.ca
Subject: [PATCH] mke2fs: batch zeroing inode table
Date:   Mon,  4 Sep 2023 14:58:06 +1000
Message-ID: <20230904045806.827621-1-dongyangli@ddn.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0011.ausprd01.prod.outlook.com (2603:10c6:10::23)
 To DS7PR19MB5711.namprd19.prod.outlook.com (2603:10b6:8:72::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB5711:EE_|PH7PR19MB6635:EE_
X-MS-Office365-Filtering-Correlation-Id: d61e1a94-ded8-4c4b-77b9-08dbad038bb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xcujNv6bKfJDk6xJMZNxhVYbvOHsHaRmTw8gRtN75IBsuiS7JeiSrPhzrVQwbJgz/MmuOqtIPNTNpaGWw9giBqlDhduMxQ+01bQ28lUbuo9BXZesOXngjJvhNonylw3o0l9hLhF2wJDfuX2co/gQwUd9ZxzjlzMtHznEpkI7crHpny61jO7H+9QdiHyT37ym8ervIUG/hxCzYvqoS0ISyIPJs9G31ospMA+tWvP8N/61Bzwv4r5+x3tE3w5Cu8EbKgq+2T9+sYKU2EKnZHmfd8JV+9xxcQipfyP/wBjb7QymEVFKOTOu7Rik9lzUyflFRTCew+j8RTDtpwrV05h4JVRJI3CfkQSQ9/TAgWEsu1wj/Bnn+Z79TLAIkqVHIxKYAE1YWNk0RqUEcBp88UTTW5nhdXstfL6Yc7UDmAaxD//azZ8HFpMkokFsgfdgPH8So/nOOBDVt2iyyIft/Wmrj/aD08GZlMbKNjhT95qJg8GTPPdgBCp8hP6BQQWV6rMJK5lMYAON3mBuX3M0O0Ga+LVvDLBbVsu+4HQsZkbHkLDJc/+B4FuadVfK0pGOE+FM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR19MB5711.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(396003)(136003)(376002)(346002)(366004)(186009)(1800799009)(451199024)(2616005)(478600001)(6666004)(66946007)(66556008)(66476007)(26005)(1076003)(55236004)(6486002)(6512007)(6506007)(2906002)(4326008)(8676002)(8936002)(316002)(6916009)(41300700001)(5660300002)(36756003)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zFOy/ojNPgxwaPwneOGhurnfCz0AXNvr3uB3pmNaboZpFogMRxoGsjm89/2Q?=
 =?us-ascii?Q?aQrengtazya70XM619NpJ/4IeRrue2aK+OpHXIahbgNpGJbRQoBnC2WTqOKw?=
 =?us-ascii?Q?QImrgH0+U7OUBgrwPSBeexW2WsOYV/nLJGigfSb1lTWBIn04xX9JgxmvWRJp?=
 =?us-ascii?Q?4xXMj2e9hpdskrvrGaT3rpXk+vQGTA0DXMuf2ZM+aXBmlw3em+af/TG7crN4?=
 =?us-ascii?Q?i3PQGyYCiuyn6BS7Cpywm30yT2gofCOn7QB99FF65/j5pjxZTAK+Sbe7z2I6?=
 =?us-ascii?Q?GfpiJqlQDtGyCxAMPiE9ilSq226CzBTwUayp3ua9fjQtQia3KmRkvFHLt4TJ?=
 =?us-ascii?Q?y0BZpxAcHiz4giODUjJzMbyoBi8I1hzSOOoxkH/EJWIHtn6uckhwdrVw2eXu?=
 =?us-ascii?Q?l5bjY4TvUq7XEZserv6qSfS+iLOiO8oxigIhYvIOs6EtJz1wHaCbnvVqmBXV?=
 =?us-ascii?Q?JlvN02BXUlUp4s5O+qHNp3jmsmxK/z/mU2fNH9Y1em9i3e+XCul2BRt00sS7?=
 =?us-ascii?Q?4y8OTgiA3YWpYKvyJft9+bpU8FDbkeRO5wvu1M2D7YZ1DhAxoH1xVr5DWeVC?=
 =?us-ascii?Q?AHvxmUBNpAOqxiy6+RnsRNp5AqKUKpiqsMcZdoScNtZGZ+lcnwxMD3c6W+TK?=
 =?us-ascii?Q?wxjlfUos8MlqIfewDwJHPcYro0CnKnNgCLUfhy4HXwWhuFDlS1zyMnSiWiLa?=
 =?us-ascii?Q?xqBSxfot2dMOdqnJRXIg0XTOfvyJL56V9Is1FbevkZ8exesCcCbDXiqLuIiL?=
 =?us-ascii?Q?IVu4TgIRTBWjOlHuHgGNfOVcGYYiJ+fB/ANGsWvWBk7RMbFP9jZfClyu6rZG?=
 =?us-ascii?Q?TawPjiG9PKYsiu5ox/xct6NDe1KDtpJUcjMTsXfjR6G8WGhldmQW7MC/Fj+f?=
 =?us-ascii?Q?SiPWtF+gdhhWcHzR/QEdxMtd2oH9miKQsNpAIUd8cl9nLp5Cnw6WJ1D7UmGK?=
 =?us-ascii?Q?FKlQOIwTRBVKFtBM54j/y2pa0U8u8LFbcZxl5EnR2kciG/WmebHqD0/7aLxP?=
 =?us-ascii?Q?NdCEPW0L4KCsgs/KCS7ny2E6NSzt79HHu1I9IzyW5skTv22NiNswJTSKcG/P?=
 =?us-ascii?Q?3kjItC73iebwFabSuc07VkPcCDxtvh8UZptL0lsYSF1ksjGXYBUcvP8J7YSN?=
 =?us-ascii?Q?AKFdL4UpQEKjNp/FjAVcHSEXtXDH98mJeCQhDeZ0wfcUCLlL+A9I++5ttZau?=
 =?us-ascii?Q?WouH/U92eZ9LhYM3cDcPn7twe5TrJI9mjXFnhaULgheJeBR2Gy4E6YdVQB2K?=
 =?us-ascii?Q?wFMbuLde9UK7C0vcTug0KwFuSFLX7hqstH9OQHWb29jMh388iGamEH1qwqY2?=
 =?us-ascii?Q?pmHXcWZFZhPeWm+o5z83ls98vISsjD3fOgpS+3upTQxkGxJRRL0CUjgqKdCD?=
 =?us-ascii?Q?SPxD9hrMAafCTz5mnopmil3ceoFaLINOqEgqXkhsN2LaQTxE6W/z9Ylb3LN6?=
 =?us-ascii?Q?kKLUd1qv/6mE4/yc8pjODKaMc+UKjFcP+plJeROafUCCMSbmUBzwOOVdJas0?=
 =?us-ascii?Q?tFFcAvizWXcpMloo7aCM2YcFvP9uxPtY+YhpSVPdRjBAPuiIeA8YTDf6igex?=
 =?us-ascii?Q?G0aC/4o3bd2JeZoc9xA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aPRLFgAa1/2+cJWbmVkP1IxMRZ/QrE7/wARFyxOD28xwVyIfEClrv6drlFEDgWVQzIdopJSuzPmH0LQz6SmYFTlNpn7QVUMHaGFGi7toL/TiOqW0xgr+rW0EmkQO9YV1LOsXUP5BccZ9rBSMOmWVwCbKwjoE29KEOipg850iqiVkcO36zPrFrPkNJiTPJ/UUCgyo7GsmEh7mEKsIKS1z5gMQ94gA180GCzyf/tDCauzwm8Rl0qQoPQX0i3bWK0rhGfIbxoXLEH16kpmydjd37qNmHj0greV0d9fhqDdfTryBddhK2qpaVkfkwXFVtUohmEVwlYSAcpQI6kQAYUuAZ3z7of+m+xmP3/bqraLoRZuu3amqtZlJ62T50LBHRxmPnuZZ3t1bk75B3fAUaOUIoP/e/fpSpHAVVn4UzhauBuH0Q9yvXGDY3IuYiQtvQd17EDA+0qZGxqcVDTmRsrWvKDEHiAA6Ybo3mR7zBveI3tV14O0tWvjTJHvaj25S/mdLWBR9Bqarc+E87fBYrVPIrp3boe9n69sVlF3CD4WIrCTwslXnBqeR1HMrh2RyR8DYwLt3/jV7B5PNFaVgQACbIUy93zOavRsRYyFzpMH6Ty6kb62/cHV5UQszdCSG719yzkiGGHpeSfhAP2RtrGsGm9jFI3/Mp+xoiMVwQ8lsZZWnQ4vk4apNiA94WNLtcvQ8yM3WUlmdL44BxSIX1dy/8batIEkvfgLV5KtQ2Go/7O4Kze/mskK0TQgx1iBMP+IamIZld0QFhn90KrPGZHOLUUJbBj9LLAkkXqRVKCRikqP0nac9Rbil7kA6ukm0bK1B
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d61e1a94-ded8-4c4b-77b9-08dbad038bb4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB5711.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 04:58:14.6264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68bsH6iZr4x7x1bbimggtFED6XyNPtd0uVmrQn+Aam6EZHhM65FWMH6hid+Qz2Kd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB6635
X-BESS-ID: 1693803495-102357-16517-15415-1
X-BESS-VER: 2019.1_20230901.1930
X-BESS-Apparent-Source-IP: 104.47.73.43
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsaGxhZAVgZQMCnVzNjAyNws0d
        Qg1dzQwjjJLDnJMtHCONXMxCAp0dJUqTYWAH+la/RBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.250593 [from 
        cloudscan15-229.us-east-2a.ess.aws.cudaops.com]
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

For flex_bg enabled fs, we could merge the
inode table blocks into a contiguous range,
this improves mke2fs time on large devices
when lazy_itable_init is disabled.

On a 977TB device, unpatched mke2fs was running
for 449m10s before getting terminated manually.
strace shows huge number of fallocate, given the
offset from fallocate it has done 41% of the inode
tables, the estimated time needed would be 1082m.

	unpatched 	patched
real	449m10.954s	4m20.531s
user	0m18.217s	0m16.147s
sys	0m20.311s	0m8.944s

Signed-off-by: Li Dongyang <dongyangli@ddn.com>
---
 misc/mke2fs.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/misc/mke2fs.c b/misc/mke2fs.c
index 4a9c1b092..aebf050f6 100644
--- a/misc/mke2fs.c
+++ b/misc/mke2fs.c
@@ -415,9 +415,9 @@ static errcode_t packed_allocate_tables(ext2_filsys fs)
 static void write_inode_tables(ext2_filsys fs, int lazy_flag, int itable_zeroed)
 {
 	errcode_t	retval;
-	blk64_t		blk;
+	blk64_t		start = 0;
 	dgrp_t		i;
-	int		num;
+	int		len = 0;
 	struct ext2fs_numeric_progress_struct progress;
 
 	ext2fs_numeric_progress_init(fs, &progress,
@@ -425,10 +425,10 @@ static void write_inode_tables(ext2_filsys fs, int lazy_flag, int itable_zeroed)
 				     fs->group_desc_count);
 
 	for (i = 0; i < fs->group_desc_count; i++) {
-		ext2fs_numeric_progress_update(fs, &progress, i);
+		blk64_t blk = ext2fs_inode_table_loc(fs, i);
+		int num = fs->inode_blocks_per_group;
 
-		blk = ext2fs_inode_table_loc(fs, i);
-		num = fs->inode_blocks_per_group;
+		ext2fs_numeric_progress_update(fs, &progress, i);
 
 		if (lazy_flag)
 			num = ext2fs_div_ceil((fs->super->s_inodes_per_group -
@@ -441,14 +441,26 @@ static void write_inode_tables(ext2_filsys fs, int lazy_flag, int itable_zeroed)
 			ext2fs_group_desc_csum_set(fs, i);
 		}
 		if (!itable_zeroed) {
-			retval = ext2fs_zero_blocks2(fs, blk, num, &blk, &num);
+			if (len == 0) {
+				start = blk;
+				len = num;
+				continue;
+			}
+			/* 'len' must not overflow 2^31 blocks for ext2fs_zero_blocks2() */
+			if (start + len == blk && len + num >= len) {
+				len += num;
+				continue;
+			}
+			retval = ext2fs_zero_blocks2(fs, start, len, &start, &len);
 			if (retval) {
 				fprintf(stderr, _("\nCould not write %d "
 					  "blocks in inode table starting at %llu: %s\n"),
-					num, (unsigned long long) blk,
+					len, (unsigned long long) start,
 					error_message(retval));
 				exit(1);
 			}
+			start = blk;
+			len = num;
 		}
 		if (sync_kludge) {
 			if (sync_kludge == 1)
@@ -457,6 +469,18 @@ static void write_inode_tables(ext2_filsys fs, int lazy_flag, int itable_zeroed)
 				io_channel_flush(fs->io);
 		}
 	}
+	if (len) {
+		retval = ext2fs_zero_blocks2(fs, start, len, &start, &len);
+		if (retval) {
+			fprintf(stderr, _("\nCould not write %d "
+				  "blocks in inode table starting at %llu: %s\n"),
+				len, (unsigned long long) start,
+				error_message(retval));
+			exit(1);
+		}
+		if (sync_kludge)
+			io_channel_flush(fs->io);
+	}
 	ext2fs_numeric_progress_close(fs, &progress,
 				      _("done                            \n"));
 
-- 
2.41.0

