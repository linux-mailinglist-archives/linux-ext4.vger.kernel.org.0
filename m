Return-Path: <linux-ext4+bounces-9327-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9345DB20978
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Aug 2025 14:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9505018A5339
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Aug 2025 12:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB602D3A83;
	Mon, 11 Aug 2025 12:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="hdfTGm0Y"
X-Original-To: linux-ext4@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013046.outbound.protection.outlook.com [40.107.44.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38632D663F;
	Mon, 11 Aug 2025 12:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754917117; cv=fail; b=ScJ+Oq1U5dJYzN9T5p/vqbn5XfG0kHPh+DThYooNfVrBX23/FrsPh4K6ciBxrrJyznuAw0FrAUat7ApYrDr1H6a/09bU5OFr0E2MODYvF8CzKxoL45JIkkDucaRcnqE6K/L69oGHDay5b0PaT6u3+n2MiiT3RCml5GOTIpcb/PA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754917117; c=relaxed/simple;
	bh=njkvPX4MkUB/5A0JzE0RwUWXur1rr6Q7B49zzjdh0Xk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rC/BczOzqXZbe5g0jvmxZYBgVd7HdPmH9lyjt5qUkltSPyD6aWz01n5nN5CLyeaRIJuLo6hhUD60pMS3GwPU75qEFdjPlCqLcuxcDBwt5yEVU57fQEWHbCvOeCEr1DtBpWxkxZG/1rQMg7GiCk6RoOcYR0lUxHMfmWM6Ps0YDhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=hdfTGm0Y; arc=fail smtp.client-ip=40.107.44.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTB0xaz7JXTApxl8D71hKplbkRTP7akrF70ldqZ1y4TRavckNLT9laL060oDDTA03eceXqycfzYOkWV69KbfO4E26NB6uLaVd1tJhJT0EjRTh80X9OaePyR9Uj+e5mMGdAFOCAmhrF0JjIpQ1PA3dEpXChCsRUor43ww5BgD0WiLstOSLQLF13ditpp1rb3n+ilVFz8fgQJ0ZFl99kJV4t9yMm5LH2TBmeUvSQQ2yqCRvBn4rgnu5OUqiA0+Pi3jT5IhEP7/QzpkXSWC6nJ8FOu9PrtBR6qmHCdvGKP7Auax+2+Jl8o+hhzS/dwuXpZLEM6FD8UqUS6BMbj8TZ7nQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyIf+ntLCZnn3mNx+/h+ePy27d61nmVEzXTK+NLYw5k=;
 b=sIj16e5+a4JFIpPlGKV2J1qYZEu21Jb+qFXunBlviftsr1/wnbLS5yt4l+y5RtOBMu6DeZNBqqYah+++qqPJjzIrhAN+ZIHQyXw7z+kmWjQNpg1qe6UN0pg1WsvEADOsHNqQG4wYJbDd91MNFzAi+KmhP7pFejFNiGB190WU5zP7uwLbqD+hXEwymNQWPyNZMpk8iTa4YoOERB/Mq2rPOBvk628FQmvT25HDyRhJPKrhTfYB//ggwUje/ZeULPRidrwW/OCe6sCtJ/56SQz3wgV1uj6vdookChasyatupf45aSn0yyM9TXKRLrijnqP2rVTUZvy4clvEdZzgXOyl7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyIf+ntLCZnn3mNx+/h+ePy27d61nmVEzXTK+NLYw5k=;
 b=hdfTGm0YBB0O4GMrOhmbdym8m3GZx9LXVJKgjvptrwwRbVxwU/DAq8vv+GKfO+eeKZyybjyln4prpXyElGMjl5XayCQKpMKH7UcAgrYwk7snwWIEnxmt1h/Hk0W/FqQwUluMu+rg1FC2E2svmbFpasQcCEr9m2ueT4RqnWX4a7C6bx9rGqGqHpvNAtFuJPL2k3RN+gmAMJeXMpfsyZq7qKVuEJhoEXYhvO4ZqJViUdxCGSWhlQbXXQ3UwBLxcy1uAlRQu1HsRWbN4PVlwEvtH8NV5Nrm2P2TJlU9WHRxfnLTCkP6ieu5I4uwr6fRpKPcidcaadmUzh/AqialSe3DTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by SEZPR06MB5591.apcprd06.prod.outlook.com (2603:1096:101:c9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 12:58:28 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 12:58:28 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org (open list:EXT4 FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH v2] ext4: Using kmalloc_array() for array space allocation
Date: Mon, 11 Aug 2025 20:58:16 +0800
Message-Id: <20250811125816.570142-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0292.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::17) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|SEZPR06MB5591:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f5dc9e-5ac2-48c5-4a22-08ddd8d6c3e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ju1RJLlLLq9O6uyIm+BrWNHAOz9ifcJuOVhlDMA13kmciJl3CUt2wDg22hPv?=
 =?us-ascii?Q?bKy0pySP8Xauw+WIEL+ewO1yoYvWEWZ5utAM1pr41m+ZTUV8F8wHceTPf/Ez?=
 =?us-ascii?Q?siohR23QPE52sZJg+RmlACCBTJaW4gbOXF0otihw1fbMbu9+XG36u4/zsf0N?=
 =?us-ascii?Q?XFJCuvcu6YLrVxlm+Y28ul+HTk8hp9fTAQ7XtnLhunqGYGH+/pQrTB6OYREN?=
 =?us-ascii?Q?QKiIU/J7qB6j6OFz3IL82eBaoqb+iKF8sbfiU9agWdBuOPSdaKzTY3jYnRBN?=
 =?us-ascii?Q?Me02LVtdmH1BXtXzOtlViT/whg69yFO4VhRJ3dQ34LDhn0ebWIOKBO02Ix5/?=
 =?us-ascii?Q?eA0rpVh9U+0DLV0p8TKj6cn4ZEM7fLOTXjBsmiqbMj5cvGoLXOzRTmAyLLeh?=
 =?us-ascii?Q?JRc6b2JdY7c27nN0ZbQZvclPs4Aug0SqmNEG+9Buv9k8t8SgkE95a/sZRv3e?=
 =?us-ascii?Q?HZ9onPe/fXC5Y58wueNNpph4jXvNXtJbV5EkfXsmH6eTMaeKZgxgpDnQUIF/?=
 =?us-ascii?Q?bYyaj0ngf1Aix7CnJfGCaimc2m8v48P4jDd5iSF5FjYEHYwiVgI4wW/VrHIq?=
 =?us-ascii?Q?7QAeDln0P/q9MZMa61j6GHO9RN3RS4ByV8EDtBmtFDPJAQQXsPpgzRjQT9zq?=
 =?us-ascii?Q?AHZ0Z41hyDUTxkSNYxOg7JTRN04kNUjVQLlXwYH+pv1ao0utJ1u+DqFZ3F5z?=
 =?us-ascii?Q?sfRX9C6UzrSHFDvzzTqfANsDnsbUQY1BuIU5gD78ysJ1cbzi25moxEZmwxQi?=
 =?us-ascii?Q?PTYq4xILcvpvlfskKvIEB2LqQw12h2jELNhpL145vXHrFh9rjpr/7JVLD2XT?=
 =?us-ascii?Q?zDrdA5bNR4y43ZXFHUVc9v4fEKncXGY3uHZEqUSrstNKOBmHVOruwT2a4gsK?=
 =?us-ascii?Q?nKDJ45wOZXNQn18M3j858p6fOU6g93/xCfjV/Q77JfLuBbuO/sLORSKwwfs3?=
 =?us-ascii?Q?VMiYCd9c3E0/Zxun/EGHR0/zrds+STMTwAy6GGKTSD/QXS2uUM6JRXQQlmlz?=
 =?us-ascii?Q?wvVzMgcVw1B9+dooyr3O8Naq88Uj1IF9n6x5arhmVW/uHK2CprXT+lSqRttC?=
 =?us-ascii?Q?wAkXPE5Hjde/2W/LWAVRkS0TNSDrMpjbt4j5W5BBlP0m1pflxb5MDdlPj/KD?=
 =?us-ascii?Q?Req55KKoJ77gbqDmFBqBC7i45CzV5gMK8KgFwgR/7Qosh9Wr861e0xfWZJPK?=
 =?us-ascii?Q?UBXgi6Zk/WWnpw7mF28Vs144teu2iQjltWmS9FyMxMc4bYZU36JYt3v8miye?=
 =?us-ascii?Q?XFJ082fok16qnUxw3nAYVat1suNjZ1+T2qArCEdaoqpHBXh/LL25KbTO4n86?=
 =?us-ascii?Q?hG7/iKoAQnEPKYSf0QULNZJilKZWywOWw3cD0LL2AYsUb3pcoSHFgndgOqlP?=
 =?us-ascii?Q?6X6Y1Tm/SBz5dr3I0UmvctQ05nC8VE4AcF3g5gr2XxBOO95t96i2EAJq7ML4?=
 =?us-ascii?Q?LoB3y2KI07YJDEZIy3L/JfAF6gTCdMJ7z1KubkZ8DkkGIGzCQ5D04Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5xh8WVm82Z7BnkDxrwj81GuPPiAsdNZbgVT98CpDAAVh6PJIVK4hvdSJntXt?=
 =?us-ascii?Q?MeTveVO4VuNwj7SYOCuqTwITcbAC6DSe4cvWzplfRj4oqHvFew4uTv6m2AeZ?=
 =?us-ascii?Q?Kiv3uUMhC1btKNJAew++zLFBHm9cOAfJ7ldWlH4DXyvaHWSLq849ZkC2/l2l?=
 =?us-ascii?Q?NsB92qXZU5YBKA7r5w/5AlQqCjXMprDMB0LdrLqFLkC3n0DoBx3nkerOqPzF?=
 =?us-ascii?Q?q50Oh4S6uf21jkif5nSNyf2mS5GmE/n25nYk8Q3lfXEzZvuzmTEtLbjaxWM8?=
 =?us-ascii?Q?iLQKI7+bzPF0XecYX4EtAVOxVz54L8ZABi4y6dmV4xYJpJ+tERFDK3x0zLsG?=
 =?us-ascii?Q?8Ju0bJ9I8GXaj/3xvidZm+xN7HV5O/v25JRzf9kDkzfQW14QloUNL/056Q9H?=
 =?us-ascii?Q?lLsMt01kceI0Nok25Raz59Upd1KT+WDWgIafFsO7S4h2GAw/WOgJ9PFuEaVY?=
 =?us-ascii?Q?urLP3OMihPro9JrLe1tP4L0LkRdHxoT4cU5BbGvUg+aQFDnjYXSsNPkxfXIU?=
 =?us-ascii?Q?HzpQWJ0PG4kjwQ20OVCQMqp17XSfIp8Ke+geT9zoEufp3Dqyu1sruW7Xv+qb?=
 =?us-ascii?Q?PZ5r6D6sBJ6jVKNAa5PbQwXmxIGmtE+g6iUIexbp8W1DxM2XFSDSTloZp3Po?=
 =?us-ascii?Q?Ni6DHMjVuVj1zYPzolpInRMvjJtJT6U1VPYtPr94OJGPznRDgtzsnxm6hD+m?=
 =?us-ascii?Q?cVkyhYKCAZeudDBRrjpFjO9d8eLyMvbovb0Lx75/R3OXXM1qGmowsHQlA/XQ?=
 =?us-ascii?Q?wtrPCLb1wxUF9mR1fTKbFd7cXh56GrmS3HMWzI9QUENfRkYzkWDEg4zttmI8?=
 =?us-ascii?Q?py9q8UC6zx6+JPUeLYVqpBvps0Xj6QyWaU7VlWpDUYBOySjgAEbTgyotVLYS?=
 =?us-ascii?Q?eFqmoRQrTD6g313npeAYsqmPvLEfQI5mSiHgRxwQVCGqysCIrFbm/tlFIYbZ?=
 =?us-ascii?Q?zBX0lI3gmpdwhgR4BRZzQw6nOj1xO9vNlA4AXR/KbNeT1fGybHRHMMSWd5Cs?=
 =?us-ascii?Q?3WkLCra90EIhpsflH6xoV7hnv2k4yP6xOjKDzY0bSyvb9L44YMArEcO4a5go?=
 =?us-ascii?Q?hLJvql+uJOqEatGyZNZVDQdzZCoaUtBpHwDWMw3K53E/9OnhGSQZmris+224?=
 =?us-ascii?Q?pzxqMH5JjIQdKkR33hejm/8zuVFk78VHZYRsYasN6S6NXqSimZXdrl0bZnYy?=
 =?us-ascii?Q?MOpOwrjGZ2VaR9OStKoB68hb5bFoR9lU9CtOJFjfltgKIYeel9exPm/91X0U?=
 =?us-ascii?Q?YYjqjxjiP5XT+miDJRNRaawgWhAm1R3Z7W/BRoTuYxzvN/+UOyw806pBygf0?=
 =?us-ascii?Q?gvoREcqNLFpj6HKnf/nD4A7VwcdmAHWckopv+kCOL5yZxh0BVXX2KDReInHK?=
 =?us-ascii?Q?o3I13Vid2dpvYgVzSOwonks6kfP+gw+YkguegSZeoeOdhY15c/nnjR5WzNHx?=
 =?us-ascii?Q?q3gO42CtnPDe4m8MVH6/2c9t5g2mpfRpZbr6F2P/xjuJvH1JigMHHcOzAz/O?=
 =?us-ascii?Q?QEbShsXYiTECfBlDroWiRUoYKTycihAdqvaz/dPo/wJWtf2UIJFzJq5B4PFw?=
 =?us-ascii?Q?UDDXXMkoNqzTNMIpLoNuzvEIuKncn/xkURpRyzS6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f5dc9e-5ac2-48c5-4a22-08ddd8d6c3e2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 12:58:27.9970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +iVM5ayuELUhxyb0zwl0wcwL4uYwE8L7YWHuvzHL0opNrcRwJS6H1PiZZo6kyQVStNJlJP5fIF7HMwQIQFUB8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5591

Replace kmalloc(size * sizeof) with kmalloc_array() for safer memory
allocation and overflow prevention.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
Changes in v2:
	Corrected the wrong subject.
---
 fs/ext4/orphan.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
index 7c7f792ad6ab..524d4658fa40 100644
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


