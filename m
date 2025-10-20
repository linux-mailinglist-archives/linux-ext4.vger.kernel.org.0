Return-Path: <linux-ext4+bounces-10988-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C32EBBF3733
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Oct 2025 22:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10C244FD96B
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Oct 2025 20:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEEC2E6CA3;
	Mon, 20 Oct 2025 20:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdpM1PlD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D05278779
	for <linux-ext4@vger.kernel.org>; Mon, 20 Oct 2025 20:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760992077; cv=none; b=MsP4Jv7UmWIOJo62UzyshmM4st+Req/yHVboAwgjYYdiVxbs2KVcpF4muR4apyJJ76lHxHDu54C5qLxzcRP7qKwvoI2jFx0/68wq0neGv/TRbgjjUDgcwhCl+EjQs86YFtQXhIj15CMwH8U6uWQedgwiNPEWE76UrZxJjGUJbi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760992077; c=relaxed/simple;
	bh=t5/5eWMXeUkU9YkWsUYfZinvFp5kv4tV+P04oxgFM8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaTkBzLio08fbZEbHyyD2kLdnOr9knT0E38XxCGMti666Q9GB4zC8kCd+WCpWEWAqIcuhVFB5OEb8YLLlCbN5V0YnJbiBP1jlKkAgYQZCASBmRMg+JARTdAsjn99ngavBAo2LNoHfMcU+MSpogNYQIY8njw/G9XLhhCjBPaP0Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdpM1PlD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4E5C113D0;
	Mon, 20 Oct 2025 20:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760992076;
	bh=t5/5eWMXeUkU9YkWsUYfZinvFp5kv4tV+P04oxgFM8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mdpM1PlDSxZuo2M0ndGqyyPPiKTmSuNcxsfQYcK6g7K9iO+YcV1DuTJcaHlo9qxYg
	 8OIsszgBHCZ32q/bHXS2lmwmLVz8k0W2BRjFrT6MyeVQyY8T/j/Py3LdPnuaNAvF7X
	 XW/6wqXKQaUMdQp3mgdw19KjDSHQ0JR+Hq8qYI9k/Vok8Fqw+dJpAfw/ev8U8fdn1a
	 Cz4++ewjUwldeUXNnLOrq+pm2a38YqailmP3/wBUBxBlABJwit6wpc7ItS0An4pCba
	 B13g2JQKX+aBqhW05uchnJ1dxZggOmPpjuHkbcg+tckbGYsWTqLRAlnzK+8mKfp1Kz
	 lXQ7xbECnbhZQ==
Date: Mon, 20 Oct 2025 13:27:56 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Subject: [PATCH 19/16] fuse2fs: mount norecovery if main block device is
 readonly
Message-ID: <20251020202756.GO6170@frogsfrogsfrogs>
References: <176062915393.3343688.9810444125172113159.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176062915393.3343688.9810444125172113159.stgit@frogsfrogsfrogs>

From: Darrick J. Wong <djwong@kernel.org>

If the main block device is read-only, downgrade the mount to an ro
norecovery mount to match what the kernel does.  This will make
generic/050 somewhat less grouchy.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 9922747728a438..83886faf2eada8 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4773,6 +4773,19 @@ int main(int argc, char *argv[])
 		flags |= EXT2_FLAG_DIRECT_IO;
 	err = ext2fs_open2(fctx.device, options, flags, 0, 0, unix_io_manager,
 			   &global_fs);
+	if (err == EPERM || err == EACCES) {
+		/*
+		 * Source device cannot be opened for write.  Under these
+		 * circumstances, mount(8) will try again with a ro mount,
+		 * and the kernel will open the block device readonly.
+		 */
+		log_printf(&fctx, "%s\n",
+ _("WARNING: source write-protected, mounted read-only."));
+		flags &= ~EXT2_FLAG_RW;
+		fctx.ro = 1;
+		err = ext2fs_open2(fctx.device, options, flags, 0, 0,
+				   unix_io_manager, &global_fs);
+	}
 	if (err) {
 		err_printf(&fctx, "%s.\n", error_message(err));
 		err_printf(&fctx, "%s\n", _("Please run e2fsck -fy."));

