Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67A159994D
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Aug 2022 11:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347621AbiHSJyu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Aug 2022 05:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347994AbiHSJyt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 19 Aug 2022 05:54:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2697BD29A;
        Fri, 19 Aug 2022 02:54:47 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AD9FF2039E;
        Fri, 19 Aug 2022 09:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660902886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Q54JXCNotWERiCcxvQsCHSyjXD6Kf9u7nD//FnXk4s=;
        b=LBv+AI73mXvdEglEKHu8kyv0tWtXZZowhEE1yoft4OYFKyE0zaLbn7mT/TaonJcl6zrX1H
        /cVYpadRlLHBW+xRTFGrCtbB+FVi87v28Ewmsa0NCzjqnzsMojacD19jepx0gZYkp1Cw8w
        YONEL5Lx1omxsMhvptwhd0FBL+pvFYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660902886;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Q54JXCNotWERiCcxvQsCHSyjXD6Kf9u7nD//FnXk4s=;
        b=S+yw4eBoiC4pbuzoQIcZbYNonD7bNa4h3OqnIuu+ullNfhAPEikc6mKMVUs6LKs6qh2snK
        h9Czbe483ZDBpaCQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2649A2C141;
        Fri, 19 Aug 2022 09:54:46 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B2665A0635; Fri, 19 Aug 2022 11:54:45 +0200 (CEST)
Date:   Fri, 19 Aug 2022 11:54:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH RFC] jbd2: detect old record when do journal scan
Message-ID: <20220819095445.yq4d2qhrhb73p3zk@quack3>
References: <20220810013442.3474533-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810013442.3474533-1-yebin10@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 10-08-22 09:34:42, Ye Bin wrote:
> As https://github.com/tytso/e2fsprogs/issues/120 describe tune2fs do not update
> j_tail_sequence when do journal recovery. This maybe recover old journal record,
> then will lead to file system corruption.
> To avoid file system corruption in this case, if detect current transaction's
> commit time earlier than previous transaction's commit time when do journal
> scan, just return error.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Thanks for the patch! Let me see if I understand your concern right. You
are concerned about the following scenario:

1) Kernel uses the filesystem, there's a crash.
2) E2fsprogs replays the journal but fails to update sb->s_sequence in the
journal superblock.
3) Kernel mounts the fs again - however note that even if kernel skips
recovery, it does scan the journal jbd2_journal_skip_recovery() and
journal->j_transaction_sequence is set based on the last transaction found
in the journal.

So I don't think there is really possibility we will quickly reuse some
transaction IDs and thus possibility of corruption on replay? Am I missing
something?

								Honza


> ---
>  fs/jbd2/recovery.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index f548479615c6..f3def21a96a5 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -812,8 +812,17 @@ static int do_one_pass(journal_t *journal,
>  					break;
>  				}
>  			}
> -			if (pass == PASS_SCAN)
> +			if (pass == PASS_SCAN) {
> +				if (commit_time < last_trans_commit_time) {
> +					pr_err("JBD2: old journal record found "
> +					       "in transaction %u\n",
> +					       next_commit_ID);
> +					err = -EFSBADCRC;
> +					brelse(bh);
> +					goto failed;
> +				}
>  				last_trans_commit_time = commit_time;
> +			}
>  			brelse(bh);
>  			next_commit_ID++;
>  			continue;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
