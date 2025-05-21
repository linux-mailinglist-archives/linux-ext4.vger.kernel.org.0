Return-Path: <linux-ext4+bounces-8095-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F75ABFFBA
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAF081BC0A27
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A741754B;
	Wed, 21 May 2025 22:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvtfhgQc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A680239E8B
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867146; cv=none; b=tCNfFbuO/cR5MxbxMMZG8qhPX8Wqr87ElcAIaZLNpB2cJOJozVkL/m/Z5avD0vBk0Px7QhwhUtqVoPIlsjcuoiAUn9tJ0j8aeprjc0C9ZfPZkhbQPeJhGpDoJVRM0NDDAlAA4On4XcScg1CjKx75IFLt0fmRgdtEztiZLuH6EYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867146; c=relaxed/simple;
	bh=+VOFYm3dOCgLWO7M7jmeLjYh+9YmZ+n4zNz5batpDLc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n2dFLNwtCOm3uHLTtAgKfBYCXLHqEFPbdlhZ3rKIp8y0+aVsvxNwpCHzy7Ep7bqiazqw/FzxXUmmmTJUJdqi1PpeQmzz5kNF/pJPF8Wp1tlhL/azf/mbs66+V0Rn0kPqWa5U8O+KHT3bYhdjbr5XIOgF1qyCieAomlnQvRFz0UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvtfhgQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D177DC4CEE4;
	Wed, 21 May 2025 22:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867145;
	bh=+VOFYm3dOCgLWO7M7jmeLjYh+9YmZ+n4zNz5batpDLc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=YvtfhgQcKRhVHxSebAHFVQ06VFRFUiEW5GkNECThxswi13YWcjHFe2HxpLNB1x5nJ
	 zjU2XH4wOrws6BAHjWFZSd0RWGIMwdNpEtUD5cRX10Q2OvMzR+QogjmN8Pm1nv2JCN
	 kq8Lb07w9csW51awoBoeKpVQvj9X/3xd6ZCOUbJAuWhQG2rSS4UlYkLeQpHCSzaDvC
	 ykbXFS6sAeQ8tf92501CuIuv8hK2CMWu0AVu53sTP+LwjKLtJSRCgPysTDQphOAHEf
	 9pkfgqFh+y9ufvkRY6Lv1F8UbMFjFSAoGQe12s2lPvTBFmI+aSHpjRtQvlqtvA/fuu
	 hHBMbVW0KGs8A==
Date: Wed, 21 May 2025 15:39:05 -0700
Subject: [PATCH 16/29] fuse2fs: make internal state corruption a hard error
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786677837.1383760.2730283507317571357.stgit@frogsfrogsfrogs>
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

If the in-memory contents are wrong, then we want to report a corruption
error and shut down the filesystem.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index f0ac89db4f6c37..6b5b19062b4ca1 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -167,11 +167,11 @@ struct fuse2fs {
 };
 
 #define FUSE2FS_CHECK_MAGIC(fs, ptr, num) do {if ((ptr)->magic != (num)) \
-	return translate_error((fs), 0, EXT2_ET_MAGIC_EXT2_FILE); \
+	return translate_error((fs), 0, EXT2_ET_FILESYSTEM_CORRUPTED); \
 } while (0)
 
 #define FUSE2FS_CHECK_CONTEXT(ptr) do {if ((ptr)->magic != FUSE2FS_MAGIC) \
-	return translate_error(global_fs, 0, EXT2_ET_BAD_MAGIC); \
+	return translate_error(global_fs, 0, EXT2_ET_FILESYSTEM_CORRUPTED); \
 } while (0)
 
 static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,


