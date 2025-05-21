Return-Path: <linux-ext4+bounces-8118-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CEAABFFED
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C0F94E52F4
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E39F23AE9A;
	Wed, 21 May 2025 22:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W03kNDdI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A1023A9B0
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867508; cv=none; b=tJ9zQ1kwrbGgAzcy4IVi43E1iFMmK1cdiCiWNYB18ug+OgEsJBtcyaNCUIG13NlEhjKqrEN3iPgL93QPv36FHFFW3ZNW+KFdY9ZVLESSGGAdWTAraEIgbANQovAsTMdUAHGUqfIitTgfXTZi1LlUry03Bm8yywMUWPj437YwObg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867508; c=relaxed/simple;
	bh=jtYrPEx9/97SxCtjwlwkVjgWfeffPc4ERNwsbbXlCLM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RsmDq5zJefHa13tOhLlR64LN+kdyLTzutB5l2t2TDkP65pTkwCTRGAIqWgB4KLuAVMs3X5JYBItD0EUgswauV/mSUE0J9N2GeYB0359AcpsQYb7rAQxhmsCcz514DxUJ5yCb5NjD6+dQJ6JstKjcAVtk8xcg25S7dEoVwJf5B74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W03kNDdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C89CC4CEE4;
	Wed, 21 May 2025 22:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867507;
	bh=jtYrPEx9/97SxCtjwlwkVjgWfeffPc4ERNwsbbXlCLM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=W03kNDdI4OCeCatmZNstDX1TJKZ5DRkyXMwFVxViK045dd2cD8eClQfYFrav9hc0X
	 Axr26apiYvheLadqdE6zuogySIfEMRw8hfHwG2ZHiJAfqNWrGQHKLO0m0/GJA6WH7s
	 f+6+/OVhOvJf9DIISHlcoNoNGo4+rDq6kxfeTVFywBTBZnWoEP4ZraqwpnK4tp57gP
	 2NLbvj6exDJQgARhyVp/Hbj8ZAk95wmtan6C/PWgBxObtqvqdngmugS6NcZ+AvIxSH
	 UA8cWNEZuwPUrr2tlx1x8Ra+VvMfY44qpVs4E9l7meFSCarxAuq/yp0s9qRfT/G30s
	 rbWssjNSdhC5A==
Date: Wed, 21 May 2025 15:45:07 -0700
Subject: [PATCH 7/7] fuse2fs: cache symlink targets in the kernel
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786678526.1385038.17134582776355667676.stgit@frogsfrogsfrogs>
In-Reply-To: <174786678371.1385038.908946555361173764.stgit@frogsfrogsfrogs>
References: <174786678371.1385038.908946555361173764.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Speed up symlinks by allowing the kernel to cache them.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    3 +++
 1 file changed, 3 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 49c77569a0336b..2368c87ef0b614 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -735,6 +735,9 @@ static void *op_init(struct fuse_conn_info *conn
 	if (ff->acl)
 		conn->want |= FUSE_CAP_POSIX_ACL;
 #endif
+#ifdef FUSE_CAP_CACHE_SYMLINKS
+	conn->want |= FUSE_CAP_CACHE_SYMLINKS;
+#endif
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 	conn->time_gran = 1;
 	cfg->use_ino = 1;


