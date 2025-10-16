Return-Path: <linux-ext4+bounces-10908-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B93BE44FB
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 17:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7CA7B4E8F68
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 15:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61675341AAE;
	Thu, 16 Oct 2025 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1ro4u0L"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DCB2E764B
	for <linux-ext4@vger.kernel.org>; Thu, 16 Oct 2025 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629439; cv=none; b=UWVnSi2uZG3/Q9Ti044HKjFyntuBzTLDVnMbzYfHUuJ8Yry/bXeTs9/Dx6PAoZOsJ63qNBvbc1ROfpAXbS48FQEGqnu5n472vHsjdeTRqEfsGEz52POqryN3Gj869+l/OBP9SrwbW3KVsAW/OmkQHjYZFXwfm4OagbU08DO47Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629439; c=relaxed/simple;
	bh=0xXP5qRN68fL1gVP/QCDzUE4fnu5i8aHPWLEuTBkPyI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XZXc2IEsBamgVUpSVotyCed32ngIGY/bDuzHnoYbf2Q87wI5c7DlepB7SxuP4DZwXmu33rWk90pJCgpy/PGdo8nkoO+wDCdzhM6VDcCuC05hbHrs06InaoqdHHLtXszJQUZ1rwlALjHT/9mBI7JOaOr3xRYI+70I5bh8sNHTkdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1ro4u0L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A86C4CEF1;
	Thu, 16 Oct 2025 15:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760629438;
	bh=0xXP5qRN68fL1gVP/QCDzUE4fnu5i8aHPWLEuTBkPyI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=T1ro4u0LIETmEJS1OLVLPsMzRNGDHnp4HWMi5OzyEhvKAPL0/KCscZodeQHszn6hR
	 nLaDwPBtJMzqf2XW7Ac1z/3PHkHsfq+V28WRpRGSC1X4bCgOi+wBV0ufQ0aXuG9Dzf
	 Un+mr5WJPEq2CKacNh4VcI4X3B4mDwPnXI7H5ASTKVimzvc3GSl0eLCTekHHWVhcu3
	 vZYeBpy/Bf6RN868CDvvcdI12sUOJucoUhtJPoAxqBswxirdLUbc8GXNnAscCMrX1A
	 4SrPAQ53pTNxc2ToGISN1a14bYa6q92o55bo5WMaxcrR2L2i/aIroK+aC86XK3hUvf
	 PsdxFPLBtLDxA==
Date: Thu, 16 Oct 2025 08:43:58 -0700
Subject: [PATCH 16/16] fuse2fs: spot check clean journals
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <176062915755.3343688.6287848560218999608.stgit@frogsfrogsfrogs>
In-Reply-To: <176062915393.3343688.9810444125172113159.stgit@frogsfrogsfrogs>
References: <176062915393.3343688.9810444125172113159.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Even though fuse2fs doesn't (yet) support writing new transactions to
the journal, we ought at least to check that the superblock is ok when
we mount a clean filesystem.  This fixes complaints by ext4/012 about
mount failing to notice a corrupt journal.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 81cbf1ef4f5dab ("misc: add fuse2fs, a FUSE server for e2fsprogs")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 debugfs/journal.h |    2 ++
 debugfs/journal.c |    2 +-
 misc/fuse2fs.c    |    7 +++++++
 3 files changed, 10 insertions(+), 1 deletion(-)


diff --git a/debugfs/journal.h b/debugfs/journal.h
index 10b638ebaab5db..67b8c99828bb0d 100644
--- a/debugfs/journal.h
+++ b/debugfs/journal.h
@@ -18,6 +18,8 @@
 errcode_t ext2fs_open_journal(ext2_filsys fs, journal_t **j);
 errcode_t ext2fs_close_journal(ext2_filsys fs, journal_t **j);
 errcode_t ext2fs_run_ext3_journal(ext2_filsys *fs);
+errcode_t ext2fs_check_ext3_journal(ext2_filsys fs);
+
 void jbd2_commit_block_csum_set(journal_t *j, struct buffer_head *bh);
 void jbd2_revoke_csum_set(journal_t *j, struct buffer_head *bh);
 void jbd2_descr_block_csum_set(journal_t *j, struct buffer_head *bh);
diff --git a/debugfs/journal.c b/debugfs/journal.c
index a6d8d4c5adf9cf..f79abcccf6adea 100644
--- a/debugfs/journal.c
+++ b/debugfs/journal.c
@@ -681,7 +681,7 @@ static void ext2fs_journal_release(ext2_filsys fs, journal_t *journal,
  * This function makes sure that the superblock fields regarding the
  * journal are consistent.
  */
-static errcode_t ext2fs_check_ext3_journal(ext2_filsys fs)
+errcode_t ext2fs_check_ext3_journal(ext2_filsys fs)
 {
 	struct ext2_super_block *sb = fs->super;
 	journal_t *journal;
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 210807ea493f51..e33b09de08a11f 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -192,6 +192,7 @@ static inline uint64_t round_down(uint64_t b, unsigned int align)
 # define FL_ZERO_RANGE_FLAG (0)
 #endif
 
+errcode_t ext2fs_check_ext3_journal(ext2_filsys fs);
 errcode_t ext2fs_run_ext3_journal(ext2_filsys *fs);
 
 #ifdef CONFIG_JBD_DEBUG		/* Enabled by configure --enable-jbd-debug */
@@ -4819,6 +4820,12 @@ int main(int argc, char *argv[])
 			ext2fs_clear_feature_journal_needs_recovery(global_fs->super);
 			ext2fs_mark_super_dirty(global_fs);
 		}
+	} else if (ext2fs_has_feature_journal(global_fs->super)) {
+		err = ext2fs_check_ext3_journal(global_fs);
+		if (err) {
+			translate_error(global_fs, 0, err);
+			goto out;
+		}
 	}
 
 	if (global_fs->flags & EXT2_FLAG_RW) {


