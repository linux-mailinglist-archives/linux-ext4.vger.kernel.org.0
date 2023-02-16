Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2998C699516
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Feb 2023 14:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjBPNDT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Feb 2023 08:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjBPNDS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Feb 2023 08:03:18 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2594748E38
        for <linux-ext4@vger.kernel.org>; Thu, 16 Feb 2023 05:03:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BA0FA1F74A;
        Thu, 16 Feb 2023 13:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676552586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z3Dv8nGBtoWHLyJsjPEHCrL0fHVD2T+0Rp2FaKnZTGs=;
        b=17+QpW/wj1L2pplOE9EJtulqIsfqzmIsGbN9XMj/bqBPeSWgYpw2QQz3tGgpcqbZjU9jOE
        7N4rEEFpwoB50yk4pyr3ig06LRaxkxXXtF0Aq9qWD8Nx6LRD1V0cIZ+RhVcBNdtsyy4040
        ErBGDMzmbYzH0e0tv6dQbakckpklfDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676552586;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z3Dv8nGBtoWHLyJsjPEHCrL0fHVD2T+0Rp2FaKnZTGs=;
        b=dL+v8c8coUGRJvwkxGReA/0UpMR13vRCPUv7Va0gQlbradvFFUbjaQGkTj8rxLZOFK8OJH
        VGwlImrls2AqtnBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A907713438;
        Thu, 16 Feb 2023 13:03:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5kg0KYop7mPWUQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 16 Feb 2023 13:03:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4B24AA06E1; Thu, 16 Feb 2023 14:03:05 +0100 (CET)
Date:   Thu, 16 Feb 2023 14:03:05 +0100
From:   Jan Kara <jack@suse.cz>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, jack@suse.com,
        linux-ext4@vger.kernel.org, yi.zhang@huawei.com,
        linfeilong@huawei.com, liuzhiqiang26@huawei.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v5 2/2] ext4: clear the verified flag of the modified
 leaf or idx if error
Message-ID: <20230216130305.nrbtd42tppxhbynn@quack3>
References: <20230213080514.535568-1-zhanchengbin1@huawei.com>
 <20230213080514.535568-3-zhanchengbin1@huawei.com>
 <20230214125211.o2j3vpkopvas2niq@quack3>
 <6e6bb868-7107-3528-db6d-0ddc275f6326@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e6bb868-7107-3528-db6d-0ddc275f6326@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 16-02-23 15:25:23, zhanchengbin wrote:
> The last patch did not take into account path[0].p_bh == NULL, so I
> reworked the code.
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 0f95e857089e..05585afae0db 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -1750,13 +1750,19 @@ static int ext4_ext_correct_indexes(handle_t
> *handle, struct inode *inode,
>                         break;
>                 err = ext4_ext_get_access(handle, inode, path + k);
>                 if (err)
> -                       break;
> +                       goto clean;
>                 path[k].p_idx->ei_block = border;
>                 err = ext4_ext_dirty(handle, inode, path + k);
>                 if (err)
> -                       break;
> +                       goto clean;
>         }
> +       return 0;
> 
> +clean:
> +       while (k++ < depth) {
> +               /* k here will not be 0, so don't consider the case where
> path[0].p_bh is NULL */

Please avoid the line over 80 characters.

> +               clear_buffer_verified(path[k].p_bh);
> +       }
>         return err;
>  }
> 
> @@ -2304,6 +2310,7 @@ static int ext4_ext_rm_idx(handle_t *handle, struct
> inode *inode,
>  {
>         int err;
>         ext4_fsblk_t leaf;
> +       int b_depth = depth;
> 
>         /* free index block */
>         depth--;
> @@ -2339,11 +2346,18 @@ static int ext4_ext_rm_idx(handle_t *handle, struct
> inode *inode,
>                 path--;
>                 err = ext4_ext_get_access(handle, inode, path);
>                 if (err)
> -                       break;
> +                       goto clean;
>                 path->p_idx->ei_block = (path+1)->p_idx->ei_block;
>                 err = ext4_ext_dirty(handle, inode, path);
>                 if (err)
> -                       break;
> +                       goto clean;
> +       }
> +       return 0;
> +
> +clean:
> +       while (depth++ < b_depth - 1) {
> +               /* depth here will not be 0, so don't consider the case
> where path[0].p_bh is NULL */

Again please avoid the overly long line.

> +               clear_buffer_verified(path[depth].p_bh);
>         }

I think this is still problematic because 'path' is being updated in the
above loop as well so this will still access beyond the end of the array.
So I think you first need to modify ext4_ext_rm_idx() to leave 'path' alone
and just index it like ext4_ext_correct_indexes() does it (separate patch
please) and then add this error recovery path.

> On 2023/2/14 20:52, Jan Kara wrote:
> > 
> > This would be more understandable as:
> > 
> > 	if (k >= 0)
> > 		while (k++ < depth)
> > 			...
> > 
> > Also the loop is IMO wrong because it will run with k == depth as well (due
> > to post-increment) and that is not initialized. Furthermore it will run
> > also if we exit the previous loop due to:
> > 
> >                  /* change all left-side indexes */
> >                  if (path[k+1].p_idx != EXT_FIRST_INDEX(path[k+1].p_hdr))
> >                          break;
> > 
> > which is unwanted as well. Which suggests that you didn't test your changes
> > much (if at all...). So please make sure your changes are tested next time.
> > Thank you!
> > 
> I only ran xfstest locally. Do you have any better suggestions?

Yes that's good. But that will not run your new error handling code at all,
will it? It would be good if you also ran the reproducer that presumably
triggered these fixes to exercise the new code...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
