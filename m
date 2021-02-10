Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19671315C58
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Feb 2021 02:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbhBJBfJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Feb 2021 20:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbhBJBdA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Feb 2021 20:33:00 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E2DC061756
        for <linux-ext4@vger.kernel.org>; Tue,  9 Feb 2021 17:32:20 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id w22so467885pll.6
        for <linux-ext4@vger.kernel.org>; Tue, 09 Feb 2021 17:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Kfk5Uw4Z7kJQuQ7PIMrKec+wBQ/rinHT9qe11xyQpf8=;
        b=AJiI3ZdxkUaUHyU+IOdAYJKp0E7IJF0ky0J3sxnrHs/tdb4XB3fAiBLr4bKxReKF1I
         X+SW8akxJltYR/R0txsCdf1HdPCGWXtqwA7xC8unWK8aAeEBp6p1B0vkMzDr92CsLmuN
         Au/2UNetsbqVK4lx92ivUFtfz+BPvz3eR+/I6wA0MSLEjSHhPO1IyfGkiy8DdrbxW11c
         QSzrhQXXz6DeqE7Ipr0rDkagxi3mguLzy4+Ch7bgauUYIqcTd60il7poy0Qp4W0Zgwqm
         QlDw62zolzmduc1uo9cyyVOtcmUJ/bsTW9k5204RBvwPnt3nf1OqVg6gpto2mugHxbIy
         sdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Kfk5Uw4Z7kJQuQ7PIMrKec+wBQ/rinHT9qe11xyQpf8=;
        b=Xf8um07Y1/qTa8IRgRnreID2MNLVbmwEnJbn4DLL/h/yVR/7MLG4OiZ77owcMEAWhY
         PbDw0FIJQHKJhGrwjydfdbnEJhCAgFeCyMmp/Cbhr8iHWWYohI+DtbKK5rxyWtbhny5u
         XcnUMzKKTvLi12Hf9bF/ZTPjv1BYDAQ+zG+C4cGzC3a+IAaUEYsv2zYzwQJhPDT3L6m2
         OyFD0IjrFSIO322lEGv/cu+qi0bXEePzJUzVlLldbADOVuFSC7NIU5kRzGHMmR6eInFj
         Ik3Xiy0/d7CmSZNEkkUrRNwcTq+CEL3t6JrX72kR5nSthZJbcygL4yIYozp/hKjpzHej
         GGXg==
X-Gm-Message-State: AOAM531wthYGhr17UkIwCjvaEO5lFz34/yRK17pOaFSCKpVq3RkKG+T9
        eo5Dz6jN2GkUOLCmDK3vTp+aenPmCJ7Z3w==
X-Google-Smtp-Source: ABdhPJz8anVTJuRGoYEo7hpKIc/GDpTEUtNsCs7mbDXLFOx0LEzP+Ls9+h65Ys4zarn/v345/BbuEmPeAnHGmA==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:7dd9:967f:92f4:2aae])
 (user=dlatypov job=sendgmr) by 2002:aa7:810d:0:b029:1dc:2639:8376 with SMTP
 id b13-20020aa7810d0000b02901dc26398376mr724241pfi.27.1612920740133; Tue, 09
 Feb 2021 17:32:20 -0800 (PST)
Date:   Tue,  9 Feb 2021 17:32:06 -0800
Message-Id: <20210210013206.136227-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH] ext4: add .kunitconfig fragment to enable ext4-specific tests
From:   Daniel Latypov <dlatypov@google.com>
To:     tytso@mit.edu
Cc:     brendanhiggins@google.com, davidgow@google.com,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        kunit-dev@googlegroups.com, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

As of [1], we no longer want EXT4_KUNIT_TESTS and others to `select`
their deps. This means it can get harder to get all the right things
selected as we gain more tests w/ more deps over time.

This patch (and [2]) proposes we store kunitconfig fragments in-tree to
represent sets of tests. (N.B. right now we only have one ext4 test).

There's still a discussion to be had about how to have a hierarchy of
these files (e.g. if one wanted to test all of fs/, not just fs/ext4).

But this fragment would likely be a leaf node and isn't blocked on
deciding if we want `import` statements and the like.

Usage
=====

Before [2] (on its way to being merged):
  $ cp fs/ext4/.kunitconfig .kunit/
  $ ./tools/testing/kunit.py run

After [2]:
  $ ./tools/testing/kunit.py run --kunitconfig=fs/ext4/.kunitconfig

".kunitconfig" vs "kunitconfig"
===============================

See also: commit 14ee5cfd4512 ("kunit: Rename 'kunitconfig' to '.kunitconfig'").
* The bit about .gitignore exluding it by default is now a con, however.
* But there are a lot of directories with files that begin with "k" and
  so this could cause some annoyance w/ tab completion*
* This is the name kunit.py expects right now, so some people are used
  to .kunitconfig over "kunitconfig"

[1] https://lore.kernel.org/linux-ext4/20210122110234.2825685-1-geert@linux-m68k.org/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit&id=243180f5924ed27ea417db39feb7f9691777688e

* 372/5556 directories isn't too much, but still not a small number:
$ find -type f -name 'k*' | xargs dirname | sort -u | wc -l
372

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 fs/ext4/.kunitconfig | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 fs/ext4/.kunitconfig

diff --git a/fs/ext4/.kunitconfig b/fs/ext4/.kunitconfig
new file mode 100644
index 000000000000..bf51da7cd9fc
--- /dev/null
+++ b/fs/ext4/.kunitconfig
@@ -0,0 +1,3 @@
+CONFIG_KUNIT=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_KUNIT_TESTS=y

base-commit: 88bb507a74ea7d75fa49edd421eaa710a7d80598
-- 
2.30.0.478.g8a0d178c01-goog

