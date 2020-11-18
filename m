Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151BA2B80F3
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbgKRPmD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgKRPmC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:42:02 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818D4C0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:42:02 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id v2so1524932pgv.2
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=8oyeSDoHSskTjE71/BgsMrVoYjV8qLw3qKErTKdSEIU=;
        b=S6/og6DTzs5jAHDoWBG2uZ+aTMDKscwnLKuZKHRIg+9jEFNYL1l4mTB8SOb28fwIuq
         +LKmu1ChgD66My1+LTumj995zRYcNObmBzFS2MIVOSj7s9CnkR4Po11ebUuGVX8cJ5+T
         iFSG3G6pYayUwz1j2cO7zobsKCAPhoytgpdWtqI6sgbSSz2iXIGV3rzB5x/gMDFLKGgh
         PJ+tKrYh4ktO58kqT695gc3a/XXj2ZsPpW9g9lbgtmwifmxQshB1Fp/NDzytMis3dtfC
         du4BGWlDLeAbQxv3OITotpwC89tJ/Qb2BEh+vBDj157vJz2q0kGY04sCl1KC0DhqZ1Gu
         4kXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8oyeSDoHSskTjE71/BgsMrVoYjV8qLw3qKErTKdSEIU=;
        b=bsxVU3DKaTQQtlZKo5oMTSloMkOrZGtpQaZSiOacE+asn9hlUESM9xdqPUNbvaN+RM
         fwuvTpejh0btXiZQfngKi8HHzRlJ9/9YVIDPgL/8dXrllLCJfCcFqg+3wPXWHSMGS6do
         UKgSlmGXgP7evccv9m5n96UJukJR+QsjJcCFMG9B5mywEuvOxvRHk3nABqV1rP5nmtek
         ZWzUfeGIxHxpHsW7BTzba0lus94yNTd1GFtljGa7OBp/hPtig3A/K0bBwDDW4EypXTDg
         fghwR5zREe6NhwrV/DWa9J7TvfyqqTLeFxo1GHbXhB/graOIbyfhYNAsNeWOaiHEcSN/
         eNVQ==
X-Gm-Message-State: AOAM532DCWc960/s6td8SPDEhlH9aotKHpFCJEre7Y+OP0XFQNmg9rVH
        E+fyl3OYQkNaTZxEK7b/VvCU0IdmdnhBoWqxSPkTrvRxP86KSZJXGkl7/WhmJUnwi7xVBPsP1qc
        6UuWIsosn3dFWDA3IeLiOjt9E72Bponle7yY9OqHYvoHsWBjJ62D9LFk2I41VM20BGi2Xk+PIWB
        cdgze31Ww=
X-Google-Smtp-Source: ABdhPJzHJ/upZ9qzE6UOssmsqoxgyzRozQW4y5GpcKM8GJTM9eRzStv+mD8Qx1it7PVHqwaZdYqeFGj4kGwOre01UZM=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a17:90b:293:: with SMTP id
 az19mr46500pjb.1.1605714121628; Wed, 18 Nov 2020 07:42:01 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:37 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-52-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 51/61] configure: enable pfsck by default
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Since most of work has been done, compile e2fsprogs
with pfsck enabled by default.

So it could testing widely now.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 configure    | 13 +++++++++++--
 configure.ac | 13 ++++++++++---
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/configure b/configure
index 1bb7a325..511de4a1 100755
--- a/configure
+++ b/configure
@@ -1589,7 +1589,7 @@ Optional Features:
   --disable-tdb           disable tdb support
   --disable-bmap-stats    disable collection of bitmap stats.
   --enable-bmap-stats-ops enable collection of additional bitmap stats
-  --enable-pfsck     enable parallel e2fsck
+  --disable-pfsck     disable parallel e2fsck
   --disable-nls           do not use Native Language Support
   --enable-threads={posix|solaris|pth|windows}
                           specify multithreading API
@@ -6169,8 +6169,17 @@ $as_echo "Enabling parallel e2fsck" >&6; }
 fi
 
 else
-  { $as_echo "$as_me:${as_lineno-$LINENO}: result: Disabling parallel e2fsck" >&5
+  if test -z "PTHREAD_LIB"
+then
+	{ $as_echo "$as_me:${as_lineno-$LINENO}: result: Disabling parallel e2fsck" >&5
 $as_echo "Disabling parallel e2fsck" >&6; }
+else
+
+$as_echo "#define CONFIG_PFSCK 1" >>confdefs.h
+
+	{ $as_echo "$as_me:${as_lineno-$LINENO}: result: Enabling parallel e2fsck by default" >&5
+$as_echo "Enabling parallel e2fsck by default" >&6; }
+fi
 
 fi
 
diff --git a/configure.ac b/configure.ac
index e73dbf50..2dacd6c8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -877,13 +877,13 @@ fi
 AC_MSG_RESULT([Disabling additional bitmap statistics by default])
 )
 dnl
-dnl handle --enable-pfsck
+dnl handle --disable-pfsck
 dnl
 PTHREAD_LIB=''
 AC_CHECK_LIB(pthread,pthread_join,PTHREAD_LIB=-pthread)
 AC_SUBST(PTHREAD_LIB)
 AC_ARG_ENABLE([pfsck],
-[  --enable-pfsck     enable parallel e2fsck],
+[  --disable-pfsck     disable parallel e2fsck],
 if test "$enableval" = "no" || test -z "PTHREAD_LIB"
 then
 	AC_MSG_RESULT([Disabling parallel e2fsck])
@@ -893,7 +893,14 @@ else
 	AC_MSG_RESULT([Enabling parallel e2fsck])
 fi
 ,
-AC_MSG_RESULT([Disabling parallel e2fsck])
+if test -z "PTHREAD_LIB"
+then
+	AC_MSG_RESULT([Disabling parallel e2fsck])
+else
+	AC_DEFINE(CONFIG_PFSCK, 1,
+		[Define to 1 if parallel e2fsck is enabled])
+	AC_MSG_RESULT([Enabling parallel e2fsck by default])
+fi
 )
 dnl
 dnl
-- 
2.29.2.299.gdc1121823c-goog

