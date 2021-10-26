Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4EA43B9CA
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Oct 2021 20:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236515AbhJZSpl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Oct 2021 14:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235794AbhJZSpj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 26 Oct 2021 14:45:39 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CCAC061745
        for <linux-ext4@vger.kernel.org>; Tue, 26 Oct 2021 11:43:13 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 035A51F43877;
        Tue, 26 Oct 2021 19:43:10 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     ltp@lists.linux.it, jack@suse.com, amir73il@gmail.com
Cc:     khazhy@google.com, kernel@collabora.com,
        linux-ext4@vger.kernel.org, repnop@google.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v2 00/10] Test the new fanotify FAN_FS_ERROR event
Date:   Tue, 26 Oct 2021 15:42:29 -0300
Message-Id: <20211026184239.151156-1-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

Now that FAN_FS_ERROR is close to being merged, I'm sending out a new
version of the LTP tests.  This version only applies the previous
feedback and updates the interface to correspond to the changes
requested on the kernel patches.

One important detail is that, for the tests to succeed, there is a
dependency on an ext4 fix I sent today:

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

Gabriel Krisman Bertazi (10):
  syscalls: fanotify: Add macro to require specific mark types
  syscalls: fanotify: Add macro to require specific events
  syscalls/fanotify20: Introduce helpers for FAN_FS_ERROR test
  syscalls/fanotify20: Validate the generic error info
  syscalls/fanotify20: Validate incoming FID in FAN_FS_ERROR
  syscalls/fanotify20: Support submission of debugfs commands
  syscalls/fanotify20: Create a corrupted file
  syscalls/fanotify20: Test event after filesystem abort
  syscalls/fanotify20: Test file event with broken inode
  syscalls/fanotify20: Test capture of multiple errors

 testcases/kernel/syscalls/fanotify/.gitignore |   1 +
 testcases/kernel/syscalls/fanotify/fanotify.h |  72 +++-
 .../kernel/syscalls/fanotify/fanotify03.c     |   4 +-
 .../kernel/syscalls/fanotify/fanotify10.c     |   3 +-
 .../kernel/syscalls/fanotify/fanotify12.c     |   3 +-
 .../kernel/syscalls/fanotify/fanotify20.c     | 313 ++++++++++++++++++
 6 files changed, 389 insertions(+), 7 deletions(-)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify20.c

-- 
2.33.0

