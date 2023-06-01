Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C46871EF07
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Jun 2023 18:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjFAQb1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Jun 2023 12:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjFAQb0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Jun 2023 12:31:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F92912C
        for <linux-ext4@vger.kernel.org>; Thu,  1 Jun 2023 09:31:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7685B1FDB4;
        Thu,  1 Jun 2023 16:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685637082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DCACy05Wl0giRQVOmv6yFaI8mWWnzdRymJdDTQkLh4I=;
        b=Rw65AGoIPOiCQGm4sgMEVhOd8h4OK2dng5lRPUcUeyC4GMel2vjLAvmn7Y1uWAacb7QAb9
        tATB34eXAv1u+IEKQraCy/l8fCzB3M188ZSKp8lAK7qfmBijGewZmBv0XM8/lht47+dUoL
        GiYe8rRdFFVH6Wxl6zPPJbR0uCh2900=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685637082;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DCACy05Wl0giRQVOmv6yFaI8mWWnzdRymJdDTQkLh4I=;
        b=chQbdQQeOW2b4uwAsmfVS1lI73Yhe2AT0AfRGROCblOlZkauEBesxESJBISOapzZQz4vvZ
        jfeqxGXO/To2JXAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 672EA13441;
        Thu,  1 Jun 2023 16:31:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pS8ZGdrHeGRYDQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 01 Jun 2023 16:31:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DFBDEA0754; Thu,  1 Jun 2023 18:31:21 +0200 (CEST)
Date:   Thu, 1 Jun 2023 18:31:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     Zhihao Cheng <chengzhihao1@huawei.com>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, yi.zhang@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 4/5] jbd2: Fix wrongly judgement for buffer head removing
 while doing checkpoint
Message-ID: <20230601163121.jjdo4f2xfpfx6dzi@quack3>
References: <20230531115100.2779605-1-yi.zhang@huaweicloud.com>
 <20230531115100.2779605-5-yi.zhang@huaweicloud.com>
 <20230601094156.m4b7rxntmaxc5zy7@quack3>
 <d73ecd71-cb4f-921f-2284-d756c68e084c@huawei.com>
 <ee706b3e-2a87-fa1a-570b-64870d5e49ad@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee706b3e-2a87-fa1a-570b-64870d5e49ad@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 01-06-23 22:20:38, Zhang Yi wrote:
> On 2023/6/1 21:44, Zhihao Cheng wrote:
> > 在 2023/6/1 17:41, Jan Kara 写道:
> > 
> > Hi, Jan
> >> On Wed 31-05-23 19:50:59, Zhang Yi wrote:
> >>> From: Zhihao Cheng <chengzhihao1@huawei.com>
> >>>
> >>> Following process,
> >>>
> >>> jbd2_journal_commit_transaction
> >>> // there are several dirty buffer heads in transaction->t_checkpoint_list
> >>>            P1                   wb_workfn
> >>> jbd2_log_do_checkpoint
> >>>   if (buffer_locked(bh)) // false
> >>>                              __block_write_full_page
> >>>                               trylock_buffer(bh)
> >>>                               test_clear_buffer_dirty(bh)
> >>>   if (!buffer_dirty(bh))
> >>>    __jbd2_journal_remove_checkpoint(jh)
> >>>     if (buffer_write_io_error(bh)) // false
> >>>                               >> bh IO error occurs <<
> >>>   jbd2_cleanup_journal_tail
> >>>    __jbd2_update_log_tail
> >>>     jbd2_write_superblock
> >>>     // The bh won't be replayed in next mount.
> >>> , which could corrupt the ext4 image, fetch a reproducer in [Link].
> >>>
> >>> Since writeback process clears buffer dirty after locking buffer head,
> >>> we can fix it by checking buffer dirty firstly and then checking buffer
> >>> locked, the buffer head can be removed if it is neither dirty nor locked.
> >>>
> >>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217490
> >>> Fixes: 470decc613ab ("[PATCH] jbd2: initial copy of files from jbd")
> >>> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> >>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> OK, the analysis is correct but I'm afraid the fix won't be that easy.  The
> >> reordering of tests you did below doesn't really help because CPU or the
> >> compiler are free to order the loads (and stores) in whatever way they
> >> wish. You'd have to use memory barriers when reading and modifying bh flags
> >> (although the modification side is implicitely handled by the bitlock
> >> code) to make this work reliably. But that is IMHO too subtle for this
> >> code.
> >>
> > 
> 
> I write two litmus-test files in tools/memory-model to check the memory module
> of these two cases as jbd2_log_do_checkpoint() and __cp_buffer_busy() does.

<snip litmus tests>

> So it looks like the out-of-order situation cannot happen, am I miss something?

After thinking about it a bit, indeed CPU cannot reorder the two loads
because they are from the same location in memory. Thanks for correcting me
on this. I'm not sure whether a C compiler still could not reorder the
tests - technically I suspect the C standard does not forbid this although
it would have to be really evil compiler to do this.

But still I think with the helper function I've suggested things are much
more obviously correct.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
