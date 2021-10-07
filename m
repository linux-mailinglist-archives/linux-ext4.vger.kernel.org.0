Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36DCE42571F
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Oct 2021 17:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241971AbhJGPzh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Oct 2021 11:55:37 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52212 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbhJGPzg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Oct 2021 11:55:36 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 80469224A2;
        Thu,  7 Oct 2021 15:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633622021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jc5nUh27ErISpDz/ZA9dXFin6EKysjnwx9BXM6pzOcA=;
        b=YXpg4gcEgEiSOMFlzwyUPcio219UgQzEUXSEie0dZ+Nw5XYqJ1avsL/ui+5WiWOPTQwE0Q
        JvC0w58XJMwe8FZ3C8xh7MypPd3tzHgz0XpzbzYeh/fqkK8NxIOsH0LGsX7T01hZCRiErs
        iiU7AsJkGnr2p6Ob0INkXQGNFIFNtEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633622021;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jc5nUh27ErISpDz/ZA9dXFin6EKysjnwx9BXM6pzOcA=;
        b=dhNWNaGlBL8y659NbhU/WIMJctrLF+dnCDVUv2rgazcm0yDM1iOnw5EjQuCKE+JYyNDfXG
        d2CA4R5TZgS35YBA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 723B3A3B84;
        Thu,  7 Oct 2021 15:53:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3A1881F2C97; Thu,  7 Oct 2021 17:53:38 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     Ted Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        syzbot+3b6f9218b1301ddda3e2@syzkaller.appspotmail.com
Subject: [PATCH 2/2] ext4: Make sure to reset inode lockdep class when quota enabling fails
Date:   Thu,  7 Oct 2021 17:53:36 +0200
Message-Id: <20211007155336.12493-3-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211007155336.12493-1-jack@suse.cz>
References: <20211007155336.12493-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1329; h=from:subject; bh=2AW8YgiHYcFwXeYJdERa1qu8RiJg7Xz8i/Xwi0n619E=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhXxeWmBjWz5R/OvonqdDae364+ls6VdaPYJpKld+x eJsA2NiJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYV8XlgAKCRCcnaoHP2RA2VrfCA DvCi4M+RikUoMvth7gI5nIRJUy+nunTt07d6gTXnrBGcLvcNIyc897/MeEFDFarLcX72LURDt093MM tb8EX1xnQJmH3RSBEmk/mBu/FXyvTpna8vlgJU3a+wq9f73E8rsigdyo43TJ9VsDlYHcs7UWvBt64q N1s3nUhgcQl7ekU6HdM7X/U+YSPZ06W6R4WLjXhGtgh4OKmO/N7N+kwBOvAZQ/m/JoeSifYKLO80E7 gGG53DvOiXSLJzwJLIwuym+OHQC8NePevyGyWwz1GaSyUYHfxHyuMt4/+Kuv12zZSxHQokZhv9f37h LXGJ8HkGfc/N8PK5B3Vxi72z40Z/LF
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When we succeed in enabling some quota type but fail to enable another
one with quota feature, we correctly disable all enabled quota types.
However we forget to reset i_data_sem lockdep class. When the inode gets
freed and reused, it will inherit this lockdep class (i_data_sem is
initialized only when a slab is created) and thus eventually lockdep
barfs about possible deadlocks.

Reported-and-tested-by: syzbot+3b6f9218b1301ddda3e2@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index fbe9cae63786..70b5fcbd351a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6355,8 +6355,19 @@ int ext4_enable_quotas(struct super_block *sb)
 					"Failed to enable quota tracking "
 					"(type=%d, err=%d). Please run "
 					"e2fsck to fix.", type, err);
-				for (type--; type >= 0; type--)
+				for (type--; type >= 0; type--) {
+					struct inode *inode;
+
+					inode = sb_dqopt(sb)->files[type];
+					if (inode)
+						inode = igrab(inode);
 					dquot_quota_off(sb, type);
+					if (inode) {
+						lockdep_set_quota_inode(inode,
+							I_DATA_SEM_NORMAL);
+						iput(inode);
+					}
+				}
 
 				return err;
 			}
-- 
2.26.2

