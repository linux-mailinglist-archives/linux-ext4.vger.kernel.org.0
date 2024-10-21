Return-Path: <linux-ext4+bounces-4661-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DF59A60FF
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Oct 2024 12:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D0E01F23CFE
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Oct 2024 10:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B34C1E3DF9;
	Mon, 21 Oct 2024 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wcO654DQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370531E32B6
	for <linux-ext4@vger.kernel.org>; Mon, 21 Oct 2024 10:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504901; cv=none; b=K3slYYhEatSYgPQo3uR5HRfVLEeKcwJ4MPZuSE3HmItYAKbb39AsQy4iodbVWknTLDJX6/pxK9P6tO7Ab+3PqOIc+1x6KxYFky4z1JVTmGz+ZP6sjW8dQSEXwFl9d4hIZkDPYnvZxVTaTTHQYgi9ERtBlF7iCllP+1UGu/HmzgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504901; c=relaxed/simple;
	bh=9463fSkV7FqBg+ae6ErrihpOEctWELQJ3N8F+ouU/p0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IeNTCYTH/DJDtU0mlV2ypnq8bYEtsaGMocgcaSoIDQsHw5tre1+TQeHC/kfGIeZX9nxJnwQjID8502lcflN9dtsKFi0IoLCS8KP7yAroA+h2FQYewjFwENoeu5luVm28E8kNmjV5+Je2+f9KWUjug3YWoMUsF0X6wxT7WPca9O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wcO654DQ; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729504896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a/kh6MtV+hVG1cOKRS4IyBRlKmLHbveTOAvSOev07Ow=;
	b=wcO654DQyUKwfP2odIDZ/2nEAO146Bt/Quj3qqq43uzveMlPrSSZg/TCnlIat8XRH6GpnF
	Cz8WYtJDUgzd5qCnzCTkEilHgZlmhyQKAZ/wnDzyVZ3FB31C+Lv0CjGzJNSsBaaUEyvJ9D
	MyxcgEECmsO8lCIOJ4JxTu8Bj8X5zqc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: Use str_yes_no() helper function
Date: Mon, 21 Oct 2024 12:00:57 +0200
Message-ID: <20241021100056.5521-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_yes_no() helper function.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/ext4/mballoc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index d73e38323879..4d8e82cb90fd 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5711,7 +5711,7 @@ static void ext4_mb_show_ac(struct ext4_allocation_context *ac)
 			(unsigned long)ac->ac_b_ex.fe_logical,
 			(int)ac->ac_criteria);
 	mb_debug(sb, "%u found", ac->ac_found);
-	mb_debug(sb, "used pa: %s, ", ac->ac_pa ? "yes" : "no");
+	mb_debug(sb, "used pa: %s, ", str_yes_no(ac->ac_pa));
 	if (ac->ac_pa)
 		mb_debug(sb, "pa_type %s\n", ac->ac_pa->pa_type == MB_GROUP_PA ?
 			 "group pa" : "inode pa");
@@ -6056,7 +6056,7 @@ static bool ext4_mb_discard_preallocations_should_retry(struct super_block *sb,
 	}
 
 out_dbg:
-	mb_debug(sb, "freed %d, retry ? %s\n", freed, ret ? "yes" : "no");
+	mb_debug(sb, "freed %d, retry ? %s\n", freed, str_yes_no(ret));
 	return ret;
 }
 
-- 
2.47.0


