Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69D7E1A1F08
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgDHKqi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:46:38 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38942 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbgDHKqh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:46:37 -0400
Received: by mail-pj1-f65.google.com with SMTP id z3so997181pjr.4
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5K19j3YqbknZ5V2CBpORy72AU7J3ZCigowjjlSslcyc=;
        b=Y0qr02YK8kEmMngukYuCn8cFGTtb9YXjEPlDDbq7ZeRljIu6wHeWLBanbmkZ/e0QVK
         hFvXk3aKxcihWJUGjWky3vCnXG2PVRzsD8SEj2/tqyeYhn5aLk2YwWroLL2df+QC/c4V
         Rx0lmAP/P+INpOzmIxpAxns5/LgJUzTecswcp3BOsbt5PesHN/3j+esT3S8HxkxLq4lZ
         p4diTSX2a7P7+FDyxEnSWoQVEX4WzCxb4MRJWkIw0uD/p8N61ms7I3WpLvgFdQ5eCGqI
         mv6oJsYDPiJN0bBga3N9+VvikwOxO+zH6m0zLM8Nh/aQp/wp+z2GFFvdvNPLk7JCAA4D
         fY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5K19j3YqbknZ5V2CBpORy72AU7J3ZCigowjjlSslcyc=;
        b=JEfFI+Z02mwJd462efG3rdpOWqKO3fR3bvlKlyEdR3jMtoymKtPCGBfs6k79BHXI1w
         lFKLBKqkV1Cpxsv8GvbENCpjWdd7QfQOwdS2CBuUBPcXQlFJiBCI02jUnfun8bjziHbK
         B0h/0wlWfCwi6IO2c7kB0fK38KEGWdmYMzH+fGMg7imEnQRSq3Qupq99+tbsdyvOZfO/
         F9mr24grtkX4Y/Ot9Evx+n3Mid4fuFFneZjI4oNrKOUlm0OjtUk1VN8XNC82XHR+krpO
         se9g9/1FE3zPe7l3V5wqopT1OWOBBlPa43TWprT03/xgYWW2TLyRAqxe7aLhLgNlFx8p
         h3Rw==
X-Gm-Message-State: AGi0PuYC0QF3689PzV/9w81x7W5C3n/fzILd6q1ht6XUraCy+FpbAk30
        3NpwQVPREmoGiuU6rVTlpZWifsWlz/w=
X-Google-Smtp-Source: APiQypJfgVxTUZLCzI40DtjtgPhn2wmhYeqjY4C0Kqk5CTOu9Lnl0b12jWHgUcRFeor76gV6iuWp7Q==
X-Received: by 2002:a17:90a:77cb:: with SMTP id e11mr4831677pjs.0.1586342796988;
        Wed, 08 Apr 2020 03:46:36 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.46.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:46:36 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 30/46] e2fsck: merge context flags properly
Date:   Wed,  8 Apr 2020 19:44:58 +0900
Message-Id: <1586342714-12536-31-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

e2fsck might restart after pass1, so we should keep
flags if possible, this patch try to fix  f_illitable_flexbg failure

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/pass1.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 52598838..eb102679 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2622,9 +2622,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_fragmented_dir);
 	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, large_files);
 
-	/* Keep the global singal flags*/
-	global_ctx->flags |= (flags & E2F_FLAG_SIGNAL_MASK) |
-			     (global_ctx->flags & E2F_FLAG_SIGNAL_MASK);
+	global_ctx->flags |= flags;
 
 	retval = e2fsck_pass1_merge_fs(global_fs, thread_fs);
 	if (retval) {
-- 
2.25.2

