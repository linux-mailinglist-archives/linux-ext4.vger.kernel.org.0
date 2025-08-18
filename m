Return-Path: <linux-ext4+bounces-9390-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D31A1B29ACE
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Aug 2025 09:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73FE63B2E17
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Aug 2025 07:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32F5279DC2;
	Mon, 18 Aug 2025 07:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="dEm/v8cw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012057.outbound.protection.outlook.com [40.107.75.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8015FDA7;
	Mon, 18 Aug 2025 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755502155; cv=fail; b=oMGh+x4AVwGBexZrU/Xahi93AaoRAd1TwE2bqHKqWBMhJZ8LZNjnU+kKZxGj8+yhixt8iLBpVMDu5qpyUIbej7nvQoT2q+FHk/joL7eM0yNn41t3nfaicvUqD0NZSArbv7QdrXizAeiqTohleEbL8RDJf3+V9vbmcvq0RJ0I3Vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755502155; c=relaxed/simple;
	bh=LRNjE2slT+hfP1bf8ulhOjbnUDVlKsufQk99PDbhBro=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PdVaymsiIoOdeDUIt4bBrWXTnkGxUQgBJVqMCOxbe+EUSPPDy7rOgcEGfUouuv37mw+uqK0rDgeDfT+qnMsMD/FLp7876dvKmB5ivC0K6WoFmOMPI1x4Bmbwr8IjvJHHO78kUORyvp2b3zDtCzh2b4K8W/sFL0xfXBiqYMeFRfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=dEm/v8cw; arc=fail smtp.client-ip=40.107.75.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yn6zTN4WgPkWLrdcM6v5SDWmv977/z64pgrjvWcGmyYmweu/vQqqdm7EaA9FgBPMQPKjN/qeTqVYXdkMup6rx4xD2xwQVHl6OPV92nX69SAFSNwzZB/yZJTHyLBPYT/Te9vsOj8yo+iBBf6M54bilt21Vm8fK2cJgy7XYB+5MbDDYrETblZreKdCdvaoPaC89mRCUiisdMo+IaWNLExkwqpEKst3KGG2bYyMu86RaVkYI/fu9z5e9vsvW1RwwIXe16AZ8e3rtNtRj4GbsWVbXJSVgamD0GLnHcyMmeLMHP4EoivZyrc368stEl6ZwhTwY8lJ/e2KemYmPn+zAgRW+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YawrVBbZPYRjRJxKTLYesyBqFkN8sqEPgG0WHQlViWM=;
 b=m5M6Y8zZtvIFoh5KVlitU55BadNCf0NpB53sRKHBU2Lf26Yr8ey8V6JdskNXbQ3kdc9/vhKfNObyDdJuhyLROqDq0ICOcAHOydJZRiBt7TgfcSPKgIWYYXtm2L++8k9fw+/mD4zzckIoJQLkmU95eBqbrYpbXHGZq5EHPdtQs4UcM4HuEfT7lfcaB1kqAPzcBdaj9Drqofm6mztQX2gNFPvBh9ZEAMivL3mpk5cpEJyRq96vcx3JwaGa5sNZ18L2WKJ9mm5/gvhUzWTvwMlCkEwlC9oexMpp5EO+HTts7dhsWfmtitd7cfg9AoEF76mnc9dYCZUGFnRYDqCFQaXMIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YawrVBbZPYRjRJxKTLYesyBqFkN8sqEPgG0WHQlViWM=;
 b=dEm/v8cwU5Cjd4lhFnnMR3+bv+3EQAG/XL1dOxMAMb+mc64d5i9+Jovsf8vtvQxxJYOpPY7TjkhmhTbzEVOsJ8qBXEUu0XnI6TQjr4e4uqyLKPQNLpedda6huA6pbIMvi6YGZtyX37HCA82Xjiia20W5DbtZfTZ81DUZLHW4dCJy/5d5BghkORNn9orE/qgFfe2q3X51ZL6FWG+Q3iiRbBzGp5yUOFw3dktgcuMi8CQXgg2l0G7U+qtXDbc+/wUUekSHXB0yNyLrmSp4b3Y2noCT1Tx3RqWh8ZjCTRPDNAnbcQosDhrHyhVB+qrJgAbMFtjpGh33w8yOVRFm3RoOHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TYZPR06MB6144.apcprd06.prod.outlook.com (2603:1096:400:341::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.21; Mon, 18 Aug
 2025 07:29:09 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 07:29:09 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] ext4: replace min/max nesting with clamp()
Date: Mon, 18 Aug 2025 15:28:59 +0800
Message-Id: <20250818072859.468081-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::26)
 To KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TYZPR06MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ae4effa-2ccd-4894-0e3f-08ddde28eba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TIEhRl3jzyQbjmFgL14WVUhe4ZJo6fracvvvGznWotuv6VFAxPfZ7tP+plJa?=
 =?us-ascii?Q?1+4zJQEP08mQrxhs1X70INSMbE1lgEf773yQQ9NgcK+fv7ldEtjekFeVznM3?=
 =?us-ascii?Q?Ko0PNOUt4OyxCp+M2csVZAE96diYU+RD7MMTY7Y/8DtiHZKcjnmg+xFZVTtx?=
 =?us-ascii?Q?UTJJtzweKI/0cpgMRjCr8ElACbz/iVpaeAi9nLFPdUfvbGJ/TZeOWXmkGNJt?=
 =?us-ascii?Q?nAh6cO1I/8ef8c5qsoW35Uev47fSdNG/PyEqyBQT4n8Kx6IBNU9wRjwhgsFt?=
 =?us-ascii?Q?hMzV0qhXLm5qsxipz/ShoCVLzyBaUd2RhVA3jNeYgX/scUU0lxr/lmnc57Sc?=
 =?us-ascii?Q?oC/JfKQLG23+bmiWY81XbDZMqHOl4Mg6xFlzNEIzMiGJGjPEk9wS7/Dzw9KV?=
 =?us-ascii?Q?7pzYt0OpxM7pZdtYkylz8OGHF1MzChgUA2UhNXC4qSJvjjQWt/AKj+7f44vY?=
 =?us-ascii?Q?v7xxnN6DLRkpZLaDUtvL7d9+S7h5w/cAZjS8ruV4lmPra7K7ROyed3429GDU?=
 =?us-ascii?Q?Bka249RrLoSSm/V4J3Hs8XHdkyzop9M94WUx8B20Qy6rxthhT3fDlHAsFMF0?=
 =?us-ascii?Q?zf2LXSfEPA8u30wvVys39wQqht7WeevN3gJpD1XF35pguG204xayFHvocnaD?=
 =?us-ascii?Q?uF6/2on0R2EDsf+/CqrREtDQJboJCxw965svdYz8288HuJJ8u3E+NLwLawOF?=
 =?us-ascii?Q?TYnw7QLgqLBf3BdwOYuBQ9XpsWOUIi/jg94li6x3PxtFCFG0fOoa3nD06805?=
 =?us-ascii?Q?szQhJkmcVxeDWSuX3kGRUixmV1p/GVp6MI5IljcOfi8f7XKYiEKf52nNlCkN?=
 =?us-ascii?Q?5sQiYpf14QesGWVO1AkaHqC+tmiOICRJqPyWYE3FtRAFc044oDPlnrLGRCjY?=
 =?us-ascii?Q?du12ndd+8B5hJ66TKn5cvog4iKFSA5ffJqrXeQCJO60yN4cGooIMgQFF+StS?=
 =?us-ascii?Q?6BvGvI7LWyldJZLwL6gjI0xF7ROoV1+QW90mi92wutsqvzPbrksaM1FQwjnH?=
 =?us-ascii?Q?YBspGI5BvVRma37eIL/pNygWBW/WgKqlRsM3rJDA5qBOmdPjWAoszRj469TK?=
 =?us-ascii?Q?x8PxJieF5IibsPPTTdWSUZyIGW50Sxk07vbNtL0vGREften1+tvM0rtsofwn?=
 =?us-ascii?Q?m0QK3Aq8feU/mFh/8RgjG/KolGc4sVN9ZD2JHQ4Z7Z3VVe30xTVyJ0BpCWeC?=
 =?us-ascii?Q?RUnaagF+QysMjh6iFTVBL2Bo9sVeYuFxOj0bfvDoiyZLF52vtnjs58YZZHD/?=
 =?us-ascii?Q?2dVvd26Mv5i+SJy2JxRF5173JIMrasgNOA6rDuHhBuRigBjQ1mCXEw0d2ceX?=
 =?us-ascii?Q?EwyeMqID+aCAif3LtguIGdU/2+NmNcPbkSgRsi2GO/W54FP9r1OvwzAIRgyq?=
 =?us-ascii?Q?0SQGRk1GtvfaPYJC8ffoO0sQVG2YjMD11wwBNNfJLs3VpTa6970QlM0SuaHy?=
 =?us-ascii?Q?A/OxN1KmINpgHkTtEmIHMWQEXdUkfWLiEPzKnGQFCn9ADTUFS2GevQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kiPxcE7hTzvX59s3atCtmxe71xENFwGOPYDf/CpFJslApW8i+wdzOrxLYzzt?=
 =?us-ascii?Q?uKydhqvhMQX/zpiFtT9t3Kcma0j3N7zsdva4qalqCeOQsRiGXEkaVELK2Tam?=
 =?us-ascii?Q?stV2Gq0FvNcGaynC2Zu6GGKL+eiOo52/dI27rhDmH0zSQSXBN4k7cNpoMGSv?=
 =?us-ascii?Q?qvZjyQAWRGJ21zPAZzDW0XnOyI2LxpKzraqf5VNr9P/HcM6SgsAZxBmbwU7B?=
 =?us-ascii?Q?yenjHl3Kts55dBLhCv4/UTTHD5cEDEzhfK6uUEUGppSxVrQTXasZl/teMpYc?=
 =?us-ascii?Q?p2at+HzEcoWyI1hEgVM36XNmdbSP5MRtdrJSGAuxjtNKYJJhrlBFfXgfOl/Q?=
 =?us-ascii?Q?gjdOErH9xWafrfcXT/uNT/ez79l0MC4z5MmRL+yrq9xpteqzkPa9pVK5uTz/?=
 =?us-ascii?Q?iv+SPpQJ+jbJ0BQMFs90MTTMmBvK/kcT83r8SeNMzVZn3NjjEt+mYUwY5ZbU?=
 =?us-ascii?Q?zFizcZ0Y+wE1S91Pr8SVSdVFKuyojFLc8OPRb829Pr/oWc9MA7ye0KpAAOF3?=
 =?us-ascii?Q?eq7ntL0jdccarGEGGrj5RmcZSNO1DUnrEE3ndlZptQqfBP7bfAsMON9WnFsp?=
 =?us-ascii?Q?bN2aZAZSSGLWwqHwf10z9DghprYLBvR/yISbq3ROL0DVtz/UGGKdQeSGxcdr?=
 =?us-ascii?Q?v+MFovvQDI1rYqcFYb/6569hMlf4GzZ9Cg1vwm41N7WW7NTFy2nxsONVEGHV?=
 =?us-ascii?Q?nu9iPG18UWbPgb1uKukcbyUVf4KIHT1c4nH75X5UuSzG7QtwHvIvyiS0f+Wb?=
 =?us-ascii?Q?0be6GnC9Lpadten5aREUDWmL5QPT+iz5ZlBcsG0gW7r7MtXWWpGQCd1EQrbT?=
 =?us-ascii?Q?b2JMlQmLdiMQFWfE+42qquVLvpAFmxcysHJnCkj1xPDrKILVKIsQtYMgd77K?=
 =?us-ascii?Q?MIZ2I02mu5vDv3g8R65Ij7Ma3DZOAYqa8V3E+twTYzDb1Z/gS7im5/fR4P6/?=
 =?us-ascii?Q?meOsx0fAotOBvVg5cGbYjmbX2N4odWgpZJds8m55DksJBdFmnjSPMV24jiM5?=
 =?us-ascii?Q?0FJKKys/CCQd5UwDjDBqcPEbRVToY3BlYfCEiHywP4elGvp7s9Nwou6+b3ud?=
 =?us-ascii?Q?hJm0qhsa0PGXk2v/2Z5JAtNCv8XxuPJjqX56yTsCjhpPJsYmuSkANd/n/yZM?=
 =?us-ascii?Q?QfrTkc84XJ339Of5eacflKwupCpCnktP7T7Q99HWXMR8B1wXfzZ3996xXoAY?=
 =?us-ascii?Q?T8/tcWa8aUVyXpEkSVIRdTLtdg1jidH32d1WiY/UXIDWsA79eeQx88upPWcQ?=
 =?us-ascii?Q?ffoTdSSQqVSefB5pcqYDvsQJVmKu0Z3EZV5YMrLjlUbhDDvc6TtOqxeIcAna?=
 =?us-ascii?Q?V06nA6a8sSJIAgz4woSYLDidJof5n4F0xuGz1k16a7EF6RO7tUZp8TATS5ar?=
 =?us-ascii?Q?opM/NgehNsEOV1v7Q6Mb7/ENgcVqKF3Qq6CI3B2YJdREtkeS2/ffR4FnUn8C?=
 =?us-ascii?Q?52LCIE9Xfu/eEbNCSXGeUKkL+boXDMQvpJjxc+VC+3T+E1QdNQIQAwQb4IZz?=
 =?us-ascii?Q?p46eC5Cv5NjoG/+mAnEpdw8WgA6h9kS4eGoXvdp7uQ560xOTTSJ6UtfiUJjy?=
 =?us-ascii?Q?kWEYzIRYA0N9/vi7LgKda3n0SMWssfzq6nA3rBnm?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae4effa-2ccd-4894-0e3f-08ddde28eba0
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 07:29:09.1528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 63UMAFfTALpGJlXRTEglKO5UGcM3M/hwaMNCfKq73JUPzj/HppDxP8pRePzNCLf+0FMJzd6QlFMF8ovD7uMZXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6144

The clamp() macro explicitly expresses the intent of constraining a value
within bounds.Therefore, replacing max(min(a,b),c) with clamp(val, lo, hi)
can improve code readability.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 fs/ext4/mmp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index 51661570cf3b..ab1ff51302fb 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -231,9 +231,9 @@ static int kmmpd(void *data)
 		 * Adjust the mmp_check_interval depending on how much time
 		 * it took for the MMP block to be written.
 		 */
-		mmp_check_interval = max(min(EXT4_MMP_CHECK_MULT * diff / HZ,
-					     EXT4_MMP_MAX_CHECK_INTERVAL),
-					 EXT4_MMP_MIN_CHECK_INTERVAL);
+		mmp_check_interval = clamp(EXT4_MMP_CHECK_MULT * diff / HZ,
+					   EXT4_MMP_MIN_CHECK_INTERVAL,
+					   EXT4_MMP_MAX_CHECK_INTERVAL);
 		mmp->mmp_check_interval = cpu_to_le16(mmp_check_interval);
 	}
 
-- 
2.34.1


