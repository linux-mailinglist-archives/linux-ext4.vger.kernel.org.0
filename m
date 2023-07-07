Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5228774B05B
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Jul 2023 13:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjGGL7Y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Jul 2023 07:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjGGL7X (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Jul 2023 07:59:23 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2102.outbound.protection.outlook.com [40.107.215.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3ACA1FF9;
        Fri,  7 Jul 2023 04:59:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSvVAi3EXam2EpPqjP6bcO7gMPs3H7YFyGFAgoeRIngRXi+Uu15i3mH+6+Kgbv6xOIE9QZBAPYZUASbHzjvVA5y38XLKlIucVdXBgOa4wey/Cmn9X4qbzAXSJR3F+jRKmzBpfrcEoai39f8W0/DGMH+pD02Uyve0gJ0DXs99YzMH+azsL49J+Rf1ySMjO3L1omIVwb/1OX+QwuEV2AhfbtTXdSlwoirtkjtbRMTkdv5dWX83K7W9W7rtPXekk31M0f3KZKp7qvx3Z77FQ8UtAOJN97JMEcyu9eoewJSFWhqru6CBKtqjNF7Nqb88er5JgyB3G0rAT+Ni8iu1HFv6aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZdQecR+nLLnTW9y6Ylj0AudMG3nYWI789EOvNRovvM=;
 b=WhKWVJqIiUncVJrxgTFAOSBDXs3ccKN5/bAR7/TgUTJOsmFq7V8K99YwW+c2Vwenbba6Fe7Fgaow3Df1HMecICNLXmQvfVLK1fAs+JBEiKuKxMo3PXypX7CTL0EGZvSdb/LR2GXnhvVLbXBBuECv3vyCfGDwr/xUQCcI3p9NBdUviD36UXxhhIEjN3K/TTpjAFD9ETrg8kcvDeGdZLQVGOl9iZufz0W4366ooeIfqnfTsq5apy+hOD87LM6Q/6ce4dLdUfxgEDnqFZ+6SmaP0l00StlHJWS8/7+9PrrrbzLjtiiiMvxyNhCIYN1JueT20rWhhGo8Gp84+3MIt3sMIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZdQecR+nLLnTW9y6Ylj0AudMG3nYWI789EOvNRovvM=;
 b=M37/mxOZMQ1ZDNabQx33ojyTPSS7q1a0aazws7BrIPXYLtOHoJ97j8eqyc+Xl5p0YizSb9ZDA5NbvqfkeTUT3qMNH6BMKjC67sSOCj3NgS5BnMXQ+DRqJGTPgaSSapZJKh6fVD/F7BZo6mSGcjRZCj8Z4WSb0K4EevX2fyov4Xi3MMKRzB7nfzFMvxVntg/yvqTDdR5Ot+Kx+VYwaPdWpezYJGSruhYX1a0WOFbfu59rGLhDoDz4X1AqcEdyXlZSNwHS8udIojs8lJlxkSLGw6Fkuit/L7OR4Elf6c0CrbAESDeE2hRbSqRXc5ij6fVo5A1uqy1qKhBwT2QdEQXL+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by SI2PR06MB5363.apcprd06.prod.outlook.com (2603:1096:4:1eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Fri, 7 Jul
 2023 11:59:18 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::8586:be41:eaad:7c03]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::8586:be41:eaad:7c03%7]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 11:59:18 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: [PATCH] fs/ext4: convert to use sbi directly
Date:   Fri,  7 Jul 2023 19:59:07 +0800
Message-Id: <20230707115907.26637-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0137.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::17) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|SI2PR06MB5363:EE_
X-MS-Office365-Filtering-Correlation-Id: ff740a64-509d-436a-2b38-08db7ee197ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JAzN2JFa3/OWCeJQ7LAHlj1Q8uHKAcArd/qfuRqezxzWaptVXaWMeyr9jqyfir3wwCJRgjjCGQg2ubqSVIBbnkiUmze679ppE1TzfUV2Oyw1AgIOP80WbB65FpdI77VcYNmW+CRP7GGaE1ti4pAca/hg3CMft3AJqx+G1UNPs+cehzp/Juhp4Nowi/W8FGt/PYOu9mipkJmq+EOEHkQB1k1fWpMTfC5LHaR04B8nJEagRuctO56RSKiCsOjF/PSYT+jgZcNVKyF0T/w/M7+/vhubz4gTqkfJypXHcwCfnFFSXbLEi9Xp5WuN9w6q/gz6xztEzAAgCuSZTj6KdN9Sw7Nx38DVru/wvkgl38Dmun6e/awhbyTUeqTyHPMz08KWmwBI+u/S577iEjp4zO8SLM2OghuL+LazXgZpaNwxMoPnaHoK6+NJuZJ2Wjttj+MeYDOeYwwABswH1N8TgvYVsZxaZlEVQ+Wa+SEsFAkTa6HfA4JspCyyEoC62pFwFXi12dG3TuP6E9W6ftMc/h7p73FbH0vatdbH5FlBLlOJTRgZZeDbeNOB980kYF3VxCCkX7SxsLptCvWu1wyEXH7Qffp8o0kDxP/9kh1wmozWZJhgwDVJOnJ1Ie9ONcgim4j3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199021)(36756003)(86362001)(110136005)(38100700002)(38350700002)(478600001)(6486002)(52116002)(6666004)(6512007)(8676002)(8936002)(5660300002)(4326008)(316002)(66476007)(2906002)(66556008)(66946007)(41300700001)(4744005)(2616005)(83380400001)(1076003)(26005)(6506007)(107886003)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AH7/w7zgoUEERYI7kWmZiKG4AGD1ayYOXdha9v5yWCc4MCcLRQitK5i5jCJc?=
 =?us-ascii?Q?1WiuHKibbfHSoqWE33koHOjFmQNtdtAT5+rSNUsbPv1qvaO8cth2CZ1M6w1T?=
 =?us-ascii?Q?yLMf5xhtRb8Id3yWKyk2nUIjgigcGACMi1lh8yFoNx+JyFKjgQXWwqVQtIwl?=
 =?us-ascii?Q?5vm0btZcvraAgzeih25hmLMduW+IpQYBnLdswwwaDjsE3ngyFklXMXvRl9+0?=
 =?us-ascii?Q?ARWQcpkTE8lwYTLcFHQC30W5xw1Pqy1nphkiZKUXgeoKh1ROyC3JOT+/lgMI?=
 =?us-ascii?Q?Z5PXBYnr99ctnBBRpgDgQ2t006SxUQFux+dKI4U+Rcn897IgOgsvhJNGPlOx?=
 =?us-ascii?Q?xvSBi8h69N1PV0iesoFLWrvkoahLGp+LBa7yxX9uqY4AF4PVDOn5OVxCABO1?=
 =?us-ascii?Q?JKF83md1v7M5wmYPwYZq95IdZMTsokJyuMu5zEzRl8fcoxHAzV2+OKUxoJZU?=
 =?us-ascii?Q?/xFBbgb9GunDeO7neGsHpjXBJvHMYpKpdp7+ZBABm2Vc1TB1f1l1wYHGIeQa?=
 =?us-ascii?Q?JKqgJkfFc60UepDRE0/O/o1cx/SJH3oNl60U2u5WkUyb2mc8xMMy8gOLnKCf?=
 =?us-ascii?Q?JZ2/AU0UhZGZMO/XAx4hpueKJghEfFElp041XRhjyknFO8sLn+OfoOzcrsWK?=
 =?us-ascii?Q?qUGMJWm9D6jlFGEyS3/IeEq+nHmkWrTmYXsWIO47kJJSYPvAaCuJkWpmhIS9?=
 =?us-ascii?Q?Au+7iD9c4N07r2LOIrwCersHyf8P3e6sSrnIMkgpz31BrCBteXItZYs+w4ea?=
 =?us-ascii?Q?hll+Gk4JOY1+hvl+hNWn7Dmrx/D2w0/wzr9duWM42shEtCa4xPn9FNH19Igu?=
 =?us-ascii?Q?kwBKfQsqdTv7vTxONqbiePwEUdBLrrFUzqhnH869AnSdOOhttFvjoDK47TOE?=
 =?us-ascii?Q?lMUTr98guiu6wjmNG3Bez2DVuiMmaNxMwGkDv0Cy11aue97pFK9dx6C1+JsC?=
 =?us-ascii?Q?GkxVlzHeUdiyyec2sN58zL0KJC9fFRAenn0dsjbagsld1wTrzWQgqzFxwKo9?=
 =?us-ascii?Q?eIQ1Egr4Q1bv4Od3ZU3ldD5CZ8vjCbGBamWSZyiWBgFf9/wlKmOLDDA82mJP?=
 =?us-ascii?Q?/xpUy/nYIUqwbR5AdSOVgpedEZ5traAE8kMdAbnmTemddF6lrOpJViEwCXsV?=
 =?us-ascii?Q?B3yIqTf41BEHPmG7PhBO5ocwx1KTgzIMdwndn6FGEpaJZDVtx6IvAWOiWNHu?=
 =?us-ascii?Q?x8Wxf/A/C3PBhKkMozJIeNzDnatfJehiWQ+BVEaBrlkbS/3MxZ/AjfJcpZRm?=
 =?us-ascii?Q?9Lg28CRvtfl+m0QqzDPGuoHrqC8HB1Zt4vhN1trIS93KAfMKhYh01WvwfSXX?=
 =?us-ascii?Q?C16gKdFGIhSpgsVZi7u9YrXaCApWRM5D+i3AmKK9lDIkb4ZM1bMVFuFAAg5/?=
 =?us-ascii?Q?7oaqhupXsyl5DBbibmEL3JlNwO6h+gCJSq8/lFkHY1ZTNC3dkgthiEbNIwdU?=
 =?us-ascii?Q?xyxA0RqZGHYuoAQB+eQOTiIVN02VjQJcaoctRf6ZT+2LV7ZEn7YqRhvjqovs?=
 =?us-ascii?Q?+dVstJYnQckHvcDXrSlSWtBqO8ZCS4ae2NWTX7qbWnE1DjudIN+KM4GQ+gV/?=
 =?us-ascii?Q?FIwFpzKqTJN88QiUlTa3pmqIDf6f26vPoA9HLPOC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff740a64-509d-436a-2b38-08db7ee197ac
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 11:59:18.2265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3hn71o2+vIs7pGg56M8IEYU+2P/bEhRzUE2kKbo5HBYVSSC3qbytY8LGs/FxE3z+eb1J8ZObNwnmcIp4wypPKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5363
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

EXT4_SB(sb) is redundant.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 fs/ext4/mballoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a2475b8c9fb5..752260903d14 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5994,7 +5994,7 @@ ext4_mb_new_blocks_simple(struct ext4_allocation_request *ar, int *errp)
 	ext4_grpblk_t max = EXT4_CLUSTERS_PER_GROUP(sb);
 	ext4_grpblk_t i = 0;
 	ext4_fsblk_t goal, block;
-	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
+	struct ext4_super_block *es = sbi->s_es;
 
 	goal = ar->goal;
 	if (goal < le32_to_cpu(es->s_first_data_block) ||
-- 
2.39.0

