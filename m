Return-Path: <linux-ext4+bounces-3759-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B49955AB8
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Aug 2024 06:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DFB81C20A91
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Aug 2024 04:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902EB9460;
	Sun, 18 Aug 2024 04:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAlM6Mvz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4FD8BE5
	for <linux-ext4@vger.kernel.org>; Sun, 18 Aug 2024 04:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723953858; cv=none; b=RD0yAv7LIlQdWReO9TzMEKm6hlX8XX864TyfIYlJOU/l+7Q26Rp6W8Hf0S7FW7FP7Ln4YhdZ6Qq9jwJ21MOXTIiVdXsSXpi432SJQVrwJBy4b3pefiidWD48RgZs7KzM7xhHDzzDukNeVvm3eD8VaN4qrxD9EwsrQra/7LTkUI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723953858; c=relaxed/simple;
	bh=keUmB73OqrvqgI/YLp0vWuA123ESl77X3nmxJJaOQ5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzrVn9HzKV3WlID51lzumk+gwkwvjaEDYb9/EhK97mvW41bsry6IXz3f+JxLco1+lTid3mpAWU6dh97vWirGX0nJUiTqcnPPDLK5KEy5zZO0r/YCYDep7zhL2/Kr7C3OdjAr/KmC7wRGBlaXIMUFKyk0PshUmpXvAirxuYUkz1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAlM6Mvz; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2021537a8e6so13863075ad.2
        for <linux-ext4@vger.kernel.org>; Sat, 17 Aug 2024 21:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723953855; x=1724558655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJUWWK3qjk5q1eAnY1JhFI02ekIayJlqPMQ2fM/3O2A=;
        b=fAlM6MvzTbGcOLS98BPVRIhYI4NPwxTzS8nWlvEZIXoTu/MhzzCuZ6l6R7eg8X58En
         sqv0KcvGcBz3tJA436NcupsnbaUqhUc0beFlZBdm8bMWgFvTLSdu8JaHaMrm/99dgL7i
         wg6WGzmQGEexWvtNTHTZ5up3OU42gCVjOW06+9OgU0xi3BMPEHcTntBgCUMNX1mqOf8M
         DPx7CBUNZFqsRvhrSbYnrYE3ZG7Em6Fer/XHs2QZOzk9rsb6D7LxzY6EwGH03Nb+dyd2
         reQLLeF0VG8+WdCwB+UC0K8G0S6PsYuhp0ubgziYA4QSx2UsUMUM4t/BtIkRuUgOAWvh
         Klpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723953855; x=1724558655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJUWWK3qjk5q1eAnY1JhFI02ekIayJlqPMQ2fM/3O2A=;
        b=jmjUh/u1cmvQYDisl+ZAhVpGND0WFcTsJDPfbzTpLSGuCcd487XjHlSNk5TxUfJB6P
         nS0rIxfGyKKWW+gRJyAhiel2d3jItWDfjiV7FHx9UUQ6ce1z80oL7oqBPXrsCGm3AgFU
         tiWR+qw2p5424UVQhitD+R6aJrF2zbLyx573yzHEeYjTFABVLa2uIpm4BKeDtR1wRGMn
         3FJxxpAdEz2O0AKqvTdYXQtP1YDUvcCAr9gDCWqq+GKfQHKQ35RB82mqI1Kqm3R4fHIe
         RjY1xAv0rWlLdJsKW5OApUY5KJeoz57uW0yf4fUh22CcNHHVdyGJr2h5sE3FB2+tUqW+
         h1Dg==
X-Gm-Message-State: AOJu0YxoGA4bnZpOh2STZJxdQl+F72aTaacIby9wPCVpWQ9cc66QYb9x
	vXNlwT7xToaZez6QXGs79ytQtsicVYcT6BkC4nkQTYOXts98WJyzr4HB7S1U
X-Google-Smtp-Source: AGHT+IGzx/jKRGwMtau/pZ2ZgDKI53nFpKNUcg+Tn5HIGRjWR9e88heetOhES1SgGlD+01GXHtyJFQ==
X-Received: by 2002:a17:902:dacc:b0:201:fd3c:a321 with SMTP id d9443c01a7336-2020404a405mr88877685ad.62.1723953855133;
        Sat, 17 Aug 2024 21:04:15 -0700 (PDT)
Received: from harshads.c.googlers.com.com (27.179.83.34.bc.googleusercontent.com. [34.83.179.27])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201f0375649sm45138235ad.124.2024.08.17.21.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 21:04:14 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.cz,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v7 0/9] Ext4 Fast Commit Performance Patchset
Date: Sun, 18 Aug 2024 04:03:47 +0000
Message-ID: <20240818040356.241684-2-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
In-Reply-To: <20240818040356.241684-1-harshadshirwadkar@gmail.com>
References: <20240818040356.241684-1-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

V7 Cover Letter
---------------

This is the V7 of the patch series. This patch series contains fixes to
review comments by Jan Kara (<jack@suse.cz>). The main changes are as
follows:

- As discussed in V6 review, I have dropped "ext4: add nolock mode to
  ext4_map_blocks()" patch given that we now ensure that i_data_sem is
  always grabbed before ext4_mark_inode_dirty() is called.

- I have also dropped "ext4: introduce selective flushing in fast commit"
  given that correctly implementing that would require more changes, and I
  think they would be best done outside of this series.

- I added "ext4: introduce selective flushing in fast commit" as the last
  patch in the series. While testing log group tests I found a few failures
  which get fixed due to this patch.

V6 Cover Letter
---------------

This is the V6 of the patch series. This patch series contains fixes to a
bunch of kernel build warnings reported by Kernel Test Robot
(lkp@intel.com) and Dan Carpenter (dan.carpenter@linaro.org). Thank you!

V5 Cover Letter
---------------

This patch series supersedes the patch series "ext4: remove journal barrier
during fast commit" sent in July 2022[1].  Except following three patches
all the other patches are newly introduced in this series.

* ext4: convert i_fc_lock to spinlock
* ext4: for committing inode, make ext4_fc_track_inode wait
* ext4: drop i_fc_updates from inode fc info

This patchset does not introduce any on-disk format and / or user visible
API change. This patchset reworks fast-commit's commit path improve overall
performance of the commit path. Following optimizations have been added in
this series:

* Avoid having to lock the journal throughout the fast commit.
* Remove tracking of open handles per inode.
* Avoid issuing cache flushes when fast commits are contained within a
  single FUA writes and there is no data that needs flushing.
* Temporarily lift committing thread's priority to match that of the
  journal thread to reduce scheduling delays.

With the changes introduced in this patch series, now the commit path for
fast commits is as follows:

1. Lock the journal by calling jbd2_journal_lock_updates_no_rsv(). This
   ensures that all the exsiting handles finish and no new handles can
   start.
2. Mark all the fast commit eligible inodes as undergoing fast commit by
   setting "EXT4_STATE_FC_COMMITTING" state.
3. Unlock the journal by calling jbd2_journal_unlock_updates. This allows
   starting of new handles. If new handles try to start an update on any of
   the inodes that are being committed, ext4_fc_track_inode() will block
   until those inodes have finished the fast commit.
4. Submit data buffers of all the committing inodes.
5. Wait for [4] to complete.
6. Commit all the directory entry updates in the fast commit space.
7. Commit all the changed inodes in the fast commit space and clear
   "EXT4_STATE_FC_COMMITTING" for all the inodes.
8. Write tail tag to ensure atomicity of commits.

(The above flow has been documented in the code as well)

I verified that the patch series introduces no regressions in "log" groups
when "fast_commit" feature is enabled.

Also, we have a paper on fast commits in USENIX ATC 2024 this year which
should become available on the website[2] in a few months.

[1] https://lwn.net/Articles/902022/
[2] https://www.usenix.org/conference/atc24

Harshad Shirwadkar (9):
  ext4: convert i_fc_lock to spinlock
  ext4: for committing inode, make ext4_fc_track_inode wait
  ext4: mark inode dirty before grabbing i_data_sem in ext4_setattr
  ext4: rework fast commit commit path
  ext4: drop i_fc_updates from inode fc info
  ext4: update code documentation
  ext4: temporarily elevate commit thread priority
  ext4: make fast commit ineligible on ext4_reserve_inode_write failure
  ext4: hold s_fc_lock while during fast commit

 fs/ext4/ext4.h              |  18 +-
 fs/ext4/fast_commit.c       | 339 ++++++++++++++++++------------------
 fs/ext4/fast_commit.h       |   1 +
 fs/ext4/inline.c            |   3 +
 fs/ext4/inode.c             |  38 ++--
 fs/ext4/super.c             |   9 +-
 fs/jbd2/journal.c           |   2 -
 include/trace/events/ext4.h |   7 +-
 8 files changed, 214 insertions(+), 203 deletions(-)

-- 
2.46.0.184.g6999bdac58-goog


