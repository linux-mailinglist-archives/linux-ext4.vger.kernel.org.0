Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F02C369B96
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Apr 2021 22:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244004AbhDWUwi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Apr 2021 16:52:38 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41382 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243974AbhDWUwd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Apr 2021 16:52:33 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id 74E8E1F41F63
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, krisman@collabora.com, ebiggers@google.com,
        drosen@google.com, ebiggers@kernel.org, yuchao0@huawei.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com, kernel test robot <lkp@intel.com>
Subject: [PATCH v8 1/4] fs: unicode: Use strscpy() instead of strncpy()
Date:   Sat, 24 Apr 2021 02:21:33 +0530
Message-Id: <20210423205136.1015456-2-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210423205136.1015456-1-shreeya.patel@collabora.com>
References: <20210423205136.1015456-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Following warning was reported by Kernel Test Robot.

In function 'utf8_parse_version',
inlined from 'utf8_load' at fs/unicode/utf8mod.c:195:7:
>> fs/unicode/utf8mod.c:175:2: warning: 'strncpy' specified bound 12 equals
destination size [-Wstringop-truncation]
175 |  strncpy(version_string, version, sizeof(version_string));
    |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The -Wstringop-truncation warning highlights the unintended
uses of the strncpy function that truncate the terminating NULL
character if source string is longer than the destination size.

strscpy() returns -E2BIG error code in case the source string doesn't
fit into the destination. Hence, use strscpy() and return an error for
overly-long strings instead of creating a non-null-terminated string
with strncpy().

Fixes: 9d53690f0d4e5 (unicode: implement higher level API for string handling)
Acked-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
Reported-by: kernel test robot <lkp@intel.com>
---
Changes in v8
  - Improve the commit message to decribe about how overly-long strings
    are handled.

 fs/unicode/utf8-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index dc25823bfed9..f9e6a2718aba 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -179,8 +179,10 @@ static int utf8_parse_version(const char *version, unsigned int *maj,
 		{1, "%d.%d.%d"},
 		{0, NULL}
 	};
+	int ret = strscpy(version_string, version, sizeof(version_string));
 
-	strncpy(version_string, version, sizeof(version_string));
+	if (ret < 0)
+		return ret;
 
 	if (match_token(version_string, token, args) != 1)
 		return -EINVAL;
-- 
2.30.2

