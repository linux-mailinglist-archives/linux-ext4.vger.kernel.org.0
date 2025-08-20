Return-Path: <linux-ext4+bounces-9406-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EFCB2E8EF
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 01:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 307A01CC45D7
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Aug 2025 23:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC932E264D;
	Wed, 20 Aug 2025 23:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDHTSJZB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0182E1758
	for <linux-ext4@vger.kernel.org>; Wed, 20 Aug 2025 23:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755733316; cv=none; b=jdBF8vu5CAUUAiIAW5AS5RYQ7wj06dJDobxWvkzxt1Ku8kJHIiEJ8po67KOl+plpGwx3z25e44NGesD3GU9bxovU9Pma8psU8chjQdb/lx8UPCQmEbcgrS61GvnUdAp+iLB9nUl8j1kv0/oEOke+Pyu8k0AnX1nDk1GkyIA0ZBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755733316; c=relaxed/simple;
	bh=ezpwtK/fQ1JiMITAd/RJBjy7iz7gYy3nBGL53mksyLQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C+fxdYmBox5fpYcHN9AM0/gSnVYC/ZL14W3K8HOlGw6u5HQBH4I+dU6UKmmXgJP0syihkao7SiO1yhjhqdx8MH7LUY1mJW6MJsEkByerr05LZvxQtDgmXmo8NS4rZp5HlimFs9mliibFPu19ypo7uVokznPHfgdrGL3js64dP3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDHTSJZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C331C4CEE7;
	Wed, 20 Aug 2025 23:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755733315;
	bh=ezpwtK/fQ1JiMITAd/RJBjy7iz7gYy3nBGL53mksyLQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=fDHTSJZBnaxAbQS16orvek7H3n/5MVwNW0MZKaetKwOmnQ7pSRmuZ/blohToreCIV
	 A1XO2hVApoByhOXq5UdDiCwl0HQwav/DWCi/hm5KXsOQCQ65EwcjBRfVjHFbasCA4Z
	 MlZDKEWY6y32WLwxMk5FT6k/bfA0imbGgyTHNr9cgmQWCQQNqri9zD3Z1xO3n9l6LH
	 qZAnZ8eZwMN2s/V1nF90mcBEd6mg3dhlT6SdZ/RPEjwYMyLMiYXOVKN26BfPggsc5a
	 oxdagSKD07k+nqKtJiXfQleHNJoYHRN+wBo5zBX3NTB57IFSKAM+lcDKpFNG10wFVV
	 Fl4ZT50tdCeFw==
Date: Wed, 20 Aug 2025 16:41:55 -0700
Subject: [PATCH 04/12] fuse2fs: allow O_APPEND and O_TRUNC opens
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <175573318676.4130038.2598964686073896057.stgit@frogsfrogsfrogs>
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

Commit 9f69dfc4e275cc didn't quite get the permissions checking correct:

generic/362       - output mismatch (see /var/tmp/fstests/generic/362.out.bad)
    --- tests/generic/362.out   2025-04-30 16:20:44.563833050 -0700
    +++ /var/tmp/fstests/generic/362.out.bad    2025-06-11 17:04:24.061193618 -0700
    @@ -1,2 +1,3 @@
     QA output created by 362
    +Failed to open/create file: Operation not permitted
     Silence is golden
    ...
    (Run 'diff -u /run/fstests/bin/tests/generic/362.out /var/tmp/fstests/generic/362.out.bad'  to see the entire diff)

The kernel allows opening a file for append and truncation.  What it
doesn't allow is opening an append-only file for truncation.  Note that
this causes generic/079 to regress, but the root cause of that problem
is actually that fuse oddly supports FS_IOC_[GS]ETFLAGS but doesn't
actually set the VFS inode flags.

Cc: <linux-ext4@vger.kernel.org> # v1.47.3
Fixes: 9f69dfc4e275cc ("fuse2fs: implement O_APPEND correctly")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index cce1c97c81c075..1debbd3355ec8f 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -2639,15 +2639,13 @@ static int __op_open(struct fuse2fs *ff, const char *path,
 		file->open_flags |= EXT2_FILE_WRITE;
 		break;
 	}
-	if (fp->flags & O_APPEND) {
-		/* the kernel doesn't allow truncation of an append-only file */
-		if (fp->flags & O_TRUNC) {
-			ret = -EPERM;
-			goto out;
-		}
 
+	/*
+	 * If the caller wants to truncate the file, we need to ask for full
+	 * write access even if the caller claims to be appending.
+	 */
+	if ((fp->flags & O_APPEND) && !(fp->flags & O_TRUNC))
 		check |= A_OK;
-	}
 
 	detect_linux_executable_open(fp->flags, &check, &file->open_flags);
 


