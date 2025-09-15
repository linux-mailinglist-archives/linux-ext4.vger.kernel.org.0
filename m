Return-Path: <linux-ext4+bounces-10065-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B185B587A8
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8EF6204717
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 22:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FD22D47E7;
	Mon, 15 Sep 2025 22:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Il1rpNKR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8632D23A4
	for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 22:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976067; cv=none; b=K9XvlydkQnW07Sy4w2TyrfarrQc0yUqBWLkXR5fmE8HkGkWQy0tTTTD/saMGNixFpkpYC+szrwaWst1WtTCwFxJSnFt8h173BvUqD7ChMDDrSyIQggeklq8bUQtY5Jog4ky9HiQ/ti8tFBLrE5NvFweVG/xCyuqo25tgAXC70bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976067; c=relaxed/simple;
	bh=KyqKAB6KN2qUInEkBFuHCT+cinpojM/COmAw4lnwqYA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aTKh5vt/PUKj34czGWWicxEjQcsf4eNIf9hY0982fT8n7qos8io9LKf1QVqhr8IY1MXspUSvRiX6aR6LnNGZ4CeU/RDE0Qwv/jtQq0i1P5l/PsM700OzHH5J/djthzmTuuwxfTBtF4tgSVr5z3hlmmIr7LixcKGttNMOMCeJ61A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Il1rpNKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017A5C4CEF1;
	Mon, 15 Sep 2025 22:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757976067;
	bh=KyqKAB6KN2qUInEkBFuHCT+cinpojM/COmAw4lnwqYA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Il1rpNKRIGbvUE/aYTPrWQfFdeKMGpmA3Ax1ZU47KhI5wVrnVoilu2kRJ+1MllVHw
	 pEOtqYEEDuFUSp5mZB4+AKxpfiiafIBWL19haZquOIU09k9x8aRvTCtKspVFF4ZRb2
	 U3SojDsD/wWVWvt92ofLp1m2KpdvM2NGcH1Ly80Q0tLcDWWCZTmVVTNGpCBzctph4x
	 8gPZALpvuBRJRd6bgKGnikfdpvLtfWaHDKqeIfzGaMKW2z9G+/VIGFeG6WdRQxrpyB
	 VyM7iJuGeocoT6Oc9p0m2E69lU9Jp86fTDSvy6PZPl9PXWc4zyEn3wuDJ0pLgDYQ+A
	 c/X206J4Se0iQ==
Date: Mon, 15 Sep 2025 15:41:06 -0700
Subject: [PATCH 01/11] fuse2fs: check root directory while mounting
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175797570031.246189.33431710777569566.stgit@frogsfrogsfrogs>
In-Reply-To: <175797569966.246189.4996503880732213475.stgit@frogsfrogsfrogs>
References: <175797569966.246189.4996503880732213475.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

The kernel will fail a mount attempt if the root directory inode isn't
even minimally readable at mount time.  Do the same for fuse2fs so that
we can pass ext4/008.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 569ac402427767..8389cc3a4872b2 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4646,6 +4646,19 @@ static unsigned long long default_cache_size(void)
 	return ret;
 }
 
+/* Make sure the root directory is readable. */
+static errcode_t fuse2fs_check_root_dir(ext2_filsys fs)
+{
+	struct ext2_inode_large inode;
+	errcode_t err;
+
+	err = fuse2fs_read_inode(fs, EXT2_ROOT_INO, &inode);
+	if (err)
+		return translate_error(fs, EXT2_ROOT_INO, err);
+
+	return 0;
+}
+
 int main(int argc, char *argv[])
 {
 	struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
@@ -4821,6 +4834,10 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	ret = fuse2fs_check_root_dir(global_fs);
+	if (ret)
+		goto out;
+
 	if (global_fs->flags & EXT2_FLAG_RW) {
 		if (ext2fs_has_feature_journal(global_fs->super))
 			log_printf(&fctx, "%s",


