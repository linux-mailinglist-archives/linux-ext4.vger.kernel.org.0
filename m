Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25A27E4AA0
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Nov 2023 22:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbjKGV1A (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Nov 2023 16:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbjKGV06 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Nov 2023 16:26:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B2212F;
        Tue,  7 Nov 2023 13:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=EP7joTD4KdhEN+JYaunSKscvkg3WE9Mu9wWDQxtZwaU=; b=qRN0vkvEs+DqYPQ9wvyojFvPip
        llXW+LTsloyNInz83z14hPryJOAdfhILlpUV6VzGgCw7Py3gAFsAYrTV2V8Cx6aRWv9/z9RLtg8pq
        4Xc4WmxdT1sFNUBm8eEzfT52hBD0tLRoXQ/Bc7HMhzcPZMt9+WtXXvpdxIiIyoeajAGopCwzgzL4c
        9Un/dahv36o5lb9YAyPUAOe+4RzbEP8GqJAOLqx2P9uKJLP97Al/aJE6i4kxw/9tXS/5AKx4PkT3E
        7XphcldjtukAjc+8u/+wuGjhPrK67Js9wXXrP3LdlRp/TCeIh+J/YsIg1zOICXJQDTFRJvbngr0gd
        fR40IhDA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r0Tav-00Ee0T-0I; Tue, 07 Nov 2023 21:26:45 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, gfs2@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-erofs@lists.ozlabs.org, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 0/3] Add folio_zero_tail() and folio_fill_tail()
Date:   Tue,  7 Nov 2023 21:26:39 +0000
Message-Id: <20231107212643.3490372-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I'm trying to make it easier for filesystems with tailpacking /
stuffing / inline data to use folios.  The primary function here is
folio_fill_tail().  You give it a pointer to memory where the data
currently is, and it takes care of copying it into the folio at that
offset.  That works for gfs2 & iomap.  Then There's Ext4.  Rather than
gin up some kind of specialist "Here's a two pointers to two blocks
of memory" routine, just let it do its current thing, and let it call
folio_zero_tail(), which is also called by folio_fill_tail().

Other filesystems can be converted later; these ones seemed like good
examples as they're already partly or completely converted to folios.

Matthew Wilcox (Oracle) (3):
  mm: Add folio_zero_tail() and use it in ext4
  mm: Add folio_fill_tail() and use it in iomap
  gfs2: Convert stuffed_readpage() to stuffed_read_folio()

 fs/ext4/inline.c        |  3 +-
 fs/gfs2/aops.c          | 37 +++++++++-----------
 fs/iomap/buffered-io.c  | 14 ++------
 include/linux/highmem.h | 76 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 96 insertions(+), 34 deletions(-)

-- 
2.42.0

