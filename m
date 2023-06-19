Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFCA7358DA
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jun 2023 15:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjFSNpZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Jun 2023 09:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjFSNpY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 19 Jun 2023 09:45:24 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2132.outbound.protection.outlook.com [40.107.255.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B12DE4E;
        Mon, 19 Jun 2023 06:45:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5UqxDdJwHNOIVOcsIr3jEXpQzbO2UxJ4T3iDaFBIhYscI/K09dVvdXtGAu0ZVbiA1Rr3BJph0uKbg3EkHjZskJU9PZkaQMGxW3TTG+R3JewIby8A6GPHU9W3Nb6kFAH5ZNnUC8mWEkaMMIw/OFNuzygQEz0iiIr9x11apikDrTnfmu2fi2gWuD12j2FWVidBhbkP5aEwm95ZU+owgpspGvr3onFBd5ZX3BPatj9fJXNs3bY8OFAkHjsxj2FW0sV65oNQ01huBE8FVspki0ejt3zQRHsJT2ZuIFtRdNmDu61vcEQVNqIj4aLGoNHIsMSN0iNV+P/x0oSfk4AjMD5bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NyJBoVqWwazm9iN0H5lO9gtmuIwm/SDovv3HY5wWPs=;
 b=bbtkBZp77UT11r8SH/GxKq/pgOOIKCE9Vw3vVgrySSpRJfulWEeSKMAz86fXxbLqb9IaNbO/CO8tla1Sd+qWuV6ABNjIORE8I7vXsHCGu6vHHPEMg8oRNjzuXHWsrvkrNAoKnb/2BMFAX4vINtP/dXOwBq97udKJzwyl5F/5MEQbNhb6KeV83tXIawCDu99daVFlDzy3CpYN5uK0A/RnZLQx9GIm2X+zJx+KmVKrUo+nbMYbzlRVrbl4KtquGA2/BwoIbjuDoEJt3BDK+bdnqcnPXq4IrOkRlYr97lg+Dwh44EDvz3B48fYXNyDcvg5b1qr6hFTITmEjAf/lUwbmvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NyJBoVqWwazm9iN0H5lO9gtmuIwm/SDovv3HY5wWPs=;
 b=Wv8Gebj0L+PmZiADEjupSELJnkqzHYMztn5R0r/uH2H4sQDzRq+a7BiBGGiI/vDEU1R89euT+WLhc5D2/Crg3P1SIPOhj64EbgKKKfum3tzHx4oIByngZtFJ1KQwSoBX8Y+chK45eBGl+UcKOx+PEDdDTOo2guowzU8iwrc/0rvZLgR3jdIaTqunryRz2xRAc7vsS49+lpBK3eiBYJ0VMkBsSEKsPy2MoxuyZ4uzdGKWNPDb8SHxo4fPoUEFFWP/AHWP3+pY/CyFK3Cyh8fEUlHunqHG1AGrMy0SyoGj2xA1yxC4knf//w7nphM07wvgAgoK3tk/oBZRUWjGEfMDMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5022.apcprd06.prod.outlook.com (2603:1096:101:48::5)
 by SEZPR06MB5365.apcprd06.prod.outlook.com (2603:1096:101:7d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 13:45:18 +0000
Received: from SEZPR06MB5022.apcprd06.prod.outlook.com
 ([fe80::37cd:b3a2:1fee:705c]) by SEZPR06MB5022.apcprd06.prod.outlook.com
 ([fe80::37cd:b3a2:1fee:705c%6]) with mapi id 15.20.6500.031; Mon, 19 Jun 2023
 13:45:18 +0000
From:   Li Dong <lidong@vivo.com>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org (open list:EXT4 FILE SYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, lidong@vivo.com
Subject: [PATCH] fs: ext4: Fix traditional comparison using max/min method
Date:   Mon, 19 Jun 2023 21:44:44 +0800
Message-Id: <20230619134503.1277-1-lidong@vivo.com>
X-Mailer: git-send-email 2.31.1.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:404:42::23) To SEZPR06MB5022.apcprd06.prod.outlook.com
 (2603:1096:101:48::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5022:EE_|SEZPR06MB5365:EE_
X-MS-Office365-Filtering-Correlation-Id: 5242e50e-0504-4726-fce7-08db70cb6b46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nZjZyrdFnwHrYXDuKF1ilEcezDkngEXRdyQ6S5A7qPn3eg+O8USNYXqiyQ5bp0QqANFSBASh5b7YTOD77RzfuziKPPB88V8cxTOixW54jgOsD6vZJF9ZcQhEVVeHh+5f+q1ct1+Geu8SOGK0A+W1+hap9Wvx9hz/Gnt51VsmKezIiztgfcVgPl6W2yh1cQzzteXJsWakDR27Q7GhToQd+CmPQ3xp79Ue2BfBcUSa6+DP6ZzTLJuXVmlpiq7miGZJwqz6zuJvNbJCgVWDTYgZZOECpsRBxJrhl+NBckWvipI8TflTna30es2kFiQ8Sb4fd1IGCMCkOdaMGw/sleEHyQv4LWqlSWfCvDeQEYn74PVfDI8G9MYidVmo505rUSSoB7XF3PIjMZLjPIOB5rxcEpVAxwDCxTZOcPUkyjYcU1HEONuU4ilc1uCBGi0GcRHbixiK9u5Q/YxX5lWdNmC0FXjA/tr7Wjy4tYAwpW1c5sB5pF9MFkEXWTZVXJdtBrw2Y4rEe8ey37R/PA6WwcED/Q0UvhR/7mhhLbqe61dFGu4CmcDwR4O+DAWTcFkX9iM8cVloCnYlbdU7RtWnKoxehSFafk+KtKW4wbaenfkYlxWmISmxiZddvFtwiwgPzXNq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5022.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199021)(186003)(66946007)(8936002)(8676002)(66556008)(5660300002)(66476007)(110136005)(6666004)(52116002)(6486002)(316002)(38350700002)(38100700002)(478600001)(41300700001)(36756003)(26005)(1076003)(6506007)(6512007)(4326008)(107886003)(4744005)(2906002)(86362001)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j6p9ypZtHeZYoHj0XAWZeyehZlarciuWZUa8t7yymBQA6IutTuCP744kfhfy?=
 =?us-ascii?Q?ssWBq/lw4xOAscMzLol6xERzQz0RtfRreqi1FMUW3daWUVvR1XeqYOmero3B?=
 =?us-ascii?Q?6GMifhEdjoGYF2Oyz9qKV0YRuVYwNNWiC4uyeOMOKy2DP36IZei8jkUWPscL?=
 =?us-ascii?Q?QidzoBpV84a2JQh51j24bcIhE7oOhLTwoaCruBPnWfdkFpgPl0kHdJXSREVN?=
 =?us-ascii?Q?Xr3khtZdub9LncOBvbwdQ4X5pnsuAHNmh0dIH2KFATyEUhFYoKSXZ4c5kqjP?=
 =?us-ascii?Q?gq7W/Oxf7vkZGkXZn9dg9H/tUsyCuN7j2J9Zp7K0MpuSnHrxOfMrtzMSYrlS?=
 =?us-ascii?Q?vd5CQdRX+mRNbvIsqcN6ppAk3DEOQBxnzi6EHmnwSwWr2cathzuwSo5+12jq?=
 =?us-ascii?Q?uaOH/K3k6dxP4847sc+r3chEEo0RB//ddQprmAGuNz3f2BAKAYGlz/pfJqzc?=
 =?us-ascii?Q?yps/MiOThN9iEzB1FEs5yxmabRUy8W0ioDuPPlqIWBh6KA5UFlALRIWWsS6Y?=
 =?us-ascii?Q?QO8y0fX9GsSM8bjNE1F0srEt2b2uQssiFWk7Jlrv9/rwiRICKZItEKYuLDWB?=
 =?us-ascii?Q?8yErVwLCyPiNO92frrvWfH/1kZt4QXVLlkv44PWlivt2grW0vVdpnx5UymhJ?=
 =?us-ascii?Q?/0Sb0xABGMcqUs905+to7j9PAIDxRqLYqj7dAZtWk/2hzHTFj6w1O9unU5nU?=
 =?us-ascii?Q?K3zFXnJSvw6hKmEIiASFMv+2B8sJ3RDcSXtO+IfuvYHi/ZTeAAGPTh3U9G1G?=
 =?us-ascii?Q?lFUldtKfu17291iss6xis2UGc9j8pIThLG9ccOhKOE2K9FS9XnGkNO0S5Vys?=
 =?us-ascii?Q?1TOB/wtTgDGjYSDeRPRh7zDidflSj1Ph7Ttl+gTkqn4keJbVPgicDV+ddl3c?=
 =?us-ascii?Q?FFvYuVX/THdhf9COjYucXlUcqqtrxPsP+ES5WVe4ZCsi8F7+B5lRzhWCuQ4A?=
 =?us-ascii?Q?XUj4KxAMQUNMUWnqEOgHLqwywnLDFggh7hHmvmsjS8BhKPtIFvmifmE24mPo?=
 =?us-ascii?Q?gKk7Kva9hUNGytLVKqjhXCndW+0Y8QyvPTyNfZjaO4sggGMYTigBfhmB5Fug?=
 =?us-ascii?Q?lNTL6VIBwlCwfEBRkd2QPtTd/nTOrnUO/0osl8SJNQ58XIJftu0b1egZQqFz?=
 =?us-ascii?Q?rkNf9pBnwUBL0+9c9AnYzfM7zwc51O+NSjOXCovcLEe0pwQNWBjTlWb0ZjRR?=
 =?us-ascii?Q?aGrF2RzTMPQSxeJ9O+VTTC0kmsQcpDTOESgq9n67PddD9HirUCaAH/OKsLnn?=
 =?us-ascii?Q?yWUexQgd/vtDspQ1EJChY1sylJldZBnZz5YyG0+5/WFLXvTXercMOLMzyok4?=
 =?us-ascii?Q?1Q6D6tABAJEy6zg5Ah9l8GB+vHFGScuURUztpLgb0xv6oxMpSUUYjoYm316s?=
 =?us-ascii?Q?4NreCfd8CR2uNCtHhL4klus1adZP7vgjAwqLLsI3TtB4Dd9ZDoNSHLnX7BdN?=
 =?us-ascii?Q?SNaStKLGwSZW5OMAZ2ZYXYeo9pEuSAj2XuSMmQn6UdO8WruYTOtcEV9i3iPD?=
 =?us-ascii?Q?ChV0xBNxVFuCFN3wLiHKoho9wCJDCZaQJXNwI2LXGNEuGuPRCFuZrYYzPFP0?=
 =?us-ascii?Q?0F5gHJEvpeuuY/P1S1msDOUTnz5VZ1W9oW+HfJOm?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5242e50e-0504-4726-fce7-08db70cb6b46
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5022.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 13:45:18.6123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDvmHeOMD2DMP/qrOMs7BYad15UO2mZIM/uWSoUctORb8uhUArx5779rNsHdrDVDF9Bkj3Pgew0hHmHdS7+A3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5365
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

It would be better to replace the traditional ternary conditional operator with max()/min()

Signed-off-by: Li Dong <lidong@vivo.com>
---
 fs/ext4/balloc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 1f72f977c6db..90ff655ddddb 100644
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
2.31.1.windows.1

