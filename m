Return-Path: <linux-ext4+bounces-8798-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EE1AF7344
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Jul 2025 14:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9953BB9F2
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Jul 2025 12:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9772E5400;
	Thu,  3 Jul 2025 12:08:01 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269F52E4983
	for <linux-ext4@vger.kernel.org>; Thu,  3 Jul 2025 12:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751544481; cv=none; b=Go51+C+8J4rlCqimd9YAEKLYUnkyU6vRhSVfg5WnocvRewnkjDutc4eJtOptRYpBPszqehzB8II85D1m+ARETxGUdBeIT+JILhMkk8tbWIQ26PoBxnJUoBZngH5OW+Ko22ANntVsae4e84u6oL41ojv5YYmWb4BZqpc939p5X4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751544481; c=relaxed/simple;
	bh=jreUI5ENE4FP6OiVZQGo0yWaWoUVeoajHwdCFVLqK78=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=kFhEVpaQ2C4AXyW3+0vnHnH5RKOJfkkNdtk3uP05Xuy4fDBXJiUXY8gYbqm+dINWw6g2BBIT7CwwZtPze7J59tzWDSl1VJ5VGZpVHq3+IklIKJgDJHmyf6br6+Tm0BpJBaZRxq3rbbWzzKWgY7rZrOiMB0HAhRirfGxa+EBiUOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bXwQx1tDkz1GCFv;
	Thu,  3 Jul 2025 20:03:53 +0800 (CST)
Received: from kwepemo100017.china.huawei.com (unknown [7.202.195.215])
	by mail.maildlp.com (Postfix) with ESMTPS id A9B43180B3F;
	Thu,  3 Jul 2025 20:07:54 +0800 (CST)
Received: from [10.174.187.231] (10.174.187.231) by
 kwepemo100017.china.huawei.com (7.202.195.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 3 Jul 2025 20:07:54 +0800
Message-ID: <f5445a3b-f278-6440-91f3-08e5ca5b93cf@huawei.com>
Date: Thu, 3 Jul 2025 20:07:53 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
To: Theodore Ts'o <tytso@mit.edu>
CC: "Darrick J. Wong" <djwong@kernel.org>, <linux-ext4@vger.kernel.org>,
	<qiangxiaojun@huawei.com>, <hejie3@huawei.com>
From: zhanchengbin <zhanchengbin1@huawei.com>
Subject: [PATCH v4] debugfs/logdump.c: Add parameter t to dump sequence commit
 timestamps
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo100017.china.huawei.com (7.202.195.215)

When filesystem errors occur, inspect journal sequences with parameter t to
dump commit timestamps.

Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
---
v4: (1) Fix incorrect variable type; (2) Add logging for error branches.
- Link to v3:
https://patchwork.ozlabs.org/project/linux-ext4/patch/32252e29-aba9-df6f-3b97-d3774df375ad@huawei.com/
v3: Change from displaying UTC time to local time.
- Link to v2:
https://patchwork.ozlabs.org/project/linux-ext4/patch/5a4b703c-6940-d9da-5686-337e3220d3a4@huawei.com/
v2: Correct abnormal formats in the patch.
- Link to v1:
https://patchwork.ozlabs.org/project/linux-ext4/patch/50aeb0c1-9f14-ed04-c3b7-7a50f61c3341@huawei.com/
---
  debugfs/logdump.c | 61 ++++++++++++++++++++++++++++++++++++++++-------
  1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/debugfs/logdump.c b/debugfs/logdump.c
index 324ed42..a1256c4 100644
--- a/debugfs/logdump.c
+++ b/debugfs/logdump.c
@@ -47,7 +47,7 @@ enum journal_location {JOURNAL_IS_INTERNAL, 
JOURNAL_IS_EXTERNAL};

  #define ANY_BLOCK ((blk64_t) -1)

-static int		dump_all, dump_super, dump_old, dump_contents, 
dump_descriptors;
+static int		dump_all, dump_super, dump_old, dump_contents, 
dump_descriptors, dump_time;
  static int64_t		dump_counts;
  static blk64_t		block_to_dump, bitmap_to_dump, inode_block_to_dump;
  static unsigned int	group_to_dump, inode_offset_to_dump;
@@ -67,6 +67,8 @@ static void dump_descriptor_block(FILE *, struct 
journal_source *,
  				  char *, journal_superblock_t *,
  				  unsigned int *, unsigned int, __u32, tid_t);

+static void dump_commit_time(FILE *out_file, char *buf);
+
  static void dump_revoke_block(FILE *, char *, journal_superblock_t *,
  				  unsigned int, unsigned int, tid_t);

@@ -118,10 +120,11 @@ void do_logdump(int argc, ss_argv_t argv, int 
sci_idx EXT2FS_ATTR((unused)),
  	inode_block_to_dump = ANY_BLOCK;
  	inode_to_dump = -1;
  	dump_counts = -1;
+	dump_time = 0;
  	wrapped_flag = false;

  	reset_getopt();
-	while ((c = getopt (argc, argv, "ab:ci:f:OsSn:")) != EOF) {
+	while ((c = getopt (argc, argv, "ab:ci:f:OsSn:t")) != EOF) {
  		switch (c) {
  		case 'a':
  			dump_all++;
@@ -162,6 +165,9 @@ void do_logdump(int argc, ss_argv_t argv, int 
sci_idx EXT2FS_ATTR((unused)),
  				return;
  			}
  			break;
+		case 't':
+			dump_time++;
+			break;
  		default:
  			goto print_usage;
  		}
@@ -521,21 +527,33 @@ static void dump_journal(char *cmdname, FILE 
*out_file,
  				break;
  		}

-		if (dump_descriptors) {
-			fprintf (out_file, "Found expected sequence %u, "
-				 "type %u (%s) at block %u\n",
-				 sequence, blocktype,
-				 type_to_name(blocktype), blocknr);
-		}
-
  		switch (blocktype) {
  		case JBD2_DESCRIPTOR_BLOCK:
+			if (dump_descriptors) {
+				fprintf (out_file, "Found expected sequence %u, "
+					 "type %u (%s) at block %u\n",
+					 sequence, blocktype,
+					 type_to_name(blocktype), blocknr);
+			}
+
  			dump_descriptor_block(out_file, source, buf, jsb,
  					      &blocknr, blocksize, maxlen,
  					      transaction);
  			continue;

  		case JBD2_COMMIT_BLOCK:
+			if (dump_descriptors) {
+				fprintf (out_file, "Found expected sequence %u, "
+					 "type %u (%s) at block %u",
+					 sequence, blocktype,
+					 type_to_name(blocktype), blocknr);
+			}
+
+			if (dump_time)
+				dump_commit_time(out_file, buf);
+			else
+				fprintf(out_file, "\n");
+
  			cur_counts++;
  			transaction++;
  			blocknr++;
@@ -543,6 +561,13 @@ static void dump_journal(char *cmdname, FILE *out_file,
  			continue;

  		case JBD2_REVOKE_BLOCK:
+			if (dump_descriptors) {
+				fprintf (out_file, "Found expected sequence %u, "
+					 "type %u (%s) at block %u\n",
+					 sequence, blocktype,
+					 type_to_name(blocktype), blocknr);
+			}
+
  			dump_revoke_block(out_file, buf, jsb,
  					  blocknr, blocksize,
  					  transaction);
@@ -742,6 +767,24 @@ static void dump_descriptor_block(FILE *out_file,
  	*blockp = blocknr;
  }

+static void dump_commit_time(FILE *out_file, char *buf)
+{
+	struct commit_header	*header;
+	uint64_t	commit_sec;
+	time_t		timestamp;
+	char		time_buffer[26];
+	char		*result;
+
+	header = (struct commit_header *)buf;
+	commit_sec = be64_to_cpu(header->h_commit_sec);
+
+	timestamp = commit_sec;
+	result = ctime_r(&timestamp, time_buffer);
+	if (result)
+		fprintf(out_file, ", commit at: %s", time_buffer);
+	else
+		fprintf(out_file, ", commit_sec is %llu\n", commit_sec);
+}

  static void dump_revoke_block(FILE *out_file, char *buf,
  			      journal_superblock_t *jsb EXT2FS_ATTR((unused)),
-- 
2.33.0


