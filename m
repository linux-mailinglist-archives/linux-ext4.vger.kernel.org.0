Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C005F504CBF
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Apr 2022 08:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236799AbiDRGgY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Apr 2022 02:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236809AbiDRGgT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Apr 2022 02:36:19 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2109.outbound.protection.outlook.com [40.107.215.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95B319006;
        Sun, 17 Apr 2022 23:33:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dy2Nkf86T1xsbd/cEL4UjILNCXtIacA/Xa3BvUEn1lMbtxMlvbgnMM8x3GPFEnVwK1MQtN0y2Q+BrKAcsdlNzpJLjHxVe42ndNHBj71K2CbEZEoGU3BREVHQ6ghIy8rHToEELzBnC+jljC10/N32/OSBn1skccHXt/7BxXzQkpjZaT3/qfuVKKNYI+9WWfAYRq5OD/2a/kh04tnKPZYG6HnP4Dl4NRX7WvFHu3m0EQ23Rkz8tOONj40FCuV3yfLuJt7rZTNckeb6VvabCs3Wo5p9xIBbdykXtPuA8GOTONg7ipM/zQESKc7XWGx2K3/AKNatBL+cXDFk2uDvOq9wNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhdYI/9gYLCgCfVSx4z+o8d9/bPAdlvoI7l6YTNvx7I=;
 b=d38MA0ftHRb8C2lZOkqnT67BLmLZixnPglZILRxBPFa1zfET1pRsWR1OsAgjbpUV6IdNlDlxenxAklnb/0nUytDUBtDkLnfS57fxBIFAqTsKeYSvEeC/bTb/z9ek2W7CG6jpvb6yI4VN6I4b3AkUBVjYufuV1ZSHgjtreqegl0jSjAg26rbAAE1dUBwJYSUIdmBhHinuK5gEU+KjgZGUZzfJ4+Uwi2UX5WUdWH7U56bQxwm8gZ1VsVhOiWWaK5D7ozuYCD7Ez/g/TD5fJ5EGIQcYiDei4Cys4e+K1AeTBY2VSZDkmYGEBSRiJCJKhZ6ubZ0EXj5V3tQejukV0K//nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhdYI/9gYLCgCfVSx4z+o8d9/bPAdlvoI7l6YTNvx7I=;
 b=lOO637ScQ5NraBXj7zYXOeDy5IOxv6/hG3rKgYN6KJ2ychTd5vzq5KMB2yvhcsGYZtlTNq3WNiCrXZeDZErAOTeJ1gvigMpfq9theTT7IPZU1kwyDirJMklZtrl9FLagaHXiA++eWUSZI2VE4GcDxpR5cRK1L12D2u+xwdS4wic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4003.apcprd06.prod.outlook.com (2603:1096:820:26::6)
 by SG2PR06MB3095.apcprd06.prod.outlook.com (2603:1096:4:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 06:33:33 +0000
Received: from KL1PR0601MB4003.apcprd06.prod.outlook.com
 ([fe80::f0c7:9081:8b5a:7e7e]) by KL1PR0601MB4003.apcprd06.prod.outlook.com
 ([fe80::f0c7:9081:8b5a:7e7e%8]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 06:33:33 +0000
From:   Fengnan Chang <changfengnan@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, axboe@kernel.dk
Cc:     linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, Fengnan Chang <changfengnan@vivo.com>
Subject: [PATCH 2/3] f2fs: notify when device not supprt inlinecrypt
Date:   Mon, 18 Apr 2022 14:33:11 +0800
Message-Id: <20220418063312.63181-2-changfengnan@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: f7ae8274-cc36-42b5-6484-08da21055c35
X-MS-TrafficTypeDiagnostic: SG2PR06MB3095:EE_
X-Microsoft-Antispam-PRVS: <SG2PR06MB3095B2DA6690F2D6223A1645BBF39@SG2PR06MB3095.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hu/ZhkNqm+HBwwUO5zp4JgP8UGdO4QHco3wtjigTPMj3oc1yzWFpOUoSWyHUbBZWgFlRjJ8W4F0RBP+7/D23FMf/2LLK911YurP3hbkJN0eXskERdlAsMsUJHEtLhqagUIwTsuD2Cyxv+5VN78k2BhzPxU/TTzwu34RILh64/SzxuFui5EHPfiw0lZo1lQUslsRK2RkYA/8TGtxrwItxSdx3oc2doY2t0ZaNNiwI932+binSZCtyNKLijcG7sJhoEp3YimPD5bkwC3fk09wXGfFBqd1OTOdIhcNXyvSaORDCREU3e9FVJ+VL9huMQF7JglZyB52b9kW2wBMADlJCk6Igmqfy1YfrivxaHQHGq+vJU4xzGUzLtAgaRg+OeRNaerp1TQWg8wqcsYAztzQJor0Ea+jYKmmNsJNB3AKYnGbzSsDGZn2N6Y9rVxBCoQYd8adL+gnX9N5eaCjCvZY7gGDvJj4cwRw+sKhgR9HDXlwIp/iVwMSQcM7z8xqQqSKkNvkrx/o/fqnTkMlr+cTShGlMnnpPGRQKS9kWzwz4gRaddrfBVxBARlvTd4bplZUV+rqj3nWMHKC85WRO/NTHAchWa/y7GtKImlPiZKmSc/N0HSwY/lxrg55hfKYun1Ri
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4003.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(4326008)(66946007)(2906002)(6506007)(52116002)(66556008)(6666004)(66476007)(2616005)(508600001)(5660300002)(107886003)(86362001)(1076003)(8936002)(6486002)(186003)(6512007)(26005)(36756003)(316002)(83380400001)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: J8oDQzLinSzH34kT5ZZfzh/fKh65Sc0S97Tk74OLvLfb+iZQsQSRswsv1V8lMUsn1rvT+sLNVpvuwxgTKwKj+WlG7Je+zWYQx8dQm2uu/wpVSPZCdjMJpKQyLeT248+bn9I7B3OnMwDMa8nughkyrP49giYM21lJu/xkhe5wvKjJAhPLKlJo12+E3uUlU5YAPR+yX0G3tvGHHVLgCRDcz3utdVEnNy6hwiamCgEcCix+QKU1HcnSjOUbGKkUDaOMHLUUzzk2spvtxuuv3wV2SysCQrZAkuXGH1gmUrYifIn1oe213VlmadfLUOUfVH1rueVkXMyShgcueb4qk2fBpYDyE2UlAvEjbAFlnP/o08IbxVw2D8ZDM+MtB+rVWUBRBCx2OY/lZbfihNKVNUgmON2iqENkozSTsuxa31eb9T4=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ae8274-cc36-42b5-6484-08da21055c35
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4003.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 06:33:33.3933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmjQnIiSY6fHahzpF7EZobAqR5W0d2ng5187BYmwweQHOPXjQZPH/ygyei15LPM0Z23rQmhhTFGy+9OHz1ZqOQ==
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
 fs/f2fs/f2fs.h  | 18 ++++++++++++++++++
 fs/f2fs/super.c |  7 +++++++
 2 files changed, 25 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 38cbed0f544e..dc27a708c283 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -27,6 +27,7 @@
 
 #include <linux/fscrypt.h>
 #include <linux/fsverity.h>
+#include <linux/blk-crypto.h>
 
 struct pagevec;
 
@@ -4395,6 +4396,23 @@ static inline bool f2fs_realtime_discard_enable(struct f2fs_sb_info *sbi)
 					f2fs_hw_should_discard(sbi);
 }
 
+#ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
+static inline bool f2fs_hw_support_crypto(struct f2fs_sb_info *sbi)
+{
+	int i;
+
+	if (!f2fs_is_multi_device(sbi))
+		if (!blk_crypto_supported(bdev_get_queue(sbi->sb->s_bdev)))
+			return false;
+
+	for (i = 0; i < sbi->s_ndevs; i++)
+		if (!blk_crypto_supported(bdev_get_queue(FDEV(i).bdev)))
+			return false;
+
+	return true;
+}
+#endif
+
 static inline bool f2fs_hw_is_readonly(struct f2fs_sb_info *sbi)
 {
 	int i;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4368f90571bd..624d8791b82d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1275,6 +1275,13 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 	}
 #endif
 
+#ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
+	if ((sb->s_flags & SB_INLINECRYPT) && !f2fs_hw_support_crypto(sbi)) {
+		f2fs_info(sbi, "mounting with \"inlinecrypt\" option, but the device does not support inlinecrypt");
+		sb->s_flags &= ~SB_INLINECRYPT;
+	}
+#endif
+
 	if (F2FS_IO_SIZE_BITS(sbi) && !f2fs_lfs_mode(sbi)) {
 		f2fs_err(sbi, "Should set mode=lfs with %uKB-sized IO",
 			 F2FS_IO_SIZE_KB(sbi));
-- 
2.32.0

