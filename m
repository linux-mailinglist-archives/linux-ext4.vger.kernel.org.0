Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCC94D1825
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Mar 2022 13:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241207AbiCHMpa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Mar 2022 07:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235678AbiCHMpa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Mar 2022 07:45:30 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6D63A5DA
        for <linux-ext4@vger.kernel.org>; Tue,  8 Mar 2022 04:44:33 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 937E9210F5;
        Tue,  8 Mar 2022 12:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646743472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3rGadNHg40FOC+/lrU4Ufl5oNtF9n1T2zDX+guAbU5M=;
        b=AMLhhuXtsBMoFqMke3aL6RGNXd/3jIXoY3DEHwS1CUCJ5bOew0KGVh9EE+atdE+P5pb2Aq
        Ig3IAPFw5WqtqzoYN5ChqAduXRZAo+DbIjUepTTXLyBlAt4NsTZiykLL6r+xn6pTCjbRim
        HvEB9/BBDrjN6vBVvG8z/idGBicVpt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646743472;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3rGadNHg40FOC+/lrU4Ufl5oNtF9n1T2zDX+guAbU5M=;
        b=lm/Sa5rL3xGu6qMurAfTwtFzAAEXhe5z84u8ooYxy3EzIEMoNROrnc8PtXhniI3R10FgW9
        s6Ish54M0C6t7wCw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 85FD7A3B8E;
        Tue,  8 Mar 2022 12:44:32 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 17109A0609; Tue,  8 Mar 2022 13:44:32 +0100 (CET)
Date:   Tue, 8 Mar 2022 13:44:32 +0100
From:   Jan Kara <jack@suse.cz>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, riteshh@linux.ibm.com, jack@suse.cz,
        tytso@mit.edu
Subject: Re: [PATCH 4/5] ext4: rework fast commit commit path
Message-ID: <20220308124432.etmyoi3gmepg2buq@quack3.lan>
References: <20220308105112.404498-1-harshads@google.com>
 <20220308105112.404498-5-harshads@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308105112.404498-5-harshads@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 08-03-22 02:51:11, Harshad Shirwadkar wrote:
> From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> 
> This patch reworks fast commit's commit path to remove locking the
> journal for the entire duration of a fast commit. Instead, we only lock
> the journal while marking all the eligible inodes as "committing". This
> allows handles to make progress in parallel with the fast commit.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

...

> @@ -1044,6 +1025,18 @@ static int ext4_fc_perform_commit(journal_t *journal)
>  	int ret = 0;
>  	u32 crc = 0;
>  
> +	/* Lock the journal */
> +	jbd2_journal_lock_updates(journal);
> +	spin_lock(&sbi->s_fc_lock);
> +	list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
> +		spin_lock(&iter->i_fc_lock);
> +		ext4_set_inode_state(&iter->vfs_inode,
> +				     EXT4_STATE_FC_COMMITTING);
> +		spin_unlock(&iter->i_fc_lock);
> +	}
> +	spin_unlock(&sbi->s_fc_lock);
> +	jbd2_journal_unlock_updates(journal);
> +

Again, i_fc_lock does not seem to be necessary here...

> @@ -1094,6 +1087,14 @@ static int ext4_fc_perform_commit(journal_t *journal)
>  		ret = ext4_fc_write_inode(inode, &crc);
>  		if (ret)
>  			goto out;
> +		spin_lock(&iter->i_fc_lock);
> +		ext4_clear_inode_state(inode, EXT4_STATE_FC_COMMITTING);
> +		spin_unlock(&iter->i_fc_lock);
> +#if (BITS_PER_LONG < 64)
> +		wake_up_bit(&iter->i_state_flags, EXT4_STATE_FC_COMMITTING);
> +#else
> +		wake_up_bit(&iter->i_flags, EXT4_STATE_FC_COMMITTING);
> +#endif
>  		spin_lock(&sbi->s_fc_lock);

And here we can do without i_fc_lock as well, we just need smp_mb() between
ext4_clear_inode_state() and wake_up_bit() to pair with the implicit
barrier inside prepare_to_wait(). 

> @@ -1227,13 +1228,15 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
>  	spin_lock(&sbi->s_fc_lock);
>  	list_for_each_entry_safe(iter, iter_n, &sbi->s_fc_q[FC_Q_MAIN],
>  				 i_fc_list) {
> -		list_del_init(&iter->i_fc_list);
> +		spin_lock(&iter->i_fc_lock);
>  		ext4_clear_inode_state(&iter->vfs_inode,
>  				       EXT4_STATE_FC_COMMITTING);
> +		spin_unlock(&iter->i_fc_lock);
>  		if (iter->i_sync_tid <= tid)
>  			ext4_fc_reset_inode(&iter->vfs_inode);
>  		/* Make sure EXT4_STATE_FC_COMMITTING bit is clear */
>  		smp_mb();
> +		list_del_init(&iter->i_fc_list);
>  #if (BITS_PER_LONG < 64)
>  		wake_up_bit(&iter->i_state_flags, EXT4_STATE_FC_COMMITTING);
>  #else

Again, i_fc_lock not needed here. As a note the comment in the above about
the barrier is a bit incorrect. The barrier does not make sure any store
happens. It is just an ordering requirement for the CPU. As such barriers
really only work in pairs because both cooperating tasks need to force
proper ordering. So we usually document barriers like:

		/*
		 * Make sure clearing of EXT4_STATE_FC_COMMITTING is
		 * visible before we send the wakeup. Pairs with implicit
		 * barrier in prepare_to_wait() in ext4_fc_track_inode().
		 */

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
