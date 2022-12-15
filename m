Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66C764D7FE
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Dec 2022 09:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiLOIs7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Dec 2022 03:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiLOIs6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Dec 2022 03:48:58 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F192E9EC
        for <linux-ext4@vger.kernel.org>; Thu, 15 Dec 2022 00:48:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 925AD21CCB;
        Thu, 15 Dec 2022 08:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671094131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GeHVNRVUttxiBhGaKWVGgVZJX6tVvKm4lg1mMARqyNU=;
        b=ngslp9CEXS5qcfKGzjHxiOjAr5vChjsLFNYQ9Tfbtw9nnU+SJD9bL5ZgTBx7U0VLgo8bsS
        EhpbpsFlgGEyXTjCyZQR3aHF9wnXytiTjektD06/Splo7Mv0q74FzWcZyM5Di7l6WeLKTo
        KoDOIHJ5a6/YRFQX5z8Af0tCQXv++is=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671094131;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GeHVNRVUttxiBhGaKWVGgVZJX6tVvKm4lg1mMARqyNU=;
        b=jc+i3J27q7TL8po0mMgV2BeTVXz+EFV2IDlijmS+krSrBDnKsb2Wozq4hDcfeMjIo8SDkb
        voucaFy8tYd/nvCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8175613434;
        Thu, 15 Dec 2022 08:48:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rHmOH3PfmmMAGgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 15 Dec 2022 08:48:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A1897A0727; Thu, 15 Dec 2022 09:48:50 +0100 (CET)
Date:   Thu, 15 Dec 2022 09:48:50 +0100
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, Zhang Yi <yi.zhang@huawei.com>,
        linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        yi.zhang@huaweicloud.com, yukuai3@huawei.com
Subject: Re: [RFC PATCH] ext4: dio take shared inode lock when overwriting
 preallocated blocks
Message-ID: <20221215084850.abze2sz2imwcoma5@quack3>
References: <20221203103956.3691847-1-yi.zhang@huawei.com>
 <20221214170125.bixz46ybm76rtbzf@quack3>
 <Y5obcGLDZuw/NWOh@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5obcGLDZuw/NWOh@mit.edu>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 14-12-22 13:52:32, Theodore Ts'o wrote:
> On Wed, Dec 14, 2022 at 06:01:25PM +0100, Jan Kara wrote:
> > 
> > Besides some naming nits (see below) I think this should work. But I have
> > to say I'm a bit uneasy about this because we will now be changing block
> > mapping from unwritten to written only with shared i_rwsem. OTOH that
> > happens during writeback as well so we should be fine and the gain is very
> > nice.
> 
> Hmm.... when I was looking potential impacts of the change what
> ext4_overwrite_io() would do, I looked at the current user of that
> function in ext4_dio_write_checks().
> 
> 	/*
> 	 * Determine whether the IO operation will overwrite allocated
> 	 * and initialized blocks.
> 	 * We need exclusive i_rwsem for changing security info
> 	 * in file_modified().
> 	 */
> 	if (*ilock_shared && (!IS_NOSEC(inode) || *extend ||
> 	     !ext4_overwrite_io(inode, offset, count))) {
> 		if (iocb->ki_flags & IOCB_NOWAIT) {
> 			ret = -EAGAIN;
> 			goto out;
> 		}
> 		inode_unlock_shared(inode);
> 		*ilock_shared = false;
> 		inode_lock(inode);
> 		goto restart;
> 	}
> 
> 	ret = file_modified(file);
> 	if (ret < 0)
> 		goto out;
> 
> What is confusing me is the comment, "We need exclusive i_rwsem for
> changing security info in file_modified().".  But then we end up
> calling file_modified() unconditionally, regardless of whether we've
> transitioned from a shared lock to an exclusive lock.
> 
> So file_modified() can get called either with or without the inode
> locked r/w.  I realize that this patch doesn't change this
> inconsistency, but it appears either the comment is wrong, or the code
> is wrong.

Maybe the comment needs rephrasing but it seems correct. file_modified()
does multiple things. It updates timestamps - these are fine with shared
i_rwsem - and is calls into __file_remove_privs() to remove SUID bits etc.
Now if __file_remove_privs() is going to modify the inode, we need i_rwsem
exclusively. And we determine whether __file_remove_privs() will do
anything by checking !IS_NOSEC(inode) in the condition above. So the
sentence you're confused about speaks about this part of the condition.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
