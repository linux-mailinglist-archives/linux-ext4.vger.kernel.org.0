Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5358912B5F1
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Dec 2019 17:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfL0Qic (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Dec 2019 11:38:32 -0500
Received: from mga06.intel.com ([134.134.136.31]:47977 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfL0Qic (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 27 Dec 2019 11:38:32 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2019 08:38:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,363,1571727600"; 
   d="scan'208";a="214825214"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 27 Dec 2019 08:38:29 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iksdB-000Fnd-D5; Sat, 28 Dec 2019 00:38:29 +0800
Date:   Sat, 28 Dec 2019 00:36:46 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [RFC PATCH] ext4: submit_fc_bh() can be static
Message-ID: <20191227163646.t3yxpunwz5cmy32v@4978f4969bb8>
References: <20191224081324.95807-14-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191224081324.95807-14-harshadshirwadkar@gmail.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


Fixes: 6ae30577ea12 ("ext4: main commit routine for fast commits")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 ext4_jbd2.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index f371f1f0f9148..05d5bfa0f355e 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -822,7 +822,7 @@ static int fc_write_data(struct inode *inode, u8 *start, u8 *end,
 	return num_tlvs;
 }
 
-void submit_fc_bh(struct buffer_head *bh)
+static void submit_fc_bh(struct buffer_head *bh)
 {
 	lock_buffer(bh);
 	clear_buffer_dirty(bh);
@@ -1153,7 +1153,7 @@ static void ext4_journal_fc_cleanup_cb(journal_t *journal)
 	trace_ext4_journal_fc_stats(sb);
 }
 
-int ext4_fc_perform_hard_commit(journal_t *journal)
+static int ext4_fc_perform_hard_commit(journal_t *journal)
 {
 	struct super_block *sb = (struct super_block *)(journal->j_private);
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
