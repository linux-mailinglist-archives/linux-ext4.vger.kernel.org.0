Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF99C3C9E38
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jul 2021 14:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhGOMLM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Jul 2021 08:11:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35764 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbhGOMLM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Jul 2021 08:11:12 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8EE691FE19;
        Thu, 15 Jul 2021 12:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626350898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eH0jeVK2i8hz++sNM/JC6YrqWq5J9vwtnU9FAcE/fG8=;
        b=i42xtiZ1AbOIPhhaltTt2t+pK3GvqvK4IIAIlcsAEib+PpDDEMuKn3cfYI050NrjY44VIs
        Ypf69xlIhxC2nec1q73PFMwavNcO2+ugXsYOT8SGLelWa0f6K3SDo/lOG8MHVrJS93hYJ+
        ej7Q4LQKkNFyy6oPTeZhpSd1Et9qlhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626350898;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eH0jeVK2i8hz++sNM/JC6YrqWq5J9vwtnU9FAcE/fG8=;
        b=vOT5bLlup9SCJ0lYGiOy0UFyQkDdrl3OAbwm9tucUavZ/x028rcUd0JT2g0igWcVnSf2ID
        z/r0ZatuEvOkPDCg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 4CD3FA3BBE;
        Thu, 15 Jul 2021 12:08:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2B52D1E0BF2; Thu, 15 Jul 2021 14:08:18 +0200 (CEST)
Date:   Thu, 15 Jul 2021 14:08:18 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [PATCH v2 3/4] ext4: factor out write end code of inline file
Message-ID: <20210715120818.GF9457@quack2.suse.cz>
References: <20210715015452.2542505-1-yi.zhang@huawei.com>
 <20210715015452.2542505-4-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715015452.2542505-4-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 15-07-21 09:54:51, Zhang Yi wrote:
> Now that the inline_data file write end procedure are falled into the
> common write end functions, it is not clear. Factor them out and do
> some cleanup. This patch also drop ext4_da_write_inline_data_end()
> and switch to use ext4_write_inline_data_end() instead because we also
> need to do the same error processing if we failed to write data into
> inline entry.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Just two small comments below.

> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index 28b666f25ac2..3d227b32b21c 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
...
> +out:
> +	/*
> +	 * If we have allocated more blocks and copied less. We will have
> +	 * blocks allocated outside inode->i_size, so truncate them.
> +	 */
> +	if (pos + len > inode->i_size && ext4_can_truncate(inode))
> +		ext4_orphan_add(handle, inode);

I don't think we need this error handling here. For inline data we never
allocate any blocks so shorter writes don't need any cleanup.

> -	return copied;
> +	ret2 = ext4_journal_stop(handle);
> +	if (!ret)
> +		ret = ret2;
> +	if (pos + len > inode->i_size) {
> +		ext4_truncate_failed_write(inode);
> +		/*
> +		 * If truncate failed early the inode might still be
> +		 * on the orphan list; we need to make sure the inode
> +		 * is removed from the orphan list in that case.
> +		 */
> +		if (inode->i_nlink)
> +			ext4_orphan_del(NULL, inode);
> +	}

And this can go away as well...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
