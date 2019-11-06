Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6386EF139C
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2019 11:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbfKFKPX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Nov 2019 05:15:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21659 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728610AbfKFKPW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Nov 2019 05:15:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573035320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CJUFt6ZmhACmth5MACyckubQ2rk4EBo2kbAYp203tVQ=;
        b=UgZjJZnmcyZEKwAI5j8tMFB88Drpyg3RbXVcl+nDGSLtnzMuQt6ENtTCPhm4aTLg3OrFeZ
        TvQUSQFCZdJa8LSTAnCdWTFA/eiivkS+2gaLS2kf81rCe0hJXyAIuPEwjTYb7WYenOIOVx
        kSncG87b9uYA8aEFB1rSjAcjPB28GxU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-jo8iogTfOiyioeZZOnVZeQ-1; Wed, 06 Nov 2019 05:15:18 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CEA0F801FBF;
        Wed,  6 Nov 2019 10:15:17 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.205.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 86B2A26DC5;
        Wed,  6 Nov 2019 10:15:15 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 02/17] ext4: Add fs parameter description
Date:   Wed,  6 Nov 2019 11:14:42 +0100
Message-Id: <20191106101457.11237-3-lczerner@redhat.com>
In-Reply-To: <20191106101457.11237-1-lczerner@redhat.com>
References: <20191106101457.11237-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: jo8iogTfOiyioeZZOnVZeQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/super.c           | 109 ++++++++++++++++++++++++++++++++++++++
 include/linux/fs_parser.h |   6 +++
 2 files changed, 115 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dd654e53ba3d..44254179bd4f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -47,6 +47,9 @@
 #include <linux/kthread.h>
 #include <linux/freezer.h>
=20
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
+
 #include "ext4.h"
 #include "ext4_extents.h"=09/* Needed for trace points definition */
 #include "ext4_jbd2.h"
@@ -1459,6 +1462,112 @@ enum {
 =09Opt_dioread_nolock, Opt_dioread_lock,
 =09Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
 =09Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
+=09Opt_errors, Opt_data, Opt_data_err, Opt_jqfmt,
+};
+
+static const struct fs_parameter_enum ext4_param_enums[] =3D {
+=09{Opt_errors,=09"continue",=09Opt_err_cont},
+=09{Opt_errors,=09"panic",=09Opt_err_panic},
+=09{Opt_errors,=09"remount-ro",=09Opt_err_ro},
+=09{Opt_data,=09"journal",=09Opt_data_journal},
+=09{Opt_data,=09"ordered",=09Opt_data_ordered},
+=09{Opt_data,=09"writeback",=09Opt_data_writeback},
+=09{Opt_data_err,=09"abort",=09Opt_data_err_abort},
+=09{Opt_data_err,=09"ignore",=09Opt_data_err_ignore},
+=09{Opt_jqfmt,=09"vfsold",=09Opt_jqfmt_vfsold},
+=09{Opt_jqfmt,=09"vfsv0",=09Opt_jqfmt_vfsv0},
+=09{Opt_jqfmt,=09"vfsv1",=09Opt_jqfmt_vfsv1},
+};
+
+static const struct fs_parameter_spec ext4_param_specs[] =3D {
+=09fsparam_flag=09("bsddf",=09=09Opt_bsd_df),
+=09fsparam_flag=09("minixdf",=09=09Opt_minix_df),
+=09fsparam_flag=09("grpid",=09=09Opt_grpid),
+=09fsparam_flag=09("bsdgroups",=09=09Opt_grpid),
+=09fsparam_flag=09("nogrpid",=09=09Opt_nogrpid),
+=09fsparam_flag=09("sysvgroups",=09=09Opt_nogrpid),
+=09fsparam_u32=09("resgid",=09=09Opt_resgid),
+=09fsparam_u32=09("resuid",=09=09Opt_resuid),
+=09fsparam_u32=09("sb",=09=09=09Opt_sb),
+=09fsparam_enum=09("errors",=09=09Opt_errors),
+=09fsparam_flag=09("nouid32",=09=09Opt_nouid32),
+=09fsparam_flag=09("debug",=09=09Opt_debug),
+=09fsparam_flag=09("oldalloc",=09=09Opt_removed),
+=09fsparam_flag=09("orlov",=09=09Opt_removed),
+=09fsparam_flag=09("user_xattr",=09=09Opt_user_xattr),
+=09fsparam_flag=09("nouser_xattr",=09Opt_nouser_xattr),
+=09fsparam_flag=09("acl",=09=09=09Opt_acl),
+=09fsparam_flag=09("noacl",=09=09Opt_noacl),
+=09fsparam_flag=09("norecovery",=09=09Opt_noload),
+=09fsparam_flag=09("noload",=09=09Opt_noload),
+=09fsparam_flag=09("bh",=09=09=09Opt_removed),
+=09fsparam_flag=09("nobh",=09=09Opt_removed),
+=09fsparam_u32=09("commit",=09=09Opt_commit),
+=09fsparam_u32=09("min_batch_time",=09Opt_min_batch_time),
+=09fsparam_u32=09("max_batch_time",=09Opt_max_batch_time),
+=09fsparam_u32=09("journal_dev",=09=09Opt_journal_dev),
+=09fsparam_bdev=09("journal_path",=09Opt_journal_path),
+=09fsparam_flag=09("journal_checksum",=09Opt_journal_checksum),
+=09fsparam_flag=09("nojournal_checksum",=09Opt_nojournal_checksum),
+=09fsparam_flag=09("journal_async_commit",Opt_journal_async_commit),
+=09fsparam_flag=09("abort",=09=09Opt_abort),
+=09fsparam_enum=09("data",=09=09Opt_data),
+=09fsparam_enum=09("data_err",=09=09Opt_data_err),
+=09fsparam_string_empty
+=09=09=09("usrjquota",=09=09Opt_usrjquota),
+=09fsparam_string_empty
+=09=09=09("grpjquota",=09=09Opt_grpjquota),
+=09fsparam_enum=09("jqfmt",=09=09Opt_jqfmt),
+=09fsparam_flag=09("grpquota",=09=09Opt_grpquota),
+=09fsparam_flag=09("quota",=09=09Opt_quota),
+=09fsparam_flag=09("noquota",=09=09Opt_noquota),
+=09fsparam_flag=09("usrquota",=09=09Opt_usrquota),
+=09fsparam_flag=09("prjquota",=09=09Opt_prjquota),
+=09fsparam_bool=09("barrier",=09=09Opt_barrier),
+=09fsparam_flag=09("nobarrier",=09=09Opt_nobarrier),
+=09fsparam_flag=09("i_version",=09=09Opt_i_version),
+=09fsparam_flag=09("dax",=09=09=09Opt_dax),
+=09fsparam_u32=09("stripe",=09=09Opt_stripe),
+=09fsparam_flag=09("delalloc",=09=09Opt_delalloc),
+=09fsparam_flag=09("nodelalloc",=09=09Opt_nodelalloc),
+=09fsparam_flag=09("warn_on_error",=09Opt_warn_on_error),
+=09fsparam_flag=09("nowarn_on_error",=09Opt_nowarn_on_error),
+=09fsparam_flag=09("lazytime",=09=09Opt_lazytime),
+=09fsparam_flag=09("nolazytime",=09=09Opt_nolazytime),
+=09fsparam_u32=09("debug_want_extra_isize",
+=09=09=09=09=09=09Opt_debug_want_extra_isize),
+=09fsparam_flag=09("mblk_io_submit",=09Opt_removed),
+=09fsparam_flag=09("nomblk_io_submit",=09Opt_removed),
+=09fsparam_flag=09("block_validity",=09Opt_block_validity),
+=09fsparam_flag=09("noblock_validity",=09Opt_noblock_validity),
+=09fsparam_u32=09("inode_readahead_blks",
+=09=09=09=09=09=09Opt_inode_readahead_blks),
+=09fsparam_u32=09("journal_ioprio",=09Opt_journal_ioprio),
+=09fsparam_bool=09("auto_da_alloc",=09Opt_auto_da_alloc),
+=09fsparam_flag=09("noauto_da_alloc",=09Opt_noauto_da_alloc),
+=09fsparam_flag=09("dioread_nolock",=09Opt_dioread_nolock),
+=09fsparam_flag=09("dioread_lock",=09Opt_dioread_lock),
+=09fsparam_flag=09("discard",=09=09Opt_discard),
+=09fsparam_flag=09("nodiscard",=09=09Opt_nodiscard),
+=09fsparam_u32_opt=09("init_itable",=09=09Opt_init_itable),
+=09fsparam_flag=09("noinit_itable",=09Opt_noinit_itable),
+=09fsparam_u32=09("max_dir_size_kb",=09Opt_max_dir_size_kb),
+=09fsparam_flag=09("test_dummy_encryption",
+=09=09=09=09=09=09Opt_test_dummy_encryption),
+=09fsparam_flag=09("nombcache",=09=09Opt_nombcache),
+=09fsparam_flag=09("no_mbcache",=09=09Opt_nombcache),=09/* for backward co=
mpatibility */
+=09fsparam_string=09("check",=09=09Opt_removed),=09/* mount option from ex=
t2/3 */
+=09fsparam_flag=09("nocheck",=09=09Opt_removed),=09/* mount option from ex=
t2/3 */
+=09fsparam_flag=09("reservation",=09=09Opt_removed),=09/* mount option fro=
m ext2/3 */
+=09fsparam_flag=09("noreservation",=09Opt_removed),=09/* mount option from=
 ext2/3 */
+=09fsparam_u32=09("journal",=09=09Opt_removed),=09/* mount option from ext=
2/3 */
+=09{}
+};
+
+static const struct fs_parameter_description ext4_fs_parameters =3D {
+=09.name=09=09=3D "ext4",
+=09.specs=09=09=3D ext4_param_specs,
+=09.enums=09=09=3D ext4_param_enums,
 };
=20
 static const match_table_t tokens =3D {
diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index dee140db6240..f704eb465cbd 100644
--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -133,11 +133,17 @@ static inline bool fs_validate_description(const stru=
ct fs_parameter_description
 =09=09=09=09__fsparam(fs_param_is_u32_octal, NAME, OPT, 0)
 #define fsparam_u32hex(NAME, OPT) \
 =09=09=09=09__fsparam(fs_param_is_u32_hex, NAME, OPT, 0)
+#define fsparam_u32_opt(NAME, OPT) \
+=09=09=09=09__fsparam(fs_param_is_u32, NAME, OPT, \
+=09=09=09=09=09  fs_param_v_optional)
 #define fsparam_s32(NAME, OPT)=09__fsparam(fs_param_is_s32, NAME, OPT, 0)
 #define fsparam_u64(NAME, OPT)=09__fsparam(fs_param_is_u64, NAME, OPT, 0)
 #define fsparam_enum(NAME, OPT)=09__fsparam(fs_param_is_enum, NAME, OPT, 0=
)
 #define fsparam_string(NAME, OPT) \
 =09=09=09=09__fsparam(fs_param_is_string, NAME, OPT, 0)
+#define fsparam_string_empty(NAME, OPT) \
+=09=09=09=09__fsparam(fs_param_is_string, NAME, OPT, \
+=09=09=09=09=09  fs_param_neg_with_empty)
 #define fsparam_blob(NAME, OPT)=09__fsparam(fs_param_is_blob, NAME, OPT, 0=
)
 #define fsparam_bdev(NAME, OPT)=09__fsparam(fs_param_is_blockdev, NAME, OP=
T, 0)
 #define fsparam_path(NAME, OPT)=09__fsparam(fs_param_is_path, NAME, OPT, 0=
)
--=20
2.21.0

