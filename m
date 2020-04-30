Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834771BE8F5
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Apr 2020 22:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgD2Uqo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Apr 2020 16:46:44 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:26924 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727027AbgD2Uqn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 29 Apr 2020 16:46:43 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 29 Apr 2020 13:46:40 -0700
Received: from localhost.localdomain (ashwinh-vm-1.vmware.com [10.110.19.225])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 450E440A3B;
        Wed, 29 Apr 2020 13:46:40 -0700 (PDT)
From:   ashwin-h <ashwinh@vmware.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@kernel.org>, <srivatsab@vmware.com>,
        <srivatsa@csail.mit.edu>, <rostedt@goodmis.org>,
        <srostedt@vmware.com>, <gregkh@linuxfoundation.org>,
        <ashwin.hiranniah@gmail.com>, ashwin-h <ashwinh@vmware.com>
Subject: [PATCH 0/5] Backport to 4.4 - ext4: protect journal inode's blocks using block_validity
Date:   Thu, 30 Apr 2020 10:05:16 +0530
Message-ID: <cover.1587718568.git.ashwinh@vmware.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: ashwinh@vmware.com does not
 designate permitted sender hosts)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

[PATCH 1/5] ext4: avoid declaring fs inconsistent due to invalid file
handles
This patch is backported as functionality in this commit is used by
Patch 2 in this patchset.

[PATCH 2/5] ext4: protect journal inode's blocks using block_validity
Backport to 4.4

[PATCH 3/5] ext4: don't perform block validity checks on the journal
[PATCH 4/5] ext4: fix block validity checks for journal inodes using
[PATCH 5/5] ext4: unsigned int compared against zero
Fixes issues found in Patch 2 in this patchset.


These patches addresses CVE-2019-19319

Colin Ian King (1):
  ext4: unsigned int compared against zero

Theodore Ts'o (4):
  ext4: avoid declaring fs inconsistent due to invalid file handles
  ext4: protect journal inode's blocks using block_validity
  ext4: don't perform block validity checks on the journal inode
  ext4: fix block validity checks for journal inodes using indirect
    blocks

 fs/ext4/block_validity.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ext4/ext4.h           | 15 ++++++++++++--
 fs/ext4/extents.c        | 12 +++++++----
 fs/ext4/ialloc.c         |  2 +-
 fs/ext4/inode.c          | 48 ++++++++++++++++++++++++++++++------------
 fs/ext4/ioctl.c          |  2 +-
 fs/ext4/namei.c          |  4 ++--
 fs/ext4/resize.c         |  5 +++--
 fs/ext4/super.c          | 28 +++++++++----------------
 9 files changed, 127 insertions(+), 43 deletions(-)

-- 
2.7.4

