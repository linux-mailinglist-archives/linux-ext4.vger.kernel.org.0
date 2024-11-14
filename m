Return-Path: <linux-ext4+bounces-5184-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269109C951A
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 23:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C6AFB22E48
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 22:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04BC1B0F0C;
	Thu, 14 Nov 2024 22:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PrKWzyAh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAD61AF0BA
	for <linux-ext4@vger.kernel.org>; Thu, 14 Nov 2024 22:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731622548; cv=none; b=qML+CucjuL52Z2vSjP21p8okAmNY96p9Q6B+nfiD8ApMkcplDuCaSxK1IzwQc5lC4gKCzZfjtV13WJ0A7pBHj/WaZrg5FA+7F7nv5/sI5EWvfVLB3Z0Nv1fEcl7sEtYVTLk72V6ZtCbCXaIRMRXjiryGN7iAIS/8YpDV/HQnY3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731622548; c=relaxed/simple;
	bh=MYkHd8As34CFbGENrqkCxmOAaeYY73357pJ8flFE+A8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DKt//M+VILr3JHPe8SfHfeY0q3WlRFph8PLuwBmrYKxC3vJOMn2kIPuCdnJ+yHDp+x/C/MBaTcvuhu+6D4fRbUv2+2Z3gtJ2M49qJFzxROh1XkIMzzHeBPf46lm6UnsqsbN4rH3rmCGdCduEP19X6FyhowtRp3xfbu877BliwpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PrKWzyAh; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731622543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kg0r27nDHYo0HTdQPuoNFOxroH69LZyYnbGGxN3ORMk=;
	b=PrKWzyAh+NAke01/Vl7QXLJstJ5J69wvo63D0+65cNoS75oyrXbFBI6d7vvRAhT1pYdUCQ
	2VdnLmM9BvS75E+h9nOaSlGhlmzQ1AS6VRy0X4DSVSrktvM75S1r6nbetnhTjeK8i16ti7
	lMBFLcvYP8+6xa7lpCZr316dpWe5wQw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: Use str_plural() instead of PLURAL() macro
Date: Thu, 14 Nov 2024 23:14:39 +0100
Message-ID: <20241114221438.38775-2-thorsten.blum@linux.dev>
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
2.47.0


