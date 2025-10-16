Return-Path: <linux-ext4+bounces-10900-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A928EBE44D1
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 17:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39E111A63E86
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 15:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4109C341AAE;
	Thu, 16 Oct 2025 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qebnCW9h"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F9A2E764B
	for <linux-ext4@vger.kernel.org>; Thu, 16 Oct 2025 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629313; cv=none; b=SNl+tydrZ0P6u+G3fD6o5PKGfO8I8zsoBuIuD8Q8ycOYH81PteBV9evc8pfXIr3jUfM0ENCqdwn2IDWTzi36cO2xxVOOJaDZ2rvDHwN33fLMDlULwnFwHZr8qdf8PNDj6lXPShG7jUNDAHIJzTJgmbPflU0cE9AJhNKA/MeRyUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629313; c=relaxed/simple;
	bh=X06BCHn0LaWKZebHCSpVWZ3yO7LkfOq19k3RVxZu+jw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DbwM9pqjsnwQTCR5tCGij8ZIYO0berwQ9GXFH62uZdZ/WmCXxVUzG0Q8LTAyF2WELeIQgm1ena4/IExSsIGO4vNEURfgT3hraue7rsj2flBO0c1jKzqrHZXrxv59VKfAa5KzwkNVJh9GU6SBMH9yk+n2xQx7iZBm/YLtHM1wxlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qebnCW9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645B0C4CEFB;
	Thu, 16 Oct 2025 15:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760629313;
	bh=X06BCHn0LaWKZebHCSpVWZ3yO7LkfOq19k3RVxZu+jw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=qebnCW9hS7gTq70dLvR23mc0UpitTArlXfqCxaF+NReEjgMv0HPg5DQLlfONHKzi8
	 Ov2klo3Ag+yKT65vKxrEnPAET9S1EyXKnhhMR7GUm1CWuu83R1zhNR+SJV8RZbYugr
	 wPmf+3T9X6gzY72jNNuDzsgpxuryzguFIr9dYdj1Wdj5IIJ6alHt3k1tzpPwbfTH8z
	 fpArbS0EGUdlp7c0OIeH6WG4JQwKLZf5WAB9NXFJLn7lftOjCu+UEpER+78KxfWiNk
	 0L7eXEukEN9Egqa8GzIwa3kNAhwDk7aBGX/N5bPqQJMWg22KojLd9BURJCaY8t0ELx
	 cSjZqrQh4wCAA==
Date: Thu, 16 Oct 2025 08:41:52 -0700
Subject: [PATCH 08/16] fuse2fs: free global_fs after a failed ext2fs_close
 call
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <176062915610.3343688.9268207114006804614.stgit@frogsfrogsfrogs>
In-Reply-To: <176062915393.3343688.9810444125172113159.stgit@frogsfrogsfrogs>
References: <176062915393.3343688.9810444125172113159.stgit@frogsfrogsfrogs>
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
prior to introducing iomap support, which means that we won't close
the (O_EXCL) block device before returning from umount, which will cause
problems with fstests and the user expectation that block devices are
closed when umount(8) returns.

Therefore, free the context after a failed close.

Cc: <linux-ext4@vger.kernel.org> # v1.43.7
Fixes: 6ae16a6814f47c ("misc: clean up error handling for ext2fs_run_ext3_journal()")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 4d92e1e818b1c4..0a862ea086cbde 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4904,10 +4904,9 @@ int main(int argc, char *argv[])
 		fflush(orig_stderr);
 	}
 	if (global_fs) {
-		err = ext2fs_close(global_fs);
+		err = ext2fs_close_free(&global_fs);
 		if (err)
 			com_err(argv[0], err, "while closing fs");
-		global_fs = NULL;
 	}
 	if (fctx.lockfile) {
 		if (unlink(fctx.lockfile)) {


