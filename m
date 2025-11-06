Return-Path: <linux-ext4+bounces-11603-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E649C3DA5B
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 196AD3B06DD
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8305A31D36C;
	Thu,  6 Nov 2025 22:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fjb8OhFO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C342BEC27
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468968; cv=none; b=qdqTRVNUBSvxFuhmnmreCKc3bSmKhdQIeVO5sJ2ic81Qp7nGYipFjH7aCHEAOP8PG6SwkDNtdIHQyHBtcFrQcYtVChnCAeCloKLtWGd5dXZSDd0lo4KwcSmnvEPy0/RBLTqTSjXSm4Pu5coU38SYFgtXsnXJCzJZBQtACiVUcnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468968; c=relaxed/simple;
	bh=GnU0bltdMGGh2uv08Oo9+G2kZsvhJ6OAW80wQ1rA5pQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jo2PcMNUx3f0TCKebs3lI3UqBbL3GyZgVwJ2xbRfOswGpBIA0EsTcYpUca01xrr2rLS9hRDHN0szljP+LXM5MAUxjyc9RcObm6DzYG6TqGRojFep9eRmzfI5Rqj+HcRqwRYgcr6k1zQDk1PINk5sO+cn44xFUSBRz05L3cRbII4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fjb8OhFO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89CBC4CEFB;
	Thu,  6 Nov 2025 22:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468968;
	bh=GnU0bltdMGGh2uv08Oo9+G2kZsvhJ6OAW80wQ1rA5pQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Fjb8OhFOxdcA/DcU1bRmzxNY7/GgiH15lyUVNs8dJZOBKUBWy5o2c+eZZcv7xq9EE
	 gqJNRHzbEZ7ziHAQXiE3euBJUbQNyEePe2BjVkEDhVmpggJDLji0Ftj748mUl/C4a7
	 qeRPOC7cTwowqeDZj/QYXSgzxzaTwhQJco/DYFiLJVgaaJzxdCqs0CLBDKZf2bzUrh
	 xHeNIBBVzLCCPi7ODhWgtf55WIo/WMjrFUUlFg4X7CDgNWM6LbwtyV8hqUveVuM9Mf
	 N0DC51RwCbSU3FyOf0sPpMd18Lv1+iyXzPvloBCFU4jjRFv5tVQSoRTTTtxtAAtJxC
	 M/vx1XAH5OCYw==
Date: Thu, 06 Nov 2025 14:42:47 -0800
Subject: [PATCH 3/4] fuse2fs: disable nfs exports
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246795299.2864102.10197771375885671176.stgit@frogsfrogsfrogs>
In-Reply-To: <176246795228.2864102.6424613500490349959.stgit@frogsfrogsfrogs>
References: <176246795228.2864102.6424613500490349959.stgit@frogsfrogsfrogs>
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
index 2468e7e1017d59..8a22147d904c27 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1588,6 +1588,9 @@ static void *op_init(struct fuse_conn_info *conn
 #ifdef FUSE_CAP_CACHE_SYMLINKS
 	fuse_set_feature_flag(conn, FUSE_CAP_CACHE_SYMLINKS);
 #endif
+#ifdef FUSE_CAP_NO_EXPORT_SUPPORT
+	fuse_set_feature_flag(conn, FUSE_CAP_NO_EXPORT_SUPPORT);
+#endif
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 	conn->time_gran = 1;
 	cfg->use_ino = 1;


