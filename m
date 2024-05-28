Return-Path: <linux-ext4+bounces-2666-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0C58D1CC4
	for <lists+linux-ext4@lfdr.de>; Tue, 28 May 2024 15:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91B801F24EDC
	for <lists+linux-ext4@lfdr.de>; Tue, 28 May 2024 13:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E554416F278;
	Tue, 28 May 2024 13:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="PjfYjGKP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QD8EAYuA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7494916E86E
	for <linux-ext4@vger.kernel.org>; Tue, 28 May 2024 13:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902337; cv=none; b=aPCGK4Bn1OxflMraw1dNjmB0tixGhVoYrOa8nziX2sDh23x4HNEx9K5NimN3u1lVaj1xzk13M82abwRMG0m0zJsbhXa4nxziEMcFccv5gMnmFSrMGyGetQPc75PI/7SIuvqxQ6Jqh1CSJxEkuk4pSutjv0GrQBnhb7XEjY/oAaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902337; c=relaxed/simple;
	bh=qJc0+tmbJPlsBaYoiyaw3o8tAlBzFBWCs00oA5tHAzU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXnwHgq8ezmFzd2g+FTJgBu0Mv6R85VsY3JHv2VUN3tKdX231PXrhMC2T2/63vrzBbTwM/1U2o1ocmvze+Db+nHOK37c4KYEbs35ZAhE7eZpiYBNwRO4Lbij3UyBNhkxDRQBVXHaAVf343g4dDUCIDKO6Buw9J1BXCMhhGposn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=PjfYjGKP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QD8EAYuA; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 6FA371C000F9;
	Tue, 28 May 2024 09:18:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 28 May 2024 09:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1716902333; x=
	1716988733; bh=uDfNy7hs8NViGiTKyNue5J7O2co9zGas7y+yIkANu2o=; b=P
	jfYjGKPoHCyYzVZsYBSv12uARcMHJYUsvL9fESJ544M7xl8Wb55boIfVTmtnv4Qq
	eRoNyHpD8jDa0p9y/uDBcrn/RmQkBbXc3VUdLiRGz1u2m2RRSYcao4NWstlbeT/q
	J7L5Q/J3j2skqF3RbmEerhDTk2ObRiZqIEl9zCEj/sZPglewdE2crWg+xYnrbwNQ
	GHKJz6N3XJT5FkevpfJniz/YvywF0Ww6IQFXQMpZC0SwHzkrjIvClDrH5w8EsWol
	bYIIz+tGgLTv5NfjUBFcuwpK+DhwUEb89pcG/mNgcquxxkIlOql0wVfriKINSBHE
	cVyQHs2Q96cw6uNFW/NEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1716902333; x=1716988733; bh=uDfNy7hs8NViG
	iTKyNue5J7O2co9zGas7y+yIkANu2o=; b=QD8EAYuA4LVxq5FBBg5Pb8wk+g+RR
	AKWaaeVpPelfYX40z/EPqQ/eIhOkBi3ZniGrDUBKVm+vsqn89vAdinHa3D8jQtAs
	HMHLixRbSTy5abQIwkumBY5u6FnTHLASPXTnnP2FC0c22b+XW+4D/UPk/b/gxyMn
	tvgDII0vhyzsPbbc3KSNlk+LtjJCBc0a7IONH87g/FZ85N7Fc0OBOk8vmmiMlYax
	J36EO8Qug3zmBD7QVTEX6aIxkKTK+cFnLtnLDtBQiE68AbR0KPCn7LrAN3MjfR5p
	oPOf83/UVTzmBhQ98Uh7MCV7pASszMrXoR4jcAVmhiQyRqXPG5TgFyDAA==
X-ME-Sender: <xms:vNlVZgKLBaXaXggFIOP6BCSBdzZHA7yWwSlJaiTwa4m8amhq1lY3dQ>
    <xme:vNlVZgIYDmjbXzDrEY2mjBnkqud9sq6U12HeVpzRZjGknRdROBY7C6WrPGiuUXdcB
    mz5l0I3eC045Ny6-A>
X-ME-Received: <xmr:vNlVZgtdyszVkO6nzPDsQZscDR-3ynaDM5AtpMq35tr9PGaHcVNx5MGdNweShpLgWhsNeCwjNbNpRD7_b5JtXU3hj9J9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejkedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlhihsshgrucftohhsshcuoehhihesrghlhihsshgrrdhi
    sheqnecuggftrfgrthhtvghrnhepgfefudekvdelieelledufeevheeglefggedvudejvd
    dtffeuueevffehleejkedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhephhhisegrlhihshhsrgdrihhs
X-ME-Proxy: <xmx:vNlVZtbryJZWlUTALxF44nbuvv0FgopTZWlbjqtZLZlAAPcbYliZlw>
    <xmx:vNlVZnZy-vBBM6jtGM9TWhr0N3c_NAADyAtfX9V4cvwMPlyX6Lne8A>
    <xmx:vNlVZpBcJ_fvI2DoLxBRdm4WKuIdJlDAo9vO8qnPahaIjBYZ9FQGtg>
    <xmx:vNlVZtZaSUDFuU59srZziQ0YKrWmolyYGZdAIKiFmVBZnrVUWs-1Iw>
    <xmx:vdlVZmkYOS_A-fnXOuYiY8IWFQqOO12aL_zzHEeYxtcFBeP4DbmNXmGZ>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 May 2024 09:18:52 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id D91AE52F; Tue, 28 May 2024 15:18:50 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: Theodore Ts'o <tytso@mit.edu>,
	linux-ext4@vger.kernel.org
Subject: [PATCH e2fsprogs v2] libext2fs: fix unused parameter warnings/errors
Date: Tue, 28 May 2024 15:18:41 +0200
Message-ID: <20240528131841.576999-1-hi@alyssa.is>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <874jaih04p.fsf@alyssa.is>
References: <874jaih04p.fsf@alyssa.is>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes building dependent packages that use -Werror.

Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 lib/ext2fs/ext2fs.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 6e87829f..ff22f66b 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -585,7 +585,8 @@ typedef struct ext2_struct_inode_scan *ext2_inode_scan;
  */
 #define EXT2_I_SIZE(i)	((i)->i_size | ((__u64) (i)->i_size_high << 32))
 
-static inline __u32 __encode_extra_time(time_t seconds, __u32 nsec)
+static inline __u32 __encode_extra_time(time_t seconds EXT2FS_ATTR((unused)),
+					__u32 nsec)
 {
 	__u32 extra = 0;
 
@@ -595,7 +596,8 @@ static inline __u32 __encode_extra_time(time_t seconds, __u32 nsec)
 #endif
 	return extra | (nsec << EXT4_EPOCH_BITS);
 }
-static inline time_t __decode_extra_sec(time_t seconds, __u32 extra)
+static inline time_t __decode_extra_sec(time_t seconds,
+					__u32 extra EXT2FS_ATTR((unused)))
 {
 #if (SIZEOF_TIME_T > 4)
 	if (extra & EXT4_EPOCH_MASK)
@@ -630,7 +632,8 @@ do {									      \
 		((struct ext2_inode_large *)(inode))->field ## _extra) :      \
 		(time_t)(inode)->field)
 
-static inline void __sb_set_tstamp(__u32 *lo, __u8 *hi, time_t seconds)
+static inline void __sb_set_tstamp(__u32 *lo, __u8 *hi EXT2FS_ATTR((unused)),
+				   time_t seconds)
 {
 	*lo = seconds & 0xffffffff;
 #if (SIZEOF_TIME_T > 4)
@@ -639,7 +642,7 @@ static inline void __sb_set_tstamp(__u32 *lo, __u8 *hi, time_t seconds)
 	*hi = 0;
 #endif
 }
-static inline time_t __sb_get_tstamp(__u32 *lo, __u8 *hi)
+static inline time_t __sb_get_tstamp(__u32 *lo, __u8 *hi EXT2FS_ATTR((unused)))
 {
 #if (SIZEOF_TIME_T == 4)
 	return *lo;

base-commit: 950a0d69c82b585aba30118f01bf80151deffe8c
-- 
2.44.0


