Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5689C67694E
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjAUUgz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjAUUgr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB49E28D3E
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 174ED60B76
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2001C433A0
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333400;
        bh=VvXtES7I3U2zXIiT7Pdtpoc8YGQ5YDLdeE5z3UJnzRs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=N6SGpLC8wn1UXK0IDZdDiL5bYEOigGxIKc97BYDlS0VI6wvDdKlnUWaB1ESpHVxzp
         xO/84GBZIKoYI6b7I+J+/2MAlM1x6AvyR9EQgZJTBhTshYJOq8O498ejTtcpcn+qeg
         xJug+D9WdzpKl+jRqzSMDkkn9k53ygL3EBOQzga3grDHkcV+EvEtuOkrYPdBBgEEO9
         FTKE1bfjFwf2u0+KAxQip9Sy0rlCRy64m1/kPLvvMeiQfoMsdLpztLvUTn/106aruE
         Gge7jIbx2Twoeo2pvLXdzu3/DuMSCOcTOPvLwZy0aAaZ8UVzBx52q1arXsBDHnHXJe
         RYkJQb+86rymQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 13/38] lib/{e2p,ss}: remove manual declarations of errno
Date:   Sat, 21 Jan 2023 12:32:05 -0800
Message-Id: <20230121203230.27624-14-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121203230.27624-1-ebiggers@kernel.org>
References: <20230121203230.27624-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

As per 'man 3 errno':

    On some ancient systems, <errno.h> was not present or did not
    declare errno, so that it was necessary to declare errno manually
    (i.e., extern int errno).   **Do not do this**.  It long ago ceased
    to be necessary, and it will cause problems with modern versions of
    the C library.

One of the platforms it causes a problem on is Windows:

    In file included from fgetversion.c:28:
    fgetversion.c: In function ‘fgetversion’:
    fgetversion.c:68:20: warning: ‘_errno’ redeclared without dllimport attribute: previous dllimport ignored [-Wattributes]
       68 |         extern int errno;
          |                    ^~~~~

Just remove these obsolete manual declarations of errno.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/e2p/fgetversion.c | 2 --
 lib/e2p/fsetversion.c | 1 -
 lib/e2p/getversion.c  | 1 -
 lib/e2p/setversion.c  | 1 -
 lib/ss/execute_cmd.c  | 2 --
 lib/ss/help.c         | 2 --
 lib/ss/pager.c        | 2 --
 7 files changed, 11 deletions(-)

diff --git a/lib/e2p/fgetversion.c b/lib/e2p/fgetversion.c
index a65e9a5c5..f3a5b4cdf 100644
--- a/lib/e2p/fgetversion.c
+++ b/lib/e2p/fgetversion.c
@@ -65,8 +65,6 @@ int fgetversion(const char *name, unsigned long *version)
 	rc = syscall(SYS_fsctl, name, EXT2_IOC_GETVERSION, &ver, 0);
 # endif /* !APPLE_DARWIN */
 #else /* ! HAVE_EXT2_IOCTLS */
-	extern int errno;
-
 	errno = EOPNOTSUPP;
 #endif /* ! HAVE_EXT2_IOCTLS */
 	if (rc == 0)
diff --git a/lib/e2p/fsetversion.c b/lib/e2p/fsetversion.c
index c2e045591..5f844b55e 100644
--- a/lib/e2p/fsetversion.c
+++ b/lib/e2p/fsetversion.c
@@ -65,7 +65,6 @@ int fsetversion (const char * name, unsigned long version)
    return syscall(SYS_fsctl, name, EXT2_IOC_SETVERSION, &ver, 0);
 #endif
 #else /* ! HAVE_EXT2_IOCTLS */
-	extern int errno;
 	errno = EOPNOTSUPP;
 	return -1;
 #endif /* ! HAVE_EXT2_IOCTLS */
diff --git a/lib/e2p/getversion.c b/lib/e2p/getversion.c
index 9f719b4a9..d374a0ea7 100644
--- a/lib/e2p/getversion.c
+++ b/lib/e2p/getversion.c
@@ -35,7 +35,6 @@ int getversion (int fd, unsigned long * version)
 	*version = ver;
 	return r;
 #else /* ! HAVE_EXT2_IOCTLS */
-	extern int errno;
 	errno = EOPNOTSUPP;
 	return -1;
 #endif /* ! HAVE_EXT2_IOCTLS */
diff --git a/lib/e2p/setversion.c b/lib/e2p/setversion.c
index 2bc933749..dd4a3f06b 100644
--- a/lib/e2p/setversion.c
+++ b/lib/e2p/setversion.c
@@ -34,7 +34,6 @@ int setversion (int fd, unsigned long version)
 	ver = (int) version;
 	return ioctl (fd, EXT2_IOC_SETVERSION, &ver);
 #else /* ! HAVE_EXT2_IOCTLS */
-	extern int errno;
 	errno = EOPNOTSUPP;
 	return -1;
 #endif /* ! HAVE_EXT2_IOCTLS */
diff --git a/lib/ss/execute_cmd.c b/lib/ss/execute_cmd.c
index 2e2c8cfa0..d092134a3 100644
--- a/lib/ss/execute_cmd.c
+++ b/lib/ss/execute_cmd.c
@@ -17,8 +17,6 @@
 #endif
 #ifdef HAVE_ERRNO_H
 #include <errno.h>
-#else
-extern int errno;
 #endif
 #include "ss_internal.h"
 #include <stdio.h>
diff --git a/lib/ss/help.c b/lib/ss/help.c
index a22b40178..54c78f239 100644
--- a/lib/ss/help.c
+++ b/lib/ss/help.c
@@ -20,8 +20,6 @@
 #endif
 #ifdef HAVE_ERRNO_H
 #include <errno.h>
-#else
-extern int errno;
 #endif
 #include <fcntl.h>
 #include <sys/param.h>
diff --git a/lib/ss/pager.c b/lib/ss/pager.c
index b9b889962..ba32b2019 100644
--- a/lib/ss/pager.c
+++ b/lib/ss/pager.c
@@ -20,8 +20,6 @@
 #endif
 #ifdef HAVE_ERRNO_H
 #include <errno.h>
-#else
-extern int errno;
 #endif
 
 #include "ss_internal.h"
-- 
2.39.0

