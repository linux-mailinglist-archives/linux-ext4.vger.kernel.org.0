Return-Path: <linux-ext4+bounces-9326-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2F9B208DA
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Aug 2025 14:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9237018A2D71
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Aug 2025 12:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A2F2D323D;
	Mon, 11 Aug 2025 12:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="dEA7177S"
X-Original-To: linux-ext4@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013012.outbound.protection.outlook.com [52.101.127.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75113C38;
	Mon, 11 Aug 2025 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754915756; cv=fail; b=ViI1QLUS3TGL2KwGADY8Aqa++sGlaqgJUQKiwXTfx6lLGNkvIQQsiwX1TH8h8OiYt4T1ZcIO965dt+q74EsLOSrL8zDmqXRaQEN//wTub7U8W9zppYYnPLxhmlK1OHgHkyR0riFOWhiEntclvGbOc5HQ7ULCyUsCEmbuY89pHOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754915756; c=relaxed/simple;
	bh=ZkWH6XYSXBOwqxEdj8Hx/xr2v4u3rN1GcSpdhkijLL8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lAFhiMMDKqm77LIegA/T3Sxsz8PJFwG6rYMeJKFW4+xVjktjucTWXIQUpGOGPWyysU0A3RTbV7vP6l39QqxxPdJnbURzInkSa8pbdAY+mNu2J4l46fu1LttScq+U4dON9x6p0LVdL4l9DrdlaNZWIy/icpcaMEOetKKNs5zGRbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=dEA7177S; arc=fail smtp.client-ip=52.101.127.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2Y+jmorqYGNpLW6OnguVroOAq6xWEg97O6oYulSKqx2qUT1hK6UYg7tSB3Z0ZysOREpDt99d61eWY917K8MCHCzQz3CvexEZaPRBZajUxWK6ZtbRVoq8qG+oOUXJ1qAGexWikh1zgdwt66woZnlKPnvt76kQi4NVck4Lhkvgen0ScQmI0TMgnMhX9wCWqA9ODtHjWIt/MWfC0heVsYqqQYI7DGQ4ZPouhQX9LbJl5H7x8zM+kouxCNDczy+0wc8vQynAsorOCgKFLFp5GaZw9+7hWAwOxOQJbM0JIErjEFO0xBjj9KcmSWxkn9+ILb5W+iGvNbDFRckudKF7EMbMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBFoCIIP4DX9fBjVhGUweq7jlgA8xSic95A3htm0+0k=;
 b=dwhIzGYCVRTKkaiX8fTlPLOcNFDfglft9M47wflZ7MzHFgji/REMScsm76zmEhjqMoxxchOyoFb7BRq+W5jwTj3uvJFPzoi27ppqMVR5QFGjzAYG06bTpPdYLW624SzfG+DD8I0y5VtTitIK75WACS5GpyiZ1ZuPOP2a9AsnAXszPpL1J9mhOiiaOtmNsrIxy8FJynw9Pf9ocLQZvEukYIt0iQF5bcVJXjoPG0iQev3I2GlqOKSZhE6vIJdYWInqEfRnbxRrmXPcu/MzRQEe4cvrJqKfH4u/R0yt1qrQHjgTrEdVkf0hYXEHZ9HKIJVs/f667DAXrV6lVU0iKbkAGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBFoCIIP4DX9fBjVhGUweq7jlgA8xSic95A3htm0+0k=;
 b=dEA7177S2h2PvDby1etIa9QJrN4Vk6zv1EK8+Hs02bA+1YSqrHLkClNVl98Obn56HfrmO+gsnElNohWKk1oM9WIiqgfNRP5Q0RGtqwlzHpDp/MbY7892V3Y+gJ0xZXKOHvwchPbmwoCoIsvBcyp850oJB/z9wqFthVUCvWlD8PsuUrt9l8J+7G6aP68pJoVQWOGFC+uhl+uX7bUwgVoiK0JECA4AUZX/qf9BWbyiRRu5sbkZtwobuBQkdNnAKHi8dpTgdZVii8TLVMums3E4gzfx/vtdjqRdWDWg2zOdn08O2GpwqaNVdM1WOCdTfDd1bxGHldYtAuDsYUlC6ELkcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by SE2PPF4A956A907.apcprd06.prod.outlook.com (2603:1096:108:1::7d0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Mon, 11 Aug
 2025 12:35:51 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 12:35:51 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org (open list:EXT4 FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] ext4: Using vmalloc_array() for array space allocation
Date: Mon, 11 Aug 2025 20:35:34 +0800
Message-Id: <20250811123534.550200-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|SE2PPF4A956A907:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d925c6-5b3c-4b76-e346-08ddd8d39b88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HLAGd0n4jqvhtaO2s3pmUZNLBT87Twx3P93wI07A7qA5YrSIQOEiAXBjs08w?=
 =?us-ascii?Q?85qRVk2R5vR1UKV/oB08uktrBgTpn0XZR5gp9GMAG0GZzzrU0qD4XHhkWiqH?=
 =?us-ascii?Q?AK/n48WxWPAxSq3tUVs6V4JxGWaxE278GPwLZVOHvJeiwY7tZAxvkjcI8JD3?=
 =?us-ascii?Q?lUonkCVHLGmCHmUUdpYBAlQizYhzfiqB+jZNtZJjwOrZS7EStKzGj40b8xrx?=
 =?us-ascii?Q?S/MuublmHZajHERGSuQaUu3tAIg4DfYNGzRJUkChMxUg1tWBMdL3VIi4eJrz?=
 =?us-ascii?Q?1yTIByvP+87Jh0wYtJYeIBk2nt49gZDeN4Ju/InTSosU4I4HLtUHcz/qYwJW?=
 =?us-ascii?Q?pNyoN4cs3qN9gQpvBC+ZFP6zaRLHD5r87Vk3JzCWaK5IF6stFwlUyES5IWjz?=
 =?us-ascii?Q?3H4Y6CrdsohAEh4elhKRuS/ld/LOecTw+j8xc5tslxRejZbR1J3X87SQuGyw?=
 =?us-ascii?Q?j8pjbw6nX10el8o40efqGDEwxXErG2QsdozyRtfEdM/+yNhvLjqC0x1bUvkH?=
 =?us-ascii?Q?O7cmwjqkhqxIC77b/Hsc5kQEhgLWYVzvCJJHBqUlSL1Vwdvj5PZvCziU7V0Z?=
 =?us-ascii?Q?Q5B8qNl/v1KWLija/I5Fz1U3gl7d2SfqrZgmcIttYa7P7uX4hxJw0CZm7wRW?=
 =?us-ascii?Q?Aw3rjoBXPe5wV9rixRbJG0ZZ6hvm6SlxzXeFi/czt0BMixtWccIi1gaCr1Sj?=
 =?us-ascii?Q?jftHnO04xNGu8flK5m7fggNpN5ezPvbS937dZfXrRBpKDYIdqfs4zzzr1/DU?=
 =?us-ascii?Q?md8wcwmQa5uKYdBfdpwCPDHVfJn/bYo4PT5C0QZ9+J6hFDYnoCGBdfRRB6cT?=
 =?us-ascii?Q?JcGJv54wDtbU0YM67wypGUt9rvBAa0BiMYJqlIjnO/SSVwbEIkzpwxCS4fQV?=
 =?us-ascii?Q?3v9edD9mJnhoZM6Pht/B3VD7z5ogshej8B9NRrPYsvunXWSJeEaaeSiHSG/l?=
 =?us-ascii?Q?MCcjRLG27K2RlErXXW3wCCO7ZiM4V1Ro9uRFxILbN7Px9h380DpAqLz8IMGX?=
 =?us-ascii?Q?nsGWDfhS7T2C/ROeLvqG53l+df3U86bdh0EOUj17Ve26SWeIy4noWXn6bjJI?=
 =?us-ascii?Q?Hiq1xvcvLfjn788+Ca/yUSJeneAoXWs19xuRcrCsWj+KmTj7sQiULxcic8n+?=
 =?us-ascii?Q?9HRhuei26yHlXm65NVuD/XtmQ2w9zFqDvxNs0QC03JvG7vKYF7UMYHZsq8JU?=
 =?us-ascii?Q?oQv4ObCTfjxRk4DlNnke6HgVzwBk3nqc9z60n4/ZGSsRiBPqflRKbig5f08U?=
 =?us-ascii?Q?DVucnCj7lNoWtkqox2wn3F3kIrwwPei01HcWSkAaT9TtFuVsSjDDPOKaw7xU?=
 =?us-ascii?Q?ggGfERKtelkIa/lfzYuFaHZgtBwwwiuYSZgwd/CjS/zHQkXlw+4b0+tnqNms?=
 =?us-ascii?Q?LyTkAbtzBWDSZTyF3JdlhaPkYCrIq/9P/1Cqa7WxLpu3QFOwg97oBNozFA3Q?=
 =?us-ascii?Q?x+sgxNT60bKMTQoGm3QRk/UmLPWGtCMsK66PY+QLPxsR2aCRihTf6w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Wd3IKJbyBTMRDLRrThpSqHr5cXan5sbzxjnBDDnpxVETluQ+mqmJZSDwNWV?=
 =?us-ascii?Q?OgWTxYXoMu4a5DR21fzq3ctML8Ya4hXBIxIca/pTaKa7cphfSEcxcmf7pt/3?=
 =?us-ascii?Q?+P+erR+BEHAiYDVA5NrRfHZA/q9B48CIZ+XbDBCA201GjqNvarhHCoQhxQ3D?=
 =?us-ascii?Q?TxynzK1rjiGNK0Vm/5GoiywSB+6qqPzQ0WbYFf4eSXSBUFMBg9VgLMIJklGX?=
 =?us-ascii?Q?n71kTjkFvDbDKGhrJopQI/Y7TeyuJ9z4z+wHzCaMKSoHj+2315cAqAx5GVR6?=
 =?us-ascii?Q?b6SfHfl8A9FNe/p3cBsbEF4JcQ7N6zMBlveek9lA/w5pK3/L9VV9Wo2clYGF?=
 =?us-ascii?Q?SG6eY/6MO9XLXPHYFBYWXxuG00XTIORJy+lnKEJLws9PxsFicFJ/nND3TtX5?=
 =?us-ascii?Q?W4MnDGTGbVtyAZGTmJqLT/bvl3LKL+912Ue2DPpfONMIo4RvyoeitJgAVAqV?=
 =?us-ascii?Q?wXek+l6yx5jU7iyVy2t06jaQQZ6MTd2ZKzcmSxOTLEtVUPNqcGVMuuaMy1O+?=
 =?us-ascii?Q?CWndnaW+gdQlVfP+VJv24EbhZ5syGx+vyUhYu44fTrFknayNVQQtMzvt0pMY?=
 =?us-ascii?Q?/UEVELcSaT22kgzybQieV/LtKCEWz4nVNEN7Jt+Q9gU9wn3hXwWpRcWGClVz?=
 =?us-ascii?Q?uy7YeP1OgYu+vNxzKw52LdBlMb6Ln5Q/OaueLaEoWFiRlGuJZhWtN6Jqw/8T?=
 =?us-ascii?Q?OlQBkjgMa58x6yg7bUHgWkthjT606/MZ6n7JMSz3zNBHgN4562sd9E50Zi2j?=
 =?us-ascii?Q?stSvD65JIVZLzP0scndDOS+xgevcQEfiWEreJb7FDq16DFeGcbaHrC0Tqh8g?=
 =?us-ascii?Q?kAhXOfon0XShFNFxrzyfZuSP+Hpy+AQR4zeG293VxIWjMkUV/4Jd9BK+rmrd?=
 =?us-ascii?Q?HDybtJkecvw975HT8FT83FpcbiF/pLpFdKDeuXyf3oPG0U/liHrkXKecdabP?=
 =?us-ascii?Q?2FRTFhIJLyfYX5x5OLoaUt8KazWEmaVj7C2Mlh8mlb73qv//ywJwVI4kdJrR?=
 =?us-ascii?Q?0saaH+I9cDnjNQC0NEOni1phXORT7icUNo8/JsIPTixNsnzinpl/L54lxzwg?=
 =?us-ascii?Q?nGn1Pf17ev4AyvSMg1bylhJQ6vhHGveLFZQa11CO6o99vZdOYailo4HAqXmh?=
 =?us-ascii?Q?v6T9snS5hXgWSfCngnP5is+q7iqoImOAupkS0iW14TCHeSnxMFXZ8SHFrUUh?=
 =?us-ascii?Q?mAop0sSTTb6c0VddXScB+MvxHXXq6V3pcNOirUx6OMgoQHOj9iimZkGdng6Y?=
 =?us-ascii?Q?5j/isw9I/DjE7d2O413UOdaoPJ1KDcfBbtGptsTUh1Y75I/rj7ZEiKpKWm6e?=
 =?us-ascii?Q?gKZy+/MO2f7tsLgjlRpntt4eHh8okCyXW3a9uVxLPeuAShsDosDKhjerb6CS?=
 =?us-ascii?Q?kFu4pxps40gsIQlbg4mR052IbBTVKpiH57KoxCXUaZ0uJG9BKFdSt0SXbu1B?=
 =?us-ascii?Q?AfqCCwKpzS37+tRzBojHGfl7RZqmzVwa490E7uAz/XESKQlEHWMEE2C0MdHd?=
 =?us-ascii?Q?Z1oxQZNnlGBYuzsu85Q1xizmyBkP7FYqR/GSHgU8oLLPX4YJ0pZEm00OB3ji?=
 =?us-ascii?Q?JjFV8I1KA6zC7+Ojr8zeWfVoiu5pvRbCC1E0gcBD?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d925c6-5b3c-4b76-e346-08ddd8d39b88
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 12:35:51.8012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fr03Rrbc5GaxTCEXI55W7so7AdiJF/si9d1G4d1w8gjaRVLLBWEBvWYI9Hf94KJ93i3dH9vam8BaBWYdBGBaZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF4A956A907

Replace kmalloc(size * sizeof) with kmalloc_array() for safer memory
allocation and overflow prevention.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 fs/ext4/orphan.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
index 7c7f792ad6ab..72fdd7e97b4c 100644
--- a/fs/ext4/orphan.c
+++ b/fs/ext4/orphan.c
@@ -589,8 +589,9 @@ int ext4_init_orphan_info(struct super_block *sb)
 	}
 	oi->of_blocks = inode->i_size >> sb->s_blocksize_bits;
 	oi->of_csum_seed = EXT4_I(inode)->i_csum_seed;
-	oi->of_binfo = kmalloc(oi->of_blocks*sizeof(struct ext4_orphan_block),
-			       GFP_KERNEL);
+	oi->of_binfo = kmalloc_array(oi->of_blocks,
+				     sizeof(struct ext4_orphan_block),
+				     GFP_KERNEL);
 	if (!oi->of_binfo) {
 		ret = -ENOMEM;
 		goto out_put;
-- 
2.34.1


