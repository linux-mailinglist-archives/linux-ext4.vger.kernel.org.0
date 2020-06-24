Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B367206A3A
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jun 2020 04:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388230AbgFXCbQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 Jun 2020 22:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387835AbgFXCbQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 23 Jun 2020 22:31:16 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD1CC061573
        for <linux-ext4@vger.kernel.org>; Tue, 23 Jun 2020 19:31:16 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l63so603654pge.12
        for <linux-ext4@vger.kernel.org>; Tue, 23 Jun 2020 19:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7c4eGKW81B+OemcrKm4MQgz/3RkopxB8Ue6/O/Q2hkY=;
        b=WRi6cON9DHNltT5oUfen6qCSLSIJTxtehftDAupFOLv5lH4kwPzBkqVd93ncge3wT7
         smjELGR5bbeSLwfXHvOryXZZuk/tmzFHxw2ZR7jxe8/H++HCqXsvy63qSwVa9ODvTjdM
         ZWE9r6+gepbIcJQ5UmiAi4EksJT/7AmtO9h1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7c4eGKW81B+OemcrKm4MQgz/3RkopxB8Ue6/O/Q2hkY=;
        b=R4elUuZEPbM387ZoGZzsO47AZHaTcdcOTkZYbQWepQm+PuPx5URc9xNSK4APtYPT6y
         uGnLtjc8GBqE1ti7eapt91W7Nthn5Lk9s9hBABprjja2cr4E/HAUelEvPS1OKKjyTRay
         AVOIOvTdeIFkm4dTzi0ZxRUEaiKAnIHZj8Mduz9Zy0VUeXBMWqaQazCoypjvww2L2aoi
         OMElN+ntPup+ZhbqQGh29jYS+n3rKFxEu8N2nQAdygoULAfPzi1KDVl+l4N9W8rV04bS
         U9wEe5uZZHkAfe3xhrsx9dpvGpmkZBbVYqYE3DJFxlk/fegMGdpqXSeeKR2hR2tY3+7x
         swAg==
X-Gm-Message-State: AOAM533Jbk+8sc2VCYGIgFU57HgRhflemXLF3QKw+DEf3Eu1vIT2XQfK
        IKDFYZOhf5+dI2GLhORlkzzUMw==
X-Google-Smtp-Source: ABdhPJxxF+UKYEZSANjk+sh7xprPcF8VVIc5qFQtXIMQTDSq/BpkySP4V8qoYHH6sDJP0neTT63TJw==
X-Received: by 2002:a63:ab02:: with SMTP id p2mr20296844pgf.416.1592965875545;
        Tue, 23 Jun 2020 19:31:15 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id w10sm15338963pgm.70.2020.06.23.19.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 19:31:14 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     sarthakkukreti@chromium.org, tytso@mit.edu, ebiggers@google.com
Cc:     linux-ext4@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] tune2fs: allow remove VERITY
Date:   Tue, 23 Jun 2020 19:31:07 -0700
Message-Id: <20200624023107.182118-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Allow verity flag to be removed from the susperblock:
Tests:
- check the signed file is readable by older kernel after flag
is removed. EXT4_VERITY_FL replaces EXT4_EXT_MIGRATE that has been
removed in 2009.
- when a new kernel is reinstalled, check reenabling verity flag
allow signature to be verified (fsverity measure ...).

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 misc/tune2fs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 314cc0d0..724b8014 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -198,7 +198,8 @@ static __u32 clear_ok_features[3] = {
 		EXT4_FEATURE_RO_COMPAT_QUOTA |
 		EXT4_FEATURE_RO_COMPAT_PROJECT |
 		EXT4_FEATURE_RO_COMPAT_METADATA_CSUM |
-		EXT4_FEATURE_RO_COMPAT_READONLY
+		EXT4_FEATURE_RO_COMPAT_READONLY |
+		EXT4_FEATURE_RO_COMPAT_VERITY
 };
 
 /**
-- 
2.27.0.111.gc72c7da667-goog

