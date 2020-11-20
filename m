Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B490E2BB505
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Nov 2020 20:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbgKTTQa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Nov 2020 14:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729444AbgKTTQa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Nov 2020 14:16:30 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0360CC0613CF
        for <linux-ext4@vger.kernel.org>; Fri, 20 Nov 2020 11:16:30 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id t8so8777894pfg.8
        for <linux-ext4@vger.kernel.org>; Fri, 20 Nov 2020 11:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7sMkFu3WbDnH80Glnn82gYd+1da6NUT/aw21v/s39Mc=;
        b=cVNW2fRH9HCrImPkadX9huYk8LpaLTVzTe/UzGNK2PHCs84/NizEp0cUhQEtsojI5J
         iv1Ey5YBc8XTx5VxOco8oGtYQO1GWXtg5RCoQF4AG1tdQOjxRQsL6FgRSZZop0H2ixos
         EB9jACqW1bN5sqeIL9hEd4GDJpb42LHpLO65dQ++AA/CGn3YwoB3z7hsecEQylsp677v
         3s9Qnprm+gqAeERDpAQ39NGBcB9F3Q0sE93d0JI+SSTcuLvU7pDHdTLqiLpoWw4/ypPL
         Ot+fbXSoZ+qbQ7EK0jJqH6j2DB+JmyqzyrGSMocWm+khhiihkNZsGNF4wmGz537u8GCR
         99Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7sMkFu3WbDnH80Glnn82gYd+1da6NUT/aw21v/s39Mc=;
        b=Ru/VxUrZsLFQ2eP+N+amG4vHEyDMghhKlfJ1ep1qqhQPy6V7IJX5E+JF8teIS5lH5V
         GnDLXV8+5/eClTo06uZI2YVtaUa+bT7eq9gpuCAWvqCZlM0qwW8DBFvLoGwF1jgliphw
         bZ//+XqHssEChG5G1ep5dlcxYvFM2ZSvtRd2VLml8AefTlOU+WIH517feteUwYFU/J59
         teGvV5OlqINL4NxeIL9RlGNScD1Zuk9NMn2zppT0rDuH6rDjkZFnPwVxGX2WiuBiThSx
         PLEvKB0/ic0J1lSwQW/05dNaiq18q7Q4yxoekTDcOKG9DChU23sdLedhcgLOxXEvZKFG
         HmUA==
X-Gm-Message-State: AOAM531eU+ZpgAdW9IvkMCMoE2nNS6nO+emWGRBFe6NkRGC9pJP5WmaI
        Kt2Pj2tYNqyUm6hrD1HE9a9uu1YkVeg=
X-Google-Smtp-Source: ABdhPJwJ4m6CyOwUTqLu/xYCWIz2om87Mw+75Hx2QApnfd02w1lV3L5Nvg7UUeTNy9Wu/TTHToia4Q==
X-Received: by 2002:a17:90b:fd1:: with SMTP id gd17mr7419124pjb.148.1605899789086;
        Fri, 20 Nov 2020 11:16:29 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id o9sm4370480pjr.2.2020.11.20.11.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 11:16:28 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 05/15] mke2fs, tune2fs: update man page with fast commit info
Date:   Fri, 20 Nov 2020 11:15:56 -0800
Message-Id: <20201120191606.2224881-6-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201120191606.2224881-1-harshadshirwadkar@gmail.com>
References: <20201120191606.2224881-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch adds information about fast commit feature in mke2fs and
tune2fs man pages.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 misc/mke2fs.8.in  | 21 +++++++++++++++++++++
 misc/tune2fs.8.in | 25 +++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in
index e6bfc6d6..2833b408 100644
--- a/misc/mke2fs.8.in
+++ b/misc/mke2fs.8.in
@@ -521,6 +521,27 @@ The size of the journal must be at least 1024 filesystem blocks
 and may be no more than 10,240,000 filesystem blocks or half the total
 file system size (whichever is smaller)
 .TP
+.BI fast_commit_size= fast-commit-size
+Create an additional fast commit journal area of size
+.I fast-commit-size
+kilobytes.
+This option is only valid if
+.B fast_commit
+feature is enabled
+on the file system. If this option is not specified and if
+.B fast_commit
+feature is turned on, fast commit area size defaults to
+.I journal-size
+/ 64 megabytes. The total size of the journal with
+.B fast_commit
+feature set is
+.I journal-size
++ (
+.I fast-commit-size
+* 1024) megabytes. The total journal size may be no more than
+10,240,000 filesystem blocks or half the total file system size
+(whichever is smaller).
+.TP
 .BI location =journal-location
 Specify the location of the journal.  The argument
 .I journal-location
diff --git a/misc/tune2fs.8.in b/misc/tune2fs.8.in
index 582d1da5..2114c623 100644
--- a/misc/tune2fs.8.in
+++ b/misc/tune2fs.8.in
@@ -357,6 +357,27 @@ and may be no more than 10,240,000 filesystem blocks.
 There must be enough free space in the filesystem to create a journal of
 that size.
 .TP
+.BI fast_commit_size= fast-commit-size
+Create an additional fast commit journal area of size
+.I fast-commit-size
+kilobytes.
+This option is only valid if
+.B fast_commit
+feature is enabled
+on the file system. If this option is not specified and if
+.B fast_commit
+feature is turned on, fast commit area size defaults to
+.I journal-size
+/ 64 megabytes. The total size of the journal with
+.B fast_commit
+feature set is
+.I journal-size
++ (
+.I fast-commit-size
+* 1024) megabytes. The total journal size may be no more than
+10,240,000 filesystem blocks or half the total file system size
+(whichever is smaller).
+.TP
 .BI location =journal-location
 Specify the location of the journal.  The argument
 .I journal-location
@@ -586,6 +607,10 @@ Setting the filesystem feature is equivalent to using the
 .B \-j
 option.
 .TP
+.TP
+.B fast_commit
+Enable fast commit journaling feature to improve fsync latency.
+.TP
 .B large_dir
 Increase the limit on the number of files per directory.
 .B Tune2fs
-- 
2.29.2.454.gaff20da3a2-goog

