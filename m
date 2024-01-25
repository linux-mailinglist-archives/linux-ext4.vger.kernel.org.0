Return-Path: <linux-ext4+bounces-918-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E39483CB2F
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jan 2024 19:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E4931C25E88
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jan 2024 18:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08E21339A9;
	Thu, 25 Jan 2024 18:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=whamcloud.com header.i=@whamcloud.com header.b="WM2lcECC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9FE13B78E
	for <linux-ext4@vger.kernel.org>; Thu, 25 Jan 2024 18:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706207491; cv=fail; b=g1YCzYC14GoCLrLP2AfProyG/qk6JqjX8+I/RYVfqN9P1zxPGBrjlBm9+V4C8VzT5hwjq2Cljky16AWr/4d6P5AInNNORXLyNXErmVgwgvDl+ooWTyQUvXSQcuIQUwyfHdFzDQgl1zKcbCuIVQE9VvVQq9440XwDbk5+eTTh3tM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706207491; c=relaxed/simple;
	bh=ARdAd8Z1VPx9rTJl3mF2EwoLui3cT3biBQPk3XXM7ss=;
	h=Date:From:To:Subject:Message-ID:Content-Type:MIME-Version; b=MM9lUP9QkEgxN18sR2RVXrODTuCMC2kmHo3akAv192ESKZDpBLe0pLiU/f5tCob2jn1UcPNLPrXoVDZJo9rEJb9BHrlLTApd0kmnluf+43TwFda1c2SoKeKEgq++7tPU/hQDS+SN+ya1ymrULsXmHGnCUjQGosrN9Y7EjfQM0Xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=whamcloud.com; spf=pass smtp.mailfrom=whamcloud.com; dkim=pass (1024-bit key) header.d=whamcloud.com header.i=@whamcloud.com header.b=WM2lcECC; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=whamcloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=whamcloud.com
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100]) by mx-outbound45-39.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 25 Jan 2024 18:31:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vylbo22FdSYpGNAaixBnZew2B0QmJJAZn1LR7K+tcX1rHNVO2+GIitZkVRPz1LdKOEkXJVQG08QKgeAWUayug5O+H32TFoxJklWIgV7esTkJyDH/DhPhb7MbFe8vKt/OsONRrZhnAcVtbdio+yQBvkn3qhz2bEJW89ncFQI1IvKMaUhatoxYVtcgcox/NIX6+em5/5bmDZUzU0IFY4/GNyq90hzgd7oyC34W7sW9foFqLkzPJYrQtuq0Wy8AOs2EKS0/u9SIxx+HZ/0S94KHOVyYOkwTRPjaGSTrsnX/3gqH8/Wffe04IA+GN8uPdGS6mk3LkAkU7SqpCES2Y5SwHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlgUuxYoo4WgvBFnLkfH/Wcl2v3R/YQm1Vpp/odDd2U=;
 b=eQYdR0EkHiCERIhAlg0S/svUbQmoPhayzNJUExxkAOVjngY9+v9jTaBZanv3hsqz6XIFbm/7/0gpWmwAV3nEGLHNOjFEmguBzsuCAVRYbw+JmYFnfu7wMyWk/GybW9xhgUJ4Ps4G7C0su/ke82gRHa/0DiDkfYu+UcAHqygH+z4MR57XnnDT/IyAGDZ9vh8WBQurEBZcSHUjDAHPNlOcVCcmy+lHiYLD4GvDYRilDnS4LbPK2JdMe/SsfXJQ6uBGYHfuqV+CbnkIdpVWNkMsAzWsXCPMN9Re0C7cc8bwvucLThHm1/T0dk+VuN7PZT1dG9IWooQMtYFu7yWn61SUQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=whamcloud.com; dmarc=pass action=none
 header.from=whamcloud.com; dkim=pass header.d=whamcloud.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whamcloud.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlgUuxYoo4WgvBFnLkfH/Wcl2v3R/YQm1Vpp/odDd2U=;
 b=WM2lcECC6+2a4yL7DH1jOXbFg4I2oNZyBLOtMWtzN0EqLcw71DxiyYZBdElcQojHGOWeUMs/J59wziVXH6OnHTqokrgjhP7KUu2auvaFNTACspBth7yhGGpkufm+zhUGlCm9yODadKni4RlOHEKrbLw8lFyUzvHpp/mCD3E8k3o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=whamcloud.com;
Received: from DM4PR19MB5835.namprd19.prod.outlook.com (2603:10b6:8:66::17) by
 PH0PR19MB4774.namprd19.prod.outlook.com (2603:10b6:510:25::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.24; Thu, 25 Jan 2024 18:31:24 +0000
Received: from DM4PR19MB5835.namprd19.prod.outlook.com
 ([fe80::64b:cc6a:d4ce:cf0b]) by DM4PR19MB5835.namprd19.prod.outlook.com
 ([fe80::64b:cc6a:d4ce:cf0b%4]) with mapi id 15.20.7228.023; Thu, 25 Jan 2024
 18:31:24 +0000
Date: Thu, 25 Jan 2024 21:31:17 +0300
From: Alexey Zhuravlev <bzzz@whamcloud.com>
To: linux-ext4@vger.kernel.org
Subject: [PATCH] shrink extent tree
Message-ID: <20240125213117.60359293@x390.bzzz77.ru>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVX0EPF0000ED8B.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:3:0:17) To DM4PR19MB5835.namprd19.prod.outlook.com
 (2603:10b6:8:66::17)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR19MB5835:EE_|PH0PR19MB4774:EE_
X-MS-Office365-Filtering-Correlation-Id: b797c1eb-fe09-4633-9b04-08dc1dd3d585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fFs9XLTUhlL1LPek0A8B9wTTdOI0LeOzIEmQYwPWb14ew1BAEH3baWNJV0oyfufCRT3zcwSdIZcXSPUGiubtSsHd/Q9kIp0NF4lLvIsVfOVW5pAKKCBA+NeQIsSL+bfuqlqdVZLy06LkpbkybUsAKC4s8GTus87dbufFJH0FlYe4L+5C2Fway0ZVTqJroFPUJ1uIatdzzajAnabST069O205Pq/Q9kmFGhRng7gLb9DCXJ27gf6yh+GutcO/BinY2tHIXFiy2HQ8iGAtnBhdr4w6LLgZXjC3Q+24RnCugGSB098lwWoEDoGRPhAA+hxZ3bm0CU1WJpiueKon+/4Exn9mq9Rvbf2FLmV6ZMd1IDXsLeIs3Tq62w/yqPb7lZfQMx26fKzmbKnYKknekWAmHeDxhEm1hv/Kl8TJStz4NzJqMMQOwt396DVOD1GHnzQGDpUTGbW1PtifW9R4rVcVIScEVRxeJCdITuTSPfZRNKKbxV8uk251r6o8qKEfnF37wRaVXTOwMyFeqFTmTEHHUadqB6edrjLlmrlTOyNh27TMbds6Be3wPKhwnt0f7j0f
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR19MB5835.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39850400004)(366004)(376002)(346002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(26005)(1076003)(9686003)(6512007)(83380400001)(478600001)(6506007)(6666004)(38100700002)(66476007)(5660300002)(66946007)(6486002)(66556008)(6916009)(316002)(8676002)(2906002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?re9XS+lr9U3ZS4o1b83vUf42dvie2vBXoJXig22yc/Q1SY44H3z4Z6DqiM1u?=
 =?us-ascii?Q?BSKqpv3/5j/qFMbXD8wSZfKcMQYdXk+QOSebMvivFOmHiqeG3jUI38n5DUAm?=
 =?us-ascii?Q?BZfyibShRN1UytI6eUqjfWw52uF/wN8CEarMZpS2DEziFJmRRb/PTDD5+Mdg?=
 =?us-ascii?Q?gagyM43OfKIsVaZgSWVOC/fuLPJi8PvqMjB6bhCfZamATDoob5f3A/w8DksJ?=
 =?us-ascii?Q?9JbY3g5ZJtGO8mZDRteaPm5l1udubrRIgi+XcNadb+3C1Amjx0gZVwLqjw+x?=
 =?us-ascii?Q?YoUN+LKe5hec70LguSmt+314GlrNQcbk0X/hfMJKrJY1GMGJWfkmC1tJq740?=
 =?us-ascii?Q?6s2Ro0lTqkLstKVm5Avq3p16r0ba+soKGK5k0gk6q6yRJxgt8JBahJVSJcaG?=
 =?us-ascii?Q?uCUehF13cS5Mq9+fOOGJ0X6C0akM8SkMIEBdMndIsjtmlWf5NBt5es5W24iz?=
 =?us-ascii?Q?bDX86R9IfJF0WA+pkxkxfxevyZVJp43Ez3dmYY547thn8ikKO+dCL2GvIXx1?=
 =?us-ascii?Q?aateyjHgNyi0CTbFdop4k9FQnh+IFIsO2sE3jAJ9WHwJfFSA1Vn1RusWIxWU?=
 =?us-ascii?Q?E1G83M7bp+1KoGbzqXKfMsksp11Ui1S/ByzlP5zBD7pV4d3atSLUK4qHZp61?=
 =?us-ascii?Q?Kjycx7z9CpG7DJWOdzjToVNnHsm3A24hOhifFSYxzlfBlDns9uVaBxFvg8TS?=
 =?us-ascii?Q?TZ+TU3engfNKLrp7fky9nTWc6hoVMFF4KWUy92Q0ztXbN6tbPG2JyhJdBWaJ?=
 =?us-ascii?Q?WAF9zM4VgMWSGltN8dRWHvKgPouRTfDLb5lkGOWBBDwHq4ihh1c0xkI1Jaul?=
 =?us-ascii?Q?d/mSyypuU2qklRea59CkM0qX2oOXLhdPu9Jz9u2y9s2cpiaH8p1mXwbzNage?=
 =?us-ascii?Q?GiGIsgn4/f/IIr5iUzWnmafQXyUCE2YaQi6ZTHTxkqhU8hbogBczI5QEdXE5?=
 =?us-ascii?Q?lEtxymvGiwfmwCkWixvwbi77kkG3NOwK/tGfqAbllaH280SakhmV1OYJRl24?=
 =?us-ascii?Q?jjLjMEuuEdj97neA4bzQAMe1bHmmwn9jpxfeSZcTfXT3mKevBQ8TDmvkS+Uh?=
 =?us-ascii?Q?pjKO+q0MutFOcJI0QqPKY5rCrv91zlYFSsT7diQ/cq1h9NZo8TZNjks9TJpM?=
 =?us-ascii?Q?C8ncfo4NyTbUTDekENNUAqdMSNOGkqN1TuvirvGlPEKFb4f3DrdcOaA0aH41?=
 =?us-ascii?Q?r2kLIA7FgsyH7p4GtgC8FEBRzkXcBbc5By7zi5R0zehV1HSN4sbvMGoCr9FR?=
 =?us-ascii?Q?JWlCA3yXiC1ANh9DkcbxGe/vbfMjnfW8vANIUOnjqPQuD2SAeGfUZeHjFYNg?=
 =?us-ascii?Q?hCw/eYb/GwoEO321IfVMS4eSC4f2kC/UvLkY1Yc4jH/jHPINycA/iOgl4Oct?=
 =?us-ascii?Q?Hp8L3fDhJWREqIom1cAA/UPWWFXt9vBwTigRklOY3ijabN9HY0LvOcdJU3vK?=
 =?us-ascii?Q?eZgUUjtwA8N9eUAyoe85KCzRf9gTCX9cgsexOJGtXZ5UUl7fVGySOxg43YhO?=
 =?us-ascii?Q?BHdbxygzpFi9k2wH8WeGX6T054nOwlpOzaUJk+fyZ6rJ4OywXotOvPDpFvqE?=
 =?us-ascii?Q?CC80wvff2V2B0aSnPpqBsi+GG1Kh1IkhJ36+oNiZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E0Y8ZQCFhBIGYyhXGglM9dY4Fuob4BgqTqXo/+8DAo3pOeGlPU3knZF3BMFoz+qkBGSmVDhvgbG8eOV+fVnp1cw3t+Hr8djkD7nk16MV9+zPFnc34EYkFagyaRIWy8u5/SxSvzju8nC6I93wZeDFe1toTauyMWC+3aH9MoQvRR14YZIC2q80S3h+n7ga7LUj1Kkw6xuyoEAPHcgrqO8Fe7OdWcYEDS7LThabc7VZJi1YWbXQ2kxy10uBy0QC1hhyWHM+NUKXJCn1GHVUKu+XTy0qkoyuIDZnDCwoIAHljL3OxjHqFxhYQNe5lKj3wE3dW/ej+qHxKT6lDw4z2OHwY/EA3LeZo4U+MooeRqZaN0MamYX4aHVlb1YBofLRk0t9j5G+HMKG09R/YpVNLxWUl5dfnDuS6joLGyDFKxtwdCOrQuwXD00ckKAxfZsCAhnFX4hvu7YmHgbtWQto5fuL1t5n7ktq2dROEPiCMyG0DyTWeUAbwKqHP4xRdRQvkUayhQeBUkMq20h/ywr0dCRAR8ishBasCCXrtKLVynjAyCtIzuKrgHCZrqKlWYz3Xf80s4PJTTUq4daPUZWhnI+dmOvzosSM7iIuuQwAHXIczW2UueBsIryYamqUJt24CnXPXERwn5J6Q147m/4squDdjeCRF8XPINTH5myRR2mNDAs=
X-OriginatorOrg: whamcloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b797c1eb-fe09-4633-9b04-08dc1dd3d585
X-MS-Exchange-CrossTenant-AuthSource: DM4PR19MB5835.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 18:31:24.0129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wknlAluIJxS7VP9juiBMzF5vL1OhWYCgIXEkgElMRoxGJQR4WvmI1LhyuyyodENpR7EEI0G2bBRUANaIiIDaFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB4774
X-BESS-ID: 1706207487-111559-12609-1305-1
X-BESS-VER: 2019.1_20240125.1647
X-BESS-Apparent-Source-IP: 104.47.58.100
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobG5uZAVgZQ0MDc0tzMMhEEko
	wMU4wNEo1SLdMMTJIsTJINUwzSlGpjAUWuNdtBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253751 [from 
	cloudscan18-231.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Hi,

Please have a look at the patch attempting to shrink extents tree.

Thanks, Alex
---
 fs/ext5/extents.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 0fd9fbd65711..4cd2f0d57917 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2025,10 +2025,31 @@ static int ext4_ext_merge_blocks(handle_t *handle,
 		}
 	}
 
-	/*
-	 * TODO: given we've got two paths, it should be possible to
-	 * collapse those two blocks into the root one in some cases
-	 */
+	/* move the next level into the root if possible */
+	k = le16_to_cpu(path[1].p_hdr->eh_entries);
+	if (depth > 2 && le16_to_cpu(path[0].p_hdr->eh_entries == 1) &&
+		path[1].p_hdr == npath[1].p_hdr &&
+		k <= le16_to_cpu(path[0].p_hdr->eh_max)) {
+
+		next = ext4_idx_pblock(path[0].p_idx);
+
+		err = ext4_ext_get_access(handle, inode, path + 0);
+		if (err)
+			return err;
+		memcpy(EXT_FIRST_INDEX(path[0].p_hdr),
+			EXT_FIRST_INDEX(path[1].p_hdr),
+			k * sizeof(struct ext4_extent_idx));
+		path[0].p_hdr->eh_entries = cpu_to_le16(k);
+		le16_add_cpu(&path[0].p_hdr->eh_depth, -1);
+		err = ext4_ext_dirty(handle, inode, path + 0);
+		if (err)
+			return err;
+
+		ext4_free_blocks(handle, inode, NULL, next, 1,
+				EXT4_FREE_BLOCKS_METADATA |
+				EXT4_FREE_BLOCKS_FORGET);
+	}
+
 	return 1;
 }
 
-- 
2.43.0

