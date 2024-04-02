Return-Path: <linux-ext4+bounces-1816-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF1B8949DD
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Apr 2024 05:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED5952826DD
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Apr 2024 03:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E4114F64;
	Tue,  2 Apr 2024 03:13:58 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id DAFD74C96;
	Tue,  2 Apr 2024 03:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712027638; cv=none; b=XLLd7hKRfLM1apSDiWOrmhZ8QV4LZecg5NfCCfr7NBuNf6F+TfYJ5CWoI1SRCeKPzpaW2V24yQZM00vmSjIssD89eGz6ScfMlR1OWkMWChZ3nmKogGL2j8IOFQVu2DsBwJ1ON3LYrnMmg1AVB+KJof/Z0a169On1hR6l2M+LssQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712027638; c=relaxed/simple;
	bh=TgYN3txUafwhIZ8qTVKumny2VJLU8Z0/5tALw0JaLnI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=V+oeyGAxUX4+rgUumkL9zgA/sxlVIQGCQSug/M0vx0sa8ppQPnE8dcNPd4zMD5kYr4sACFiSWmzOfCX8/zp3Q5ETtnzR3YBosHrpcaTvRTZFYXdQryNItzISqCeRVZL6N3bITDQqpNYXwqOhYN6hbPwiBs9HIt6O0mrbjAxkZNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 82E386088D5DA;
	Tue,  2 Apr 2024 11:13:51 +0800 (CST)
X-MD-Sfrom: kunyu@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li kunyu <kunyu@nfschina.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] =?UTF-8?q?ext4:=20extents:=20Remove=20unnecessary=20?= =?UTF-8?q?=E2=80=980=E2=80=99=20values=20from=20err?=
Date: Tue,  2 Apr 2024 11:13:42 +0800
Message-Id: <20240402031342.32884-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

err is assigned first, so it does not need to initialize the assignment.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 fs/ext4/extents.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index caace8c3fd3c1..f3cb570951a7e 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1403,7 +1403,7 @@ static int ext4_ext_create_new_leaf(handle_t *handle, struct inode *inode,
 {
 	struct ext4_ext_path *path = *ppath;
 	struct ext4_ext_path *curp;
-	int depth, i, err = 0;
+	int depth, i, err;
 
 repeat:
 	i = depth = ext_depth(inode);
@@ -1709,7 +1709,7 @@ static int ext4_ext_correct_indexes(handle_t *handle, struct inode *inode,
 	int depth = ext_depth(inode);
 	struct ext4_extent *ex;
 	__le32 border;
-	int k, err = 0;
+	int k, err;
 
 	eh = path[depth].p_hdr;
 	ex = path[depth].p_ext;
@@ -2569,7 +2569,7 @@ ext4_ext_rm_leaf(handle_t *handle, struct inode *inode,
 		 ext4_lblk_t start, ext4_lblk_t end)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
-	int err = 0, correct_index = 0;
+	int err, correct_index = 0;
 	int depth = ext_depth(inode), credits, revoke_credits;
 	struct ext4_extent_header *eh;
 	ext4_lblk_t a, b;
@@ -2794,7 +2794,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 	struct ext4_ext_path *path = NULL;
 	struct partial_cluster partial;
 	handle_t *handle;
-	int i = 0, err = 0;
+	int i = 0, err;
 
 	partial.pclu = 0;
 	partial.lblk = 0;
@@ -3162,7 +3162,7 @@ static int ext4_split_extent_at(handle_t *handle,
 	struct ext4_extent *ex, newex, orig_ex, zero_ex;
 	struct ext4_extent *ex2 = NULL;
 	unsigned int ee_len, depth;
-	int err = 0;
+	int err;
 
 	BUG_ON((split_flag & (EXT4_EXT_DATA_VALID1 | EXT4_EXT_DATA_VALID2)) ==
 	       (EXT4_EXT_DATA_VALID1 | EXT4_EXT_DATA_VALID2));
@@ -3403,7 +3403,7 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
 	ext4_lblk_t ee_block, eof_block;
 	unsigned int ee_len, depth, map_len = map->m_len;
 	int allocated = 0, max_zeroout = 0;
-	int err = 0;
+	int err;
 	int split_flag = EXT4_EXT_DATA_VALID2;
 
 	ext_debug(inode, "logical block %llu, max_blocks %u\n",
@@ -3698,7 +3698,7 @@ static int ext4_convert_unwritten_extents_endio(handle_t *handle,
 	ext4_lblk_t ee_block;
 	unsigned int ee_len;
 	int depth;
-	int err = 0;
+	int err;
 
 	depth = ext_depth(inode);
 	ex = path[depth].p_ext;
@@ -3761,7 +3761,7 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
 	ext4_lblk_t ee_block;
 	unsigned int ee_len;
 	int depth;
-	int err = 0;
+	int err;
 
 	/*
 	 * Make sure that the extent is no bigger than we support with
@@ -4418,7 +4418,7 @@ int ext4_ext_truncate(handle_t *handle, struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 	ext4_lblk_t last_block;
-	int err = 0;
+	int err;
 
 	/*
 	 * TODO: optimization is possible here.
-- 
2.18.2


