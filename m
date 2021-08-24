Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4403F5DAE
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Aug 2021 14:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236983AbhHXMLN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Aug 2021 08:11:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22721 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237131AbhHXMLM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 24 Aug 2021 08:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629807028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ffoqJmw2CTvKATx+x1QbM7NagBCQvJ2wGH+0gT3Qxac=;
        b=G3fuSY/saAyCOA3g+zR68bNr7SFsQtD52/qfkQ+mamWbsNsXoZ3ru2iKLNHCuKhnNds6Kq
        tD+vUvcJuO8fpOqd23atqSNGGOiAcw18CE+KFtZ4sx/DV6xSUYeIn9xjctVB8j6Ekqe27B
        abHE5F+LrXMyWkyfZTCsVb8oN4froPE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-GpxVLUNJNBCHJqyYhQ00jQ-1; Tue, 24 Aug 2021 08:10:27 -0400
X-MC-Unique: GpxVLUNJNBCHJqyYhQ00jQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10C62871807;
        Tue, 24 Aug 2021 12:10:26 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.0])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4829760C25;
        Tue, 24 Aug 2021 12:10:25 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH 2/2] tests: update expect files for f_large_dir and f_large_dir_csum
Date:   Tue, 24 Aug 2021 14:10:20 +0200
Message-Id: <20210824121020.143449-2-lczerner@redhat.com>
In-Reply-To: <20210824121020.143449-1-lczerner@redhat.com>
References: <20210824121020.143449-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Update expect files for f_large_dir and f_large_dir_csum tests to
include the warning about missing y2038 support with 128-byte inodes.

Fixes: a23b50cd ("mke2fs: warn about missing y2038 support when formatting fresh ext4 fs")
Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 tests/f_large_dir/expect      | 1 +
 tests/f_large_dir_csum/expect | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/f_large_dir/expect b/tests/f_large_dir/expect
index 028234cc..495ea85d 100644
--- a/tests/f_large_dir/expect
+++ b/tests/f_large_dir/expect
@@ -1,3 +1,4 @@
+128-byte inodes cannot handle dates beyond 2038 and are deprecated
 Creating filesystem with 108341 1k blocks and 65072 inodes
 Superblock backups stored on blocks: 
 	8193, 24577, 40961, 57345, 73729
diff --git a/tests/f_large_dir_csum/expect b/tests/f_large_dir_csum/expect
index aa9f33f1..44770f7b 100644
--- a/tests/f_large_dir_csum/expect
+++ b/tests/f_large_dir_csum/expect
@@ -1,3 +1,4 @@
+128-byte inodes cannot handle dates beyond 2038 and are deprecated
 Creating filesystem with 31002 1k blocks and 64 inodes
 Superblock backups stored on blocks: 
 	8193, 24577
-- 
2.31.1

