Return-Path: <linux-ext4+bounces-2652-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5168CFC9C
	for <lists+linux-ext4@lfdr.de>; Mon, 27 May 2024 11:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 436D71F22879
	for <lists+linux-ext4@lfdr.de>; Mon, 27 May 2024 09:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE7B1DFE4;
	Mon, 27 May 2024 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="mkH/6rzs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PAzHvDBa"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C9313174B
	for <linux-ext4@vger.kernel.org>; Mon, 27 May 2024 09:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716801435; cv=none; b=mBHvpoNewsIk+kVHJIkyPmRo6EWQIWf73OiD7Z9tUBuIyYpGPkbv/3rhosxjkvvxoSkElGTqEgo2u6KQlSqAgtk+iu7ntGjDb4Kgxel93NbFdodbuztdYTmWU8DnZPwv8MBbmrwHmu+hVHbaWH7IE8XAflLtCpuuYA6m6eB9iqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716801435; c=relaxed/simple;
	bh=CecAeyoou+/HH0A17TQH4FkfTMhFzA64op5JgclGqGg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jTDgwe8mvmIlvVCSwp8IfF0T42UY5dbkvI1iPW/a4boGlZ+dmID5MQf5SffnFebE7Pe7Z11oMgeWFIPywh5MzxizoWuRhicTI2K1Z3rNLbyYq46ZSSwFDvmVfpOq6XK/5ApC00DcEB1I15m1rY3BNnKY7PQuEEL8MrfhlWgpY2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=mkH/6rzs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PAzHvDBa; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8B3CF13800E6
	for <linux-ext4@vger.kernel.org>; Mon, 27 May 2024 05:17:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 27 May 2024 05:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1716801431; x=1716887831; bh=YIL0JdpRjCvVW/wgX9cqG
	NR2AHbm3kdSXhTKqHdpm5Y=; b=mkH/6rzsv0J1Zba3cywrPNrgneyYZpzXyBWjj
	KtvfJ3ymN/xejFP57OzzhBvVpPtEjAVhLQGQBeaJw8ci9IJGl08xqVpVipZWbZj7
	kR6FLusbLxU0tzMQykdq2VV3AWGStUMiFl/MPDNAMv1aDa1ruEssOOWOdgJNb8sE
	u6aBNfZd4z92isxJ9Eq0EKobjSzvN+83nzYZtnGrnOEwLjzQnHAZt9S6ONK+Xbxa
	m0j5JXMvSZgtlvwmqyt5QG4Tsk+gr9hjZg6GzFGTuyK37XRUJQHMusajyYj4Q/bC
	Icbh5cRTayZ+Fm+05GXLNOAoEVLJlqQGPFz/qPUH7PWDOaYjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716801431; x=1716887831; bh=YIL0JdpRjCvVW/wgX9cqGNR2AHbm
	3kdSXhTKqHdpm5Y=; b=PAzHvDBaGTdxzjjyavd6mm90OuD1G011mV3OzllCyHQ3
	tu8HxGbBJZ15CLwyh7eeEnxBjhFUToH5rshkuMSsavA1JdSIKNcxXRJRrJ6mqv9D
	oJJxmtwOduoToyxXW8Zqck/dyfexn5nQ1aWMacPfDv9pXrHBf6/jzqJw+YLNiwkO
	09yQnr5ecWnoB8XdGIfl8QIaJf8wrNgYQZGWssEEHG4KUeNMGGVUqyBa/nbQ0xUD
	WMBqHtRUhTk6rsm5PE7RDf/EfHBjGv1+b4H5H5siuv0OO3vwg/9TsrSsgzIGV1H8
	uJaNieqCUFPzyUY/lvn7mKpm7kWeu9AvuZt46BZU/g==
X-ME-Sender: <xms:l09UZkr42Tj3GCW6pa1859gbpGEcXcsw3CZ00tl37FChKXfxXxI1xw>
    <xme:l09UZqpPD2IU7cwr8I7vPrs4sAKCP-k5aTI11P0cZK9v8HeTJyp02EXpAyghMMiQP
    9iqr--p9Bw6b-70bQ>
X-ME-Received: <xmr:l09UZpP_L1bwceDbmrGquJQCAdfKuE19DU4-LYGNEzJw91DKJveXeROFHqesWWrxbvrGz5Z3gxMJhRJoN71qhwqgXacF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejgedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehlhihsshgrucftohhsshcuoehhihesrghlhihsshgrrdhisheq
    necuggftrfgrthhtvghrnhephedvfffghfetieejgfetfedtgffhvdehueehvdejudfgge
    fgleejgfelfeevgfefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhephhhisegrlhihshhsrgdrihhs
X-ME-Proxy: <xmx:l09UZr5PdSyAGGYetzdrRUOAxtleKifl7ZfL3R8zGFjX06vKLod5TQ>
    <xmx:l09UZj5sA9dzqEQlniiPtVeSCPm2Qn1w3uEJzZyZVsqdJkT_UWZhLg>
    <xmx:l09UZrhmw62RLF6RPJ5_JjoF-Y4snL6hxsv63xmeISgOk5PEqHdDBA>
    <xmx:l09UZt6duT7EkSJL48uoqRoqbr-jUctHN4LF293UVcPFk9RFfZZIiw>
    <xmx:l09UZtRUczszvoZy9V7J91cAR5v2psVBOofIKdzwRugN0ifIIpWNJtOo>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-ext4@vger.kernel.org>; Mon, 27 May 2024 05:17:10 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id 420C03B1; Mon, 27 May 2024 11:17:08 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: linux-ext4@vger.kernel.org
Subject: [PATCH] libext2fs: fix unused parameter warnings/errors
Date: Mon, 27 May 2024 11:15:43 +0200
Message-ID: <20240527091542.4121237-2-hi@alyssa.is>
X-Mailer: git-send-email 2.44.0
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
I'm assuming here that it is actually intentional that these variables 
are unused!  I don't understand the code enough to know for sure — 
I'm just trying to fix some build regressions after updating e2fsprogs. :)

 lib/ext2fs/ext2fs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 6e87829f..a1ce192b 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -592,6 +592,8 @@ static inline __u32 __encode_extra_time(time_t seconds, __u32 nsec)
 #if (SIZEOF_TIME_T > 4)
 	extra = ((seconds - (__s32)(seconds & 0xffffffff)) >> 32) &
 		EXT4_EPOCH_MASK;
+#else
+	(void)seconds;
 #endif
 	return extra | (nsec << EXT4_EPOCH_BITS);
 }
@@ -600,6 +602,8 @@ static inline time_t __decode_extra_sec(time_t seconds, __u32 extra)
 #if (SIZEOF_TIME_T > 4)
 	if (extra & EXT4_EPOCH_MASK)
 		seconds += ((time_t)(extra & EXT4_EPOCH_MASK) << 32);
+#else
+	(void)extra;
 #endif
 	return seconds;
 }
@@ -642,6 +646,7 @@ static inline void __sb_set_tstamp(__u32 *lo, __u8 *hi, time_t seconds)
 static inline time_t __sb_get_tstamp(__u32 *lo, __u8 *hi)
 {
 #if (SIZEOF_TIME_T == 4)
+	(void)hi;
 	return *lo;
 #else
 	return ((time_t)(*hi) << 32) | *lo;

base-commit: 950a0d69c82b585aba30118f01bf80151deffe8c
-- 
2.44.0


