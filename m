Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2099E4D174B
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Mar 2022 13:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346727AbiCHMbX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Mar 2022 07:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345666AbiCHMbW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Mar 2022 07:31:22 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412043FD98
        for <linux-ext4@vger.kernel.org>; Tue,  8 Mar 2022 04:30:26 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D3F451F396;
        Tue,  8 Mar 2022 12:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646742624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XKTzS4qY/ExYNSjF9XwFlmDawcC67b46dguzYhpP3o8=;
        b=R2TtIVRym1AeFR5oRsBaYitanz6bDxv9fXgvxusPNOhCYe6AcbMQGLtr18VwnlL8UeuKGu
        vn2KRXthrngQTly6gxDmgR3+4BBikS7WcvY8KxJJlMoX8Q1rtolRnS5FGF/kjdBfxwOjFb
        b5i7oNUqF9Fy8CtkBnf3ZYCjGB4vPtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646742624;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XKTzS4qY/ExYNSjF9XwFlmDawcC67b46dguzYhpP3o8=;
        b=dYjmApN05ePDdAX3gjUW2V3ELWg7HfY2oMBBc38IltrClYhz1hPWeImAr60I74nrd9CpHU
        AXP6nf7sq3TvEqDQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C5692A3B83;
        Tue,  8 Mar 2022 12:30:24 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C70C1A0609; Tue,  8 Mar 2022 13:30:20 +0100 (CET)
Date:   Tue, 8 Mar 2022 13:30:20 +0100
From:   Jan Kara <jack@suse.cz>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, riteshh@linux.ibm.com, jack@suse.cz,
        tytso@mit.edu
Subject: Re: [PATCH 3/5] ext4: for committing inode, make ext4_fc_track_inode
 wait
Message-ID: <20220308123020.u4357jwbtoqhy5xd@quack3.lan>
References: <20220308105112.404498-1-harshads@google.com>
 <20220308105112.404498-4-harshads@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308105112.404498-4-harshads@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 08-03-22 02:51:10, Harshad Shirwadkar wrote:
> From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> 
> If the inode that's being requested to track using ext4_fc_track_inode
> is being committed, then wait until the inode finishes the commit.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Looks mostly good. Just some notes below.

> diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
> index 3477a16d08ae..7fa301b0a35a 100644
> --- a/fs/ext4/ext4_jbd2.c
> +++ b/fs/ext4/ext4_jbd2.c
> @@ -106,6 +106,18 @@ handle_t *__ext4_journal_start_sb(struct super_block *sb, unsigned int line,
>  				   GFP_NOFS, type, line);
>  }
>  
> +handle_t *__ext4_journal_start(struct inode *inode, unsigned int line,
> +				  int type, int blocks, int rsv_blocks,
> +				  int revoke_creds)
> +{
> +	handle_t *handle = __ext4_journal_start_sb(inode->i_sb, line,
> +						   type, blocks, rsv_blocks,
> +						   revoke_creds);
> +	if (ext4_handle_valid(handle) && !IS_ERR(handle))
> +		ext4_fc_track_inode(handle, inode);

Why do you need to call ext4_fc_track_inode() here? Calls in
ext4_map_blocks() and ext4_mark_iloc_dirty() should be enough, shouldn't
they?

> +	return handle;
> +}
> +
>  int __ext4_journal_stop(const char *where, unsigned int line, handle_t *handle)
>  {
>  	struct super_block *sb;

...

> @@ -519,6 +525,33 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
>  		return;
>  	}
>  
> +	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
> +	    (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY))
> +		return;
> +
> +	spin_lock(&ei->i_fc_lock);
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
> +
> +		prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
> +		spin_unlock(&ei->i_fc_lock);
> +
> +		schedule();
> +		finish_wait(wq, &wait.wq_entry);
> +		spin_lock(&ei->i_fc_lock);
> +	}
> +	spin_unlock(&ei->i_fc_lock);

Hum, we operate inode state with atomic bitops. So I think there's no real
need for ei->i_fc_lock here. You just need to be careful and check inode
state again after prepare_to_wait() call. 

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
