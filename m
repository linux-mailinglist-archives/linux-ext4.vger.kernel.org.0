Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19041459FCE
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Nov 2021 11:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbhKWKOh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 Nov 2021 05:14:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31927 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235308AbhKWKOg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 23 Nov 2021 05:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637662288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=w8sj1BR3J7P5JjMdHYdNHS0umwBBqIUc0ZkdXdA9MAU=;
        b=VuXEmL+JUUrlPlAAxmvkTVwaoS/cZZfyJ3X+dnYnEdiATQIisoijgP/oa3qlRFj2S00a1T
        vOB7rMILIrcYB71MnBA5fxsKg5I8szjbyWGNRt8G9O5YLWAjZaKjkhhoZTDXmqjpi6usYE
        t67P6ELciUw3cOb2V+vBBVPIPVKrx98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-TQ3c0MFbMKG20aOoSp3iuQ-1; Tue, 23 Nov 2021 05:11:25 -0500
X-MC-Unique: TQ3c0MFbMKG20aOoSp3iuQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60E269F92A;
        Tue, 23 Nov 2021 10:11:24 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.195.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A6C905F4E0;
        Tue, 23 Nov 2021 10:11:23 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH] common/rc: set maximum label length for ext4
Date:   Tue, 23 Nov 2021 11:11:19 +0100
Message-Id: <20211123101119.5112-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Set maximum label length for ext4 in _label_get_max() to be able to test
online file system label set/get ioctls.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 common/rc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/rc b/common/rc
index 8e351f17..50d6d0bd 100644
--- a/common/rc
+++ b/common/rc
@@ -4545,6 +4545,9 @@ _label_get_max()
 	f2fs)
 		echo 255
 		;;
+	ext2|ext3|ext4)
+		echo 16
+		;;
 	*)
 		_notrun "$FSTYP does not define maximum label length"
 		;;
-- 
2.31.1

