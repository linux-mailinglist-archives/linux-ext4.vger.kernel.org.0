Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9B45A1305
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Aug 2022 16:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240663AbiHYOLT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 25 Aug 2022 10:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241057AbiHYOLQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 25 Aug 2022 10:11:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C058B2FA;
        Thu, 25 Aug 2022 07:11:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5C38633BC8;
        Thu, 25 Aug 2022 14:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661436668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tl5mr7Orfciz8580Kvvafn34WntciMWhPUTK5y7gOSE=;
        b=haq1wmc25epJ/iMb1dVs9tLxYMS9sY750TcXzlFNLYPze+yYVeLqdR4DajyfAXdd2vUeiK
        Y4KubJVnTPjaFNHZqc/QyOYjMbLd8Z0kp7a0fYzdNBWw6JDRwhvcM85mypsaCZf4xq7zSa
        aUd+/NsR9sVb6siomWFO/CnHZKslwYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661436668;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tl5mr7Orfciz8580Kvvafn34WntciMWhPUTK5y7gOSE=;
        b=f6y/Gxq94eKvWk0UYr80AFUcw7lsiHfeKsr5qQw9NfiLCm/yUwDebA1qpn7x1COaoJnGu2
        OoRRSRFXQ0ctGrDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4925713517;
        Thu, 25 Aug 2022 14:11:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id apTOEfyCB2O7RAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 25 Aug 2022 14:11:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D0CACA0679; Thu, 25 Aug 2022 16:11:07 +0200 (CEST)
Date:   Thu, 25 Aug 2022 16:11:07 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        akpm@linux-foundation.org, mgorman@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH] mm: migrate: buffer_migrate_folio_norefs() fallback
 migrate not uptodate pages
Message-ID: <20220825141107.f2ntf77pekeepfty@quack3>
References: <20220825080146.2021641-1-chengzhihao1@huawei.com>
 <20220825105704.e46hz6dp6opawsjk@quack3>
 <6db0b93a-76d8-e936-c57e-17cb192224f2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6db0b93a-76d8-e936-c57e-17cb192224f2@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 25-08-22 19:32:09, Zhihao Cheng wrote:
> 在 2022/8/25 18:57, Jan Kara 写道:
> > On Thu 25-08-22 16:01:46, Zhihao Cheng wrote:
> > > From: Zhang Yi <yi.zhang@huawei.com>
> > > 
> > > Recently we notice that ext4 filesystem occasionally fail to read
> > > metadata from disk and report error message, but the disk and block
> > > layer looks fine. After analyse, we lockon commit 88dbcbb3a484
> > > ("blkdev: avoid migration stalls for blkdev pages"). It provide a
> > > migration method for the bdev, we could move page that has buffers
> > > without extra users now, but it will lock the buffers on the page, which
> > > breaks a lot of current filesystem's fragile metadata read operations,
> > > like ll_rw_block() for common usage and ext4_read_bh_lock() for ext4,
> > > these helpers just trylock the buffer and skip submit IO if it lock
> > > failed, many callers just wait_on_buffer() and conclude IO error if the
> > > buffer is not uptodate after buffer unlocked.
> > > 
> > > This issue could be easily reproduced by add some delay just after
> > > buffer_migrate_lock_buffers() in __buffer_migrate_folio() and do
> > > fsstress on ext4 filesystem.
> > > 
> > >    EXT4-fs error (device pmem1): __ext4_find_entry:1658: inode #73193:
> > >    comm fsstress: reading directory lblock 0
> > >    EXT4-fs error (device pmem1): __ext4_find_entry:1658: inode #75334:
> > >    comm fsstress: reading directory lblock 0
> > > 
> > > Something like ll_rw_block() should be used carefully and seems could
> > > only be safely used for the readahead case. So the best way is to fix
> > > the read operations in filesystem in the long run, but now let us avoid
> > > this issue first. This patch avoid this issue by fallback to migrate
> > > pages that are not uotodate like fallback_migrate_folio(), those pages
> > > that has buffers may probably do read operation soon.
> > > 
> > > Fixes: 88dbcbb3a484 ("blkdev: avoid migration stalls for blkdev pages")
> > > Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> > > Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> > 
> > Thanks for the analysis and the fix! As you noted above this is actually a
> > bug in the filesystems that they assume that locked buffer means it is
> > under IO.  Usually that is the case but there are other places that lock
> > the buffer without doing IO. Page migration is one of them, jbd2 machinery
> > another one, there may be others.
> > 
> > So I think this really ought to be fixed in filesystems instead of papering
> > over the bug in the migration code. I agree this is more work but we will
> > reduce the technical debt, not increase it :). Honestly, ll_rw_block()
> > should just die. It is actively dangerous to use. Instead we should have
> > one call for readahead of bhs and the rest should be converted to
> > submit_bh() or similar calls. There are like 25 callers remaining so it
> > won't be even that hard.
> > 
> > And then we have the same buggy code as in ll_rw_block() copied to
> > ext4_bread_batch() (ext4_read_bh_lock() in particular) so that needs to be
> > fixed as well...
> > 
> > 								Honza
> 
> You are right, Jan. I totally agree with you. It seems that I shouldn't have
> been lazy.

If you face any issues with this, feel free to email me. I'll be happy to
help :).

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
