Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA6C1834A1
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Mar 2020 16:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgCLPUW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Mar 2020 11:20:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38740 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbgCLPUU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Mar 2020 11:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ABEU/z7lsXGuGe1amIkhjXTbw805aSLYXuvorFP/c3k=; b=T/4LYR/akk9J+gFFrv/ViLv2an
        JbyCsYuHTCufoMBEiaU1qhf95fHWQ70Uur5ME2p4xxztO2ZqecS5iPT+dxt0vTuJYlJq0TPnGmuPY
        Ej3CfkeKY/YiRPsuLhefs4KfJHPTfuqTmd6Cz6woBT6OZBGOVBSO7jtE1n8GxdHuWuyim5QhEug3o
        Wv1U4ziLSqadY5UiLruOkuUFU1N2b6u7b3iVNvBoawleHe9VMPBOLCDZEyO+rHiseWSCYaDO3tbuv
        g1r5Hn1T9rIwko5J3R5mzRW00u5kuEebPFsJUplpkPMLBTcfeYc85zvlLwFxEorVeTXp/BjHhMo/f
        eyDiq9AQ==;
Received: from [2001:4bb8:184:5cad:8026:d98c:a056:3e33] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCPdE-0007uv-38; Thu, 12 Mar 2020 15:20:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-ext4@vger.kernel.org,
        reiserfs-devel@vger.kernel.org
Subject: [PATCH 13/21] block: remove block/partitions/karma.h
Date:   Thu, 12 Mar 2020 16:19:31 +0100
Message-Id: <20200312151939.645254-14-hch@lst.de>
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

Just move the single define to block/partitions/karma.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/karma.c | 3 ++-
 block/partitions/karma.h | 6 ------
 2 files changed, 2 insertions(+), 7 deletions(-)
 delete mode 100644 block/partitions/karma.h

diff --git a/block/partitions/karma.c b/block/partitions/karma.c
index 59812d705c3d..4d93512f4bd4 100644
--- a/block/partitions/karma.c
+++ b/block/partitions/karma.c
@@ -8,9 +8,10 @@
  */
 
 #include "check.h"
-#include "karma.h"
 #include <linux/compiler.h>
 
+#define KARMA_LABEL_MAGIC		0xAB56
+
 int karma_partition(struct parsed_partitions *state)
 {
 	int i;
diff --git a/block/partitions/karma.h b/block/partitions/karma.h
deleted file mode 100644
index 1b5eec57ee0c..000000000000
--- a/block/partitions/karma.h
+++ /dev/null
@@ -1,6 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- *  fs/partitions/karma.h
- */
-
-#define KARMA_LABEL_MAGIC		0xAB56
-- 
2.24.1

