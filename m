Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24822343DAA
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Mar 2021 11:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhCVKWV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Mar 2021 06:22:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhCVKV6 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 22 Mar 2021 06:21:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A529861983;
        Mon, 22 Mar 2021 10:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616408518;
        bh=1ZXyAEoZvbRkXxlNGub3IZewOHt3TvQOb2jwwjEpWeM=;
        h=From:To:Cc:Subject:Date:From;
        b=rA5K7PCyEEcmeyp55RFIMDxdQy0/ANqGgaPGtNK1StpdpjgqXSi/FNbm0XeNt7KsV
         XlV08phrHIHwm6+TIqXIjjaWTUFpa6hAdYuHXdtxlxTiieSdb71hzvZiyW1GKWvh7D
         +2p8BE4RVoyZIvs/OptjiCqKMCtIlRY/bo36IDVEv2RbC3MFGVVjQKIzW1IrvNHtI9
         rKIEeKv3Auyu+vFvsKk9v842cJKOXz8fOb4XL9H0rGywlGLxCMheaXSu81BLhhFtb0
         V8EQfATahNNBlRGYt56x2bmrMfeR0AfnjJHy+0uQYCfM48LKPE+PtjOKQ5s4j5UnmG
         5cii+5nnKy11A==
From:   Arnd Bergmann <arnd@kernel.org>
To:     "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Mauricio Faria de Oliveira <mfo@canonical.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        Alexander Lochmann <alexander.lochmann@tu-dortmund.de>,
        Hui Su <sh_def@163.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] jbd2: avoid -Wempty-body warnings
Date:   Mon, 22 Mar 2021 11:21:38 +0100
Message-Id: <20210322102152.95684-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Building with 'make W=1' shows a harmless -Wempty-body warning:

fs/jbd2/recovery.c: In function 'fc_do_one_pass':
fs/jbd2/recovery.c:267:75: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
  267 |                 jbd_debug(3, "Fast commit replay failed, err = %d\n", err);
      |                                                                           ^

Change the empty dprintk() macros to no_printk(), which avoids this
warning and adds format string checking.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/jbd2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 99d3cd051ac3..232e6285536a 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -61,7 +61,7 @@ void __jbd2_debug(int level, const char *file, const char *func,
 #define jbd_debug(n, fmt, a...) \
 	__jbd2_debug((n), __FILE__, __func__, __LINE__, (fmt), ##a)
 #else
-#define jbd_debug(n, fmt, a...)    /**/
+#define jbd_debug(n, fmt, a...)  no_printk(fmt, ##a)
 #endif
 
 extern void *jbd2_alloc(size_t size, gfp_t flags);
-- 
2.29.2

