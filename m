Return-Path: <linux-ext4+bounces-9404-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE1BB2E8ED
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 01:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88D4A1CC45C8
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Aug 2025 23:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8892E1757;
	Wed, 20 Aug 2025 23:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZ0XQfUA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901DC2765E3
	for <linux-ext4@vger.kernel.org>; Wed, 20 Aug 2025 23:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755733284; cv=none; b=IXW7i/Ncrt25yJiruzvUThMyO2Di6yxhn/wR5ssS7OP0FVbaNQdb/U87GTGxWIArljOkbDBZv1uil9WWO1ONeqXisGYUHIaExoAAiVLyKrx9497FRm9lk1phuSOeLU+2Gvok9YgKEmkuzhd+gy9yEADCy5Hcaoc39fIIeVS2dFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755733284; c=relaxed/simple;
	bh=Vzw1YfsTZrSX/zq/PSzKNuekwmc5q427HZIquU9HeG8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d+FvfFEfJkf9BJV8mmwngfTn0iMBf94TLD2OV/xQ2tJfTPNcZddWzwlaKD4+DV1jBNgZDVZtvqB4zGuXF+5eF4dcOgXy4aOP6vHysSk5GQGCS2tnQadd/6vKKDy4hiXWhmk/FToL5cRPZN3shrRzOGg7DvI6LGavZyCWSFgW7Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZ0XQfUA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6C5C4CEE7;
	Wed, 20 Aug 2025 23:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755733284;
	bh=Vzw1YfsTZrSX/zq/PSzKNuekwmc5q427HZIquU9HeG8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=LZ0XQfUAV3mhN2NLBC1Nar9Z6Ka6dATsjGAcQ9MN/FuToGAD0+uh5LAN36dyqYJM+
	 3GIDLWWQLPgeFwC9RVx3FWjjuPxjiO9MrUBYBh7Aop7OnRAGuaUc4r6xRLE1mHSW5a
	 HvXwbAipaUBnynXouOcyly67mdNEtap2r6R7bZA0CYA2tMNCC/kWAyxZpjGM4O7thp
	 u/gos8LCsXaz2njnBk/UdRH8y8wrYifO7pBEBlBYNhGyHaBfSvBL5M99RZm9aaswqr
	 +S6B2XmwC5GOpltnQuRY+IJoW7uWh48i0Y3/NJZTFkjZOh0XXmB3lOiqHNbdoJwuSo
	 8AWqn1KNLsOQg==
Date: Wed, 20 Aug 2025 16:41:23 -0700
Subject: [PATCH 02/12] fuse2fs: fix readlink failure
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <175573318640.4130038.13924482444671815931.stgit@frogsfrogsfrogs>
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

For readlink of slow symlinks, an IO error when reading the link target
cause memory corruption.  This happens because the error case for
ext2fs_file_read closes the file, translates the error, but then jumps
down to the regular termination code, which re-closes the file and is
hence a UAF.  Straighten out the error paths to eliminate the UAF.
Also fix the bug that short target reads aren't flagged as corruption
as is done in the kernel.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 81cbf1ef4f5dab ("misc: add fuse2fs, a FUSE server for e2fsprogs")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 4d42a634bf377b..f9da9c1ac051cb 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1086,13 +1086,11 @@ static int op_readlink(const char *path, char *buf, size_t len)
 		}
 
 		err = ext2fs_file_read(file, buf, len, &got);
-		if (err || got != len) {
-			ext2fs_file_close(file);
+		if (err)
 			ret = translate_error(fs, ino, err);
-			goto out2;
-		}
+		else if (got != len)
+			ret = translate_error(fs, ino, EXT2_ET_INODE_CORRUPTED);
 
-out2:
 		err = ext2fs_file_close(file);
 		if (ret)
 			goto out;


