Return-Path: <linux-ext4+bounces-7474-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C518A9BA0C
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 23:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 830B81BA38CA
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 21:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DAC21E087;
	Thu, 24 Apr 2025 21:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJUMV3yi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA36198851
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 21:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745530957; cv=none; b=rCxCW8B7P3jv3e7b8z6b8wUWrZ9ANW1jgr+VdlJNqXrzI9EtE/I2q4Vfe3/NOTunxv0+iZHFwz7Uz+fwQ7HwmUtkGKaXGB5g6n9+69OmE2n/I+r8sAoZitQqpugjy/qDmuTLAIFob5fZuletMUX3CFTbz6N0FOEHtJclps28RTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745530957; c=relaxed/simple;
	bh=hfSbPHxvzK2ie1tDWhDt2mANUHzXZfQHNwkeRxQ17lU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E344q9elIKjszyZGblD4ynhEKWfDUx469hcOuy/lILIL3x7MJt2t2z+PHG9VnwJRO/NWxxOPLCMx7+1/ruZAIRgiU0bEQFTDdXhY3BczRdIqDApUqfshWGC+6FXQmXIRSLdDBwOzJ2oJu8E9tJlZz+F+Y3u/kxSV0PvKvpK016M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJUMV3yi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0118FC4CEE3;
	Thu, 24 Apr 2025 21:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745530957;
	bh=hfSbPHxvzK2ie1tDWhDt2mANUHzXZfQHNwkeRxQ17lU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=WJUMV3yiIg2zKNnLguim090rXRfy3GatOfvxIB5n+Sd46/fkMOyQt2dr5Jpxo9V7C
	 443RV1AGVc7JaYGz4sO+T/sZ5W5h7GcMOzTcsBupsFfcX9CRcLkzTN5lpbPOvm0puk
	 ZgrTroE7OarGBGCqnyknEITLdyAHayI6p1VIy69GpBLNSieeQGlrVJFhPNEYNPj2M7
	 MUpTrrXXqSSTYnJYUYKC1bu1NiCNZBKnlw0TUqSkfQ6ZiKTta3kZ4dXLfBSfOIQiF4
	 wPlTWhhv4K0/GpWzXrGK0XJ2U3O+vw9lr+oHWAY9CRHcpKymbzYC6P8UgbvDB4lQK6
	 8+v7751vZXrJg==
Date: Thu, 24 Apr 2025 14:42:36 -0700
Subject: [PATCH 07/16] fuse2fs: report nanoseconds resolution through getattr
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174553065051.1160461.5080284869849276746.stgit@frogsfrogsfrogs>
In-Reply-To: <174553064857.1160461.865616278603382583.stgit@frogsfrogsfrogs>
References: <174553064857.1160461.865616278603382583.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Report the nanonseconds component of timestamps via getattr, and tell
fuse that we actually support nanosecond granularity.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    6 ++++++
 1 file changed, 6 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index d56d51207d1f25..bf4e592e7d2782 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -586,6 +586,9 @@ static void *op_init(struct fuse_conn_info *conn
 	dbg_printf(ff, "%s: dev=%s\n", __func__, fs->device_name);
 #ifdef FUSE_CAP_IOCTL_DIR
 	conn->want |= FUSE_CAP_IOCTL_DIR;
+#endif
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
+	conn->time_gran = 1;
 #endif
 	if (fs->flags & EXT2_FLAG_RW) {
 		fs->super->s_mnt_count++;
@@ -635,10 +638,13 @@ static int stat_inode(ext2_filsys fs, ext2_ino_t ino, struct stat *statbuf)
 						(struct ext2_inode *)&inode);
 	EXT4_INODE_GET_XTIME(i_atime, &tv, &inode);
 	statbuf->st_atime = tv.tv_sec;
+	statbuf->st_atim.tv_nsec = tv.tv_nsec;
 	EXT4_INODE_GET_XTIME(i_mtime, &tv, &inode);
 	statbuf->st_mtime = tv.tv_sec;
+	statbuf->st_mtim.tv_nsec = tv.tv_nsec;
 	EXT4_INODE_GET_XTIME(i_ctime, &tv, &inode);
 	statbuf->st_ctime = tv.tv_sec;
+	statbuf->st_ctim.tv_nsec = tv.tv_nsec;
 	if (LINUX_S_ISCHR(inode.i_mode) ||
 	    LINUX_S_ISBLK(inode.i_mode)) {
 		if (inode.i_block[0])


