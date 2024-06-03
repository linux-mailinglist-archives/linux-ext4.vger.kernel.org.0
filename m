Return-Path: <linux-ext4+bounces-2749-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2EA8D8073
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Jun 2024 12:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96AC4B23DC1
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Jun 2024 10:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D449580039;
	Mon,  3 Jun 2024 10:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RCFqGgMI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233BB107A8
	for <linux-ext4@vger.kernel.org>; Mon,  3 Jun 2024 10:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717412266; cv=none; b=cp0p8/y+0abaiAP9Un/vnwvvVv247YLu/2AOyWZHBu8sNvZfEj9FFPj+ATnhyqGpaS4KyU1Lk0d7uEBMbQplk18h+CZbsUx1VJzhrXQ4Mk/QoxOL++2J55NMZk/Ls6Pj8NCIrM2PGQrX4D5qadd/P6e5nv/sl+yu2ZSa6jP4GzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717412266; c=relaxed/simple;
	bh=ILLCQJ6YCWaiOUwBZ2oG6XTFLJUTtXS5qQ90oQP3gAY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Bc2z1XvRDv+QtDXKbyrcD7z2n3R1CfR+zmczbMO8EuwB0dhhqgWOh6XaSfcpqHS1IBbZOh03Y1RsC07Dx8rkRiD4nJjme0dOp2qoyUS5D+C4AVhSmgyPzHq3NFOQC0CWdPbvDIE0+UUSD4n1DfEdQJI2xmXJnWXS4nEu8/mTxHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RCFqGgMI; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=uGnoAAc7YPzdknGJd+
	YKFZ3RPWePJNQ/hjnRUSA0X0E=; b=RCFqGgMImfAT3PaJXGkgXjOimRQv9SteeC
	7KM11w07Ha3ak/d665LlOYSZWm/Wa/o3bQbW5pVTFV+Umj/W6acGxgZNfwjxK6gh
	G1gLENsIp0wOHoS6nJG+NiEt1XZCv3ENiRbc6BxRKkHsgUer1Iwsx3PdTxPxdf41
	d0k94zRvo=
Received: from localhost.tbsite.net (unknown [140.205.118.15])
	by gzga-smtp-mta-g1-2 (Coremail) with SMTP id _____wDXr1+RoV1m9DTwFg--.13199S3;
	Mon, 03 Jun 2024 18:57:22 +0800 (CST)
From: carrion bent <carrionbent@163.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	carrion bent <carrionbent@163.com>
Subject: [PATCH] ext4:fix macro definition error of EXT4_DIRENT_HASH and EXT4_DIRENT_MINOR_HASH
Date: Mon,  3 Jun 2024 18:57:19 +0800
Message-Id: <1717412239-31392-1-git-send-email-carrionbent@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID:_____wDXr1+RoV1m9DTwFg--.13199S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr45ury3tFWxCryrWr45ZFb_yoWDtFcE93
	48Ar18GwsIyF93Ka18A345tF1aqr48KF4jqF95G34qvr98Ja13A34qq3srZr93ury3AF1D
	uF9Yqr1rKrn7WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_SfOUUUUUU==
X-CM-SenderInfo: xfdu2xprqev0rw6rljoofrz/1tbiLhbycmV4JUKG1QAAsR
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

the macro parameter "entry" of EXT4_DIRENT_HASH and
EXT4_DIRENT_MINOR_HASH was not used, but rather the
variable de was directly used, which may be a local
variable inside a function that calls the macros

Signed-off-by: carrion bent <carrionbent@163.com>
---
 fs/ext4/ext4.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 983dad8..04bdd27 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2338,9 +2338,9 @@ struct ext4_dir_entry_2 {
 	((struct ext4_dir_entry_hash *) \
 		(((void *)(entry)) + \
 		((8 + (entry)->name_len + EXT4_DIR_ROUND) & ~EXT4_DIR_ROUND)))
-#define EXT4_DIRENT_HASH(entry) le32_to_cpu(EXT4_DIRENT_HASHES(de)->hash)
+#define EXT4_DIRENT_HASH(entry) le32_to_cpu(EXT4_DIRENT_HASHES(entry)->hash)
 #define EXT4_DIRENT_MINOR_HASH(entry) \
-		le32_to_cpu(EXT4_DIRENT_HASHES(de)->minor_hash)
+		le32_to_cpu(EXT4_DIRENT_HASHES(entry)->minor_hash)
 
 static inline bool ext4_hash_in_dirent(const struct inode *inode)
 {
-- 
2.7.4


