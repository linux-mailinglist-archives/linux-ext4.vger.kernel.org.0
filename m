Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886B52FF8CF
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jan 2021 00:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbhAUX0v (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Jan 2021 18:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbhAUXFp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Jan 2021 18:05:45 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DAFC0612F2
        for <linux-ext4@vger.kernel.org>; Thu, 21 Jan 2021 15:03:47 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id i2so1974623plt.14
        for <linux-ext4@vger.kernel.org>; Thu, 21 Jan 2021 15:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=73jUIQHuj0265QRP8P3oVVOaSevfoFr6R3Pxp4Z8uk0=;
        b=RpM4qKLA+63xTwFiz255mspkEHNICv4dlhm7EHfnRU0UFN2Ihke5P4zOrKCiazdR7d
         bXOol4JvqiZOdRVsLQZnm4+9mSTLVh42aPGA5Y4Y5IB+y5B3KInSnmfMLfUe5WfbPlV5
         VxFwpZ2Vqn0u1sbV9D8cI0VjEg3QNpJhpPWDPwb+anXbPJOiIr/ySdiPWgUfOjgjdgkA
         IdEjApFDSNmguJFxEjGJY6eDJTmCCZhgIUZiGfP7Ni5urYiytgymML2bkgTyZ9IBfFd0
         PUCS2z8FThCRQC0kEqTRjWh5yf4h+dirIoOYGRoPF8cFverIpktw4+4nKzBCaAqBcI22
         stXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=73jUIQHuj0265QRP8P3oVVOaSevfoFr6R3Pxp4Z8uk0=;
        b=TOkp6KPAJbvMHZVMJ6A9FD0Bc87WiML4HYf8FW0DajBcmvz/s91YF4FZgFTgzJ0kMw
         31cmzOPVeQ6ap1ToJ/BjnVUvkngDoheOFaJ0hkAM90TiZ1pwvtSgfk8oOEilj03DnrxD
         yfBz7axQzHGHHd5LmjDdff9evkGi1tP2PKEvb1i/6isNockoyc9THtfJ8gtYy+ZumAgC
         hxpVv8e8vFhDzOlhO4QcOUfDwkqtn4XRZ94lzt8g8PCbW6tFOgbQ3xzDbDITquZz/6je
         ehEzPB/d5/Pu+wRVcZQVrlVT/1egTBmdgdOXc2ZiwzPPLlY1VxCm0kbBQfd9zgzDebbR
         eIgw==
X-Gm-Message-State: AOAM532X96MKuX291Lw05cQfaQbQfqxKZ52jduutg3KO3FG0024LDp7A
        /tw/h3vbxTOnF0VsbOu6YdCMPl7wkyE=
X-Google-Smtp-Source: ABdhPJwJkQ2FWOp1yUHZk7nzCbAeBUq10CoEvBoJQOw9xo3NYsJVQXsuE+AArFPbdsM6X5/w9fvQdGdj3Ek=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a17:90b:370d:: with SMTP id
 mg13mr1905409pjb.161.1611270227094; Thu, 21 Jan 2021 15:03:47 -0800 (PST)
Date:   Thu, 21 Jan 2021 23:03:32 +0000
In-Reply-To: <20210121230336.1373726-1-satyat@google.com>
Message-Id: <20210121230336.1373726-5-satyat@google.com>
Mime-Version: 1.0
References: <20210121230336.1373726-1-satyat@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH v8 4/8] direct-io: add support for fscrypt using blk-crypto
From:   Satya Tangirala <satyat@google.com>
To:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chao Yu <chao@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Set bio crypt contexts on bios by calling into fscrypt when required,
and explicitly check for DUN continuity when adding pages to the bio.
(While DUN continuity is usually implied by logical block contiguity,
this is not the case when using certain fscrypt IV generation methods
like IV_INO_LBLK_32).

Signed-off-by: Eric Biggers <ebiggers@google.com>
Co-developed-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/direct-io.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index d53fa92a1ab6..f6672c4030e3 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/fs.h>
+#include <linux/fscrypt.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/highmem.h>
@@ -392,6 +393,7 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
 	      sector_t first_sector, int nr_vecs)
 {
 	struct bio *bio;
+	struct inode *inode = dio->inode;
 
 	/*
 	 * bio_alloc() is guaranteed to return a bio when allowed to sleep and
@@ -399,6 +401,9 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
 	 */
 	bio = bio_alloc(GFP_KERNEL, nr_vecs);
 
+	fscrypt_set_bio_crypt_ctx(bio, inode,
+				  sdio->cur_page_fs_offset >> inode->i_blkbits,
+				  GFP_KERNEL);
 	bio_set_dev(bio, bdev);
 	bio->bi_iter.bi_sector = first_sector;
 	bio_set_op_attrs(bio, dio->op, dio->op_flags);
@@ -763,9 +768,17 @@ static inline int dio_send_cur_page(struct dio *dio, struct dio_submit *sdio,
 		 * current logical offset in the file does not equal what would
 		 * be the next logical offset in the bio, submit the bio we
 		 * have.
+		 *
+		 * When fscrypt inline encryption is used, data unit number
+		 * (DUN) contiguity is also required.  Normally that's implied
+		 * by logical contiguity.  However, certain IV generation
+		 * methods (e.g. IV_INO_LBLK_32) don't guarantee it.  So, we
+		 * must explicitly check fscrypt_mergeable_bio() too.
 		 */
 		if (sdio->final_block_in_bio != sdio->cur_page_block ||
-		    cur_offset != bio_next_offset)
+		    cur_offset != bio_next_offset ||
+		    !fscrypt_mergeable_bio(sdio->bio, dio->inode,
+					   cur_offset >> dio->inode->i_blkbits))
 			dio_bio_submit(dio, sdio);
 	}
 
-- 
2.30.0.280.ga3ce27912f-goog

