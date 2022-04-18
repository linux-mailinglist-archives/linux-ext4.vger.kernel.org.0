Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A8F504CB4
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Apr 2022 08:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236809AbiDRGg3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Apr 2022 02:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236813AbiDRGgV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Apr 2022 02:36:21 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2109.outbound.protection.outlook.com [40.107.215.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB28519007;
        Sun, 17 Apr 2022 23:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKO7Ce/RYFyB88bpO0GkMaarYlkRYqPNY1RbhUPADi+z3XNmy6n2EXO1HtyvN8Gx5EldscXLYJsfa69FqjHdU5Wp38Iic0A2S4X+bnNBhPbA0O6ZMdfuCt5OJRspyA0a6PT+e+7GkXB3sHOdYgbrWJj55mbn0ausVmezKm6GznhEoIGqF3HFVURmzAzokMvG+8wa6dsoE5rKPlf2Y4xrvvNCnn4s2FHgdrpwvjg6N0dqqJ8j9TNtZReiEW95I220vjdFO8ZEsCphfuAJqJCD1j5XSLKTkgpH4S7NfuNu+3iGEAF+F4WuJIwQVqc6bclqUeoo/zem+q8s7C0oTgLlLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmPWqmtS7iPD3Gnh0idgaebWXHkUMfU5HptJ3FmgFUM=;
 b=V9QaefoHQk2JumAu51SnFIBDoBY1d14+yaKmf+sTTlYDial2zLYLRgQW3d1YiClag7089/5K2PhO8cRH2gED1fJFWXLvYDsQpOEKGsqz3AvJbtmuU93BzEkf0d8MINYwosOU6XarLuM3kxLGxXHg08vPxOup1+Kqh7ShdhCZMU8IUBJT7UkplgnVrxMxMdJZ3qOYhc6k30r6OHRwyc+wXvb0WyGLtlN3xbMmOUILpry9zaELScqyYd+JLNIS+Y4YEB8orEHaeyk6TzLizEbCShmlLh3T3RjrtSK6mCDxwGNgE0P/AmRe08Gqgs8BJGY6qNpwfn/kTuaezPo9cipk2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmPWqmtS7iPD3Gnh0idgaebWXHkUMfU5HptJ3FmgFUM=;
 b=C/L3WjGfxZn2hFp5DKUtWSHJnyuciZNTM/Yi6nrZZH8o0qAfDf7TDPoiJJ/kKBy6q7KjH4dWzJ/wNlXcpd6o/lEsYRHziajoPI/ubdBgTk66mUxBkhAEL7UKb/f4l2wHRV/E2ZwRU61kkyQIvbJ6/Zjp0Lq3yJp6v+c3upRflbQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4003.apcprd06.prod.outlook.com (2603:1096:820:26::6)
 by SG2PR06MB3095.apcprd06.prod.outlook.com (2603:1096:4:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 06:33:35 +0000
Received: from KL1PR0601MB4003.apcprd06.prod.outlook.com
 ([fe80::f0c7:9081:8b5a:7e7e]) by KL1PR0601MB4003.apcprd06.prod.outlook.com
 ([fe80::f0c7:9081:8b5a:7e7e%8]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 06:33:35 +0000
From:   Fengnan Chang <changfengnan@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, axboe@kernel.dk
Cc:     linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, Fengnan Chang <changfengnan@vivo.com>
Subject: [PATCH 3/3] ext4: notify when device not supprt inlinecrypt
Date:   Mon, 18 Apr 2022 14:33:12 +0800
Message-Id: <20220418063312.63181-3-changfengnan@vivo.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220418063312.63181-1-changfengnan@vivo.com>
References: <20220418063312.63181-1-changfengnan@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0068.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::32) To KL1PR0601MB4003.apcprd06.prod.outlook.com
 (2603:1096:820:26::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4762591-fc7f-4d43-6dfc-08da21055d66
X-MS-TrafficTypeDiagnostic: SG2PR06MB3095:EE_
X-Microsoft-Antispam-PRVS: <SG2PR06MB3095EE50EA3F4D13F789B000BBF39@SG2PR06MB3095.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sseW0M3Kk4hb3ypYTyW6FPA1nW5r4IyDTKKDa/H3YtlwXl+/DgIsJuo93+nBSumPbNip8pb01Ma4XdfoO5FWlYoGDN7tikcpfYJCP9IYfI0EiqxPTBG/opa4VZUHXAZMsXmUYmMUKypit5Wk32nJTm7WJeEisW/CbOz5P8+/Dimnt+2DKBIAntCjtx4f+mcoXVojLuM4iQGilHx76Yp7YLNTJr8o1YPkdeEaE273drt9RDJnQ6VzUBU9Kvqr4WuddSwx2iL8p45TIQMfSKQWshtFB5K5cPuMeWyVpW8hDkCg1rTaEv19klk+raR9lAjvQ03Pm6yLUJcE6Qc1iJ0Wt6bZgAKl3VfwqiEx06uSZkT99CPmGuUnEaznirn2d70PlBK3XYWzeA2KnJmpwRK73Fo86hRgwrVRnbi1VXwfQQK9QvBBkqT8CTCoGz6lz0rZ/BbAzjOFU6+hP3PjFLgc6cuR/3bEITRcsaHxO3bQHX6fraT76417xBySDGGMQR+USskx7Sm+7GzW6qiHamwrv/H6rhReMOT1EVMI1mu78BxPpYh67NjdMFBdfX8ReKwK166XVIIFovfAMGUMndQ0XFkFm8EMp5n3Xy9nB+dM1RYnAd7m2Mc+9/scFCXTmcw3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4003.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(4326008)(66946007)(2906002)(6506007)(52116002)(66556008)(6666004)(66476007)(2616005)(508600001)(5660300002)(107886003)(86362001)(1076003)(8936002)(6486002)(186003)(6512007)(26005)(36756003)(316002)(83380400001)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MXgTOAXw+GKgHjF8rbzXwyBdLuCfQjIdKEpnkbNFzB7BcqpdlZOuAur937EQVZDgCzZHAnYLcDYqR8qk2ZIMcPD5V+WNo7EznpAnBJ+oA0rjatP938pTc6SuArKhF8W4/igT/f/1pB4F/xpe4xikAlKdjMx/sU08XdghnrwnWWdjYpQo51X5IrBhHM4MWuPrfMrxw4FW4s/msHG+4jrxKSbWTp7AHR4VKT0wkSIgaaPiZbStdgin/SEXhCzA5+yX+W6b0GAfiKAP1bmTEvoHMjfLFmXPRvEd4WIVFhXoa1dL5JNVP/00G0T3RWUzxw3HQGIG/OaiVO4dW2I2G/acRoHBYUQId+22Vo2j5fgPsWz6DJZcHyK65an3GOR6JuVd/3lmX2GI5FNcWB9qcXeruSMyFx2ggxcPii0C6WH2asA=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4762591-fc7f-4d43-6dfc-08da21055d66
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4003.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 06:33:35.4549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UIrz7dDR7YMVwf7FqZ7P7Px9QO/ul1bzASoJ2B3EAeftllGgHaNV5//V5pxrwL6MT0lWNgoD/1hf04y70L+Tag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3095
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Notify when mount filesystem with -o inlinecrypt option, but the device
not support inlinecrypt.

Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
---
 fs/ext4/super.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 81749eaddf4c..f91454d3a877 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -48,6 +48,7 @@
 #include <linux/fsnotify.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/blk-crypto.h>
 
 #include "ext4.h"
 #include "ext4_extents.h"	/* Needed for trace points definition */
@@ -5466,6 +5467,17 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 				 "the device does not support discard");
 	}
 
+#ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
+	if (sb->s_flags & SB_INLINECRYPT) {
+		struct request_queue *q = bdev_get_queue(sb->s_bdev);
+
+		if (!blk_crypto_supported(q)) {
+			ext4_msg(sb, KERN_WARNING,
+			 "mounting with \"inlinecrypt\" option, but the device does not support inlinecrypt");
+			sb->s_flags &= ~SB_INLINECRYPT;
+		}
+	}
+#endif
+
 	if (es->s_error_count)
 		mod_timer(&sbi->s_err_report, jiffies + 300*HZ); /* 5 minutes */
 
-- 
2.32.0

