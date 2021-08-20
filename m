Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D37E3F315D
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Aug 2021 18:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhHTQPr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Aug 2021 12:15:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37382 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhHTQPq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Aug 2021 12:15:46 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0C0C4221E9;
        Fri, 20 Aug 2021 16:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629476108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=pPu1MIJVt35RD10fJe4zhHVyfHRc7zPYfxdXjLJIQPg=;
        b=oUsJEspq6EuUs8ZVBxZgy9CGxka1FfLAMF9Ecp0uShNJI461g8C0qg74xqNAbHwdEVl/GI
        p0g5aQuFG+DJDPUFXeQsY2f5PokRb7SS2JGeHz8y7af8COH/RqLX3PZM/lMR+pbt5j8Htz
        AZd+1qdSj84/lwqhfaixWXIorVw8YzQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629476108;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=pPu1MIJVt35RD10fJe4zhHVyfHRc7zPYfxdXjLJIQPg=;
        b=+h2hRzxe5od6Cx/qgkF8k8i8NlVg6w9inYoMFpkq8nB6GzHUBNelcZtPO87AZRrfxSvS7l
        lsu6aqtUKgRYaNCA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 0076AA3B87;
        Fri, 20 Aug 2021 16:15:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CCEDF1E0679; Fri, 20 Aug 2021 18:15:04 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH] libss: add newer libreadline.so.8 to dlopen path
Date:   Fri, 20 Aug 2021 18:15:02 +0200
Message-Id: <20210820161502.8497-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1068; h=from:subject; bh=LHoupy/y/pBh46Y+3+qREs9sS9c1VwNorCB5FbEKdVo=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhH9TblntXKwwtKLgwOR43o/ztXK5uVQAgKuHshD0h KHqejNCJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYR/U2wAKCRCcnaoHP2RA2cerB/ 4j7P8PnlvkSnetNKuhc2piqQonYmJ560wlqtuD89f9HVtYqjGik40CNL8s89ou/e971MisK9j3KciI +Ml8p3H2WxXEe9cYuYE2SUuXWEE97fsgy9O2xVmyz7NJUdZWNKdMdDlNwx0v074u/tOriN5MtzPeLC PsXM3dBS1LHsA3DSQfvqTTCul/R05iCG5zK92uoGyCYhQv+P5hZX2YDnqHSsl/+jX9TGEemlz/e/xI z7y3z/uODJUr/ZNqOHaMOWoKH7yM/PGRl+aDxHDqKzZp/KxnsDdPy27cQNKyD1pfnUTxnepnPYOAXf B7CRj4zF4Ln1lvNIy9TQcd5I13uwY4
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

OpenSUSE Tumbleweed now has libreadline.so.8. Add it to the list of libs
to look for.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 lib/ss/get_readline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Hum, why don't we look for libreadline.so BTW? That way we could save adding
now so version whenever one appears?

diff --git a/lib/ss/get_readline.c b/lib/ss/get_readline.c
index 11c72b3387d1..aa1615747934 100644
--- a/lib/ss/get_readline.c
+++ b/lib/ss/get_readline.c
@@ -37,7 +37,7 @@ static void ss_release_readline(ss_data *info)
 #endif
 
 /* Libraries we will try to use for readline/editline functionality */
-#define DEFAULT_LIBPATH "libreadline.so.7:libreadline.so.6:libreadline.so.5:libreadline.so.4:libreadline.so:libedit.so.2:libedit.so:libeditline.so.0:libeditline.so"
+#define DEFAULT_LIBPATH "libreadline.so.8:libreadline.so.7:libreadline.so.6:libreadline.so.5:libreadline.so.4:libreadline.so:libedit.so.2:libedit.so:libeditline.so.0:libeditline.so"
 
 #ifdef HAVE_DLOPEN
 void ss_get_readline(int sci_idx)
-- 
2.26.2

