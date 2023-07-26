Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBDD763AE6
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Jul 2023 17:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjGZPX0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Jul 2023 11:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234527AbjGZPXY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Jul 2023 11:23:24 -0400
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAC911B
        for <linux-ext4@vger.kernel.org>; Wed, 26 Jul 2023 08:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1690384998;
        bh=lIZx++5LVxLXHxynqzB4zpRx348SqI7uTsGTcy1yaO8=;
        h=From:To:Cc:Subject:Date;
        b=HnTkWriABuhiTIGqDG8h49B/ivPhEgSScY6TFc+oy8rJ0nQvMyc7UoF2nGIprrorc
         Yq/z1oFBsBYFPVGdRzH9CDhHmBWWkQQ5n+ajcV+P/B48dkOaGzravRc4XHjCzc8kJS
         MwTiBrqmjneC3JgeU3tFArxIURhKKGOxGx0UufqY=
Received: from fedora.. ([2409:8a00:257d:1060:8e4e:4276:b7e5:8a0e])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id 5D081CC3; Wed, 26 Jul 2023 23:23:16 +0800
X-QQ-mid: xmsmtpt1690384996t2hk7hfkd
Message-ID: <tencent_DBB7534F4FC71E2788D13206DA966281D806@qq.com>
X-QQ-XMAILINFO: MQjKimNqHmeyTrjDJkFphoad13zxlWTQK/cnqYjIRhzH5S1klrUEUOiOLunHjd
         qvdnGknjzWUYtJbbdWE/lIgrC5H1OYeO8JTA4oc+d/AH/rEO71mP83GNufmCchWXfwFcZlOcfEml
         Q5rGvhBe29efqSGvAXDwagsPX8hmUd8ikxMevidt+cqfP2dsLbze50wLzodMAWiCNkffVlliFaac
         iBZO/cD4n8YReAQLLAVFLd+5Sk1N+jEZl/3hTdlT4aCJ8xmgTDFInsX8bvIgtTeRnnpW4RiktAaE
         SlS42nxiQfFrgBcLsMxNg6mjDW2YibJTRjXvW+O6TS8IiEuGFwp3BLjs96TMzfxGF8iPku+eBVRj
         urD64P2B7Mctovj+vQlM8DfqcjPmkarmaIHigFbOo7Oce/fT0vizW+KeVqV+n8pFci+eMoZYPOCU
         6Umg/GDj6Zerbr7l+/RFGz7RVxT200L40yc8yjkDvffTz9tFGDyy8FYAlmsuOdSNEBNUeRNEHEPy
         oognGPq5j7cVtK62EV09Xcm5poyaJ8QXwCcgToLuHM3iYS19D7rhSqPKAr+320S7+Ngk0dzTO+GO
         2m8pw5IulX4h9y9Hp4rENS6eLw68EkKE74t6svoD0BmWCaBnWhi0hlQ3PaVaghIGByCMFf07p/Ka
         HJndspSADgUKojCpKPdRplenYpqwMMUMy1Iw6XnlNnHdlInIcxg5RskE26Nbg8DG83vGiEJrjoPT
         fTIoOUqOGw7A78NOLe4EEOR5K44gCcBuojOcDbstw6J4t6yWbDNqboq/58QXA+Ig5RXw3B84rgzk
         3/08qU1jNiu7WkOASABRODiSzIAIIHGLyKcLWNWrSghYMVx7qIvjtBpBja4R9ijTFQPN+ZUJlvgM
         3MmZVoiu//mteeO0Lcc3BzH5bB4LkJPBQym5xTk9mSdG4EjLsMmtGTpUS8pJZV8G1iz0dawsjXvz
         Rq4anfQzs4Nd6IMbjxdO1Uy1T6wTBfl22ARquA9E0p7me9y5I2jMzhJtzzb3luyf1HiiD3c7No6N
         omoe2u192Yk0yVffB4
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From:   Wang Jianjian <wangjianjian0@foxmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     wangjianjian0@foxmail.com
Subject: [PATCH] jbd2: Remove unused t_handle_lock
Date:   Wed, 26 Jul 2023 23:23:15 +0800
X-OQ-MSGID: <20230726152315.154262-1-wangjianjian0@foxmail.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Since commit f7f497cb7024 ("jbd2: kill t_handle_lock
transaction spinlock"), this lock has been no use.

Signed-off-by: Wang Jianjian <wangjianjian0@foxmail.com>
---
 include/linux/jbd2.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index d860499e15e4..8199235dbaf3 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -636,11 +636,6 @@ struct transaction_s
 	 */
 	struct list_head	t_inode_list;
 
-	/*
-	 * Protects info related to handles
-	 */
-	spinlock_t		t_handle_lock;
-
 	/*
 	 * Longest time some handle had to wait for running transaction
 	 */
-- 
2.34.3

