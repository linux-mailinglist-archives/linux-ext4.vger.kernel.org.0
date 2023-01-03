Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206BE65CA7D
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Jan 2023 00:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjACXq1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Jan 2023 18:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjACXq0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Jan 2023 18:46:26 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A1D2FB
        for <linux-ext4@vger.kernel.org>; Tue,  3 Jan 2023 15:46:25 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id g16so24626211plq.12
        for <linux-ext4@vger.kernel.org>; Tue, 03 Jan 2023 15:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=euRwx6QF/OV6RpXiKr7BIdAc00ukRSAUiOkpbL7iCKU=;
        b=XjKNtQpNLJ8aqo7xjHoll4+DdwZrxKRZXlYp6JqqXGXYzu6avm3dJLbOsMQuy89EdG
         OIWBFWbEMo8JNz8qp4S5dPsIzqCFDBkzKAK65Fd3iUKktYjLfZgxonKbHUMSqauJ6Kyx
         kSt3wX07D1moGHhO+wh5Wh7DHypEKw3VjuYS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=euRwx6QF/OV6RpXiKr7BIdAc00ukRSAUiOkpbL7iCKU=;
        b=2k915RRMRepyu2al3QVJC5wOnaNqsUdVCan2AODrcZ9ytuKBF+H+8VouTqWMYRI9m6
         05F1nfHvdtt69elSQ20KB5gX15lIaTkNHqV//i4+JWo1fK5rPZLxnuG1XvIfD5PvAVeb
         Q8x8o4ZoLm8LuP3MqNZR6CGU90smksAXnB2Ij1aFIYST9geVClRF88EM49hmWNLEHHCG
         g2JLg8WUbrrhGVBb8Dvp4ET2itiJp/TMfXQx5LBdn81Km+itCrgjEAvXGTvlBZeCq+G4
         vBbM1hnWmOuuuxd0hedQ0eZtQV2PE4zkTqcJzJUk9/EZsWm8qLszF9k5BQutArhuRMMO
         4RVg==
X-Gm-Message-State: AFqh2kq16ofEZKljj2Ihn58EK6R1VSGvDSwrUP3Yt2iiN3Jfdd209Oje
        Sz+EoEeIvvvaQ0iMbNFHWO97YQ==
X-Google-Smtp-Source: AMrXdXv/JNePduRY0txUDdRCt5JhRSIR6DrhMpv75pkJ3d4K/8KqbSdJC4O5iyMFwg38vN8/tHD1Kg==
X-Received: by 2002:a05:6a20:bf19:b0:af:dc62:8abd with SMTP id gc25-20020a056a20bf1900b000afdc628abdmr50713685pzb.0.1672789584914;
        Tue, 03 Jan 2023 15:46:24 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a23-20020aa794b7000000b00582729b7032sm4793752pfl.97.2023.01.03.15.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 15:46:24 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     tytso@mit.edu
Cc:     Kees Cook <keescook@chromium.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH] ext4: Fix function prototype mismatch for ext4_feat_ktype
Date:   Tue,  3 Jan 2023 15:46:20 -0800
Message-Id: <20230103234616.never.915-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1630; h=from:subject:message-id; bh=EPPA4fAFZuWB5pdzvby7FTtYsOyM2XQPaphR85N5tMQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjtL5MF54NCvmDQY0Dd7rNnLX1L0GvWxEKudKalV75 pS6Nr92JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY7S+TAAKCRCJcvTf3G3AJjndD/ 47MN61Dsc0UtJKECZp7gwKoY73Pw3qTWJzGhEO8zpglulKrzEkZeTmPqhCIiQ7U8fC9E6hyPMOvGkR JL3zryAjWLo9eGZSahA3Hd7tbnnwYZ/ZF2iKqEhnkRF/dnXpC5Pa1QozMpdidQ6rZO5/v9dnLQDW0w Xi98Dw0EjbPMvKQnM7L+uJoYyyiI7kBjsYAePwWSerOGNflmjK7jj+RLCAZgdRUMgPdvSSm/BCLYqg kDeTUx8FPOHowELmcRgHBexBBzvFKb65KXlUBj4hndW/bMUjLR2s9VTm09L3DeILJrL9iH6sNLRyjL ADKZtflw7g7rUxaQX3RIK5ML2pcj/272P3g/5uNtCyBkOkNgKWsAqedOsIP4goqWAI0QCMsKY3RIm2 7du4nSWz7sQdkpIIVqNJfHoKbtKKrkjwN552ikIhXKWsDOsjDzFzi0VbHikZiWupfdcX3Yl8JIeKvW BpVAP83s1pbJS54o4CwGMT+1M/K0iX1xNpYhaieiJfX6qePvsAdYLNmi2KmdDrPVNmDv7Lp8tCudP8 NKdrr8dUolvQoy3K9oBsuxGUcStGfPSaiMfyIhuAuGaPJbXjLMpTjkygqQBdEmRgYh3HSnPqeLNyQi EeXk5XyMYgH2WqJLhtBB1KTJuOLGoSuBDmmUvEPBF5znyJD3023rRY+4SY8w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
indirect call targets are validated against the expected function
pointer prototype to make sure the call target is valid to help mitigate
ROP attacks. If they are not identical, there is a failure at run time,
which manifests as either a kernel panic or thread getting killed.

ext4_feat_ktype was setting the "release" handler to "kfree", which
doesn't have a matching function prototype. Add a simple wrapper
with the correct prototype.

This was found as a result of Clang's new -Wcast-function-type-strict
flag, which is more sensitive than the simpler -Wcast-function-type,
which only checks for type width mismatches.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/ext4/sysfs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index d233c24ea342..83cf8b5afb54 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -491,6 +491,11 @@ static void ext4_sb_release(struct kobject *kobj)
 	complete(&sbi->s_kobj_unregister);
 }
 
+static void ext4_kobject_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
 static const struct sysfs_ops ext4_attr_ops = {
 	.show	= ext4_attr_show,
 	.store	= ext4_attr_store,
@@ -505,7 +510,7 @@ static struct kobj_type ext4_sb_ktype = {
 static struct kobj_type ext4_feat_ktype = {
 	.default_groups = ext4_feat_groups,
 	.sysfs_ops	= &ext4_attr_ops,
-	.release	= (void (*)(struct kobject *))kfree,
+	.release	= ext4_kobject_release,
 };
 
 void ext4_notify_error_sysfs(struct ext4_sb_info *sbi)
-- 
2.34.1

