Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541F63B1161
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Jun 2021 03:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhFWBjA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Jun 2021 21:39:00 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49588 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229774AbhFWBjA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 22 Jun 2021 21:39:00 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15N1adH0031867
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Jun 2021 21:36:40 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5FF4915C3CD6; Tue, 22 Jun 2021 21:36:39 -0400 (EDT)
Date:   Tue, 22 Jun 2021 21:36:39 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 1/3] ext4: add discard/zeroout flags to journal flush
Message-ID: <YNKQJ/dwQlvQiMKp@mit.edu>
References: <20210518151327.130198-1-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518151327.130198-1-leah.rumancik@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 18, 2021 at 03:13:25PM +0000, Leah Rumancik wrote:
> Add a flags argument to jbd2_journal_flush to enable discarding or
> zero-filling the journal blocks while flushing the journal.
> 
> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> 
> Changes in v4:
> - restructured code division between patches
> - changed jbd2_journal_flush flags arg from bool to unsigned long long
> 
> Changes in v5:
> - changed jbd2_journal_flush flags to unsigned int
> - changed name of jbd2_journal_flush flags from JBD2_ERASE* to
> JBD2_JOURNAL_FLUSH*
> - cleaned up loop in jbd2_journal_erase which finds contiguous regions
> - updated flag checking
> ---

I noticed a minor issue in this commit, and so I've made the following
change to this commit in the ext4 tree.

	       	       	      	     	  - Ted

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 521ce41c242c..3a2ed60ea8b7 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1715,7 +1715,7 @@ static int __jbd2_journal_erase(journal_t *journal, unsigned int flags)
 	if (!q)
 		return -ENXIO;
 
-	if (JBD2_JOURNAL_FLUSH_DISCARD & !blk_queue_discard(q))
+	if ((flags & JBD2_JOURNAL_FLUSH_DISCARD) && !blk_queue_discard(q))
 		return -EOPNOTSUPP;
 
 	/*
