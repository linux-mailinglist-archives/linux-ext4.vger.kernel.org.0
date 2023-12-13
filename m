Return-Path: <linux-ext4+bounces-418-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B048107DB
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Dec 2023 02:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EF681C20E6A
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Dec 2023 01:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E2E10EA;
	Wed, 13 Dec 2023 01:51:28 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA7BD5
	for <linux-ext4@vger.kernel.org>; Tue, 12 Dec 2023 17:51:24 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4SqdK15pQfz29frN;
	Wed, 13 Dec 2023 09:32:53 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id ED8D31800C9;
	Wed, 13 Dec 2023 09:34:00 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 13 Dec
 2023 09:33:59 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <tytso@mit.edu>, <jack@suse.com>
CC: <linux-ext4@vger.kernel.org>, <yi.zhang@huawei.com>
Subject: [PATCH v2 5/5] ext4: Move ext4_check_bdev_write_error() into nojournal mode
Date: Wed, 13 Dec 2023 09:32:24 +0800
Message-ID: <20231213013224.2100050-6-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231213013224.2100050-1-chengzhihao1@huawei.com>
References: <20231213013224.2100050-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000013.china.huawei.com (7.193.23.81)

Since JBD2 takes care of all metadata writeback errors of fs dev,
ext4_check_bdev_write_error() is useful only in nojournal mode.
Move it into '!ext4_handle_valid(handle)' branch.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Suggested-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4_jbd2.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index d1a2e6624401..5d8055161acd 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -235,8 +235,6 @@ int __ext4_journal_get_write_access(const char *where, unsigned int line,
 
 	might_sleep();
 
-	ext4_check_bdev_write_error(sb);
-
 	if (ext4_handle_valid(handle)) {
 		err = jbd2_journal_get_write_access(handle, bh);
 		if (err) {
@@ -244,7 +242,8 @@ int __ext4_journal_get_write_access(const char *where, unsigned int line,
 						  handle, err);
 			return err;
 		}
-	}
+	} else
+		ext4_check_bdev_write_error(sb);
 	if (trigger_type == EXT4_JTR_NONE || !ext4_has_metadata_csum(sb))
 		return 0;
 	BUG_ON(trigger_type >= EXT4_JOURNAL_TRIGGER_COUNT);
-- 
2.39.2


