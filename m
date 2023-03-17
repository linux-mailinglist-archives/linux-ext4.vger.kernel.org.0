Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1856BEB70
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Mar 2023 15:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjCQOfF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Mar 2023 10:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjCQOez (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Mar 2023 10:34:55 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6E010DE68;
        Fri, 17 Mar 2023 07:34:23 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m35so3469528wms.4;
        Fri, 17 Mar 2023 07:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679063662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9wEPVpsDJ+eVU2ayy3OZi1jrduVw8/8ymYn0qSuZays=;
        b=K5la/SfjO65BOgwF/u6LgTQ1f+i1hHrenfb2zoVMnAD9rkyccRrIcO13xjYw3RAyTh
         ED5gwoCFQB8OJamAZgxdGMtZ23ZrS3HZmr1h2s1sVqm8k6kTgAqIO7SbdTmK+wD1asyS
         SsFtt78B9d2KSPeWYbAZFXPOiaxgm8Lq3+S1tFZ+ADXGsqhMS8NM0Y0T4OOgUixacaMv
         COHVor7lQk5bVY22QgHHBkK5HCxJg60dPBfoyK2eYnB8XuXC7K3U+WCcCPPvpgRwkBgO
         3QHI1haZBjgyurPw6uOvzvveKtF/wm8eOgIdvPA+aNHGZDhMCDq0NgGts+4XG3Dle5M1
         ipgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679063662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9wEPVpsDJ+eVU2ayy3OZi1jrduVw8/8ymYn0qSuZays=;
        b=3GG5+yRx4D7YZHFZov0PSHSOo7u/qimeqTQ/p6q+cicQVYwzTtDTf9Fkecf/clS9HM
         b1zc7dC17K52AyJKERsv6VpxenJlgREvXcrBdRUoLwSTF78yzb779P3BHfkLvKb2D+l0
         1lRVAycNFSd14kD+DlU+61DPyDJBe1t0XIyeZuUo3duzYUAz2pmKXs19n+hQGkyJqYL3
         gJYmcjIew+9MCpnKWRMfsZH9f+Vhps0h4s4rdCheYeoAhrtQU81dgYocJDMSpmNLTMWe
         tHs6L/SMhMBgOKoyMTTC5CrAxUHe+4M+3bjoM+0RxJ9WtVSgGCPcrQr9KPlKH40xjact
         fJ2g==
X-Gm-Message-State: AO0yUKWGBEpDBHhOcyvWDsSUZxvOLCWWVh5c9N/+Pj+6J3q47Hc+On2S
        TzJPsZgxkT6oRmER35haDSo=
X-Google-Smtp-Source: AK7set8uQgZPt/dhZCj1n8QuiVwT5KrkwFw/aLgz/2WouLqjBvXYqprdgPtufTzgm3LABScKFazbCA==
X-Received: by 2002:a7b:cb98:0:b0:3ed:8360:e54 with SMTP id m24-20020a7bcb98000000b003ed83600e54mr2176440wmi.8.1679063662197;
        Fri, 17 Mar 2023 07:34:22 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id c16-20020adffb50000000b002c56179d39esm2106715wrs.44.2023.03.17.07.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 07:34:21 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ext2: remove redundant assignment to pointer end
Date:   Fri, 17 Mar 2023 14:34:20 +0000
Message-Id: <20230317143420.419005-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Pointer is assigned a value that is never read, the assignment is
redundant and can be removed.

Cleans up clang-scan warning:
fs/ext2/xattr.c:555:3: warning: Value stored to 'end' is never read [deadcode.DeadStores]
                end = (char *)header + sb->s_blocksize;

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/ext2/xattr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index b126af5f8b15..8906ba479aaf 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -552,7 +552,6 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
 		error = -ENOMEM;
 		if (header == NULL)
 			goto cleanup;
-		end = (char *)header + sb->s_blocksize;
 		header->h_magic = cpu_to_le32(EXT2_XATTR_MAGIC);
 		header->h_blocks = header->h_refcount = cpu_to_le32(1);
 		last = here = ENTRY(header+1);
-- 
2.30.2

