Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24D87E81ED
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Oct 2019 08:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfJ2HRd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Oct 2019 03:17:33 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:52608 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726222AbfJ2HRd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 29 Oct 2019 03:17:33 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id E25332E152A;
        Tue, 29 Oct 2019 10:17:29 +0300 (MSK)
Received: from sas2-62907d92d1d8.qloud-c.yandex.net (sas2-62907d92d1d8.qloud-c.yandex.net [2a02:6b8:c08:b895:0:640:6290:7d92])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id FLAYMo7LQn-HSl0IkGo;
        Tue, 29 Oct 2019 10:17:29 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1572333449; bh=JmOMu3j8hu0LNc+DXvUp3pdXcmiafoOCxffP9Mfih00=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=kL+fVJZcZGOzkzj1wsVwOuc0OFIOkT0Nwmci+dzv3uPx5X6sozRKtcLNeEYKqDvnr
         rGH5quePhVzaKlHJo8L9XfbKRde/BnyXj3+vFilVj9YOw0KbvaxIfaykVdKtG4ot+Y
         WQ56bpUxZmykxEvL69g5CVvDOtKwsVtjcaALXhSk=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:148a:8f3:5b61:9f4])
        by sas2-62907d92d1d8.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id OZwNqtbXMU-HSV4p7eg;
        Tue, 29 Oct 2019 10:17:28 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] ext4: deaccount delayed allocations at freeing inode in
 ext4_evict_inode()
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        Eric Whitney <enwlinux@gmail.com>
Date:   Tue, 29 Oct 2019 10:17:28 +0300
Message-ID: <157233344808.4027.17162642259754563372.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If inode->i_blocks is zero then ext4_evict_inode() skips ext4_truncate().
Delayed allocation extents are freed later in ext4_clear_inode() but this
happens when quota reference is already dropped. This leads to leak of
reserved space in quota block, which disappears after umount-mount.

This seems broken for a long time but worked somehow until recent changes
in delayed allocation.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 fs/ext4/inode.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 516faa280ced..580898145e8f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -293,6 +293,15 @@ void ext4_evict_inode(struct inode *inode)
 				   inode->i_ino, err);
 			goto stop_handle;
 		}
+	} else if (EXT4_I(inode)->i_reserved_data_blocks) {
+		/* Deaccount reserve if inode has only delayed allocations. */
+		err = ext4_es_remove_extent(inode, 0, EXT_MAX_BLOCKS);
+		if (err) {
+			ext4_warning(inode->i_sb,
+				     "couldn't remove extents %lu (err %d)",
+				     inode->i_ino, err);
+			goto stop_handle;
+		}
 	}
 
 	/* Remove xattr references. */

