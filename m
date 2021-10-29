Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34CF24404C1
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Oct 2021 23:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhJ2VUS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 29 Oct 2021 17:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhJ2VUS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 29 Oct 2021 17:20:18 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301F3C061570
        for <linux-ext4@vger.kernel.org>; Fri, 29 Oct 2021 14:17:49 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 983BB1F45C6F;
        Fri, 29 Oct 2021 22:17:46 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com, repnop@google.com
Cc:     ltp@lists.linux.it, khazhy@google.com, kernel@collabora.com,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v3 0/9] Test the new fanotify FAN_FS_ERROR event
Date:   Fri, 29 Oct 2021 18:17:23 -0300
Message-Id: <20211029211732.386127-1-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

Now that FAN_FS_ERROR is close to being merged, I'm sending a new
version of the LTP tests.  This is the v3 of this patchset, and it
applies the feedback of the previous version, in particular, it solves
the issue Amir pointed out, that ltp won't gracefully handle a test with
tcnt==0.  To solve that, I merged the patch that set up the environment
with a simple test, that only triggers a fs abort and watches the
event.

I'm also renaming the testcase from fanotify20 to fanotify21, to leave
room for the pidfs test that is also in the baking by Matthew Bobrowski.

One important detail is that, for the tests to succeed, there is a
dependency on an ext4 fix I sent a few days ago:

https://lore.kernel.org/linux-ext4/20211026173302.84000-1-krisman@collabora.com/T/#u

---

Original cover letter:

FAN_FS_ERROR is a new (still unmerged) fanotify event to monitor
fileystem errors.  This patchset introduces a new LTP test for this
feature.

Testing file system errors is slightly tricky, in particular because
they are mostly file system dependent.  Since there are only patches for
ext4, I choose to make the test around it, since there wouldn't be much
to do with other file systems.  The second challenge is how we cause the
file system errors, since there is no error injection for ext4 in Linux.
In this series, this is done by corrupting specific data in the
test device with the help of debugfs.

The FAN_FS_ERROR feature is flying around linux-ext4 and fsdevel, and
the latest version is available on the branch below:

    https://gitlab.collabora.com/krisman/linux -b fanotify-notifications-v9

A proper manpage description is also available on the respective mailing
list, or in the branch below:

    https://gitlab.collabora.com/krisman/man-pages.git -b fan-fs-error

Please, let me know your thoughts.

Gabriel Krisman Bertazi (9):
  syscalls: fanotify: Add macro to require specific mark types
  syscalls: fanotify: Add macro to require specific events
  syscalls/fanotify21: Introduce FAN_FS_ERROR test
  syscalls/fanotify21: Validate the generic error info
  syscalls/fanotify21: Validate incoming FID in FAN_FS_ERROR
  syscalls/fanotify21: Support submission of debugfs commands
  syscalls/fanotify21: Create a corrupted file
  syscalls/fanotify21: Test file event with broken inode
  syscalls/fanotify21: Test capture of multiple errors

 configure.ac                                  |   3 +-
 testcases/kernel/syscalls/fanotify/.gitignore |   1 +
 testcases/kernel/syscalls/fanotify/fanotify.h |  66 +++-
 .../kernel/syscalls/fanotify/fanotify03.c     |   4 +-
 .../kernel/syscalls/fanotify/fanotify10.c     |   3 +-
 .../kernel/syscalls/fanotify/fanotify12.c     |   3 +-
 .../kernel/syscalls/fanotify/fanotify21.c     | 312 ++++++++++++++++++
 7 files changed, 384 insertions(+), 8 deletions(-)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify21.c

-- 
2.33.0

