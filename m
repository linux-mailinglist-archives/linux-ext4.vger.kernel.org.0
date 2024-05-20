Return-Path: <linux-ext4+bounces-2588-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4874B8C98D7
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 07:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2B4328215C
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 05:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B366818E28;
	Mon, 20 May 2024 05:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfeZ/Zug"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B870E17BAB
	for <linux-ext4@vger.kernel.org>; Mon, 20 May 2024 05:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716184335; cv=none; b=GoKGLvMGaCVwV69yXJX5sGI9/n9bTEDLJ7w0gAwZGy5yJDYZG0LqPx/Mw6DoETiNteZtTv5/BAPzW1xnR1yTh9zzteLdyN0NyUnr/VWef6j3dfkJjW6rNOjFVXtZdbutfvG0hB51Kb6aIyHi6CGuwmRAhwDDb6ivCa1VnInMtHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716184335; c=relaxed/simple;
	bh=wu7YEzq+lRilSD4JZCge6AI1ow5y+pV4swLuWDyXUNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+tgQzp1a0GSKQAzs8hWEP7YdcC1zjwd/4ApLLxaYaDVlho3OhMMc+DJ3FkHNA9D3pGFEs757wiMXIjb0ZhXFMfVRiMhap2tWTLRudzqmw0AAeEuH8g3RZzU6HHCxQ4Qb+DaGREKOmeHg8iH7Y6kOem4kV0vmz5daztq4F9w/kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfeZ/Zug; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6f0f87f9545so1873702a34.2
        for <linux-ext4@vger.kernel.org>; Sun, 19 May 2024 22:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716184333; x=1716789133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWW/wNZKk20Q5d+2ZvU6dyAte2Ib7vphR0PBwrIMDPM=;
        b=XfeZ/ZugeNt7hW4q1GX3YcXuIqRXRFy7VvxZDiODo65XsM6bYX+ip6eGHkUGoOXCHH
         Bja/wpfc6XmjXuDHs+M2Mkc+zNnaccbYveP/0ANs9CrNqrtwYWM7s5Nv+I1jjyK9ceF0
         lhbSyHY0cXjuMSDHXBrTorjxHASoREupOaHb57sBqgscsGVYQ4Kadednu3SxEevxbZLG
         7Qu5fvQkKbLxCOmHZvyrYeOBHuxxrtkwQOyZAlVdRSTrJDVwGvi03tvMyjILWhLpvgEp
         iwfiEsU5gkyK+8lO34AaQZ48TE7Sx8JFvz3FZlgdYClEN4EY+GqzvaK83EG2+duQ3Hkz
         micg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716184333; x=1716789133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWW/wNZKk20Q5d+2ZvU6dyAte2Ib7vphR0PBwrIMDPM=;
        b=tFvdVFVrlmYt3kV8WDe1ITAqsBgp7dyJDamHzlPiZdh7p+HcDVGFUaRpkeVb2/na1+
         WQUGVvE+ywMw95UPmwjh9ypCJPWEhg645EnpaC4pju9jGbNV19NwBy15eQTmHzXHTLZE
         1QdcFtw7H0cwIQFnK8Y04OMIpBzvDEeAY7/U17CY8fEs1uY6lK1uFzOQ4b5i+Uvr2JY8
         LpWoRt1ByzbQGF+qfGa/MNPc803GEVFnB2fdz8YXUuXlPSnnT9VJbvjvVqKl8273RDc/
         SZb+RArlSP5tEDazK/YP4rOFJLmX3vBfJTDDkEXGFb2QieeyV6eyoz2YgwVXhuVUM+Np
         zuSQ==
X-Gm-Message-State: AOJu0YyaEX1+lFFQe/MFFcI2b7YE70SnGrO+Hvy8iMeRMj7pN6A7Pi6H
	jRpixsJ1xcMi0gS5mgYO1HtCorqoep9dpJJ0jAFP+i78L2AZwlz3jqV2ltWM
X-Google-Smtp-Source: AGHT+IFv80HJPeJa2CEiH4hGNxlON3YpwFHtH/MMZlG/1ZmCzBaBKU8YZ9Y9LKO8xQYxGFhAEogGOw==
X-Received: by 2002:a05:6830:1143:b0:6ee:23dd:7441 with SMTP id 46e09a7af769-6f0e92cbbd1mr29431956a34.28.1716184332689;
        Sun, 19 May 2024 22:52:12 -0700 (PDT)
Received: from harshads.c.googlers.com.com (34.85.168.34.bc.googleusercontent.com. [34.168.85.34])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-659f66bf18csm6769297a12.46.2024.05.19.22.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 22:52:12 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	saukad@google.com,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 07/10] ext4: add nolock mode to ext4_map_blocks()
Date: Mon, 20 May 2024 05:51:50 +0000
Message-ID: <20240520055153.136091-8-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240520055153.136091-1-harshadshirwadkar@gmail.com>
References: <20240520055153.136091-1-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add nolock flag to ext4_map_blocks() which skips grabbing
i_data_sem in ext4_map_blocks. In FC commit path, we first
mark the inode as committing and thereby prevent any mutations
on it. Thus, it should be safe to call ext4_map_blocks()
without i_data_sem in this case. This is a workaround to
the problem mentioned in RFC V4 version cover letter[1] of this
patch series which pointed out that there is in incosistency between
ext4_map_blocks() behavior when EXT4_GET_BLOCKS_CACHED_NOWAIT is
passed. This patch gets rid of the need to call ext4_map_blocks()
with EXT4_GET_BLOCKS_CACHED_NOWAIT and instead call it with
EXT4_GET_BLOCKS_NOLOCK. I verified that generic/311 which failed
in cached_nowait mode passes with nolock mode.

[1] https://lwn.net/Articles/902022/

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h        |  1 +
 fs/ext4/fast_commit.c | 16 ++++++++--------
 fs/ext4/inode.c       | 14 ++++++++++++--
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index d802040e94df..196c513f82dd 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -720,6 +720,7 @@ enum {
 #define EXT4_GET_BLOCKS_IO_SUBMIT		0x0400
 	/* Caller is in the atomic contex, find extent if it has been cached */
 #define EXT4_GET_BLOCKS_CACHED_NOWAIT		0x0800
+#define EXT4_GET_BLOCKS_NOLOCK			0x1000
 
 /*
  * The bit position of these flags must not overlap with any of the
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index b81b0292aa59..0b7064f8dfa5 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -559,13 +559,6 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
 		!list_empty(&ei->i_fc_list))
 		return;
 
-	/*
-	 * If we come here, we may sleep while waiting for the inode to
-	 * commit. We shouldn't be holding i_data_sem in write mode when we go
-	 * to sleep since the commit path needs to grab the lock while
-	 * committing the inode.
-	 */
-	WARN_ON(lockdep_is_held_type(&ei->i_data_sem, 1));
 
 	while (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
 #if (BITS_PER_LONG < 64)
@@ -898,7 +891,14 @@ static int ext4_fc_write_inode_data(struct inode *inode, u32 *crc)
 	while (cur_lblk_off <= new_blk_size) {
 		map.m_lblk = cur_lblk_off;
 		map.m_len = new_blk_size - cur_lblk_off + 1;
-		ret = ext4_map_blocks(NULL, inode, &map, 0);
+		/*
+		 * Given that this inode is being committed,
+		 * EXT4_STATE_FC_COMMITTING is already set on this inode.
+		 * Which means all the mutations on the inode are paused
+		 * until the commit operation is complete. Thus it is safe
+		 * call ext4_map_blocks() in no lock mode.
+		 */
+		ret = ext4_map_blocks(NULL, inode, &map, EXT4_GET_BLOCKS_NOLOCK);
 		if (ret < 0)
 			return -ECANCELED;
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 26b9d3076536..c6405c45970e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -546,7 +546,8 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 	 * Try to see if we can get the block without requesting a new
 	 * file system block.
 	 */
-	down_read(&EXT4_I(inode)->i_data_sem);
+	if (!(flags & EXT4_GET_BLOCKS_NOLOCK))
+		down_read(&EXT4_I(inode)->i_data_sem);
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
 		retval = ext4_ext_map_blocks(handle, inode, map, 0);
 	} else {
@@ -573,7 +574,15 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
 				      map->m_pblk, status);
 	}
-	up_read((&EXT4_I(inode)->i_data_sem));
+	/*
+	 * We should never call ext4_map_blocks() in nolock mode outside
+	 * of fast commit path.
+	 */
+	WARN_ON((flags & EXT4_GET_BLOCKS_NOLOCK) &&
+		!ext4_test_inode_state(inode,
+				       EXT4_STATE_FC_COMMITTING));
+	if (!(flags & EXT4_GET_BLOCKS_NOLOCK))
+		up_read((&EXT4_I(inode)->i_data_sem));
 
 found:
 	if (retval > 0 && map->m_flags & EXT4_MAP_MAPPED) {
@@ -614,6 +623,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 	 * the write lock of i_data_sem, and call get_block()
 	 * with create == 1 flag.
 	 */
+	WARN_ON((flags & EXT4_GET_BLOCKS_NOLOCK) != 0);
 	down_write(&EXT4_I(inode)->i_data_sem);
 
 	/*
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


