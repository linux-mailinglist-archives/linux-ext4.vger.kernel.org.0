Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228161FCD23
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Jun 2020 14:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgFQMPC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 17 Jun 2020 08:15:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:42606 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgFQMPC (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 17 Jun 2020 08:15:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4B5AEAAC6;
        Wed, 17 Jun 2020 12:15:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CD4221E128D; Wed, 17 Jun 2020 14:15:00 +0200 (CEST)
Date:   Wed, 17 Jun 2020 14:15:00 +0200
From:   Jan Kara <jack@suse.cz>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>
Subject: Re: [PATCH] jbd2: make sure jh have b_transaction set in
 refile/unlink_buffer
Message-ID: <20200617121500.GA29763@quack2.suse.cz>
References: <20200617091031.6558-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617091031.6558-1-lczerner@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 17-06-20 11:10:31, Lukas Czerner wrote:
> Callers of __jbd2_journal_unfile_buffer() and
> __jbd2_journal_refile_buffer() assume that the b_transaction is set. In
> fact if it's not, we can end up with journal_head refcounting errors
> leading to crash much later that might be very hard to track down. Add
> asserts to make sure that is the case.
> 
> We also make sure that b_next_transaction is NULL in
> __jbd2_journal_unfile_buffer() since the callers expect that as well and
> we should not get into that stage in this state anyway, leading to
> problems later on if we do.
> 
> Tested with fstests.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>

Thanks! The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/transaction.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index e91aad3637a2..e65e0aca2826 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -2026,6 +2026,9 @@ static void __jbd2_journal_temp_unlink_buffer(struct journal_head *jh)
>   */
>  static void __jbd2_journal_unfile_buffer(struct journal_head *jh)
>  {
> +	J_ASSERT_JH(jh, jh->b_transaction != NULL);
> +	J_ASSERT_JH(jh, jh->b_next_transaction == NULL);
> +
>  	__jbd2_journal_temp_unlink_buffer(jh);
>  	jh->b_transaction = NULL;
>  }
> @@ -2572,6 +2575,13 @@ bool __jbd2_journal_refile_buffer(struct journal_head *jh)
>  
>  	was_dirty = test_clear_buffer_jbddirty(bh);
>  	__jbd2_journal_temp_unlink_buffer(jh);
> +
> +	/*
> +	 * b_transaction must be set, otherwise the new b_transaction won't
> +	 * be holding jh reference
> +	 */
> +	J_ASSERT_JH(jh, jh->b_transaction != NULL);
> +
>  	/*
>  	 * We set b_transaction here because b_next_transaction will inherit
>  	 * our jh reference and thus __jbd2_journal_file_buffer() must not
> -- 
> 2.21.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
