Return-Path: <linux-ext4+bounces-1386-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835BA866BF0
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Feb 2024 09:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CEF1284724
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Feb 2024 08:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A034E1C696;
	Mon, 26 Feb 2024 08:17:37 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78971CAA8
	for <linux-ext4@vger.kernel.org>; Mon, 26 Feb 2024 08:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708935457; cv=none; b=YoJEhhU4emLcf7hTREAePEWDBtwtTTf06/GLCI0ijAM5akaUXOa8iDGV48E7fMlEktzQl/ZWv1RGxiWFQXrCtHY1yg7kosGjO+PcWOztSC3/e8e7UOsMLennbit2k+AaXHDIlr3w4gUZ8zqUEXkxE6+5Bp7Zmr5OHIggIaVu4jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708935457; c=relaxed/simple;
	bh=vToQbZUIyw2YHyHWR8/F3LXddYsT60XuwSiXZwCRZwU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kg3nsJojf4wGcgaYZBFnGQaX9Zs68oyTjUVKbKpgR4BTDZnGsjTw/VyUQzW99Pyc/6nppPiiFjUnm3ja7uSoD2s9Dn7Hrud5cHM/vlzLIrEiJYdMuzHBgUHDQ2PJLrBQIJRtXPPyL3ZrHQTib5ms7PP3q/7bYAqKwKt/KEACi0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Tjthl1HzfzvVys;
	Mon, 26 Feb 2024 16:15:19 +0800 (CST)
Received: from kwepemm600012.china.huawei.com (unknown [7.193.23.74])
	by mail.maildlp.com (Postfix) with ESMTPS id D1DEC180068;
	Mon, 26 Feb 2024 16:17:26 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 16:17:26 +0800
From: Wenchao Hao <haowenchao2@huawei.com>
To: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
	<linux-ext4@vger.kernel.org>
CC: <louhongxiang@huawei.com>, Wenchao Hao <haowenchao2@huawei.com>
Subject: [RESEND PATCH] e2fsprogs: debugfs: Fix infinite loop when dump log
Date: Mon, 26 Feb 2024 16:14:51 +0800
Message-ID: <20240226081451.3224276-1-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600012.china.huawei.com (7.193.23.74)

There are 2 scenarios which would trigger infinite loop:

1. None log is recorded, then dumplog with "-n", for example:
   debugfs -R "logdump -O -n 10" /dev/xxx
   while /dev/xxx has no valid log recorded.
2. The log area is full and cycle write is triggered, then dumplog with
   debugfs -R "logdump -aOS" /dev/xxx

This patch add a new flag "reverse_flag" to mark if logdump has reached
to tail of logarea, it is default false, and set in macro WRAP().

If reverse_flag is true, and we comes to first_transaction_blocknr
again, just break the logdump loop.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 debugfs/logdump.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/debugfs/logdump.c b/debugfs/logdump.c
index b600228e..05ea839a 100644
--- a/debugfs/logdump.c
+++ b/debugfs/logdump.c
@@ -52,6 +52,7 @@ static int64_t		dump_counts;
 static blk64_t		block_to_dump, bitmap_to_dump, inode_block_to_dump;
 static unsigned int	group_to_dump, inode_offset_to_dump;
 static ext2_ino_t	inode_to_dump;
+static bool		reverse_flag;
 
 struct journal_source
 {
@@ -80,8 +81,10 @@ static void dump_fc_block(FILE *out_file, char *buf, int blocksize,
 static void do_hexdump (FILE *, char *, int);
 
 #define WRAP(jsb, blocknr, maxlen)					\
-	if (blocknr >= (maxlen))					\
-	    blocknr -= (maxlen - be32_to_cpu((jsb)->s_first));
+	if (blocknr >= (maxlen)) {					\
+		blocknr -= (maxlen - be32_to_cpu((jsb)->s_first));	\
+		reverse_flag = true;					\
+	}
 
 void do_logdump(int argc, char **argv, int sci_idx EXT2FS_ATTR((unused)),
 		    void *infop EXT2FS_ATTR((unused)))
@@ -115,6 +118,7 @@ void do_logdump(int argc, char **argv, int sci_idx EXT2FS_ATTR((unused)),
 	inode_block_to_dump = ANY_BLOCK;
 	inode_to_dump = -1;
 	dump_counts = -1;
+	reverse_flag = false;
 
 	reset_getopt();
 	while ((c = getopt (argc, argv, "ab:ci:f:OsSn:")) != EOF) {
@@ -477,8 +481,7 @@ static void dump_journal(char *cmdname, FILE *out_file,
 		if (dump_old && (dump_counts != -1) && (cur_counts >= dump_counts))
 			break;
 
-		if ((blocknr == first_transaction_blocknr) &&
-		    (cur_counts != 0) && dump_old && (dump_counts != -1)) {
+		if ((blocknr == first_transaction_blocknr) && dump_old && reverse_flag) {
 			fprintf(out_file, "Dump all %lld journal records.\n",
 				(long long) cur_counts);
 			break;
-- 
2.32.0


