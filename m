Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E204E1BC597
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Apr 2020 18:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgD1Qpv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Apr 2020 12:45:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46946 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727957AbgD1Qpv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Apr 2020 12:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588092349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lpuv7iWaVeNunST+tjB4wXU+WGHhdOGpYWy/euREdMo=;
        b=DuZYmT6ZW8qBLZCKFLCprgTTnQx6CiVyxEGtTKTvDOOwriPHk72xjtyRa3StdQxIp4OTY/
        LmKG9sg8DMfBAXwtVHCMf/QiMU2+xkHW00xKfSrt774A8vBxpFmCd5tTZ15Su+a6/0qg7F
        RA5z+A1Y5vfRbjNPdmOF6fRFFSV/Djw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-nl_lMkpMPAqqN-jKWWuPsA-1; Tue, 28 Apr 2020 12:45:47 -0400
X-MC-Unique: nl_lMkpMPAqqN-jKWWuPsA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3163A53;
        Tue, 28 Apr 2020 16:45:46 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 443541000322;
        Tue, 28 Apr 2020 16:45:45 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk
Subject: [PATCH v2 01/17] fs_parse: allow parameter value to be empty
Date:   Tue, 28 Apr 2020 18:45:20 +0200
Message-Id: <20200428164536.462-2-lczerner@redhat.com>
In-Reply-To: <20200428164536.462-1-lczerner@redhat.com>
References: <20200428164536.462-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Allow parameter value to be empty by spcifying fs_param_can_be_empty
flag.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/fs_parser.c            | 31 +++++++++++++++++++++++--------
 include/linux/fs_parser.h |  2 +-
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index ab53e42a874a..0d44801919f9 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -200,6 +200,8 @@ int fs_param_is_bool(struct p_log *log, const struct =
fs_parameter_spec *p,
 	int b;
 	if (param->type !=3D fs_value_is_string)
 		return fs_param_bad_value(log, param);
+	if (!*param->string && (p->flags & fs_param_can_be_empty))
+		return 0;
 	b =3D lookup_constant(bool_names, param->string, -1);
 	if (b =3D=3D -1)
 		return fs_param_bad_value(log, param);
@@ -212,8 +214,11 @@ int fs_param_is_u32(struct p_log *log, const struct =
fs_parameter_spec *p,
 		    struct fs_parameter *param, struct fs_parse_result *result)
 {
 	int base =3D (unsigned long)p->data;
-	if (param->type !=3D fs_value_is_string ||
-	    kstrtouint(param->string, base, &result->uint_32) < 0)
+	if (param->type !=3D fs_value_is_string)
+		return fs_param_bad_value(log, param);
+	if (!*param->string && (p->flags & fs_param_can_be_empty))
+		return 0;
+	if (kstrtouint(param->string, base, &result->uint_32) < 0)
 		return fs_param_bad_value(log, param);
 	return 0;
 }
@@ -222,8 +227,11 @@ EXPORT_SYMBOL(fs_param_is_u32);
 int fs_param_is_s32(struct p_log *log, const struct fs_parameter_spec *p=
,
 		    struct fs_parameter *param, struct fs_parse_result *result)
 {
-	if (param->type !=3D fs_value_is_string ||
-	    kstrtoint(param->string, 0, &result->int_32) < 0)
+	if (param->type !=3D fs_value_is_string)
+		return fs_param_bad_value(log, param);
+	if (!*param->string && (p->flags & fs_param_can_be_empty))
+		return 0;
+	if (kstrtoint(param->string, 0, &result->int_32) < 0)
 		return fs_param_bad_value(log, param);
 	return 0;
 }
@@ -232,8 +240,11 @@ EXPORT_SYMBOL(fs_param_is_s32);
 int fs_param_is_u64(struct p_log *log, const struct fs_parameter_spec *p=
,
 		    struct fs_parameter *param, struct fs_parse_result *result)
 {
-	if (param->type !=3D fs_value_is_string ||
-	    kstrtoull(param->string, 0, &result->uint_64) < 0)
+	if (param->type !=3D fs_value_is_string)
+		return fs_param_bad_value(log, param);
+	if (!*param->string && (p->flags & fs_param_can_be_empty))
+		return 0;
+	if (kstrtoull(param->string, 0, &result->uint_64) < 0)
 		return fs_param_bad_value(log, param);
 	return 0;
 }
@@ -245,6 +256,8 @@ int fs_param_is_enum(struct p_log *log, const struct =
fs_parameter_spec *p,
 	const struct constant_table *c;
 	if (param->type !=3D fs_value_is_string)
 		return fs_param_bad_value(log, param);
+	if (!*param->string && (p->flags & fs_param_can_be_empty))
+		return 0;
 	c =3D __lookup_constant(p->data, param->string);
 	if (!c)
 		return fs_param_bad_value(log, param);
@@ -256,7 +269,8 @@ EXPORT_SYMBOL(fs_param_is_enum);
 int fs_param_is_string(struct p_log *log, const struct fs_parameter_spec=
 *p,
 		       struct fs_parameter *param, struct fs_parse_result *result)
 {
-	if (param->type !=3D fs_value_is_string || !*param->string)
+	if (param->type !=3D fs_value_is_string ||
+	    (!*param->string && !(p->flags & fs_param_can_be_empty)))
 		return fs_param_bad_value(log, param);
 	return 0;
 }
@@ -276,7 +290,8 @@ int fs_param_is_fd(struct p_log *log, const struct fs=
_parameter_spec *p,
 {
 	switch (param->type) {
 	case fs_value_is_string:
-		if (kstrtouint(param->string, 0, &result->uint_32) < 0)
+		if ((!*param->string && !(p->flags & fs_param_can_be_empty)) ||
+		    kstrtouint(param->string, 0, &result->uint_32) < 0)
 			break;
 		if (result->uint_32 <=3D INT_MAX)
 			return 0;
diff --git a/include/linux/fs_parser.h b/include/linux/fs_parser.h
index 2eab6d5f6736..1cde756ef0fd 100644
--- a/include/linux/fs_parser.h
+++ b/include/linux/fs_parser.h
@@ -42,7 +42,7 @@ struct fs_parameter_spec {
 	u8			opt;	/* Option number (returned by fs_parse()) */
 	unsigned short		flags;
 #define fs_param_neg_with_no	0x0002	/* "noxxx" is negative param */
-#define fs_param_neg_with_empty	0x0004	/* "xxx=3D" is negative param */
+#define fs_param_can_be_empty	0x0004	/* "xxx=3D" is allowed */
 #define fs_param_deprecated	0x0008	/* The param is deprecated */
 	const void		*data;
 };
--=20
2.21.1

