Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 808E3150370
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Feb 2020 10:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgBCJi1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 3 Feb 2020 04:38:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:54802 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbgBCJi1 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 3 Feb 2020 04:38:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F29E6AC37;
        Mon,  3 Feb 2020 09:38:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 941D61E0D5D; Mon,  3 Feb 2020 10:38:23 +0100 (CET)
Date:   Mon, 3 Feb 2020 10:38:23 +0100
From:   Jan Kara <jack@suse.cz>
To:     Liu Song <fishland@aliyun.com>
Cc:     tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, liu.song11@zte.com.cn
Subject: Re: [RFC PATCH] jbd2: remove unused return value of
 jbd2_journal_cancel_revoke
Message-ID: <20200203093823.GC12938@quack2.suse.cz>
References: <20200130133603.7103-1-fishland@aliyun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130133603.7103-1-fishland@aliyun.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 30-01-20 21:36:03, Liu Song wrote:
> From: Liu Song <liu.song11@zte.com.cn>
> 
> There is no place to use the return value of "jbd2_journal_cancel_revoke",
> so remove it.
> 
> Signed-off-by: Liu Song <liu.song11@zte.com.cn>

OK, makes sense. Thanks for the cleanup. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/revoke.c     | 5 +----
>  include/linux/jbd2.h | 2 +-
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
> index fa608788b93d..f4fe7a171691 100644
> --- a/fs/jbd2/revoke.c
> +++ b/fs/jbd2/revoke.c
> @@ -420,12 +420,11 @@ int jbd2_journal_revoke(handle_t *handle, unsigned long long blocknr,
>   * do not trust the Revoked bit on buffers unless RevokeValid is also
>   * set.
>   */
> -int jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
> +void jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
>  {
>  	struct jbd2_revoke_record_s *record;
>  	journal_t *journal = handle->h_transaction->t_journal;
>  	int need_cancel;
> -	int did_revoke = 0;	/* akpm: debug */
>  	struct buffer_head *bh = jh2bh(jh);
>  
>  	jbd_debug(4, "journal_head %p, cancelling revoke\n", jh);
> @@ -450,7 +449,6 @@ int jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
>  			list_del(&record->hash);
>  			spin_unlock(&journal->j_revoke_lock);
>  			kmem_cache_free(jbd2_revoke_record_cache, record);
> -			did_revoke = 1;
>  		}
>  	}
>  
> @@ -473,7 +471,6 @@ int jbd2_journal_cancel_revoke(handle_t *handle, struct journal_head *jh)
>  			__brelse(bh2);
>  		}
>  	}
> -	return did_revoke;
>  }
>  
>  /*
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index ce44b687d02b..c27716740917 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1470,7 +1470,7 @@ extern int __init jbd2_journal_init_revoke_table_cache(void);
>  
>  extern void	   jbd2_journal_destroy_revoke(journal_t *);
>  extern int	   jbd2_journal_revoke (handle_t *, unsigned long long, struct buffer_head *);
> -extern int	   jbd2_journal_cancel_revoke(handle_t *, struct journal_head *);
> +extern void	   jbd2_journal_cancel_revoke(handle_t *, struct journal_head *);
>  extern void	   jbd2_journal_write_revoke_records(transaction_t *transaction,
>  						     struct list_head *log_bufs);
>  
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
