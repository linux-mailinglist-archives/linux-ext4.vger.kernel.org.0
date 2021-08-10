Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505C73E82B1
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Aug 2021 20:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbhHJSR1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Aug 2021 14:17:27 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59352 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238717AbhHJSO5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 Aug 2021 14:14:57 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17AIEVJg021957
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Aug 2021 14:14:32 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 824F815C37CF; Tue, 10 Aug 2021 14:14:31 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/2] jbd2: clean up two gcc -Wall warnings in recovery.c
Date:   Tue, 10 Aug 2021 14:14:26 -0400
Message-Id: <20210810181426.13162-2-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210810181426.13162-1-tytso@mit.edu>
References: <20210810181426.13162-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fix a signed vs unsigned and a void * pointer arithmetic warning.

This cleanup is also in e2fsprogs commit aec460db9a93 ("e2fsck: clean
up two gcc -Wall warnings in recovery.c").

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/jbd2/recovery.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index ba979fcf1cd3..8ca3527189f8 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -179,8 +179,8 @@ static int jbd2_descriptor_block_csum_verify(journal_t *j, void *buf)
 	if (!jbd2_journal_has_csum_v2or3(j))
 		return 1;
 
-	tail = (struct jbd2_journal_block_tail *)(buf + j->j_blocksize -
-			sizeof(struct jbd2_journal_block_tail));
+	tail = (struct jbd2_journal_block_tail *)((char *)buf +
+		j->j_blocksize - sizeof(struct jbd2_journal_block_tail));
 	provided = tail->t_checksum;
 	tail->t_checksum = 0;
 	calculated = jbd2_chksum(j, j->j_csum_seed, buf, j->j_blocksize);
@@ -896,7 +896,7 @@ static int scan_revoke_records(journal_t *journal, struct buffer_head *bh,
 {
 	jbd2_journal_revoke_header_t *header;
 	int offset, max;
-	int csum_size = 0;
+	unsigned csum_size = 0;
 	__u32 rcount;
 	int record_len = 4;
 
-- 
2.31.0

