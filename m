Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993CC6629E5
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Jan 2023 16:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbjAIP32 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Jan 2023 10:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbjAIP30 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Jan 2023 10:29:26 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405082A9;
        Mon,  9 Jan 2023 07:29:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CE7F2473A;
        Mon,  9 Jan 2023 15:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673278163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PJYHHfpKQfZuhLtjjw+kUkQXCPxXzCZB8sqhX5HJNgo=;
        b=x9pQuwXJ31ktFed7cyEQ12sm9EAV/j86D6Ujx0xF3xC+Y8ns4fo31HzV7LAXAHx3i5i1EP
        2dRH3dUnOUb3vrOIZaaJpsCgzquh1D+KL6gsODN2a8aZH8AOTDroE+sZeO3gRnrVTFsjuU
        oa1x0oFlUSsDvpkLpTlAuSrXltxW7WM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673278163;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PJYHHfpKQfZuhLtjjw+kUkQXCPxXzCZB8sqhX5HJNgo=;
        b=y/4a8+JRD2hBzINbYxlPFsJm045dGsAdcJMrmBgaPIs34D1EzQaSc1ooYXUk2znk9pBw90
        UfOCN9HbXulg35CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB97A134AD;
        Mon,  9 Jan 2023 15:29:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id p3DFLdMyvGNbUQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 09 Jan 2023 15:29:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 33035A0749; Mon,  9 Jan 2023 16:29:23 +0100 (CET)
Date:   Mon, 9 Jan 2023 16:29:23 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        libaokun1@huawei.com, zhanchengbin1@huawei.com
Subject: Re: [PATCH -next v3] jbd2: Fix data missing when reusing bh which is
 ready to be checkpointed
Message-ID: <20230109152923.fvx57xucg2vggzp6@quack3>
References: <20230109134545.2234414-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109134545.2234414-1-chengzhihao1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 09-01-23 21:45:45, Zhihao Cheng wrote:
> Following process will make data lost and could lead to a filesystem
> corrupted problem:
> 
> 1. jh(bh) is inserted into T1->t_checkpoint_list, bh is dirty, and
>    jh->b_transaction = NULL
> 2. T1 is added into journal->j_checkpoint_transactions.
> 3. Get bh prepare to write while doing checkpoing:
>            PA				    PB
>    do_get_write_access             jbd2_log_do_checkpoint
>     spin_lock(&jh->b_state_lock)
>      if (buffer_dirty(bh))
>       clear_buffer_dirty(bh)   // clear buffer dirty
>        set_buffer_jbddirty(bh)
> 				    transaction =
> 				    journal->j_checkpoint_transactions
> 				    jh = transaction->t_checkpoint_list
> 				    if (!buffer_dirty(bh))
> 		                      __jbd2_journal_remove_checkpoint(jh)
> 				      // bh won't be flushed
> 		                    jbd2_cleanup_journal_tail
>     __jbd2_journal_file_buffer(jh, transaction, BJ_Reserved)
> 4. Aborting journal/Power-cut before writing latest bh on journal area.
> 
> In this way we get a corrupted filesystem with bh's data lost.
> 
> Fix it by moving the clearing of buffer_dirty bit just before the call
> to __jbd2_journal_file_buffer(), both bit clearing and jh->b_transaction
> assignment are under journal->j_list_lock locked, so that
> jbd2_log_do_checkpoint() will wait until jh's new transaction fininshed
> even bh is currently not dirty. And journal_shrink_one_cp_list() won't
> remove jh from checkpoint list if the buffer head is reused in
> do_get_write_access().
> 
> Fetch a reproducer in [Link].
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216898
> Cc: <stable@kernel.org>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
> Suggested-by: Jan Kara <jack@suse.cz>

Great, the patch looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Just a suggestion for rephrasing of the comment below

> -		/*
> -		 * In any case we need to clean the dirty flag and we must
> -		 * do it under the buffer lock to be sure we don't race
> -		 * with running write-out.
> +		 * We need to clean the dirty flag and we must do it under the
> +		 * buffer lock to be sure we don't race with running write-out.
>  		 */
>  		JBUFFER_TRACE(jh, "Journalling dirty buffer");
>  		clear_buffer_dirty(bh);
> +		/*
> +		 * Setting jbddirty after clearing buffer dirty is necessary.
> +		 * Function jbd2_journal_restart() could keep buffer on
> +		 * BJ_Reserved list until the transaction committing, then the
> +		 * buffer won't be dirtied by jbd2_journal_refile_buffer()
> +		 * after committing, the buffer couldn't fall on disk even
> +		 * last checkpoint finished, which may corrupt filesystem.
> +		 */

As far as I understand you want to say:
		/*
		 * The buffer is going to be added to BJ_Reserved list now
		 * and nothing guarantees jbd2_journal_dirty_metadata()
		 * will be ever called for it. So we need to set jbddirty
		 * bit here to make sure the buffer is dirtied and written
		 * out when the journaling machinery is done with it.
		 */

>  		set_buffer_jbddirty(bh);
>  	}

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
