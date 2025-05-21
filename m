Return-Path: <linux-ext4+bounces-8116-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B6FABFFEB
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3FB31BC37AF
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174A9239E87;
	Wed, 21 May 2025 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lI4RXjZj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11A51A317A
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867476; cv=none; b=akx8dViJ2iN3hUeGrwD18yaS856F4Uj7XNe4bBftM+wcZdOjgqbW3jTkcwFTNAWGsjj4AgKj5UVSPqJGwTlmbsVjWY6jCTelrZaTUwTuUCtgYGltR8kV3YYtq929cugQbGTEzB8Wfz0eJaPp3s83GvtmU+rK/WoM0G7dWQ4Lz5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867476; c=relaxed/simple;
	bh=d2GIhqJJSLQ1GHd9gn9YA0gG0ZL0AZ5njdXMJANcOzM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ElgeTouiEVQmygtOj/7VyFAZm8PbYEz4zFPCk9W8kdnGx+ekwcUtenbpZI4pmnjeLMjMmiTb8EGqom3cyuzdfuouUCo5KCeYzQSbx3yeCe1o4qBhgH+3DK9Eh8ezpDteuMDVHUwRj55wpnl4x/T0vZ4Akkk+Wwd5nA87tBTgbk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lI4RXjZj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7C2C4CEE4;
	Wed, 21 May 2025 22:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867476;
	bh=d2GIhqJJSLQ1GHd9gn9YA0gG0ZL0AZ5njdXMJANcOzM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=lI4RXjZjpKrUT6HYVrUF2D0k+2TxLVctuzfiTQc440LOTd31IYCmFFkOIAxm7byPK
	 zPfWGkiUcJtEkqOjp/33+HhwNqxWwsL0eunDpmhYfWTwnfpQfkUDggluOEYqBHEkHO
	 Y+rWRfziraSKhl5lhxwrrqgxvzVmlT5WJGDPnmU5bImjDeRdfgJdqhANAsA0Xc5Mho
	 lQq7g8b/dALdl2/RDKQ5wB1CF/XOLVv951tk8zyIrD5MrulNnI1w++lI5g6Q649iEf
	 Rr6M0ynkqsIwDXH4Jfs+n6sT1sDf3aemdkNLALT+O8pWks3Dkkow02k5H9AJTX6azz
	 nreDMqLGKBJaw==
Date: Wed, 21 May 2025 15:44:35 -0700
Subject: [PATCH 5/7] fuse2fs: only flush O_SYNC files on close
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786678489.1385038.14963089920680674888.stgit@frogsfrogsfrogs>
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

Don't call ext2fs_flush2() from op_release unless the file was opened
with either synchronous write flag.

XXX: Maybe this should be replaced with actual incore state tracking for
inodes?

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 6fae10e9473ea5..b0d3e3ea479d72 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -2673,11 +2673,15 @@ static int op_release(const char *path EXT2FS_ATTR((unused)),
 	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
 	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
 	pthread_mutex_lock(&ff->bfl);
-	if (fs_writeable(fs) && fh->open_flags & EXT2_FILE_WRITE) {
+
+	if ((fp->flags & O_SYNC) &&
+	    fs_writeable(fs) &&
+	    (fh->open_flags & EXT2_FILE_WRITE)) {
 		err = ext2fs_flush2(fs, EXT2_FLAG_FLUSH_NO_SYNC);
 		if (err)
 			ret = translate_error(fs, fh->ino, err);
 	}
+
 	fp->fh = 0;
 	pthread_mutex_unlock(&ff->bfl);
 


