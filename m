Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6250E248E7B
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Aug 2020 21:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgHRTPO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Aug 2020 15:15:14 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56409 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726585AbgHRTPO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 Aug 2020 15:15:14 -0400
Received: from callcc.thunk.org (pool-108-49-65-20.bstnma.fios.verizon.net [108.49.65.20])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 07IJExAa004954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Aug 2020 15:15:00 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D39EB420DC0; Tue, 18 Aug 2020 15:14:59 -0400 (EDT)
Date:   Tue, 18 Aug 2020 15:14:59 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Shijie Luo <luoshijie1@huawei.com>, linux-ext4@vger.kernel.org,
        linfeilong@huawei.com
Subject: Re: [PATCH] jbd2: remove useless variable chksum_seen in do_one_pass
Message-ID: <20200818191459.GC162457@mit.edu>
References: <20200811022128.32690-1-luoshijie1@huawei.com>
 <20200818104826.GA1902@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818104826.GA1902@quack2.suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I wonder if this is even cleaner?  What do folks think?

  	    	    	 - Ted

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 2ed278f0dced..4373abbfd19a 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -690,14 +690,11 @@ static int do_one_pass(journal_t *journal,
 			 * number. */
 			if (pass == PASS_SCAN &&
 			    jbd2_has_feature_checksum(journal)) {
-				int chksum_err, chksum_seen;
 				struct commit_header *cbh =
 					(struct commit_header *)bh->b_data;
 				unsigned found_chksum =
 					be32_to_cpu(cbh->h_chksum[0]);
 
-				chksum_err = chksum_seen = 0;
-
 				if (info->end_transaction) {
 					journal->j_failed_commit =
 						info->end_transaction;
@@ -705,42 +702,23 @@ static int do_one_pass(journal_t *journal,
 					break;
 				}
 
-				if (crc32_sum == found_chksum &&
-				    cbh->h_chksum_type == JBD2_CRC32_CHKSUM &&
-				    cbh->h_chksum_size ==
-						JBD2_CRC32_CHKSUM_SIZE)
-				       chksum_seen = 1;
-				else if (!(cbh->h_chksum_type == 0 &&
-					     cbh->h_chksum_size == 0 &&
-					     found_chksum == 0 &&
-					     !chksum_seen))
-				/*
-				 * If fs is mounted using an old kernel and then
-				 * kernel with journal_chksum is used then we
-				 * get a situation where the journal flag has
-				 * checksum flag set but checksums are not
-				 * present i.e chksum = 0, in the individual
-				 * commit blocks.
-				 * Hence to avoid checksum failures, in this
-				 * situation, this extra check is added.
-				 */
-						chksum_err = 1;
-
-				if (chksum_err) {
-					info->end_transaction = next_commit_ID;
-
-					if (!jbd2_has_feature_async_commit(journal)) {
-						journal->j_failed_commit =
-							next_commit_ID;
-						brelse(bh);
-						break;
-					}
-				}
+                                /* Neither checksum match nor unused? */
+				if (!((crc32_sum == found_chksum &&
+				       cbh->h_chksum_type ==
+						JBD2_CRC32_CHKSUM &&
+				       cbh->h_chksum_size ==
+						JBD2_CRC32_CHKSUM_SIZE) ||
+				      (cbh->h_chksum_type == 0 &&
+				       cbh->h_chksum_size == 0 &&
+				       found_chksum == 0)))
+					goto chksum_error;
+
 				crc32_sum = ~0;
 			}
 			if (pass == PASS_SCAN &&
 			    !jbd2_commit_block_csum_verify(journal,
 							   bh->b_data)) {
+			chksum_error:
 				info->end_transaction = next_commit_ID;
 
 				if (!jbd2_has_feature_async_commit(journal)) {
