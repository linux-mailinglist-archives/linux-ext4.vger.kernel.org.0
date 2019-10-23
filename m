Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 206D6E211F
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Oct 2019 18:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfJWQz4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Oct 2019 12:55:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:59466 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726265AbfJWQz4 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 23 Oct 2019 12:55:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 65068AC84;
        Wed, 23 Oct 2019 16:55:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2359F1E4A99; Wed, 23 Oct 2019 18:55:54 +0200 (CEST)
Date:   Wed, 23 Oct 2019 18:55:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 05/22] ext4: Fix ext4_should_journal_data() for EA inodes
Message-ID: <20191023165554.GG31271@quack2.suse.cz>
References: <20191003215523.7313-1-jack@suse.cz>
 <20191003220613.10791-5-jack@suse.cz>
 <20191021013842.GF6799@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021013842.GF6799@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun 20-10-19 21:38:42, Theodore Y. Ts'o wrote:
> On Fri, Oct 04, 2019 at 12:05:51AM +0200, Jan Kara wrote:
> > Similarly to directories, EA inodes do only journalled modifications to
> > their data. Change ext4_should_journal_data() to return true for them so
> > that we don't have to special-case them during truncate.
> 
> We are already special-casing EA inodes in ext4_clear_blocks() in
> fs/ext4/indirect.c, and get_default_free_blocks_flags() in
> fs/ext4/extents.c, and like S_ISDIR, we want to treat EA inode blocks
> as metadata.   So I'm not sure I see the value of this change?

Firstly, ext4_should_journal_data() should tell whether inode's data blocks
are modified through journalling. So as a principle of least surprise it
should return true for EA inodes because that's how data blocks of those
inodes are modified.

Secondly, once ext4_should_journal_data() is fixed by this patch, I think
that we can just drop that special-casing from ext4_clear_blocks() and
get_default_free_blocks_flags() and just have there:

	if (ext4_should_journal_data(inode))
		flags |= EXT4_FREE_BLOCKS_FORGET;

> As an aside, I was looking at fs/ext4/mballoc.c to see what the
> difference is for treating a block as a metadata block versus a
> journaled data block, and what I found made my hair rise on end:
> 
> 	/*
> 	 * We need to make sure we don't reuse the freed block until after the
> 	 * transaction is committed. We make an exception if the inode is to be
> 	 * written in writeback mode since writeback mode has weak data
> 	 * consistency guarantees.
> 	 */
> 
> So in data=writeback, if a file is deleted, its blocks are available
> for immediate reallocation, and if we are under heavy memory pressure,
> the deleted file's blocks could get overwritten --- even in the case
> where we crash and the transaction never committed.
> 
> While it's true that date=writeback mode has weaker guarantees, my
> understanding is that it only applied to the exposure stale data, and
> not to a long-standing file's blocks getting corrupted if it is almost
> deleted, but not quite before a crash.
> 
> Granted, the situation where this would happen is quite wrare, but it
> seems quite wrong....

I've always considered data=writeback as: You don't know what the data is
going to be if the file was touched shortly before crashing (i.e., similar
to old ext2 non-guarantees).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
