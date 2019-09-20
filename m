Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0C0B9911
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Sep 2019 23:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389650AbfITVbV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Sep 2019 17:31:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729725AbfITVbV (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 20 Sep 2019 17:31:21 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98BF720B7C
        for <linux-ext4@vger.kernel.org>; Fri, 20 Sep 2019 21:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569015080;
        bh=K1XKfl1E4n/4AYgHzqCbFj+SYp7RMDnxwNgkzlIr6u8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Llu57tAW4C/oJTO/BlBU+YvouPbdBAekovXEJvC2FzmiscCgSDxpTMUxHidBvasd7
         p2T6sHg/1EDKZg7shijB1Ay6H1GiDG1M7Hv0rUiRLDD46BUUfWh8yyfTbUwMgM9I1u
         4oJ81xBxq25fAAGa3wt8uvI3HRP4w7qDO2KEjY6Q=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 3/6] ext4.5: document the verity feature
Date:   Fri, 20 Sep 2019 14:29:51 -0700
Message-Id: <20190920212954.205789-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
In-Reply-To: <20190920212954.205789-1-ebiggers@kernel.org>
References: <20190920212954.205789-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 misc/ext4.5.in | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/misc/ext4.5.in b/misc/ext4.5.in
index 40e75f81..627c0dad 100644
--- a/misc/ext4.5.in
+++ b/misc/ext4.5.in
@@ -312,6 +312,18 @@ the file system using
 and it also speeds up the time required for
 .BR mke2fs (8)
 to create the file system.
+.TP
+.B verity
+.br
+Enables support for verity protected files.  Verity files are readonly,
+and their data is transparently verified against a Merkle tree hidden
+past the end of the file.  Using the Merkle tree's root hash, a verity
+file can be efficiently authenticated, independent of the file's size.
+.IP
+This feature is most useful for authenticating important read-only files
+on read-write file systems.  If the file system itself is read-only,
+then using dm-verity to authenticate the entire block device may provide
+much better security.
 .SH MOUNT OPTIONS
 This section describes mount options which are specific to ext2, ext3,
 and ext4.  Other generic mount options may be used as well; see
@@ -774,6 +786,8 @@ ext4, 4.13
 ext4, 4.13
 .IP "\fBcasefold\fR" 2i
 ext4, 5.2
+.IP "\fBverity\fR" 2i
+ext4, 5.4
 .SH SEE ALSO
 .BR mke2fs (8),
 .BR mke2fs.conf (5),
-- 
2.23.0.351.gc4317032e6-goog

