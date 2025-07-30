Return-Path: <linux-ext4+bounces-9229-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 491DCB15901
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jul 2025 08:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 870EC18A4462
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jul 2025 06:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8321F09A5;
	Wed, 30 Jul 2025 06:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="EboBUdNQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013054.outbound.protection.outlook.com [52.101.127.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DFC199BC;
	Wed, 30 Jul 2025 06:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753857523; cv=fail; b=gTuFKutr4fxkWeH1IUCxxY827knLhuTVWoat5Vj3qDbSOc0xM8wD5hPtCheOoV+q+fdnIsKMm1GIuTzq8Ucy/Wip62q7y+B0klrqm4Au58gnju6Y8ep2/t14ECM2kUaqtfVBAdJ8182UdpmxdjB/soklpTln2dcHSUuClpnfJsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753857523; c=relaxed/simple;
	bh=PvbKidJ4DxP5hJbsW7Sc4vgHVP5U8azfk0AfL6ht66g=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KHwVqk8Bge8B67GIf6Kdb2StRt56LgrMQhF7KIg5s6ty2zza5yh1u7wCkA7uK7fjh1QiHGGvCb/c2QVcjeUKsafzLjqSoPCVpwae+5usVtFgHTQyBM8OoaqY/V4d0zhiBut0s4mJgUl53wy+oCdpGV0/3acnMW0uzwdwpLCXvhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=EboBUdNQ; arc=fail smtp.client-ip=52.101.127.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wwWGdnc+wFkyjIwjmdMXNlhXPT+JWcaMKDFp52xXdapS9lG8zSZnDq0AHo7JsbajLEvfELQxVB6624O3/gGXwMBV07XmHfZ0+yTgugWjhsRjzgMs8sFy3c9DcUQTwvMiho7zQiv2+9J5n0LzRHoTyNB3TfnQM9s0YDToQjEREC6tbRu85DrM9SKVqtC7GynidZuvQUXPDwV7xE+MbnYBHdUPFQ77edFtIdhSunYtbCPvUHZp4xVuIb6bZy2peg3HG5/YZQJvLBy1OlaDCqL+/m8OXwn4CYALubDbs6KnmciM1xcLLqpTOJlrVyyRakW84sI9kiSdXAIUY8pL/NATeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFOrzidG4CKq+43HB2NKE1TAQcOtLXCOpZkZr3bQ73M=;
 b=UcoD4aUVBy1a7UIdZaMWwNlayx8EphX3Sm9IIduF0mhFU/R7cNLZIRvMe0hfiascPNvAnWk+aADL6Rh9gE2kEm7fRk6SV6eCb3unMX0nxzIXWDKtfdxDUpPryNYGBlN+QLtjtF49h208p3nbjQKTPiVaWAPke1s2h09/+hlcZVj5CqfuZ9lFOdzdBhYAqMFqCSG97jSnD5ZRyUAdPu+2tdKy4Kl6bwHEgW9B5dcbiVJPHXvEEtFkI8xOGp7F9KfASSGEaAO3pfyzMSSYoS2srpxaASUjnYQkcfg6RKlybxRk2VYoCacbe9e+78GLdm6jGejVdpOhAkuVB8womuAYkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFOrzidG4CKq+43HB2NKE1TAQcOtLXCOpZkZr3bQ73M=;
 b=EboBUdNQ2gizDsjkee/l5+1+9/cuWh/75pbHRbTSPj1XS8zte8Uqs0bIZmz+i7CsE/fmOP/2qTB33T7c6a95QyJ2JkPLr8sT58mSa4OUX7cWcxiZ3OofIf/4sosqTn/0391+NiKUynJtQ44aglEOKmIrjN6eCHEyXolYL6x63YBbpcktJTZeoywuH3E7iz6UWNWnlP1FtH2+S6DSlmKWPuwHU3GfYJoDhYWO1lWupvZ+iRUef8mnCrrH2h7UJ5YbtrQ3HpuFhTntpWm02CSiRV58jFTGCEBh7mSBaDJ6nZzkJp9z3PgGJcqw3NYrioP6Iv5EOfHi81P7mYj+/dIN2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYSPR06MB7008.apcprd06.prod.outlook.com (2603:1096:400:469::8)
 by PUZPR06MB5698.apcprd06.prod.outlook.com (2603:1096:301:f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 06:38:36 +0000
Received: from TYSPR06MB7008.apcprd06.prod.outlook.com
 ([fe80::41f3:1597:2953:65f2]) by TYSPR06MB7008.apcprd06.prod.outlook.com
 ([fe80::41f3:1597:2953:65f2%4]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 06:38:36 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] ext4: Use IS_ERR_OR_NULL() helper function
Date: Wed, 30 Jul 2025 14:38:23 +0800
Message-Id: <20250730063823.313324-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0009.APCP153.PROD.OUTLOOK.COM (2603:1096::19) To
 TYSPR06MB7008.apcprd06.prod.outlook.com (2603:1096:400:469::8)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYSPR06MB7008:EE_|PUZPR06MB5698:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c8e954f-1f0a-4671-11f7-08ddcf33b62b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Au77QUPQO+nlfXaXEWYMWzleHygLTra62Ha8bg1miUjDspL6UsJqra8+Dxhh?=
 =?us-ascii?Q?7g9sPc/7lyIZxhGsEAFHWBhcUKqwzLOl8KNCshEPBJZg9DcBupMBvNCQjqSj?=
 =?us-ascii?Q?cmEDq9Ip7mmr9Vhz55w/W8NR4aEdp/+DmpJi9rPJ09wzqUDJgJ9sUz0czexb?=
 =?us-ascii?Q?CPBMClSAkhRZvnI8vCDbp0V70F/8XhcqXnGvSs7pk4DRpT08AmibseBRcs6d?=
 =?us-ascii?Q?/qTnALWsGCmpnttbAjo3J+HVUG0trjNHQDndXGDaGh3eBdiaMDn8EfEdA7ZA?=
 =?us-ascii?Q?qlB/bUv10JPm5N/qaTkdL22NCdAeYhlH7PxOtMWFrl50vHT7TOFT87P0wSO8?=
 =?us-ascii?Q?rU6qdWq1G5A9J//3W566OPTKwlyotRNpoT1InrNbC6NaYBsWCSdSImHklsqp?=
 =?us-ascii?Q?0N9SpRqZQhU3QeHoBbPsJPQ11b8IUmSeiFycVAYh8JukwNwnCDE4cSWNV3dF?=
 =?us-ascii?Q?pAQol2Np8UW2FuSBlttf/dmrfvLW9tC0b2iH14q530QjUbsR+sr+TEUlacl1?=
 =?us-ascii?Q?RwoykXDM2vas8x1n4+qMl3TBMVMX5iovPgXHG13LMCAC9N0PoT/iI/3T3/y5?=
 =?us-ascii?Q?g+aLWws3jweFNJjOiCWtK69O4o495IkUEn9LC8Kswiu1T5tghYsDLytnzc0t?=
 =?us-ascii?Q?hRaKL7FvPKraD9ZT7pi76wnKKxe4oeMH+VDRCRL9JdEg2Ysd5RGF4L9fRWEO?=
 =?us-ascii?Q?UoNEIIDoccSNa/Vot37QBmqkrExcCy8iV+yL/K3BY7FZd7w8TtnWxFpOt9cj?=
 =?us-ascii?Q?eZ/1vPLt14DUW0XTCrZKRfAE7UHE5kfxsMnjd8l1NuRFfmM7HwWMbDUI8GhA?=
 =?us-ascii?Q?DnxPqSxP90XLtiAVhdIbdK3zYztfKhlTwaEy1S8JE74XJquZ88tTjyCZTNg8?=
 =?us-ascii?Q?wJwc7IB7G4TGn+o8MZqS2/eIFvkWXXYIYMdkMoMQjwDPNDehaYs7j8SRjWbG?=
 =?us-ascii?Q?45JLaDibJW7SnqNj98x6QhN4ULR9JbrWGhS1L/vfsrJD822BWPt3kUlZVgEo?=
 =?us-ascii?Q?MBi1k1eLLlAN38t6jWWqt5SQEVI18awRCugnJEZuHENR77lcQwUhKcNHiVL7?=
 =?us-ascii?Q?6DOnf1x/j55E09w2BKARKItHkrECt9ZKfk5Gt1xsCsNRfqs04rYvzVFpC/Lj?=
 =?us-ascii?Q?tO3lkQGTi7PscJBSfxz+FGuXg/KL7EMbdlRO5GkMTgjqrj3Yof/5SxqW3ePg?=
 =?us-ascii?Q?Rhaxlvo3zl2H7a70FnMfLgYbJu3CLXaTMNsr1XePf/wkIboN26QXZ/YhpxYL?=
 =?us-ascii?Q?3aqtTpbth3RlZ2lReSinOidhCyuM498pPPxsHsUl0Hpe4fY5uNAlGOCxjBu6?=
 =?us-ascii?Q?PvjGyHu5eSaBfaXXRZSp5hv3WPbYKcZ6o2J9Eq0eh4q/EPkXMpJ7/0TTHr3s?=
 =?us-ascii?Q?IfD2YLAv8XdmykwW0qOvm9Ti03xTmzRFDf3vaj840K18SRge9RLXadwxLWIk?=
 =?us-ascii?Q?zvJ5cw+7jMZ99U5RmbhxOdj79urVEHDLhgPgus7fJK4qutkl/FoNVQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYSPR06MB7008.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BULHfruplBWKVdot8sr2ZkWXf251Qjs6Aq6DzPOvnlhs4dKDzbG+R0nya7aO?=
 =?us-ascii?Q?WLfxqe18vxOoD9Bp7EHM05AE9G53R1A2tJhzVdFtj7EVc9Vn82Yz9Q8mEJUm?=
 =?us-ascii?Q?/GuhuacJ9J8sLZQqlgtXw4PRrXTvJX32TlJpHGT+3o6VUl0cwTrB/gfjVLp/?=
 =?us-ascii?Q?igKJjDdb/GRD6y214C/7hvP0yL2hLzaJhR+W8/QOyo1T0baOU3z3RIRv+bN/?=
 =?us-ascii?Q?dXusgLwcb0IMydKVUQKOVoQQzHddhx7CERnP7MZ1ubnF6kzZBcRIHDbeNxg0?=
 =?us-ascii?Q?JZNJN6kYKmpzpaND002ZYQ9NDAVVWTvHIsTwtylGL9y+O1tUp8qO7Ikx+Uod?=
 =?us-ascii?Q?SAJc4xZUGSTZfT+W7jVnJrc7K4TFJ4q8fNPBEtj4mxt3ijnjPSuuRD1HNFXS?=
 =?us-ascii?Q?Jj25+V18W316UqWqAhpqK4wKmpyh6x2Xi+EDYKYtjl6UjctkaF5Y8b7ML4WL?=
 =?us-ascii?Q?krjt4jfbdBfcOTF6qGtaqbbQp0RQ9SQoNjn8PvxkvNEUsr9jUf3n6Rfi2I0m?=
 =?us-ascii?Q?tJq53RRwuu+5tH3ajRmD5F+pu0szQPvg9Y/ZuubSx3Mo/iAmgRYfQmz4Ydim?=
 =?us-ascii?Q?FyKrnXEIhmkbtMbpBJg4EWK9DbRBNW0qBDljDnMMEl1GlmP5qVL8JKiuBcF6?=
 =?us-ascii?Q?kekMyRZEgKvroM2u/7iNhOyo+SKifKhtVtv0Q7GVUarlx020CR1sOz2p/Ems?=
 =?us-ascii?Q?B6NbccAe9KlRDdXI8FNlQUxlW9S3fGYhJvqaj4ElW6AMvNJZGjUF/E1Sb/Nj?=
 =?us-ascii?Q?1w0NRBrWQuEZsITl5YH9WRK2o+hMvuQzDJLJ1evrmBBu89cRewwp6gE2pg02?=
 =?us-ascii?Q?SljsP6QkiOKi4fnwtH3JA58YlRmZOFzlK6tqxuVpnnZZmn0HyYr70tY+O/j9?=
 =?us-ascii?Q?3r8fk9CoqPk83aUpmEK1inpkRD0m40p418CBw4hmzLXXcw4CsDZuinqaMoEL?=
 =?us-ascii?Q?4RFDUP502FISx4ZvqeXMQqgPxUP6YG2kB1U7sREx1O2frO1TE7Hojd1BGh5N?=
 =?us-ascii?Q?7d42P3CuzCRRj1LXsrUEC3ApCyI5o5JjCVS8odiTtP+at5EQ3Ua7yqmfyV36?=
 =?us-ascii?Q?GnijHqKyvVzOrN2cctTtzht83+UoqFnIdXQS5gsuE6TBqFYf7ZXSU+hgzzt4?=
 =?us-ascii?Q?jTRF3Gx8SGve0nATy26heS/pUYPsH4jJJuMgdHr9v8+h8UYiTqDV/bx17POF?=
 =?us-ascii?Q?07IrYDR7sL5Ica9WvtMYZhJtKroXchR7uFu1MRcY71iJd3skir55T3KkQvJ8?=
 =?us-ascii?Q?9uwhLD/VDWS3IN9LLVC352/Jy+GA+xzjo2bDnm5D7ebrY2aBbQ9Do1ZIj1IU?=
 =?us-ascii?Q?yugRo1P8gB9qGfjPi6eYDKIPGbIpQ10wbNQMWqOlXEH5b02JQ2vWFnKJKMnC?=
 =?us-ascii?Q?3vZqQhuC8hwrGGseUCA05AccWe+7yZeHEOabhLn5LZ1ABamSvu0IqAzC6Z6G?=
 =?us-ascii?Q?NN46iHpYH8DIqW8XBu+gf/FDkr6EG17WbcXR9sj7HYS/LG1luJvwJl3aviZd?=
 =?us-ascii?Q?9FFd6MqgaJgidhIhdlrR2snjlmjerwMqAFAG5lQhuw2kLYYPWqYr6nR8+NCe?=
 =?us-ascii?Q?w50BL8ePQ0/300Q5leIHZ7+LJ9RUXGz8UV+kUswx?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8e954f-1f0a-4671-11f7-08ddcf33b62b
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB7008.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 06:38:36.5413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8pPEH9+GrST3g/bVhQudJfP8zAiCqJToY6G1Cks8PL3cyWyZ+Nm7J1oCH0xbT0b0G6i/HrzIoo5NunZYxLPB2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5698

Use the IS_ERR_OR_NULL() helper instead of open-coding a NULL and 
an error pointer checks to simplify the code and improve readability.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 fs/ext4/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index d83f91b62317..7dff0dc70d0c 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -723,7 +723,7 @@ struct stats dx_show_entries(struct dx_hash_info *hinfo, struct inode *dir,
 		struct stats stats;
 		printk("%s%3u:%03u hash %8x/%8x ",levels?"":"   ", i, block, hash, range);
 		bh = ext4_bread(NULL,dir, block, 0);
-		if (!bh || IS_ERR(bh))
+		if (IS_ERR_OR_NULL(bh))
 			continue;
 		stats = levels?
 		   dx_show_entries(hinfo, dir, ((struct dx_node *) bh->b_data)->entries, levels - 1):
-- 
2.34.1


