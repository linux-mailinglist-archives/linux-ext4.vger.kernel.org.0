Return-Path: <linux-ext4+bounces-9403-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473C0B2E8F5
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 01:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B22097BE449
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Aug 2025 23:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5182E3396;
	Wed, 20 Aug 2025 23:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKjttYAi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4A22E3391
	for <linux-ext4@vger.kernel.org>; Wed, 20 Aug 2025 23:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755733268; cv=none; b=boc5eLV4smgx1RnOxv5rYSCASS3SxbFOTRgwMPEUBypbrhE1AUj8Igqij/Wl08NEmQM8E9ze0a5PVlqItM0BuCWEiNmzP2Rcvp9bqBYEXxJ4WsYW+yM1gC1VzZMpBWJlCZUehmqdpO2eOpzib1Ojt5gEJcUBGczjEkTciVtl4kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755733268; c=relaxed/simple;
	bh=my4AX15Ad87EbeJdzyJ+yGKR/eFT/s1u15lAmhkcT0c=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Smzuu/HMkz6FNyvYLU127PFvvlRU0/VWifJ/nI4n0yQP0OTMhVwk91oyKD4ysrflJtuY82oUE/qXvoDafGBKfC2/YkRk3tIDk/e9Wt1GIBf4sZBzoYZx2r7Nbq5s1V3i5QDVz0Px/mPH3b4ZDqS5Q95BJYPy2fEFZu1bWHje28w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKjttYAi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AAA1C4CEE7;
	Wed, 20 Aug 2025 23:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755733268;
	bh=my4AX15Ad87EbeJdzyJ+yGKR/eFT/s1u15lAmhkcT0c=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=gKjttYAi51ZmXdnd+DW60GJlW7em1ouzdj5GsE/BY2FVk8LG36FFNqih3UALIVFzy
	 Xc6dvwtKyTehYJA1D8o+6H7iqr4mNh3C0y6sUOc9rCzwWd7259zcE+6wixSBJKZXOd
	 d9FazjzR1sF7oD+1gowwY2hpPZKYCljY2lF8Bgr1RpM+sfe9NlxmJH05VpNtd5eMk1
	 +cuoi3ROHZyLk3uGfu5nv+zMBtyETkWcx4R8iartktYOFfr9PdfB/HQi3af9P9a9do
	 yN8/FekVqe7ahywbxRnaZUiIgfzmyhcgPoS3EXCKEb8yxmusyQZ1NNg1ZZrsXdcPwS
	 lDvh3R21u4xYA==
Date: Wed, 20 Aug 2025 16:41:07 -0700
Subject: [PATCH 01/12] mke2fs: don't print warnings about dax to stderr
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <175573318622.4130038.48444777771831124.stgit@frogsfrogsfrogs>
In-Reply-To: <175573318553.4130038.2069350865263085609.stgit@frogsfrogsfrogs>
References: <175573318553.4130038.2069350865263085609.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

mke2fs prints a warning to standard error if the target device supports
fsdax but the fs block size doesn't match the page size.  This isn't an
error since we don't abort the format and the filesystem will work just
fine if the user doesn't care about fsdax.

Therefore, print the warning to stdout, not stderr.

Cc: <linux-ext4@vger.kernel.org> # v1.45.7
Fixes: f4979dd566acc4 ("mke2fs: Warn if fs block size is incompatible with DAX")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/mke2fs.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)


diff --git a/misc/mke2fs.c b/misc/mke2fs.c
index c84ace7a551222..7f81a5137501e0 100644
--- a/misc/mke2fs.c
+++ b/misc/mke2fs.c
@@ -2503,10 +2503,9 @@ static void PRS(int argc, char *argv[])
 		}
 
 		if (dev_param.dax && blocksize != sys_page_size) {
-			fprintf(stderr,
-				_("%s is capable of DAX but current block size "
-				  "%u is different from system page size %u so "
-				  "filesystem will not support DAX.\n"),
+			printf(_("%s is capable of DAX but current block size "
+				 "%u is different from system page size %u so "
+				 "filesystem will not support DAX.\n"),
 				device_name, blocksize, sys_page_size);
 		}
 	}


