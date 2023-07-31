Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95A5769C0E
	for <lists+linux-ext4@lfdr.de>; Mon, 31 Jul 2023 18:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjGaQPE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 31 Jul 2023 12:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjGaQPD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 31 Jul 2023 12:15:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9458DA7
        for <linux-ext4@vger.kernel.org>; Mon, 31 Jul 2023 09:15:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 539C51F74C;
        Mon, 31 Jul 2023 16:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1690820101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SGuud7a7aLdlXTTjWteXYdue7LAtwq6mK5VCy+sYByY=;
        b=jcYp75DfC0CRpBJnK4N7V//lJECmWehxScHZoU1IR3RkSPonJirlI/mHnvre8256moKJnL
        6eVlVbGFRmpMvF1a6hUsnY8xw2zP8hBni6Hg7kjsuhy2g1vVaGaL/g+ow6MlY2CdhZiEr0
        e4gaDgxAzPqH8g/rrOCz/kBEne4bwYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1690820101;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SGuud7a7aLdlXTTjWteXYdue7LAtwq6mK5VCy+sYByY=;
        b=iRnIMK1QoqI5doY1tjx9jiZie8OqIeiqRY2d6lvX460Vw58ZzgKifEFtcJoIZSV11hA+HG
        J+iDVMSBhHLiprDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 442361322C;
        Mon, 31 Jul 2023 16:15:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NHeVEAXex2TlDQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 31 Jul 2023 16:15:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C1BB6A075D; Mon, 31 Jul 2023 18:15:00 +0200 (CEST)
Date:   Mon, 31 Jul 2023 18:15:00 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yang.lee@linux.alibaba.com,
        yukuai3@huawei.com
Subject: Re: [PATCH 2/3] jbd2: Check 'jh->b_transaction' before remove it
 from checkpoint
Message-ID: <20230731161500.dm7nf3kpxbvfxa5y@quack3>
References: <20230714025528.564988-1-yi.zhang@huaweicloud.com>
 <20230714025528.564988-3-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230714025528.564988-3-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 14-07-23 10:55:27, Zhang Yi wrote:
> From: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> Following process will corrupt ext4 image:
> Step 1:
> jbd2_journal_commit_transaction
>  __jbd2_journal_insert_checkpoint(jh, commit_transaction)
>  // Put jh into trans1->t_checkpoint_list
>  journal->j_checkpoint_transactions = commit_transaction
>  // Put trans1 into journal->j_checkpoint_transactions
> 
> Step 2:
> do_get_write_access
>  test_clear_buffer_dirty(bh) // clear buffer dirty，set jbd dirty
>  __jbd2_journal_file_buffer(jh, transaction) // jh belongs to trans2
> 
> Step 3:
> drop_cache
>  journal_shrink_one_cp_list
>   jbd2_journal_try_remove_checkpoint
>    if (!trylock_buffer(bh))  // lock bh, true
>    if (buffer_dirty(bh))     // buffer is not dirty
>    __jbd2_journal_remove_checkpoint(jh)
>    // remove jh from trans1->t_checkpoint_list
> 
> Step 4:
> jbd2_log_do_checkpoint
>  trans1 = journal->j_checkpoint_transactions
>  // jh is not in trans1->t_checkpoint_list
>  jbd2_cleanup_journal_tail(journal)  // trans1 is done
> 
> Step 5: Power cut, trans2 is not committed, jh is lost in next mounting.
> 
> Fix it by checking 'jh->b_transaction' before remove it from checkpoint.
> 
> Fixes: 46f881b5b175 ("jbd2: fix a race when checking checkpoint buffer busy")
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Indeed! I've missed this difference between __cp_buffer_busy() and
jbd2_journal_try_remove_checkpoint() during my review of 46f881b5b175. The
fix looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/checkpoint.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index 936c6d758a65..f033ac807013 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -639,6 +639,8 @@ int jbd2_journal_try_remove_checkpoint(struct journal_head *jh)
>  {
>  	struct buffer_head *bh = jh2bh(jh);
>  
> +	if (jh->b_transaction)
> +		return -EBUSY;
>  	if (!trylock_buffer(bh))
>  		return -EBUSY;
>  	if (buffer_dirty(bh)) {
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
