Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1528846B68F
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Dec 2021 10:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbhLGJIX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Dec 2021 04:08:23 -0500
Received: from mail-sgaapc01on2138.outbound.protection.outlook.com ([40.107.215.138]:65377
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229714AbhLGJIW (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 7 Dec 2021 04:08:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjSGV9tdeQvp9fzFpkiFaivWE6wOnE7/bDsj4io1adZCSRe+9xGcNbx11dU9VLEA2cLUCOd8j+E5sJawJgxVCj+yDGrZBRABldYoed/9ODG/KIFi4VYEEB+YTq8NA9ByeB4wIZR2lYmqp2/Nrjlz3+8tw08Jto62G9aoajFZCAUn38K+Qa7GELMkxd0bNCc+BIjipJpuEzqKTnqpq9OcAehVLkszB978aCFsv4/bDQn8wL7u0LWAhU8CLCHihjt0ejmQR4e2wuAWnJncjXYwsi4np0Z4gFjGuDRpkoUNlzZSACX59r7wvk1v6Q7Bj/lYQt6tkSVuhYzi2uUrssDlGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUX5w9+IyXxt3H+RepVrkg7zaL/sAo4jfq94Iy8Jmhc=;
 b=JeaglNcdnqB6CqX2lrOfs+3lHMpGV1oK0G+7iH7xbcyUXFGYK4pZX+kZDFy65Qnpqpw4iexVeKvwpM/0M639sklo/Xo8yS++jWHKT1ergemXtAxaEw61ShsLHtX4Gzts6s7QhTQdNCSCbaxxVg2BcpP0Gc4A485Mc0Qtq7OLB0Nxd4+BeYAPMWgjrKC33vw2I60G04rOZAdivgJMmD4qsQ7I+KJa9UH4vURAaVZH1aFM9y5egP9FqZXLLFRlTwvor1eiq78meXOvAZGZmmJ+bvNmvmmrxpQG1+fzlTkg57CuPWcL53GG7ni/no+A9giirToTWV9+F4D3/Ko80lWFZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUX5w9+IyXxt3H+RepVrkg7zaL/sAo4jfq94Iy8Jmhc=;
 b=ZxspoWp6Wwa2vNgYQtsNw7G1tAdTvYXALk7Po+vE8lvyVdGkiyQUFLn3CkapWUxPxqWvM0KQJpTkl5YKfhQmp9zKR5MbNs8AYD9GUzYQJmBqOS6Z5Q+fvXLVX/KqIfXmeig/2o4KrSvt5n+MCNRhvThbI84Dgn7wmhZhCCLXt/A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by HK2PR0601MB2035.apcprd06.prod.outlook.com (2603:1096:202:e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Tue, 7 Dec
 2021 09:04:46 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::8986:b885:90d7:5e61]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::8986:b885:90d7:5e61%3]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 09:04:46 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org (open list:EXT4 FILE SYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     kernel@vivo.com, Guo Zhengkui <guozhengkui@vivo.com>
Subject: [PATCH] fs: ext4: remove duplicate includes
Date:   Tue,  7 Dec 2021 17:04:30 +0800
Message-Id: <20211207090430.4612-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0156.apcprd02.prod.outlook.com
 (2603:1096:201:1f::16) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
Received: from guozhengkui.debian (218.213.202.190) by HK2PR02CA0156.apcprd02.prod.outlook.com (2603:1096:201:1f::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Tue, 7 Dec 2021 09:04:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 051f8e1c-837f-4bda-8f2a-08d9b9609d6e
X-MS-TrafficTypeDiagnostic: HK2PR0601MB2035:EE_
X-Microsoft-Antispam-PRVS: <HK2PR0601MB2035FFEABD9952F33FBCD06DC76E9@HK2PR0601MB2035.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:155;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 12QXVa/VaC84A01iUTRVM4c5iGe/O5FMTZ6ue7pxrEpo+h3VahmgNSLdVyuaS3RaKIXwS20me2cFkJZTHaCosQ3OSrm2XkdtBH2A82RIbIeKUb1+pZLh+N87Em22I7RRxuSccML0D+UJ1JTEtyjU4K+9g3jt7TbHhz7N6L5O2GeYWgC/YmKdweZpM0qlTZUY7rwOhPO2OrVUIAy0e9Q8GCzriicT2X9fM6QEkwHTLyBfnzjpk/nsTBK28A5nU9lVuutjcPaGaBCt2jpAu4A+MIYquU9lzUX2pHg8svFxbq7zxOq6JE/2cgoa84H9HDXekbuLIbP7lDgsCd8V2qDZc40fkIexdzwne/lUkEfXM79aK2h1bLkufKS4gi8yTKOKeiJt3WLlI2jyPrqrwQzhvBI+YGksgmPYoiedSOZnuxhFSVzlZvKTAQENjLUqqAIfI7EgawRz7V98YBhK1PG8jpiDGxZusYtFH3wnbvWb4Rudy5+LxtrsUB7Yw1V+sVAvCw99MHF8vyQcKu6URELsMNzrDePO5g661uTQ+KFfTGHk7mYdE6/o8E+NGDCYi5Y/nOceqy8ASJ35D7nH3RvT335pnSPRIQfLvAL+W2l2S8HsB3CCxNqlxvD1knwv60C1bQ/r0RsxNB0Z61UNr6rymzL4B1N9cJ3JfRquMYvD22/jLQGBd297de9Wg2IT1MK2ptVyS58RmffOqOLWh9rIBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(8676002)(956004)(8936002)(38350700002)(36756003)(6512007)(38100700002)(5660300002)(110136005)(316002)(107886003)(4326008)(52116002)(2616005)(186003)(26005)(508600001)(6666004)(6486002)(6506007)(66476007)(83380400001)(86362001)(66946007)(2906002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qH5ShFPQNkjCppm+fyHVsdm38EwTpHfzxWh9ryces+eObXmrqVuHEDFPnAuJ?=
 =?us-ascii?Q?jv4VAgomJJ9muBJEndyJULZ6fD4qJ6uL2ki7Lery5bL5ImArCKgOT9Lrkw+G?=
 =?us-ascii?Q?H7TFOx1Hmg6PD1Czx6mgOZqi1RrVsrGc/WNqUVhSoPJVZLZ/H9NLjlUz3rJS?=
 =?us-ascii?Q?egIZqoRl1PEH/ADHdkcUgUlusfdgDi9dSCGvCZoDSp+krWEo1tjNJOaCuSKo?=
 =?us-ascii?Q?92lkM3kakYNn0zKoxKKmCbim0ew8m8dPLwDbwmq0QzkF2cfTi7wMh7uO4vxU?=
 =?us-ascii?Q?9CHDKy62UjUj6Cv25+SUvJXDIBcuRUNFN4O7Z0kySu6/MOKpmh2cdfJ5rSCS?=
 =?us-ascii?Q?mm30FBMmvw036dKMFYJAqEstIojPlC0gbEfD3rneCSNICP8bMfMpGw0VcN0K?=
 =?us-ascii?Q?5TJrxS3NXgYMzF2ZuT5EJ4RUrZofJZwcRmLngYEa3Z/ezXOFWESotf+KcE74?=
 =?us-ascii?Q?CfiHeQGFY+o0uuWJKJOIkMIzwr5xnSeeQSxDyTgEUFgvI5gBL0i70EwOyZF4?=
 =?us-ascii?Q?UOL94uZvCSmq318XXvcsqAeh03KPOTUSMlEYHuHIr6GbilK6Nm4iTC2i2FH/?=
 =?us-ascii?Q?oSSFjk5HS+ivLh6eqYpfbJjaaupIYSqJNO8wYaCJVLcO/f0puVVqsvCsO/cK?=
 =?us-ascii?Q?WDZLWYNrP6Od6Ntu0d4AcoY8HabA9VFguy9xhH+0Z90/qQAeakun0RNaigWr?=
 =?us-ascii?Q?FkwLahqB9qjwI+Rs7gaee5YQ/NnRMM1YjVgLRrsfQp6DqTJAH/4Oo35S++zb?=
 =?us-ascii?Q?tR2z5chTvao2uWn7lUiF2m7OhkCqck154LcRCVWsp1hAaTeUZzed7/Z7mnhY?=
 =?us-ascii?Q?OXOX08pjnJDA+gGhMmgmbZMpAf1Rro01oAE1lVhzirLlOiWEBjwygCUsy0dq?=
 =?us-ascii?Q?EZb4ylW62bI7yd4ikfsMB8jjH1foKdv0BY4iIcShpkwKDJJ8ufh5KdlJKgLj?=
 =?us-ascii?Q?uio9gx/bff4rErnluMDQoYxlsyB1D7La5tY1BY4CxuebdfMAYZGPNvdleFU2?=
 =?us-ascii?Q?k7L3Tq2RupGvQrCDBEGQ1ZSswpRkE5XreK+z5OMH5q1NYtRma/7nSOPIrN65?=
 =?us-ascii?Q?tddDGRxnb32VIuZJMHFdMG0v+mTMYwU0NUGTxCDdbCnZLY6E6yC87jVMpEco?=
 =?us-ascii?Q?ufVRzE9cM7RF6Ku/yvF3RqGnEcyD0Ij0b5hsjqeEB2uRkptfKVNc3C3Btq/e?=
 =?us-ascii?Q?dhpbnpLtP8KKHUx0hWg1NuQC8ESR24UoRCLWnUGHPu30ylizeXbal/ksDEnP?=
 =?us-ascii?Q?UWgX88cJhM77K+gOUZ4RHk9oGvdkoUdCKHKeacBQcPWRXgZX8aXCwKceGMq2?=
 =?us-ascii?Q?SgHJkoHJxid58s3qmu7wRi4e9ndHxX1PQCCA8pNeHN1qez+JbvpJ1mkAq2g0?=
 =?us-ascii?Q?H+JDmbmzbE4ozVhhinHGE9b9PWX+lgKoiEkWjlNvq2L1+0xusWL4CPHdKKQy?=
 =?us-ascii?Q?OHoZ5mk9tAvIpHgb+FGWxo8jhIrrP/vcMcCcRyhvL1ubPpmEms8G6uPP4e9t?=
 =?us-ascii?Q?IRBkbQ4x1FRJBMClhnOA2Bk0mPLfOaRf3AAO/mjW38N99NLlTFbBsEKw4tQZ?=
 =?us-ascii?Q?6h9Ld3RJUVTB7+jIz/sX8eT7FAkgCQbOJvPkw44cm53o6SCsS8sQrOD6fsTE?=
 =?us-ascii?Q?+N6dIXdlNoxSRWK93heINHI=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 051f8e1c-837f-4bda-8f2a-08d9b9609d6e
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 09:04:46.0622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n7NsXKeYQEXoRar1tpgZvxxtJis17AJQU+xmjU4nsqmhgZy3FzwVs3zuk+il+4mKmDdMuYEN4TremPtsZ5BlAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR0601MB2035
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

remove a duplicate "#include <linux/dax.h>".

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 fs/ext4/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ccafcbc146d3..973ea307041a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -27,35 +27,34 @@
 #include <linux/dax.h>
 #include <linux/quotaops.h>
 #include <linux/string.h>
 #include <linux/buffer_head.h>
 #include <linux/writeback.h>
 #include <linux/pagevec.h>
 #include <linux/mpage.h>
 #include <linux/namei.h>
 #include <linux/uio.h>
 #include <linux/bio.h>
 #include <linux/workqueue.h>
 #include <linux/kernel.h>
 #include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/bitops.h>
 #include <linux/iomap.h>
 #include <linux/iversion.h>
-#include <linux/dax.h>
 
 #include "ext4_jbd2.h"
 #include "xattr.h"
 #include "acl.h"
 #include "truncate.h"
 
 #include <trace/events/ext4.h>
 
 static __u32 ext4_inode_csum(struct inode *inode, struct ext4_inode *raw,
 			      struct ext4_inode_info *ei)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	__u32 csum;
 	__u16 dummy_csum = 0;
 	int offset = offsetof(struct ext4_inode, i_checksum_lo);
 	unsigned int csum_size = sizeof(dummy_csum);
 
-- 
2.20.1

