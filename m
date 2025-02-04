Return-Path: <linux-ext4+bounces-6303-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F03AA27697
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Feb 2025 16:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2213166B05
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Feb 2025 15:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EB92147FA;
	Tue,  4 Feb 2025 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XkoAQK+f"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D372147F7
	for <linux-ext4@vger.kernel.org>; Tue,  4 Feb 2025 15:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738684659; cv=none; b=AhhgZMTy8zRQ76ebMOB4tB71EgjzyxSjO7w7Rxd7zE4oqKxoGyiXfdVjHxZsllmkjJ4ayyuFlXdGB1KXJprzaFX6pOpgBTH2pGWcP/T3EB1FmYbczcJdZL4G48RuXqiKtEgzd+B1RDJkTpZHYxbwCXLdCOBQuQjTcI4pDb92rLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738684659; c=relaxed/simple;
	bh=nNZkV5dZvnerrrabYupYnm0jtaQhOWqqF15cD5rwh8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IvDMz+IcRGxVVcXHPfrKys1cdrLlFNG1AG7IxDMAPnQiIO0lseZYFN2on2oPDGCGApcf/tofxefRJetRRBPn5P9y4UiYasji363+iUoObuolKfTmclirpBXdQbCeyAeCTEh311/+moP961eKjDJslXlQpwvZIpjVVVnpryaGrnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XkoAQK+f; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738684645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2N9dh/hrAxDhAxb7Cx6jXTYkCHM0vnY3TInVj0O++lA=;
	b=XkoAQK+fTH7UaoR/Rqp24EJH3mOkziyHZw0Aswt8w5l3OCcX1pe/WS3yRr7/VRvxIwQ2z7
	z0b7wKqb5fN5bAB3bA13n7nOzRoXBm6NQQaBzjdToZsWeJqMtKb+vRynu+jDdQQVhbPFw9
	4O4uoFMWFUzMRGh4g9G8nmw8T4q0/T4=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] ext4: Use str_plural() instead of PLURAL() macro
Date: Tue,  4 Feb 2025 16:57:08 +0100
Message-ID: <20250204155707.4669-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove the custom PLURAL() macro and use the str_plural() function
instead.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/ext4/orphan.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
index e5b47dda3317..1320f91c9b3b 100644
--- a/fs/ext4/orphan.c
+++ b/fs/ext4/orphan.c
@@ -4,6 +4,7 @@
 #include <linux/fs.h>
 #include <linux/quotaops.h>
 #include <linux/buffer_head.h>
+#include <linux/string_choices.h>
 
 #include "ext4.h"
 #include "ext4_jbd2.h"
@@ -488,14 +489,12 @@ void ext4_orphan_cleanup(struct super_block *sb, struct ext4_super_block *es)
 		}
 	}
 
-#define PLURAL(x) (x), ((x) == 1) ? "" : "s"
-
 	if (nr_orphans)
 		ext4_msg(sb, KERN_INFO, "%d orphan inode%s deleted",
-		       PLURAL(nr_orphans));
+			 nr_orphans, str_plural(nr_orphans));
 	if (nr_truncates)
 		ext4_msg(sb, KERN_INFO, "%d truncate%s cleaned up",
-		       PLURAL(nr_truncates));
+			 nr_truncates, str_plural(nr_truncates));
 #ifdef CONFIG_QUOTA
 	/* Turn off quotas if they were enabled for orphan cleanup */
 	if (quota_update) {
-- 
2.48.1


