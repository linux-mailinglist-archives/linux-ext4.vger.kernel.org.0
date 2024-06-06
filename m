Return-Path: <linux-ext4+bounces-2789-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C15238FDE38
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jun 2024 07:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58B551F25914
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jun 2024 05:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6D53AC36;
	Thu,  6 Jun 2024 05:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="o1ceHMGF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9EF446A2
	for <linux-ext4@vger.kernel.org>; Thu,  6 Jun 2024 05:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717652639; cv=none; b=sQ9iw9pw4WFqY4kGYSAL2obUntc9I6DQn3BaAggPvlKRjmYvYRHJmWkX1b1ELw9/5TYn8WVICtTXWnqpXkFhL1bI3HQKjcMkN7FuKUejZescpGKvMvST7OJ8g/0/OinS5RIJ0mgIlwJ5iwLMDqLjF2q8cN36eDy2hOv41rfKnRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717652639; c=relaxed/simple;
	bh=E3xoj+QfK7wTNX1uS2jc92oz1Usudj1VLXGehqSzS50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=F7+BNbviuS2CQF1/j8O20KiyAneuDPT7GU+2GO1MYb4Qp+Ao1XTlbjVCjw2iMZPP+jmVNpb9cyOr1lwDWpiAhPZra8piA1uknMmWoWuBOaSyBCZ0EwdLCoJHVbh1hRzU87wCb/JWGRkeu/+s6xmJdodlPqvVb9U59UOh3dcIB8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=o1ceHMGF; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717652633; h=From:To:Subject:Date:Message-Id;
	bh=uXHgiyQ96csgFQ1Lw6YKxjPS6x/w6GdUL1tu3OF1KIM=;
	b=o1ceHMGFqaoMzONDxQV19E/x58AaPiZsF+lfAAE55uu14SImZNeGWlZ/TbmXhYIRjlMvc83ovMavOpSapU8hgfQJDSjlRrh3P1vnvkD1PDkMX/+60JtZ/ktbTZ/ZfULwEFeUm3bXvqA7Kdt6F/O0asIGra2xKu/PT63qwyx02DM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=carrionbent@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W7x8LZI_1717652616;
Received: from localhost(mailfrom:carrionbent@linux.alibaba.com fp:SMTPD_---0W7x8LZI_1717652616)
          by smtp.aliyun-inc.com;
          Thu, 06 Jun 2024 13:43:52 +0800
From: carrion bent <carrionbent@linux.alibaba.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	carrion bent <carrionbent@linux.alibaba.com>
Subject: [PATCH v2] ext4: fix macro definition error of EXT4_DIRENT_HASH and EXT4_DIRENT_MINOR_HASH
Date: Thu,  6 Jun 2024 13:43:16 +0800
Message-Id: <1717652596-58760-1-git-send-email-carrionbent@linux.alibaba.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1717412239-31392-1-git-send-email-carrionbent@163.com>
References: <1717412239-31392-1-git-send-email-carrionbent@163.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

    the macro parameter 'entry' of EXT4_DIRENT_HASH and
    EXT4_DIRENT_MINOR_HASH was not used, but rather the
    variable 'de' was directly used, which may be a local
    variable inside a function that calls the macros.
    Fortunately, all callers have passed in 'de' so far,
    so this bug didn't have an effect.

Signed-off-by: carrion bent <carrionbent@linux.alibaba.com>
---
 fs/ext4/ext4.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 983dad8..04bdd27 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2338,9 +2338,9 @@ struct ext4_dir_entry_2 {
 	((struct ext4_dir_entry_hash *) \
 		(((void *)(entry)) + \
 		((8 + (entry)->name_len + EXT4_DIR_ROUND) & ~EXT4_DIR_ROUND)))
-#define EXT4_DIRENT_HASH(entry) le32_to_cpu(EXT4_DIRENT_HASHES(de)->hash)
+#define EXT4_DIRENT_HASH(entry) le32_to_cpu(EXT4_DIRENT_HASHES(entry)->hash)
 #define EXT4_DIRENT_MINOR_HASH(entry) \
-		le32_to_cpu(EXT4_DIRENT_HASHES(de)->minor_hash)
+		le32_to_cpu(EXT4_DIRENT_HASHES(entry)->minor_hash)
 
 static inline bool ext4_hash_in_dirent(const struct inode *inode)
 {
-- 
2.7.4


