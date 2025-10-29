Return-Path: <linux-ext4+bounces-11145-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB21BC17990
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Oct 2025 01:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D28C400E49
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Oct 2025 00:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDE32D24B6;
	Wed, 29 Oct 2025 00:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8DWQjMl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404BA263C75;
	Wed, 29 Oct 2025 00:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698604; cv=none; b=WLde5HSZKngnWYRPAiJB8ANZvpcKFvD9ClaER6YncVMwjeaF9Mt3c+RFGwCqNBtGwwyXTFmf1xt9i1W0EAX9UWGk4DPIFxAJDVPcVzpthcr2Xvs0Tnkaad6HQViWT+f3diDfZ0TNjmeV3vZ0lpeEw7vXvw1fNpOt2lNa5Or48DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698604; c=relaxed/simple;
	bh=ssFrNMajnicXJn39CakLDbBqCGbp4RcCtTVSgDCvW0I=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R42Bb3Y5AClS2lvwjkjRdOHOp0UNxHmiMfmPINe6NseSr18anIp2LQTmscgOtwCjQmfH4FSHcjxhkMkTUzhuXPsn3ZZiHxJF4wgSTBvBX2Cm9vMsJFF4Yq1oyrmqUEeuKBrXKWI+RwfliFwXOHtOArujBQfSDXeQCUNdOBVLijw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8DWQjMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBA6C4CEE7;
	Wed, 29 Oct 2025 00:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698604;
	bh=ssFrNMajnicXJn39CakLDbBqCGbp4RcCtTVSgDCvW0I=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=D8DWQjMlB9VJXKkLTnrWAnJrBGQW7EVcoGvp64/WAJM8knym74HUYzsgToPd44bdn
	 FxelLZbW26rcDJQWWXfhi3+uecByx57NXqU7SfRUdRBsKTpbXCT+Oc61MliUFT0W2D
	 Xtzq18NfA2M3cy3uc2+vWPINeithmEo9NSLg8XSQy45XybREDPoH3ZJw3CAzMQLsdO
	 P4K6a3azdEg91hQkVwf0Om+kZ9v9K77bOMNQFXEB40gjahBfwZZ5Uy4p2Br1p0E1ZK
	 e3rzB6seydpyZhpyMwpfCg3m7WgpTl52HYzi2ybhApr0XZMGUdhqgagkMhkGeSTLCn
	 bqDs8BpFU5cVQ==
Date: Tue, 28 Oct 2025 17:43:23 -0700
Subject: [PATCH 2/5] fuse: signal that a fuse inode should exhibit local fs
 behaviors
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169809296.1424347.6509219210054935670.stgit@frogsfrogsfrogs>
In-Reply-To: <176169809222.1424347.16562281526870178424.stgit@frogsfrogsfrogs>
References: <176169809222.1424347.16562281526870178424.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create a new fuse inode flag that indicates that the kernel should
implement various local filesystem behaviors instead of passing vfs
commands straight through to the fuse server and expecting the server to
do all the work.  For example, this means that we'll use the kernel to
transform some ACL updates into mode changes, and later to do
enforcement of the immutable and append iflags.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index aaa8574fd72775..a8068bee90af57 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -232,6 +232,11 @@ enum {
 	FUSE_I_BTIME,
 	/* Wants or already has page cache IO */
 	FUSE_I_CACHE_IO_MODE,
+	/*
+	 * Client has exclusive access to the inode, either because fs is local
+	 * or the fuse server has an exclusive "lease" on distributed fs
+	 */
+	FUSE_I_EXCLUSIVE,
 };
 
 struct fuse_conn;
@@ -1046,7 +1051,7 @@ static inline struct fuse_conn *get_fuse_conn(struct inode *inode)
 	return get_fuse_mount_super(inode->i_sb)->fc;
 }
 
-static inline struct fuse_inode *get_fuse_inode(struct inode *inode)
+static inline struct fuse_inode *get_fuse_inode(const struct inode *inode)
 {
 	return container_of(inode, struct fuse_inode, inode);
 }
@@ -1088,6 +1093,13 @@ static inline bool fuse_is_bad(struct inode *inode)
 	return unlikely(test_bit(FUSE_I_BAD, &get_fuse_inode(inode)->state));
 }
 
+static inline bool fuse_inode_is_exclusive(const struct inode *inode)
+{
+	const struct fuse_inode *fi = get_fuse_inode(inode);
+
+	return test_bit(FUSE_I_EXCLUSIVE, &fi->state);
+}
+
 static inline struct folio **fuse_folios_alloc(unsigned int nfolios, gfp_t flags,
 					       struct fuse_folio_desc **desc)
 {


