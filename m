Return-Path: <linux-ext4+bounces-8096-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 846CEABFFBC
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35A5C4E4DF1
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117B2239E85;
	Wed, 21 May 2025 22:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhxugOb/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F00230269
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867161; cv=none; b=ZFqMl2V74Yfkvo+AmTdYbkYWF8jacDB4W0wz66FoMBhzPdS/7hUhboTmaztjRVR6dvPrbUf2FErlM6axKX6DUDRH1loKXJ/16MJnyhclKvgn9wiACqBsBVhd2lM0tMz+mfJ+zvbXpsl1R4yXPBOVnCHScWdAgqDbwZSPzSsgXqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867161; c=relaxed/simple;
	bh=0hAqkF1wJgJh8qbmypf5Z3hMFBAJup/4jlF5RuGV8io=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aLuvUgu45tCSz/WkcAL55V6lrV+TIfxEqtV0rTD9OjNmezeD1pcG7jbAGdcwstqbDCPPj5ykte7/AfQQyknSuqLCbvkl+mPvLEaD6MyuNU+V0OWkcMUUKI5tBQj+bPTcurXp4isZSaT9PmYq3ecQIwJkV3L9Zemi7YXgOGqNLyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhxugOb/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FF4C4CEE4;
	Wed, 21 May 2025 22:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867161;
	bh=0hAqkF1wJgJh8qbmypf5Z3hMFBAJup/4jlF5RuGV8io=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=RhxugOb/qPUcI39o1VYOdb8iPLTCj77pqUlnmPzIE2+gzi6BzN0cU6enfAU33ddFv
	 ivgjVSDDPzO3VFbCz2PPIY9gg1EhAaJWdmhZ3QLewv6M2nC30W6vEBqhl1zTa81TLZ
	 IAzCaXdUKQP7rn9AsDDItsLfePwbt6GEvtmFawHNOjdfgCqmJ+sI0/n0aRouFzuVei
	 YpB9TdaGTAJ23ayBuO9Rp5UuKsqS//YaoBPP8Q1/kSIr5lRSJXrLw9jTckOh4IccqZ
	 Llh1so7gvzHqsAwxNENevoYArgwUOWSw3yMxwE/7MsHJam3LAH6Rch1jOobkzt4XKT
	 j61nUEHx46DLg==
Date: Wed, 21 May 2025 15:39:21 -0700
Subject: [PATCH 17/29] fuse2fs: make bad magic numbers report a corruption
 error too
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786677853.1383760.10493605429423115597.stgit@frogsfrogsfrogs>
In-Reply-To: <174786677421.1383760.15289906755026332870.stgit@frogsfrogsfrogs>
References: <174786677421.1383760.15289906755026332870.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Report bad magic numbers as corruption errors too.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 6b5b19062b4ca1..e73730cfe27130 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4275,6 +4275,37 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 	case EXT2_ET_UNIMPLEMENTED:
 		ret = -EOPNOTSUPP;
 		break;
+	case EXT2_ET_MAGIC_EXT2FS_FILSYS:
+	case EXT2_ET_MAGIC_BADBLOCKS_LIST:
+	case EXT2_ET_MAGIC_BADBLOCKS_ITERATE:
+	case EXT2_ET_MAGIC_INODE_SCAN:
+	case EXT2_ET_MAGIC_IO_CHANNEL:
+	case EXT2_ET_MAGIC_UNIX_IO_CHANNEL:
+	case EXT2_ET_MAGIC_IO_MANAGER:
+	case EXT2_ET_MAGIC_BLOCK_BITMAP:
+	case EXT2_ET_MAGIC_INODE_BITMAP:
+	case EXT2_ET_MAGIC_GENERIC_BITMAP:
+	case EXT2_ET_MAGIC_TEST_IO_CHANNEL:
+	case EXT2_ET_MAGIC_DBLIST:
+	case EXT2_ET_MAGIC_ICOUNT:
+	case EXT2_ET_MAGIC_PQ_IO_CHANNEL:
+	case EXT2_ET_MAGIC_E2IMAGE:
+	case EXT2_ET_MAGIC_INODE_IO_CHANNEL:
+	case EXT2_ET_MAGIC_EXTENT_HANDLE:
+	case EXT2_ET_BAD_MAGIC:
+	case EXT2_ET_MAGIC_EXTENT_PATH:
+	case EXT2_ET_MAGIC_GENERIC_BITMAP64:
+	case EXT2_ET_MAGIC_BLOCK_BITMAP64:
+	case EXT2_ET_MAGIC_INODE_BITMAP64:
+	case EXT2_ET_MAGIC_RESERVED_13:
+	case EXT2_ET_MAGIC_RESERVED_14:
+	case EXT2_ET_MAGIC_RESERVED_15:
+	case EXT2_ET_MAGIC_RESERVED_16:
+	case EXT2_ET_MAGIC_RESERVED_17:
+	case EXT2_ET_MAGIC_RESERVED_18:
+	case EXT2_ET_MAGIC_RESERVED_19:
+	case EXT2_ET_MMP_MAGIC_INVALID:
+	case EXT2_ET_MAGIC_EA_HANDLE:
 	case EXT2_ET_DIR_CORRUPTED:
 	case EXT2_ET_CORRUPT_SUPERBLOCK:
 	case EXT2_ET_RESIZE_INODE_CORRUPT:


