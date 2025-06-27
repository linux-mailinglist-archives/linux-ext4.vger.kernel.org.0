Return-Path: <linux-ext4+bounces-8668-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AECAEADBB
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Jun 2025 06:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E2DE4A70A4
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Jun 2025 04:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB04C1BE871;
	Fri, 27 Jun 2025 04:11:27 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845962BAF9
	for <linux-ext4@vger.kernel.org>; Fri, 27 Jun 2025 04:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750997487; cv=none; b=GGGdu1TZDIgiMUJIXGhivawc/6YasLYAtBpLGwii9xhPLC/83PmoiX5PuGwchj9PalcN/4VaotCa3cF18CxSoEGGdMnTY1Z+Yn5ziD+TcCM0B2v/h88RutWVWRLHli0W7CdoedUNUF7tY9KdwDz0G7u5RxYzF+DE9qg6c4R5RuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750997487; c=relaxed/simple;
	bh=jaTYgmABf21nztGuEiu3NFE3x3QtaZ7dg4SgRRZ5Ows=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CZb9pOZABc9Fb0Fk9yZEEJ3LgNJom86G+ws/J+qJf6Eu8Rx/VsEQEJgmoeBXonsjlh7hCNWB85HaMe5BAiJNNa3seyjmc8bI+gN/wFQp4L6Jc0PYjKCF5Qnz+T5KM/QxqwyBduQKodWj2i9xTX5xd3/9L+pAnfpGA1b8Jo+Oj8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bT27S57phzCsMt;
	Fri, 27 Jun 2025 12:07:00 +0800 (CST)
Received: from kwepemp200004.china.huawei.com (unknown [7.202.195.99])
	by mail.maildlp.com (Postfix) with ESMTPS id 0600B140159;
	Fri, 27 Jun 2025 12:11:21 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemp200004.china.huawei.com
 (7.202.195.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 27 Jun
 2025 12:11:20 +0800
From: zhangjian <zhangjian496@huawei.com>
To: <tytso@mit.edu>
CC: <linux-ext4@vger.kernel.org>
Subject: [PATCH] debugfs: fix printing for sequence in descriptor/revoke block
Date: Sat, 28 Jun 2025 05:24:51 +0800
Message-ID: <20250627212451.3600741-1-zhangjian496@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemp200004.china.huawei.com (7.202.195.99)

When cursor cross the last journal block and will dump old journal blocks
sequence number will be lower than transaction number. Sequence number
should be read from descriptor block rather than accelerating transaction.

For example:
A snippet from "logdump -aO"
===============================================================
Found expected sequence 6, type 1 (descriptor block) at block 13
Dumping descriptor block, sequence 13, at block 13:
  FS block 276 logged at journal block 14 (flags 0x0)
  FS block 2 logged at journal block 15 (flags 0x2)
  FS block 295 logged at journal block 16 (flags 0x2)
  FS block 292 logged at journal block 17 (flags 0x2)
  FS block 7972 logged at journal block 18 (flags 0x2)
  FS block 1 logged at journal block 19 (flags 0x2)
  FS block 263 logged at journal block 20 (flags 0xa)
Found sequence 6 (not 13) at block 21: end of journal.
===============================================================

sequence number should be 6 from header->h_sequence, rather than 13 from
transaction accelerating from jsb->s_sequence

Signed-off-by: zhangjian <zhangjian496@huawei.com>
Signed-off-by: zhanchengbin <zhanchengbin1@h-partners.com>
---
 debugfs/logdump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/debugfs/logdump.c b/debugfs/logdump.c
index 324ed425..56f36291 100644
--- a/debugfs/logdump.c
+++ b/debugfs/logdump.c
@@ -532,7 +532,7 @@ static void dump_journal(char *cmdname, FILE *out_file,
 		case JBD2_DESCRIPTOR_BLOCK:
 			dump_descriptor_block(out_file, source, buf, jsb,
 					      &blocknr, blocksize, maxlen,
-					      transaction);
+					      sequence);
 			continue;
 
 		case JBD2_COMMIT_BLOCK:
@@ -545,7 +545,7 @@ static void dump_journal(char *cmdname, FILE *out_file,
 		case JBD2_REVOKE_BLOCK:
 			dump_revoke_block(out_file, buf, jsb,
 					  blocknr, blocksize,
-					  transaction);
+					  seqeunce);
 			blocknr++;
 			WRAP(jsb, blocknr, maxlen);
 			continue;
-- 
2.33.0


