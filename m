Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A897E22E7DC
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Jul 2020 10:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgG0Ifr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Jul 2020 04:35:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:60066 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbgG0Ifq (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 27 Jul 2020 04:35:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1E275AC37;
        Mon, 27 Jul 2020 08:35:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BD3691E12C5; Mon, 27 Jul 2020 10:35:44 +0200 (CEST)
Date:   Mon, 27 Jul 2020 10:35:44 +0200
From:   Jan Kara <jack@suse.cz>
To:     Xianting Tian <xianting_tian@126.com>
Cc:     tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jbd2: fix incorrect code style
Message-ID: <20200727083544.GD23179@quack2.suse.cz>
References: <1595077057-8048-1-git-send-email-xianting_tian@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595077057-8048-1-git-send-email-xianting_tian@126.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 18-07-20 08:57:37, Xianting Tian wrote:
> Remove unnecessary blank.
> 
> Signed-off-by: Xianting Tian <xianting_tian@126.com>

Looks fine. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index e494443..5eccf8c 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1285,7 +1285,7 @@ journal_t *jbd2_journal_init_inode(struct inode *inode)
>   * superblock as being NULL to prevent the journal destroy from writing
>   * back a bogus superblock.
>   */
> -static void journal_fail_superblock (journal_t *journal)
> +static void journal_fail_superblock(journal_t *journal)
>  {
>  	struct buffer_head *bh = journal->j_sb_buffer;
>  	brelse(bh);
> @@ -1815,7 +1815,7 @@ int jbd2_journal_destroy(journal_t *journal)
>  
>  
>  /**
> - *int jbd2_journal_check_used_features () - Check if features specified are used.
> + *int jbd2_journal_check_used_features() - Check if features specified are used.
>   * @journal: Journal to check.
>   * @compat: bitmask of compatible features
>   * @ro: bitmask of features that force read-only mount
> @@ -1825,7 +1825,7 @@ int jbd2_journal_destroy(journal_t *journal)
>   * features.  Return true (non-zero) if it does.
>   **/
>  
> -int jbd2_journal_check_used_features (journal_t *journal, unsigned long compat,
> +int jbd2_journal_check_used_features(journal_t *journal, unsigned long compat,
>  				 unsigned long ro, unsigned long incompat)
>  {
>  	journal_superblock_t *sb;
> @@ -1860,7 +1860,7 @@ int jbd2_journal_check_used_features (journal_t *journal, unsigned long compat,
>   * all of a given set of features on this journal.  Return true
>   * (non-zero) if it can. */
>  
> -int jbd2_journal_check_available_features (journal_t *journal, unsigned long compat,
> +int jbd2_journal_check_available_features(journal_t *journal, unsigned long compat,
>  				      unsigned long ro, unsigned long incompat)
>  {
>  	if (!compat && !ro && !incompat)
> @@ -1882,7 +1882,7 @@ int jbd2_journal_check_available_features (journal_t *journal, unsigned long com
>  }
>  
>  /**
> - * int jbd2_journal_set_features () - Mark a given journal feature in the superblock
> + * int jbd2_journal_set_features() - Mark a given journal feature in the superblock
>   * @journal: Journal to act on.
>   * @compat: bitmask of compatible features
>   * @ro: bitmask of features that force read-only mount
> @@ -1893,7 +1893,7 @@ int jbd2_journal_check_available_features (journal_t *journal, unsigned long com
>   *
>   */
>  
> -int jbd2_journal_set_features (journal_t *journal, unsigned long compat,
> +int jbd2_journal_set_features(journal_t *journal, unsigned long compat,
>  			  unsigned long ro, unsigned long incompat)
>  {
>  #define INCOMPAT_FEATURE_ON(f) \
> -- 
> 1.8.3.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
