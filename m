Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4C222EB5D
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Jul 2020 13:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgG0Lob (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Jul 2020 07:44:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:45890 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgG0Lob (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 27 Jul 2020 07:44:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C06CDB606;
        Mon, 27 Jul 2020 11:44:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4F5EC1E0E83; Mon, 27 Jul 2020 13:44:30 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Lukas Czerner <lczerner@redhat.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 1/6] ext4: Handle error of ext4_setup_system_zone() on remount
Date:   Mon, 27 Jul 2020 13:44:24 +0200
Message-Id: <20200727114429.1478-2-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200727114429.1478-1-jack@suse.cz>
References: <20200727114429.1478-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4_setup_system_zone() can fail. Handle the failure in ext4_remount().

Reviewed-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 330957ed1f05..8e055ec57a2c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5653,7 +5653,10 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 		ext4_register_li_request(sb, first_not_zeroed);
 	}
 
-	ext4_setup_system_zone(sb);
+	err = ext4_setup_system_zone(sb);
+	if (err)
+		goto restore_opts;
+
 	if (sbi->s_journal == NULL && !(old_sb_flags & SB_RDONLY)) {
 		err = ext4_commit_super(sb, 1);
 		if (err)
-- 
2.16.4

