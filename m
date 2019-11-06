Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBD3BF13AD
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2019 11:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731450AbfKFKPt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Nov 2019 05:15:49 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28301 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731418AbfKFKPr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Nov 2019 05:15:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573035346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PXA/dELZ8OtwOUO1D1m6U24gphQX+H7AIDKurT4QfSA=;
        b=NudDRtTvue9G7eqkr/UUcb2Yb9CPRULPhFDLn31UauXHnlyG94P+c3bf0kxyeEL1AzcyIN
        XOsgAGurFltFAdwdbZX+Ai/nmCu6oQC8GwSLOhuambs5SnjsIbcnaQ29ARoUxivre6gFUp
        gda/vMHWhOBI9R/EzMQMI2wWSY4yyek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-iG0t7e4-NvmYXecJ48Tu_w-1; Wed, 06 Nov 2019 05:15:43 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEB58107ACC3;
        Wed,  6 Nov 2019 10:15:41 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.205.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D983627073;
        Wed,  6 Nov 2019 10:15:40 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 16/17] ext4: change token2str() to use ext4_param_specs
Date:   Wed,  6 Nov 2019 11:14:56 +0100
Message-Id: <20191106101457.11237-17-lczerner@redhat.com>
In-Reply-To: <20191106101457.11237-1-lczerner@redhat.com>
References: <20191106101457.11237-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: iG0t7e4-NvmYXecJ48Tu_w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Chage token2str() to use ext4_param_specs instead of tokens so that we
can get rid of tokens entirely.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/super.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index f2f17c11b616..2f3296e81837 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2613,12 +2613,14 @@ static inline void ext4_show_quota_options(struct s=
eq_file *seq,
=20
 static const char *token2str(int token)
 {
-=09const struct match_token *t;
+=09const struct fs_parameter_spec *spec;
=20
-=09for (t =3D tokens; t->token !=3D Opt_err; t++)
-=09=09if (t->token =3D=3D token && !strchr(t->pattern, '=3D'))
+=09for (spec =3D ext4_param_specs; spec->name !=3D NULL; spec++)
+=09=09if (spec->opt =3D=3D token &&
+=09=09    (spec->type =3D=3D fs_param_is_flag ||
+=09=09     spec->type =3D=3D fs_param_is_bool))
 =09=09=09break;
-=09return t->pattern;
+=09return spec->name;
 }
=20
 /*
--=20
2.21.0

