Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33656552AE5
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jun 2022 08:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345837AbiFUGQC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Jun 2022 02:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345836AbiFUGQA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Jun 2022 02:16:00 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF581BE97;
        Mon, 20 Jun 2022 23:15:54 -0700 (PDT)
X-QQ-mid: bizesmtp78t1655792144tyyn46h7
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 14:15:34 +0800 (CST)
X-QQ-SSF: 01000000007000109000000A0000000
X-QQ-FEAT: HDjpALELSmFgfGq9nHorWpfBP8NQbowQ/hSGqJYLCImI++jRbEtpupGxSmLSQ
        HbCKGZYq7yE63+bmLNVbe7yzWIv7tubvIsn9ThRaEiW65dpfmRO3YebYV++QvvXNzcFH8dR
        CXcoLxBY3Jxqn4qOtK3a1DONvAnujQIPrac4Aqiun3vY/5zyd1g9BPVbl0q0IFrqN/sabLn
        IRONJsYWTGF1VZwfEPTOb9wrV89nWH+ytfVXzQT3k6p1PsgYbJjkqMTsqdAV7wOGI2V2uoz
        KysJ6pP0ogkUOxgxqeaF++llbtnBBMPLSxZ26jwUQSXUyfRFph3q8CRfM=
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiangjian@cdjrlc.com
Subject: [PATCH] ext4: aligned '*' in comments
Date:   Tue, 21 Jun 2022 14:15:31 +0800
Message-Id: <20220621061531.19669-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The '*' in the comment is not aligned.

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 fs/ext4/xattr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
index 77efb9a627ad..c1edfbc13efb 100644
--- a/fs/ext4/xattr.h
+++ b/fs/ext4/xattr.h
@@ -84,7 +84,7 @@ struct ext4_xattr_entry {
 /*
  * The minimum size of EA value when you start storing it in an external inode
  * size of block - size of header - size of 1 entry - 4 null bytes
-*/
+ */
 #define EXT4_XATTR_MIN_LARGE_EA_SIZE(b)					\
 	((b) - EXT4_XATTR_LEN(3) - sizeof(struct ext4_xattr_header) - 4)
 
-- 
2.17.1

