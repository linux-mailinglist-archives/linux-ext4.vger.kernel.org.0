Return-Path: <linux-ext4+bounces-2650-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 200C98CFA4A
	for <lists+linux-ext4@lfdr.de>; Mon, 27 May 2024 09:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5146A1C2109D
	for <lists+linux-ext4@lfdr.de>; Mon, 27 May 2024 07:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9A022338;
	Mon, 27 May 2024 07:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="uphEL6aI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FUVgW547"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1BDC13C
	for <linux-ext4@vger.kernel.org>; Mon, 27 May 2024 07:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716795695; cv=none; b=se0dXubCtgrSZpR9mKNOpt2bOtLqqYdwELnbqPtMPGrAntI544cAWvcO8T8W7facRbYT/kQH6LftxaRyXsp10hd6Dd2V5JNLLXiltzcq5cZtxm9INHzdrCyelKTkRBGYFhwPdMmMt94zqPiA3hNnoZy+Jkl3fgVUlO2giA/7+KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716795695; c=relaxed/simple;
	bh=FFEyMko5XZievcLFZyLJZwZBTiVRQMGqRjEJMDTARYQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=oid+IU+fvpAFZYZB74q/xw35flpBJZ5WYb8aYUuwxVudfHyhXchL7VmITrf0daZ2qFlxuuiGQ0eeKamzzCKKWMH2uT71nkqgiyRIpqajH+oT5z5thitp6vUUEBueP8QsYveBGtQF9ltSQkBgfZyeEaOjRFLCPKP2OrQkAqISV6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=uphEL6aI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FUVgW547; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3431C11400B3
	for <linux-ext4@vger.kernel.org>; Mon, 27 May 2024 03:41:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 27 May 2024 03:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1716795691; x=1716882091; bh=NeTHE9horBiDqH9mKdXCf
	4uVAsgHxcTkExiZdUfzgMc=; b=uphEL6aImi/dC23L2CNaBC+CfAr89xSfG8CFY
	ezXW+oKR/vC9yrcy8TGDwYi0D3FmNT6552DyFUhZN7VhehfpJ/QAzMiuWrmgYuEl
	uUMgk0ehLkyX8SZpcOR614RRqU0zGc2ClJvj7CXIAr4GEpTIa9fwchCcC0xIvECB
	WSNXPNoVwNbSYqRoVUwofW9RMQNwDLq8pXh0fuFOk8agxcedWOmQXC0+PME8vJAJ
	R2Z3enE/0FSR4uWWHqazt5HJiEJkrVgHuK7Uz5XZ0dayfcrejS9OF2zD4X3/L8dP
	FovBujQjbOP9zFfgk/7DyolyAjfFkikMrFaeHlrsC5/sEeagA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716795691; x=1716882091; bh=NeTHE9horBiDqH9mKdXCf4uVAsgH
	xcTkExiZdUfzgMc=; b=FUVgW547FUKG2ND2+sCSqPvBHiQJp9b35JXYMSjXIPE3
	maRfbTSH7gkaXkC8djos5HVZ5AS0DLvOKo2eJZDDpj/KHamiVoP0WXdF2gRFIVnr
	Q/5RymBnEkiwiIb7FH3imuumHbUUFaKGIuJbI3aw09WAmd+Asj5eXCS0u/LxWTuY
	snOQ10oEdxo1HPY6IDBADyvRPtRDA5uAFfraBkE1qBdXeVVwxQMsxKJGPN1HyjHR
	H7ifk3KfXclCgXVrX7Yp/qt3O2TLJ9paDu0M7O7r5u/+by4H9HYmhCoeADLgj+I6
	Tw+Lqio1+t8UlHBQB14HqtpYFpIR0w3SioT65/V0FQ==
X-ME-Sender: <xms:KjlUZrnyKugqiMrCtD4OsKt9VGun7A7F4uvjhhB3Cx2HxLr1wHyaHw>
    <xme:KjlUZu2q3egpbkVk5kqV2C_-C0UmEmm3MjSXVifH2fTqc9zvgZIDmrLeBsb43qoyT
    -RLl8-LG0TKA8NTZg>
X-ME-Received: <xmr:KjlUZhoNz11uRg2GADmFPTA37J2LJsajvvDVKIMZb0WyLeOWWGkX035TEKnMN9-E9H59U2__BkZkwiWoNlHx_Vumdj4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejfedguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhihshhsrgcutfhoshhsuceohhhisegrlhihshhsrgdrihhs
    qeenucggtffrrghtthgvrhhnpeehvdffgffhteeijefgteeftdfghfdvheeuhedvjedugf
    eggfeljefgleefvefgfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehhihesrghlhihsshgrrdhish
X-ME-Proxy: <xmx:KjlUZjlcyduRSuh2q6QZBXG4Tc-EtNYkOuDn5QTzRdBR2bea6Jte4Q>
    <xmx:KjlUZp0-ZyyjbNoNLRnzpPsWkibczeOAV1u7eon9LZEYARMtch7SNA>
    <xmx:KjlUZitT2Ql1enfVaoDrX7vsR2pr-5dnFe67w0QxAM2m-dTwotuK-w>
    <xmx:KjlUZtWcgtqjEiIon2AFk8RGDYll1v4799C8wRzXofjH789VYmpigg>
    <xmx:KzlUZq9V0DsEgC-G7yY3pLrTmPBdtwAurkwYAoHzHa1cCYYhvhqx1mfr>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-ext4@vger.kernel.org>; Mon, 27 May 2024 03:41:30 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id 4C7BF269; Mon, 27 May 2024 09:41:28 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: linux-ext4@vger.kernel.org
Subject: [PATCH] configure: add SIZEOF_TIME_T to public_config.h
Date: Mon, 27 May 2024 09:41:21 +0200
Message-ID: <20240527074121.2767083-1-hi@alyssa.is>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This has recently started being used by ext2fs.h.  Other users of the
ext2fs.h header would always get the 32-bit versions of the
__encode_extra_time, __decode_extra_sec, and __sb_set_tstamp; and the
64-bit version of __sb_get_tstamp, due to the SIZEOF_TIME_T macro
being undefined and treated as zero.

Fixes: 5b599a32 ("Fix 32-bit build and test failures")
Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 configure    | 5 +++++
 configure.ac | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/configure b/configure
index cba3191c..e299be02 100755
--- a/configure
+++ b/configure
@@ -13018,6 +13018,11 @@ if grep HAVE_SYS_TYPES_H confdefs.h > tmp_config.$$; then
 else
   echo "#undef HAVE_SYS_TYPES_H" >> public_config.h
 fi
+if grep SIZEOF_TIME_T confdefs.h > tmp_config.$$; then
+  uniq tmp_config.$$ >> public_config.h
+else
+  echo "#undef SIZEOF_TIME_T" >> public_config.h
+fi
 if grep WORDS_BIGENDIAN confdefs.h > tmp_config.$$; then
   uniq tmp_config.$$ >> public_config.h
 else
diff --git a/configure.ac b/configure.ac
index 131caef3..9a3dff1c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1156,6 +1156,11 @@ if grep HAVE_SYS_TYPES_H confdefs.h > tmp_config.$$; then
 else
   echo "#undef HAVE_SYS_TYPES_H" >> public_config.h
 fi
+if grep SIZEOF_TIME_T confdefs.h > tmp_config.$$; then
+  uniq tmp_config.$$ >> public_config.h
+else
+  echo "#undef SIZEOF_TIME_T" >> public_config.h
+fi
 if grep WORDS_BIGENDIAN confdefs.h > tmp_config.$$; then
   uniq tmp_config.$$ >> public_config.h
 else

base-commit: 950a0d69c82b585aba30118f01bf80151deffe8c
-- 
2.44.0


