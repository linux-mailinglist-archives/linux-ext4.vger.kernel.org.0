Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6D32CA6F8
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Dec 2020 16:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391817AbgLAPYU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Dec 2020 10:24:20 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:58828 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391805AbgLAPYU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Dec 2020 10:24:20 -0500
X-Greylist: delayed 624 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Dec 2020 10:24:19 EST
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 0F8CE18172F06;
        Tue,  1 Dec 2020 16:13:14 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id fliEVs798DrA; Tue,  1 Dec 2020 16:13:13 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id A7UHHXVABWwE; Tue,  1 Dec 2020 16:13:13 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH] ext4: Don't leak old mountpoint samples
Date:   Tue,  1 Dec 2020 16:13:01 +0100
Message-Id: <20201201151301.22025-1-richard@nod.at>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

As soon the first file is opened, ext4 samples the mountpoint
of the filesystem in 64 bytes of the super block.
It does so using strlcpy(), this means that the remaining bytes
in the super block string buffer are untouched.
If the mount point before had a longer path than the current one,
it can be reconstructed.

Consider the case where the fs was mounted to "/media/johnjdeveloper"
and later to "/".
The the super block buffer then contains "/\x00edia/johnjdeveloper".

This case was seen in the wild and caused confusion how the name
of a developer ands up on the super block of a filesystem used
in production...

Fix this by clearing the string buffer before writing to it,

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/ext4/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 3ed8c048fb12..dba521250d01 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -809,6 +809,7 @@ static int ext4_sample_last_mounted(struct super_bloc=
k *sb,
 	err =3D ext4_journal_get_write_access(handle, sbi->s_sbh);
 	if (err)
 		goto out_journal;
+	memset(sbi->s_es->s_last_mounted, 0x00, sizeof(sbi->s_es->s_last_mounte=
d));
 	strlcpy(sbi->s_es->s_last_mounted, cp,
 		sizeof(sbi->s_es->s_last_mounted));
 	ext4_handle_dirty_super(handle, sb);
--=20
2.26.2

