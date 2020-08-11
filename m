Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC1A2414EB
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Aug 2020 04:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgHKCWm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Aug 2020 22:22:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42304 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726380AbgHKCWm (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 10 Aug 2020 22:22:42 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 53F846FF2CB2273FDFAE;
        Tue, 11 Aug 2020 10:22:40 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Tue, 11 Aug 2020
 10:22:31 +0800
From:   Shijie Luo <luoshijie1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <jack@suse.cz>, <linfeilong@huawei.com>
Subject: [PATCH] jbd2: remove useless variable chksum_seen in do_one_pass
Date:   Mon, 10 Aug 2020 22:21:28 -0400
Message-ID: <20200811022128.32690-1-luoshijie1@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This variable only indicates that we do checksum success, while
chksum_err can also do. Moreover, condition "!chksum_seen" in else
if bracket is pointless.

Signed-off-by: Shijie Luo <luoshijie1@huawei.com>
---
 fs/jbd2/recovery.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 2ed278f0dced..575bb6426bcc 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -690,14 +690,12 @@ static int do_one_pass(journal_t *journal,
 			 * number. */
 			if (pass == PASS_SCAN &&
 			    jbd2_has_feature_checksum(journal)) {
-				int chksum_err, chksum_seen;
+				int chksum_err = 0;
 				struct commit_header *cbh =
 					(struct commit_header *)bh->b_data;
 				unsigned found_chksum =
 					be32_to_cpu(cbh->h_chksum[0]);
 
-				chksum_err = chksum_seen = 0;
-
 				if (info->end_transaction) {
 					journal->j_failed_commit =
 						info->end_transaction;
@@ -709,11 +707,10 @@ static int do_one_pass(journal_t *journal,
 				    cbh->h_chksum_type == JBD2_CRC32_CHKSUM &&
 				    cbh->h_chksum_size ==
 						JBD2_CRC32_CHKSUM_SIZE)
-				       chksum_seen = 1;
+				       chksum_err = 0;
 				else if (!(cbh->h_chksum_type == 0 &&
 					     cbh->h_chksum_size == 0 &&
-					     found_chksum == 0 &&
-					     !chksum_seen))
+					     found_chksum == 0))
 				/*
 				 * If fs is mounted using an old kernel and then
 				 * kernel with journal_chksum is used then we
-- 
2.19.1

