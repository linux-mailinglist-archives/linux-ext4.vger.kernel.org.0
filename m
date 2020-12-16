Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B331A2DBACF
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Dec 2020 06:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgLPFlT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Dec 2020 00:41:19 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47908 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725274AbgLPFlS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Dec 2020 00:41:18 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BG5eTSu020120
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Dec 2020 00:40:30 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id AAC14420280; Wed, 16 Dec 2020 00:40:29 -0500 (EST)
Date:   Wed, 16 Dec 2020 00:40:29 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 07/12] ext4: Defer saving error info from atomic context
Message-ID: <X9mdzfqfC1HJC4ts@mit.edu>
References: <20201127113405.26867-1-jack@suse.cz>
 <20201127113405.26867-8-jack@suse.cz>
 <X9mbnUqNFnJSN1S8@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X9mbnUqNFnJSN1S8@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Applied with the following additional change folded in:

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0c18f50f2207..9d0ce11bd48e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5475,17 +5475,21 @@ static int ext4_commit_super(struct super_block *sb, int sync)
 	spin_lock(&sbi->s_error_lock);
 	if (sbi->s_add_error_count > 0) {
 		es->s_state |= cpu_to_le16(EXT4_ERROR_FS);
-		__ext4_update_tstamp(&es->s_first_error_time,
-				     &es->s_first_error_time_hi,
-				     sbi->s_first_error_time);
-		strncpy(es->s_first_error_func, sbi->s_first_error_func,
-			sizeof(es->s_first_error_func));
-		es->s_first_error_line = cpu_to_le32(sbi->s_first_error_line);
-		es->s_first_error_ino = cpu_to_le32(sbi->s_first_error_ino);
-		es->s_first_error_block = cpu_to_le64(sbi->s_first_error_block);
-		es->s_first_error_errcode =
+		if (!es->s_first_error_time && !es->s_first_error_time_hi) {
+			__ext4_update_tstamp(&es->s_first_error_time,
+					     &es->s_first_error_time_hi,
+					     sbi->s_first_error_time);
+			strncpy(es->s_first_error_func, sbi->s_first_error_func,
+				sizeof(es->s_first_error_func));
+			es->s_first_error_line =
+				cpu_to_le32(sbi->s_first_error_line);
+			es->s_first_error_ino =
+				cpu_to_le32(sbi->s_first_error_ino);
+			es->s_first_error_block =
+				cpu_to_le64(sbi->s_first_error_block);
+			es->s_first_error_errcode =
 				ext4_errno_to_code(sbi->s_first_error_code);
-
+		}
 		__ext4_update_tstamp(&es->s_last_error_time,
 				     &es->s_last_error_time_hi,
 				     sbi->s_last_error_time);
