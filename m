Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2024D2B01EC
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Nov 2020 10:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgKLJZN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Nov 2020 04:25:13 -0500
Received: from mail-dm6nam12on2075.outbound.protection.outlook.com ([40.107.243.75]:64096
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726158AbgKLJZM (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 12 Nov 2020 04:25:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DG/cjS4u0Jne2m4awm5nfTqRT3dVT/0Sb4Tr1O1czgcptUGhr2FvQRuIFQItqRR+iPxo1Xl+QleFaBu74LklajV1v13QCMw+1r3HuSkgRuhJcnxpscG39gk+vV/F0uX8JPLZ7dUNZJKSH/BYOSlvR8eBZkL3g6aD4A10D1cA1c2anAl08T3yo88fhAJpX/x+K548i8HSJFwXzo24NV7moOvalVVv9luR0db1AtEadGjxP3GwF7AC1fglKSHhwYSDd2qVQhpL4guPHES5vQm3+EQzdyahBoZcykZOH/qBKLcxN8DTTbrMXvwcCrB7DbQHdM8YQIdTs++xt8itMZcZ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktpTill6Y7CCdhYXMg+PhoXPpR2thiNndJbB0l2Aa1I=;
 b=VZv7gpFiBwsUoqe2vwNRqiQOfieWxYM2UWjd+pA6hhZenQEMEctpRwxmdke2CSnwp3GuOB8Q/aIy6xBmxt9NrufXppp+iUo1EJqdua6gip2u8R/+9GHEcflQ/+7lXol1w9jCwILH32Eyfis19rjDt12Zl2qAb+i5OX4+ONWW9Z7o0sJcbWbqKGcQyz+XO7+tRYHCkzQ9+R5XFzWRuSQ+XEahCHMuXfltSdmG6T1+oBLdOumKGkZTtXdWgBvx29S/P6A06ETNQT+vg7eoZodZ4QEnvo++HyJiX8SH/S9cQwt8jDmvVEiy+yuyQA3lA61OOmOtfizOLwSFJwbj+c6Dzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktpTill6Y7CCdhYXMg+PhoXPpR2thiNndJbB0l2Aa1I=;
 b=HAXpJMWnK0+Tz8ax5Cp4AqmpM0EtWuIWNsVBLNmbxryolb0F+hmaUnUTHZMTvxnyiZLxvwqj6ltol7Z+iFjBXQ9PiwovNO9K5dlH2fAKmoHneip0WB1CBL5bMJ3UjLmNA+38pKn2zMbf2HCbiSFuoPzoPgUiTQv4tCT//2K/3iU=
Authentication-Results: mit.edu; dkim=none (message not signed)
 header.d=none;mit.edu; dmarc=none action=none header.from=windriver.com;
Received: from BN7PR11MB2658.namprd11.prod.outlook.com (2603:10b6:406:ae::16)
 by BN7PR11MB2722.namprd11.prod.outlook.com (2603:10b6:406:b8::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Thu, 12 Nov
 2020 09:25:07 +0000
Received: from BN7PR11MB2658.namprd11.prod.outlook.com
 ([fe80::e187:114c:b6cc:b4c2]) by BN7PR11MB2658.namprd11.prod.outlook.com
 ([fe80::e187:114c:b6cc:b4c2%6]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 09:25:07 +0000
From:   Kang Wenlin <wenlin.kang@windriver.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: fix -Wstringop-truncation warnings
Date:   Thu, 12 Nov 2020 17:33:24 +0800
Message-Id: <20201112093324.8052-1-wenlin.kang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HKAPR03CA0019.apcprd03.prod.outlook.com
 (2603:1096:203:c9::6) To BN7PR11MB2658.namprd11.prod.outlook.com
 (2603:10b6:406:ae::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-wkang-d1.wrs.com (60.247.85.82) by HKAPR03CA0019.apcprd03.prod.outlook.com (2603:1096:203:c9::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.13 via Frontend Transport; Thu, 12 Nov 2020 09:25:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73bb01d1-5764-4737-ef0f-08d886ecd84a
X-MS-TrafficTypeDiagnostic: BN7PR11MB2722:
X-Microsoft-Antispam-PRVS: <BN7PR11MB27229BE1A6E13B611C07F050E1E70@BN7PR11MB2722.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:12;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JB8Uq4bOg271pA1hHwi0k3vxncsxJ5g5JO3y/oAe/2OZZDq1xMaGwsTs+jJPiRh4YnPENat3vPqtl6ToHMlc+MG8kVOLjT6Gbm5oG6cO6aROVIbJ1JPteKE3pdCiF71DrZToPrY6tQ8ezbfHXkgHkCexkcK+fPYJ5/EqrldIhUPeyi9mwQQAWotPibK4j9zG3EEAz8s7Eat5tfoTph3fRguOtVhbrrzdkpPfXSkOKMBD8ukaRzJzxQMtAkmDdXyntCzZF0/9EUOhylGguA59cn1nqdKnFsN4JpMW2pPKN8RZGOmaZC1qIxF8gBTExP8Z89SlVYjgGELWjHXHpqcwYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2658.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(39850400004)(136003)(396003)(8936002)(8676002)(2906002)(86362001)(1076003)(36756003)(16526019)(4326008)(6666004)(478600001)(6486002)(6512007)(66476007)(316002)(66556008)(26005)(186003)(5660300002)(2616005)(52116002)(956004)(66946007)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Zc6tGsh9V6t1bFswLk0GOuJ3sG2bve0z/P8Whbrju8UxEwy8S7oOJt7ajK8x+7/SoBi90KrXm0nlAb+ejpEerg5bKFV0IAR2INJg+6TN3tsgYS3Bc+ef/gxAw2wMozDOA0m9v1vMknfUKImZ2JLKeBrkhfmLBOuEgJ8DIMdmKa7713u65ayX7T1e4NaR88zFwZXyfTp4oRz/z70dO3aMwA9h0sauSM38XezT0F6QZW8l9+A1Hob59r7ZzJrXH1gwF63uqLYOtK4vxNOKtdVKqMtmuSV5s2ww+ZYdnOx2dX6a1F6gCcjzncIu3F6WbDgSNTk1BldsMnytI+tiR4zeYaXN5W4mYirlvO9rJI7HLuOV76MrPw85iABZVthb0G/IR0NnpRdIkcWRQ7+XrCDBM7FrxzPHyvyVxMgL5DkwfBcTEaaF9Ye6HDi7zsENg1yI4USqwsbETrz6oLg5yn9YFLVeaFw5cb8LKPSDKKb/VnglYKOC3Z+gJswS0mjC19j3lyxKIat9HWPaAT1PR629syJUCYW5PmVuXGjQs8JZvTTUCqc9PMiECJA5FKZfr0RLu9Agxv/Griyf0IhzU4IOBBtIys+yUZGUSp2bVtQo9ec0UaPOH+qlaC+y6KKIMRkOS0KQDzbSxH1oEv6R4KQw6rrWSUVq92Wx+Z/d+jdjMVYu6ayvJD8asbrIQqIvfnivi+4qfZRKK5ZNkVgS8NqotVcDv/oX1G4ff+W+sCE2NQEYSsv7dfpOmd2AQdpf4ba92xGLilHDJvk1/FXy+u4bAduOjg2WfEdqWdHsJ2eJiIAH53ApL6sryC1zp/OkZ6D4MhyfutEeZZCx6Zq2EbnSpkiRZEj+yX0uh0PRmLiMGqaZd+7MrRanco/eiX2C7YTsNFPSUHCyrTTiYZXcKrtlcA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73bb01d1-5764-4737-ef0f-08d886ecd84a
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2658.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2020 09:25:07.4327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M6jtnZMUmXcClXKJ+hmpsHf6/kVfGZl143ScLoJD2qKyVPxZip1bEL+V3sA8C44AxaG5svS82CScwIvOu9AnVnZHf1OUOd1PzwrZBQ1LssQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2722
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wenlin Kang <wenlin.kang@windriver.com>

The strncpy() function may create a unterminated string,
use strscpy_pad() instead.

This fixes the following warning:

fs/ext4/super.c: In function '__save_error_info':
fs/ext4/super.c:349:2: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
  strncpy(es->s_last_error_func, func, sizeof(es->s_last_error_func));
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fs/ext4/super.c:353:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
   strncpy(es->s_first_error_func, func,
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    sizeof(es->s_first_error_func));
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
---
 fs/ext4/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c3b864588a0b..3ade6e1f7a4d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -446,7 +446,7 @@ static void __save_error_info(struct super_block *sb, int error,
 		return;
 	es->s_state |= cpu_to_le16(EXT4_ERROR_FS);
 	ext4_update_tstamp(es, s_last_error_time);
-	strncpy(es->s_last_error_func, func, sizeof(es->s_last_error_func));
+	strscpy_pad(es->s_last_error_func, func, sizeof(es->s_last_error_func));
 	es->s_last_error_line = cpu_to_le32(line);
 	es->s_last_error_ino = cpu_to_le32(ino);
 	es->s_last_error_block = cpu_to_le64(block);
@@ -507,7 +507,7 @@ static void __save_error_info(struct super_block *sb, int error,
 	if (!es->s_first_error_time) {
 		es->s_first_error_time = es->s_last_error_time;
 		es->s_first_error_time_hi = es->s_last_error_time_hi;
-		strncpy(es->s_first_error_func, func,
+		strscpy_pad(es->s_first_error_func, func,
 			sizeof(es->s_first_error_func));
 		es->s_first_error_line = cpu_to_le32(line);
 		es->s_first_error_ino = es->s_last_error_ino;
-- 
2.17.1

