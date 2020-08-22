Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68C724E660
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Aug 2020 10:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgHVIWp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 22 Aug 2020 04:22:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10308 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725932AbgHVIWo (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 22 Aug 2020 04:22:44 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EB7925A3A5E0FE7057B7;
        Sat, 22 Aug 2020 16:22:42 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Sat, 22 Aug 2020
 16:22:31 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <jack@suse.com>, <tytso@mit.edu>, <linux-ext4@vger.kernel.org>,
        <yebin10@huawei.com>
Subject: [PATCH 1/2] ext4: Add comment to BUFFER_FLAGS_DISCARD for search code
Date:   Sat, 22 Aug 2020 16:22:17 +0800
Message-ID: <20200822082218.2228697-2-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200822082218.2228697-1-yebin10@huawei.com>
References: <20200822082218.2228697-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When we analyze the problem, we find that in the discard_buffer will
implicitly clear some bits, which bothered us for a while. Add notes
to comment so that we can't miss them when analyzing the code.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/buffer.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index c1501a3c5ebe..d05b94cc48c0 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1496,7 +1496,13 @@ EXPORT_SYMBOL(set_bh_page);
  * Called when truncating a buffer on a page completely.
  */
 
-/* Bits that are cleared during an invalidate */
+/* Bits that are cleared during an invalidate
+ * clear_buffer_mapped
+ * clear_buffer_req
+ * clear_buffer_new
+ * clear_buffer_delay
+ * clear_buffer_unwritten
+*/
 #define BUFFER_FLAGS_DISCARD \
 	(1 << BH_Mapped | 1 << BH_New | 1 << BH_Req | \
 	 1 << BH_Delay | 1 << BH_Unwritten)
-- 
2.25.4

