Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BB43BA3AE
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Jul 2021 19:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhGBRhE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Jul 2021 13:37:04 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41545 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229455AbhGBRhE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Jul 2021 13:37:04 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 162HYRPD026119
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Jul 2021 13:34:28 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6A7EA15C3CE4; Fri,  2 Jul 2021 13:34:27 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH] ext4: fix flags validity checking for EXT4_IOC_CHECKPOINT
Date:   Fri,  2 Jul 2021 13:34:25 -0400
Message-Id: <20210702173425.1276158-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Use the correct bitmask when checking for any not-yet-supported flags.

Fixes: 351a0a3fbc35 ("ext4: add ioctl EXT4_IOC_CHECKPOINT")
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: Leah Rumancik <leah.rumancik@gmail.com>
---
 fs/ext4/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 5730aeca563c..6eed6170aded 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -823,7 +823,7 @@ static int ext4_ioctl_checkpoint(struct file *filp, unsigned long arg)
 	if (!EXT4_SB(sb)->s_journal)
 		return -ENODEV;
 
-	if (flags & ~JBD2_JOURNAL_FLUSH_VALID)
+	if (flags & ~EXT4_IOC_CHECKPOINT_FLAG_VALID)
 		return -EINVAL;
 
 	q = bdev_get_queue(EXT4_SB(sb)->s_journal->j_dev);
-- 
2.31.0

