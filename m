Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC361AFB83
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Apr 2020 16:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgDSO7d (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 19 Apr 2020 10:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgDSO7d (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 19 Apr 2020 10:59:33 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCB4C061A0C;
        Sun, 19 Apr 2020 07:59:33 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id g30so3675240pfr.3;
        Sun, 19 Apr 2020 07:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=kdyI82JjT3M56W4J6XJScvBjuJ26MbF7Q/2Npkyn2zY=;
        b=HLXSV3B6MpciVNZO5VC7bSsaJmsaR6kf8peM/E6RZp9/NbzKOntDCNZ+ME5z7NLcZG
         iuN/Te6ZU9e0LBgQDVVh0Iwdvy66+7Cml0fzbQdSOQyyVNBup9lEc8FriCfxaR2OvPYL
         xw7bGJzbVsFt8LtxR1jsBDNnv2YfDGhFvYMC9f7ifdiIG+8eInZjON9YtILKe3y15tC/
         RW8ccAZ+f+be6NQ2XnXfcZulTaRg+SVr7sNXOVOnTYiGIEYwHBv0uivEMAeayfXlHgfK
         GIv0VnA89HaGMYuK7f2XEIVgQpqTZhJU5VdKg/BE2jtHqSn374WiVdbN+kBI9exdr4N0
         ODwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=kdyI82JjT3M56W4J6XJScvBjuJ26MbF7Q/2Npkyn2zY=;
        b=sPvhPF55bpZ07u1ytSIAZVXxrJ7WLWAKwFrVz9rdcM7vdCH7wH1efOZIwinIPMO9xK
         +56tCIar3h5wuoWtIIlOhDTeJ0jfV+KSud7IYi/Cts2VShiuSVV+sPrm1lo6pTO+/E4B
         VPYLgdQjNy2tZ9K1z7T8PAcOhgeTMYuqb6xU3brPcoaenEQPN0s0/oiy+UtF2AOUQTOA
         ob01/aDiEnffYnku0apcrqZAdsAcomzShIx6f89Jn9tWPoiHU2JECpj8pn5P3cVvHNcF
         kON7JZ2JNfqR2aXf7eLt5vQlymrXO4zpC+c/C4AeL6EQdOKoHVXm8HupTxePWhMJu8Dp
         7Y+w==
X-Gm-Message-State: AGi0PuYYmgv1FA2Fx+PJQd+185+VT/CSWr9icrKbPWDlTDQV0QpQcLha
        UZ/WriEnJrRxuf5on1h0t08=
X-Google-Smtp-Source: APiQypL0kp5Zdl//h4W4UC2WtOAQlc6Kv1C0L0oEgDHxV9ag05+rmydqxq0cqFtIpM6w9abfHSJFQQ==
X-Received: by 2002:a63:cf4e:: with SMTP id b14mr12869302pgj.344.1587308372933;
        Sun, 19 Apr 2020 07:59:32 -0700 (PDT)
Received: from nishad ([106.51.232.103])
        by smtp.gmail.com with ESMTPSA id 17sm19487412pgg.76.2020.04.19.07.59.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Apr 2020 07:59:32 -0700 (PDT)
Date:   Sun, 19 Apr 2020 20:29:26 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Joe Perches <joe@perches.com>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: Use the correct style for SPDX License Identifier
Message-ID: <20200419145922.GA9713@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch corrects the SPDX License Identifier style in
header files related to Ext4 File System support.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used).

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 fs/ext4/acl.h            | 2 +-
 fs/ext4/ext4.h           | 2 +-
 fs/ext4/ext4_extents.h   | 2 +-
 fs/ext4/ext4_jbd2.h      | 2 +-
 fs/ext4/extents_status.h | 2 +-
 fs/ext4/fsmap.h          | 2 +-
 fs/ext4/mballoc.h        | 2 +-
 fs/ext4/truncate.h       | 2 +-
 fs/ext4/xattr.h          | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/acl.h b/fs/ext4/acl.h
index 9b63f5416a2f..a48fc5ae2701 100644
--- a/fs/ext4/acl.h
+++ b/fs/ext4/acl.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
   File: fs/ext4/acl.h
 
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 91eb4381cae5..834db49f28db 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *  ext4.h
  *
diff --git a/fs/ext4/ext4_extents.h b/fs/ext4/ext4_extents.h
index 1c216fcc202a..a49f4a9405c7 100644
--- a/fs/ext4/ext4_extents.h
+++ b/fs/ext4/ext4_extents.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2003-2006, Cluster File Systems, Inc, info@clusterfs.com
  * Written by Alex Tomas <alex@clusterfs.com>
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 4b9002f0e84c..2d0b715f955e 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * ext4_jbd2.h
  *
diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
index 4ec30a798260..7cf0e24e863d 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *  fs/ext4/extents_status.h
  *
diff --git a/fs/ext4/fsmap.h b/fs/ext4/fsmap.h
index 68c8001fee85..e80bae62798f 100644
--- a/fs/ext4/fsmap.h
+++ b/fs/ext4/fsmap.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2017 Oracle.  All Rights Reserved.
  *
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 88c98f17e3d9..dcf52540f379 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *  fs/ext4/mballoc.h
  *
diff --git a/fs/ext4/truncate.h b/fs/ext4/truncate.h
index bcbe3668c1d4..e465183d963f 100644
--- a/fs/ext4/truncate.h
+++ b/fs/ext4/truncate.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * linux/fs/ext4/truncate.h
  *
diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
index ffe21ac77f78..9308acd560f4 100644
--- a/fs/ext4/xattr.h
+++ b/fs/ext4/xattr.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
   File: fs/ext4/xattr.h
 
-- 
2.17.1

