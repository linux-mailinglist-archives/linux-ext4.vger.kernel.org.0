Return-Path: <linux-ext4+bounces-7462-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7D3A9B9FD
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 23:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E721B82EA2
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 21:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976EF21CC68;
	Thu, 24 Apr 2025 21:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3U75ota"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9F1198851
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 21:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745530770; cv=none; b=lebpTaEn2hh1SR2Ra7CKVPwKxbS52wP0SvM5zSei7JndS8JjcVc+QUOzWEVdSx6mCD8N1BWHL99PZyXTkBbbWS5odLaOkuVIte4abBJUEB8Y8rcpTPzuoqYSh6XWD8IuW/6yhBaFgVlVDIWjI3i+0Yvtvm8RX9BDsmyBsUsdM7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745530770; c=relaxed/simple;
	bh=/NI7UASRHVCThISDs1QjV7Wg9LYWhIJSx9jQKUZTs80=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bXIAIFHnPXM4jotluXwGzdFAOhoXKQ8V+xq6o+4JcXORskoBE8j4W9l8jk6Rszbu6HclFJSqOjpplpieoaAlBx0jHfkkLgTRtBPb18XUFtxhjmfWj/oYz6qQZurYxI9e/6evA+2z35zpmM9YphYh6L9DRtr+yZoTOWeof596bbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3U75ota; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E7FC4CEE3;
	Thu, 24 Apr 2025 21:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745530769;
	bh=/NI7UASRHVCThISDs1QjV7Wg9LYWhIJSx9jQKUZTs80=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=N3U75otaW9fzY9YA5uu0JnvkJjITyVaPcvXe/krzaacjRuL6DyoIc4QYst9hwclFf
	 QaE5Qb6rT1koAheO+/6wu1wzdFhsX0WBB1i5eChMSM49+v34VHaHueMLko1OdmYs9z
	 abUsLD7ZFGUH/aMwGS1xw+x+tX1yj5nthxv4oqMmzgS/KDtjwYjx1UETKWJeyyzxjf
	 NsqWGggaReFsdCa9yuAlzui45OF8QL+nCWr/EcAxAuVSzMituOjrjL04N9wQlRcJR/
	 k5HdCpl4QROqDxOoiw4C/SrH+Pp9xywv860uNO12X6plqNCBWKc5pjk8kLAaKsuXGl
	 n7e9an+NU1wBw==
Date: Thu, 24 Apr 2025 14:39:29 -0700
Subject: [PATCH 3/5] fuse2fs: use error logging macro for mount errors
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174553064509.1160047.12034355870702470696.stgit@frogsfrogsfrogs>
In-Reply-To: <174553064436.1160047.577374015997116030.stgit@frogsfrogsfrogs>
References: <174553064436.1160047.577374015997116030.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Use err_printf for mount errors so that they all have a standard format
and go where all the other errors go.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index f2d0e1f2441f83..e3e747dec33fd9 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3868,8 +3868,8 @@ int main(int argc, char *argv[])
 	err = ext2fs_open2(fctx.device, options, flags, 0, 0, unix_io_manager,
 			   &global_fs);
 	if (err) {
-		printf(_("%s: %s.\n"), fctx.device, error_message(err));
-		printf(_("Please run e2fsck -fy %s.\n"), fctx.device);
+		err_printf(&fctx, "%s.\n", error_message(err));
+		err_printf(&fctx, "%s\n", _("Please run e2fsck -fy."));
 		goto out;
 	}
 	fctx.fs = global_fs;
@@ -3886,17 +3886,16 @@ int main(int argc, char *argv[])
 			printf(_("%s: recovering journal\n"), fctx.device);
 			err = ext2fs_run_ext3_journal(&global_fs);
 			if (err) {
-				printf(_("%s: %s.\n"), fctx.device,
-				       error_message(err));
-				printf(_("Please run e2fsck -fy %s.\n"),
-				       fctx.device);
+				err_printf(&fctx, "%s.\n", error_message(err));
+				err_printf(&fctx, "%s\n",
+						_("Please run e2fsck -fy."));
 				goto out;
 			}
 			ext2fs_clear_feature_journal_needs_recovery(global_fs->super);
 			ext2fs_mark_super_dirty(global_fs);
 		} else {
-			printf("%s", _("Journal needs recovery; running "
-			       "`e2fsck -E journal_only' is required.\n"));
+			err_printf(&fctx, "%s\n",
+ _("Journal needs recovery; running `e2fsck -E journal_only' is required."));
 			goto out;
 		}
 	}
@@ -3918,24 +3917,24 @@ int main(int argc, char *argv[])
 	}
 
 	if (!(global_fs->super->s_state & EXT2_VALID_FS))
-		printf("%s", _("Warning: Mounting unchecked fs, running e2fsck "
-		       "is recommended.\n"));
+		err_printf(&fctx, "%s\n",
+ _("Warning: Mounting unchecked fs, running e2fsck is recommended."));
 	if (global_fs->super->s_max_mnt_count > 0 &&
 	    global_fs->super->s_mnt_count >= global_fs->super->s_max_mnt_count)
-		printf("%s", _("Warning: Maximal mount count reached, running "
-		       "e2fsck is recommended.\n"));
+		err_printf(&fctx, "%s\n",
+ _("Warning: Maximal mount count reached, running e2fsck is recommended."));
 	if (global_fs->super->s_checkinterval > 0 &&
 	    (time_t) (global_fs->super->s_lastcheck +
 		      global_fs->super->s_checkinterval) <= time(0))
-		printf("%s", _("Warning: Check time reached; running e2fsck "
-		       "is recommended.\n"));
+		err_printf(&fctx, "%s\n",
+ _("Warning: Check time reached; running e2fsck is recommended."));
 	if (global_fs->super->s_last_orphan)
-		printf("%s",
-		       _("Orphans detected; running e2fsck is recommended.\n"));
+		err_printf(&fctx, "%s\n",
+ _("Orphans detected; running e2fsck is recommended."));
 
 	if (global_fs->super->s_state & EXT2_ERROR_FS) {
-		printf("%s",
-		       _("Errors detected; running e2fsck is required.\n"));
+		err_printf(&fctx, "%s\n",
+ _("Errors detected; running e2fsck is required."));
 		goto out;
 	}
 


