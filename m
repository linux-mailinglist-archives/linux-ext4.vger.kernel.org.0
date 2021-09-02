Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB17F3FEC8D
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Sep 2021 12:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbhIBK76 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Sep 2021 06:59:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28624 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231133AbhIBK75 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Sep 2021 06:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630580339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qXQlZgA6EHuDgWBBwsvp+ZfFFR8ceZAteJMJO5nKZ3M=;
        b=ElUNhZO5H/8JZIFRmMHPVVYouJ/4moQOYdJiTDWpRYJ+0fyqDEKAvgtymxcPKwQnS+gZvz
        zIPv9WwVrv+AuFkhbdt7qg/SHmPcCmTuo/qME7yV4vioP4Au0exO6xA0hNC4uoXmK47HVx
        IODp87bLYbDJKTVFVG7RajcFiXj2ghE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-NOOtwIGzOh-5wqGePuBWBA-1; Thu, 02 Sep 2021 06:58:57 -0400
X-MC-Unique: NOOtwIGzOh-5wqGePuBWBA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05E716D252;
        Thu,  2 Sep 2021 10:58:57 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5275076BF9;
        Thu,  2 Sep 2021 10:58:56 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH] tests: Add option to print diff output of failed tests
Date:   Thu,  2 Sep 2021 12:58:52 +0200
Message-Id: <20210902105852.72745-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add variable $PRINT_FAILED which when set will print the diff output of
a failed test.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 tests/test_one.in | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/test_one.in b/tests/test_one.in
index 5d7607ad..78499ad0 100644
--- a/tests/test_one.in
+++ b/tests/test_one.in
@@ -82,6 +82,10 @@ if [ $elapsed -gt 60 -a ! -f $test_dir/is_slow_test ]; then
 	echo "$test_name:  consider adding $test_dir/is_slow_test"
 fi
 
+if [ -n "$PRINT_FAILED" -a -f $test_name.failed ] ; then
+	cat $test_name.failed
+fi
+
 if [ "$SKIP_UNLINK" != "true" ] ; then
 	rm -f $TMPFILE
 fi
-- 
2.31.1

