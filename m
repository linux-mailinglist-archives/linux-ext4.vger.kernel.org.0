Return-Path: <linux-ext4+bounces-8256-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B13AC9EDB
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Jun 2025 16:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08651657F8
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Jun 2025 14:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61F51B0F19;
	Sun,  1 Jun 2025 14:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="Brkthi0b"
X-Original-To: linux-ext4@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81371DED78
	for <linux-ext4@vger.kernel.org>; Sun,  1 Jun 2025 14:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748787757; cv=none; b=jOtCo+AVUlL3tap2RLxp7oxXKlUR3d3OhU9igFiGSOfFg/Uwzwa0dHOzNQ/xhlmdMMTYsRJqiyilCUQ3LiJSNkidhUDg4n7kDtorB4lhKvwUs8VcftFERAHiq+SKdDKMKPYbnshmNg6ysKrrcdc9W8eA9cVd2AYE27ZKIXfdqGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748787757; c=relaxed/simple;
	bh=xj257tgn7Z1MNSmQWlBRe2nFYmTztvLX3vJvvs/VaAw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=B5y7PD8ZaBU7J9bplpBks3MuEvdDfngT1oKZLw1Qj6zbEQo0ZHCD8MK6tidtVr6Xo71n4hOkoE96TxvIy+9xnt9HoGxzMLJGkDXrKMFMZ5cgYIODWiTV4q5Fkcbamzc5G41qvulRE+/Inghx/YHHEpu8lmO/e1nf3agc0HBM+2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=Brkthi0b; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
X-KPN-MessageId: f7a75a1b-3ef3-11f0-a830-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id f7a75a1b-3ef3-11f0-a830-005056abad63;
	Sun, 01 Jun 2025 16:23:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=AvmgXbOGq57aGNnXZMAmEbRiltg+Gs6xirrsGgTKc+g=;
	b=Brkthi0bli2EjIfN1PQ+191N1gjSQIMez981X9Biub9rOrOnqfxNyem4XV/NflO09tCuouc6VrAmb
	 nT4CirJcIUUN4mPhFU3D8vFmlcBOaOL+eP5Y4cf7etokf+q4iX1KAfLENS20YNOdTG5gwWKQ3lqU7j
	 eAx5ddmqZzEi3jWE=
X-KPN-MID: 33|zNf46mG2kPCcXuWAZa1fNmGc7Wp1/XjrzAqShla7iJHCea5R6aVd3ti5dbTfC3/
 JJULM2Wl1mPcfyuGf8rYWQQkw7PLNhO6gimb7nplh/3U=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|eLfmhitAxRD5BbV/NyWaW/488vBbmXaJgGc7AognvTU+r3+vPGtJRSK4wV1fK3Z
 fPlHb/8lHbdgD8jyvfh6BIA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id d9b22a59-3ef3-11f0-95af-005056abf0db;
	Sun, 01 Jun 2025 16:22:30 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: linux-ext4@vger.kernel.org
Subject: [PATCH] fix several typos in the latest Release Notes
Date: Sun,  1 Jun 2025 16:22:17 +0200
Message-ID: <20250601142217.17820-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>

Something is missing in the following sentence in the "UI and Features"
section, but I don't know what:

  Add mke2fs.conf knobs to control whether the RAID stripe or stride sizes
  from the storage device information depending on whether the storage
  device is a rotational or non-rotational device.
---
 doc/RelNotes/v1.47.3.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/doc/RelNotes/v1.47.3.txt b/doc/RelNotes/v1.47.3.txt
index 2a24001d..e3699b3c 100644
--- a/doc/RelNotes/v1.47.3.txt
+++ b/doc/RelNotes/v1.47.3.txt
@@ -28,7 +28,7 @@ Fixes
 -----
 
 Fix "e2fsck -E unshare_blocks" to clear the shared_blocks flag when
-there are no shared blocks to clear
+there are no shared blocks to clear.
 
 Fix "e2fsck -n" to not abort when it trips across an EA inode which
 is not referenced by any inodes in the file system.
@@ -41,7 +41,7 @@ Fix debugfs's dirsearch command on big-endian systems.
 Fix many fuse2fs bugs found by running fstests, including fixing
 support for O_APPEND, O_TRUNC, POSIX ACLs, and the immutable flag.  Also
 fix fuse2fs to correctly remove ea_inodes if the last reference to an
-ea_inode is removed when an inode is removed, and to update timestmps
+ea_inode is removed when an inode is removed, and to update timestamps
 correctly after the mkdir(2) and symlink(2) operations.
 
 Fix fuse2fs's error code handling for fallocate(), truncate() and
@@ -75,7 +75,7 @@ potentially leading to a corrupted extent tree.
 
 Fix potential livelock bug in the unix_io manager.
 
-Fix invaidation support in the unix_io manager.
+Fix invalidation support in the unix_io manager.
 
 Various man page cleanups.
 
@@ -90,7 +90,7 @@ Improve tune2fs's performance by avoiding scanning the file system to
 update quota inodes in cases when it's not necessary.
 
 Improve fuse2fs's performance by returning inode and type information in
-readdir() and to use the actal inode numbers instead of asking fuse
+readdir() and to use the actual inode numbers instead of asking fuse
 to make up inode numbers.
 
 Fix various Coverity and compiler warnings.
@@ -110,17 +110,17 @@ created directory.
 Add new functions ext2fs_log2_u{32,64}() and ext2fs_log10_u{32,64}() so
 we don't have multiple copies of these functions in various e2fsprogs
 programs.
-        
+
 Improve debugging and logging in fuse2fs.
 
-General code cleaups in fuse2fs.
+General code cleanups in fuse2fs.
 
 Improve fuse2fs's performance by allowing a larger cache in unix_io and
 using O_DIRECT to read and write the block device.
 
-Fixed Windows portability problems intrduced in 1.47.2.
+Fixed Windows portability problems introduced in 1.47.2.
 
-Fixed potention races in the Makefiles which could show up when using
+Fixed potential races in the Makefiles which could show up when using
 "make -j install".
 
 Fixed build failures when libarchive is not available.
-- 
2.48.1


