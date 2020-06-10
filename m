Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDDF11F5900
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jun 2020 18:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgFJQ1S (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 10 Jun 2020 12:27:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:59166 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728174AbgFJQ1S (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 10 Jun 2020 12:27:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id ABCB6AC6C;
        Wed, 10 Jun 2020 16:27:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C04131E1283; Wed, 10 Jun 2020 18:27:15 +0200 (CEST)
Date:   Wed, 10 Jun 2020 18:27:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, "zhangyi (F)" <yi.zhang@huawei.com>,
        linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        zhangxiaoxu5@huawei.com
Subject: Re: [PATCH 00/10] ext4: fix inconsistency since reading old metadata
 from disk
Message-ID: <20200610162715.GD20677@quack2.suse.cz>
References: <20200526071754.33819-1-yi.zhang@huawei.com>
 <20200608082007.GJ13248@quack2.suse.cz>
 <cc834f50-95f0-449a-0ace-c55c41d2be1c@huawei.com>
 <20200609121920.GB12551@quack2.suse.cz>
 <45796804-07f7-2f62-b8c5-db077950d882@huawei.com>
 <20200610095739.GE12551@quack2.suse.cz>
 <20200610154543.GI1347934@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610154543.GI1347934@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 10-06-20 11:45:43, Theodore Y. Ts'o wrote:
> On Wed, Jun 10, 2020 at 11:57:39AM +0200, Jan Kara wrote:
> > > So I guess it may still lead to inconsistency. How about add this checking
> > > into ext4_journal_get_write_access() ?
> > 
> > Yes, this also occured to me later. Adding the check to
> > ext4_journal_get_write_access() should be safer.
> 
> There's another thing which we could do.  One of the issues is that we
> allow buffered writeback for block devices once the change to the
> block has been committed.  What if we add a change to block device
> writeback code and in fs/buffer.c so that optionally, the file system
> can specify a callback function can get called when an I/O error has
> been reflected back up from the block layer?
> 
> It seems unfortunate that currently, we can immediately report the I/O
> error for buffered writes to *files*, but for metadata blocks, we
> would only be able to report the problem when we next try to modify
> it.
> 
> Making changes to fs/buffer.c might be controversial, but I think it
> might be result in a better solution.

Yeah, what you propose certainly makes sence could be relatively easily
done by blkdev_writepage() using __block_write_full_page() with appropriate
endio handler which calls fs callback. I'm just not sure how propagate the
callback function from the fs to the blkdev...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
