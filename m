Return-Path: <linux-ext4+bounces-9045-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EDDB09005
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 17:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE3C6585C1F
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 15:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DBD2F948F;
	Thu, 17 Jul 2025 14:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dloanqwu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497942F9487
	for <linux-ext4@vger.kernel.org>; Thu, 17 Jul 2025 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752764374; cv=none; b=NaWyAfe4KVgEFu1EsAK6iw+vBs6DJ/ktj5v/YCmEG5iD/7WZZFMtAOHCvtO1A9B/gDF1gUvKKV5TBd8E4c1s/IKKcVa8hcITH53n340iBxEOsqYW+NtnisGS4VFJraDd4uWr/DHl/8fmTBNlUfC+Ga3V51+4cxiQUVKvdKucCgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752764374; c=relaxed/simple;
	bh=b2/wS5LBOZde2r8nil9BvE2O+45CJndiiEMcT3dbO/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrqLStogm6KeABEqUrGutzRT0/WeDHHCkurImYi3M8gFMW9MhA2MA5orxTNQu1TwSb3wLkmyd95DUV6j87PHQCsU39nftYGMeafWPnNZ1XeT5oLjBKZbWeCB/dhlkws8GCOBy7cdINKAW3x+wv6nCTRAwG6y9FGAW00nrcIwLhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dloanqwu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D79C4CEF0;
	Thu, 17 Jul 2025 14:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752764373;
	bh=b2/wS5LBOZde2r8nil9BvE2O+45CJndiiEMcT3dbO/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dloanqwum07a/p5DpZhAlrZh8IR4YZAi9pzTBPQMrpe/kJUEQRJv5uDEQ9FZihz7x
	 fMmVvsg+Nkpc9DiDCCrilnT8Om8ViheEIfanh2Lng9anbnyn330v0zUactooiKBxTw
	 MOpg30Qv8I9qAZr7z3IWWCD9BtHMGIM1U440XC+GANdZsdzoSpUMZ8AL7vNC6NJs0L
	 uV4eqOR+G9U7Tnwh87U/byUdsHgWlYObCfG8sLGBCh9NG40RJI0PMqRtxn0nOyrgpY
	 sbzv2XEE3KS3jxdxT0csfHneWCzRTAv7+EdkIQYlUT76NjM/pFr3Pwvdgb1kWh1ssH
	 d33XKc9GcA/vw==
Date: Thu, 17 Jul 2025 07:59:33 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Subject: [PATCH 14/8] libext2fs: fix data read corruption in
 ext2fs_file_read_inline_data
Message-ID: <20250717145933.GI2672022@frogsfrogsfrogs>
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

Fix numerous problems in the function that reads data from an inlinedata
file:

 - Reads starting after isize should be returned as short reads.
 - Reads past the end of the inline data should return zeroes.
 - Reads from the inline data buffer must not exceed isize.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 54e880b870f7fe ("libext2fs: handle inline data in read/write function")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/fileio.c |   22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/lib/ext2fs/fileio.c b/lib/ext2fs/fileio.c
index 818f7f05420029..900002c5295682 100644
--- a/lib/ext2fs/fileio.c
+++ b/lib/ext2fs/fileio.c
@@ -255,18 +255,26 @@ ext2fs_file_read_inline_data(ext2_file_t file, void *buf,
 			     unsigned int wanted, unsigned int *got)
 {
 	ext2_filsys fs;
-	errcode_t retval;
+	errcode_t retval = 0;
 	unsigned int count = 0;
+	uint64_t isize = EXT2_I_SIZE(&file->inode);
 	size_t size;
 
+	if (file->pos >= isize)
+		goto out;
+
 	fs = file->fs;
 	retval = ext2fs_inline_data_get(fs, file->ino, &file->inode,
 					file->buf, &size);
 	if (retval)
 		return retval;
 
-	if (file->pos >= size)
-		goto out;
+	/*
+	 * size is the number of bytes available for inline data storage, which
+	 * means it can exceed isize.
+	 */
+	if (size > isize)
+		size = isize;
 
 	count = size - file->pos;
 	if (count > wanted)
@@ -275,6 +283,14 @@ ext2fs_file_read_inline_data(ext2_file_t file, void *buf,
 	file->pos += count;
 	buf = (char *) buf + count;
 
+	/* zero-fill the rest of the buffer */
+	wanted -= count;
+	if (wanted > 0) {
+		memset(buf, 0, wanted);
+		file->pos += wanted;
+		count += wanted;
+	}
+
 out:
 	if (got)
 		*got = count;

