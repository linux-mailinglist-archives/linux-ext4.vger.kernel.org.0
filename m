Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A00D76D073
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Aug 2023 16:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjHBOrK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Aug 2023 10:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbjHBOrJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Aug 2023 10:47:09 -0400
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9971BE7
        for <linux-ext4@vger.kernel.org>; Wed,  2 Aug 2023 07:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1690987620;
        bh=8oXbhwTXOk2laXlpJKWBTOgPexjx8+ZPuguvtJIb0Nw=;
        h=From:To:Cc:Subject:Date;
        b=EyxlH0xHxCxttj4e/RUsoUhhVMZ33bKJ8RlfOzB+1oLZbcl52rMiHQxh9VbPm5iVi
         3VS7YbMYWpehbkXRiUoyrDQfqmSIPlPvKfcE7r28XW53vRmJcazfFEzcMmGe7PrUa7
         q+UKB924qut8fknwJaM9KwePN+iN5mlKWluef87A=
Received: from fedora.. ([2409:8a00:2577:9740:9ca5:5f74:38db:4c67])
        by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
        id B7381021; Wed, 02 Aug 2023 22:45:51 +0800
X-QQ-mid: xmsmtpt1690987551tdd5x2o5m
Message-ID: <tencent_8477CBE568348A1862C64E393D587B342008@qq.com>
X-QQ-XMAILINFO: MyirvGjpKb1j1Pd04BE4aUWlLRaB0nfADzCtyeBTnJGyfHDhfOBke5ksMrG1XL
         NoR0lUXqE6+mUWctt6uWldWVVtI/7sF7hbC6t0V+kwKfBE6ymyDu6GTQAnlUtBJZ4NMZgTZgJ21x
         aiT9Z6ACPPk4XBmwbsPmMdtcE5P+wH/jGA4/0/9qgkN3xHrGIuUIBv9jtTWqkWh9NiU5ttxAqaPF
         8X98+SuNexc4k+BfZqFQ2hzDhyyh3WpILXA1uwHo8elLTq+e0dDDnQbqfjRSgk7cH45FtjGrk0Op
         d71+iYEa53pSnxVY8r6gUuEovGylujElaSp9JBWnwz8DUpF+ki7IBk4Sa/2BaD/te56BHkjBRMKr
         gtLslfgqoDVYihOHz/L7JuMM0OYWIqgMfcMDNLOS1NHNU6CkJvP2sutqsOF0atOinvR7KZQOLnJZ
         nmoCbcSRiXulukZplWxk1ahSPXEtTMyqval9sluKUKzSjqBNOhyecFhwWlC4yXNcoRJw9U90YRJm
         7MakQdIg3/VMB+3dLFkjYcvc7JmTnUzrHQ5UMFFKq6+FuZ+RV6R5L+5MyOQRU4cZrdZUe6MoDtqb
         DhjO8kzxR4N29t5VqtABKq7vLqc7VHHEm+9I/6NX6pPVLxym0koVcoJk1F7SQr9rChJ+Oli69+9A
         OCXvhfE0JQjjxKLmY5Q9/Hwo5OZzcJilI23i/7TzR7lXUtQZ5gdRN/CHrswyfJC4GIcJHbngP0tL
         qlSMBu1NKDnoMqIYtu9RmNqxmxgPMByXlyHhIWGJ4en9/sA0OsDm++kLI8gp0aIn2iPOuccgDBkt
         qV8+5k+LD6oYrjAIcfWnCSo2e9r+G5oos6aOSLUZXQQy/6KJ56LvZ3aukLuflxSvzaOQufcOBvKp
         BdzUUCBBWxb/vrZyL/aSdAA007sxtmry3bHYzTGQ8faNBucH3OD6043zGO01v5JRSGlkt0p5RNat
         KVolQhHCJ+lK7lhxu4VWM9MR8Eyp0wffxFUUjCVpFlyk2dHQr2pDyX+V4Yjer/AYzBbZg7JQg=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From:   Wang Jianjian <wangjianjian0@foxmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     wangjianjian0@foxmail.com, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH] jbd2: Remove unused t_handle_lock
Date:   Wed,  2 Aug 2023 22:45:34 +0800
X-OQ-MSGID: <20230802144534.244452-1-wangjianjian0@foxmail.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,
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

Fixes: f7f497cb7024 ("jbd2: kill t_handle_lock transaction spinlock")
Signed-off-by: Wang Jianjian <wangjianjian0@foxmail.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
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

