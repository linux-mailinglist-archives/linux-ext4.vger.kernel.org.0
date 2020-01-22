Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1C7144DEE
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2020 09:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgAVIub (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Jan 2020 03:50:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:40786 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729113AbgAVIua (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 22 Jan 2020 03:50:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 970CAAC23;
        Wed, 22 Jan 2020 08:50:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7009E1E0A4F; Wed, 22 Jan 2020 09:50:24 +0100 (CET)
Date:   Wed, 22 Jan 2020 09:50:24 +0100
From:   Jan Kara <jack@suse.cz>
To:     Shijie Luo <luoshijie1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz
Subject: Re: [PATCH] jbd2: modify assert condition in
 __journal_remove_journal_head
Message-ID: <20200122085024.GB12845@quack2.suse.cz>
References: <20200122070548.64664-1-luoshijie1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122070548.64664-1-luoshijie1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 22-01-20 02:05:48, Shijie Luo wrote:
> Only when jh->b_jcount = 0 in jbd2_journal_put_journal_head, we are allowed
> to call __journal_remove_journal_head.
> 
> Signed-off-by: Shijie Luo <luoshijie1@huawei.com>

Thanks for the patch. You're right but given that
__journal_remove_journal_head() has exactly one caller and that checks for
jh->b_jcount == 0 just before calling __journal_remove_journal_head(), I
think the assertion is pretty pointless. So I'd rather just remove it
completely.

								Honza

> ---
>  fs/jbd2/journal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 5e408ee24a1a..4f417a7f1ae0 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -2556,7 +2556,7 @@ static void __journal_remove_journal_head(struct buffer_head *bh)
>  {
>  	struct journal_head *jh = bh2jh(bh);
>  
> -	J_ASSERT_JH(jh, jh->b_jcount >= 0);
> +	J_ASSERT_JH(jh, jh->b_jcount == 0);
>  	J_ASSERT_JH(jh, jh->b_transaction == NULL);
>  	J_ASSERT_JH(jh, jh->b_next_transaction == NULL);
>  	J_ASSERT_JH(jh, jh->b_cp_transaction == NULL);
> -- 
> 2.19.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
