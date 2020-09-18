Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65EC726FDBA
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Sep 2020 15:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgIRNCy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Sep 2020 09:02:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:55236 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbgIRNCx (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 18 Sep 2020 09:02:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CC663AFCB;
        Fri, 18 Sep 2020 13:03:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 24B131E12E1; Fri, 18 Sep 2020 15:02:52 +0200 (CEST)
Date:   Fri, 18 Sep 2020 15:02:52 +0200
From:   Jan Kara <jack@suse.cz>
To:     =?utf-8?B?5bi45Yek5qWg?= <changfengnan@hikvision.com>
Cc:     Jan Kara <jack@suse.cz>, changfengnan <changfengnan@qq.com>,
        "adilger@dilger.ca" <adilger@dilger.ca>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "jack@suse.com" <jack@suse.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI0=?= =?utf-8?Q?=3A?= [PATCH] jbd2:
 avoid transaction reuse after reformatting
Message-ID: <20200918130252.GG18920@quack2.suse.cz>
References: <tencent_2341B065211F204FA07C3ADDA1AE07706405@qq.com>
 <20200911100603.GA26589@quack2.suse.cz>
 <2fa90e4995e0403f91f3290207618f35@hikvision.com>
 <20200917104440.GC16097@quack2.suse.cz>
 <6a08086d98c64f97bcaed1edd38861f6@hikvision.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a08086d98c64f97bcaed1edd38861f6@hikvision.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

On Fri 18-09-20 01:49:09, 常凤楠 wrote:
> Sorry about my mailer, the patch is in the attachment.

Thanks for the patch. Functionally the patch looks mostly OK now. The only
concern I have is that it handles checksum failures only in
JBD2_DESCRIPTOR_BLOCK. This is the most likely case but it could also
happen that JBD2_REVOKE_BLOCK or JBD2_COMMIT_BLOCK is the first one you see
with mismatching checksum. So I think you need to handle these cases as
well. I think your ri_commit_block logic below is an attempt to deal with
these cases (but it's difficult to be sure because of complete lack of
comments) but it is not reliable. A valid transaction can begin both with a
descriptor or with a revoke block.

A few other comments mostly about coding style below:

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index a4967b27ffb6..f7702e14077f 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -417,7 +417,7 @@ static int do_one_pass(journal_t *journal,
 			struct recovery_info *info, enum passtype pass)
 {
 	unsigned int		first_commit_ID, next_commit_ID;
-	unsigned long		next_log_block;
+	unsigned long		next_log_block, ri_commit_block = 0;
 	int			err, success = 0;
 	journal_superblock_t *	sb;
 	journal_header_t *	tmp;
@@ -428,7 +428,9 @@ static int do_one_pass(journal_t *journal,
 	__u32			crc32_sum = ~0; /* Transactional Checksums */
 	int			descr_csum_size = 0;
 	int			block_error = 0;
-
+	bool		need_check_commit_time = false;
+	__be64		last_trans_commit_time;

All variable names in this function seem to be indented by one more
column. Please keep the indentation.

+	

This empty line has whitespace on it. Please delete.

 	/*
 	 * First thing is to establish what we expect to find in the log
 	 * (in terms of transaction IDs), and where (in terms of log
@@ -514,18 +516,18 @@ static int do_one_pass(journal_t *journal,
 		switch(blocktype) {
 		case JBD2_DESCRIPTOR_BLOCK:
 			/* Verify checksum first */
+			if(pass == PASS_SCAN) 
			  ^ Coding style requires space before opening (.
You have this problem at multiple places.

+				ri_commit_block = 0;
+
 			if (jbd2_journal_has_csum_v2or3(journal))
 				descr_csum_size =
 					sizeof(struct jbd2_journal_block_tail);
 			if (descr_csum_size > 0 &&
 			    !jbd2_descriptor_block_csum_verify(journal,
 							       bh->b_data)) {
-				printk(KERN_ERR "JBD2: Invalid checksum "
-				       "recovering block %lu in log\n",
-				       next_log_block);
-				err = -EFSBADCRC;
-				brelse(bh);
-				goto failed;
+				need_check_commit_time = true;
+				jbd_debug(1, "invalid descriptor block found in %lu, continue recovery first.\n",next_log_block);
+				
 			}
 
 			/* If it is a valid descriptor block, replay it
@@ -535,6 +537,7 @@ static int do_one_pass(journal_t *journal,
 			if (pass != PASS_REPLAY) {
 				if (pass == PASS_SCAN &&
 				    jbd2_has_feature_checksum(journal) &&
+				    !need_check_commit_time &&
 				    !info->end_transaction) {
 					if (calc_chksums(journal, bh,
 							&next_log_block,
@@ -688,6 +691,36 @@ static int do_one_pass(journal_t *journal,
 			 * are present verify them in PASS_SCAN; else not
 			 * much to do other than move on to the next sequence
 			 * number. */
+			if(pass == PASS_SCAN) {
+				struct commit_header *cbh =
+					(struct commit_header *)bh->b_data;
+				if(need_check_commit_time) {
+					__be64 commit_time = be64_to_cpu(cbh->h_commit_sec);
+					if(commit_time >= last_trans_commit_time) {
+						printk(KERN_ERR "JBD2: Invalid checksum found in log, %d\n",
+						next_commit_ID);
+						err = -EFSBADCRC;
+						brelse(bh);
+						goto failed;
+					}
+					else
+					{
  Coding style requires to put opening { on the same line as 'else'. Like:
					else {
+						/*it's not belong to same journal, just end this recovery with success*/
+						jbd_debug(1, "JBD2: Invalid checksum found in block in log, but not same journal %d\n",
+						next_commit_ID);
+						err = 0;
+						brelse(bh);
+						goto done;
+					}
+				}
+				if(ri_commit_block) {
+					jbd_debug(1, "invalid commit block found in %lu, stop here.\n",next_log_block);
+					brelse(bh);
+					goto done;
+				}
+				ri_commit_block = next_log_block;

Why does the ri_commit_block logic exist? I don't see it bringing any
benefit...

+				last_trans_commit_time = be64_to_cpu(cbh->h_commit_sec);
+			}
 			if (pass == PASS_SCAN &&
 			    jbd2_has_feature_checksum(journal)) {
 				int chksum_err, chksum_seen;
@@ -755,6 +788,12 @@ static int do_one_pass(journal_t *journal,
 			continue;
 
 		case JBD2_REVOKE_BLOCK:
+			if (pass == PASS_SCAN && 
+				ri_commit_block) {
+				jbd_debug(1, "invalid revoke block found in %lu, stop here.\n",next_log_block);
+				brelse(bh);
+				goto done;
+			}

This is wrong. A valid transaction can start with a revoke block...

 			/* If we aren't in the REVOKE pass, then we can
 			 * just skip over this block. */
 			if (pass != PASS_REVOKE) {

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
