Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B544D2CFA
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Mar 2022 11:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiCIKUu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Mar 2022 05:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiCIKUt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Mar 2022 05:20:49 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A00114F998
        for <linux-ext4@vger.kernel.org>; Wed,  9 Mar 2022 02:19:50 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5987321111;
        Wed,  9 Mar 2022 10:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646821189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kKI5oPSnP9OBhXrhlOhmUK7WzBrUgn9TY08XHlpKTsw=;
        b=W77b6KinWt6gXnLXsBzxK+CoZ/KnbbxI0WkAVBPYrXrw/wXHEKVLwbN3Tv7f/2H5npGt2s
        eD6g1/viabtd+mt+rVF1+uLXl7IAgP64h0GFuw8Kn+lv07Pcd0tnVUpadq/R3mytjkpgC6
        dJaxgxcu2WQmwUOUZ6OZbXQCdsrP+LM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646821189;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kKI5oPSnP9OBhXrhlOhmUK7WzBrUgn9TY08XHlpKTsw=;
        b=qZlowEGBneZOhG5nKOiIC31kCy8EO7GAUswB4fngOzCtnoSmQ4hsvvEezJBcct8PqeUgGM
        jaje1YQzgouNCGAg==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 428BAA3B81;
        Wed,  9 Mar 2022 10:19:49 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6280CA060B; Wed,  9 Mar 2022 11:19:47 +0100 (CET)
Date:   Wed, 9 Mar 2022 11:19:47 +0100
From:   Jan Kara <jack@suse.cz>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, riteshh@linux.ibm.com, jack@suse.cz,
        tytso@mit.edu
Subject: Re: [PATCH v2 5/5] ext4: update code documentation
Message-ID: <20220309101947.66pcot5qhxvtydha@quack3.lan>
References: <20220308163319.1183625-1-harshads@google.com>
 <20220308163319.1183625-6-harshads@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308163319.1183625-6-harshads@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 08-03-22 08:33:19, Harshad Shirwadkar wrote:
> From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> 
> This patch updates code documentation to reflect the commit path changes
> made in this series.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/fast_commit.c | 36 ++++++++++++++++++++++--------------
>  1 file changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index eea19e3ea9ba..c14e6d34d552 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -49,14 +49,21 @@
>   * that need to be committed during a fast commit in another in memory queue of
>   * inodes. During the commit operation, we commit in the following order:
>   *
> - * [1] Lock inodes for any further data updates by setting COMMITTING state
> - * [2] Submit data buffers of all the inodes
> - * [3] Wait for [2] to complete
> - * [4] Commit all the directory entry updates in the fast commit space
> - * [5] Commit all the changed inode structures
> - * [6] Write tail tag (this tag ensures the atomicity, please read the following
> + * [1] Lock the journal by calling jbd2_journal_lock_updates. This ensures that
> + *     all the exsiting handles finish and no new handles can start.
> + * [2] Mark all the fast commit eligible inodes as undergoing fast commit
> + *     by setting "EXT4_STATE_FC_COMMITTING" state.
> + * [3] Unlock the journal by calling jbd2_journal_unlock_updates. This allows
> + *     starting of new handles. If new handles try to start an update on
> + *     any of the inodes that are being committed, ext4_fc_track_inode()
> + *     will block until those inodes have finished the fast commit.
> + * [4] Submit data buffers of all the committing inodes.
> + * [5] Wait for [4] to complete.
> + * [6] Commit all the directory entry updates in the fast commit space.
> + * [7] Commit all the changed inodes in the fast commit space and clear
> + *     "EXT4_STATE_FC_COMMITTING" for these inodes.
> + * [8] Write tail tag (this tag ensures the atomicity, please read the following
>   *     section for more details).
> - * [7] Wait for [4], [5] and [6] to complete.
>   *
>   * All the inode updates must call ext4_fc_start_update() before starting an
>   * update. If such an ongoing update is present, fast commit waits for it to
> @@ -142,6 +149,13 @@
>   * similarly. Thus, by converting a non-idempotent procedure into a series of
>   * idempotent outcomes, fast commits ensured idempotence during the replay.
>   *
> + * Locking
> + * -------
> + * sbi->s_fc_lock protects the fast commit inodes queue and the fast commit
> + * dentry queue. ei->i_fc_lock protects the fast commit related info in a given
> + * inode. Most of the code avoids acquiring both the locks, but if one must do
> + * that then sbi->s_fc_lock must be acquired before ei->i_fc_lock.
> + *
>   * TODOs
>   * -----
>   *
> @@ -156,13 +170,7 @@
>   *    fast commit recovery even if that area is invalidated by later full
>   *    commits.
>   *
> - * 1) Fast commit's commit path locks the entire file system during fast
> - *    commit. This has significant performance penalty. Instead of that, we
> - *    should use ext4_fc_start/stop_update functions to start inode level
> - *    updates from ext4_journal_start/stop. Once we do that we can drop file
> - *    system locking during commit path.
> - *
> - * 2) Handle more ineligible cases.
> + * 1) Handle more ineligible cases.
>   */
>  
>  #include <trace/events/ext4.h>
> -- 
> 2.35.1.616.g0bdcbb4464-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
