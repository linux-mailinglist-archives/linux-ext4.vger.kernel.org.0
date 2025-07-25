Return-Path: <linux-ext4+bounces-9191-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6403B1215A
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Jul 2025 17:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC133AC0EC4
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Jul 2025 15:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D032EE968;
	Fri, 25 Jul 2025 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1Xp/ycP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA5724677E
	for <linux-ext4@vger.kernel.org>; Fri, 25 Jul 2025 15:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753458971; cv=none; b=afoDRrba06PIC+Q8Qbbd5sYtATefOLU4dZu7En/IYFIMFxrkJqAmkzxV45cZcq6UaQ0y/ltWpyAY0J3Qnt96LkIdg/gytO7BfRV+Y6OK7OQiWsRSgqFyUDe2WnYzZFKJoQBuSIKh2DwiNuCEssmcyjvdfYNDn/0rcRFRyT6VMzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753458971; c=relaxed/simple;
	bh=x0XHSmeayeoxzsjEur9qWdQXXL5JmdvVLGCROiTezQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYpOCVotDHjV5x0hs5PhS9rdjpFBZjohO6hHgNTiYkjnhh22pfkLlPgywxvVBPzVEjUk1zeyBa+0Nsk+Ci8h4lOZiYL1kD5ZGhP+Q/rZFXjn9XyuSy0RBzx+E8ESzg+uw3HNSrRQNryA9d8pkKHjoaNOF2zLf1rzkiTaJWVwF9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1Xp/ycP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E1EC4CEE7;
	Fri, 25 Jul 2025 15:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753458970;
	bh=x0XHSmeayeoxzsjEur9qWdQXXL5JmdvVLGCROiTezQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L1Xp/ycParvwzmCH2BUw6UuOIK3nkxfelPgPvttKdyUlu5vrdvqXGArsKEvd4EABp
	 Bg5wJOYFkt2IXEglWL0wr02w2F20n6r6QKDwqPgbNXB03J8nnMFuvuXCvBEBQmof6h
	 AveH4LXGWU00gVHLM9V2rYx5x63Sl029fgVXcEDeIirAV1D8SD/fZC+m/elQpuwP7T
	 cgdXgOa/+GLrmdwc1zZ5o+etoHIjzLjYilffuZOMk1B4pcP4SelZ+4BRUo7n+eyfA+
	 4q10AZZJDrqEvU4jVJNXAMdnU+NXBFGo3eFpoX6RlV0KEJyL1jMflMkxFxOcZXscPW
	 Fhz3gT2wNXtHg==
Date: Fri, 25 Jul 2025 08:56:10 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Subject: [PATCH 19/8] fuse2fs: don't record every errno in the superblock as
 an fs failure
Message-ID: <20250725155610.GP2672022@frogsfrogsfrogs>
References: <175182662934.1984706.3737778061161342509.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175182662934.1984706.3737778061161342509.stgit@frogsfrogsfrogs>

From: Darrick J. Wong <djwong@kernel.org>

fstests just blew up because somewhere in the fuse iomap code we
returned an ESTALE, which was then passed to translate_error.  That
function decided it was a Serious Error and wrote it to the superblock,
so every subsequent mount attempt failed.

I should go figure out why the iomap cache upsert operation returned
ESTALE, but that's not a sign that the *ondisk* filesystem is corrupt.
Prior to commit 71f046a788adba we wouldn't have written that to the
superblock either.

Fix this by isolating the handful of errno that usually mean corruption
problems in filesystems and writing those to the superblock; the other
errno are merely operational errors that can be passed back to the
kernel and up to userspace.

I'm not sure why e2fsck doesn't flag when s_error_count > 0.  That might
be an error on its own.

Cc: <linux-ext4@vger.kernel.org> # v1.47.3
Fixes: 71f046a788adba ("fuse2fs: correctly handle system errno values in __translate_error()")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 242bbfd221eb3a..18d8f426a5eb43 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4969,9 +4969,23 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 		is_err = 1;
 		ret = -EUCLEAN;
 		break;
-	default:
+	case EIO:
+#ifdef EILSEQ
+	case EILSEQ:
+#endif
+	case EUCLEAN:
+		/* these errnos usually denote corruption or persistence fail */
 		is_err = 1;
-		ret = (err < 256) ? -err : -EIO;
+		ret = -err;
+		break;
+	default:
+		if (err < 256) {
+			/* other errno are usually operational errors */
+			ret = -err;
+		} else {
+			is_err = 1;
+			ret = -EIO;
+		}
 		break;
 	}
 

