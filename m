Return-Path: <linux-ext4+bounces-4976-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C619BEF7A
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2024 14:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C4141F239EB
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2024 13:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A8B1E0DBD;
	Wed,  6 Nov 2024 13:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="g2hBDhU6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9533189F5C;
	Wed,  6 Nov 2024 13:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730901160; cv=none; b=Pet3GcN0uRuL9uu1enWMLyc3SA2MOlXgkG628XQxVUXZwdS7GABHyXBxZJS8c0cfVTFT6gJ7mES9TxFBfIjcOjnC5LY8+YMF6wARrNztM0kRJH/nFT28/8qGmfh7O6MhWa5JimW1UDf5ynKBzwuJdot/XjZq9m/HRvgxf3rs/fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730901160; c=relaxed/simple;
	bh=GJYdckaeT8XFNWuJqGWFrQL3KCrqATkjDDoe4xVbAAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FJxP+aD9EWIV8Y2QktoTo3ocJGzbU/B2o9w0ECl1Vb4ap+uvQU7mHdHGkHJmo0mpxvnHuFhJJLESDLJa4WmmqDg+yEmalRcDt31ym0sku7rJk0stBg3zC/YAePtiDH7WFtjoJVp0QmQKKAt7QRdAohtIa+cB6Cx0aL0FjZAGctc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=g2hBDhU6; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1t8gSa-00085V-Cy; Wed, 06 Nov 2024 08:52:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
	references; bh=EKH9KN2ClLyRbOUM9coteRTjG0WGp2kon9aSbZ+MVTk=; b=g2hBDhU6GgpZSf
	kBX70j/Na4eE3lnomHlE517QOaKfMYPGjGCO/USCO6GhE5IP3ztyEv6CbEAT1FX2dK34Vl4pVV3wv
	nBprdnIjEB3SoZoWLVZ1pbpq4ZvBYvCttDLLx/MbqF+KpJpkXPxwC17T0GVNYAPcuIPwqkMMJ6cRl
	ICs/N6CEN/nFj9oHHFCDGlkddWU54kjTXaXMTIh73+6xy5g9wPCV6mBA5mZEkd4U0WM4scCLN5YI4
	JOW6QUZn46E7tLeMprXfTq2ZM7s1AWOQGjFV4x9ztcxixT46SpVE20Y6meyc/bKcxaj71xk/LAPXU
	a9U9CE21qQRzWBgenZgg==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lukas.skupinski@landisgyr.com,
	anton.reding@landisgyr.com,
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH 0/1] ext4: Prevent an infinite loop in the lazyinit thread.
Date: Wed,  6 Nov 2024 14:47:40 +0100
Message-ID: <20241106134741.26948-1-othacehe@gnu.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Under the following conditions, the lazyinit thread can reschedule itself
indefinitely without doing anything, consuming a large amount of the system
resources:

In the ext4_run_li_request function, a start_time timestamp is taken. Right
before elr->lr_timeout is computed, in the same function, the system clock is
updated in userspace, from the Unix Epoch to the current time. The
elr->lr_timeout takes a large value. The elr->lr_next_sched is then set to a
value far away in the future.

/*
 * Away from jiffies because of a time jump when computing
 * elr->lr_timeout.
 */
elr->lr_next_sched = jiffies + elr->lr_timeout;

Back, in the ext4_lazyinit_thread that called the ext4_run_li_request, the
following condition can be false:

// elr->lr_next_sched > next_wakeup
if (time_before(elr->lr_next_sched, next_wakeup))
        next_wakeup = elr->lr_next_sched;

so that next_wakeup is not updated. Assuming that next_wakeup was not updated
above and still has the MAX_JIFFY_OFFSET value, the following condition will
be true:

// next_wakeup == MAX_JIFFY_OFFSET
if ((time_after_eq(cur, next_wakeup)) ||
    (MAX_JIFFY_OFFSET == next_wakeup)) {
	cond_resched();
	continue;
}

causing us to process the li_request_list again. If we now have jiffies < 
elr->lr_next_sched, as we have already elr->lr_next_sched > next_wakeup, we
will just continue without updating next_wakeup,

// jiffies < elr->lr_next_sched && elr->lr_next_sched > next_wakeup
if (time_before(jiffies, elr->lr_next_sched)) {
	if (time_before(elr->lr_next_sched, next_wakeup))
		next_wakeup = elr->lr_next_sched;
	continue;
}

and again, we will call cond_resched because next_wakeup is not updated, and
we now have an infinite loop.

This was put into evidence with the following values:

jiffies = 4294938821
elr->lr_next_sched = 1966790060
next_wakeup = 1073741822 (MAX_JIFFY_OFFSET)

on an armv7 (32 bits) system, without an RTC, while updating the system clock
during the lazyinit thread is working.

Fix that by using ktime_get_ns insted of ktime_get_real_ns and by using a
boolean instead of MAX_JIFFY_OFFSET to determine whether the next_wakeup value
has been set.

Thanks,

Mathieu

Mathieu Othacehe (1):
  ext4: Prevent an infinite loop in the lazyinit thread.

 fs/ext4/super.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

-- 
2.46.0


