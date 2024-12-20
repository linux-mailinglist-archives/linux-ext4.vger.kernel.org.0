Return-Path: <linux-ext4+bounces-5831-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 965D49F9A7B
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 20:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC0D6165613
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 19:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64915222D5C;
	Fri, 20 Dec 2024 19:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gEB5Deky"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEF621A438
	for <linux-ext4@vger.kernel.org>; Fri, 20 Dec 2024 19:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734722925; cv=none; b=QzBjjQ//Tn49XhEe2DpVJFNovpE3mwvOfgWRKyIqKnm9hpllkrDMKl3oqIrWJ+70teme9vPwa8LXQ/IZWyx4V0bQ+cbP2qYmufueRg2ksYarMSw9689jn/K4t7Ee9Qg0PhkS9RE/WBjqZJ8vqYTVZ+tBZ/T/68lJMgDDP4+wyOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734722925; c=relaxed/simple;
	bh=F/pfvzzvMpqz4XIdpA1lJBWfcIAxumMoZrWR6FsU9a4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Evk7k64CkAP91ORAcDEAAlSe9feXHHKEqkdOKo97hMdSUCqx94Z0MTzIr/uOciMzj8SyZR3pSW+kOmkFTCx6HpsH32K+nuR0CDjfwS8RjrUlTmcOSEhbCIJ3/F6RAacvDUGqnlPgnsMV4HYSdnN8oQqwP3NMUTSRLP8KqcVkW/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gEB5Deky; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734722917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/CJ00DbdGmaQAk+t1WEnYTSaYNKGRDNTr0TxyBYMezk=;
	b=gEB5DekyEQp0MkQaEalFsKkDtuQkzUzzuI718+Xm5AjGQCKwIaeUuQc+u+JKoqaSLToNQz
	X/DknkXfTGqhoHaK1bJnzIFBHSNFq0VO/RgygZwuu0W1wsgqWVmKd1zkoZUtnQ2ci07BIo
	rOuY3ntx0oH/3NsfXCOjUU2EG2dulXo=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] ext4: Use str_plural() instead of PLURAL() macro
Date: Fri, 20 Dec 2024 20:27:51 +0100
Message-ID: <20241220192750.2212-2-thorsten.blum@linux.dev>
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
2.47.1


