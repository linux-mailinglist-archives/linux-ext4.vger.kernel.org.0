Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B2663207C
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Nov 2022 12:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiKUL0f (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Nov 2022 06:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiKUL0J (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Nov 2022 06:26:09 -0500
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE647A7C09
        for <linux-ext4@vger.kernel.org>; Mon, 21 Nov 2022 03:21:39 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id v18-20020a056402349200b004622e273bbbso6610661edc.14
        for <linux-ext4@vger.kernel.org>; Mon, 21 Nov 2022 03:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ut094+1HiZ4Cjb1djYz8ZPvCLMxdVr+mJo3AtkrOKCA=;
        b=PtZTUVznvnflFwUv9SKypxZQqr7i1LRYenCMrhMEOVGiPfxccwpjsY0A4YtFeeVnlF
         h2lGU/CX2UGfxpSXxpMO1krIzX7InkrGi25tw16FUZGnYRG+48rz3JaSCOEXLpqgE/EM
         opVGk0Q/rJdXGr0oIG5tziMO7oWC8RwHnTFpjZTCghBdovVeuHaJ0UfGVV+HSRF+Mevy
         v/vENEx2/1GIDj3F6RVT8uC+lujEgt6uMMFBYmaBcrnbZqaZYAVFDM7x70bVO4+mtAA4
         t18AcVUc3fi2I1HwUNs+HNibRi0u8zeQUEKGIUhxxWoUi8pcajXw5PvuDm5HDd/vf0M6
         Dc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ut094+1HiZ4Cjb1djYz8ZPvCLMxdVr+mJo3AtkrOKCA=;
        b=Z3RuMSohrjgwIgrBpslu7Hz9ac3QGVlIiJfy4SWD821QQh+gFdrE6T8DQY6bZW2MzM
         pLCWUo2rJ9/JWWrTYbnwshZ3xSHJSCQwwhfD14a7ljO7WfvUjBS1iuX8DIMt5Ig6t5Dh
         Y5i4oTq60HoQxa3aB7D2CAoAG3KGLqSAQcPwOL6juwS+FONdbdHSQsxznUK7AFWcmKbj
         Mh7Yn7WZ3dtJkYQeMuocJDBIGglHcpsEasrCQgWRBZsy8qxtXxqUYePz3KUIPq4+iAWr
         qz4c1mpJ8vCHwDdT97n5d7QwNcz+lxsBJt0E0M5HGbbuM0QhRpozl7T3zzHJs7hYBME/
         GGHQ==
X-Gm-Message-State: ANoB5pmPzdFtokn23VjP3D5tnQBRV3pU0ke+FNwco5aj+2+OCBiCc5lr
        /mpdhoejp/jcsVh+bvZVojSbHZD1d6c=
X-Google-Smtp-Source: AA0mqf6ymM+aPMyFpxcfMJZ6dxw5jBiyJyJ7BqqZjljlNhaC6hbGZmGDYm3fYA/es+nh2vPHSPoyWsXw6P0=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:db68:962:2bf6:6c7])
 (user=glider job=sendgmr) by 2002:aa7:c788:0:b0:458:b9f9:9fba with SMTP id
 n8-20020aa7c788000000b00458b9f99fbamr16132478eds.305.1669029698340; Mon, 21
 Nov 2022 03:21:38 -0800 (PST)
Date:   Mon, 21 Nov 2022 12:21:30 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221121112134.407362-1-glider@google.com>
Subject: [PATCH 1/5] fs: ext4: initialize fsdata in pagecache_write()
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        syzbot+9767be679ef5016b6082@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When aops->write_begin() does not initialize fsdata, KMSAN reports
an error passing the latter to aops->write_end().

Fix this by unconditionally initializing fsdata.

Cc: Eric Biggers <ebiggers@kernel.org>
Fixes: c93d8f885809 ("ext4: add basic fs-verity support")
Reported-by: syzbot+9767be679ef5016b6082@syzkaller.appspotmail.com
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 fs/ext4/verity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index 3c640bd7ecaeb..30e3b65798b50 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -79,7 +79,7 @@ static int pagecache_write(struct inode *inode, const void *buf, size_t count,
 		size_t n = min_t(size_t, count,
 				 PAGE_SIZE - offset_in_page(pos));
 		struct page *page;
-		void *fsdata;
+		void *fsdata = NULL;
 		int res;
 
 		res = aops->write_begin(NULL, mapping, pos, n, &page, &fsdata);
-- 
2.38.1.584.g0f3c55d4c2-goog

