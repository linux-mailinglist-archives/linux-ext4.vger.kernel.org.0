Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9470E15428F
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2020 12:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgBFLDm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Feb 2020 06:03:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:59126 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbgBFLDm (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 6 Feb 2020 06:03:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2DD86B116;
        Thu,  6 Feb 2020 11:03:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2A4151E0E31; Thu,  6 Feb 2020 12:03:35 +0100 (CET)
Date:   Thu, 6 Feb 2020 12:03:35 +0100
From:   Jan Kara <jack@suse.cz>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org,
        luoshijie1@huawei.com, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH 1/2] jbd2: move the clearing of b_modified flag to the
 journal_unmap_buffer()
Message-ID: <20200206110335.GA3994@quack2.suse.cz>
References: <20200203140458.37397-1-yi.zhang@huawei.com>
 <20200203140458.37397-2-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203140458.37397-2-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 03-02-20 22:04:57, zhangyi (F) wrote:
> There is no need to delay the clearing of b_modified flag to the
> transaction committing time when unmapping the journalled buffer, so
> just move it to the journal_unmap_buffer().
> 
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>

Thanks for the patch. It looks good, just one small comment below:

> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index e77a5a0b4e46..a479cbf8ae54 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -2337,11 +2337,7 @@ static int journal_unmap_buffer(journal_t *journal, struct buffer_head *bh,
>  		set_buffer_freed(bh);
>  		if (journal->j_running_transaction && buffer_jbddirty(bh))
>  			jh->b_next_transaction = journal->j_running_transaction;
> -		spin_unlock(&journal->j_list_lock);
> -		spin_unlock(&jh->b_state_lock);
> -		write_unlock(&journal->j_state_lock);
> -		jbd2_journal_put_journal_head(jh);
> -		return 0;
> +		may_free = 0;

I'd rather add b_modified clearing here than trying to reuse the tail of
the function. Because this condition is different from the other ones that
end up in zap_buffer_locked - here we really want to keep bh and jh mostly
intact.
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
