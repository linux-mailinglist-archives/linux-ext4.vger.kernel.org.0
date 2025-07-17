Return-Path: <linux-ext4+bounces-9069-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F4CB0984D
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Jul 2025 01:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A69F3A15DA
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 23:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551B5241667;
	Thu, 17 Jul 2025 23:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjHMAsST"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C6EFBF6;
	Thu, 17 Jul 2025 23:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795688; cv=none; b=dcI2Ds2y92UMgNOpW76S4uT0AX1a5vJ+cjMOgOYPd3zrNp7XRmX6qwAQNvCiMC8Ba6XU2NGqKuCdoh8M/jnuOfWU4xAUMmqw6oOWolVi5I+icWy2/IGHgKpDFPQLDxLwQ2l5otgqBZHAUNohxjuNR/3LtJAt2Yv9MAbeVtCYr2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795688; c=relaxed/simple;
	bh=vWm+jS101oedCHKeA50zAj6J7Eu+cBK42m9IVJhrEaU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rFde6vx1ZCtoKW5TAgLyvKWpgkGAenYESl5yZ1JXKo0E1HPDvb+PAT4jIYPLP/YLxeTcfkzyKKlqz/exyLp7RRVa4Y9HQPjLkaJ2336fZ0Sl3RQzRRnvJwQIYKiVVQHW637EfBiL1KKFOU02H7lQQrvM/CqSkG1EXTqkuXAA3vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjHMAsST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BAEC4CEE3;
	Thu, 17 Jul 2025 23:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795687;
	bh=vWm+jS101oedCHKeA50zAj6J7Eu+cBK42m9IVJhrEaU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=QjHMAsSThUyuGVYjgK2YmeIlsS8GRa+BBHVUe9LawabcedJ0j5dlsge8MMUVm2xDH
	 flMCky9c7Y7BtEKKq5fnfol4/H20OLfnbP82JGnblhoHX1hvz7hWkuY7iVWh6jYjcL
	 U5sB1YaefAu779yJ0QL+l9pxefd6kl5Ff1jvEVXiQYn1Wbgd5/d9jAgLuLLMcFuHgo
	 /lOj7Dfuud80EEeCc44QuhbjMUDSbc5aHUmiHjtcc3kKePbSXheSSMKQo5cTDVLpkA
	 ORH+qWShkzvCx3OLNmkyb6he6eo5FfcZtqGcMxvAd/Jit6fhUm1RGg6DQU7c8BGSUL
	 ufngWmp9likMA==
Date: Thu, 17 Jul 2025 16:41:27 -0700
Subject: [PATCH 08/22] fuse2fs: only flush the cache for the file under
 directio read
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: joannelkoong@gmail.com, miklos@szeredi.hu, John@groves.net,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, linux-ext4@vger.kernel.org,
 neal@gompa.dev
Message-ID: <175279461178.715479.16479332905031345778.stgit@frogsfrogsfrogs>
In-Reply-To: <175279460935.715479.15460687085573767955.stgit@frogsfrogsfrogs>
References: <175279460935.715479.15460687085573767955.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

We only need to flush the io_channel's cache for the file that's being
read directly, not everything else.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 64aca0f962daaf..88b71af417c0d7 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -5179,7 +5179,7 @@ static int fuse2fs_iomap_begin_read(struct fuse2fs *ff, ext2_ino_t ino,
 		return -ENOSYS;
 
 	/* flush dirty io_channel buffers to disk before iomap reads them */
-	err = io_channel_flush(ff->fs->io);
+	err = io_channel_flush_tag(ff->fs->io, ino);
 	if (err)
 		return translate_error(ff->fs, ino, err);
 


