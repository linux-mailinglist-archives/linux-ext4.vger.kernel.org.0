Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631A234C422
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Mar 2021 08:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhC2Gyh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Mar 2021 02:54:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:33963 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230274AbhC2GyP (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 29 Mar 2021 02:54:15 -0400
IronPort-SDR: W4XC49nZ3EjUCI4gLdCy/Y0nX3nB8GrXfl3weBPQSYmLBGFKgeKB+htIqygxYAKoOnHeWgnRL0
 RvCwYYPY1stQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="178619862"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="178619862"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2021 23:54:14 -0700
IronPort-SDR: WIrOiAdG+oVHSJJyEqdKlgETx4BzteOgBhGuvf3aHz7E1jXKrPiJdAJF3H7hh18EcWOC6UmxLV
 pxQLvhZ7mb0g==
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="526838471"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2021 23:54:13 -0700
From:   ira.weiny@intel.com
To:     Jan Kara <jack@suse.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ext2: Convert kmap to kmap_local_page
Date:   Sun, 28 Mar 2021 23:54:00 -0700
Message-Id: <20210329065402.3297092-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

kmap is inefficient and can be abused so it is being phased out in favor of
kmap_local_page where possible.

ext2 uses kmap in ext2_[get|put]_page().  All of the calls to
ext2_[get|put]_page() occur in single threads so it is perfectly safe and
preferable to use kmap_local_page().

This series has a clean up which matches ext2_put_page() with ext2_dotdot() and
ext2_find_entry().  Those calls use ext2_get_page() to map the page prior to
returning it to their callers.  And they document that ext2_put_page() should
be matched up with them.  This was the case but the ext2_put_page() calls were
hidden in other functions.  We lift the ext2_put_page() calls to match up to
the functions where ext2_dotdot() and ext2_find_entry() are called.

After that clean up convert ext2_[get|put]_page() to kmap and adjust for
kunmap_local() requiring the page address.

Nesting of kmap_local_page() calls is maintained with minor changes.

Ira Weiny (2):
  ext2: Match up ext2_put_page() with ext2_dotdot() and
    ext2_find_entry()
  fs/ext2: Replace kmap() with kmap_local_page()

 fs/ext2/dir.c   | 94 +++++++++++++++++++++++++++++++------------------
 fs/ext2/ext2.h  | 12 ++++---
 fs/ext2/namei.c | 34 +++++++++++-------
 3 files changed, 89 insertions(+), 51 deletions(-)

-- 
2.28.0.rc0.12.gb6a658bd00c9

