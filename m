Return-Path: <linux-ext4+bounces-1656-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C81C87C823
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Mar 2024 04:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 968A61F2217F
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Mar 2024 03:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1189B12E7F;
	Fri, 15 Mar 2024 03:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TnHAHl0j"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2EBDF58
	for <linux-ext4@vger.kernel.org>; Fri, 15 Mar 2024 03:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710474804; cv=none; b=mYhH1Ya70DxjLaAbH3uY2FqPR/l4roHYkPFZQ7yAIiU2zDRDzznNr2LbFg/Qld5c3ncVLM4OakKIeASdezvqG34KQa6g1U6plmz0Ye5BBMx010cEyBzHPnwk/jkhMqWuqW5GFq8o1tpeoTRl/678LdCcMy3zKAeUNv7ikvPfSJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710474804; c=relaxed/simple;
	bh=2qMcRbP6ZzThdZGcEPqIsQjXmXA3HO46JfwlDTtZ19U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKT48RgtwGtKVyna92wMTTcdPXg4BxbF1K1O1jLI9OHboyQAD3BYT3uLGS3EeP3b8wBssFMJQpCn3FJsNSRjMieEkia5aUxQfXyRNiYEWJpUzFGEqAgJF4sL2404cypHw3Z33iKh6B7Fv5GOK/1dNWba/4yR1fhV5XINqCyFuU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TnHAHl0j; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710474801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b3OAWR1YN5Ue1DLQYdfxGHPlfZVSaTst3605+wbzFMA=;
	b=TnHAHl0jBxYCvli6JJtoKK/AtikrGpOLfgq7u/0ZkCZQOE2uOLetAjUV0IUkWDUBWea72i
	cLleOiAoaNZld7uFCI+Y8geW8Kjdgt+4waqGIp+DLgJObRUzJDTaJSzSYHHxgpqsGhJDrH
	r5RjBjisWhBPThMRlpbLGRbcqqFbR8I=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: torvalds@linux-foundation.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org
Subject: [PATCH 3/3] ext4: Add support for FS_IOC_GETFSSYSFSPATH
Date: Thu, 14 Mar 2024 23:53:02 -0400
Message-ID: <20240315035308.3563511-4-kent.overstreet@linux.dev>
In-Reply-To: <20240315035308.3563511-1-kent.overstreet@linux.dev>
References: <20240315035308.3563511-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

the new sysfs path ioctl lets us get the /sys/fs/ path for a given
filesystem in a fs agnostic way, potentially nudging us towards
standarizing some of our reporting.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org
---
 fs/ext4/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index f5e5a44778cf..cb82b23a4d98 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5346,6 +5346,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP | QTYPE_MASK_PRJ;
 #endif
 	super_set_uuid(sb, es->s_uuid, sizeof(es->s_uuid));
+	super_set_sysfs_name_bdev(sb);
 
 	INIT_LIST_HEAD(&sbi->s_orphan); /* unlinked but open files */
 	mutex_init(&sbi->s_orphan_lock);
-- 
2.43.0


