Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFEE15A394
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Feb 2020 09:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgBLIpO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Feb 2020 03:45:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:59572 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728493AbgBLIpO (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 12 Feb 2020 03:45:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C428BAC9D;
        Wed, 12 Feb 2020 08:45:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1AB3A1E0E01; Wed, 12 Feb 2020 09:45:11 +0100 (CET)
Date:   Wed, 12 Feb 2020 09:45:11 +0100
From:   Jan Kara <jack@suse.cz>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, linux-ext4@vger.kernel.org,
        luoshijie1@huawei.com, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH 2/2] jbd2: do not clear the BH_Mapped flag when
 forgetting a metadata buffer
Message-ID: <20200212084511.GA25573@quack2.suse.cz>
References: <20200203140458.37397-1-yi.zhang@huawei.com>
 <20200203140458.37397-3-yi.zhang@huawei.com>
 <20200206114647.GB3994@quack2.suse.cz>
 <6c03b515-d128-06be-2e38-56a01ee63263@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c03b515-d128-06be-2e38-56a01ee63263@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 06-02-20 23:28:01, zhangyi (F) wrote:
> Thanks for the comments.
> 
> On 2020/2/6 19:46, Jan Kara wrote:
> > On Mon 03-02-20 22:04:58, zhangyi (F) wrote:
> [..]
> >> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> >> index 6396fe70085b..a649cdd1c5e5 100644
> >> --- a/fs/jbd2/commit.c
> >> +++ b/fs/jbd2/commit.c
> >> @@ -987,10 +987,13 @@ void jbd2_journal_commit_transaction(journal_t *journal)
> >>  		if (buffer_freed(bh) && !jh->b_next_transaction) {
> >>  			clear_buffer_freed(bh);
> >>  			clear_buffer_jbddirty(bh);
> >> -			clear_buffer_mapped(bh);
> >> -			clear_buffer_new(bh);
> >> -			clear_buffer_req(bh);
> >> -			bh->b_bdev = NULL;
> >> +			if (buffer_unmap(bh)) {
> >> +				clear_buffer_unmap(bh);
> >> +				clear_buffer_mapped(bh);
> >> +				clear_buffer_new(bh);
> >> +				clear_buffer_req(bh);
> >> +				bh->b_bdev = NULL;
> >> +			}
> > 
> > Any reason why you don't want to clear buffer_req and buffer_new flags for
> > all buffers as well? I agree that b_bdev setting and buffer_mapped need
> > special treatment.
> > 
> IIUC, for the buffer coming from jbd2_journal_forget() is always 'block
> device backed' metadata buffer (not pretty sure), and for these metadata
  Yes, it is.

> buffer, buffer_new flag will not be set. At the same time, since it's
> always mapped, so it's fine to keep the buffer_req flag even it's freed
> by the filesystem now, because it means the block device has committed
> this buffer, and it seems that it does not affect we reuse this buffer.
> Am I missing something ?

OK, you're right that buffer_new shouldn't be ever set for block backed
buffers and we don't care about buffer_req. So let's keep the split of bits
to clear as you did and just add a comment that for block device buffers it
is enough to clear buffer_jbddirty and buffer_freed, for file mapping
buffers (i.e., journalled data) we have to be more careful and clear more
bits.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
