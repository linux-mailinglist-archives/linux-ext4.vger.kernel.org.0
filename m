Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262DB3CB5B2
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jul 2021 12:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbhGPKLT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Jul 2021 06:11:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36968 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbhGPKLS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Jul 2021 06:11:18 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2A0BF22B78;
        Fri, 16 Jul 2021 10:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626430101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PgNXF/KDfux570bJDuW6+3nIA+gGTR50Oc7Pi4OGQFQ=;
        b=qTUKeVZuIGrzy46HPDOQKSTNxQpGV0MfrtYgdzTSh/VKtZAbJwiDXhSOesDGRzizdEec22
        DCrfFz1tPQfmML57J9a/nwhaNSFHnXuFQF4DoQu3rO83H3HDl9C2gXC8NFFMW4bCUG+nNl
        QKxFu4qKv+K4QdcZtUYb28uh6r6sCDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626430101;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PgNXF/KDfux570bJDuW6+3nIA+gGTR50Oc7Pi4OGQFQ=;
        b=nfXxJwQbRaJpd4CcVsc08/zilvPvWSn6nnSKVTJBUm4k21SYBIuFHU3GBvmKliGHk4Jcbj
        UqAiru6IFSw7QfAA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 1A7DEA3BAF;
        Fri, 16 Jul 2021 10:08:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E51AC1E087D; Fri, 16 Jul 2021 12:08:20 +0200 (CEST)
Date:   Fri, 16 Jul 2021 12:08:20 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, yukuai3@huawei.com
Subject: Re: [PATCH v2 3/4] ext4: factor out write end code of inline file
Message-ID: <20210716100820.GF31920@quack2.suse.cz>
References: <20210715015452.2542505-1-yi.zhang@huawei.com>
 <20210715015452.2542505-4-yi.zhang@huawei.com>
 <20210715120818.GF9457@quack2.suse.cz>
 <eced292f-cdbe-ff0f-3d4d-d6e3a3c84520@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eced292f-cdbe-ff0f-3d4d-d6e3a3c84520@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 16-07-21 11:56:06, Zhang Yi wrote:
> On 2021/7/15 20:08, Jan Kara wrote:
> > On Thu 15-07-21 09:54:51, Zhang Yi wrote:
> >> Now that the inline_data file write end procedure are falled into the
> >> common write end functions, it is not clear. Factor them out and do
> >> some cleanup. This patch also drop ext4_da_write_inline_data_end()
> >> and switch to use ext4_write_inline_data_end() instead because we also
> >> need to do the same error processing if we failed to write data into
> >> inline entry.
> >>
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> > 
> > Just two small comments below.
> > 
> >> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> >> index 28b666f25ac2..3d227b32b21c 100644
> >> --- a/fs/ext4/inline.c
> >> +++ b/fs/ext4/inline.c
> > ...
> >> +out:
> >> +	/*
> >> +	 * If we have allocated more blocks and copied less. We will have
> >> +	 * blocks allocated outside inode->i_size, so truncate them.
> >> +	 */
> >> +	if (pos + len > inode->i_size && ext4_can_truncate(inode))
> >> +		ext4_orphan_add(handle, inode);
> > 
> > I don't think we need this error handling here. For inline data we never
> > allocate any blocks so shorter writes don't need any cleanup.
> > 
> >> -	return copied;
> >> +	ret2 = ext4_journal_stop(handle);
> >> +	if (!ret)
> >> +		ret = ret2;
> >> +	if (pos + len > inode->i_size) {
> >> +		ext4_truncate_failed_write(inode);
> >> +		/*
> >> +		 * If truncate failed early the inode might still be
> >> +		 * on the orphan list; we need to make sure the inode
> >> +		 * is removed from the orphan list in that case.
> >> +		 */
> >> +		if (inode->i_nlink)
> >> +			ext4_orphan_del(NULL, inode);
> >> +	}
> > 
> > And this can go away as well...
> > 
> 
> Yeah, but if we don't call ext4_truncate_failed_write()->..->
> ext4_inline_data_truncate(), it will lead to incorrect larger i_inline_size
> and data entry. Although it seems harmless (i_size can prevent read zero
> data), I think it's better to restore the data entry(the comments need
> change later), or else it will occupy more xattr space. What do you think ?

Good point. I've found this out last time when I was reviewing your patches
and then forgot again. So please leave the code there but fix this
misleading comment:

/*
 * If we have allocated more blocks and copied less. We will have
 * blocks allocated outside inode->i_size, so truncate them.
 */

Something like:

/*
 * If we didn't copy as much data as expected, we need to trim back size of
 * xattr containing inline data.
 */

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
