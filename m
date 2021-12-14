Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CC3474CDB
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Dec 2021 21:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhLNU41 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Dec 2021 15:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbhLNU41 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Dec 2021 15:56:27 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222C5C061574
        for <linux-ext4@vger.kernel.org>; Tue, 14 Dec 2021 12:56:27 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id t11so19725262qtw.3
        for <linux-ext4@vger.kernel.org>; Tue, 14 Dec 2021 12:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iBq5h4ljD4EhKsomLG2GAY5w6FFirqkm84KkBsSVkYU=;
        b=ddLs8POnwbSFYqAglRT/C+UjtU/NsW52fgYiAO2C9uHC4scyWTTgbfS9yTVU3O4dMW
         k4kyqmBupT0mUw1eRnqTWagH4d9CntOOYeWECGDKAM+k3ftSDBGc/W79hWj4cbcfYmek
         7if+G5XLefC+pyH6SCZdFPiueehRgjTt7WaAQFd4+pt75hcUkWg6I9qk3W1ZlKIw2G9w
         Ku4uOsk/xPVjbvXsT+F/XsGZ7/2QgJpRcnlbgNfyrHobI0uqBxrthn2nvIjZ0K0KHOQV
         XHroqstGC5LY3w0PBNyEP2Oe+JPexFGgvKCEJvt6mESHRdUBiwQLIEVqkxGI8BUofXci
         Q8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iBq5h4ljD4EhKsomLG2GAY5w6FFirqkm84KkBsSVkYU=;
        b=ANtwzw+G+a7FRS1V90S+VaAOjU800YhzUhAwIzXWx/pDEz94j6465h229XwgUQRLuB
         zQBSNuAIkyob3bBBjoltT/OIt4azmHrWLxs8DAfsWND3U1/VzNvOJ6klpBqG8wqUsIMw
         0j0kzqz8qMHauSdJ3V0CN9DJMBUiMVESVsE5FaxuKDzcq/lOj5gHKQYpIq5nmbRud4Iv
         47KOfF8eKK0FgTnik9xTHOB/jGt9GdIGI1pdLQ7frX5LFLERu7e6UjdE3dbnSWN9Swcm
         Uz9vQTlGo83GRXkm35r8olGJbaKIcpNQYxP8YvZA7YStPgWPS3k6nJf4m2ycrj9vI6yd
         /vxA==
X-Gm-Message-State: AOAM531A0RxLKQEqqifLOpddmsqaCfbu9QiRTo/hLdWHXMh7zZoCzlbI
        9lbPFDcO3oJK8Z33zWFCH9ibc3a2zsc=
X-Google-Smtp-Source: ABdhPJyMu1MVGsPWZhCsngSrTourGXmhPflqL9zK98SmxcsDX2HKW0NByDrmSbjvzj69kqk73Wb6ig==
X-Received: by 2002:ac8:5cce:: with SMTP id s14mr8768045qta.349.1639515386158;
        Tue, 14 Dec 2021 12:56:26 -0800 (PST)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id d15sm783913qtd.70.2021.12.14.12.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 12:56:25 -0800 (PST)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH] xfstests-bld: add ext4/044 to adv.exclude
Date:   Tue, 14 Dec 2021 15:56:17 -0500
Message-Id: <20211214205617.17233-1-enwlinux@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Test ext4/044 fails when run in the adv test case because it explicitly
attempts to mount a test file system created with the inline_data
feature as ext3.  The inline_data feature and ext3 are incompatible,
and the mount attempt fails.

This test did not fail in earlier xfstests-bld versions because the
features included in adv were different.  In particular, the 64bit
feature was applied, and this had an unfortunate side effect.
Because the 64bit feature requires extents, and because the test
attempts to create an ext3 file system, the initial attempt actually
failed.  This was hidden by behavior in the xfstest function
_scratch_do_mkfs, which then attempted to create the file system without
the supplied "extra" mkfs options (those supplied for the adv test case).
So, the test file system was not created with inline_data, the explicit
attempt to mount the test file system as ext3 succeeded, and the test
passed without testing anything particular to the adv test case.

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 .../test-appliance/files/root/fs/ext4/cfg/adv.exclude         | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/adv.exclude b/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/adv.exclude
index b6c802d..42d7451 100644
--- a/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/adv.exclude
+++ b/kvm-xfstests/test-appliance/files/root/fs/ext4/cfg/adv.exclude
@@ -1,5 +1,9 @@
 ext4/004	# dump/restore doesn't handle inline data
 
+# ext4/044 tries to mount the file system as ext3 explicitly.  This will
+# fail because ext3 and the inline_data feature are incompatible.
+ext4/044
+
 # This takes a *long* time and doesn't add much value to run on all
 # configurations.  So we're going to be selective where we run it.
 generic/027
-- 
2.20.1

