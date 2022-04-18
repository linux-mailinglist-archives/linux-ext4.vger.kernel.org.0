Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0ED504CBD
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Apr 2022 08:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236802AbiDRGg1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Apr 2022 02:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236810AbiDRGgT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Apr 2022 02:36:19 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2109.outbound.protection.outlook.com [40.107.215.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5865018E3F;
        Sun, 17 Apr 2022 23:33:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcPfzZbC8JhMvuB7ob9+flrf1S080/02bJ3ZUisd60icEziQyqwxfKNxYkAmZi3WrclWmew/k6UcNRYLCU0o8jouQEp2lJl5QjdC6OjJ4hw+q+ZXI+Qi87vnCgG+G+6wVTG4ohxUZc6Nf16UWio9UMGMf1VocjWutcsxG+a9XN2pfSbS/PxMlSrZl5WToI+HQ7l9fRkKM4jqFtp9yuJPl8E8JO7amhlVi221kS1TyhihB0L7LGOWtceLwDTW8QNkHMD+JqZBLjN6U27mxPNvvD2LOfY4o6Nlmz7EM14xcremC/fALLgnDlQMyxh9KWcPyJ9bHJbQwwafrkGh8fQfiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6hmehXcFAR1LpNSYALI3vQiOl2uusEqiuGD9Jahh80=;
 b=GRXBjo+uJrJa8q2GJy/dzrGVtZ5nRrWKJ4765xb+VJKIB1nqd7TFDv/jeylOddI28SSAMKG9IPt6S2xaXlmELdcYBXL9BTMCEcsQYoN2MIomc6oyw4tJrDuL0FjhZrDFDepQ7r8Gw0z9VOW301hvXGXd9UPaAIeoL0dWdcJIiLQ+25W8rgSfrPKkgtgZQDdZ2GVfPrK8x1iRC/tPQBeGI0DCHC1c9BbnveXzhojDjOl72xaxXsBIOEwZTywGT9vKdz0ICSbHe9dP1SF/zXMCa/U6l1LAZv1gRx4vd6SVRRWf3VCnHbi4lNnnc24GoBVTFYu8+B6eGAc4QK82vabjvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6hmehXcFAR1LpNSYALI3vQiOl2uusEqiuGD9Jahh80=;
 b=Zmm8gMwWBio+KObS2c5tlNVxrD3rAOPmll0XjWLdwEutHxtjfB6TT6HGQzRMzYyidKPVUeT6uHRJck6S0GhH5tXbx1TW9niqymzzfQWOdU3N8C2TGevRVHIIC5+1f85UTEwKxO1Xte4R4yNCh+TbDAg5SKXFdjzKfUUpZko3qmA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4003.apcprd06.prod.outlook.com (2603:1096:820:26::6)
 by SG2PR06MB3095.apcprd06.prod.outlook.com (2603:1096:4:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 06:33:31 +0000
Received: from KL1PR0601MB4003.apcprd06.prod.outlook.com
 ([fe80::f0c7:9081:8b5a:7e7e]) by KL1PR0601MB4003.apcprd06.prod.outlook.com
 ([fe80::f0c7:9081:8b5a:7e7e%8]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 06:33:31 +0000
From:   Fengnan Chang <changfengnan@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, axboe@kernel.dk
Cc:     linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, Fengnan Chang <changfengnan@vivo.com>
Subject: [PATCH 1/3] blk-crypto: introduce blk_crypto_supported
Date:   Mon, 18 Apr 2022 14:33:10 +0800
Message-Id: <20220418063312.63181-1-changfengnan@vivo.com>
X-Mailer: git-send-email 2.32.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0068.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::32) To KL1PR0601MB4003.apcprd06.prod.outlook.com
 (2603:1096:820:26::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 275c9f2c-9563-402f-e781-08da21055aff
X-MS-TrafficTypeDiagnostic: SG2PR06MB3095:EE_
X-Microsoft-Antispam-PRVS: <SG2PR06MB3095496E51532255E4B98027BBF39@SG2PR06MB3095.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DbhLy57t/AZDdVLR9nfWPspjUnb8vKGQmkj1sD4GmjsuEOz0g9wA7tIgd0ti83EgkGoChr1Eea6ZXjQHh12NdomYEUPxon9zg6J6BaectlgTokHSetTMkPD0Fha4HKcUulViaQKfpMTljFmdr5zxArH+ApWpPbM9Nn5W8asIe/98lX0p48+gJiuhjwTO7UJ4wofvIMWTSVPoGA51lOD/YX9Slruro4ER/kg/kmZMLXYcyjfu1N6yy6hb+BLBEBIjqrliS3EagJZUmeRLsKdf54UZWP58pQgFTXeTXJyiWJiQ/WKY049ShmT0aETTaDyBddr0hWYg4a6xM0OYtJsAYa1VSgu7kE4jm002Xs7O8xBbkIFZSVV8vCY574O5LV47qniLlH5iS2XcR8PtKHQF+YujO4zmgSd6N31Xw5ctnDPx0ZbpM7x0sF7EVJ0TVH8nwIIYDige8kuPop4xKVuMbyu9JKGK+VgNrcBX5W0oWrPS1iWeBGbtK3lEvfXH1QS9NgRHJZQDFhnLg4/h8mWsKLXvPmitS73tkqxhxBGdm//2hifCrvLbB343pb1mZTeAW7NMW1KWd2TdfI5AaTO3j8nv8ZLRHL0MICn44k1C7xhavf2lKcrQTkZj02GXLfAc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4003.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(4326008)(66946007)(2906002)(6506007)(52116002)(66556008)(6666004)(66476007)(2616005)(508600001)(5660300002)(107886003)(86362001)(1076003)(8936002)(6486002)(186003)(6512007)(26005)(36756003)(316002)(83380400001)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8YvNsZ76UAWTwWhwKdqi9HKmYTrVoalNn2b9TVbYtiklqkjMkZbHjpwVki2g3hbg/gEfct2BzX/OtpkEZMu0yrW/h23daZQlIKJH0EWCMGM6kxUn4Nx/h04WBiI0AXZcK5g73/yPTu3Hp+uluDoP3uR9afNmuXTkZL/baIZByRPjiINkQCj5y/0fqkRxXPeNax+QAWiHfIIAYWMZj0d8nx73WVqLvWV5Er7PFvvkLlGeHOvYz7dkpzUPdv74bsHAYduzqvOE7gHYlG+LDde/WxFcG59ywwX+yVu5WCOBFNKMCGULNHvfcmDCdTE4xbUIS42EonaG3/5MNw+JZ8t3mqb7BbwYr3P487naTYmyjzDMcPPu+Q/2GME5l7Wj+cGXOtZiL1rTKiotJJrOsHuOJJXf7Gc1jcpNuCl9gWLHFPw=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 275c9f2c-9563-402f-e781-08da21055aff
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4003.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 06:33:31.3633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +pmkrF13/4rvMYPjdeNKgGz20eV9aw0wQ0BeZRtS7o79ynbV2iOgA5G0LfDxfEnPc7dykAMCfki8pok6bYmcyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3095
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Introduce blk_crypto_supported, Filesystems may use this to check wheather
storage device support inline encryption.

Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
---
 block/blk-crypto.c         | 6 +++++-
 include/linux/blk-crypto.h | 5 +++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index a496aaef85ba..bef0833f9621 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -363,7 +363,11 @@ bool blk_crypto_config_supported(struct request_queue *q,
 	return IS_ENABLED(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK) ||
 	       __blk_crypto_cfg_supported(q->crypto_profile, cfg);
 }
-
+bool blk_crypto_supported(struct request_queue *q)
+{
+	return IS_ENABLED(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK) ||
+	       q->crypto_profile;
+}
 /**
  * blk_crypto_start_using_key() - Start using a blk_crypto_key on a device
  * @key: A key to use on the device
diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
index 69b24fe92cbf..6806cef24d0f 100644
--- a/include/linux/blk-crypto.h
+++ b/include/linux/blk-crypto.h
@@ -103,6 +103,7 @@ int blk_crypto_evict_key(struct request_queue *q,
 bool blk_crypto_config_supported(struct request_queue *q,
 				 const struct blk_crypto_config *cfg);
 
+bool blk_crypto_supported(struct request_queue *q);
 #else /* CONFIG_BLK_INLINE_ENCRYPTION */
 
 static inline bool bio_has_crypt_ctx(struct bio *bio)
@@ -110,6 +111,10 @@ static inline bool bio_has_crypt_ctx(struct bio *bio)
 	return false;
 }
 
+static inline bool blk_crypto_supported(struct request_queue *q)
+{
+	return false;
+}
 #endif /* CONFIG_BLK_INLINE_ENCRYPTION */
 
 int __bio_crypt_clone(struct bio *dst, struct bio *src, gfp_t gfp_mask);
-- 
2.32.0

