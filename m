Return-Path: <linux-ext4+bounces-8086-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 664E9ABFFA7
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781ED4E3651
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFE523958D;
	Wed, 21 May 2025 22:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omy5m9x/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427F12B9A9
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867005; cv=none; b=TtopuOzg17Lh8IXSiIP961xFhHAMnYehQyQ9Ft/MVnhiSM7/LvZmJAc7JwY5IDRcW2Tq/+RUzozD3sYjJq1rWQUeCzRtu3qwF7aR2cG63EPrtnS28a/BpAqjElewBCPWX5odfu2fG4eyNrHse3fciIiOSoR4ejwvyRfKFd83Sik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867005; c=relaxed/simple;
	bh=fEmJKx3rwFHQZgA9tzuoy/ZClLnWFTqbl6C+TMRC7Vo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wu1RdKEX/XcuHTLpdW8o559Cf+EL1PqHTIL+QFqWk49t0PqX6S5SLnrZHIykmZQRLk4A1rd7Ge7j2B1Wi+uWe+s9GvS7WRJaj1sVP+nKVxid4kfFtQJJKQVqTx5K1fMF+YAmf705tJA5j4Lwu1Pgym9plVTe/ROPm1eIh6QlNJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omy5m9x/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D7BC4CEE4;
	Wed, 21 May 2025 22:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867005;
	bh=fEmJKx3rwFHQZgA9tzuoy/ZClLnWFTqbl6C+TMRC7Vo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=omy5m9x/fXtcet4jJbTJ3hKMNpJHA/nXqKJLZpjcc/vd2idKlseD3d4GFfWhHI9oh
	 At4kR1uFp1tnzq6JAcb26JYYS+Wi/tNoLZTvD6AF1Owx3vzv4TgVLeEXU+cRREJvv5
	 NQfB3LgZjBefvhyKAah0JyD4Oy7s69/E2TfqI3wcLrSt9S07GUCFqZZ2BDk8a/rY0W
	 DGdVW0ZhWLYbFcxpj7YUzihVrLTeyegSsNTa60DwlH3keOufmD5ApQQpaUS2JTpCTr
	 +QjJoXOqOC/NheYYUOOJdQt3r/arIlYvWGbM1+OB5DbHaHSpYRbDe5dOErpjVkLoUI
	 rVjW/eLilspsQ==
Date: Wed, 21 May 2025 15:36:44 -0700
Subject: [PATCH 07/29] fuse2fs: fix error return handling in op_truncate
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <174786677675.1383760.13355151028679279614.stgit@frogsfrogsfrogs>
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

Fix a couple of bugs with the errcode/ret handling in op_truncate.
First, we need to return ESTALE for a zero inumber because there is no
inode zero in an ext* filesystem.  Second, we need to return negative
errno for failures to libfuse, not raw errcode_t.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 81cbf1ef4f5dab ("misc: add fuse2fs, a FUSE server for e2fsprogs")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 33f72cf08f7b3a..74f1ca81aebc61 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1963,10 +1963,14 @@ static int op_truncate(const char *path, off_t len
 	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
 	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, path, &ino);
-	if (err || ino == 0) {
+	if (err) {
 		ret = translate_error(fs, 0, err);
 		goto out;
 	}
+	if (!ino) {
+		ret = -ESTALE;
+		goto out;
+	}
 	dbg_printf(ff, "%s: ino=%d len=%jd\n", __func__, ino, len);
 
 	ret = check_inum_access(fs, ino, W_OK);
@@ -1998,7 +2002,7 @@ static int op_truncate(const char *path, off_t len
 
 out:
 	pthread_mutex_unlock(&ff->bfl);
-	return err;
+	return ret;
 }
 
 #ifdef __linux__


