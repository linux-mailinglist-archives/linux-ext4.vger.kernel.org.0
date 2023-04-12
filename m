Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0296DECDE
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Apr 2023 09:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjDLHrr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Apr 2023 03:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjDLHro (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Apr 2023 03:47:44 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E7161BF
        for <linux-ext4@vger.kernel.org>; Wed, 12 Apr 2023 00:47:43 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id c10-20020a17090abf0a00b0023d1bbd9f9eso13769211pjs.0
        for <linux-ext4@vger.kernel.org>; Wed, 12 Apr 2023 00:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681285662;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=501liZLtrBrP3uOqXrKpjeNE37BdPgtVkc0/sTO4GKQ=;
        b=ADdTjEWJfUQ0t2OmZZ7XrWs7OlcZo/ffK86KX0qSgIVzzXWLmRAPdOk8KlNQdZBrnL
         JSKocMtK3W3AsbPMvnuF87zsAjYWrGcqZ8ksVpQcQl4n/2gwXhG3u95Dh1buXUdSm2Wr
         uEkknULxJTXKIOJERPlwQ3FTOBJJL4GeEugasK4iX2okh5NUYsjqYtNmlz3TOv1EUzLv
         cIsVHcWgOXN0CBZ09CaVN/t3Ga1/uL/6Ug1ojgU4lbOOeOZeAMJbqiFJIQSjr/VuXzDK
         doUz4iawzluknN4Yv4Wsw0k/ayYhQ+RuPJDT52q3IaYDs9GE5OJ0z3bdYBE1MNxW0fhO
         uSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681285662;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=501liZLtrBrP3uOqXrKpjeNE37BdPgtVkc0/sTO4GKQ=;
        b=hWVZL7WYTvVbv1YYz6DKYdNcX8vPK9D+2Q0T5pt+EXVmOOpOsmmpjvWACxu7kjK3sy
         ySDy29hKXWITdO6Y+wY6yknObpyDMRaq2gCOaYXwSNeXOjHFgNlzJewJ7uO90mS8E6ZP
         3EMACYLU7do/1TS5r5/T+nglH0SPOqiaHKkdgo8v9gpOM9mx9MZUa5fyP4nK+sKI7A3R
         xtse/W0eRUHcQuD8JTPOhXFzPTW1bod3ar0bziFVSW3TwXcH6N6yRwxxco85nUkOZVLF
         1xAo4ORJMpv6Y7dlHfufbP0D0x0yM9quC8ocQDDr+LAOR3kvQjSjIXFnQwDk16WuZ/4G
         7oCA==
X-Gm-Message-State: AAQBX9fJ7cs/nW0TmAHh4/QFIID63AnxNCd6ilyBNbySdncxoxMdENBF
        8Kjv7944DfbU3r/dSDtrlezHiTMul0eb9Q==
X-Google-Smtp-Source: AKy350b89aTyR4PHnd+ri7TXR+PrPfN3A5phUgA/oysD61hm/tzgH1gH7BxU21v3NqY4yjBGY1mgDg==
X-Received: by 2002:a17:902:d2d0:b0:1a6:7632:2b1a with SMTP id n16-20020a170902d2d000b001a676322b1amr289649plc.64.1681285662257;
        Wed, 12 Apr 2023 00:47:42 -0700 (PDT)
Received: from localhost ([222.70.26.66])
        by smtp.gmail.com with ESMTPSA id iw5-20020a170903044500b0019a91895cdfsm10958012plb.50.2023.04.12.00.47.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Apr 2023 00:47:41 -0700 (PDT)
From:   JunChao Sun <sunjunchao2870@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, yi.zhang@huawei.com, jack@suse.cz,
        sunjunchao <sunjunchao@yanrongyun.com>,
        JunChao Sun <sunjunchao2870@gmail.com>
Subject: [PATCH] ext4: remove BUG_ON which will be triggered in race scenario
Date:   Wed, 12 Apr 2023 00:47:37 -0700
Message-Id: <20230412074737.5769-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: sunjunchao <sunjunchao@yanrongyun.com>

There is a BUG_ON statement which will be triggered in the
following scenario, let's remove it.

thread0                                         thread1
ext4_write_begin(inode0)
    ->ext4_try_to_write_inline_data()
        written some bits successfully
ext4_write_end(inode0)
    ->ext4_write_inline_data_end()
                                            ext4_write_begin(inode0)
                                                ->ext4_try_to_write_inline_data()
                                                    ->ext4_convert_inline_data_to_extent()
                                                        ->ext4_write_lock_xattr()
                                                            ->ext4_destroy_inline_data_nolock()
                                                                ->ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
                                                        ->ext4_write_unlock_xattr()
        ->ext4_write_lock_xattr()
        ->BUG_ON(!ext4_has_inline_data()) will be triggered

The problematic logic is that ext4_write_end() test ext4_has_inline_data()
without holding xattr_sem, and ext4_write_inline_data_end() test it again using
a BUG_ON() with holding xattr_sem.

Signed-off-by: JunChao Sun <sunjunchao2870@gmail.com>
---
 fs/ext4/inline.c | 6 +++++-
 fs/ext4/inode.c  | 5 ++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 1602d74..b5752975 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -753,7 +753,11 @@ int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
 			goto out;
 		}
 		ext4_write_lock_xattr(inode, &no_expand);
-		BUG_ON(!ext4_has_inline_data(inode));
+		if (!ext4_has_inline_data(inode)) {
+			ext4_write_unlock_xattr(inode, &no_expand);
+			brelse(iloc.bh);
+			return -ENODATA;
+		}
 
 		/*
 		 * ei->i_inline_off may have changed since
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index bf0b7de..7502657 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1317,7 +1317,10 @@ static int ext4_write_end(struct file *file,
 
 	if (ext4_has_inline_data(inode) &&
 	    ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
-		return ext4_write_inline_data_end(inode, pos, len, copied, page);
+		ret = ext4_write_inline_data_end(inode, pos, len, copied, page);
+
+	if (ret != -ENODATA)
+		return ret;
 
 	copied = block_write_end(file, mapping, pos, len, copied, page, fsdata);
 	/*
-- 
1.8.3.1

