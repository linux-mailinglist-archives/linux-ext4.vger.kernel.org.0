Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4281834A3
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Mar 2020 16:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgCLPUZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Mar 2020 11:20:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38752 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbgCLPUX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Mar 2020 11:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mZJm55P2eEYhCMiFZYeq28BA1dMXbfVsRxzSlsg0Hy0=; b=iUlu01/AIbiH7ScJ3Ieug/1gBB
        4x3foTUscQo3npa6fDD/bDmUQa4yg03S7FIqgh+5VypwxcBdkQ1f3iC/fCQkAspc5br0aqOtic/Nr
        m9YJGokk4J2s1yvUhADkouYuD/o84BdDn6b3UG5hX/HlocPIuUpjhtsO+uqKhlbMjLmJxR/ud+hu6
        BmuAl4sgAV1SsnmEItva+rY321pXBc2o+QGkaocz5Y722OmEgLITHgD6+RAdJyNqN7nB+0E7rEekt
        HmOegc7CVZalkN52+4e2azcRyd0Z7t2sKtKqqb5rbUKSXCNL+4JtBvwWhW+oXmWStUzI4uC7TknfL
        yemkDr6w==;
Received: from [2001:4bb8:184:5cad:8026:d98c:a056:3e33] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCPdG-0007vX-Rd; Thu, 12 Mar 2020 15:20:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-ext4@vger.kernel.org,
        reiserfs-devel@vger.kernel.org
Subject: [PATCH 14/21] block: remove block/partitions/osf.h
Date:   Thu, 12 Mar 2020 16:19:32 +0100
Message-Id: <20200312151939.645254-15-hch@lst.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200312151939.645254-1-hch@lst.de>
References: <20200312151939.645254-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Just move the single define to block/partitions/osf.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/osf.c | 2 +-
 block/partitions/osf.h | 7 -------
 2 files changed, 1 insertion(+), 8 deletions(-)
 delete mode 100644 block/partitions/osf.h

diff --git a/block/partitions/osf.c b/block/partitions/osf.c
index 4b873973d6c0..84560d0765ed 100644
--- a/block/partitions/osf.c
+++ b/block/partitions/osf.c
@@ -9,9 +9,9 @@
  */
 
 #include "check.h"
-#include "osf.h"
 
 #define MAX_OSF_PARTITIONS 18
+#define DISKLABELMAGIC (0x82564557UL)
 
 int osf_partition(struct parsed_partitions *state)
 {
diff --git a/block/partitions/osf.h b/block/partitions/osf.h
deleted file mode 100644
index 80a58c382b3f..000000000000
--- a/block/partitions/osf.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *  fs/partitions/osf.h
- */
-
-#define DISKLABELMAGIC (0x82564557UL)
-
-- 
2.24.1

