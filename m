Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6E44566AF
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Nov 2021 00:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhKSAA4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Nov 2021 19:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhKSAAz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Nov 2021 19:00:55 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C849C061574
        for <linux-ext4@vger.kernel.org>; Thu, 18 Nov 2021 15:57:55 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id A9F981F47098
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637279872; bh=PxhtOZi8FpecU5v9kfXKItkwreg65Wwi4desFZ3Y+10=;
        h=From:To:Cc:Subject:Date:From;
        b=M4ALlR2cuYk6zx0KDFSifzBYMHFKPlSLS0kB/nhfYjjpgCu//emofUTVvejjv7KeQ
         61Ybj6YZgJpyq7ut1hbQz1SABNcJC89FNleK94aSlKT2+R8it37wNA1nXIiToNOLxB
         9fWlb1+yLri+5gfsIUb3do2sw+6zkyvhSz3GMsrkym7XUbQhEayOAAH84ZLhJs6k30
         Qw/MCWrZ7epo/dxQm5lJ9iyC9s0CzFN+wqmvf/lYBKvbs6H/6OKxGVNGjOGILUCeLq
         U/zdRIlkd/PGVvgzSTa02x/RX5vJ0zOnCFQX/DgOVtLk7ToMbAc6l6u7CX2daGIvjV
         Q+iOHspbUjjrg==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     pvorel@suse.cz, jack@suse.com, amir73il@gmail.com,
        repnop@google.com
Cc:     linux-ext4@vger.kernel.org, kernel@collabora.com,
        khazhy@google.com, ltp@lists.linux.it,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v4 0/9] Test the new fanotify FAN_FS_ERROR event
Date:   Thu, 18 Nov 2021 18:57:35 -0500
Message-Id: <20211118235744.802584-1-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

FAN_FS_ERROR was merged into Linus tree, and the PIDFD testcases reached
LTP.  Therefore, I'm sending a new version of the FAN_FS_ERROR LTP
tests.  This is the v4 of this patchset, and it applies the feedback of
the previous version.

Thanks,

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
  syscalls/fanotify22: Introduce FAN_FS_ERROR test
  syscalls/fanotify22: Validate the generic error info
  syscalls/fanotify22: Validate incoming FID in FAN_FS_ERROR
  syscalls/fanotify22: Support submission of debugfs commands
  syscalls/fanotify22: Create a corrupted file
  syscalls/fanotify22: Test file event with broken inode
  syscalls/fanotify22: Test capture of multiple errors

 configure.ac                                  |   3 +-
 testcases/kernel/syscalls/fanotify/.gitignore |   1 +
 testcases/kernel/syscalls/fanotify/fanotify.h |  65 +++-
 .../kernel/syscalls/fanotify/fanotify03.c     |   4 +-
 .../kernel/syscalls/fanotify/fanotify10.c     |   3 +-
 .../kernel/syscalls/fanotify/fanotify12.c     |   3 +-
 .../kernel/syscalls/fanotify/fanotify22.c     | 314 ++++++++++++++++++
 7 files changed, 385 insertions(+), 8 deletions(-)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify22.c

-- 
2.33.0

