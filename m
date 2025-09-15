Return-Path: <linux-ext4+bounces-10057-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6779B5879D
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 585F91B25558
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 22:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D5F2D46AF;
	Mon, 15 Sep 2025 22:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="en/jTmMh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449FA2C236D
	for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 22:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757975942; cv=none; b=i5T3y/IM1mrPfWxKBpXH9s1y+Jm5RvvQHk3S0CJr5K4Fn3RB8zVstIyZ95nkk6ykDoJFIyXVl4EpQMuNpFe768OUwUFCaAdCQEWgDKFSKXGHk6XSUksERzNFUnm/GYvznSZM/QN7EJguoMwRMFQ9AJFIw2PglFaT+8e4/FPzwug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757975942; c=relaxed/simple;
	bh=K1IfOrL6uqv/WuF5yEEdp21OqBm/4GrRKpsVoSI7S5M=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O82kpfaTzxTmPp9wCzNIA2y76+7jqubPWpuqNFVloBT7mVbDqS2ZssXjMPIXrtjZJnrL8yIVHNVJu0lhy/CY6dAqRosYtzlY0q1GzrJoavl/HxCtaJTjvgCI7nsMUFeir720BXJTq2yqHDwoFPbiK3U6oMh470RFz1+BZUF8Vu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=en/jTmMh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D368EC4CEF1;
	Mon, 15 Sep 2025 22:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757975941;
	bh=K1IfOrL6uqv/WuF5yEEdp21OqBm/4GrRKpsVoSI7S5M=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=en/jTmMhZ4JHXSZ44OpKHfqeAM0d/r44CxQedoxzxkH5r0mN0x2mjHo01sLWU21H7
	 f4B1d09ekZM5zTWhhNg1YmEyavpteLlaZ775wxJkAIfQCjcAE0GOZWUWTZ0b942ZjQ
	 yAcy1EYEoJSl9o02w6s1FCjnaoAdNLAdB/IZ+tMZ2i62aFCQvCylXMFV0DgG5ZiQXq
	 TmacG0+e6DkTRuxTDVwfW/w/MFD8239Ms2VpqU9obQruNqC3wFMoxx4zTMAYLsFqeJ
	 lJ934XkWyeaDb0m7v2+U+2M8Fh8JmbSNgFY8PYYz4zq8E1HB9BSKIcPFqPBGFL2cZ6
	 EVMzGKcYHetkQ==
Date: Mon, 15 Sep 2025 15:39:01 -0700
Subject: [PATCH 05/12] fuse2fs: free global_fs after a failed ext2fs_close
 call
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <175797569709.245695.7389555784743357.stgit@frogsfrogsfrogs>
In-Reply-To: <175797569564.245695.4628729304068635201.stgit@frogsfrogsfrogs>
References: <175797569564.245695.4628729304068635201.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

If ext2fs_close fails for any reason, it won't free the ext2_filsys
object or any of the other things that hang off of it, like the io
managers and whatnot.  Right now this results in a memory leak of
global_fs, which is mostly benign because we're nearly to the end of
main() anyway.

However, a future patch will move the ext2fs_close call to op_destroy
prior to introducing fuseblk support, which means that we won't close
the (O_EXCL) block device before returning from umount, which will cause
problems with fstests and the user expectation that block devices are
closed when umount(8) returns.

Therefore, free the context after a failed close.

Cc: <linux-ext4@vger.kernel.org> # v1.43.7
Fixes: 6ae16a6814f47c ("misc: clean up error handling for ext2fs_run_ext3_journal()")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 4d92e1e818b1c4..08470a99dc7b4d 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4905,8 +4905,10 @@ int main(int argc, char *argv[])
 	}
 	if (global_fs) {
 		err = ext2fs_close(global_fs);
-		if (err)
+		if (err) {
 			com_err(argv[0], err, "while closing fs");
+			ext2fs_free(global_fs);
+		}
 		global_fs = NULL;
 	}
 	if (fctx.lockfile) {


