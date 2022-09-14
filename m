Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2B25B8337
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Sep 2022 10:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiINIoW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Sep 2022 04:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiINIoV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Sep 2022 04:44:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DCB6BCE6
        for <linux-ext4@vger.kernel.org>; Wed, 14 Sep 2022 01:44:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B828322422;
        Wed, 14 Sep 2022 08:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663145056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Gv4v6I/UzZg0PRcYxznpUSQlvOqEApSdvEoIRTZC40=;
        b=LgNBIlR6IuDuTkGqhL/iiy+e+B4q2Sx1ZyihU+wUb42XjD6Dn1fDSj16Vc17wHcjtP/kCi
        ELvwD8KmmZVSFcWR6Um3VNwn6bRjBicn+gQnIiGn4MdJ+k8GQ0ivanIXU9QnZowijqCebj
        nBpR+nI9P0wVmT1WOl+jLTcSlfImSco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663145056;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Gv4v6I/UzZg0PRcYxznpUSQlvOqEApSdvEoIRTZC40=;
        b=X5dpNNuY8YFLDddIwv30cKTFRjsareu/YKyK1t4rc6xFIXyHwsGFJmLDpE4S+1QhlIv7lC
        Qrr4KnWZAvfa/KBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A9D2A13494;
        Wed, 14 Sep 2022 08:44:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Jr9wKWCUIWM3FgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 14 Sep 2022 08:44:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3B52EA0680; Wed, 14 Sep 2022 10:44:16 +0200 (CEST)
Date:   Wed, 14 Sep 2022 10:44:16 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     Yuan Can <yuancan@huawei.com>, jack@suse.com,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] fs/ext2: remove unused variable es
Message-ID: <20220914084416.xp7y5tcqtrotjad6@quack3>
References: <20220913071141.94082-1-yuancan@huawei.com>
 <20220913145050.6si6rhpdtsem6vwl@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913145050.6si6rhpdtsem6vwl@riteshh-domain>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 13-09-22 20:20:50, Ritesh Harjani (IBM) wrote:
> On 22/09/13 07:11AM, Yuan Can wrote:
> > The variable es is never used, remove it.
> > No functional change.
> > 
> > Signed-off-by: Yuan Can <yuancan@huawei.com>
> > ---
> >  fs/ext2/ialloc.c | 2 --
> >  1 file changed, 2 deletions(-)
> 
> Hi Yuan,
> 
> Thanks for the patch - 
> 
> However while reviewing this, I also looked at ext2_count_free_blocks(). 
> And then I felt maybe the right thing to do is to print more info when
> EXT2FS_DEBUG is enabled which would be to dump both stored counters in the debug message 
> i.e. (from ext2_super_block -> s_free_**_count, and from ext2_sb_info -> s_free**_counter)

I don't have a strong opinion, but yeah, what you suggest makes sense.

								Honza

> diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
> index c17ccc19b938..87c57ddcd2ed 100644
> --- a/fs/ext2/balloc.c
> +++ b/fs/ext2/balloc.c
> @@ -1475,8 +1475,10 @@ unsigned long ext2_count_free_blocks (struct super_block * sb)
>                 bitmap_count += x;
>                 brelse(bitmap_bh);
>         }
> -       printk("ext2_count_free_blocks: stored = %lu, computed = %lu, %lu\n",
> -               (long)le32_to_cpu(es->s_free_blocks_count),
> +       printk("ext2_count_free_blocks: stored = %lu, %lu, computed = %lu, %lu\n",
> +               (unsigned long) le32_to_cpu(es->s_free_blocks_count),
> +               (unsigned long)
> +               percpu_counter_read(&EXT2_SB(sb)->s_freeblocks_counter),
>                 desc_count, bitmap_count);
>         return bitmap_count;
>  #else
> diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
> index 998dd2ac8008..436d5c4d61c0 100644
> --- a/fs/ext2/ialloc.c
> +++ b/fs/ext2/ialloc.c
> @@ -643,7 +643,8 @@ unsigned long ext2_count_free_inodes (struct super_block * sb)
>                 bitmap_count += x;
>         }
>         brelse(bitmap_bh);
> -       printk("ext2_count_free_inodes: stored = %lu, computed = %lu, %lu\n",
> +       printk("ext2_count_free_inodes: stored = %lu, %lu, computed = %lu, %lu\n",
> +               (unsigned long) le32_to_cpu(es->s_free_inodes_count),
>                 (unsigned long)
>                 percpu_counter_read(&EXT2_SB(sb)->s_freeinodes_counter),
>                 desc_count, bitmap_count);
> 
> @Jan, 
> Please do let me know your thoughts on this. This doesn't changes the functionality, 
> since the return value remains the same. But it dumps both stored counter values
> in debug output, which is what I think the intended behaviour of the print
> should be in the first place. 
> 
> If this looks correct to you - I can send an official patch fixing this.
> 
> -ritesh
> 
> > 
> > diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
> > index 998dd2ac8008..951b80a7f7d2 100644
> > --- a/fs/ext2/ialloc.c
> > +++ b/fs/ext2/ialloc.c
> > @@ -620,11 +620,9 @@ unsigned long ext2_count_free_inodes (struct super_block * sb)
> >  	int i;	
> >  
> >  #ifdef EXT2FS_DEBUG
> > -	struct ext2_super_block *es;
> >  	unsigned long bitmap_count = 0;
> >  	struct buffer_head *bitmap_bh = NULL;
> >  
> > -	es = EXT2_SB(sb)->s_es;
> >  	for (i = 0; i < EXT2_SB(sb)->s_groups_count; i++) {
> >  		unsigned x;
> >  
> > -- 
> > 2.17.1
> > 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
