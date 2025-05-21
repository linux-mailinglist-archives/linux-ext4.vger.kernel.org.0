Return-Path: <linux-ext4+bounces-8089-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A94ABFFAC
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36434A7B23
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13DE230269;
	Wed, 21 May 2025 22:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7htWFFu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941A51754B
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867052; cv=none; b=gvZlpR2NRKF6BjIHTMgDlHEoRtPZGtNTfoKaTGtnNP3N/ORpJORdZ0QCeHdatlSOfM4AinXg88DWeijziYiBKVbdeJEDiOoVWmHAIi+8SjMyRl282MtqLldrmsPeaZ5b9IBIuRhtE0f14QhM7vW3TLGyZFvoAx24CrqsUvHXVS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867052; c=relaxed/simple;
	bh=sSAo+Fwivrql41xogopyzs0lAAiq5dqqGXIMNGd0eRc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L8indoUnEr8ghBhyGl3iNxyZ3ks+pdL3Ya2bh8DwMtdKnpQuI934dtLRN1skFcyXAtuK/15Pab/cLpBCmwJrzZnoYGfmisc8BFtBqrsZjb1o1rbGvrsKAYve9Skukb3q20XRd/bTTL8pfYdK80l9Yzy4cgr3hwDgIf+hbDd89dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7htWFFu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A14C4CEE4;
	Wed, 21 May 2025 22:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867052;
	bh=sSAo+Fwivrql41xogopyzs0lAAiq5dqqGXIMNGd0eRc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=c7htWFFutHaKit7W0dQMD8HadBGh939EVnxCSbSuUFki+8KfFQpvfmXo+2PhGe/59
	 rCx+uaqpJNWTMcFlAsiQMTLztNCP5pWdq1nCacv1bWcMydn9Fpy2Dles9JRBs8BIAW
	 jn7Mtb3MgLNa8YEqobPNz8I2bdea/e+e3bBLr0nEdRUoe2E0LLbpRuSeErHHJayvW7
	 tn8O6bfAKYB1d/tkHAOiptPnkx+X3hJUqZHtgCWBt5lh6+MID2lvx4K/EKEHLvBXtq
	 l6rarRtXFm/fQyAFPn7ng2tlxtmVfGUGHIE4hIHgIacBFHtVwU9tiygYQjDdDkv199
	 luf3nmXszVyDg==
Date: Wed, 21 May 2025 15:37:31 -0700
Subject: [PATCH 10/29] fuse2fs: allow some control over acls
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786677729.1383760.10883670792875770541.stgit@frogsfrogsfrogs>
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

Allow some control over whether or not ACLs get used, though for kernel
mode it will always be enabled.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 40105368775a93..a0e5d601e55877 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -160,6 +160,7 @@ struct fuse2fs {
 	uint8_t norecovery;
 	uint8_t kernel;
 	uint8_t directio;
+	uint8_t acl;
 	unsigned long offset;
 	unsigned int next_generation;
 	unsigned long long cache_size;
@@ -648,6 +649,10 @@ static void *op_init(struct fuse_conn_info *conn
 #ifdef FUSE_CAP_IOCTL_DIR
 	conn->want |= FUSE_CAP_IOCTL_DIR;
 #endif
+#ifdef FUSE_CAP_POSIX_ACL
+	if (ff->acl)
+		conn->want |= FUSE_CAP_POSIX_ACL;
+#endif
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 	conn->time_gran = 1;
 	cfg->use_ino = 1;
@@ -3813,8 +3818,9 @@ static struct fuse_opt fuse2fs_opts[] = {
 	FUSE2FS_OPT("offset=%lu",	offset,			0),
 	FUSE2FS_OPT("kernel",		kernel,			1),
 	FUSE2FS_OPT("directio",		directio,		1),
+	FUSE2FS_OPT("acl",		acl,			1),
+	FUSE2FS_OPT("noacl",		acl,			0),
 
-	FUSE_OPT_KEY("acl",		FUSE2FS_IGNORED),
 	FUSE_OPT_KEY("user_xattr",	FUSE2FS_IGNORED),
 	FUSE_OPT_KEY("noblock_validity", FUSE2FS_IGNORED),
 	FUSE_OPT_KEY("cache_size=%s",	FUSE2FS_CACHE_SIZE),


