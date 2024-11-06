Return-Path: <linux-ext4+bounces-4977-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C079BEF7C
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2024 14:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FF871F23B44
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2024 13:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6BB201021;
	Wed,  6 Nov 2024 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="Wn3UOhjc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2801DEFD7;
	Wed,  6 Nov 2024 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730901161; cv=none; b=NxlpWnVEoudr5p41xSx+oUgplxyK69Ne7RnQ5Sh7WYn2a6CcrWjy9AI/WHzqbod7F58QlS2T241muDjF4SKa2o/e2r4Z+ImY5sH4uNPnh5zpmhix16zXEljHwW1I5l5J2TupnN6G5xbReVcbZZNrS/pyTovTed7l0B4aN50vP/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730901161; c=relaxed/simple;
	bh=hsDm8riYcjMPE60i/Lbnnj638ErPNKlm74Hu/6HiOzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CdniPRnNNoTaHUhVYR123eCVSaKK2RPfTkDdF0SDr+7dG2IUCfKQe2qte8QOeoCjJHZya1UZPK/RiC7mF4mdYdfZmX8sisE1Tc4iCKArHBmsLMtwUq1PbnfcWqDklLQiUhq5chsABGEDnd81yH7I28u1ad+dr1S7Ow4lgHKWmvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=Wn3UOhjc; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1t8gSd-00085t-3a; Wed, 06 Nov 2024 08:52:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:Subject:To:
	From; bh=dqWk5AJnz/jo2LVdopcpW+APPxryZDyUyYYPqJnsvak=; b=Wn3UOhjcEtqc8xPOrQNL
	WRJmkQRPABAVJo1smeE6jLie6Utn+UGteNKoGFYMv/bwpXJqcWWcDvdnsTqgAr/fIwKyiVNP0Ptk+
	IaanfYQDDsVGMRQgsRVCZE+WryRfY53qwbzeg6GiaIS69fDYOgvxp95vDdTawhLTygWwei+I/feiU
	qsmq9MGlad0VeVRPtu4B+S8CtGD5mfwaMVA9UPjdn6hXlOOl1OlkVby6cVzWRNe51uyOTzn4QJ79L
	UvQk82NZw3PlKn0PDenq4In3nwKEFNOou5kz1POAoAw7Okbq6dmpYM5Z3wnvIn7NCXaKFg52leuio
	xa3Mqxt+eNWPXQ==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lukas.skupinski@landisgyr.com,
	anton.reding@landisgyr.com,
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH 1/1] ext4: Prevent an infinite loop in the lazyinit thread.
Date: Wed,  6 Nov 2024 14:47:41 +0100
Message-ID: <20241106134741.26948-2-othacehe@gnu.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241106134741.26948-1-othacehe@gnu.org>
References: <20241106134741.26948-1-othacehe@gnu.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use ktime_get_ns instead of ktime_get_real_ns when computing the lr_timeout
not to be affected by system time jumps.

Use a boolean instead of the MAX_JIFFY_OFFSET value to determine whether
the next_wakeup value has been set. Comparing elr->lr_next_sched to
MAX_JIFFY_OFFSET can cause the lazyinit thread to loop indefinitely.

Co-developed-by: Lukas Skupinski <lukas.skupinski@landisgyr.com>
Signed-off-by: Lukas Skupinski <lukas.skupinski@landisgyr.com>
Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 fs/ext4/super.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 9fcf44064c6a6..b4839ccd83ad5 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3712,12 +3712,12 @@ static int ext4_run_li_request(struct ext4_li_request *elr)
 		ret = 1;
 
 	if (!ret) {
-		start_time = ktime_get_real_ns();
+		start_time = ktime_get_ns();
 		ret = ext4_init_inode_table(sb, group,
 					    elr->lr_timeout ? 0 : 1);
 		trace_ext4_lazy_itable_init(sb, group);
 		if (elr->lr_timeout == 0) {
-			elr->lr_timeout = nsecs_to_jiffies((ktime_get_real_ns() - start_time) *
+			elr->lr_timeout = nsecs_to_jiffies((ktime_get_ns() - start_time) *
 				EXT4_SB(elr->lr_super)->s_li_wait_mult);
 		}
 		elr->lr_next_sched = jiffies + elr->lr_timeout;
@@ -3777,8 +3777,9 @@ static int ext4_lazyinit_thread(void *arg)
 
 cont_thread:
 	while (true) {
-		next_wakeup = MAX_JIFFY_OFFSET;
+		bool next_wakeup_initialized = false;
 
+		next_wakeup = 0;
 		mutex_lock(&eli->li_list_mtx);
 		if (list_empty(&eli->li_request_list)) {
 			mutex_unlock(&eli->li_list_mtx);
@@ -3791,8 +3792,11 @@ static int ext4_lazyinit_thread(void *arg)
 					 lr_request);
 
 			if (time_before(jiffies, elr->lr_next_sched)) {
-				if (time_before(elr->lr_next_sched, next_wakeup))
+				if (!next_wakeup_initialized ||
+				    time_before(elr->lr_next_sched, next_wakeup)) {
 					next_wakeup = elr->lr_next_sched;
+					next_wakeup_initialized = true;
+				}
 				continue;
 			}
 			if (down_read_trylock(&elr->lr_super->s_umount)) {
@@ -3820,16 +3824,18 @@ static int ext4_lazyinit_thread(void *arg)
 				elr->lr_next_sched = jiffies +
 					get_random_u32_below(EXT4_DEF_LI_MAX_START_DELAY * HZ);
 			}
-			if (time_before(elr->lr_next_sched, next_wakeup))
+			if (!next_wakeup_initialized ||
+			    time_before(elr->lr_next_sched, next_wakeup)) {
 				next_wakeup = elr->lr_next_sched;
+				next_wakeup_initialized = true;
+			}
 		}
 		mutex_unlock(&eli->li_list_mtx);
 
 		try_to_freeze();
 
 		cur = jiffies;
-		if ((time_after_eq(cur, next_wakeup)) ||
-		    (MAX_JIFFY_OFFSET == next_wakeup)) {
+		if (!next_wakeup_initialized || time_after_eq(cur, next_wakeup)) {
 			cond_resched();
 			continue;
 		}
-- 
2.46.0


