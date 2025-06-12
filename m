Return-Path: <linux-ext4+bounces-8375-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 773F9AD65AF
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jun 2025 04:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1D7C3ACF3F
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jun 2025 02:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753471C84BA;
	Thu, 12 Jun 2025 02:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ewVXWC7R"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE631C3039
	for <linux-ext4@vger.kernel.org>; Thu, 12 Jun 2025 02:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749695375; cv=none; b=GrnAm53Zjf77agWDE4b8SH33YX/xqIE030DVC16Gsl7sIfBSk5MX8On0SfYTp2uoT0l7QnbTEyAzasgZ6oNSAorxcGFlZF4yE5Ef19dylleLSV5sBCy4vpATHgr5niKzRgZWM+gBqhZ521FLbRY255Q96BWJosoZ3Ki1ydPKhiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749695375; c=relaxed/simple;
	bh=UiR+4jj7Lezdi7ckAIhQ1hmMUd7C1uiRiYBWgV7z74w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gaFhFMPZnyu0gPmupZvApfj4j+XPNG/ggTSmYqZrXHsMpfOVmRezFpjsvNF+M9RF/KV3iQW0C5mXc7/EQ24MSsUwZVxUdqk5x6FpPUTVUZsdr+L+cRZaY+s/0GjMl2n47iKrvG1pmjzIUtcUHW54zMRqs/ofGGsBXDc+HXIECKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ewVXWC7R; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a50956e5d3so409838f8f.1
        for <linux-ext4@vger.kernel.org>; Wed, 11 Jun 2025 19:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749695370; x=1750300170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wyJycTNJKqQAdQ4vv1MjI1ZDB2PA21sgOvxj6YC0ETM=;
        b=ewVXWC7RK1FoHXMgNlYNRCYV84yypu5i/u05FEHnx7NH43xZwOUZEFacgOHhw+5E3+
         FyS/t1cTwVib9RaD0VieonMXFIZaeelijGgR+bChQRZDeaECA83RlFuZFYXr20rRrBV2
         V93OhqS+8jXN83sNceAd2CZ2ZqsvmsAgen2MaPy/AZK+t2L3AdclxaKHwR5aJVaeEQOT
         0zaEnIRtvkPFB59Yx5OmmrtS9CaBi+KQxoWieTv1Es/mpVwtXS21JIaSQsjGmv/Acdne
         59tamKdPID7DtHLvYk3SfDMoYaMcX4m91duRHxSu2jFvomIhANyFHJbvwsCujqEKoB6B
         TzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749695370; x=1750300170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wyJycTNJKqQAdQ4vv1MjI1ZDB2PA21sgOvxj6YC0ETM=;
        b=f+gr/E3ckMQOGZ79knqxYubQNcG5MDoyb1leoE1o5yy/NUYvuHQJ0ax7mlZHVw+z5L
         gQ/GXnoNmvTa1lxPaGOWg2mRXKRnRny1L7RwznMzwpFubz+2XCy2uZ5hR873pdJclnar
         JFqFrEX1TjMJBwRtMjQOWLMMXUdMg1dOt4KHLMLfwDYJfTl30N0jnd8AJccxuKsXpOXL
         eg3nfl2lJE1nsCMIgAYzMqvEKECS52kHwhcjyYsAvFrf6KYh8cTgRBl3NICP7J+AwWdY
         OZCh61507T+qacjm+PY/VDSIMHiLJCGGd+AIVl3uM+XFB41rDRgvcVMj8JudMjHbTRnT
         8ObA==
X-Forwarded-Encrypted: i=1; AJvYcCW5TnGYvA5FLZ7KsZWZhzH1A+tCI/ESYKvcGibln4WWI7m0HfsQZy+Ix+O9F+GqAjLTvXzfltn3M1ri@vger.kernel.org
X-Gm-Message-State: AOJu0Yyblc0qU3XX2OQ7QWmLfXdUtyB0iGy+agl3PfExWxUYnruK7XVH
	1Ym4DPqb486rRdN4k0fLNMObSJwp7ZQGFHWljfB616iJRO0RjLzic1McbKFKd3JQ6Q==
X-Gm-Gg: ASbGncstER9/wglYbIvf82mkCWxECSYDnC2Ba4MUXdgKucmdI2WA0tSHS2b2BbzMNvb
	pcEQUdi3bmlhmXh/fLH1u53fBjiCsGBSlnvDtQIsdGXAI7ElA9QPi7WYhtd3dDr1WTWQF0cKSZM
	+edjnm+HclPdEHB6s7YazjDrdr2KVEvEASsIVzK9b6XGJcaMRshi4aUtD+s4Ma2fyEf8FVMUj1z
	9sluEeLKb4VoCz0kHmdmr/RkNNRUjINzEQaguVKsVLtOSW3ZY0+LAZ/ta5Tc9yw1PQywZ2Ww0+o
	T1wsdAu6DVPkkUQvEjhurESqnEPIEs+mAa3xQzPY96Z2UZW69rqKdGHi5gn7pw==
X-Google-Smtp-Source: AGHT+IEor0nUXVAnFPELZdkVN3Zon9NMN75gb7Dse9/hrs9o11jYQcVQVAHlt5QJB3hYaccylY2k3w==
X-Received: by 2002:a05:6000:2dc4:b0:3a4:ef00:a7b9 with SMTP id ffacd0b85a97d-3a5586dcd53mr3812187f8f.12.1749695370135;
        Wed, 11 Jun 2025 19:29:30 -0700 (PDT)
Received: from localhost ([202.127.77.110])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-748809ebecesm296699b3a.138.2025.06.11.19.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 19:29:29 -0700 (PDT)
From: Wei Gao <wegao@suse.com>
To: linux-kernel@vger.kernel.org
Cc: jack@suse.com,
	linux-ext4@vger.kernel.org,
	wegao@suse.com
Subject: [PATCH] ext2: Handle fiemap on empty files to prevent EINVAL
Date: Thu, 12 Jun 2025 10:28:55 -0400
Message-ID: <20250612142855.2678267-1-wegao@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, ext2_fiemap would unconditionally apply "len = min_t(u64, len,
i_size_read(inode));", When inode->i_size was 0 (for an empty file), this
would reduce the requested len to 0. Passing len = 0 to iomap_fiemap could
then result in an -EINVAL error, even for valid queries on empty files.
The new validation logic directly references ext4_fiemap_check_ranges.

Link: https://github.com/linux-test-project/ltp/issues/1246
Signed-off-by: Wei Gao <wegao@suse.com>
---
 fs/ext2/inode.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 30f8201c155f..e5cc61088f21 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -895,10 +895,30 @@ int ext2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		u64 start, u64 len)
 {
 	int ret;
+	u64 maxbytes;
 
 	inode_lock(inode);
-	len = min_t(u64, len, i_size_read(inode));
+	maxbytes = inode->i_sb->s_maxbytes;
+
+	if (len == 0) {
+		ret = -EINVAL;
+		goto unlock_inode;
+	}
+
+	if (start > maxbytes) {
+		ret = -EFBIG;
+		goto unlock_inode;
+	}
+
+	/*
+	 * Shrink request scope to what the fs can actually handle.
+	 */
+	if (len > maxbytes || (maxbytes - len) < start)
+		len = maxbytes - start;
+
 	ret = iomap_fiemap(inode, fieinfo, start, len, &ext2_iomap_ops);
+
+unlock_inode:
 	inode_unlock(inode);
 
 	return ret;
-- 
2.49.0


