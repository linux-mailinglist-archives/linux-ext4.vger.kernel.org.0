Return-Path: <linux-ext4+bounces-10693-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA4DBC6212
	for <lists+linux-ext4@lfdr.de>; Wed, 08 Oct 2025 19:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A97381893DAB
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Oct 2025 17:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8592147EF;
	Wed,  8 Oct 2025 17:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHcDf35F"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6DB8F49
	for <linux-ext4@vger.kernel.org>; Wed,  8 Oct 2025 17:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759943787; cv=none; b=e0orRuGA0fvIniQfoGCD3NRm1G1vRF65WzgCxhJHxZiRttSDQP5g9y2gILq8rHEUzn8fOd0OSLfRn9Nl33scGUWhOAMsDM+S07CW4+xtz7bOTtqp+Wj+S5nOpSp/Xtsw+tOrfNNuEIRcrXWh5a1T0wQSCKAlDURpZ5+s/0WhCFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759943787; c=relaxed/simple;
	bh=lSbsnp+f2ZfbNqP91vjR5Xj3Tii7DpPF2a5DI6ln/qI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r114ZnmxXMFAz79TzlkYYxPb2b7+KWhOvNavqzfFSwb4gLNsqmzlVYiG8/tn7RTcVlk/Z/ml1rs/x3bO6asVLvXhIkBY/x+HB7EobV+kIGVBb2KFywVxfHPKJ7VXkTaC+gnsmi1NLDJE+cQy9L9cl1YKF0j7F/r5rI3ERP2XrQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHcDf35F; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7811d363caaso4199b3a.3
        for <linux-ext4@vger.kernel.org>; Wed, 08 Oct 2025 10:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759943785; x=1760548585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cRuhYvqTv2rk1I3xV6eqvp2KxFVEUhGvlADpHk6TzHE=;
        b=GHcDf35FgJt4/KLSGykK3tXnn9ULR8FGZmmCJ9HXKH2kjVodE20aQ7i6KtcfSd4ZDr
         uMiQc+DhB/SwPjJMNG78gi/034hMgJu6cDlpgPlCsFwRy0wW4XvzaW7YzWT9y1FTO9Ld
         54XBib9zvDJvWGRSjroXASaRU+FlsyaKJo2MCB7NJPeuzDRE7KfE5z67l2gbnQS56UsX
         e8PbhSC0uZAT6nsThflMG/WUE7boNm4UhNkrVYeNA60ZmauKeiKC1px/7X7uN+CUMEEu
         tv3vdL0HqUT2ro27aJf+gI6u+NgDOD3Aro24BY+Y3GESe+Te1Hmbf7UgilBKtkDUhCgI
         ES6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759943785; x=1760548585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cRuhYvqTv2rk1I3xV6eqvp2KxFVEUhGvlADpHk6TzHE=;
        b=h2EBw2bUm6Z8AwNaMSrAvHtFpMCncGHGdrysK1zGEURxvQYOhwx7H7NY1Km7R7TaF1
         QkZ1u6SNWusdQo2cXE/wQ83E895iMAItjsnHW8tZ0+h9me30j1VWwewA06zaWgTfd0ix
         u8otosFcghxVDtvZ/LRFYbyVfeY9287H8DJ+XUAIg4rPVcP7ZzbyxlYSmra+vcwezNlz
         gnvWLEOYhDvr+cjXFVcGYJ3wZmIDuxzgcqUw/iEB4NxQzwiWoE8oHhXjEMN4YM427Ibp
         vbV2xfX+2B4g1CMI+dflhzvQKXeisotg8bkH9qr6ceJ8j1scvK4vGmHxRBAXVzi6l7mi
         rDBg==
X-Gm-Message-State: AOJu0YytYsFhZJuWiN1J1xtcvL4yRNo4KBq34qI/YLIPIZimxL9iozHs
	jzPpkRwo2l6okKgfuZeGICI2JTssep/QmCE6hDaUywP2UDUPL72caFTL
X-Gm-Gg: ASbGncuNyMnOPdM1FuJX8OV83iAQ3nYiz4eWTjIuVsW5G0fdFNLk2uTSYIfwiwnXlr+
	Lv9ahkFYSTRTv9uYt1/nJB0a5D/0Ci69FKtxdnw2vBVLCQf5BCrtRA27tkEMSvBnZ49Z+j5RV6k
	2aLQ9xQBGVptKMSgjvqrBV701U0T2iYiBTYrOfkt1pQ0Lf0aNApTkR/0RBC+oAo02BuFQ4B9OlP
	eRM7F2CZlULnDEpcR0a6i9mqFPRcVby2upAW4hfxxXB7hVjT9ftZC15L5oYfwlNIoCs/fLPOdE1
	9XALVC1yMxPVStiFoiM6s11fkE7DLAZfh6463KeoniZLVPcews6HfkmJcZDkKatq7xLOw1KzaQ2
	VzyePNEvT3NlVqhgMj39To2JCIoSlXi5RKpkOc+QtLV+NpUepLML7mUU=
X-Google-Smtp-Source: AGHT+IF2nVVJlk3OrgRyN8xpfnM0xEdDzSAX/mSWj64B8OkEIb0ZOfOvsN//kU9EW5Q2GLoooQcakA==
X-Received: by 2002:a05:6a00:3e21:b0:776:19f6:5d3d with SMTP id d2e1a72fcca58-79385513828mr2844390b3a.2.1759943785168;
        Wed, 08 Oct 2025 10:16:25 -0700 (PDT)
Received: from ranganath.. ([2406:7400:98:ffd0:1e7c:66e7:2459:3ac2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794e2a4cb5asm261881b3a.71.2025.10.08.10.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 10:16:24 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Ranganath V N <vnranganath.20@gmail.com>
Subject: [PATCH] fs: ext4: fix uninitialized symbols
Date: Wed,  8 Oct 2025 22:46:13 +0530
Message-ID: <20251008171614.12129-1-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the issue detected by the smatch tool.

fs/ext4/inode.c:3583 ext4_map_blocks_atomic_write_slow() error: uninitialized symbol 'next_pblk'.
fs/ext4/namei.c:1776 ext4_lookup() error: uninitialized symbol 'de'.
fs/ext4/namei.c:1829 ext4_get_parent() error: uninitialized symbol 'de'.
fs/ext4/namei.c:3162 ext4_rmdir() error: uninitialized symbol 'de'.
fs/ext4/namei.c:3242 __ext4_unlink() error: uninitialized symbol 'de'.
fs/ext4/namei.c:3697 ext4_find_delete_entry() error: uninitialized symbol 'de'.

Tested with compilation only.
These changes enhance code clarity, address static analysis tool errors.

Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---
 fs/ext4/inode.c |  2 +-
 fs/ext4/namei.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b7a15db4953..792b88522916 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3544,7 +3544,7 @@ static int ext4_map_blocks_atomic_write_slow(handle_t *handle,
 	ext4_lblk_t m_lblk = map->m_lblk;
 	unsigned int m_len = map->m_len;
 	unsigned int mapped_len = 0, m_flags = 0;
-	ext4_fsblk_t next_pblk;
+	ext4_fsblk_t next_pblk = NULL;
 	bool check_next_pblk = false;
 	int ret = 0;
 
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 2cd36f59c9e3..045616033515 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1762,7 +1762,7 @@ static struct buffer_head * ext4_dx_find_entry(struct inode *dir,
 static struct dentry *ext4_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
 {
 	struct inode *inode;
-	struct ext4_dir_entry_2 *de;
+	struct ext4_dir_entry_2 *de = NULL;
 	struct buffer_head *bh;
 
 	if (dentry->d_name.len > EXT4_NAME_LEN)
@@ -1818,7 +1818,7 @@ static struct dentry *ext4_lookup(struct inode *dir, struct dentry *dentry, unsi
 struct dentry *ext4_get_parent(struct dentry *child)
 {
 	__u32 ino;
-	struct ext4_dir_entry_2 * de;
+	struct ext4_dir_entry_2 * de = NULL;
 	struct buffer_head *bh;
 
 	bh = ext4_find_entry(d_inode(child), &dotdot_name, &de, NULL);
@@ -3133,7 +3133,7 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 	int retval;
 	struct inode *inode;
 	struct buffer_head *bh;
-	struct ext4_dir_entry_2 *de;
+	struct ext4_dir_entry_2 *de = NULL;
 	handle_t *handle = NULL;
 
 	retval = ext4_emergency_state(dir->i_sb);
@@ -3224,7 +3224,7 @@ int __ext4_unlink(struct inode *dir, const struct qstr *d_name,
 {
 	int retval = -ENOENT;
 	struct buffer_head *bh;
-	struct ext4_dir_entry_2 *de;
+	struct ext4_dir_entry_2 *de = NULL;
 	handle_t *handle;
 	int skip_remove_dentry = 0;
 
@@ -3688,7 +3688,7 @@ static int ext4_find_delete_entry(handle_t *handle, struct inode *dir,
 {
 	int retval = -ENOENT;
 	struct buffer_head *bh;
-	struct ext4_dir_entry_2 *de;
+	struct ext4_dir_entry_2 *de = NULL;
 
 	bh = ext4_find_entry(dir, d_name, &de, NULL);
 	if (IS_ERR(bh))
-- 
2.43.0


