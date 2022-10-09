Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBF65F8921
	for <lists+linux-ext4@lfdr.de>; Sun,  9 Oct 2022 05:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiJIDZt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 8 Oct 2022 23:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiJIDZm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 8 Oct 2022 23:25:42 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC715286DA;
        Sat,  8 Oct 2022 20:25:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VRgUfzb_1665285934;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VRgUfzb_1665285934)
          by smtp.aliyun-inc.com;
          Sun, 09 Oct 2022 11:25:37 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] ext4: remove deprecated_msg
Date:   Sun,  9 Oct 2022 11:25:20 +0800
Message-Id: <20221009032520.108294-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

fs/ext4/super.c:1744:19: warning: ‘deprecated_msg’ defined but not used.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2346
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/ext4/super.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 989365b878a6..7950904fbf04 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1741,10 +1741,6 @@ static const struct fs_parameter_spec ext4_param_specs[] = {
 
 #define DEFAULT_JOURNAL_IOPRIO (IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, 3))
 
-static const char deprecated_msg[] =
-	"Mount option \"%s\" will be removed by %s\n"
-	"Contact linux-ext4@vger.kernel.org if you think we should keep it.\n";
-
 #define MOPT_SET	0x0001
 #define MOPT_CLEAR	0x0002
 #define MOPT_NOSUPPORT	0x0004
-- 
2.20.1.7.g153144c

