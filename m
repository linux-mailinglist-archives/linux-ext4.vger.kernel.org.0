Return-Path: <linux-ext4+bounces-1119-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF5584A7BB
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Feb 2024 22:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64E851C26B91
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Feb 2024 21:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5CC12D169;
	Mon,  5 Feb 2024 20:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PvxVcBYt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5FC12A17F
	for <linux-ext4@vger.kernel.org>; Mon,  5 Feb 2024 20:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707163574; cv=none; b=or18APwZBhUAycg7+0Hs2UTfKCn/Am8//luMIRxMdODiDX+BfnrLh2+c7PRiMjlbGWCBfc6hM8krlvXShurK9fjgHHpqUgX2I3sm9QRBg14GAX6Psm7RELFfGudJGBN59Xl/Lg88Cr7BHNeEoorY+4GMHWqO5R7rEUXC59de4eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707163574; c=relaxed/simple;
	bh=XgF3fY5kEN+vUXqGN7hKlRnAVg3Ylev2ReQ2bfeBKZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXidVnczbV4o8ohUwe6UcTya1kP5CU6ht+x1U58lk00VRPALHJdjWcLzUTJI4UmOBHKW0K0bUgMpneA1U2DvPl44lPGiQmpnbYvy0UGC57o0Y+w8OTb+yHgt2lnTCXtMDL6xLz5xIPsDGDxmu8zDqOda03oossFcoHDcdLjdC7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PvxVcBYt; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707163571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NLVu6z9oDG9sN6mZGh4y4P6bs4UjmMpsBscmXPUe1bU=;
	b=PvxVcBYt7kYfaf12e30W3x0/H8h/HJO72Cemqvu76NHpwi78k4o2zorkFCEuaYAkT9nwB1
	6GHJLaLgmqy4xQSlf/Z03MErkO7mBHraWYj6eTSIwBY2/H1VmgcZXTVjvKPvB4FOGj4fZL
	OmdQW4FtTPe1DR1sxWKgQfbIK56J9Hk=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 6/6] bcachefs: add support for FS_IOC_GETSYSFSNAME
Date: Mon,  5 Feb 2024 15:05:17 -0500
Message-ID: <20240205200529.546646-7-kent.overstreet@linux.dev>
In-Reply-To: <20240205200529.546646-1-kent.overstreet@linux.dev>
References: <20240205200529.546646-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/fs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 77ea61090e91..50b2fd3ddd23 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -1947,6 +1947,7 @@ static struct dentry *bch2_mount(struct file_system_type *fs_type,
 	sb->s_time_min		= div_s64(S64_MIN, c->sb.time_units_per_sec) + 1;
 	sb->s_time_max		= div_s64(S64_MAX, c->sb.time_units_per_sec);
 	sb->s_uuid		= c->sb.user_uuid;
+	snprintf(sb->s_sysfs_name, sizeof(sb->s_sysfs_name), "%pU", c->sb.user_uuid.b);
 	c->vfs_sb		= sb;
 	strscpy(sb->s_id, c->name, sizeof(sb->s_id));
 
-- 
2.43.0


