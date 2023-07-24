Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FF075FA4D
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jul 2023 17:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjGXPBD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Jul 2023 11:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjGXPBC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Jul 2023 11:01:02 -0400
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0874E56
        for <linux-ext4@vger.kernel.org>; Mon, 24 Jul 2023 08:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1690210856;
        bh=TIUSbSTVTSqMfUwntP9fp42C7TFU50djMwl0U2BqCvA=;
        h=From:To:Cc:Subject:Date;
        b=fMZi9lt+py9yxqZUAv7HcsTaBusyWgG6Ea3PygjJK97lkAgmAiN2ykyi8mphPR/4S
         0uVel9YY1QcojH7ib4DarN6nrc+dV/ouYV9LmtKAeU9sTgTMwm43i+/Bwae6NksHfV
         011xr+RaJVjCaYKKwthBWM7ryiRWfHrR9mnpD6Jg=
Received: from fedora.. ([2409:8a00:257d:1060:8e4e:4276:b7e5:8a0e])
        by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
        id 3708A82; Mon, 24 Jul 2023 23:00:55 +0800
X-QQ-mid: xmsmtpt1690210855tgrkvi83e
Message-ID: <tencent_CB3115278E9ED6BD081097E5753433452107@qq.com>
X-QQ-XMAILINFO: MmpliBmRb3iCy42EVV+6PfDJ68H1fM+qGvvhTCtTHGKSC6DwBA6LFlaUk120Pf
         fVdT60DOO+tkSxWpAeAxSSEPZQstxUMD1ZWMx7tIWF69Si9N+ohtl5/Wmbv+OyWJ/TYMoaJ1mCla
         oNzHmyi8BwmqyEIlqRoi5y+Mjnsf55VVyY5RC9RekA9P9aHTzzT3NFJ1bog9L77uuNyVj7Z52RlJ
         oKPo2xnZxlhusdSch8Gf10xXwC0H6xxafrHeeTJoxtjgNtkYfoDb2JKAi6FYFHIrFjW5klJpl6M7
         JA3m5lk8YcB/ah3bbiGmgSp9eIfdrSiBCv610p5JrGpsagXo0FLeq/J69qG9dHAe596IWKeBcxZb
         chKMj50xwAQoMmZ0Xe8bjWwaKOi2hbmOvCn3R7NE0UfLnVAy/YOLuA+X+eYW5SrzwgP2lOYFM5PR
         rGubsiIx75Tw1gujFua1d4v3GeWJ+UqyURv00GMGXv96dBFFep48xHUfwtxwc0R5he+o7E+F2u7P
         AHtxGhO5+FZlEh+N8emnwXyBfULdm0e2RON2aAROIsPYJsK4MqI7SstXtM0HMai0PwF9UWQu11gP
         DYqRTUaPf7XYQ8CCwUSO7YW/0RuSmQz2juGuYh/MwjiGpV2mLNx9u9GQqW7MWi0z2b82t8PgRjnq
         4KcEz6I68xFKFhQ8p0MLyiaWsmzTn3zhClxBMQlP30e7wfn3en5KxgZi63OjSGPGYVI0aeS8cowb
         uY0LBie4yAzBrlk354vtkwwUJmHsWJL7tTUcuWHX8HSy5jmPD2vixXXdhiXwkdd1VRjHehibmBsq
         gOxK6kWo5+SnW27JRXyTMwnV8jI1dwaR6De/8on9R0CNvr1jZ50PFDMve03OSChrtfkR+KkGTEEX
         iBsLU9b0yiOp2H4r0f3qiI0CZCiw0pg51rZTbh+EtmqZQRqDvFIrrggmhijGAd2nOcOQe6hLOlRU
         C9BMrzo8U/L3/CIT3Uqu9hHhiAs70qz/2ZJwOtnCV9qsUBqmM5iw==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From:   Wang Jianjian <wangjianjian0@foxmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     wangjianjian0@foxmail.com
Subject: [PATCH] jbd2: Remove unused t_handle_lock
Date:   Mon, 24 Jul 2023 22:58:21 +0800
X-OQ-MSGID: <20230724145821.152396-1-wangjianjian0@foxmail.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Since commit 4f98186848('jbd2: refactor wait logic for transaction
updates into a common function'), this lock has been no use.
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

