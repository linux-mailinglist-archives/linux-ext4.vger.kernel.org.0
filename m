Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8AB746B676
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Dec 2021 09:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhLGI7T (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Dec 2021 03:59:19 -0500
Received: from mail-eopbgr1300094.outbound.protection.outlook.com ([40.107.130.94]:42240
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231313AbhLGI7S (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 7 Dec 2021 03:59:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkUvTRemKQQk1V4iabXRMKtGEucQAvz9m1Df01t1w2CV19qdali9Omn2Y3r80NDCGGDjkgYHZK/OEBuXgSjL04z/Ad9O5/6IlJLtWWiSpIuXO88CLYsNSN6Q24U43Xrnf66XxYUEGHufGbvhzPv2Gzn0yDOib1FxoarijF+PH3aFOX/pVAEmOuQt/ADeSnFL4qps0SXSZ45eEbCFo/w50xD6lGmH68W5KMRvOTpPBxRRa4QSpZmmdUBIoCN1bmZ4sAa8IhxRHGwzJF6tXQhXkVkp2xyLA7Nx1AApkKt3WtNGd8p88rSjIcfLwuKxVB9eWwRPtCV4WRfM2zOXVLOPOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdwkWcI2cQ+tr+RP0eZKyuXUjLW/Xfoz3yT5kDEd/gc=;
 b=dZvdCiMXKY5+RtBq3DBrqocc+j0XCbhw04zh4mx4ZJ2W9GD3Pfue07qswrNI5XTvc7AV4gnwcsGiOjXqr/0chl6mHUzY1O1bqZFo6pqrwNu176n13Ubl1yY1wg3hb0pWvAEh74twQliMdxPVnYSJrjaQ4eTDoaY94q9IhPgrG/YDddgcVRv9BRiklBZm1BTAQnB4u6PHVeWWvViSaCOGeBmb/n00yCyLGBuQbn/pWLTv/eT0SJ3s5NN118dN/2WXTR0Ei91r6pYT/gmw0z+hu/aWDMddQrPRbBg4DiILeegyO3vPEOY+e6oUv7/Xru0gx6yMxq0+TDkRSovta3n0hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdwkWcI2cQ+tr+RP0eZKyuXUjLW/Xfoz3yT5kDEd/gc=;
 b=Ngku/zRqt/i+00kftXHoVdTERLK+MnsxUtG2sgd0/52lDa8C5QiJ7p9aZP9FT8fUrTGWszv9t6z0mG6g0aaL0n/jyzLHGvoOUr0mDOgPUwZ4WHv0COHfZpI0dMlsQKx/hkkzzWT0IINXDFzBZLM/mmdWqZM+sLshnqpbKyv1ysQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by HK0PR06MB3842.apcprd06.prod.outlook.com (2603:1096:203:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 08:55:44 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::8986:b885:90d7:5e61]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::8986:b885:90d7:5e61%3]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 08:55:43 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org (open list:EXT2 FILE SYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     kernel@vivo.com, Guo Zhengkui <guozhengkui@vivo.com>
Subject: [PATCH] fs: ext2: remove duplicate includes
Date:   Tue,  7 Dec 2021 16:55:24 +0800
Message-Id: <20211207085525.4390-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0039.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::8)
 To HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
MIME-Version: 1.0
Received: from guozhengkui.debian (203.90.234.87) by SG2P153CA0039.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::8) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 7 Dec 2021 08:55:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3446ca96-764d-456b-d3f6-08d9b95f5a05
X-MS-TrafficTypeDiagnostic: HK0PR06MB3842:EE_
X-Microsoft-Antispam-PRVS: <HK0PR06MB38425CBB387CDC8CBEC4C7BCC76E9@HK0PR06MB3842.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:177;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O7Lq/4sFPSRdfmmgcD52jen8wLeOZv4DRTP08b3sreWqofgKPYukzEdP4ksHeWIBP2qylVNvQKxgrNGO65XrH+I6lkOWPM+ejJN03+DLd0j8edYerZ9/HOSVetoUwCVF/C3SdFrt+eOISGwJfbiMPlN9bN5aIoB5nsZ1TYg/Zw678pQJWLuS0jODY8u+6D7svrlaGTXE97sydVYjiXIg6B93KGR+CsFug4OE+jsp8LRW3zZP/quKFrOfm1PlDVDLfNIv8p5QOF1W1Y6LrhLljp3cPMte55D1Eku3m4JpWpLT8L5J5z9X+xJDcrutm9Bwjnv7JjqTjabzpnfch/G08NtwZEuGPXd38D4y1DplhKBw4BHZSEWhzW0MZoWxTRlJ9TMc6MM7r/rV84H5YPeLeQQutwIsv8nSrInwLyVJgDyAbtaEGUNZ6TUzAJPNvmwA6SPcYtPerejPn+nsyUYwyDo+EeaoSJC5Z38ymG2mnSOcsBLtF01zFUk5inKSDj5BJI9woNGgGtYLhTNltWzSEbHUTVbeaW5MYM/LkoDvTUUmHQEO0S2AhgyV+xZ/SrU8vDqJZvUKLmnsP/gafaEDSyOs04gaHjj/5DVFCghT3DEKDQVKojZlhGz0lQ9ZPBv2FxRQY9l9z7RorFstk7rC8r/3bF7zfredtu9oCzKMqPtg+mYhNRmXb9m0XQ6KcRmLE3lOkGY2VQtZfZT53RbqoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(8676002)(83380400001)(5660300002)(8936002)(6506007)(36756003)(52116002)(38350700002)(38100700002)(86362001)(6666004)(4326008)(66476007)(66946007)(26005)(6512007)(186003)(107886003)(4744005)(1076003)(2616005)(956004)(66556008)(508600001)(316002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PoxmMxGA2HrOEvx6Dab25Zv3GBESo6KBDtNVxFsH3wVPEx79WXavfHZyNVe8?=
 =?us-ascii?Q?79qJLCsGh2/9Tfz9cGKtPfutQWtuxiYSRp4EMOqI7c748Ifbay/xeEK1Llp/?=
 =?us-ascii?Q?8l4xa3nTMu0Kj3LaDU/+Pwi73SPyOL4EJdL/OYCO4jW7YvSwKpMi/Q4jRJBw?=
 =?us-ascii?Q?r7rOU4bNEYjz1azeHh9rJbCUVfuecJggYT/JmjycJy0Vn3ms0p+LLsDnUNr8?=
 =?us-ascii?Q?9/mPfZ9l7do7kM0kqGRhlRAaSj6q3TBm6Ygokq42XMkPoaF37fTb97PjFAZH?=
 =?us-ascii?Q?A+X5LPqukYaDqZjJLitpjIoW6x8m5+UuSvWnPYi5daPNejXAqQw/vIN72aLI?=
 =?us-ascii?Q?jHvYpk0kt4L3Jr1YV8tU5nsWWThMKDeS+hvPSfr3W3yRoZ/HLU036P5m6Q6f?=
 =?us-ascii?Q?SaiJr8TSaWDspqcVUaWAjMhs9heTvVRGpd0TeuiBMPk9DKZ1HudOXczi6SIZ?=
 =?us-ascii?Q?KDbGEbOE0l76/hMUM28HZ8JX9W9pzd3kU3vhlmx3G055Cnhb43OVHo0eJqBR?=
 =?us-ascii?Q?gcNJgUn12QUwYZhHbAwRQrSAvIY8zwBpSVyzWSo8oCiyeWdt2GMIYrl5i1lt?=
 =?us-ascii?Q?F79GgUpWrZY1NRW5sto78xOnGWbqMGrUr6ZhAZL1xKDRoPNLu56vAnhpILAf?=
 =?us-ascii?Q?EBqrgXuqOnD89ygRxOtdDhgWH76SCiNY6AkAWry8nMjRiTnyEeoYWaYoFzgT?=
 =?us-ascii?Q?rkGCXZiqI6tenoSjJLN7li/KgnFCO5ASYInvK1L+atJaaGEtCHxYQki/0wyQ?=
 =?us-ascii?Q?fZnnP8dUdRuKpCxUYqxHj7GTgi3V5fPDOHGYYrLdqwuK+RDmtIFCe2DmWFf4?=
 =?us-ascii?Q?/ui6FKvPT6C8XFaC4BFhYjy2TJ3G5Ku1e53f6iG/c2wyMKq5D5P2d8bIh5qq?=
 =?us-ascii?Q?nrJkr4532aSvMWJugAD0sHi+79GeimhhigSxpPt8XjbsQfTsuxEf44TiskoX?=
 =?us-ascii?Q?onZpaNz7kj/JMHclkmij0rhwzIeoAf1AJMiE7RPTqRcVumBHpfrkz8HpkeSv?=
 =?us-ascii?Q?hd0l/YEvhKJlJ41EjCwG/xBxbhvT7ppiQTYKqU3W2eW5Y+JR3uJm9UhDONgt?=
 =?us-ascii?Q?kInbqAXokRqHwfu43OXLpFscRS+JbKQ8E3OJlxJHm6Wcqe1homtemz7Q9llo?=
 =?us-ascii?Q?a4pM6AGZpVwRcPwRBfVzzIhyQRMEE7ySuNOXxEnmUD6JwkyJN7jlZ3BXODVp?=
 =?us-ascii?Q?xag26MjMmDRBUuSA4X/54furslh01TJdHJFi9qStqhFpqglJLcmJB+ey1YFg?=
 =?us-ascii?Q?twTxWxc6W2LPnwpnHuj3rc0RkiSvFV0N+MRKqmdCwxdHrjLxGC7UbLvi+hWC?=
 =?us-ascii?Q?D7rlFnm0xmH1WXEE9q/1k6S6l1lovMJ2P/bbK4NjPk96zYVBBHklOIFS00Ht?=
 =?us-ascii?Q?LMQkxaEmw770Adwy+BUMRNTHgdcgctomwoM66Ji0rOPhh1aydlM/WWw9tkVA?=
 =?us-ascii?Q?Qt4nMvxIHcoLIov20Gm2SG0U54rhUBPEdsSws4kxJgcwMQpPtP0PpffPVw9x?=
 =?us-ascii?Q?7lNWp42R4Gs4E0OdRYP+9xxfMQo9NK1MxYdNACoaPBR9Kqc7U4Gm19aPrM1z?=
 =?us-ascii?Q?Y8st0IgjL0+wI7boHsoX5xjGdttjXExF2RZn4POfjIy3MLpt38g75kTErzPb?=
 =?us-ascii?Q?vQHaTEuMjc4RaIP8uLrdOHI=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3446ca96-764d-456b-d3f6-08d9b95f5a05
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 08:55:43.6436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CnovtAf0OyyR5lKfY7tklvzW6q0e35abBGuhY7uCVvvLQ/0VSWd7tMyzKE409kD58J1Z54t0sCJ9DhBVgW5sNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3842
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

remove a duplicate "#include <linux/dax.h>"

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 fs/ext2/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 602578b72d8c..da4c301b4305 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -29,21 +29,20 @@
 #include <linux/dax.h>
 #include <linux/blkdev.h>
 #include <linux/quotaops.h>
 #include <linux/writeback.h>
 #include <linux/buffer_head.h>
 #include <linux/mpage.h>
 #include <linux/fiemap.h>
 #include <linux/iomap.h>
 #include <linux/namei.h>
 #include <linux/uio.h>
-#include <linux/dax.h>
 #include "ext2.h"
 #include "acl.h"
 #include "xattr.h"
 
 static int __ext2_write_inode(struct inode *inode, int do_sync);
 
 /*
  * Test whether an inode is a fast symlink.
  */
 static inline int ext2_inode_is_fast_symlink(struct inode *inode)
-- 
2.20.1

