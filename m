Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C74CFDE1CA
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Oct 2019 03:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfJUBit (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 20 Oct 2019 21:38:49 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43953 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726718AbfJUBis (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 20 Oct 2019 21:38:48 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9L1ch5h006028
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 20 Oct 2019 21:38:43 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 03063420458; Sun, 20 Oct 2019 21:38:42 -0400 (EDT)
Date:   Sun, 20 Oct 2019 21:38:42 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 05/22] ext4: Fix ext4_should_journal_data() for EA inodes
Message-ID: <20191021013842.GF6799@mit.edu>
References: <20191003215523.7313-1-jack@suse.cz>
 <20191003220613.10791-5-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003220613.10791-5-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 04, 2019 at 12:05:51AM +0200, Jan Kara wrote:
> Similarly to directories, EA inodes do only journalled modifications to
> their data. Change ext4_should_journal_data() to return true for them so
> that we don't have to special-case them during truncate.

We are already special-casing EA inodes in ext4_clear_blocks() in
fs/ext4/indirect.c, and get_default_free_blocks_flags() in
fs/ext4/extents.c, and like S_ISDIR, we want to treat EA inode blocks
as metadata.   So I'm not sure I see the value of this change?

As an aside, I was looking at fs/ext4/mballoc.c to see what the
difference is for treating a block as a metadata block versus a
journaled data block, and what I found made my hair rise on end:

	/*
	 * We need to make sure we don't reuse the freed block until after the
	 * transaction is committed. We make an exception if the inode is to be
	 * written in writeback mode since writeback mode has weak data
	 * consistency guarantees.
	 */

So in data=writeback, if a file is deleted, its blocks are available
for immediate reallocation, and if we are under heavy memory pressure,
the deleted file's blocks could get overwritten --- even in the case
where we crash and the transaction never committed.

While it's true that date=writeback mode has weaker guarantees, my
understanding is that it only applied to the exposure stale data, and
not to a long-standing file's blocks getting corrupted if it is almost
deleted, but not quite before a crash.

Granted, the situation where this would happen is quite wrare, but it
seems quite wrong....

						- Ted
