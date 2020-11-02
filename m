Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E71D2A2CEC
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Nov 2020 15:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgKBO0j (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Nov 2020 09:26:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34330 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725925AbgKBO0i (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Nov 2020 09:26:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604327197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JCSykoCJDyi6EQuX6/vLK0UKyPSyCuVNi1wrevWalTk=;
        b=B9ojKrthKDFYPKlntHKCuoZrDdmTDs1T6VZmtVihCBmiHnn5ikYZEzTtopnR/KJLPmsHhj
        PAwe6tzbHI7rbMedy6TRYG3I2YGbCjYY+n4sMcFmy6Pece+yaLLaZM/FDAYt8Vw8IFcuQc
        Qw0p85nL08cTCuVXNLLgPyQJKqAknzk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-w4gGmjJKPyyl3abEXbwnrQ-1; Mon, 02 Nov 2020 09:26:35 -0500
X-MC-Unique: w4gGmjJKPyyl3abEXbwnrQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D197801FCC
        for <linux-ext4@vger.kernel.org>; Mon,  2 Nov 2020 14:26:34 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 065406198E
        for <linux-ext4@vger.kernel.org>; Mon,  2 Nov 2020 14:26:33 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH] mke2fs: Escape double quotes when parsing mke2fs.conf
Date:   Mon,  2 Nov 2020 15:26:31 +0100
Message-Id: <20201102142631.87627-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Currently, when constructing the <default> configuration pseudo-file using
the profile-to-c.awk script we will just pass the double quotes as they
appear in the mke2fs.conf.

This is problematic, because the resulting default_profile.c will either
fail to compile because of syntax error, or leave the resulting
configuration invalid.

It can be reproduced by adding the following line somewhere into
mke2fs.conf configuration and forcing mke2fs to use the <default>
configuration by specifying nonexistent mke2fs.conf

MKE2FS_CONFIG="nonexistent" ./misc/mke2fs -T ext4 /dev/device

default_mntopts = "acl,user_xattr"
^ this will fail to compile

default_mntopts = ""
^ this will result in invalid config file

Syntax error in mke2fs config file (<default>, line #4)
       Unknown code prof 17

Fix it by escaping the double quotes with a backslash in
profile-to-c.awk script.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 misc/profile-to-c.awk | 1 +
 1 file changed, 1 insertion(+)

diff --git a/misc/profile-to-c.awk b/misc/profile-to-c.awk
index f964efd6..814f7236 100644
--- a/misc/profile-to-c.awk
+++ b/misc/profile-to-c.awk
@@ -4,6 +4,7 @@ BEGIN {
 }
 
 {
+  gsub("\"","\\\"",$0);
   printf("  \"%s\\n\"\n", $0);
 }
 
-- 
2.26.2

