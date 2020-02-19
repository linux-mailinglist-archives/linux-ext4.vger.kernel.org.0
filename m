Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 217A9164025
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Feb 2020 10:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgBSJT4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Feb 2020 04:19:56 -0500
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:53624 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726202AbgBSJT4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 19 Feb 2020 04:19:56 -0500
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 7E8502E14A0;
        Wed, 19 Feb 2020 12:19:54 +0300 (MSK)
Received: from vla1-5a8b76e65344.qloud-c.yandex.net (vla1-5a8b76e65344.qloud-c.yandex.net [2a02:6b8:c0d:3183:0:640:5a8b:76e6])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id bnLtzLBnAl-JrLOssYR;
        Wed, 19 Feb 2020 12:19:54 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1582103994; bh=8YSxTUOk5w5fh0SdmqFzB3e8NK2TQ0pJ0mEf0yBxVkU=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=0P3CPGb2mu269bYBBnvbhd7iWK7YVRiq39369+or8VaLRyqfbKF7Zpt+F3pjI/Nw/
         P/kmuUzDSaz6gKZxQtOTfTfRgpgEO6zGoiSSKDsYEA4/qb+ywfZWPUoluhyNq1D3qJ
         UMSqZTUCRcAmYckVnx9vnESAAfkKdnv/ThvS7jJY=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8448:fbcc:1dac:c863])
        by vla1-5a8b76e65344.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 6Ek3u93F2Y-JqUSIcYI;
        Wed, 19 Feb 2020 12:19:52 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] ext4: fix handling mount -o remount,nolazytime
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Cc:     Karel Zak <kzak@redhat.com>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Date:   Wed, 19 Feb 2020 12:19:52 +0300
Message-ID: <158210399258.5335.3994877510070204710.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Tool "mount" from util-linux >= 2.27 knows about flag MS_LAZYTIME and
handles options "lazytime" and "nolazytime" as fs-independent.

For ext4 it works for enabling lazytime: mount(MS_REMOUNT | MS_LAZYTIME),
but does not work for disabling: mount(MS_REMOUNT).

Currently ext4 has performance issue in lazytime implementation caused by
contention around inode_hash_lock in ext4_update_other_inodes_time().

Fortunately lazytime still could be disabled without unmounting by passing
"nolazytime" as fs-specific mount option: mount(MS_REMOUNT, "nolazytime").
But modern versions of tool "mount" cannot do that.

This patch fixes remount for modern tool and keeps backward compatibility.

Fixes: a2fd66d069d8 ("ext4: set lazytime on remount if MS_LAZYTIME is set by mount")
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Link: https://lore.kernel.org/lkml/158040603451.1879.7954684107752709143.stgit@buzz/
---
 fs/ext4/super.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index f464dff09774..c901dc957b97 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5339,6 +5339,9 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	if (sbi->s_journal && sbi->s_journal->j_task->io_context)
 		journal_ioprio = sbi->s_journal->j_task->io_context->ioprio;
 
+	if (!(*flags & SB_LAZYTIME))
+		sb->s_flags &= ~SB_LAZYTIME;
+
 	if (!parse_options(data, sb, NULL, &journal_ioprio, 1)) {
 		err = -EINVAL;
 		goto restore_opts;

