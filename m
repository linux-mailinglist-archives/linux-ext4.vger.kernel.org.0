Return-Path: <linux-ext4+bounces-11030-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAF1C04C5F
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Oct 2025 09:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0F344F1336
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Oct 2025 07:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E382E8B9D;
	Fri, 24 Oct 2025 07:40:00 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF67E2E8B6F;
	Fri, 24 Oct 2025 07:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291600; cv=none; b=UDPMhIzTIHO7pCjFKr63YugQoAF8HwBstm7uvCQe74bKzpidciurUpbJZMKKFJ1PSTXvcXNaGT5NZvdLed+g1fernvV4N+Ri0AMQmZrsRPvKvTtWyMHoi3ntHF/36aPPqbKLxurV5VwSoiIENW9DWkenMYKeRVqIUHHACVhYoEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291600; c=relaxed/simple;
	bh=7ZGDSNXtDC7CwvFhRYT74Xiitn6FfaLCgNlwhpZEZ10=;
	h=From:To:Cc:Subject:Date:Message-Id; b=PHKU9xkn+VYJwzj9oGtNNho8wo0shNMiXfcAOPbeAdmNwneZ/KxAxBhc072IKXTRGD29sutmOiznlB//+LDYmh0YwoHS0mB5yQgy9dZkopQ317rMtEWUdygAIAjp1+RhPhRerRdigKwIIn3ZjAZGWLIwbHayZRDUG+/zMDe4ZEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-d0-68fb2d470470
From: Byungchul Park <byungchul@sk.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: kernel_team@skhynix.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs/jbd2: use a weaker annotation in journal handling
Date: Fri, 24 Oct 2025 16:39:40 +0900
Message-Id: <20251024073940.1063-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHJMWRmVeSWpSXmKPExsXC9ZZnoa677u8Mg0NzhC2eL1/MaDFz3h02
	i8u75rBZtPb8ZHdg8Wg6c5TZY/2WqywenzfJBTBHcdmkpOZklqUW6dslcGXsb3vHWLCct2LD
	8Ta2BsYm7i5GTg4JAROJQ+fnsMHYn38tYgGx2QTUJW7c+MkMYosIKEn8udTM2MXIwcEsECnx
	97QNSFhYwFVi0tVNYCUsAqoSpzpugI3hBRozcf5HJoiR8hKrNxwAquECsrexSkzY/5kRIiEp
	cXDFDZYJjNwLGBlWMQpl5pXlJmbmmOhlVOZlVugl5+duYgT6elntn+gdjJ8uBB9iFOBgVOLh
	PSH/K0OINbGsuDL3EKMEB7OSCG9Z5I8MId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxG38pThATS
	E0tSs1NTC1KLYLJMHJxSDYythS03jj/luyS8u5Jtl//G9Z+2G/POid7w586fL/tur44N/eDM
	bjmpNLxDalk7b5HU8sDkrd+lbsbyXy/fMfVI/Nu0P+9ydWe0S319VPPSnPOH497C2z/WJeuw
	Ny40SmgwLzi2wkZlf4vk6yVzzyQFPlt405azIbgz0besxjdy/+vSO3ZRMT5KLMUZiYZazEXF
	iQCcNiEJ8QEAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKJMWRmVeSWpSXmKPExsXC5WfdrOuu+zvD4OhsTovnyxczWhyee5LV
	Yua8O2wWl3fNYbNo7fnJ7sDq0XTmKLPH4hcfmDzWb7nK4vF5k1wASxSXTUpqTmZZapG+XQJX
	xv62d4wFy3krNhxvY2tgbOLuYuTkkBAwkfj8axELiM0moC5x48ZPZhBbREBJ4s+lZsYuRg4O
	ZoFIib+nbUDCwgKuEpOubgIrYRFQlTjVcYMNxOYFGjNx/kcmiJHyEqs3HGCewMixgJFhFaNI
	Zl5ZbmJmjqlecXZGZV5mhV5yfu4mRqDnltX+mbiD8ctl90OMAhyMSjy8ByR+ZQixJpYVV+Ye
	YpTgYFYS4S2L/JEhxJuSWFmVWpQfX1Sak1p8iFGag0VJnNcrPDVBSCA9sSQ1OzW1ILUIJsvE
	wSnVwLh08z4J08KO5X+yt3EK7Qz/fkKXTWVftv3EiuzDxkpsntaWrXuf/zbNNpp3QzHsnJuw
	y61DHw2KTVstTJY9mKTJdyY2ufDDydc5OoWbT56rvnx+3jmmANE9a6KtVy9dFjz53sfvf1Zw
	vvm0QuVU4ZQYWUnhLw6dGb3NJf63+Vwu7V7ZWszpv0GJpTgj0VCLuag4EQALa91n2AEAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

jbd2 journal handling code doesn't want jbd2_might_wait_for_commit()
to be placed between start_this_handle() and stop_this_handle().  So it
marks the region with rwsem_acquire_read() and rwsem_release().

However, the annotation is too strong for that purpose.  We don't have
to use more than try lock annotation for that.

rwsem_acquire_read() implies:

   1. might be a waiter on contention of the lock.
   2. enter to the critical section of the lock.

All we need in here is to act 2, not 1.  So trylock version of
annotation is sufficient for that purpose.  Now that dept partially
relies on lockdep annotaions, dept interpets rwsem_acquire_read() as a
potential wait and might report a deadlock by the wait.

Replace it with trylock version of annotation.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
Hi,

I found this issue during DEPT development but it's still favorable in
any case for more precise annotation.

	Byungchul
---
 fs/jbd2/transaction.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index c7867139af69..b4e65f51bf5e 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -441,7 +441,7 @@ static int start_this_handle(journal_t *journal, handle_t *handle,
 	read_unlock(&journal->j_state_lock);
 	current->journal_info = handle;
 
-	rwsem_acquire_read(&journal->j_trans_commit_map, 0, 0, _THIS_IP_);
+	rwsem_acquire_read(&journal->j_trans_commit_map, 0, 1, _THIS_IP_);
 	jbd2_journal_free_transaction(new_transaction);
 	/*
 	 * Ensure that no allocations done while the transaction is open are
-- 
2.17.1


