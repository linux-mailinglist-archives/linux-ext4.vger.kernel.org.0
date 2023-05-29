Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27C5714540
	for <lists+linux-ext4@lfdr.de>; Mon, 29 May 2023 09:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjE2HJy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 May 2023 03:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjE2HJs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 29 May 2023 03:09:48 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2131.outbound.protection.outlook.com [40.107.117.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7ED3AD;
        Mon, 29 May 2023 00:09:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJQShSl176yvBlk6A3dWPqMslfn/iutexOYv8snLZ2sNGBTcJ2POY6YudtkxK56rfprDD6xQv5LFMTY+GXLoDq6ei9gD9DJ6QexadHbLtvUwSA5PJnjyY8Sbz+vo92YTGjr5u3fctkXasDzNedpz7VjcCAsHRmg3+hmQLNYn1Z571SmtFGbeyqtiVlF1k7n7MTK7mkXukRnNm8+AdUHuGY9Y5nO/7AUKlRGY8AhpcVDLfo3bXikDm6Wz6r4WZIIq//wfijnGKcYtOUGTFbT71fz25qH0aUbLpMi4vFZ9tGsHzk0EIR5CuwBFYnPDkNsA+zo8RlZ/9zDJ1QRwWNswwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJRlhtpYh2fossqZLaBSSXF0Q0/vYJzUGPM4XtJZklE=;
 b=WJ6FEVVcydmnqhvwW9SxwCCZEv7Vg/i8K2XRwZDQ3ves/r2W1noHFKM4MiQDek53XRt9be0JJA57Web8I1U2Xd5Zmq1C7J4TfJoYU4yy4vsS6zXoV+R8w2XH59ImUk7SpS5pWtjWyR++3+HaMgfRPuQvhg4Y4iYlc3noQlO/Qoxv1qRoJcIW/vMbpkBe81nPbRHRjtx1/udP0lgdpu41OdR6YYflQ9VD5CA1tB97PQuMeuW2gljKP44THyPXn4M/iNMyCpKHhYFXS5bDK9gy3btl16pUV6fFSMjt2bUG0kpC0/u+qEtcRZJa4z5a6wre3ODgOg0ukIX0GcY5v2H/5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJRlhtpYh2fossqZLaBSSXF0Q0/vYJzUGPM4XtJZklE=;
 b=qB5u2OTtXmiJZCzKDVY7Gan7PMC1J/+dTevChPUbjXDs3VUrcWlEvmvEghc3nPs1cTIE5mqUxcyFAPFcT19S48s7p8mre4IG1RH2LeCi+YyQFGgk7Qr9yRpZXMBL7PjVvWOEJ7gmKuT6j4utqDappepD++jbHi/zIivhAp5hWfRouOGJIsrQV5HLn8Q5ttoMBGqALxaqaOdprzQSTA/dsscHEy9CriWT1uD5Rc1KpqigXR3XV5fNjzDsGGQVPHcJzDqRdS0QKH5MCt0Y2p81+z7Z3lNha7tOpDCyQM2Dfl+qyO5neTgjcSuDR/a6Nn4hNBbR/Ft7RCApaym9hFqMJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by SEZPR06MB5737.apcprd06.prod.outlook.com (2603:1096:101:9c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Mon, 29 May
 2023 07:09:40 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e%5]) with mapi id 15.20.6433.018; Mon, 29 May 2023
 07:09:40 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org (open list:EXT4 FILE SYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: [PATCH] ext4: Fix traditional comparison using max/min method
Date:   Mon, 29 May 2023 15:09:30 +0800
Message-Id: <20230529070930.37949-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0100.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::16) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|SEZPR06MB5737:EE_
X-MS-Office365-Filtering-Correlation-Id: dcb2c998-8d22-4571-8fc1-08db6013ab4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YlzpfeyZaZeKszJ5dY1whOIsP5O7++gxEff9IU5rAVL/U84H2CSKgAQi5KODhBzhD2DYc4zmkOvSB6VaOx5tG2w961hrWkz8Ls/u43v271bHm9iDkipyBTyNBIfrZoGcy95YxUMNTg7XXDW66YTbg0WQ+LPhjzw516NNrdA2e6ckZ9CGIVD6AJtV7pzPlYjqBDwuGKzQtSszneOxL4PbEkXOEhFefl1v/BM5I6GNqOantWwbkiPrvtnTFIorjTB5ll+fB0BgD7/0A5zofqn4g05msXI3mWXUlqISuClZxztOg2RCfslasnFbnPQdZHATz1F4kOfxlNyZXh04jYMaVeMwyYyKT21mtyL+VO8MBW8sUPb6zaNV0mm5nv3z0nG70HWnMIVi1LORSALQhuKuTRbbUIOencj3C1n8CAQlA5AL0xKCZKe2s/71RCrRO3LmRdj6C1DZnYFDrAkI50NfwfA6Y79eq7ntOegoez2bhc49aixxELddguC1tPPXWdDEe12MyLonOAfkXW+bYOqEhuRnnJ7SNqo7JJDluS2CVApo/lVSUdDuXTZhxXJYR83JA6Ycm0fskZna4IlvINXreeLtEUa5Vr5tWnjyGqXYw4ELmwne0yH0OhyNkbDE+9iT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199021)(5660300002)(86362001)(478600001)(6486002)(66476007)(66946007)(66556008)(8936002)(8676002)(107886003)(110136005)(26005)(6666004)(41300700001)(52116002)(316002)(4326008)(1076003)(6506007)(6512007)(186003)(83380400001)(2616005)(2906002)(4744005)(36756003)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SG1N9e11YCXn+pW+bHion1ZRBawWHzsxoUCoj4Np6aOCHt+NruWdHHQ9OBaR?=
 =?us-ascii?Q?4GHoCB6jYpW3xGxs4ogb17UVPJ4z6ADl9sv5D9208ii/g+LmrbqGjoJj355m?=
 =?us-ascii?Q?iA7pvVUun04+X6EPK2uXLqRDNd5EscUolToL+ZMkmyENSF/kNu94vvXyzor1?=
 =?us-ascii?Q?A3WMRJ5RSdAM8hOJXQ35d+WC0ciRvryafk9gMiq3oihsf3gRcXRvo9vdfNBs?=
 =?us-ascii?Q?MfJLXYw8K9PsxTxeZuQjvSZmfmvqszsbh1BrLJiKX0tUKKvSughHJNW1qkNC?=
 =?us-ascii?Q?Zms261lu/kfo9cMHBM//rAyne7runS4k57aQxE00vm44q8+iWYMMEhdtc80j?=
 =?us-ascii?Q?+5BYVEFWB19OLODsL/qia26xUgFcsSO7b9Ygdqarsa+EAHlOGCo2WNF9payk?=
 =?us-ascii?Q?P+gLFs9KEVQEtBLsdgKtrtZtzZu6KDGBx+4YQjhP//Ej2PjUVals9R4PaYVS?=
 =?us-ascii?Q?R7LM0ExdLdk69HGXe1J+Z1YxKJ+TPY7kzRn1v8QSOgVWYFAU30QZFsyojZGQ?=
 =?us-ascii?Q?VAwQA7gr5j4zkjL/1ZL0nDrEL8b+h7EDNNsW9cFto/CudFtuKQLY/mt60/eh?=
 =?us-ascii?Q?QKSCIhyi9TW+lR1VxuWJ7p6cIP41heFuhRrEElKu2g3iARnzcLgnMsevGxLa?=
 =?us-ascii?Q?FYkiGPXneMHJcegRG04tkI1nmqqP90fU73+atFPhd1FmJ4AlZe5VR9PYxgx3?=
 =?us-ascii?Q?NXWYwO6HEMqXzCnBAqQs5rZngCyTmZWp9LgdQ0CRlDrqygp49IGUlJ+1WfDe?=
 =?us-ascii?Q?rAo3f77xSc9Jg5hkE9WoLocE7toMQZTv4SXY6Dg10etzSCqVPwhwrbxjLZrv?=
 =?us-ascii?Q?m3qMS1oPsiL2QJAI9RvV/JKEoEzgfGbQuq/5+91o4o/qseeP7FeM/TyLUcuZ?=
 =?us-ascii?Q?xsjX+uYzht03kE8NF7b6uIx5/y6lTAELWHcRfFazxXnrm5FEtH+dEBjLIEYU?=
 =?us-ascii?Q?uFxVl6SGxXy5hUUfF85S4KuwTTo4j0U5fnvmqPSWm7Ku1q+jmCUOCRpvSvvj?=
 =?us-ascii?Q?85xqPoBB2SFcjKyFVpapk0jPgAfXBzsNQygBj75qO2LQXtl13VLEIw+IACuC?=
 =?us-ascii?Q?bWQQFEhm03mx1tC2nJlzkT1dpc270u32rWx7IEAUcq9adHPeBQmjyKuCxkRG?=
 =?us-ascii?Q?hV2WucY+fYTtLn7K5VVsLPjmF2j3n9x6MDLkBZyg4z90srQG55iscDCWjTVR?=
 =?us-ascii?Q?+G99aHK6E44uby7tpdqhcGMVCt8p+dv4CJMX4kWC0Eo4Q8Hrc/uPKQcdW48y?=
 =?us-ascii?Q?VQHfOgDn63ODO77AlBTitAfRdAE4RZMwAEW43ImUo0Pn9tyx2kpttF9Lccr5?=
 =?us-ascii?Q?7tpvweS+H4DPbmGF42AiWV1cZu68QQHlCRZkkY9UL0/KV4JiikfFZaYs1dtb?=
 =?us-ascii?Q?bK7obm+DR4Wh/1UHYWzpibp/qdEs5C5n7sjxabAHDBBbQ69AuUtl4Ry/CuZp?=
 =?us-ascii?Q?Ox0qSdK2pkEneoJtUoB2Y5ati5AriUgEd/Y+Zr2cIeL0Of4hi32mQmzDuR5/?=
 =?us-ascii?Q?DRxRDDTnno2XACtnu1q1hnLybM+n1iABO95boM0fHtSs8F3kdrA0HupzZEG3?=
 =?us-ascii?Q?XBEf+dbt3Hh/e5ayjmZm5X7GYITHjqyFpGt1mlBT?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb2c998-8d22-4571-8fc1-08db6013ab4c
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 07:09:39.9721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YJW4HL52NPjn65+UM7hX3C/+w2E5N7DzbBU371D5isaL1lSUBtlI+fsPxDynAV7umNqg3dQIHwsY96XsbIEjzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5737
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

It would be better to replace the traditional ternary conditional
operator with max()/min()

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 fs/ext4/balloc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)
 mode change 100644 => 100755 fs/ext4/balloc.c

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index c1edde817be8..82124045d187
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -111,10 +111,8 @@ static unsigned ext4_num_overhead_clusters(struct super_block *sb,
 	itbl_blk_start = ext4_inode_table(sb, gdp);
 	itbl_blk_end = itbl_blk_start + sbi->s_itb_per_group - 1;
 	if (itbl_blk_start <= end && itbl_blk_end >= start) {
-		itbl_blk_start = itbl_blk_start >= start ?
-			itbl_blk_start : start;
-		itbl_blk_end = itbl_blk_end <= end ?
-			itbl_blk_end : end;
+		itbl_blk_start = max(itbl_blk_start, start);
+		itbl_blk_end = min(itbl_blk_end, end);
 
 		itbl_cluster_start = EXT4_B2C(sbi, itbl_blk_start - start);
 		itbl_cluster_end = EXT4_B2C(sbi, itbl_blk_end - start);
-- 
2.39.0

