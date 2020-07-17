Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C26B223FF6
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jul 2020 17:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgGQPyD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jul 2020 11:54:03 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54476 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726556AbgGQPyC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Jul 2020 11:54:02 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 06HFrx67029542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jul 2020 11:53:59 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C41AF420304; Fri, 17 Jul 2020 11:53:58 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Alex Zhuravlev <bzzz@whamcloud.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 0/4] ex4 block bitmap prefetching
Date:   Fri, 17 Jul 2020 11:53:48 -0400
Message-Id: <20200717155352.1053040-1-tytso@mit.edu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I've revised Alex's original block allocation prefetch changes a bit,
and an option to prefetch all of the block allocation bitmaps when the
file system is mounted.  Please take a look...


Alex Zhuravlev (2):
  ext4: add prefetching for block allocation bitmaps
  ext4: skip non-loaded groups at cr=0/1 when scanning for good groups

Theodore Ts'o (2):
  ext4: indicate via a block bitmap read is prefetched via a tracepoint
  ext4: add prefetch_block_bitmaps mount options

 fs/ext4/balloc.c            |  16 +++-
 fs/ext4/ext4.h              |  21 +++++-
 fs/ext4/mballoc.c           | 143 +++++++++++++++++++++++++++++++++++-
 fs/ext4/super.c             |  51 ++++++++++---
 fs/ext4/sysfs.c             |   4 +
 include/trace/events/ext4.h |  24 +++++-
 6 files changed, 236 insertions(+), 23 deletions(-)

-- 
2.24.1

