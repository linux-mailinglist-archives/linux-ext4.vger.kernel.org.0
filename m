Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A22719742
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Jun 2023 11:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbjFAJmR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Jun 2023 05:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjFAJmQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Jun 2023 05:42:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D504134
        for <linux-ext4@vger.kernel.org>; Thu,  1 Jun 2023 02:41:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D9D912190C;
        Thu,  1 Jun 2023 09:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685612516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9BgKzdQxiE2MjPikzt5RxWBbmh+7r/G2sV0ec5gBkm8=;
        b=cDes27wNnYi/IEPXSpDLTAskIFZvW27N46APrySivGn3tCHesQFqzdqfMpgcOGYsESbsRu
        HbTH3v4EKGOEznWKaqgaaHGE+95W+/FsAXlh2+UQo5btACPiGcIn3AbCurNExpkqprlONl
        9uLmLk91K3oXuxZu3itZiy/06TG7OUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685612516;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9BgKzdQxiE2MjPikzt5RxWBbmh+7r/G2sV0ec5gBkm8=;
        b=BdULwq1mi9HzxPuohJf2l/vpEd17t02TKaD6+FVVz/UnnukyogGQxKJXvbRD94Rx6B7QuZ
        vr93Mg4asPsfQ1DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA46A139B7;
        Thu,  1 Jun 2023 09:41:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DHdsMeRneGTILQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 01 Jun 2023 09:41:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5E104A0754; Thu,  1 Jun 2023 11:41:56 +0200 (CEST)
Date:   Thu, 1 Jun 2023 11:41:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        yukuai3@huawei.com, chengzhihao1@huawei.com
Subject: Re: [PATCH 4/5] jbd2: Fix wrongly judgement for buffer head removing
 while doing checkpoint
Message-ID: <20230601094156.m4b7rxntmaxc5zy7@quack3>
References: <20230531115100.2779605-1-yi.zhang@huaweicloud.com>
 <20230531115100.2779605-5-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531115100.2779605-5-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 31-05-23 19:50:59, Zhang Yi wrote:
> From: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> Following process,
> 
> jbd2_journal_commit_transaction
> // there are several dirty buffer heads in transaction->t_checkpoint_list
>           P1                   wb_workfn
> jbd2_log_do_checkpoint
>  if (buffer_locked(bh)) // false
>                             __block_write_full_page
>                              trylock_buffer(bh)
>                              test_clear_buffer_dirty(bh)
>  if (!buffer_dirty(bh))
>   __jbd2_journal_remove_checkpoint(jh)
>    if (buffer_write_io_error(bh)) // false
>                              >> bh IO error occurs <<
>  jbd2_cleanup_journal_tail
>   __jbd2_update_log_tail
>    jbd2_write_superblock
>    // The bh won't be replayed in next mount.
> , which could corrupt the ext4 image, fetch a reproducer in [Link].
> 
> Since writeback process clears buffer dirty after locking buffer head,
> we can fix it by checking buffer dirty firstly and then checking buffer
> locked, the buffer head can be removed if it is neither dirty nor locked.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217490
> Fixes: 470decc613ab ("[PATCH] jbd2: initial copy of files from jbd")
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

OK, the analysis is correct but I'm afraid the fix won't be that easy.  The
reordering of tests you did below doesn't really help because CPU or the
compiler are free to order the loads (and stores) in whatever way they
wish. You'd have to use memory barriers when reading and modifying bh flags
(although the modification side is implicitely handled by the bitlock
code) to make this work reliably. But that is IMHO too subtle for this
code.

What we should be doing to avoid these races is to lock the bh. So
something like:

	if (jh->b_transaction != NULL) {
		do stuff
	}
	if (!trylock_buffer(bh)) {
		buffer_locked() branch
	}
	... Now we have the buffer locked and can safely check for dirtyness

And we need to do a similar treatment for journal_clean_one_cp_list() and
journal_shrink_one_cp_list().

BTW, I think we could merge journal_clean_one_cp_list() and
journal_shrink_one_cp_list() into a single common function. I think we can
drop the nr_to_scan argument and just always cleanup the whole checkpoint
list and return the number of freed buffers. That way we have one less
function to deal with checkpoint list cleaning.

Thinking about it some more maybe we can have a function like:

int jbd2_try_remove_checkpoint(struct journal_head *jh)
{
	struct buffer_head *bh = jh2bh(jh);

	if (!trylock_buffer(bh) || buffer_dirty(bh))
		return -EBUSY;
	/*
	 * Buffer is clean and the IO has finished (we hold the buffer lock) so
	 * the checkpoint is done. We can safely remove the buffer from this
	 * transaction.
	 */
	unlock_buffer(bh);
	return __jbd2_journal_remove_checkpoint(jh);
}

and that can be used with a bit of care in the checkpointing functions as
well as in jbd2_journal_forget(), __journal_try_to_free_buffer(),
journal_unmap_buffer().

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
