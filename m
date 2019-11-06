Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44DD9F139D
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2019 11:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbfKFKPZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Nov 2019 05:15:25 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37383 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729280AbfKFKPZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Nov 2019 05:15:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573035324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k3ORuIq+OD0BzAtNEko83JNOTNNcVhGqwkgJiexCdSU=;
        b=Mfg4HIiNm93nZc8DNNYwrqr/w5ERGMwB6HL26dE9+UfI+HA8SLdS99ygBUwERQOeqjyd4T
        t81l4VRJsxWr9p1XgV2j5ocQ2uXzrP38fv1KdDQB0pT7CDRYi7HR8qS3dN+MEB1ACdXthY
        Z+j2vNQJs1lZ23RSWL/eFiCj52aJcVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-_590Myb2Pj6G04ddNY5FEw-1; Wed, 06 Nov 2019 05:15:21 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EB09477;
        Wed,  6 Nov 2019 10:15:19 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.205.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 238D61A7E2;
        Wed,  6 Nov 2019 10:15:17 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 03/17] ext4: move option validation to a separate function
Date:   Wed,  6 Nov 2019 11:14:43 +0100
Message-Id: <20191106101457.11237-4-lczerner@redhat.com>
In-Reply-To: <20191106101457.11237-1-lczerner@redhat.com>
References: <20191106101457.11237-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: _590Myb2Pj6G04ddNY5FEw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Move option validation out of parse_options() into a separate function
ext4_validate_options().

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/super.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 44254179bd4f..b155257e2a4e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -88,6 +88,7 @@ static void ext4_unregister_li_request(struct super_block=
 *sb);
 static void ext4_clear_request_list(void);
 static struct inode *ext4_get_journal_inode(struct super_block *sb,
 =09=09=09=09=09    unsigned int journal_inum);
+static int ext4_validate_options(struct super_block *sb);
=20
 /*
  * Lock ordering
@@ -2160,10 +2161,9 @@ static int parse_options(char *options, struct super=
_block *sb,
 =09=09=09 unsigned int *journal_ioprio,
 =09=09=09 int is_remount)
 {
-=09struct ext4_sb_info *sbi =3D EXT4_SB(sb);
-=09char *p, __maybe_unused *usr_qf_name, __maybe_unused *grp_qf_name;
 =09substring_t args[MAX_OPT_ARGS];
 =09int token;
+=09char *p;
=20
 =09if (!options)
 =09=09return 1;
@@ -2181,7 +2181,14 @@ static int parse_options(char *options, struct super=
_block *sb,
 =09=09=09=09     journal_ioprio, is_remount) < 0)
 =09=09=09return 0;
 =09}
+=09return ext4_validate_options(sb);
+}
+
+static int ext4_validate_options(struct super_block *sb)
+{
+=09struct ext4_sb_info *sbi =3D EXT4_SB(sb);
 #ifdef CONFIG_QUOTA
+=09char *usr_qf_name, *grp_qf_name;
 =09/*
 =09 * We do the test below only for project quotas. 'usrquota' and
 =09 * 'grpquota' mount options are allowed even without quota feature
--=20
2.21.0

