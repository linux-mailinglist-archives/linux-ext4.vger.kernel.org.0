Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C017E1FC9CA
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Jun 2020 11:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgFQJZ5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 17 Jun 2020 05:25:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41117 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725536AbgFQJZ5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 17 Jun 2020 05:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592385956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5hWn7MRCR6o1uAcvBFYKXKNlYUtbdpN0vJxOt1YsMyM=;
        b=d2FVYQJG3t6JXxAagyWU9dmyqr7PHr7UJqJiZrcSvt7IM6l4Vpfm2OwrGn23aUF5S2Z1Jh
        og0aJyy6mRNY3ub46tIq4j1zZ6bKIHqn6LnNt31ZfAXflOOsfBSzjfUo/DvC4bSmGVW7jL
        A83uCQ6WvheqCpDBmt0gKkI8VAZ+Mds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-tZry2wIvPHCDP5Xg9En84Q-1; Wed, 17 Jun 2020 05:25:52 -0400
X-MC-Unique: tZry2wIvPHCDP5Xg9En84Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B666A2210A1;
        Wed, 17 Jun 2020 09:25:51 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.195.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 011DE7CABA;
        Wed, 17 Jun 2020 09:25:50 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.com>
Subject: [PATCH v2] jbd2: make sure jh have b_transaction set in refile/unfile_buffer
Date:   Wed, 17 Jun 2020 11:25:49 +0200
Message-Id: <20200617092549.6712-1-lczerner@redhat.com>
In-Reply-To: <20200617091031.6558-1-lczerner@redhat.com>
References: <20200617091031.6558-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Callers of __jbd2_journal_unfile_buffer() and
__jbd2_journal_refile_buffer() assume that the b_transaction is set. In
fact if it's not, we can end up with journal_head refcounting errors
leading to crash much later that might be very hard to track down. Add
asserts to make sure that is the case.

We also make sure that b_next_transaction is NULL in
__jbd2_journal_unfile_buffer() since the callers expect that as well and
we should not get into that stage in this state anyway, leading to
problems later on if we do.

Tested with fstests.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
v2: Fix subject line s/unlink/unfile/

 fs/jbd2/transaction.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index e91aad3637a2..e65e0aca2826 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2026,6 +2026,9 @@ static void __jbd2_journal_temp_unlink_buffer(struct journal_head *jh)
  */
 static void __jbd2_journal_unfile_buffer(struct journal_head *jh)
 {
+	J_ASSERT_JH(jh, jh->b_transaction != NULL);
+	J_ASSERT_JH(jh, jh->b_next_transaction == NULL);
+
 	__jbd2_journal_temp_unlink_buffer(jh);
 	jh->b_transaction = NULL;
 }
@@ -2572,6 +2575,13 @@ bool __jbd2_journal_refile_buffer(struct journal_head *jh)
 
 	was_dirty = test_clear_buffer_jbddirty(bh);
 	__jbd2_journal_temp_unlink_buffer(jh);
+
+	/*
+	 * b_transaction must be set, otherwise the new b_transaction won't
+	 * be holding jh reference
+	 */
+	J_ASSERT_JH(jh, jh->b_transaction != NULL);
+
 	/*
 	 * We set b_transaction here because b_next_transaction will inherit
 	 * our jh reference and thus __jbd2_journal_file_buffer() must not
-- 
2.21.3

