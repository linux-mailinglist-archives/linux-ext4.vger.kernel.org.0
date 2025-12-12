Return-Path: <linux-ext4+bounces-12331-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD48CB9340
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 16:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B792306220A
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 15:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1D2299927;
	Fri, 12 Dec 2025 15:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RXyJ1oCB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A7E29ACD7
	for <linux-ext4@vger.kernel.org>; Fri, 12 Dec 2025 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765554461; cv=none; b=SlDA4weisnoNEhUGNHzxj/duQWhpL8grZzCtd/RyJk5w0O7mYIVlYOyHrrlZl4+dG/MqFho0agCDwrcg4STaivhqiksDcE/sHay3D60/8eBd5rDGZM+2uIXueQZVD1AKv173ijKBqOZ7duYNFXx3Roj7+e3IZLLl73/xKWawC6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765554461; c=relaxed/simple;
	bh=Tl9fDwdSX1ZNx+zZYYWYdg9nuoRoEGevkfneyuk4gP4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O6galqWQv620O04AYMtSADTJk9Wo/kfdsfyquNcdfqiOj24KKasf4WRZYR3QlH/ObSbfgKJ74JcjW6QjyIdZg2G/+/mYoKPSCZ8kiuZxMT6y2b+cmp8HzVSmnIsj3+MONpZ0a21zkLpTzybFnjh4L6Bh8dhxt6lHJzCPVvg4g5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RXyJ1oCB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765554458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3JnStAS5paEDe1MeaZq8TQObzSFFfOMj1TNkfUzBZI4=;
	b=RXyJ1oCBHHyWfnJDrifGrxuPVsxHu7cNa/u7vORbEYRYknGv8h0511YMXGhsvq/xuJNx8N
	beMBx0Nfn25A56l36O4zQVvw9TZLRQyVYSgIhF4pA/jQbd171gNSgDeUpgtNMPxdvgj74K
	+ALfEd0xPwHRUNuzvhdSxKumQOnFqQw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-444-pXt4KS9PPtaoWq5tQzzkuA-1; Fri,
 12 Dec 2025 10:47:37 -0500
X-MC-Unique: pXt4KS9PPtaoWq5tQzzkuA-1
X-Mimecast-MFC-AGG-ID: pXt4KS9PPtaoWq5tQzzkuA_1765554456
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1061195FCF0
	for <linux-ext4@vger.kernel.org>; Fri, 12 Dec 2025 15:47:36 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.64.2])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 510B9195398A
	for <linux-ext4@vger.kernel.org>; Fri, 12 Dec 2025 15:47:36 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
To: linux-ext4@vger.kernel.org
Subject: [PATCH] ext4: fix dirtyclusters double decrement on fs shutdown
Date: Fri, 12 Dec 2025 10:47:35 -0500
Message-ID: <20251212154735.512651-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

fstests test generic/388 occasionally reproduces a warning in
ext4_put_super() associated with the dirty clusters count:

  WARNING: CPU: 7 PID: 76064 at fs/ext4/super.c:1324 ext4_put_super+0x48c/0x590 [ext4]

Tracing the failure shows that the warning fires due to an
s_dirtyclusters_counter value of -1. IOW, this appears to be a
spurious decrement as opposed to some sort of leak. Further tracing
of the dirty cluster count deltas and an LLM scan of the resulting
output identified the cause as a double decrement in the error path
between ext4_mb_mark_diskspace_used() and the caller
ext4_mb_new_blocks().

First, note that generic/388 is a shutdown vs. fsstress test and so
produces a random set of operations and shutdown injections. In the
problematic case, the shutdown triggers an error return from the
ext4_handle_dirty_metadata() call(s) made from
ext4_mb_mark_context(). The changed value is non-zero at this point,
so ext4_mb_mark_diskspace_used() does not exit after the error
bubbles up from ext4_mb_mark_context(). Instead, the former
decrements both cluster counters and returns the error up to
ext4_mb_new_blocks(). The latter falls into the !ar->len out path
which decrements the dirty clusters counter a second time, creating
the inconsistency.

AFAICT the solution here is to exit immediately from
ext4_mb_mark_diskspace_used() on error, regardless of the changed
value. This leaves the caller responsible for clearing the block
reservation at the same level it is acquired. This also skips the
free clusters update, but the caller also calls into
ext4_discard_allocated_blocks() to free the blocks back into the
group. This survives an overnight loop test of generic/388 on an
otherwise reproducing system and survives a local regression run.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---

Hi all,

I've thrown some testing at this and poked around the area enough that I
_think_ it is reasonably sane, but the error paths are hairy and I could
certainly be missing some details. I'm happy to try a different approach
if there are any thoughts around that.. thanks.

Brian

 fs/ext4/mballoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 56d50fd3310b..224abfd6a42b 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4234,7 +4234,7 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
 				   ac->ac_b_ex.fe_start, ac->ac_b_ex.fe_len,
 				   flags, &changed);
 
-	if (err && changed == 0)
+	if (err)
 		return err;
 
 #ifdef AGGRESSIVE_CHECK
-- 
2.51.1


