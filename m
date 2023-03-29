Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B926CED66
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Mar 2023 17:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjC2PuO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Mar 2023 11:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjC2PuG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Mar 2023 11:50:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61285588
        for <linux-ext4@vger.kernel.org>; Wed, 29 Mar 2023 08:50:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8D8E221A1C;
        Wed, 29 Mar 2023 15:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680105003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n6mFTNsPAlX4aM7ayWY6bDtyV8ROmsAxRc6wOQ4NTzs=;
        b=tb2IkMootnQyJmz8gYwcGKLaFlI3jf7Tg3G3Jy+pYylQbpGtoM4Zk94epXTVrauLiihB+u
        QQS6PHyDaXC6Eh3k++50wm7RAM8IULQ/zk1vw7paCpZsxAEWC6NDFIlH9IPp3uF83CkZlU
        Jd8L915eE/dym5woJozE3Tt244IiD0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680105003;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n6mFTNsPAlX4aM7ayWY6bDtyV8ROmsAxRc6wOQ4NTzs=;
        b=knbrPh8Gw/E9OQ2YLjkL2rALvYlm+aeaRAYB4QTO3WDZUq/qMmvZVgfXMGyNIOKOfT1IiI
        tbJi5SpBd53/ApAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B08E913A18;
        Wed, 29 Mar 2023 15:50:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gc8VKypeJGRiYwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 29 Mar 2023 15:50:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6B103A0755; Wed, 29 Mar 2023 17:49:50 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 12/13] ext4: Update comment in mpage_prepare_extent_to_map()
Date:   Wed, 29 Mar 2023 17:49:43 +0200
Message-Id: <20230329154950.19720-12-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230329125740.4127-1-jack@suse.cz>
References: <20230329125740.4127-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=jack@suse.cz; h=from:subject; bh=JuJKMzle1SxXfisUwr+OoJQBJlYVLkJcuPotCRuJdSg=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkJF4WeEVZqr4amnqsj7mdL7xepPJnfgOxiwfFHQVu IHph6OOJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZCReFgAKCRCcnaoHP2RA2ea0B/ 41OnehWlQSX9ZYC392iy6CG2Gzn2qgtZwC9yO71m7oOLMw3t8d+d3OoywRliorDfVUrtVjbp3JsibH 3yXvMx5xo1y+ZMijmU6ElapLUqDo6R+LV+YRCxEGv0HkHmdcUnMd2lPh9/E3XyNaAKsF5LYogreLBJ WXUsdfUyIH0ixK9Eat5DlT+TuLbrWDi3UQxaNyMd4LJWUVww3xxtxRIA0nqd69DDBirIor3U4BoKnD Xo0wzlQXn69oL9mVJfLMK0Piq9Fo2XyE+asTAvroyYVAZH9MIF7V8MjLi0wXZPIgiROqDMVG0iP/UI MszF8tM4ShILAGbULkJh1uDpt15H28
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Since filemap_write_and_wait() is now enough to get journalled data to
final location update the comment in mpage_prepare_extent_to_map().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 3c6bce0afb20..25a9e7586c50 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2490,11 +2490,10 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 			 * Just submit the page. For data=journal mode we
 			 * first handle writeout of the page for checkpoint and
 			 * only after that handle delayed page dirtying. This
-			 * is crutial so that forcing a transaction commit and
-			 * then calling filemap_write_and_wait() guarantees
-			 * current state of data is in its final location. Such
-			 * sequence is used for example by insert/collapse
-			 * range operations before discarding the page cache.
+			 * makes sure current data is checkpointed to the final
+			 * location before possibly journalling it again which
+			 * is desirable when the page is frequently dirtied
+			 * through a pin.
 			 */
 			if (!mpd->can_map) {
 				WARN_ON_ONCE(sb->s_writers.frozen ==
-- 
2.35.3

