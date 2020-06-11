Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449501F63A8
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jun 2020 10:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgFKIe2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Jun 2020 04:34:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59044 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726651AbgFKIe2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 Jun 2020 04:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591864467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=tYt8wIp47TLS9JNkJcULGEMZvCJIk4AdRW5F88VoPg8=;
        b=SUsGHA5Vs0jHz86MROjdIqR6x0Y3xRz7xv54UFUR4YuAYkA0CMOK8B8vWeTwMzwutZKT8V
        wD7/JDcjaVywXmsqRJfC3PRrET5C0uIO1h8ItDceKSTKx7dhvLzJieLozDYbuZIRSVFPgj
        8l3LA2kJNOr7jfwA/PsaCld3ZUTwTNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-RGKLhJ9MMtyUmtS-rWhnmA-1; Thu, 11 Jun 2020 04:34:25 -0400
X-MC-Unique: RGKLhJ9MMtyUmtS-rWhnmA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27D2F464;
        Thu, 11 Jun 2020 08:34:23 +0000 (UTC)
Received: from work (unknown [10.40.192.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E25819D61;
        Thu, 11 Jun 2020 08:34:22 +0000 (UTC)
Date:   Thu, 11 Jun 2020 10:34:17 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: jbd2: can b_transaction be NULL in refile_buffer ?
Message-ID: <20200611083417.4akdykeubd7kfuuh@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

I am tracking a rare and very hard to reproduce bug that ends up hittng

J_ASSERT_JH(jh, jh->b_transaction == NULL)

in __journal_remove_journal_head(). In fact we can get there with
b_next_transaction set and b_jlist == BJ_Forget so it's clear that we
should not have dropped the last JH reference at that point.

Most of the time that I've seen we get there from
__jbd2_journal_remove_checkpoint() called from
jbd2_journal_commit_transaction().

The locking in and around grabbing and putting the journal head
reference (b_jcount) looks solid as well as the use of j_list_lock. But
I have noticed a problem in logic of __jbd2_journal_refile_buffer().

The idea is that b_next_transaction will inherit the reference from
b_transaction so that we do not need to grab a new reference of
journal_head. However this will only be true if b_transaction is set.
But if it is indeed NULL, then we will do

WRITE_ONCE(jh->b_transaction, jh->b_next_transaction);

and __jbd2_journal_file_buffer() will not grab the jh reference. AFAICT
the b_next_transaction is not holding it's own jh reference. This will
result in b_transaction _not_ holding it's own jh reference and we will
be able to drop the last jh reference at unexpected places - hence we can
hit the asserts in __journal_remove_journal_head().

However I am not really sure if it is indeed possible to get into
__jbd2_journal_refile_buffer() with b_transaction == NULL and
b_next_transaction set. Jan do you have any idea if that's possible and
what would be the circumstances to lead us there ?


Regardless I still think this is a bug in the logic and we should either
make sure that b_transaction is _not_ NULL in
__jbd2_journal_refile_buffer(), or let __jbd2_journal_file_buffer() grab
the jh reference if b_transaction was indeen NULL. How about something
like the following untested patch ?

Thanks!
-Lukas

-- 

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index e91aad3637a2..55e5cb6b4bb5 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2498,7 +2498,7 @@ void __jbd2_journal_file_buffer(struct journal_head *jh,
                __jbd2_journal_temp_unlink_buffer(jh);
        else
                jbd2_journal_grab_journal_head(bh);
-       jh->b_transaction = transaction;
+       WRITE_ONCE(jh->b_transaction, transaction);

        switch (jlist) {
        case BJ_None:
@@ -2577,15 +2577,14 @@ bool __jbd2_journal_refile_buffer(struct journal_head *jh)
         * our jh reference and thus __jbd2_journal_file_buffer() must not
         * take a new one.
         */
-       WRITE_ONCE(jh->b_transaction, jh->b_next_transaction);
-       WRITE_ONCE(jh->b_next_transaction, NULL);
        if (buffer_freed(bh))
                jlist = BJ_Forget;
        else if (jh->b_modified)
                jlist = BJ_Metadata;
        else
                jlist = BJ_Reserved;
-       __jbd2_journal_file_buffer(jh, jh->b_transaction, jlist);
+       __jbd2_journal_file_buffer(jh, jh->b_next_transaction, jlist);
+       WRITE_ONCE(jh->b_next_transaction, NULL);
        J_ASSERT_JH(jh, jh->b_transaction->t_state == T_RUNNING);

        if (was_dirty)
(END)

