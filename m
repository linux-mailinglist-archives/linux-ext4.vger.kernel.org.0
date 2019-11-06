Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7E28F139B
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2019 11:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfKFKPV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Nov 2019 05:15:21 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32063 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725856AbfKFKPV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Nov 2019 05:15:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573035320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=keng0HNt9A92I9WRKiu9EnyiCtO3WzwUb06VJi0OJdY=;
        b=iyBkEQZkMy/lhIpS36X2j2Psu2cYErHyWQnLCqAVzP1/2FWgzRtLl6yfNshK/SoLPtZZhd
        gmHEe/vX+kMsWLRfo58nJrpJq5Ak/Qiz8hvXseidTOMGHyFiSWFZlXe6QDuJWtFISQRYlX
        nmB2Zoat0VX7U6zT6CB2di2jrscemA8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-hkeVe5OxMLuixVqrMmsH9w-1; Wed, 06 Nov 2019 05:15:16 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B3141005502;
        Wed,  6 Nov 2019 10:15:15 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.205.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20BFF26DC5;
        Wed,  6 Nov 2019 10:15:13 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     Theodore Ts'o <tytso@mit.edu>, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 01/17] vfs: Handle fs_param_neg_with_empty
Date:   Wed,  6 Nov 2019 11:14:41 +0100
Message-Id: <20191106101457.11237-2-lczerner@redhat.com>
In-Reply-To: <20191106101457.11237-1-lczerner@redhat.com>
References: <20191106101457.11237-1-lczerner@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: hkeVe5OxMLuixVqrMmsH9w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Make fs_param_neg_with_empty work.  It says that a parameter with no value
or and empty value should be marked as negated.

This is intended for use with ext4, which hadn't yet been converted.

Fixes: 31d921c7fb96 ("vfs: Add configuration parser helpers")
Reported-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---
 fs/fs_parser.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index d1930adce68d..f95997a76738 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -129,6 +129,11 @@ int fs_parse(struct fs_context *fc,
 =09case fs_param_is_string:
 =09=09if (param->type !=3D fs_value_is_string)
 =09=09=09goto bad_value;
+=09=09if ((p->flags & fs_param_neg_with_empty) &&
+=09=09    (!result->has_value || !param->string[0])) {
+=09=09=09result->negated =3D true;
+=09=09=09goto okay;
+=09=09}
 =09=09if (!result->has_value) {
 =09=09=09if (p->flags & fs_param_v_optional)
 =09=09=09=09goto okay;
--=20
2.21.0

