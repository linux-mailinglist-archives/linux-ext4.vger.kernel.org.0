Return-Path: <linux-ext4+bounces-8141-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 065E1AC0106
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 02:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A47BE7B7263
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F96645;
	Thu, 22 May 2025 00:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPH70OTD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0219380
	for <linux-ext4@vger.kernel.org>; Thu, 22 May 2025 00:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872493; cv=none; b=LiMGfdsZrEmRi0QDzxf+0X8/7InROcdZt76pADmaTuDhR3AwnkMW6BAcQOlh0S1HhscQtYAXBwtufi4h/UoCeCIvDXraBC4ZqFBHESfgylviLqr3XfSgXhKU4GzPzlEKKKTju3MljGhtt6D5fy12+kpbe3mZA4xPsV3u2CzBS/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872493; c=relaxed/simple;
	bh=9lyKojZWWD8yvZW6Uj1nGdlMQs6o2QP+9zJtQCNK6g4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ayLoulZXoME6mQwyQg9cg3rcPi37dZsXZb6zl2r7lbqtUdnua9MFM1PI/6RKz0tMlINx+/FxwGULTYGhTvnLRW4pEvONNjiAISEXBTdl8Qzg++4A7Yy1epleFjL+pUEXb94aRR682YNR8MZEGTvYLqpYbtJJPcbuia8sFuqg+jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPH70OTD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9B0C4CEE4;
	Thu, 22 May 2025 00:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872492;
	bh=9lyKojZWWD8yvZW6Uj1nGdlMQs6o2QP+9zJtQCNK6g4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=EPH70OTD8oe9lEBYW9dqQWqX7ySaj9XTrz+4ThGWTAbQr/Zn2eArbKYNS/X5Kpoo3
	 Z0SX6AxBJSgkm+TECGTb8sf5aTenBovhqGxGhiiUksew2jsQUo+nkrDM+DUgrLaGhn
	 9WeQnmEE/Y/DtQM7gIRizCWS3Tut543ASrLZ9L86PYZDtSKI3TdBsXpVUgHNFu8qer
	 NgVMySiYcdUoVQD5lMNbyegutpmYmFxqIEnXsUBj323qI11n78MdEmBaKFHs+5lnV2
	 sCn+LuaPhiT2JEG+ASaO8keeO2xkBhmzd7cK07+iKeJhtCmjERW4PK6aMiv0/c7TCX
	 LBudQj4hLJTRQ==
Date: Wed, 21 May 2025 17:08:11 -0700
Subject: [PATCH 3/3] fuse2fs: disable nfs exports
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174787197897.1484400.7320488214945123982.stgit@frogsfrogsfrogs>
In-Reply-To: <174787197833.1484400.960875804610238864.stgit@frogsfrogsfrogs>
References: <174787197833.1484400.960875804610238864.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

The kernel fuse driver can export its own handles, but it doesn't
actually talk to the fuse server about those handles.  Hence they don't
survive unmount/mount cycles like regular ext4.  Disable them, because
they cause fstests regressions and it's not clear that they're suitable
for NFS export, at least not as most people understand ext4 NFS exports.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    3 +++
 1 file changed, 3 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 6137fc04198d39..769bb5babd2738 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -969,6 +969,9 @@ static void *op_init(struct fuse_conn_info *conn
 #ifdef FUSE_CAP_CACHE_SYMLINKS
 	fuse_set_feature_flag(conn, FUSE_CAP_CACHE_SYMLINKS);
 #endif
+#ifdef FUSE_CAP_NO_EXPORT_SUPPORT
+	fuse_set_feature_flag(conn, FUSE_CAP_NO_EXPORT_SUPPORT);
+#endif
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 	conn->time_gran = 1;
 	cfg->use_ino = 1;


