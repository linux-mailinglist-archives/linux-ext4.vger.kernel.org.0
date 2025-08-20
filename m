Return-Path: <linux-ext4+bounces-9414-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC777B2E8FA
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 01:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 675341CC46FF
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Aug 2025 23:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5832E2E11CA;
	Wed, 20 Aug 2025 23:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+kgGPCK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14512E0B69
	for <linux-ext4@vger.kernel.org>; Wed, 20 Aug 2025 23:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755733441; cv=none; b=cgimvfpygpoyJQJ0XIYmvArGjScJwaMxMUWbsfQctpjtCUw4O6alXgcjXiA2+87BUDIc8l2/YvtZ5J5BZ1dmIAKFrgdcFKsiR9Hqe3clE0Cj3E7kMBGautEAwf4xQyh4ykdrzlFJ6uyKnMSEj/L9IqkwZYTo/hbrGsDs+ge5PQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755733441; c=relaxed/simple;
	bh=nSkx9B/N2xy2iDj2XodScLci7IOwPHVkADtPyT9Yorg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lhN3G26nzJ8Zp+JjB2wwv8ufLKeDFjTL3cYgek7XwF5aJ9Ju2CFTAoNtnU14tvrgRjup7SSC7HxymrP+YzuZBEt1mU3e6R2p0bgOFIOlx4XaMF1QlXL7hvDd5jM7w9AkTCrGmNNqFNo2+aKsqkaUebS62tTOlmFaorOaCPjntVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+kgGPCK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F284C4CEE7;
	Wed, 20 Aug 2025 23:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755733440;
	bh=nSkx9B/N2xy2iDj2XodScLci7IOwPHVkADtPyT9Yorg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=H+kgGPCKINxY4JCMlWIY095wDUaS9FbpMPKWvIa3M39s0ohUOMqFvVSLr6KzdpZIp
	 94hvIqJA2jBUj2pzbcitHw36ritOn6nEAHbKi6HAajth1ZKbU8VMh627wvoB00p1Y6
	 fZXBN8eM3Fg3YP/54WETaYwuDbAO+kwRQcWZEibMZGpzw08v49NdWjSb56Q6hlWjsE
	 NFTXTEYh0Y37Ys5JbmBbEcubXpZ4jnbXVWDy8hGJbV8x/VpnB1SRquRnv/mazmnFiK
	 XtvVJCR95+WANCSrs+KlP6Wpw5ZeNu/Q0S3ylK2o0H7LnbzQ+sDsONhaWOPChHFuxy
	 f1ZActOHaLLbg==
Date: Wed, 20 Aug 2025 16:44:00 -0700
Subject: [PATCH 12/12] libext2fs: relock CACHE_MTX after calling ->write_error
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <175573318818.4130038.7207560675429333657.stgit@frogsfrogsfrogs>
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

In the UNIX I/O manager, we drop CACHE_MTX before calling the
->write_error handler in case it decides to retry the failed write.
Therefore, we must retake the lock after it returns, to ensure
consistent lock state when flush_cached_blocks returns.

Cc: <linux-ext4@vger.kernel.org> # v1.46.6
Fixes: 0e0c7537eb5fdc ("libext2fs: unix_io: fix_potential error path deadlock in flush_cached_blocks()")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/unix_io.c |    1 +
 1 file changed, 1 insertion(+)


diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index 1af246da345bca..cb408f51779aa7 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -734,6 +734,7 @@ static errcode_t flush_cached_blocks(io_channel channel,
 					retval2);
 				if (err_buf)
 					ext2fs_free_mem(&err_buf);
+				mutex_lock(data, CACHE_MTX);
 				goto retry;
 			} else
 				cache->write_err = 0;


