Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB121EF2E8
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jun 2020 10:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgFEIO4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Jun 2020 04:14:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60156 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725986AbgFEIOz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Jun 2020 04:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591344894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=50HbxhUUlhcuuYB0XS/HFK6Wq/LTkGN0QWQYVM34EQk=;
        b=SphLSAKkZ+/qbsVLM6zLiuK0uDkNaWb3yzzwFmf+VX/MukOcc9AgsGkkbk447Ic7E8eLVI
        yIFw+y9AFrbY0EHyDnhnn+hPfwgRnBJnVyL/EVmGTPpqrKb+OY5PahBBLqTaUmafSX4Yc2
        Hgx+f/Nq+FlwP4au6h2MujSDW8XygBY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-9xRaB6LFNCyx5-tSaKOdSw-1; Fri, 05 Jun 2020 04:14:52 -0400
X-MC-Unique: 9xRaB6LFNCyx5-tSaKOdSw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31E87800685
        for <linux-ext4@vger.kernel.org>; Fri,  5 Jun 2020 08:14:51 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9EDD46ACF6
        for <linux-ext4@vger.kernel.org>; Fri,  5 Jun 2020 08:14:50 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 2/4] e2fsck: use size_t instead of int in string_copy()
Date:   Fri,  5 Jun 2020 10:14:40 +0200
Message-Id: <20200605081442.13428-2-lczerner@redhat.com>
In-Reply-To: <20200605081442.13428-1-lczerner@redhat.com>
References: <20200605081442.13428-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

len argument in string_copy() is int, but it is used with malloc(),
strlen(), strncpy() and some callers use sizeof() to pass value in. So
it really ought to be size_t rather than int. Fix it.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 e2fsck/e2fsck.h | 2 +-
 e2fsck/util.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 9b2b9ce8..85f953b2 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -627,7 +627,7 @@ extern void log_err(e2fsck_t ctx, const char *fmt, ...)
 extern void e2fsck_read_bitmaps(e2fsck_t ctx);
 extern void e2fsck_write_bitmaps(e2fsck_t ctx);
 extern void preenhalt(e2fsck_t ctx);
-extern char *string_copy(e2fsck_t ctx, const char *str, int len);
+extern char *string_copy(e2fsck_t ctx, const char *str, size_t len);
 extern int fs_proc_check(const char *fs_name);
 extern int check_for_modules(const char *fs_name);
 #ifdef RESOURCE_TRACK
diff --git a/e2fsck/util.c b/e2fsck/util.c
index d98b8e47..88e0ea8a 100644
--- a/e2fsck/util.c
+++ b/e2fsck/util.c
@@ -135,7 +135,7 @@ void *e2fsck_allocate_memory(e2fsck_t ctx, unsigned long size,
 }
 
 char *string_copy(e2fsck_t ctx EXT2FS_ATTR((unused)),
-		  const char *str, int len)
+		  const char *str, size_t len)
 {
 	char	*ret;
 
-- 
2.21.3

