Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C581BC5A5
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Apr 2020 18:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgD1QqM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Apr 2020 12:46:12 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49926 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728084AbgD1QqL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 28 Apr 2020 12:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588092371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=88ox8GtihqbFNHEozsDa3e755E8gglid/Xusjz7RSlg=;
        b=OdBklY2xCSmMP/PUsCBdJoXHkgD7L4PBB/66v0F2u90d/c9q/d9IAPIDtyi8bZI28WhLIn
        runpp9oZSeAAYkDbGUY59geVu0ecgJv4Ts5nA3VyhoFqhAremI2zJrD5E+5gbT9ytcjONa
        PzK6xOrvvF2n8ScHwvAAuzag88axCpc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-teqohvL2PJWMUKX771bmRQ-1; Tue, 28 Apr 2020 12:46:09 -0400
X-MC-Unique: teqohvL2PJWMUKX771bmRQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 307641895A2F;
        Tue, 28 Apr 2020 16:46:08 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF3B71002388;
        Tue, 28 Apr 2020 16:46:05 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk
Subject: [PATCH v2 15/17] ext4: change token2str() to use ext4_param_specs
Date:   Tue, 28 Apr 2020 18:45:34 +0200
Message-Id: <20200428164536.462-16-lczerner@redhat.com>
In-Reply-To: <20200428164536.462-1-lczerner@redhat.com>
References: <20200428164536.462-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Chage token2str() to use ext4_param_specs instead of tokens so that we
can get rid of tokens entirely.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 fs/ext4/super.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index df7d1a724f1b..41075fdd076a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2691,12 +2691,12 @@ static inline void ext4_show_quota_options(struct=
 seq_file *seq,
=20
 static const char *token2str(int token)
 {
-	const struct match_token *t;
+	const struct fs_parameter_spec *spec;
=20
-	for (t =3D tokens; t->token !=3D Opt_err; t++)
-		if (t->token =3D=3D token && !strchr(t->pattern, '=3D'))
+	for (spec =3D ext4_param_specs; spec->name !=3D NULL; spec++)
+		if (spec->opt =3D=3D token && !spec->type)
 			break;
-	return t->pattern;
+	return spec->name;
 }
=20
 /*
--=20
2.21.1

