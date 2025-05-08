Return-Path: <linux-ext4+bounces-7768-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E039AB01EF
	for <lists+linux-ext4@lfdr.de>; Thu,  8 May 2025 19:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621463AB5DD
	for <lists+linux-ext4@lfdr.de>; Thu,  8 May 2025 17:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDB3286D46;
	Thu,  8 May 2025 17:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c09Cz5eR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0751E3DE8
	for <linux-ext4@vger.kernel.org>; Thu,  8 May 2025 17:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746727175; cv=none; b=EZmchhbcfl8Sg+ZbV6RzzW4liZFTuh5crIObOs9eU0KzkbkNHZKbdv8ZxInZfZmKrmKSxsdpm1Xnr3ko0WqvhyGGtUUfHNf5IHkA15V24qRoKaLsvEev5hTaKpy4Sg/bZDlBs55m7uKQtn0MOJP0b/+UnXlj/nbPVg6wnkdrnCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746727175; c=relaxed/simple;
	bh=w1JOZ9lmcbk7cIpwI54cfvdwfHn04J4SVblOyRwvibo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MfPz8CC9thMeNR9RgTn+34DBqeC/xLl7vtIT5kJJp7R0RjjVl8fSmqnPs+aJIxP5PNLZk9bIy6XEuo+e9Yj8AyeUlmdN+D+nIN6r+G53o41FrfPl4iYMioCtVfAXdoh89wSp4yFoUSbqNHq6AYqQJtdlUzG/ixPRGQm6y2mGtvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c09Cz5eR; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7415d28381dso721753b3a.1
        for <linux-ext4@vger.kernel.org>; Thu, 08 May 2025 10:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746727172; x=1747331972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/haF0raaQpszTQOGZYcILfSZscOO9vS7K6pykG3wEQw=;
        b=c09Cz5eRUxzYu32FHra6ZJKeXhuc3MSiHAMGm+ANRB5cCMxB1+wBV3OyP3O7wqEGfF
         vVPy5dCduNl26SiRlMl0/c7kKfaR0zFB+2dpd4tp91oN1zyLrKhqhusOtKXLC08NU6RF
         hxTPJ6Ypsi87WzQFBUsuQqhUkdJe5BlPYuBPN9ShmPOGX2zrnM2grKePfswEIL4aZoSj
         ucHkhQX6VDNBFtpO0gk2EO5AigMYBfa/xrxm3icekqJtRP+ZPDLrvalvKvRPmXCAkcg8
         n5CzRnq0rIHB6kgoa01gipLLLsac8lzL42C7YgcxoMir5zqEIBcV8XlMNlOLBdVQ8F05
         M6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746727172; x=1747331972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/haF0raaQpszTQOGZYcILfSZscOO9vS7K6pykG3wEQw=;
        b=DsyNHLHe7kHgRnfwrhqJ2F/DykZ4pd9zKGxoVjk+s2xOhEApb6+uXgO2Z3/46hcbln
         J/olC/wLMdotI8aWJl/sLK5qLts38eB1oE+sj18q9Jt0ThT/rcPWrVzL1jCUpzS2B66d
         s26U60HgNXN53wtL6w+n37MqRnnQaegic/GAtuhE+r3M51kV2bF9Bu84CWTeSqh7LksV
         7+rQH8+VCO3YBrCKpahkpRel1j5lE9O7AXKnzI0MiG0a9kRdYO573/S/3FTCw5LTsNf+
         8Sm+65fOoUbzn6JCxQflpqJuZTMlnzgEoVZEEiZorxdP/ghddx4FsMnjsJDpXLLmcDii
         ukRw==
X-Gm-Message-State: AOJu0Yx4jC4e7EZmJhb68t8gDx5IilZTELfxjov8Sjd5bYcyHleJDxPG
	0qko6h18MF0sfiwQxKlsRMTKlAmr16y9XtBMGBnqQm/tlfqrom91dGGEp9E9iS8=
X-Gm-Gg: ASbGncsMIPJPzeAjHiteaw5G811vyvVe+rHq0es3op0fNl7XKP0VMTrxhemrHO9lRrH
	6UNV/JO0e27eXBGW/lJcAihsq51wRDCzSIUlYmTj5gZUCUtoyo8DH5zkEk+Sx5HNmr80/m0pr+q
	v4W8hGCDz9Tn8sIg+eaR7QjZmwMADfp+Teb13uicGWlSsJnVp/lD+rbu+vBEYLDRIGtJrWADavR
	/AmKsEi1E6NoujWM/VjbxL0obOKDmuhciN2/kMTaVDlCKMNmwu9EeJ1HJA783bqoJkWC+cnn91m
	L6TE/xrAVDo49I40AplhVFd/atAg5+WuNtRRPN9M2DRyGIFsC6PrDlaFwwa8v4Ku6I4pHwv1k2n
	xSe18yhqbnqdX4qvOx3NkI2UAjFku7pPfgJVV
X-Google-Smtp-Source: AGHT+IEAfvSjdCf3WVjIUEr25DJAPysO9LVWXgXYqVnkjmtdntLlLT/Syu4QH1dpAIv9Sk1SsKi0EA==
X-Received: by 2002:a17:903:32d1:b0:22e:6bb1:f717 with SMTP id d9443c01a7336-22fc918dcb4mr4381735ad.41.1746727172054;
        Thu, 08 May 2025 10:59:32 -0700 (PDT)
Received: from harshads.c.googlers.com.com (156.242.82.34.bc.googleusercontent.com. [34.82.242.156])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22fc828939asm2153535ad.164.2025.05.08.10.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 10:59:31 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.cz,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v9 0/9] Ext4 fast commit performance patchset
Date: Thu,  8 May 2025 17:58:59 +0000
Message-ID: <20250508175908.1004880-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

V9 Cover Letter
---------------

This is the V9 of the patch series. This patch series is rebased on
6.15-rc3. This patch series fixes FSTests errors introduced patchset
8. To fix these errors, I have added a few more fixes to "ext4: rework
fast commit commit path" patch. The summary of the changes is as
follows:

- The new commit path first flushes all the data from all the inodes
  before marking inodes as being committed by setting bit
  "EXT4_STATE_FC_COMMITTING". This gets rid of a deadlock between:

  - `ext4_do_writepages()` which ends up waiting for fast commit to
    finish

  - `ext4_fc_perform_commit()` which triggers writeback path while
    submitting inode data.

- The fix to the race above, introduces a new race between
  ext4_fc_del() and ext4_fc_perform_commit(). Since now we delay
  setting "EXT4_STATE_FC_COMMITTING" until after data flush has
  finished, it is now possible that the inode being flushed may get
  deleted by a competing ext4_fc_del(). To fix this race, I introduced
  a new inode state called
  "EXT4_STATE_FC_FLUSHING_DATA". ext4_fc_del() now waits for
  "EXT4_STATE_FC_FLUSHING_DATA" bit to clear.

Verified that no new regression are introduced in -g auto and -g log
groups with fast_commit config.

V8 Cover Letter
--------------

This is the V8 of the patch series. This patch series contains fixes to
review comments by Jan Kara (<jack@suse.cz>). The main changes are as
follows:

- sbi->s_fc_lock is now a mutex type, and it is not released during
  commit path. This gets rid of a number of soft lockups due to race
  with ext4_fc_del().

- I have dropped "ext4: make fast commit ineligible on
  ext4_reserve_inode_write failure" patch.

- I have split "ext4: hold s_fc_lock while during fast commit" into
  two patches: "ext4: convert s_fc_lock to mutex type" and "ext4: hold
  s_fc_lock while during fast commit" to make reviewing easy.

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
  ext4: convert s_fc_lock to mutex type
  ext4: hold s_fc_lock while during fast commit

 fs/ext4/ext4.h        |  19 +-
 fs/ext4/fast_commit.c | 446 ++++++++++++++++++++++--------------------
 fs/ext4/inline.c      |   1 +
 fs/ext4/inode.c       |  12 +-
 fs/ext4/super.c       |   9 +-
 fs/jbd2/journal.c     |   2 -
 6 files changed, 260 insertions(+), 229 deletions(-)

-- 
2.49.0.1045.g170613ef41-goog


