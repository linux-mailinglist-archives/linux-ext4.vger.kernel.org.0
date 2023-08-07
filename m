Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB7A7725D1
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Aug 2023 15:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbjHGNdl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Aug 2023 09:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbjHGNdk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Aug 2023 09:33:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41D11BE5
        for <linux-ext4@vger.kernel.org>; Mon,  7 Aug 2023 06:33:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 710A8219E1;
        Mon,  7 Aug 2023 13:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691415195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iuPm8Ny4p7lUvkdkwWjnApG/ArVned/LpHLV9/ddKSg=;
        b=wLutDvVcxgPobZwgOuykIAArzBzzd410uaMoplSzu648G3D9eWcmR/MkYAFkBKKQs6yTUB
        g3D80zqY7/3sxd9ZDbqX5tHHNCc9gFJWTxkcCJGZO2lEjf+p9Fz7NU89wrIT/RZm4TA+ZE
        csx96WFiatS9Po1xl7SALl7qipIZHsQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691415195;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iuPm8Ny4p7lUvkdkwWjnApG/ArVned/LpHLV9/ddKSg=;
        b=zyktxEBEzwUO3GYOI3Vo9XGwBGLBYRetkUG40E2Iub9aefg6jWA8W2tkQKlyNmwXBTYFd3
        Y5NYUg9qjEJNAQDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 62E1113910;
        Mon,  7 Aug 2023 13:33:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TNYZGJvy0GTHHgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 07 Aug 2023 13:33:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EA885A076C; Mon,  7 Aug 2023 15:33:14 +0200 (CEST)
Date:   Mon, 7 Aug 2023 15:33:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 07/12] jbd2: add fast_commit space check
Message-ID: <20230807133314.sjkpdrluvvzgpotx@quack3>
References: <20230704134233.110812-1-yi.zhang@huaweicloud.com>
 <20230704134233.110812-8-yi.zhang@huaweicloud.com>
 <20230803143825.f364hmpsgqbzvjwo@quack3>
 <d23c42ce-32d1-79c3-63b2-0bfbc3af924c@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d23c42ce-32d1-79c3-63b2-0bfbc3af924c@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 07-08-23 18:53:09, Zhang Yi wrote:
> On 2023/8/3 22:38, Jan Kara wrote:
> > On Tue 04-07-23 21:42:28, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> If JBD2_FEATURE_INCOMPAT_FAST_COMMIT bit is set, it means the journal
> >> have fast commit records need to recover, so the fast commit size
> >> should not be zero, and also the leftover normal journal size should
> >> never less than JBD2_MIN_JOURNAL_BLOCKS. Add a check into the
> >> journal_check_superblock() and drop the pointless branch when
> >> initializing in-memory fastcommit parameters.
> >>
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> > 
> > Some comments below.
> > 
> > 
> >> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> >> index efdb8db3c06e..210b532a3673 100644
> >> --- a/fs/jbd2/journal.c
> >> +++ b/fs/jbd2/journal.c
> >> @@ -1392,6 +1392,18 @@ static int journal_check_superblock(journal_t *journal)
> >>  		return err;
> >>  	}
> >>  
> >> +	if (jbd2_has_feature_fast_commit(journal)) {
> >> +		int num_fc_blks = be32_to_cpu(sb->s_num_fc_blks);
> >> +
> >> +		if (!num_fc_blks ||
> >> +		    (be32_to_cpu(sb->s_maxlen) - num_fc_blks <
> >> +		     JBD2_MIN_JOURNAL_BLOCKS)) {
> >> +			printk(KERN_ERR "JBD2: Invalid fast commit size %d\n",
> >> +			       num_fc_blks);
> >> +			return err;
> >> +		}
> > 
> > This is wrong sb->s_num_fc_blks == 0 means that the fast-commit area should
> > have the default size of 256 blocks. At least that's how it behaves
> > currently and we should not change the behavior.
> 
> Thanks for the review and correcting me. I missed the fc_debug_force
> mount option, this option enable fast commit feature without init
> sb->s_num_fc_blks to disk, so it could left over an unclean image with
> fast_commit feature but sb->s_num_fc_blks is still zero. And the mke2fs
> could also set sb->s_num_fc_blks to 0.

Yes.

> > Similarly if the number of fastcommit blocks was too big (i.e. there was
> > not enough space left for ordinary journal), we effectively silently
> > disable fastcommit and you break this behavior in this patch.
> > 
> 
> If the fastcommit is too big, jbd2_journal_initialize_fast_commit()
> will detect this corruption and refuse to mount.
> 
> [ 1213.810719] JBD2: Cannot enable fast commits.
> [ 1213.812282] EXT4-fs (pmem1): Failed to set fast commit journal feature
> 
> It only silently disable fastcommit while recovering the journal, but it
> doesn't seem to make much sense, because the journal->j_last is likely to
> be wrong (not point to the correct end of normal journal range) and will
> probably lead to incorrect recovery. It seems better to report the error
> and exit as early as possible. So I suppose we could keep this "too big"
> check in journal_check_superblock(). How does that sound ?

Ah, you are right. So let's keep the "space for journal too small" check as
you suggest.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
