Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD4A713BC0B
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jan 2020 10:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbgAOJIt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Jan 2020 04:08:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:36348 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729267AbgAOJIt (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 15 Jan 2020 04:08:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 52515AC4B;
        Wed, 15 Jan 2020 09:08:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 359871E0CBC; Wed, 15 Jan 2020 10:08:46 +0100 (CET)
Date:   Wed, 15 Jan 2020 10:08:46 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [RFC 1/2] iomap: direct-io: Move inode_dio_begin before
 filemap_write_and_wait_range
Message-ID: <20200115090846.GB31450@quack2.suse.cz>
References: <cover.1578907890.git.riteshh@linux.ibm.com>
 <27607a16327fe9664f32d09abe565af0d1ae56c9.1578907891.git.riteshh@linux.ibm.com>
 <20200114163702.GA7127@infradead.org>
 <20200114171934.GB22081@quack2.suse.cz>
 <20200114182736.GA27370@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114182736.GA27370@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 14-01-20 10:27:36, Christoph Hellwig wrote:
> On Tue, Jan 14, 2020 at 06:19:34PM +0100, Jan Kara wrote:
> > We want to detect in the writeback path whether there's direct IO (read)
> > currently running for the inode. Not for the writeback issued from
> > iomap_dio_rw() but for any arbitrary writeback that iomap_dio_rw() can be
> > racing with - so struct writeback_control won't help. Now if you want to
> > see the ugly details why this hack is needed, see my other email to Ritesh
> > in this thread with details of the race.
> 
> How do we get other writeback after iomap_dio_rw wrote everything out?

You create dirty page using mmap in the range read by iomap_dio_rw() and then
background writeback happens at unfortunate time... Email [1] has the exact
traces.

> Either way I'm trying to kill i_dio_count as it has all kinds of
> problems, see the patch sent out earlier today.

OK, I'll see that patch.

								Honza

[1] https://lore.kernel.org/linux-ext4/20200114094741.GC6466@quack2.suse.cz
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
