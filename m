Return-Path: <linux-ext4+bounces-8487-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A481ADC972
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Jun 2025 13:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C68A318961EE
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Jun 2025 11:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768812DF3D5;
	Tue, 17 Jun 2025 11:31:48 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C60F2DF3E6
	for <linux-ext4@vger.kernel.org>; Tue, 17 Jun 2025 11:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750159908; cv=none; b=p986Kdt6fVIk8a2Hralu8yJYh0OdBX1WaaWYo2O5KftR91LrP1v1/GKdaBpIwkPlAEW4gNAxD9nZNG3mJmMF8pjlu5MOtKosp6SRr0zSBwT+6ANAtVtGax4XTA2S6PN8iozqgcTh4hhQ0szcWrJ4f9tKIFl8xFNa0PAFawIuZk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750159908; c=relaxed/simple;
	bh=KZOjQdMzqVCan2vTE5sKw39hfp6EMWDiLG7KCt4cvQw=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=kHDUeeCImA9wjjZ5oYtsIDQuZyz6LI+0IXM49Agqr5B9MRzUkIcdU8hGrVHcdKfznNUgtpq+nWhkn3PIcxFmEVBz0blFDhNcx/oaGAkXu3wa4nRWxYYutN88QrDuRLUht5lkuXEUrNHAjeztZihtmy2iXQQ3bcB35/zAaA5q1g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bM4QJ0y8Rz1W3Sc;
	Tue, 17 Jun 2025 19:29:12 +0800 (CST)
Received: from kwepemo100017.china.huawei.com (unknown [7.202.195.215])
	by mail.maildlp.com (Postfix) with ESMTPS id 6D274180044;
	Tue, 17 Jun 2025 19:31:36 +0800 (CST)
Received: from [10.174.187.231] (10.174.187.231) by
 kwepemo100017.china.huawei.com (7.202.195.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 17 Jun 2025 19:31:35 +0800
Message-ID: <50aeb0c1-9f14-ed04-c3b7-7a50f61c3341@huawei.com>
Date: Tue, 17 Jun 2025 19:31:35 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
To: Theodore Ts'o <tytso@mit.edu>
CC: <linux-ext4@vger.kernel.org>, <qiangxiaojun@huawei.com>,
	<hejie3@huawei.com>
From: zhanchengbin <zhanchengbin1@huawei.com>
Subject: [PATCH] debugfs/logdump.c: Add parameter t to dump sequence commit
 timestamps
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo100017.china.huawei.com (7.202.195.215)

When filesystem errors occur, inspect journal sequences with parameter t to
  dump commit timestamps.

Signed-off-by: zhanchengbin <zhanchengbin@huawei.com>
---
  debugfs/logdump.c | 63 ++++++++++++++++++++++++++++++++++++++++-------
  1 file changed, 54 insertions(+), 9 deletions(-)

diff --git a/debugfs/logdump.c b/debugfs/logdump.c
index 324ed42..bbe1384 100644
--- a/debugfs/logdump.c
+++ b/debugfs/logdump.c
@@ -47,7 +47,7 @@ enum journal_location {JOURNAL_IS_INTERNAL, 
JOURNAL_IS_EXTERNAL};

  #define ANY_BLOCK ((blk64_t) -1)

-static int        dump_all, dump_super, dump_old, dump_contents, 
dump_descriptors;
+static int        dump_all, dump_super, dump_old, dump_contents, 
dump_descriptors, dump_time;
  static int64_t        dump_counts;
  static blk64_t        block_to_dump, bitmap_to_dump, inode_block_to_dump;
  static unsigned int    group_to_dump, inode_offset_to_dump;
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
+    dump_time = 0;
      wrapped_flag = false;

      reset_getopt();
-    while ((c = getopt (argc, argv, "ab:ci:f:OsSn:")) != EOF) {
+    while ((c = getopt (argc, argv, "ab:ci:f:OsSn:t")) != EOF) {
          switch (c) {
          case 'a':
              dump_all++;
@@ -162,6 +165,9 @@ void do_logdump(int argc, ss_argv_t argv, int 
sci_idx EXT2FS_ATTR((unused)),
                  return;
              }
              break;
+        case 't':
+            dump_time++;
+            break;
          default:
              goto print_usage;
          }
@@ -521,21 +527,33 @@ static void dump_journal(char *cmdname, FILE 
*out_file,
                  break;
          }

-        if (dump_descriptors) {
-            fprintf (out_file, "Found expected sequence %u, "
-                 "type %u (%s) at block %u\n",
-                 sequence, blocktype,
-                 type_to_name(blocktype), blocknr);
-        }
-
          switch (blocktype) {
          case JBD2_DESCRIPTOR_BLOCK:
+            if (dump_descriptors) {
+                fprintf (out_file, "Found expected sequence %u, "
+                     "type %u (%s) at block %u\n",
+                     sequence, blocktype,
+                     type_to_name(blocktype), blocknr);
+            }
+
              dump_descriptor_block(out_file, source, buf, jsb,
                            &blocknr, blocksize, maxlen,
                            transaction);
              continue;

          case JBD2_COMMIT_BLOCK:
+            if (dump_descriptors) {
+                fprintf (out_file, "Found expected sequence %u, "
+                     "type %u (%s) at block %u",
+                     sequence, blocktype,
+                     type_to_name(blocktype), blocknr);
+            }
+
+            if (dump_time)
+                dump_commit_time(out_file, buf);
+
+            fprintf(out_file, "\n");
+
              cur_counts++;
              transaction++;
              blocknr++;
@@ -543,6 +561,13 @@ static void dump_journal(char *cmdname, FILE *out_file,
              continue;

          case JBD2_REVOKE_BLOCK:
+            if (dump_descriptors) {
+                fprintf (out_file, "Found expected sequence %u, "
+                     "type %u (%s) at block %u\n",
+                     sequence, blocktype,
+                     type_to_name(blocktype), blocknr);
+            }
+
              dump_revoke_block(out_file, buf, jsb,
                        blocknr, blocksize,
                        transaction);
@@ -742,6 +767,26 @@ static void dump_descriptor_block(FILE *out_file,
      *blockp = blocknr;
  }

+static void dump_commit_time(FILE *out_file, char *buf)
+{
+    struct commit_header    *header;
+    __be64        commit_sec;
+    time_t        timestamp;
+    struct tm    timeinfo;
+
+    header = (struct commit_header*)buf;
+    commit_sec = be64_to_cpu(header->h_commit_sec);
+
+    timestamp = commit_sec;
+    gmtime_r(&timestamp, &timeinfo);
+    fprintf(out_file, ", commit at UTC: %04d-%02d-%02d %02d:%02d:%02d",
+        timeinfo.tm_year + 1900,
+        timeinfo.tm_mon + 1,
+        timeinfo.tm_mday,
+        timeinfo.tm_hour,
+        timeinfo.tm_min,
+        timeinfo.tm_sec);
+}

  static void dump_revoke_block(FILE *out_file, char *buf,
                    journal_superblock_t *jsb EXT2FS_ATTR((unused)),
-- 
2.33.0

