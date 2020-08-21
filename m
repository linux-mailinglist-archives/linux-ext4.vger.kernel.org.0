Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F8B24C9B0
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Aug 2020 03:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgHUBzd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Aug 2020 21:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgHUBza (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Aug 2020 21:55:30 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF61C061385
        for <linux-ext4@vger.kernel.org>; Thu, 20 Aug 2020 18:55:30 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a79so286858pfa.8
        for <linux-ext4@vger.kernel.org>; Thu, 20 Aug 2020 18:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ox1M4H9yXLK0NZmqy1bfDVrKeJ5PP7vOvP4fO3yewSU=;
        b=K2E6LeDDWf3R9D+P+rJW/xZOJc0peVtf2tEXr2d4ECX01728ENehioWCFeWDlu+pIY
         vTuqAfRN/nR3HPnrA8ETdhoQFSDWwpgemT23rA82h2BkaugKwchH07ki0YDh7+EzGLqx
         QoD1knj/PxPezmUuDcqe1JArZV0SMi+kDcni45G7HxAjbBio4nVbDGp2TKISsN1bY0Ml
         6LS2e/UBd5NnxD4HBb7d3nb1ldy0d42K7btQdX10grzVcsdj6wO3XQ2SEhs3GMQioV3G
         FG63BV37FvoDBZM+KVOoMZnjcJdmanVBH+9OhJk+CvfPmwKmantPlwf+hwk4nlUAAklE
         qvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ox1M4H9yXLK0NZmqy1bfDVrKeJ5PP7vOvP4fO3yewSU=;
        b=ZViFK0DuPguktlt5Kl66d93eB3dvZr79RzAfjHtFQQ9qNHpl2MNDlu0Qs4sFWEruNs
         PQdI6PK3zE3ZleK7Gue/lnpOBJZMIaV3zNdKMBwcV4FWyarHCRKfz2cCQPBc4iK2DO1F
         FckF5GvLyh7XKdK/AD92kWZFXB3y1utfXDkpqU5iMiHMnNqoknjAHkgZwqFbpJXDuDl9
         dwoOZT8um61utMzAEM9yhzgSIxyo4o59N3g8n29CpOIIy2MEcjML9HIdSP/y5Bv342+f
         2s+vZGwqlP9QN03Qm5/XDhLbxjP/4Pj4raqvIm/RgHLkY74NdGZOrKqXM6hAZHLzRtVP
         3C5A==
X-Gm-Message-State: AOAM5302S3im8Bn+tJZFZZOcu0Lq8bsuJMTA1VooBxjpRrWylDArZmb0
        Dl7DxKfiN0kUJzCocB207z9jx1qGhzk=
X-Google-Smtp-Source: ABdhPJzjui3q/kP4/TkNLusrkheXFmi/aVf1vzb7B8aw21Vqyzx75D15qfdV446CZBLEzPjprbD+sg==
X-Received: by 2002:a63:5f04:: with SMTP id t4mr713010pgb.308.1597974928503;
        Thu, 20 Aug 2020 18:55:28 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id o15sm370191pfu.167.2020.08.20.18.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 18:55:27 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, lyx1209@gmail.com,
        Harshad Shirwadkar <harshads@google.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [RFC PATCH v2 0/9] ext4: add free-space extent based allocator
Date:   Thu, 20 Aug 2020 18:55:14 -0700
Message-Id: <20200821015523.1698374-1-harshads@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4: add free-space extent based allocator

This patchset introduces a new multiblock allocator for the Ext4 file
system based on an enhanced version of the free space management
mechanism originally proposed by Kadekodi S. and Jain S., in their
paper, "Taking Linux Filesystems to the Space Age: Space Maps in Ext4"
[1].

High Level Design
=================

This allocator maintains the free space information about the file
system in per-flexible block group level trees. These trees are
constructed from block bitmaps stored on disk. Therefore, this feature
does not require any on-disk format change. For every flexible block
group, we maintain individual freespace nodes in two trees, one sorted
by flex-bg offset and other sorted by length. This gives us two
benefits: i) In the allocation path, our search time complexity is
O(Log(Number of freespace regions in the flex-bg)). ii) In free path,
in the same time complexity we can merge the adjacent nodes thereby
reducing the size of the tree efficiently.

Along with flexible block group level trees, we also introduce a top
level meta-tree which consists of individual flex-bg trees. This tree
is sorted by length of largest extents found in flex-bgs. The key
advantage that this tree gives us is this: During an allocation
request, the allocator is now able to consult this tree and directly
(in O(Log(Number of Flex BGs)) jump to a flexible block group which
_definitely_ has at least one (the largest) extent that can satisfy
this request. If no flexible block group exists which can satisfy this
request, the allocator can now immediately drop the CR level.

In order to preseve the parallel allocation / free performance, the
allocator only *tries* to consult this tree. It does so by calling
read_trylock() function and if the meta-tree is busy, the allocator
continues its linear search until it is able to grab a read-lock on
this tree.

Memory Footprint
================

In a less fragmented file system, the memory footprint of the new
allocator is significantly lower than buddy bitmaps. Memory footprint
of the freespace tree allocator can be checked by running "cat
/sys/fs/ext4/<dev>/frsp_tree_usage". For an almost newly created 100G
disk, the total usage is only ~10 KB. However, as the fragmentation
level increases, the memory footprint of this allocator may
increase. The memory usage of the freespace tree allocator can be
controlled using sysfs tunable "mb_frsp_max_mem". Once the memory
threshold is reached, the allocator starts evicting the freespace
trees in the LRU fashion from memory. However, we don't remove tree's
entry from the meta-tree. This allows the allocator to efficiently
reconstruct only relevant trees from on-disk bitmaps under high memory
pressure. As we show in the evaluation section, freespace tree
allocator still manages to outperform buddy allocator in memory crunch
situation. The default value of mb_frsp_max_mem is max(memory needed
for buddy, maximum memory needed for one tree in the worst
case). Accounting for max memory needed for one tree allows us to keep
at least one tree in memory even in the worst case. This avoids
thrashing.

Caching Tree Metadata
=====================

As noted in our experiments, we find caching tree metadata (the
largest available extent in a tree) in the meta-tree significantly
boosts allocation performance. However, if the allocator waits for the
cache to fill up before starting to serve allocation requests, that
may severely degrade allocation performance on large disks. Thus, it
is important to tune the tree caching behavior according to the
underlying block device. This patchset provides four cache aggression
levels. Cache aggression level can be specified as a mount time
parameter "frsp_cache_aggression". Here is the meaning of these
different levels:

|-------+------------------------------------------------------------------|
| Level | Meaning                                                          |
|-------+------------------------------------------------------------------|
|     0 | Try to avoid caching as much as possible. In this mode           |
|       | the allocator tries hard to serve the request from the already   |
|       | cached trees.                                                    |
|-------+------------------------------------------------------------------|
|     1 | Avoid caching at CR=0. Otherwise, cache trees on every other     |
|       | allocation request. (default)                                    |
|-------+------------------------------------------------------------------|
|     2 | Cache trees on every other allocation request.                   |
|-------+------------------------------------------------------------------|
|     3 | Aggressive caching. In this mode the allocator aggressively      |
|       | caches uncached trees, even if the request can be fulfilled      |
|       | by one of the available trees. Using this mode, the allocator    |
|       | ends up caching trees quickly and thereby is able to make better |
|       | allocation decisions sooner.                                     |
|-------+------------------------------------------------------------------|

Evaluation
==========

This feature did not introduce any regressions in Ext4 XFStests in
quick group. We created a _highly_ fragmented 60T disk with over 490K
block groups and over 30K flexible block groups. We tested the write
performance of the first small write (10MB) and a larger second write
(100MB) using both the buddy allocator and freespace tree
allocator. We turned memory limit off for the first four free space
tree configurations.

First Write Performance
-----------------------
|--------------------------------------+---------+---------+-----------+--------|
| Allocator                            | RAM     | # trees | Perf      | Time   |
|                                      | usage   |  cached |           |        |
|--------------------------------------+---------+---------+-----------+--------|
| Buddy Allocator (v5.7)               | -       |       - | 6.8 KB/s  | 25m51s |
|--------------------------------------+---------+---------+-----------+--------|
| With --prefetch_block_bitmap         | -       |       - | 28.1 KB/s | 6m14s  |
|--------------------------------------+---------+---------+-----------+--------|
| Free space tree allocator at level 0 | 43.5 MB |     201 | 2.6 MB/s  | 0m8s   |
|--------------------------------------+---------+---------+-----------+--------|
| Free space tree allocator at level 1 | 193 MB  |     874 | 1.5 MB/s  | 0m47s  |
|--------------------------------------+---------+---------+-----------+--------|
| Free space tree allocator at level 2 | 3.6 GB  |   16476 | 21.4 KB/s | 8m14s  |
|--------------------------------------+---------+---------+-----------+--------|
| Free space tree allocator at level 3 | 6.8 GB  |   30720 | 9.1 KB/s  | 19m22s |
|--------------------------------------+---------+---------+-----------+--------|
| Free space tree allocator at level 3 | 1023 MB |   30720 | 9.3 KB/s  | 18m53s |
| ( With 1G Limit)                     |         |         |           |        |
|--------------------------------------+---------+---------+-----------+--------|

Second Write Performance
------------------------
|--------------------------------------+---------+---------+-----------+-------|
| Allocator                            | RAM     | # trees | Perf      | Time  |
|                                      | usage   |  cached |           |       |
|--------------------------------------+---------+---------+-----------+-------|
| Buddy Allocator (v5.7)               | -       |       - | 499 KB/s  | 3m30s |
|--------------------------------------+---------+---------+-----------+-------|
| With --prefetch_block_bitmap         | -       |       - | 185 KB/s  | 9m26s |
|--------------------------------------+---------+---------+-----------+-------|
| Free space tree allocator at level 0 | 48.7 MB |     226 | 48.2 MB/s | 6s    |
|--------------------------------------+---------+---------+-----------+-------|
| Free space tree allocator at level 1 | 221 MB  |    1007 | 26.8 MB/s | 8s    |
|--------------------------------------+---------+---------+-----------+-------|
| Free space tree allocator at level 2 | 6.8 GB  |   30720 | 178 KB/s  | 9m54s |
|--------------------------------------+---------+---------+-----------+-------|
| Free space tree allocator at level 3 | 6.8 GB  |   30720 | 79 MB/s   | 5s    |
|--------------------------------------+---------+---------+-----------+-------|
| Free space tree allocator at level 3 | 1023 MB |   30720 | 77.1 MB/s | 7s    |
| ( With 1G Limit)                     |         |         |           |       |
|--------------------------------------+---------+---------+-----------+-------|

Verified that parallel write performance on a newly created disk is
not very different for buddy allocator and freespace tree
allocator. This patchset is applied on top of block bitmap prefetch
patches.

Signed-off-by: Yuexin Li <lyx1209@gmail.com>
Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

[1] https://www.kernel.org/doc/ols/2010/ols2010-pages-121-132.pdf

Changes Since V1:

- Rebased the patchset on top of ext4 dev branch
- Converted the patches to RFC

Harshad Shirwadkar (8):
  ext4: add handling for extended mount options
  ext4: rename ext4_mb_load_buddy to ext4_mb_load_allocator
  ext4: add prefetching support for freespace trees
  ext4: add freespace tree optimizations
  ext4: add memory usage tracker for freespace trees
  ext4: add LRU eviction for free space trees
  ext4: add tracepoints for free space trees
  ext4: add freespace trees documentation in code

Yuexin Li (1):
  ext4: add freespace tree allocator

 fs/ext4/ext4.h              |  117 +++
 fs/ext4/mballoc.c           | 1541 +++++++++++++++++++++++++++++++++--
 fs/ext4/mballoc.h           |   67 +-
 fs/ext4/resize.c            |    8 +
 fs/ext4/super.c             |   60 +-
 fs/ext4/sysfs.c             |   11 +
 include/trace/events/ext4.h |  112 +++
 7 files changed, 1821 insertions(+), 95 deletions(-)

-- 
2.28.0.297.g1956fa8f8d-goog

