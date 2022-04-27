Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A66751213E
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Apr 2022 20:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240348AbiD0Pzo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Apr 2022 11:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240503AbiD0Pxw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Apr 2022 11:53:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED6B54F8F
        for <linux-ext4@vger.kernel.org>; Wed, 27 Apr 2022 08:50:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8B47C210F4;
        Wed, 27 Apr 2022 15:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651074636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=heKopi47f9pKe9eE0I4ebeW27yRXRnoWXGqNjuRsuVg=;
        b=KeViPxciFa7FopQyGzZy5wDIK8fZRfChmG/B/tjqNRwciwdKIZ3ua2uycVTsaOlttsxxR6
        4RaAr/L+19ietn1V3YEX02vR2McUbBNNkO5LhLtRX+jedYdfkirwzClCX3vcNyw5+fXxOH
        bO1TZdjfV3UeAfNVe7f2xeJeSNf+his=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651074636;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=heKopi47f9pKe9eE0I4ebeW27yRXRnoWXGqNjuRsuVg=;
        b=Tp21fA591TUSpNBh5T13LNIXgI62OBW87zHv8lSNKnz7M1dmfAIs/q8T8sAd6hnkjcGdv5
        mGinPZoGqnbiSbAA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 73CEE2C143;
        Wed, 27 Apr 2022 15:50:36 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 86F3FA0639; Wed, 27 Apr 2022 17:50:32 +0200 (CEST)
Date:   Wed, 27 Apr 2022 17:50:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, riteshh@linux.ibm.com, jack@suse.cz,
        tytso@mit.edu
Subject: Re: [PATCH v3 2/6] ext4: for committing inode, make
 ext4_fc_track_inode wait
Message-ID: <20220427155032.pikb3jdb62732xvi@quack3.lan>
References: <20220419173143.3564144-1-harshads@google.com>
 <20220419173143.3564144-3-harshads@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419173143.3564144-3-harshads@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 19-04-22 10:31:39, Harshad Shirwadkar wrote:
> From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> 
> If the inode that's being requested to track using ext4_fc_track_inode
> is being committed, then wait until the inode finishes the
> commit. Also, add calls to ext4_fc_track_inode at the right places.
> 
> With this patch, now calling ext4_reserve_inode_write() results in
> inode being tracked for next fast commit. A subtle lock ordering
> requirement with i_data_sem (which is documented in the code) requires
> that ext4_fc_track_inode() be called before grabbing i_data_sem. So,
> this patch also adds explicit ext4_fc_track_inode() calls in places
> where i_data_sem grabbed.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> ---
>  fs/ext4/fast_commit.c | 38 ++++++++++++++++++++++++++++++++++++++
>  fs/ext4/inline.c      |  3 +++
>  fs/ext4/inode.c       |  5 ++++-
>  3 files changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index c278060a15bc..55f4c5ddd8e5 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> +	/*
> +	 * If we come here, we may sleep while waiting for the inode to
> +	 * commit. We shouldn't be holding i_data_sem in write mode when we go
> +	 * to sleep since the commit path needs to grab the lock while
> +	 * committing the inode.
> +	 */
> +	WARN_ON(lockdep_is_held_type(&ei->i_data_sem, 1));

Note that we can deadlock even if we had i_data_sem for reading because
another reader is not allowed to get the rwsem if there is writer waiting
for it. So we need to check even that case here.

> +	while (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
> +#if (BITS_PER_LONG < 64)
> +		DEFINE_WAIT_BIT(wait, &ei->i_state_flags,
> +				EXT4_STATE_FC_COMMITTING);
> +		wq = bit_waitqueue(&ei->i_state_flags,
> +				   EXT4_STATE_FC_COMMITTING);
> +#else
> +		DEFINE_WAIT_BIT(wait, &ei->i_flags,
> +				EXT4_STATE_FC_COMMITTING);
> +		wq = bit_waitqueue(&ei->i_flags,
> +				   EXT4_STATE_FC_COMMITTING);
> +#endif
> +		prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
> +		if (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING))
> +			schedule();
> +		finish_wait(wq, &wait.wq_entry);
> +	}
> +
>  	ret = ext4_fc_track_template(handle, inode, __track_inode, NULL, 1);
>  	trace_ext4_fc_track_inode(handle, inode, ret);

As we discussed in the call we should tell lockdep that this is equivalent
to lock+unlock of let's say fc_committing_lock and the fastcommit code
setting / clearing EXT4_STATE_FC_COMMITTING is equivalent to lock / unlock
of fc_committing_lock. That way we get proper lockdep tracking of this
waiting primitive.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
