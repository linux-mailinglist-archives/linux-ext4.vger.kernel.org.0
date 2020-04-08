Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD0AD1A1F14
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgDHKrC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:47:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43637 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgDHKrB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:47:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id s4so3136216pgk.10
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uAq99OOvuKKwevmXOhPesNPdE1EHSYa4GsrsBMnryfo=;
        b=E/2RP02eXAY0BY4HFoMq1K0ND8DeN8xjcMx1Hpj4cs8WdtD42nZoxaHJhmHGgmarjM
         4LbfHcBu1o+8tvo9G2KGJoxZhLe7YcQMImGwBWMGWOeWtyfuH/fv2hc9Cg9t7V4aKcja
         8y8FNvQGlygvQinrrgkNhhR8EsmkVq8s6izOXdnwd+WqotGLQribsJEZxrmHr96ez5IN
         mNSaA4N0GEwUbsajf9NQ7TgEsOlHkr4ZHVN4unfjXJYA7tzIttgxlN6G2THwI5v39aHq
         36qEzFurVqSjiT0Q+ihHaXuLdo+V8zSDvrqEnKxWR/Xnx1hU0IAFaH8EESKd0R76ERR/
         wnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uAq99OOvuKKwevmXOhPesNPdE1EHSYa4GsrsBMnryfo=;
        b=Dt7T/+XgetC3ZxOZqJpmLPtdxk6DbCorKfC7mYY+CSA96Qf2EBDwFI4thy3mhfeGc3
         WGR2ZRf54KalWJw/+cJjlyzTFScpQ+9nDPw2C8yUga5tyS6ZHRx6sGn0btI3iRrMRBoE
         gnkH1kGEbCmZa/ghG603aH26++tTSvCanjDSOfjLtg2qNVyG6m6oMsEbtRumUfOPgON2
         Q9quhoSMXL9WwaWvQu1+f9HvjYru+l/NunsQvREvNAi928egv31WfEGXaqW9jomK/hxe
         zdQhv9AqLBfebOOkHn8YvlePdCGkx0qYZUULMA1pFf7oqWiU/oLN/fsOE5AljSpVrxXk
         Ab5w==
X-Gm-Message-State: AGi0PuZQnozOXC/LPijkdWiey4Wg7SB24hnDx4X29lHIaI/1IEOlwsBz
        BxUCblsMT6szVX3EME474SSx0wYjPfo=
X-Google-Smtp-Source: APiQypJZtl54kstqSt/VkTh6gcTTc5jOgs44khldE5avSjuXhELRQ8m+7e4rojuIhC8WK9N3e+hu2w==
X-Received: by 2002:a62:1dd3:: with SMTP id d202mr7140239pfd.47.1586342820757;
        Wed, 08 Apr 2020 03:47:00 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.46.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:47:00 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 41/46] e2fsck: merge inode_bad_map after threads finish
Date:   Wed,  8 Apr 2020 19:45:09 +0900
Message-Id: <1586342714-12536-42-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Change-Id: I19138835c8532eab8f91b711ba25300b33329902
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/pass1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 4173d920..d7d37d8b 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -3141,6 +3141,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	 * so please do NOT leave any garbage behind after returning.
 	 */
 	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, inode_used_map);
+	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, inode_bad_map);
 	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, inode_dir_map);
 	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, inode_bb_map);
 	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, inode_imagic_map);
-- 
2.25.2

