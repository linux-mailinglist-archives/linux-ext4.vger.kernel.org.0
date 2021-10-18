Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1236C431AB0
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Oct 2021 15:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhJRNZp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Oct 2021 09:25:45 -0400
Received: from mail-eopbgr1310138.outbound.protection.outlook.com ([40.107.131.138]:10976
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229519AbhJRNZo (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 18 Oct 2021 09:25:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBfqi+jW8V56MKCd60/LCHsxrkvQqOuZmnKLJNHGh/Rn2svJhamN/xaZ2VsUNPWF6iZGdgaGQMYpAYKzzKH0B1Uxs/sdJFzfYIvb35yX5k7kJGM791C4JikQWB88cvD4C9btsq/dG/kJNMbRTwdO7xNtRZWaLjzlhz9fujZELSMrRGwtHPhfMEP2qe0W6VTHdd8+i2qJb70tqCuQao4ZfuXgfyDBvCfdr+8MVW9nOPiXBtO+tf+++i5kxQzkb8Q3WNfRuSJhF8Ff/RBauwiyliwyzKcT/N6P2I60PXxTsHQcgPTITlLkfDdMKKnE/jBdkd+ImQaY7W8OXnuscCNnNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64/BOLIWFoLD5VDVt+JbI0+cyngDGXsO4d5qdfgEZCc=;
 b=IVxjcvBHF8ws+69U4BOCbSukAwxUVCDj4HuGrNTC2Z5Gwc5ACslK8niZsPzeczfa/cviILIUv1JVcs6HJPJF6ynqB0qlgOxY/rTFoocUo6b9Sd9AP2kTn860ZcWv/ce1bmDF3wAVUGOrT6nO9xlMmLXmRSonqtyRFw2bDT1tzNi6r+3rVsudgYfQfWHQZxqxL86YhAS7fHSORs1GMY1g/1gs0YZegax16bYVfGkNwTWUgXEQcjiA3Lj4aifQA1u5+C9ZA/eHo4mISwncdXjqKhNM+o3n4xagwRcDYFnqicXmqKoik+Gk84tPc+G4G7tBzXVJbCwJfbmnedDNN9Z00A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64/BOLIWFoLD5VDVt+JbI0+cyngDGXsO4d5qdfgEZCc=;
 b=LoQSj7olrpr80BBZpxabKYWxISQ1jNbmlD2tJ29knHnrYFvEEjLPbt6OuKJwOyHRigEYHTq18tpWTd7AjfQiYiN+jpssfCzJNZIWIbccUQ9B7orBAtYwDaExrZbIK7hAywD0aT6hKKGENQGg1CkqnvglKid1DGXjI7V7kdeQiic=
Authentication-Results: mit.edu; dkim=none (message not signed)
 header.d=none;mit.edu; dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4021.apcprd06.prod.outlook.com (2603:1096:301:37::11)
 by PSAPR06MB3960.apcprd06.prod.outlook.com (2603:1096:301:3a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Mon, 18 Oct
 2021 13:23:30 +0000
Received: from PSAPR06MB4021.apcprd06.prod.outlook.com
 ([fe80::395a:f2d7:d67f:b385]) by PSAPR06MB4021.apcprd06.prod.outlook.com
 ([fe80::395a:f2d7:d67f:b385%5]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 13:23:30 +0000
From:   Bernard Zhao <bernard@vivo.com>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] =?UTF-8?q?fs/ext4=EF=BC=9Abug=20fix=20of=20memory=20leak?= =?UTF-8?q?=20in=20ext4=5Fmb=5Fpa=5Falloc?=
Date:   Mon, 18 Oct 2021 06:23:15 -0700
Message-Id: <20211018132319.45350-1-bernard@vivo.com>
X-Mailer: git-send-email 2.33.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR02CA0195.apcprd02.prod.outlook.com
 (2603:1096:201:21::31) To PSAPR06MB4021.apcprd06.prod.outlook.com
 (2603:1096:301:37::11)
MIME-Version: 1.0
Received: from ubuntu.localdomain (203.90.234.87) by HK2PR02CA0195.apcprd02.prod.outlook.com (2603:1096:201:21::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4608.16 via Frontend Transport; Mon, 18 Oct 2021 13:23:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f42702a-5144-4162-bcfa-08d9923a79ab
X-MS-TrafficTypeDiagnostic: PSAPR06MB3960:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PSAPR06MB39600386230E367530BAE28CDFBC9@PSAPR06MB3960.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M4/wV9xxL7yNlPR09ABTjLeP1FJ9AafMLkvy9TZw5uZEMFPuL0qZwOoC38QN4QkZ+L4FKHH0cDk5V4ZqgN2xabhmgEznnm5Wweial5RminewRBn8qkdVhFD528ixxmKnhYjXKApEpeCvXRIdS1wJVbCgEWrjqTo/rxeYzXec3jWuNWb721F/+7alHWRwTwHB7ggjTteed5KVwn2Zi6NIgDJ0TFbmjNsWVW13Pd5OZsXaoOgNH6VPtv3xm/DUx8VqAqFtqIX7aj2wqtksH6WH2sehDqjJXNJ+PZHfezM+RAJairnLPs4ZbXhq6lq4ZoSHP++krzQRZTjjAgcf6DSJUGG42bJOiGrRLeDVYLO+8fFEXgrZ2w+xOQ0cS/MAcVITOCHoBJQ/T9knbDtJRjzgsDL4FLQPhNKyneLzMPGPGzCM6JopNxL95gUmVHZmpUc8Yb4e74XLN2m0qWcKSiiuc/bTd/YNOZklHiN3jpxVTq6i5+adJzXAJQWR/BS6yaKM2IezSEBeKZzIQbNiGbYpsL8Y/SrhccY6rtfFR1cpsrcrGBtKFOfT97QzpDsxAPi0xd5nFPjNGE/6OAZ4qaGXfIJSGgjc+6cyWQuMV0z7b74+U3OTCLhS4XXgHM854a2qPFH9e6z9Gt4/se671JdL6FdLi1mOpZgN3pxxa7Vg+c/L+Wo9GPvUy2PikiE+yfyUGdBN8ChDQCQmn3PjnElNfL3IFHo9uBLYxaUVlaam8sJ6fXN0KzNWHbf4jdmka22ypqnuIXx9dx24nD1jf7/RdUwMGjKXQGjUdE0RpN4G5tI4Fh2oNvnMCNrAYuQFA+ke
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4021.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(66476007)(66556008)(2906002)(38350700002)(38100700002)(186003)(6486002)(52116002)(83380400001)(2616005)(956004)(6512007)(508600001)(26005)(66946007)(36756003)(5660300002)(1076003)(4326008)(86362001)(6666004)(107886003)(966005)(8936002)(316002)(110136005)(99710200001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HPoNfz6J9alIi7jN/xKoMl32a63Td/MJ9XSef3JwSrYDolz10z9BlyWm0hZAfI7P4/8Ael3OXdhUZc5A0AnGIVEO0SsD1QbeNIyNrUOQBEX76dk9oRRy098AoKW5MP3H1azzE/jRm6PUEwJqKDwWTEch52ET7a/WQYtb5dt7Ynxa9sOb3Qlk6YJip9gilXwrwrnWlCks1LjZdHyZOp1JkFcVovnLUN9IccYpJskFU0Pd1teJbAOakP13CYEQ28TMY8Wm1rYeF5t0HoNBJdKGvHdCRdxXW0rlirJz7ged7btVtyMYRRpSGgAfe+xFy83VQhtQFU4LIWuj/r/JkKgvzV1/mqaw5KnEnyFQPLef/Jx2K4YrNnRp5zqurNPcoDwODTxb8KpgGzAom1DJSHlhWqDudWOCfGb8h4R9sf7trVOYeGEYP/66kG6eLIo0I+LqGa1f7INu++Vf9SR9B565biQoAVL/sSBV8rqh5y2Num0/In9FTC0RVSSWYmfaXJNHUtTyflNFZ9jGCO80+vK45EDfypCMNNNM5kSdFS4w7cL3z74YTL35cooc49SdAFWhXw3lsYuQ1+n7esKwnCJwTqmgYAz3EbtHa1U2C/oisalT1X8X2opRWN6a2fhqt2+dV6EEDwAuY9K6RnGP9VjmBYZjxDVrr7AYUtvCTUcNlnPqaiW+lVGiKR8pD2g1p9Fxb6oC5WtqUbgFpbz8f3Aw/Q==
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f42702a-5144-4162-bcfa-08d9923a79ab
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4021.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 13:23:29.8902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AlS+yW/wIBuY/j2L/9Y6ESZscm7v8aL6cZvDCxR+a9rw6YilQ0VM3rTZCg36lZK5Z2RW3I0fl3QtyxhA9JZ3zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB3960
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch try to fix bug reported by syzkaller:
BUG: memory leak
unreferenced object 0xffff888112a84a28 (size 104):
  comm "kworker/u4:3", pid 948, jiffies 4294943272 (age 473.370s)
  hex dump (first 32 bytes):
    c0 53 8a 12 81 88 ff ff 22 01 00 00 00 00 ad de  .S......".......
    00 01 00 00 00 00 ad de 22 01 00 00 00 00 ad de  ........".......
  backtrace:
    [<ffffffff817773cb>] kmem_cache_zalloc include/linux/slab.h:711 [inline]
    [<ffffffff817773cb>] ext4_mb_pa_alloc fs/ext4/mballoc.c:5046 [inline]
    [<ffffffff817773cb>] ext4_mb_new_blocks+0xd5b/0x18b0 fs/ext4/mballoc.c:5581
    [<ffffffff81731d2d>] ext4_ext_map_blocks+0xdfd/0x2940 fs/ext4/extents.c:4250
    [<ffffffff81754a03>] ext4_map_blocks+0x333/0xb10 fs/ext4/inode.c:637
    [<ffffffff8175c22b>] mpage_map_one_extent fs/ext4/inode.c:2393 [inline]
    [<ffffffff8175c22b>] mpage_map_and_submit_extent fs/ext4/inode.c:2446 [inline]
    [<ffffffff8175c22b>] ext4_writepages+0xc8b/0x19c0 fs/ext4/inode.c:2798
    [<ffffffff8145d19a>] do_writepages+0xfa/0x2a0 mm/page-writeback.c:2364
    [<ffffffff815cbdbe>] __writeback_single_inode+0x6e/0x520 fs/fs-writeback.c:1616
    [<ffffffff815cc924>] writeback_sb_inodes+0x2d4/0x710 fs/fs-writeback.c:1881
    [<ffffffff815ccdbb>] __writeback_inodes_wb+0x5b/0x150 fs/fs-writeback.c:1950
    [<ffffffff815cd2af>] wb_writeback+0x3ff/0x470 fs/fs-writeback.c:2055
    [<ffffffff815ced0a>] wb_check_old_data_flush fs/fs-writeback.c:2155 [inline]
    [<ffffffff815ced0a>] wb_do_writeback fs/fs-writeback.c:2208 [inline]
    [<ffffffff815ced0a>] wb_workfn+0x3fa/0x760 fs/fs-writeback.c:2237
    [<ffffffff81265d0f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81266619>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126fb18>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff888112a84a90 (size 104):
  comm "kworker/u4:3", pid 948, jiffies 4294943272 (age 473.370s)
  hex dump (first 32 bytes):
    98 98 8a 12 81 88 ff ff 22 01 00 00 00 00 ad de  ........".......
    00 01 00 00 00 00 ad de 22 01 00 00 00 00 ad de  ........".......
  backtrace:
    [<ffffffff817773cb>] kmem_cache_zalloc include/linux/slab.h:711 [inline]
    [<ffffffff817773cb>] ext4_mb_pa_alloc fs/ext4/mballoc.c:5046 [inline]
    [<ffffffff817773cb>] ext4_mb_new_blocks+0xd5b/0x18b0 fs/ext4/mballoc.c:5581
    [<ffffffff81731d2d>] ext4_ext_map_blocks+0xdfd/0x2940 fs/ext4/extents.c:4250
    [<ffffffff81754a03>] ext4_map_blocks+0x333/0xb10 fs/ext4/inode.c:637
    [<ffffffff8175c22b>] mpage_map_one_extent fs/ext4/inode.c:2393 [inline]
    [<ffffffff8175c22b>] mpage_map_and_submit_extent fs/ext4/inode.c:2446 [inline]
    [<ffffffff8175c22b>] ext4_writepages+0xc8b/0x19c0 fs/ext4/inode.c:2798
    [<ffffffff8145d19a>] do_writepages+0xfa/0x2a0 mm/page-writeback.c:2364
    [<ffffffff815cbdbe>] __writeback_single_inode+0x6e/0x520 fs/fs-writeback.c:1616
    [<ffffffff815cc924>] writeback_sb_inodes+0x2d4/0x710 fs/fs-writeback.c:1881
    [<ffffffff815ccdbb>] __writeback_inodes_wb+0x5b/0x150 fs/fs-writeback.c:1950
    [<ffffffff815cd2af>] wb_writeback+0x3ff/0x470 fs/fs-writeback.c:2055
    [<ffffffff815ced0a>] wb_check_old_data_flush fs/fs-writeback.c:2155 [inline]
    [<ffffffff815ced0a>] wb_do_writeback fs/fs-writeback.c:2208 [inline]
    [<ffffffff815ced0a>] wb_workfn+0x3fa/0x760 fs/fs-writeback.c:2237
    [<ffffffff81265d0f>] process_one_work+0x2cf/0x620 kernel/workqueue.c:2297
    [<ffffffff81266619>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2444
    [<ffffffff8126fb18>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

The full link:
https://syzkaller.appspot.com/bug?id=6b3fa085566c7c8c64e32a6747c0a2b2c039e364

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 fs/ext4/mballoc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 72bfac2d6dce..e767aacebdf0 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5439,6 +5439,7 @@ static int ext4_mb_release_context(struct ext4_allocation_context *ac)
 		}
 
 		ext4_mb_put_pa(ac, ac->ac_sb, pa);
+		ext4_mb_pa_free(ac);
 	}
 	if (ac->ac_bitmap_page)
 		put_page(ac->ac_bitmap_page);
-- 
2.31.0

