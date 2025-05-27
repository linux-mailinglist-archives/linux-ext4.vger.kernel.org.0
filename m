Return-Path: <linux-ext4+bounces-8204-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7874FAC47AD
	for <lists+linux-ext4@lfdr.de>; Tue, 27 May 2025 07:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1822C7A4A4C
	for <lists+linux-ext4@lfdr.de>; Tue, 27 May 2025 05:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B344419D07A;
	Tue, 27 May 2025 05:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TE9rROHy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D32922EF5;
	Tue, 27 May 2025 05:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748324307; cv=none; b=CKkoYaaTGyjDePt9yWP9XmW8JoiUnca3pWFVXRMp5x9iTIlCO5juV3P+FIVz5jThdXOYq7skEYWKMkKAQyR1mkcnlKSw73OQ8MR6XvcdGC2Te7Unx4HRZTHEsjoHJHaXTBnEI1wAeiaHnauV3XyTDjNSaqAUVDT7gftyENQm+RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748324307; c=relaxed/simple;
	bh=7CUXNSCa6bt0o8RMpuuLS2h0H+Gj1TyQT+7wDVWCtY8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CRd8FQAS0c7V1WSmZ4Xoyahjk/UpLp99551N9xh2tc2WHXjfhLa9w5b338tTe8VaH++lHSiR96FLDzMXc3O991nujiyYZ/S69eKvC5L79o5t5+8Td3QI90qi0yB3KgziRSuluNIYJQzs8/fiMysf7jNxjb0Ynsox/u818YYPut0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TE9rROHy; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=5j
	/teWC9IvlPG7boq+Rl9HFG88D7q8CxXkXGn8aiWZY=; b=TE9rROHyCqyNAZ5ouO
	w71PNTroMfD6xJsHxdY3xNCEI3Ad9MUP4T78B2YVe86cmxbWXMLrQH46nTFzCxo8
	OTUV62uAIusO82TZ5hfYAykejs1fwwHLJTa30zYl1CadAVF0CpGgAuqPFO8gnTRN
	+g4tuItL6eBTG2U78Ho31q4lg=
Received: from liubaolin-VMware-Virtual-Platform.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wCX_W7ATzVo83KsEA--.2109S2;
	Tue, 27 May 2025 13:38:10 +0800 (CST)
From: Baolin Liu <liubaolin12138@163.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: liubaolin12138@163.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Baolin Liu <liubaolin@kylinos.cn>
Subject: [PATCH v1] ext4: remove unused EXT_STATS macro from ext4_extents.h
Date: Tue, 27 May 2025 13:38:05 +0800
Message-Id: <20250527053805.1550912-1-liubaolin12138@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCX_W7ATzVo83KsEA--.2109S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GryfCrWxXr4kXr4kCrWfKrg_yoWfKrb_Ja
	yxAFWkAry3tr92g3WxGr1jqF1IqF10gr13Was5Grs5Z3yjqws8Jw4DCrZxZr909r4UAr43
	ur48JF1jvas7WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRiNBM5UUUUU==
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/1tbiIAhaymg1TCZvewABsa

From: Baolin Liu <liubaolin@kylinos.cn>

The EXT_STATS macro in fs/ext4/ext4_extents.h has been defined
but never used in the codebase since its introduction. This patch
removes it.

Analysis:
1. No references found in fs/ext4/ or other kernel code.
2. No impact on compilation or functionality.
3. Git history shows it was never utilized.

Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
---
 fs/ext4/ext4_extents.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/ext4/ext4_extents.h b/fs/ext4/ext4_extents.h
index 26435f3a3094..c484125d963f 100644
--- a/fs/ext4/ext4_extents.h
+++ b/fs/ext4/ext4_extents.h
@@ -30,13 +30,6 @@
  */
 #define CHECK_BINSEARCH__
 
-/*
- * If EXT_STATS is defined then stats numbers are collected.
- * These number will be displayed at umount time.
- */
-#define EXT_STATS_
-
-
 /*
  * ext4_inode has i_block array (60 bytes total).
  * The first 12 bytes store ext4_extent_header;
-- 
2.39.2


