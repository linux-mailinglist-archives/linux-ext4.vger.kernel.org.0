Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFF62A4BBD
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Nov 2020 17:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgKCQiw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Nov 2020 11:38:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:52366 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgKCQiv (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 3 Nov 2020 11:38:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C1396ADDB;
        Tue,  3 Nov 2020 16:38:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6ADF91E12FB; Tue,  3 Nov 2020 17:38:50 +0100 (CET)
Date:   Tue, 3 Nov 2020 17:38:50 +0100
From:   Jan Kara <jack@suse.cz>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz
Subject: Re: [PATCH 05/10] jbd2: fix fast commit journalling APIs
Message-ID: <20201103163850.GI3440@quack2.suse.cz>
References: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
 <20201031200518.4178786-6-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031200518.4178786-6-harshadshirwadkar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 31-10-20 13:05:13, Harshad Shirwadkar wrote:
> This patch adds a few misc fixes for jbd2 fast commit functions.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Please no "misc fixes" patches. If you have trouble writing good
explanatory changelog, it's usually a sign you're trying to cram too much
into a single commit :). In this case I'd split it into 3 changes:

1) TODO update.
2) Removal of j_state_lock protection (with comment updates)
3) Fix of journal->j_running_transaction->t_tid handling.

> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 9b4e87a0068b..df1285da7276 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -946,7 +946,9 @@ struct journal_s
>  	 * @j_fc_off:
>  	 *
>  	 * Number of fast commit blocks currently allocated.
> -	 * [j_state_lock].
> +	 * [j_state_lock]. During the commit path, this variable is not

Please remove the [j_state_lock] annotation when the entry isn't really
protected by j_state_lock... Also I'd maybe rephrase the comment like
"Accessed only during fastcommit, currenly only a single process can
perform fastcommit at a time."

> +	 * protected by j_state_lock since only one process performs commit
> +	 * at a time.
>  	 */
>  	unsigned long		j_fc_off;
>  
> @@ -1110,7 +1112,9 @@ struct journal_s
>  
>  	/**
>  	 * @j_fc_wbuf: Array of fast commit bhs for
> -	 * jbd2_journal_commit_transaction.
> +	 * jbd2_journal_commit_transaction. During the commit path, this
> +	 * variable is not protected by j_state_lock since only one process
> +	 * performs commit at a time.
>  	 */
>  	struct buffer_head	**j_fc_wbuf;

Here the bh's aren't really used in jbd2_journal_commit_transaction() are
they? Please fix that when updating the comment. Also I'd find a
reformulation like I suggested for the comment above more comprehensible.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
