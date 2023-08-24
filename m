Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258D8787405
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Aug 2023 17:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241552AbjHXPX7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Aug 2023 11:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242162AbjHXPXf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Aug 2023 11:23:35 -0400
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECC019B0
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 08:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1692890608;
        bh=ABm+GFY2ZgJgw5Rhcat52PRSQADuMTWRe6gAm492igU=;
        h=From:To:Cc:Subject:Date;
        b=vHaUwb/yW4O64s+NKUK8XAv1aLsavXPKyeWYcY0fF+SKz6PVtL/+HIPocRTGDabE3
         whjAyCxVCp+0rKlVBYmmNiSS+lA/iAO9jlcoBECc+WqF7H1lLC8GoNJw7E85E8Qgqi
         8+fBTbpiJpSQQ5aNSWD3s+vmsxgvkXXkjqbOdykI=
Received: from fedora.. ([120.244.20.128])
        by newxmesmtplogicsvrszc2-1.qq.com (NewEsmtp) with SMTP
        id 5DA9F2FB; Thu, 24 Aug 2023 23:23:26 +0800
X-QQ-mid: xmsmtpt1692890606t12iks7uk
Message-ID: <tencent_F992989953734FD5DE3F88ECB2191A856206@qq.com>
X-QQ-XMAILINFO: NiAdzfE16ND4XagQJttc9fD6QkcH7G44JptLm2CN5jSKxbYakq1aMDUngBsFBY
         4O1aQhzdhOsKqU8iw3OYRbzlNOXwwbPw7zFufcAneMkT6sl2dz8qsQmVtm4CKQP8LHr8hadeeqXt
         C44Iyq5hQtQWdVm2gbReXpMnlSaB7JyuGHo1fcICiZHp3TtoRzwSpWcD5DlKyAo55gyvm8IinEsn
         ItXQyxuefffqtokFfhpMxVf/wBrO6J31lRmxmvJkfB7A33zcUq1St0n5mZdg5yAgR7qqWaq0qWWh
         dfO2I0bOPsjdOMOsYn8rZDVmBVnRFji4OHQsb7e5RmWLwpIqMThxuCsh+1jy9BlrkCbpLQ2FfNJw
         7BmpbosYuxV/ogNfYWHSgrPKRw74Q3xwTiKilGaG75aGAY+hKGKTkwJuIJL2V4U6DnWuRiK/f/Ta
         ysUAyaLifb2ZMMRZ7FU6895HdKnx+xrREHomoozRKv3yauCj4HbbyYHYqQGRqdJ0272LmT+jlc6F
         lKAI0fLIMfnPwXeDEDohfhGycH+Y/urDOe9IugT5pKHunearaZ9Zw9BuMYrmhuxjFv0Eyx7FJW2g
         voyNayEag5+hsMaFXWBunjOCXzXtMQ81t4EIBmjxQKOsfePb9JrzBLeHY/cRQ0AWx8iGB4h4tOzP
         FV4VrTmrjgehaMihsu7B2wgJ7jXoQo9jLgdK2JLk/T8uW6wLktId/s5ft8G/Q8ukK1eLojCvw100
         8jywKQdUHKA0mqf5oqRuyCf2tIxgOykEes3RPiTyjJUfhrvrnJBPQ/9PYGYrCPVMq5CBK7MRF/+a
         n4JYA0Uovz9XndDzlsqg8NInkixmCFeTnSdlujwU4e3SAvI8ml9M/mG5dl4tDFjZNzlO8srPQf74
         7UhYD/ojoL8tLr8lz4NHd9i2MHdR5WmMP4IQpITU5eePYH97XlEn+/2Fe18/0ZDloHW+UUTBlEUW
         N+NhzGjzXNytSeg8ykp04cFdoxsTEMDOjNlegN5ag+fDbwAJFpKQ32C9DIvXUf
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From:   Wang Jianjian <wangjianjian0@foxmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Wang Jianjian <wangjianjian0@foxmail.com>
Subject: [PATCH] ext4: Fix incorrect offset
Date:   Thu, 24 Aug 2023 23:23:24 +0800
X-OQ-MSGID: <20230824152324.17840-1-wangjianjian0@foxmail.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The last argumen of ext4_check_dir_entry is dentry offset
int the file.

Signed-off-by: Wang Jianjian <wangjianjian0@foxmail.com>
---
 fs/ext4/namei.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 94608b7df7e8..33ebd35025bf 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2261,8 +2261,7 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
 	top = data2 + len;
 	while ((char *)(de2 = ext4_next_entry(de, blocksize)) < top) {
 		if (ext4_check_dir_entry(dir, NULL, de, bh2, data2, len,
-					 (data2 + (blocksize - csum_size) -
-					  (char *) de))) {
+					(char *)de - data2)) {
 			brelse(bh2);
 			brelse(bh);
 			return -EFSCORRUPTED;
-- 
2.34.3

