Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784BB1D73D2
	for <lists+linux-ext4@lfdr.de>; Mon, 18 May 2020 11:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgERJVY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 May 2020 05:21:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:36654 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgERJVX (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 18 May 2020 05:21:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 29825B018;
        Mon, 18 May 2020 09:21:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C6CA71E0390; Mon, 18 May 2020 11:21:21 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] ext4: Drop ext4_journal_free_reserved()
Date:   Mon, 18 May 2020 11:21:19 +0200
Message-Id: <20200518092120.10322-2-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200518092120.10322-1-jack@suse.cz>
References: <20200518092120.10322-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Remome ext4_journal_free_reserved() function. It is never used.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4_jbd2.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 4b9002f0e84c..1c926f31d43e 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -335,12 +335,6 @@ static inline handle_t *__ext4_journal_start(struct inode *inode,
 handle_t *__ext4_journal_start_reserved(handle_t *handle, unsigned int line,
 					int type);
 
-static inline void ext4_journal_free_reserved(handle_t *handle)
-{
-	if (ext4_handle_valid(handle))
-		jbd2_journal_free_reserved(handle);
-}
-
 static inline handle_t *ext4_journal_current_handle(void)
 {
 	return journal_current_handle();
-- 
2.16.4

