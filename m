Return-Path: <linux-ext4+bounces-7472-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42841A9BA0A
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 23:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C9E71770F3
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 21:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAA921E087;
	Thu, 24 Apr 2025 21:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEwBzH3y"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4384198851
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 21:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745530926; cv=none; b=kMNjggc/Vo8s6faraSq7wU/49QXh7vO55s3BRgAmsJzj1mp3YniuEaBm2e/A+Bj2/49rglNsodgSIpdoFOvTtVSM4l8RFVTXR9MrnGsov9JEyr9T3nMHP56cs7d+hiAoOXNEw6WrPtmydTeERYEOGC/Z21tkkRQi8Kyh0Hq6z9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745530926; c=relaxed/simple;
	bh=jWeBc0koSNIJqO5MUwn9WWNEUxvr5fVfH4obk/mpjtU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ajt0wn0RYvodLFI1Ai1aCeqLA/CpK1gVHNhc+ssAs2SyXvxlJDh7MnQOP208BvbwCZDiXSUw2o2r+0B5rpIbqDm9NK+6rK5z23sdJibu01hG5cmLJ+/AUFCGtkFidXAVLfQUJ4MHN905bY7+Wjh3cBk67e4R0fyNN95tnaP/JMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEwBzH3y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E3BC4CEE3;
	Thu, 24 Apr 2025 21:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745530925;
	bh=jWeBc0koSNIJqO5MUwn9WWNEUxvr5fVfH4obk/mpjtU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=vEwBzH3yKdaZKGHjwr3eUhHzDzvNpwybZkCo4HixiojeL7xtPI6+Ijgxbp/nEUAQ7
	 UtstMhgqpBr+XDi6PoFVVijTT0Gv0W3jgkEIq94+vGPg5JJ6p9NyEMG00/9B+WnP4o
	 xAiqv2JDLOZQoD/R3/+XtCDUixcZ7UKxDdOslHfIF8iKxxGbOO1cJh6j/x+jmPNc27
	 WuvBRRbkikkjdr9VRpWpWhEPMQt8stE7mzz1e/TS1jlW0EtHUDiXeyLpFhjfiew0Av
	 M24M1eAA7STtQGFNZZDJS8OShNM5+5BG0zlSdwAhZw1xZixzS8gapWtogelmuy4f0b
	 gPd4UuoJgImzQ==
Date: Thu, 24 Apr 2025 14:42:05 -0700
Subject: [PATCH 05/16] fuse2fs: log names of xattrs being set/get/removed
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174553065016.1160461.12942341433377716292.stgit@frogsfrogsfrogs>
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

Actually record the names of the xattrs being modified to make it easier
to debug fstests failures.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 5de6562ff97ecd..f499231dd04c94 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -2271,7 +2271,7 @@ static int op_getxattr(const char *path, const char *key, char *value,
 		ret = translate_error(fs, 0, err);
 		goto out;
 	}
-	dbg_printf(ff, "%s: ino=%d\n", __func__, ino);
+	dbg_printf(ff, "%s: ino=%d name=%s\n", __func__, ino, key);
 
 	ret = check_inum_access(fs, ino, R_OK);
 	if (ret)
@@ -2438,7 +2438,7 @@ static int op_setxattr(const char *path EXT2FS_ATTR((unused)),
 		ret = translate_error(fs, 0, err);
 		goto out;
 	}
-	dbg_printf(ff, "%s: ino=%d\n", __func__, ino);
+	dbg_printf(ff, "%s: ino=%d name=%s\n", __func__, ino, key);
 
 	ret = check_inum_access(fs, ino, W_OK);
 	if (ret == -EACCES) {
@@ -2504,7 +2504,7 @@ static int op_removexattr(const char *path, const char *key)
 		ret = translate_error(fs, 0, err);
 		goto out;
 	}
-	dbg_printf(ff, "%s: ino=%d\n", __func__, ino);
+	dbg_printf(ff, "%s: ino=%d name=%s\n", __func__, ino, key);
 
 	ret = check_inum_access(fs, ino, W_OK);
 	if (ret)


