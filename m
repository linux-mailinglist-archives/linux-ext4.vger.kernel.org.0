Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304471F41E5
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jun 2020 19:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbgFIROY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Jun 2020 13:14:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49053 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727021AbgFIROX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Jun 2020 13:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591722862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=QMyFhku3rGzuZoalxANSGbyqeBynKYN/URvK4ZCOZOE=;
        b=eKdC4+wRxIK4oa/uFGRl+w1GLfFaN/v44m/g3eTvO6VUzJhVZErZ/SeSUqG+PQwWocPcAX
        twx0/dwZ5xlQHxEyH842pEvuihQHH/F5+96ywdTsINh9LqwZvDn+K0jHjf1Wvh8fD0ncSi
        aWaOQ58Cpbw5559H5dSEfFddSW8077Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-dFYh4qi_O8WKGaR5QuSwlg-1; Tue, 09 Jun 2020 13:14:20 -0400
X-MC-Unique: dFYh4qi_O8WKGaR5QuSwlg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7476A800053;
        Tue,  9 Jun 2020 17:14:19 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 448F01001281;
        Tue,  9 Jun 2020 17:14:19 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 059HEIoY031800;
        Tue, 9 Jun 2020 13:14:18 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 059HEIHm031797;
        Tue, 9 Jun 2020 13:14:18 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 9 Jun 2020 13:14:18 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>
cc:     linux-ext4@vger.kernel.org
Subject: [PATCH] ext2: fix missing percpu_counter_inc (fwd)
Message-ID: <alpine.LRH.2.02.2006091312530.31685@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I'm resending this because I didn't get any response.

Mikulas



---------- Forwarded message ----------
Date: Mon, 20 Apr 2020 16:02:21 -0400 (EDT)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Jan Kara <jack@suse.com>
Cc: linux-ext4@vger.kernel.org
Subject: [PATCH] ext2: fix missing percpu_counter_inc

sbi->s_freeinodes_counter is only decreased by the ext2 code, it is never
increased. This patch fixes it.

Note that sbi->s_freeinodes_counter is only used in the algorithm that
tries to find the group for new allocations, so this bug is not easily
visible (the only visibility is that the group finding algorithm selects
inoptinal result).

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 fs/ext2/ialloc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6/fs/ext2/ialloc.c
===================================================================
--- linux-2.6.orig/fs/ext2/ialloc.c	2019-09-20 14:39:07.951999000 +0200
+++ linux-2.6/fs/ext2/ialloc.c	2020-04-20 21:33:26.389999000 +0200
@@ -80,6 +80,7 @@ static void ext2_release_inode(struct su
 	if (dir)
 		le16_add_cpu(&desc->bg_used_dirs_count, -1);
 	spin_unlock(sb_bgl_lock(EXT2_SB(sb), group));
+	percpu_counter_inc(&EXT2_SB(sb)->s_freeinodes_counter);
 	if (dir)
 		percpu_counter_dec(&EXT2_SB(sb)->s_dirs_counter);
 	mark_buffer_dirty(bh);
@@ -528,7 +529,7 @@ got:
 		goto fail;
 	}
 
-	percpu_counter_add(&sbi->s_freeinodes_counter, -1);
+	percpu_counter_dec(&sbi->s_freeinodes_counter);
 	if (S_ISDIR(mode))
 		percpu_counter_inc(&sbi->s_dirs_counter);
 

