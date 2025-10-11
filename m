Return-Path: <linux-ext4+bounces-10785-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7275BCF089
	for <lists+linux-ext4@lfdr.de>; Sat, 11 Oct 2025 08:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802B53AADB1
	for <lists+linux-ext4@lfdr.de>; Sat, 11 Oct 2025 06:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB042147E6;
	Sat, 11 Oct 2025 06:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="decIIU/7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6669921930A
	for <linux-ext4@vger.kernel.org>; Sat, 11 Oct 2025 06:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760164722; cv=none; b=ebAVDJh/WA40McLtDlAVn0vbRQRd2rDZ6PVdzHXkMxZ1fkXNRG1A8I/GIubfb0s0r9mK0CW/j5x1boLcpvkS5P7yItXOKaEK3h7m/Uk0O+F1VbD/d5PHj1zgvKv+GvGsy/1PV20CSnEOOzshgrDjIWAh3pgcqOnLwLeO+TUrijU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760164722; c=relaxed/simple;
	bh=LjdMP4wX5K2PJoIkDNssZ0x5qpw4jYUvKfOFzldt+78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=leRkfqeqxE509+rNiTrvOJGFUWY72RiHxafVPS+vLAyJ1675GFT8gInXuSp0xH+WlewpREQQ+GYMxTqd9eWxhqK119i561QyyCllxLAK1i0L1NdPj6+3h+nzjF0UAjde5/R/NgJTDqI9ABD906nEgeRmpjXmNvU+znDZCTH92ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=decIIU/7; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32ebcef552eso640468a91.0
        for <linux-ext4@vger.kernel.org>; Fri, 10 Oct 2025 23:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760164720; x=1760769520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4KsdyrgfWB/FqT6OOcbFSO1XBvuLxrHfzAVePQ1iTY=;
        b=decIIU/7mEcJBYlwWbXUi7CyqhPn2bqONs86NcMs4yZ8v40vy95Pp8EXXBdCbhim6R
         1/A6YfAiKaeguMLCJ7wukvmh9c9iRqNGQAJebMu040WCSw9PT2nIgvreKlAKZKFcTEWt
         3jUYy61zKCuwsdmlU87zZvoCvhr2TkusC0Z4/3tyBNvlWBp0fhKWX6XmRp/cdwwbHWyG
         10S3I5tjmefWq2MVe3GUrne03Le4U15ukBXEGpQudijXHLCXWuGMUPHXhLeba918dmyn
         GAhS8mjS/UxYHO8up2PL15Un7f0nYSNjUuAE8eoBm3fi5ubyxZn7hgHGwN0TVfZco/S+
         6P7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760164720; x=1760769520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4KsdyrgfWB/FqT6OOcbFSO1XBvuLxrHfzAVePQ1iTY=;
        b=mHE4c4yPkJs03ocgsreZCuHKfFkksabTps5isjpS7l/A9S6g5g5LmqOAAA+1Pf9Gno
         N1ko6mW+Of7zCJzoctkUoGLJ5Oe09NrfDX+EwMSoSHl5RS9AQ0HeZC8YUeFhVe20RKvH
         /u4S/y7NuZhFWsM66YrP8vJ3p8596dqMAauIDAx+AYe7jUJ9qBA7X4zo3V7VWsFaL/8d
         9rFVptmjkFlsKchZ+k3znhLo2GUCcgfchPPWEYDfUTXpG3FGzoTncLNR5qDQsm/ukw8Q
         2jnVbCou0goKGoTrEMTQ1Oi8ycuwDDjFA+9ZwoO7lUtw9Xeb+94LLvF8mpDuuPCpVTKP
         setA==
X-Forwarded-Encrypted: i=1; AJvYcCXEjz17rBOXNUAq1vRuaeiYjnPq3ByJ35coNd8PQ+l3xUWMBTt58lpbVsDtffsnXkJNLyGJVcusA1MV@vger.kernel.org
X-Gm-Message-State: AOJu0YzCzO6xXaSSdXoy9ey49T538Eo5xDLZ9grWUS0BTjO/+A+zNzMM
	gJMU0QEhGFNl6xPSWAp1VOKyGCG6XiiiNd9QAh3SlMwJjdFK9pi9fE33
X-Gm-Gg: ASbGncuiy2NFK2F+93vWiNH2O1XM/S+bWRVW9EtKpHzfwXKOdTmMTUpfUp7dpiWFHJZ
	m5qkS9jKS2BTKc804sA63O3ionKGtaiUrIs9YGsXpMEO+ewJBbWN0pHl5nPvKGNIz4wkPRkxM+M
	/lpMdLC0JinqAWCN8w6ItOR6hAXImqy1tJB0aiDI4W6wwSgRpJVvWyf5qoj+1cgT1KZLuxQChDj
	MlDX/HJKPdy8byYKn4GTFae6/N9GaCN/xIiordsiJi9LDV1G/xtH8PwUvsMFB02jj/T7V9MLxA/
	3a/gW/v6vLzGJIhX6qtV4cEvyC1MHuSl2cs3aKbQrwckaWmf1Cu6/MnuTk4JwQrFTBH8qf1ouxl
	1pOHFBsxcRKr4OJSoXUYKK9Q33QFlshuZxd0jOSQDPs+ONwSh
X-Google-Smtp-Source: AGHT+IF1JQXObCuG7xFhogMbxfyVhO5SQR9FmzcjivYXOk8ZFuH6BJG6HLBb/IJlGVfYnt4qekicwg==
X-Received: by 2002:a17:903:1a6f:b0:257:3283:b859 with SMTP id d9443c01a7336-29027321d06mr119587995ad.9.1760164720383;
        Fri, 10 Oct 2025 23:38:40 -0700 (PDT)
Received: from ranganath.. ([2406:7400:98:ffd0:8dcb:f5b3:8234:d05])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034dea083sm76040465ad.24.2025.10.10.23.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 23:38:39 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
To: lkp@intel.com
Cc: adilger.kernel@dilger.ca,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-ext4@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev,
	skhan@linuxfoundation.org,
	tytso@mit.edu,
	vnranganath.20@gmail.com
Subject: [PATCH v2] fs: ext4: fix uninitialized symbols
Date: Sat, 11 Oct 2025 12:08:29 +0530
Message-ID: <20251011063830.47485-1-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <202510110207.yBvUMr5Z-lkp@intel.com>
References: <202510110207.yBvUMr5Z-lkp@intel.com>
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

These changes enhance code clarity, address static analysis tool errors.

Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---

v2:
corrected the kernel test robot noticed build errors.

 fs/ext4/inode.c |  2 +-
 fs/ext4/namei.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 5b7a15db4953..f20db3f4ef68 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3544,7 +3544,7 @@ static int ext4_map_blocks_atomic_write_slow(handle_t *handle,
 	ext4_lblk_t m_lblk = map->m_lblk;
 	unsigned int m_len = map->m_len;
 	unsigned int mapped_len = 0, m_flags = 0;
-	ext4_fsblk_t next_pblk;
+	ext4_fsblk_t next_pblk = 0;
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


