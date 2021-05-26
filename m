Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62424390FFE
	for <lists+linux-ext4@lfdr.de>; Wed, 26 May 2021 07:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhEZFbX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 May 2021 01:31:23 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:47658 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhEZFbV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 May 2021 01:31:21 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 9562BCD6F0;
        Wed, 26 May 2021 13:29:33 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [113.57.152.160])
        by smtp.263.net (postfix) whith ESMTP id P31748T140095178925824S1622006973077818_;
        Wed, 26 May 2021 13:29:33 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <7fee386b9b371a26a8e884a007123901>
X-RL-SENDER: chenyichong@uniontech.com
X-SENDER: chenyichong@uniontech.com
X-LOGIN-NAME: chenyichong@uniontech.com
X-FST-TO: tytso@mit.edu
X-RCPT-COUNT: 5
X-SENDER-IP: 113.57.152.160
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   chenyichong <chenyichong@uniontech.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        chenyichong <chenyichong@uniontech.com>
Subject: [PATCH] use local variables ei instead of invoking function EXT4_I
Date:   Wed, 26 May 2021 13:29:30 +0800
Message-Id: <20210526052930.11278-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Signed-off-by: chenyichong <chenyichong@uniontech.com>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index fe6045a46599..a5c4cd1c757b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -374,7 +374,7 @@ void ext4_da_update_reserve_space(struct inode *inode,
 	ei->i_reserved_data_blocks -= used;
 	percpu_counter_sub(&sbi->s_dirtyclusters_counter, used);
 
-	spin_unlock(&EXT4_I(inode)->i_block_reservation_lock);
+	spin_unlock(&ei->i_block_reservation_lock);
 
 	/* Update quota subsystem for data blocks */
 	if (quota_claim)
-- 
2.20.1



