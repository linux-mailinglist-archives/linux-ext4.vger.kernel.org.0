Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8178647584A
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Dec 2021 12:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242258AbhLOL7a (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Dec 2021 06:59:30 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:49366 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242253AbhLOL73 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Dec 2021 06:59:29 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B88C61F388;
        Wed, 15 Dec 2021 11:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639569568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mBbMbwCHonLHXnrfcPb/Pc65QhO0lqcuBgQUijn2l0k=;
        b=rWVj1wZ/vO3v0g+s4FGzHSfys+WVJ2TLW4ML79oKBvTGE2Q1XkoqzQWWzZlr5ve9szExhV
        VG8A/JbmdtwuTh03VyG+LFH1rhZXncjsyA54Ld1A1AWOfqdDpKIn4E5fzLNKIfqIZu6cow
        z6uFPIC7vTWCmE8GSPSqt6YxTzAdYxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639569568;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mBbMbwCHonLHXnrfcPb/Pc65QhO0lqcuBgQUijn2l0k=;
        b=oVmFI9yIFe9G7A6y1i5o3fh2aV7ngwaM7rsN0EYlozEpB4RYWSl8lLguu6tXmRdUD3dv56
        Acr9Xia6N9qQwIAg==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id 8A382A3B87;
        Wed, 15 Dec 2021 11:59:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F34951F2C94; Wed, 15 Dec 2021 12:59:27 +0100 (CET)
Date:   Wed, 15 Dec 2021 12:59:27 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     jack@suse.cz, linux-ext4@vger.kernel.org
Subject: Re: [bug report] ext4: Set flags on quota files directly
Message-ID: <20211215115927.GN14044@quack2.suse.cz>
References: <20211215114231.GA12626@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215114231.GA12626@kili>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Dan!

On Wed 15-12-21 14:42:31, Dan Carpenter wrote:
> The patch 957153fce8d2: "ext4: Set flags on quota files directly"
> from Apr 6, 2017, leads to the following Smatch static checker
> warning:
> 
> 	fs/ext4/super.c:6779 ext4_quota_on()
> 	warn: missing error code here? 'IS_ERR()' failed. 'err' = '0'
> 
> fs/ext4/super.c
>     6761 
>     6762         lockdep_set_quota_inode(path->dentry->d_inode, I_DATA_SEM_QUOTA);
>     6763         err = dquot_quota_on(sb, type, format_id, path);
>     6764         if (err) {
>     6765                 lockdep_set_quota_inode(path->dentry->d_inode,
>     6766                                              I_DATA_SEM_NORMAL);
>     6767         } else {
>     6768                 struct inode *inode = d_inode(path->dentry);
>     6769                 handle_t *handle;
>     6770 
>     6771                 /*
>     6772                  * Set inode flags to prevent userspace from messing with quota
>     6773                  * files. If this fails, we return success anyway since quotas
>     6774                  * are already enabled and this is not a hard failure.
>     6775                  */
>     6776                 inode_lock(inode);
>     6777                 handle = ext4_journal_start(inode, EXT4_HT_QUOTA, 1);
>     6778                 if (IS_ERR(handle))
> --> 6779                         goto unlock_inode;
> 
> This should set "err = PTR_ERR(handle)" right?

The comment above explains it I guess. We don't want to return error if
ext4_journal_start() fails because it is a "soft" failure we can absorb.

								Honza


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
