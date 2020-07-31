Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3E3234B72
	for <lists+linux-ext4@lfdr.de>; Fri, 31 Jul 2020 21:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbgGaTIc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 31 Jul 2020 15:08:32 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59739 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726726AbgGaTIc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 31 Jul 2020 15:08:32 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 06VJ8Sk4009104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 15:08:29 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 53330420304; Fri, 31 Jul 2020 15:08:28 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 0/4] V2- ext4 block bitmap prefetch patches
Date:   Fri, 31 Jul 2020 15:08:01 -0400
Message-Id: <20200731190805.181253-1-tytso@mit.edu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is a second revision of Alex's original block allocation
prefetch patches.

Changes are from v1:

*) We don't skip reading block bitmaps in the first block group of a
flex_bg.  This is necessary so that strategy of biasing block
allocations for metadata blocks (in particular, extent tree
blocks) can be preserved.

*) The prefetch_block_bitmaps mount option now will prefetch the block
bitmaps before starting lazy inode table initialization, instead of
the other way around.  In general, for freshly created file systems,
prefetching block bitmaps will go very quickly, since most block
groups have not been used yet, so we don't actually the prefetch those
block bitmaps.

*) Other minor spelling fixups, cleanups.


Alex Zhuravlev (2):
  ext4: add prefetching for block allocation bitmaps
  ext4: skip non-loaded groups at cr=0/1 when scanning for good groups

Theodore Ts'o (2):
  ext4: indicate via a block bitmap read is prefetched via a tracepoint
  ext4: add prefetch_block_bitmaps mount options

 fs/ext4/balloc.c            |  16 +++-
 fs/ext4/ext4.h              |  23 +++++-
 fs/ext4/mballoc.c           | 153 +++++++++++++++++++++++++++++++++++-
 fs/ext4/super.c             |  59 ++++++++++----
 fs/ext4/sysfs.c             |   4 +
 include/trace/events/ext4.h |  68 +++++++++++++++-
 6 files changed, 294 insertions(+), 29 deletions(-)

-- 
2.24.1

