Return-Path: <linux-ext4+bounces-9258-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 328B0B1936D
	for <lists+linux-ext4@lfdr.de>; Sun,  3 Aug 2025 12:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC46C3B90D2
	for <lists+linux-ext4@lfdr.de>; Sun,  3 Aug 2025 10:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1043B288C08;
	Sun,  3 Aug 2025 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="jJ3WqFHL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012038.outbound.protection.outlook.com [52.101.126.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273E128851C;
	Sun,  3 Aug 2025 10:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754216589; cv=fail; b=rnM3iOvmC6lawWaH8EfQ6/dFYpp0JxP1JeTJkjtNkXW7u6HOd0ASLze2YV5CscFfLdvsMyqwQEWLUXzBkUAcbKafWZ9NK5qWD7UYSSTaWYwI3JUo67Oe/jZ9GJWTs8dQTQ0Q2uoKfPymRx7c8SP10iktaxJj+PsdN0OedwE0gW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754216589; c=relaxed/simple;
	bh=FVbjgZkz2JWwOcplYQB63EyhpDLLtgfqIfruJRvPc+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FAVwdyW4N2K7OQk8vE1mu0NoN2uoxHONB3w9gmgNmmCkD8hDFV3H9bR/Aw9OR87SgJ8eMSmBFlmROp3vRqIpmFL36WODxOEkmWXNuyOp6FWDIWfSnI5J3lRJOKeQGEOgO01AgV/D17H403ZPB7oUHQ5Tfieicd4vasa5FleHXq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=jJ3WqFHL; arc=fail smtp.client-ip=52.101.126.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2ZZpdYtjiUX1cThZ1bzAHWR/YEMVuMXUpiADoZFlnASDEioLjaOAXLphiyFUdSrSm1ZjsFRKODRpPImXhDkeQwxZRuTSAApaEBeRyBl4uIhnvjVzuT/yFohvxqCyyQRFMa0q5xyR+ktPsQ6CespwbFdoba0rg1gKWFjELfLgs1p74Q8rVjqdj8SumHyRmPzqkomX3CzsQbHLj+OKIoPZHZNCSMSAU/ewUQIjaARNmj8byPLfFfvt9PWwJLUNjOa0MKQc5U7zWwnbmx5PsdmkH8LsXYnFxgYmPKGFu+gmkrfg3XRUiI67DqJi+GDH64gggb7CoU/dHavD2S+NZulYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIsaLjj0SpeG+7+nMBb4VzPWZYKyF3LgsbDgnDFfwsE=;
 b=RlKB7XsXqjTWUACiFAhjxGCAwrSB/08yYFT8lEfGYL6PMsSBRxtpaCYgJr6I6PkVpaB1j3GgAhsR3aZsWXT2psRFQCmHYKtdcf6XPO4tv0lDjfu2OaCaAZlPNWg+C8CRhDynFd9nYxW+NjFmFyaAI7ErlKmJEKW9wivXeC+MbmgyTnX6TJBI407w8v6eW2pQML/EyC6WTDxRwUHQ6RnQTmPxBZkvDKYpEoC7MKgKjqOQ2Aq7PRZ06AC+G/9yOYiD/sfxDxBXKyaOe4bx0gp3Ybiow8taSC9julrNpPfW9g6y2uyatGwIzauGL1gDNHkPtd9joaPlgePSLL9hMvXnYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIsaLjj0SpeG+7+nMBb4VzPWZYKyF3LgsbDgnDFfwsE=;
 b=jJ3WqFHL6QLqfPgiTsZy5nEjpRYvK25T6Foh9ortRtd5XJ/e7Be1CCGG22H4OTvIuk0Xbxn0xMOjJimoFBIJ5rtZYZxF+7NDod6d2FBatpgqW0ZN/X99PnyB6VssiRzV9VTYfQyg04YXhlgMIyg86j8ad8ZHI7fvJjxzGHWUtvYEWhKPkbfEAbMvV1EWs3/5f3RGuOMqOnx4fSK7HPiiCVdclRUEu9rBGsj8wkwHkfYEl3kMQnGYNqIhEq6tia3hBWtD4zVskXjvq/jZ6Iu3pXlICvPgMqJru2EqW2R/Q3qVbdB08bPeyK7YatV14LGe5XmauElkPdrM0YfDrEhcaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TY0PR06MB5128.apcprd06.prod.outlook.com (2603:1096:400:1b3::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.18; Sun, 3 Aug 2025 10:23:06 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8989.017; Sun, 3 Aug 2025
 10:23:06 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org (open list:EXT4 FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: willy@infradead.org,
	Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH 3/4] ext4: Remove redundant __GFP_NOWARN
Date: Sun,  3 Aug 2025 18:22:41 +0800
Message-Id: <20250803102243.623705-4-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250803102243.623705-1-rongqianfeng@vivo.com>
References: <20250803102243.623705-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::14) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TY0PR06MB5128:EE_
X-MS-Office365-Filtering-Correlation-Id: b680ab5c-2832-45eb-7266-08ddd277bc71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Px5HAnGuIropZ2e/Tw6eMlw4raJFFWiGlef6d5iSviRX3PzcmZ7oiBvEVD1+?=
 =?us-ascii?Q?kETRBpia2QcnLX3FqRv5rC2IL4bY3EG5tYhqAEvRGtweXb0QW1KiLJTUfKiB?=
 =?us-ascii?Q?wKr+1/eLnCKKB+I71eMu6zhf4C6gVPXevsSTF1SxQCDilH9ulEoyAyHmWDi+?=
 =?us-ascii?Q?DM9y2VD+dRH/UGAjGv+Szvq3ObEDZoBFp88EesFuVHq5tQsHqahBWAvzqF3v?=
 =?us-ascii?Q?JLxknyeG5VtoM4COuqT1dnRcRv/7s50fR4eRc0EcIDGQHqdMzFMutEs6kBnR?=
 =?us-ascii?Q?4F/nXbUPopywiOIq629gYznPrrJvTCGUQOfCiIPwkOsuWhyDE6gr6VpRHviW?=
 =?us-ascii?Q?Adb0LidLaargcZ3z0AXJqoppUAWyP5XGDXtIfnY8cO0q0hctaCR8tPpXUxxX?=
 =?us-ascii?Q?V0rr5/zAlUjBhWmvNFZXwEW2mDwi+L2B//98DZLa+ChNleAAXq/EWWsWK5HU?=
 =?us-ascii?Q?XWB6zcWiVZeUKUnz9r2HpxXo/cmwY8wuLNgV8/G7hLMAZUDFp7GZ2TXvK8K0?=
 =?us-ascii?Q?AypV+JJNelsm9EP2ZFlGweQFDgJGSsBlTzZ/pPKLc144lsl56IaUcY5ArQVr?=
 =?us-ascii?Q?Z8t4Kui4Bcd9WJNWV4F2kfoBaMKSvz5y45scKvFy9eNIcDRnSBnLyZUeejd3?=
 =?us-ascii?Q?SfGqt4NFGdrSBe0tz+eHArS+dLZfwGu5C06KabqKxR27CaJOUUkzVGKGuUmh?=
 =?us-ascii?Q?2DAP+Izd09hS0YSWYxNx9rUqDR1CkSspHyLZWO6uKNIfxswK/HQ3dRwBe6aq?=
 =?us-ascii?Q?BB8uI8NSFeqKT2v+OMQR9IHS3KdYktf13g0oj53i2Nm3ht/5Kil2fMrM9waW?=
 =?us-ascii?Q?7qzBrK4pBvprjin+buo/zZzcp0uTAhjsi/YvqSsLoK2Wr4rXLYAfx2FPYYO2?=
 =?us-ascii?Q?CNr8+inzPDjO6hyugvQO2xu9Yiw+aiYNiislJ21sfcgoEnTMkT+GqfBcfBMW?=
 =?us-ascii?Q?BSGNu1A/qxwRFZ//0Z47199nIqPh7ebAwU6PatWPWMRV7IVMcWEYxDRxuN6D?=
 =?us-ascii?Q?vZZEsrxyKFMgWvoknExxoRt+o8AvAaNrcG//2+Wv5dV0qG4ECZC4Yq1r2zKZ?=
 =?us-ascii?Q?62yHe+i47oroYqkQGrO7CaSjHAqqdSlzI4Zvx0ijzdEF9rBx4/y2sW9/VasY?=
 =?us-ascii?Q?dfrmngqCdYWtopRHEQCdVGSzPyuQxqwcBGV9FW8msxVRAfz/rMh57y/Ll55y?=
 =?us-ascii?Q?Al+IO9Hn6oGfbiUEPtEIAi4ebpCS5h2s0ADyKZvrq8EyBe0fBXI/BV8o2cdI?=
 =?us-ascii?Q?FAqINdDG9zWaoqHazvANbpsbMuO3bEr8LSHzxApSW/V7JOHvrqZ112izdtoy?=
 =?us-ascii?Q?Ez4S4nSViPjFf969Z/N6/u2srJye5Jg4boBMCRPKq/cs12VvAZHbKHr8WIEO?=
 =?us-ascii?Q?YRIdE2cW/zK4Yo9RIooUSlXlr/DAEo9eKDEilXqAvsGsMfCiccCMDzfILfWi?=
 =?us-ascii?Q?tJPOijxyIHO1/UVGwbGmgOMkVq77H1HOeXJBTBoNRCy41VsuANFAHg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o41a8e4jigIoet4wjZ/PsGiUvjYRvVVImF7HZSzjAIhiIOCiZd4tVH2PZhEp?=
 =?us-ascii?Q?Gr/pWenroPnzwjuCgknYbxhKLP+8w9HkDTEbsBGBQ4BnsFDL1pziDtmqv8N0?=
 =?us-ascii?Q?glDLltqeAFq5ZqYfq8qutRjqU28RDpW5xQ/Hrswp9M20dLfuFHFiD5DRoHah?=
 =?us-ascii?Q?wEqB8qRm71IyMwBiOuUyTn3reIZG9r8E6ai+5rSZWdbuhd4MqzCWH0ggF/FA?=
 =?us-ascii?Q?UdSPgM8hH2Khn5anpmEwdXc9HvGXH6gGbM1NhOkZEZYeVDTyAUnI2ntcOddf?=
 =?us-ascii?Q?AE96H8LchzaGb1vYldlITmSjFMV0cvVNcFpR/0073dkInwxQEg2SWFwLpsg9?=
 =?us-ascii?Q?dhzrPwXqvryVHXMqbnnF5bxP4YdS4keakx20C7mgxyzGvmfO21DtzPrkGDyd?=
 =?us-ascii?Q?IMe+F6zajGQdluYeYRVQ6XHs3oyXxU3EyHa9yNqG1UFIOdONBX0G3xXLhw0U?=
 =?us-ascii?Q?Z1anLFgj85tXLr9ss4ukcKNvPtuTY9JJA/qj4qHiwY3G+W1CscPCmFRZZOR0?=
 =?us-ascii?Q?ZoW6aWBou022AARz6a/cOYo1GEirg1YWydo2qQSN2xJ8e04U8vbBKlshSCye?=
 =?us-ascii?Q?gjzE6QOlvberE+rTjYV3vdpHIg8ykXascegG79IecwQxrx2QmUf0+cZLqv1l?=
 =?us-ascii?Q?7peCGSdMawi/7Z5RCPgH7QG/H6GLYsXqK9b+Hlb1ps0DIgOeOPiZTyB0xVFh?=
 =?us-ascii?Q?GwDKlyyq98GJIphvuiy6HSUIeyL9LMQfM6ZbXhD0Xbg1FIbBhF1DU7/6Ihye?=
 =?us-ascii?Q?WFsf47mvaz42C6DfeHAdImg8eHE7iNBXTMRfooa3XjWWGyCsGfJ1Zuqet5o1?=
 =?us-ascii?Q?+BJwMwLeYut5+w7GpNxgwBqrRNze1OM8sXol7MRnfRBG5xKwIxKh2XjiXsPg?=
 =?us-ascii?Q?nK9MKnanzQcB10X+038Gz8mV4Yt7FJY8oVK26QiB/vKj4HB5CLt/YBNiGdut?=
 =?us-ascii?Q?q8s1GtcnsECEqK5fZzseB0wr6u9AhDeG+O9AdakZ1J0i44WaVpb5TR2d9pa6?=
 =?us-ascii?Q?RpupJejIA0OcJUcszdeh/ZD0NtVooZ6NzHE/Ji5Ee3m90qxEpxGBje6iWLzo?=
 =?us-ascii?Q?fmhF/INwNca2nblSNyFZpuUU56mx/zB+QFVTUxF1qKXxuxqT+P8y6qdu2w87?=
 =?us-ascii?Q?VQ+oYIqGOOZe26GIPxMs6ndBNJ9qPYHAK0rNEF/47/jcm0qfl2uL91bKjCtR?=
 =?us-ascii?Q?rdHNgDtdmzG+JopPlEKs0kVy5ADeCJOz80cBLvU1S9tU0Sn3FxhG40XxdcSB?=
 =?us-ascii?Q?fGzw228F6OnGhwdXcw837riEAhESh/+KiHKL53zDSN4Vg8i+/mDdKLbSW9ql?=
 =?us-ascii?Q?4lVv3m2hUTQ9p++bSNCR4ukyspl0ra2K1LGv18FJyqs/XWzqpBhcWgh0idWW?=
 =?us-ascii?Q?9inXe8JQMc6T6Xcc0ADEIpTQdAoWs1PNOZjtnkEq9KneCZVqnnDfB19Jia1P?=
 =?us-ascii?Q?64EwONFcc1KzavzSNrFDS39rpRVzwxjk/taKOmCP9HNn2Oxspxi67wqBXk5z?=
 =?us-ascii?Q?C2j5JQrVzbNZACaPw7xqvC2VCRJB/575jbdbL/hWoVJcyr0jM6iBuV8zZV9y?=
 =?us-ascii?Q?R6c/Eo57yK+ZWBVRnTlSGM/GoihrKs/+co4Rk1jk?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b680ab5c-2832-45eb-7266-08ddd277bc71
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2025 10:23:06.3173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WiyvxS4MmI80MTwin5uZD9laV/JZI/CMeq6zymmLBBBmg168xiyopcmKzC2Sk15xC38eWfJh+gtTFYQc3giq1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5128

GFP_NOWAIT already includes __GFP_NOWARN, so let's remove
the redundant __GFP_NOWARN.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 fs/ext4/page-io.c | 2 +-
 fs/ext4/super.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 3d8b0f6d2dea..39abfeec5f36 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -547,7 +547,7 @@ int ext4_bio_write_folio(struct ext4_io_submit *io, struct folio *folio,
 		 * first page of the bio.  Otherwise it can deadlock.
 		 */
 		if (io->io_bio)
-			gfp_flags = GFP_NOWAIT | __GFP_NOWARN;
+			gfp_flags = GFP_NOWAIT;
 	retry_encrypt:
 		bounce_page = fscrypt_encrypt_pagecache_blocks(folio,
 					enc_bytes, 0, gfp_flags);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c7d39da7e733..5f5680336ae6 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -268,7 +268,7 @@ struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
 void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block)
 {
 	struct buffer_head *bh = bdev_getblk(sb->s_bdev, block,
-			sb->s_blocksize, GFP_NOWAIT | __GFP_NOWARN);
+			sb->s_blocksize, GFP_NOWAIT);
 
 	if (likely(bh)) {
 		if (trylock_buffer(bh))
-- 
2.34.1


