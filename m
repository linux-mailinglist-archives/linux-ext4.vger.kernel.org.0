Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E406A3F5DAD
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Aug 2021 14:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237118AbhHXMLM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Aug 2021 08:11:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26208 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236969AbhHXMLL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 24 Aug 2021 08:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629807027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gOwWaCaThZ+AtEFFwf3VJ/szXfzI27Vxv0OEK2fKRSw=;
        b=MMFo2QhmCyIrOU3i+05B2Kf/IphQ2SVK8SXJocVyEihJnn8kmYlao5yxo/JBPTuJYL+ITM
        ZHS/8NBjyzO5IgGEuBajl65lFZqVQg04FP7A44OC6zCQt01T3jUxxZfG1h5H+r26RZwlx5
        WkATDQ2jOrsQV6G1es4rOtgjxlxs42Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-qctIdoRXMb-_YnCN5yq5dw-1; Tue, 24 Aug 2021 08:10:25 -0400
X-MC-Unique: qctIdoRXMb-_YnCN5yq5dw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00033101C8A5;
        Tue, 24 Aug 2021 12:10:24 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.0])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 197A460C25;
        Tue, 24 Aug 2021 12:10:23 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH 1/2] tests: update expect files for f_mmp_garbage
Date:   Tue, 24 Aug 2021 14:10:19 +0200
Message-Id: <20210824121020.143449-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Update expect file for f_mmp_garbage test to work correctly with the
new default 256 inode size.

Fixes: d730be5ceeba ("tests: update mke2fs.conf to create 256 byte inodes by default")
Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 tests/f_mmp_garbage/expect.1 | 2 +-
 tests/f_mmp_garbage/expect.2 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/f_mmp_garbage/expect.1 b/tests/f_mmp_garbage/expect.1
index a8add101..4134eaea 100644
--- a/tests/f_mmp_garbage/expect.1
+++ b/tests/f_mmp_garbage/expect.1
@@ -5,5 +5,5 @@ Pass 2: Checking directory structure
 Pass 3: Checking directory connectivity
 Pass 4: Checking reference counts
 Pass 5: Checking group summary information
-test_filesys: 11/64 files (0.0% non-contiguous), 13/100 blocks
+test_filesys: 11/64 files (0.0% non-contiguous), 15/100 blocks
 Exit status is 0
diff --git a/tests/f_mmp_garbage/expect.2 b/tests/f_mmp_garbage/expect.2
index 66300025..3bca182e 100644
--- a/tests/f_mmp_garbage/expect.2
+++ b/tests/f_mmp_garbage/expect.2
@@ -3,5 +3,5 @@ Pass 2: Checking directory structure
 Pass 3: Checking directory connectivity
 Pass 4: Checking reference counts
 Pass 5: Checking group summary information
-test_filesys: 11/64 files (0.0% non-contiguous), 13/100 blocks
+test_filesys: 11/64 files (0.0% non-contiguous), 15/100 blocks
 Exit status is 0
-- 
2.31.1

