Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0A5B62EB
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2019 14:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbfIRMPF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Sep 2019 08:15:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:52190 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730608AbfIRMPE (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 18 Sep 2019 08:15:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5EAF0AD45;
        Wed, 18 Sep 2019 12:15:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7810E1E4215; Wed, 18 Sep 2019 12:06:27 +0200 (CEST)
Date:   Wed, 18 Sep 2019 12:06:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     yangerkun <yangerkun@huawei.com>, jack@suse.cz,
        linux-ext4@vger.kernel.org, yi.zhang@huawei.com, houtao1@huawei.com
Subject: Re: [PATCH] ext4: fix a bug in ext4_wait_for_tail_page_commit
Message-ID: <20190918100627.GB25056@quack2.suse.cz>
References: <20190917084814.40370-1-yangerkun@huawei.com>
 <20190917153140.GF6762@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917153140.GF6762@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 17-09-19 11:31:40, Theodore Y. Ts'o wrote:
> On Tue, Sep 17, 2019 at 04:48:14PM +0800, yangerkun wrote:
> > No need to wait when offset equals to 0. And it will trigger a bug since
> > the latter __ext4_journalled_invalidatepage can free the buffers but leave
> > page still dirty.
> 
> That's only true if the block size == the page size, no?  If the
> offset is zero and the block size is 1k, we still need to wait.
> Shouldn't the better fix be:
> 
> > -	if (offset > PAGE_SIZE - i_blocksize(inode))
> > +	if (offset >= PAGE_SIZE - i_blocksize(inode))

No, what yangerkun wrote is correct. We don't have to wait for commit when
offset == 0 - truncate_inode_pages() should just happily process such page.
Also '>' in the above condition is correct. offset == PAGE_SIZE -
i_blocksize(inode) means one full block is getting truncated from the page
and we need to wait in that case to avoid jbd2_journal_invalidatepage()
failing with EBUSY when called from truncate_inode_pages().

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
