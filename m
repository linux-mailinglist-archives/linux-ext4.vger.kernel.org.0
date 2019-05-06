Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D54A014B30
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2019 15:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfEFNt4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 May 2019 09:49:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41408 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfEFNtz (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 6 May 2019 09:49:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DA81E308A9E2
        for <linux-ext4@vger.kernel.org>; Mon,  6 May 2019 13:49:55 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.205.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 367035D969
        for <linux-ext4@vger.kernel.org>; Mon,  6 May 2019 13:49:55 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH] ext4: Fix data corruption caused by overlapping unaligned and aligned IO
Date:   Mon,  6 May 2019 15:49:52 +0200
Message-Id: <20190506134952.26070-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 06 May 2019 13:49:55 +0000 (UTC)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Unaligned AIO must be serialized because the zeroing of partial blocks
of unaligned AIO can result in data corruption in case it's overlapping
another in flight IO.

Currently we wait for all unwritten extents before we submit unaligned
AIO which protects data in case of unaligned AIO is following overlapping
IO. However if a unaligned AIO is followed by overlapping aligned AIO we
can still end up corrupting data.

To fix this, we must make sure that the unaligned AIO is the only IO in
flight by waiting for unwritten extents conversion not just before the
IO submission, but right after it as well.

This problem can be reproduced by xfstest generic/538

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/file.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 98ec11f69cd4..2c5baa5e8291 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -264,6 +264,13 @@ ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	}
 
 	ret = __generic_file_write_iter(iocb, from);
+	/*
+	 * Unaligned direct AIO must be the only IO in flight. Otherwise
+	 * overlapping aligned IO after unaligned might result in data
+	 * corruption.
+	 */
+	if (ret == -EIOCBQUEUED && unaligned_aio)
+		ext4_unwritten_wait(inode);
 	inode_unlock(inode);
 
 	if (ret > 0)
-- 
2.20.1

