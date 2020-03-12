Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 778CC1834AD
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Mar 2020 16:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgCLPUa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Mar 2020 11:20:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38802 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbgCLPU2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Mar 2020 11:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2LWz+IqIM5pjnYsoc6C9Se72Jf2MPu2WCdsKyWxUKKQ=; b=hvqAl2QwtsESlC0QcXbeueYJ6E
        bFFRnDazECe5tzJ9APUzrk40tYC7iu1EmAi5O/tt0pY/Hxf6JBlEfj0ug//hJ0KrW+uG8SKqVKTRF
        wwuutPcGZbpWPi6dh41UR81Lr32S7K4/Lp2tPsDQdtvb0wdzZIUFh4U9NrcDo8NM7ibMXmlsGlRTk
        csJAHs/f0sJn/QFfwGWAlMws11cZSneQvN/Lj3+VNj7SoYuvstGyTme7v5EcQoAxgRKp66xkwJ4vW
        dQk43MKhWA30pJMSFYfL/xom6dDhALyzOyK7YGZKsSBEwqBFwJ2ADgNY5Bm2oH+2KqqQLksDDFK20
        EIctOeHA==;
Received: from [2001:4bb8:184:5cad:8026:d98c:a056:3e33] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCPdM-0007xd-2r; Thu, 12 Mar 2020 15:20:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-ext4@vger.kernel.org,
        reiserfs-devel@vger.kernel.org
Subject: [PATCH 16/21] block: remove block/partitions/sun.h
Date:   Thu, 12 Mar 2020 16:19:34 +0100
Message-Id: <20200312151939.645254-17-hch@lst.de>
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

Just move the two defines to block/partitions/sun.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/sun.c | 4 +++-
 block/partitions/sun.h | 8 --------
 2 files changed, 3 insertions(+), 9 deletions(-)
 delete mode 100644 block/partitions/sun.h

diff --git a/block/partitions/sun.c b/block/partitions/sun.c
index 90f36724e796..28b44100f2b1 100644
--- a/block/partitions/sun.c
+++ b/block/partitions/sun.c
@@ -9,7 +9,9 @@
  */
 
 #include "check.h"
-#include "sun.h"
+
+#define SUN_LABEL_MAGIC          0xDABE
+#define SUN_VTOC_SANITY          0x600DDEEE
 
 int sun_partition(struct parsed_partitions *state)
 {
diff --git a/block/partitions/sun.h b/block/partitions/sun.h
deleted file mode 100644
index 4c8877a5b52d..000000000000
--- a/block/partitions/sun.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *  fs/partitions/sun.h
- */
-
-#define SUN_LABEL_MAGIC          0xDABE
-#define SUN_VTOC_SANITY          0x600DDEEE
-
-- 
2.24.1

