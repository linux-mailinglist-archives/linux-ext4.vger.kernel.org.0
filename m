Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3883E275676
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Sep 2020 12:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgIWKfd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Sep 2020 06:35:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:46414 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWKfc (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 23 Sep 2020 06:35:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DE028AC79;
        Wed, 23 Sep 2020 10:36:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 578261E12E3; Wed, 23 Sep 2020 12:35:31 +0200 (CEST)
Date:   Wed, 23 Sep 2020 12:35:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Hui Su <sh_def@163.com>
Cc:     tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] FIX the comment of struct jbd2_journal_handle
Message-ID: <20200923103531.GE6719@quack2.suse.cz>
References: <20200922171231.GA53120@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922171231.GA53120@rlk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 23-09-20 01:12:31, Hui Su wrote:
> the struct name was modified long ago, but the comment still
> use struct handle_s.
> 
> Signed-off-by: Hui Su <sh_def@163.com>

Thanks for the patch. It looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/jbd2.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 08f904943ab2..a1ef05412acf 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -452,8 +452,8 @@ struct jbd2_inode {
>  struct jbd2_revoke_table_s;
>  
>  /**
> - * struct handle_s - The handle_s type is the concrete type associated with
> - *     handle_t.
> + * struct jbd2_journal_handle - The jbd2_journal_handle type is the concrete
> + *     type associated with handle_t.
>   * @h_transaction: Which compound transaction is this update a part of?
>   * @h_journal: Which journal handle belongs to - used iff h_reserved set.
>   * @h_rsv_handle: Handle reserved for finishing the logical operation.
> -- 
> 2.25.1
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
