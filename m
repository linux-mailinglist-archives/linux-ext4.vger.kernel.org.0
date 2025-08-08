Return-Path: <linux-ext4+bounces-9284-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA14B1E410
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Aug 2025 10:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92B2F3AB897
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Aug 2025 08:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3877324A05B;
	Fri,  8 Aug 2025 08:06:46 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from omta003.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0C84AEE2
	for <linux-ext4@vger.kernel.org>; Fri,  8 Aug 2025 08:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.97.99.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754640406; cv=none; b=Mc04AgTsKBeqUVV14o5i3VwHSG2+m4IIdq+XtOXw4fjjstA5pg88JpP9cO9QdfXDLLDJOoT2A54P7Ble50rgWqFt6k10EpLxrmKwMSIme50Lw1wQrNf+Nl5iYoNmG2ag9DwaF6midRnPE5Dls/t3AABg+XfqObS3tUo/TAgbiDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754640406; c=relaxed/simple;
	bh=DCms4VkDzKFNblfh2PhJ+rY4JHIzCbwh8pKfrtIr12k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wkb1xfKg1mu70uY+PD8PhGhlZmbx7bdWJA1EI4NqDy3CiAYXK6CqGXGB1VpkbPU/j+hGeiLzH1+fXL+WY9dliRGgigKLHo78MB8aFt2dVr38o1Ab8Bc0x3NSFH7wqN2GgcrNzadEctPqnOP49GwEXDUuHLdCXBB0fgyQI80cPsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; arc=none smtp.client-ip=3.97.99.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: from shw-obgw-4001a.ext.cloudfilter.net ([10.228.9.142])
	by cmsmtp with ESMTPS
	id kAy7uYMa59JM2kI66udL9S; Fri, 08 Aug 2025 08:05:06 +0000
Received: from cabot.adilger.int ([70.77.200.158])
	by cmsmtp with ESMTP
	id kI65uvtluWX70kI65uMYcc; Fri, 08 Aug 2025 08:05:06 +0000
X-Authority-Analysis: v=2.4 cv=d71WygjE c=1 sm=1 tr=0 ts=6895afb2
 a=0Thh8+fbYSyN3T2vM72L7A==:117 a=0Thh8+fbYSyN3T2vM72L7A==:17 a=ySfo2T4IAAAA:8
 a=lB0dNpNiAAAA:8 a=1rRP3Pm-Zha4dS9LYPEA:9 a=ZUkhVnNHqyo2at-WnAgH:22
 a=c-ZiYqmG3AbHTdtsH08C:22
From: Andreas Dilger <adilger@dilger.ca>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org,
	Andreas Dilger <adilger@dilger.ca>,
	Andreas Dilger <adilger@whamcloud.com>,
	Li Dongyang <dongyangli@ddn.com>
Subject: [PATCHv2] ext2fs: fix fast symlink blocks check
Date: Fri,  8 Aug 2025 02:04:27 -0600
Message-ID: <20250808080505.1307694-1-adilger@dilger.ca>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfP0amQsfON78heTq6LJO7JXHz+FVoUI16PQsT7YY+9c7wPihYJ2kZkHzjcihyk/dLciN1nJhnDc5KHolHVrEErRT4WtVrYq3rpkDtcvWtpjNUZWtqfG2
 2W60HOxIoZM7wjcYJTlHGsytUskkTt9ui8VH0B9CLtyc2oJGLrNQXGe2B3c4ITJW4umv5lZh38y4lZj2gNa+Lxl5uJhE6YaGmJXei9vpJHUPBG5qGoboU5mw
 jtPEoMQBE1IrtBh7Bald5jmuCnvO1z5XKTvK8qH3XL3HsPomcTKDyH4zSC2axH8EVvP8g2cC0nI/fxngdQ0jdA==

Use ext4_inode_is_fast_symlink() in ext2fs_inode_has_valid_blocks2()
instead of depending exclusively on i_blocks == 0 to determine
if an inode is a fast symlink. Otherwise, if a fast symlink has a
large external xattr inode that increases i_blocks, it will be
incorrectly reported as having invalid blocks.

Change-Id: Ibde2348da39401601abedd603bd7e4ef97091abe
Fixes: 0684a4f33 ("Overhaul extended attribute handling")
Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
Reviewed-by: Li Dongyang <dongyangli@ddn.com>
Reviewed-on: https://review.whamcloud.com/59871
Lustre-bug-id: https://jira.whamcloud.com/browse/LU-19121
---
v1->v2: added f_ea_inode_fast_symlink test case

 lib/ext2fs/valid_blk.c                 |   1 +
 tests/f_ea_inode_fast_symlink/expect.1 |   7 +++++++
 tests/f_ea_inode_fast_symlink/expect.2 |   7 +++++++
 tests/f_ea_inode_fast_symlink/image.gz | Bin 0 -> 13789 bytes
 tests/f_ea_inode_fast_symlink/name     |   1 +
 5 files changed, 16 insertions(+)
 create mode 100644 tests/f_ea_inode_fast_symlink/expect.1
 create mode 100644 tests/f_ea_inode_fast_symlink/expect.2
 create mode 100644 tests/f_ea_inode_fast_symlink/image.gz
 create mode 100644 tests/f_ea_inode_fast_symlink/name

diff --git a/lib/ext2fs/valid_blk.c b/lib/ext2fs/valid_blk.c
index db5d90ae4..332e9c66a 100644
--- a/lib/ext2fs/valid_blk.c
+++ b/lib/ext2fs/valid_blk.c
@@ -43,6 +43,7 @@ int ext2fs_inode_has_valid_blocks2(ext2_filsys fs, struct ext2_inode *inode)
 			/* With no EA block, we can rely on i_blocks */
 			if (inode->i_blocks == 0)
 				return 0;
+			return !ext2fs_is_fast_symlink(inode);
 		} else {
 			/* With an EA block, life gets more tricky */
 			if (inode->i_size >= EXT2_N_BLOCKS*4)
diff --git a/tests/f_ea_inode_fast_symlink/expect.1 b/tests/f_ea_inode_fast_symlink/expect.1
new file mode 100644
index 000000000..b88456d00
--- /dev/null
+++ b/tests/f_ea_inode_fast_symlink/expect.1
@@ -0,0 +1,7 @@
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+test_filesys: 14/256 files (0.0% non-contiguous), 1147/8192 blocks
+Exit status is 0
diff --git a/tests/f_ea_inode_fast_symlink/expect.2 b/tests/f_ea_inode_fast_symlink/expect.2
new file mode 100644
index 000000000..b88456d00
--- /dev/null
+++ b/tests/f_ea_inode_fast_symlink/expect.2
@@ -0,0 +1,7 @@
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+test_filesys: 14/256 files (0.0% non-contiguous), 1147/8192 blocks
+Exit status is 0
diff --git a/tests/f_ea_inode_fast_symlink/image.gz b/tests/f_ea_inode_fast_symlink/image.gz
new file mode 100644
index 0000000000000000000000000000000000000000..f3872b3721fa8484e05cc3281d0bc745113fa775
GIT binary patch
literal 13789
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

literal 0
HcmV?d00001

diff --git a/tests/f_ea_inode_fast_symlink/name b/tests/f_ea_inode_fast_symlink/name
new file mode 100644
index 000000000..9eebeded8
--- /dev/null
+++ b/tests/f_ea_inode_fast_symlink/name
@@ -0,0 +1 @@
+fast symlink with ea_inode
-- 
2.43.5


