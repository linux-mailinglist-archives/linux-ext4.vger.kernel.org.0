Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D926C1BB5
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Mar 2023 17:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjCTQcP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Mar 2023 12:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjCTQbo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 Mar 2023 12:31:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A43D9761;
        Mon, 20 Mar 2023 09:24:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DF9BC21AC5;
        Mon, 20 Mar 2023 16:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679329486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XJu4zqG3QbOSaOf4atKMI3UF36bMJzTzfp3BXDoSmIc=;
        b=pK9ZprUumF/lDEIimiWUWAnntcke+OYuYVSkB4m+CyLRrupZuuNAsBCOoXBGFMDYvtS57C
        dHuSAJSOJbuxnkHKRkDFfHlLN7F7H+5khhKaumotwfGp2d96Ib6UiGwQxAxbUmK8KiL03Z
        /htELGWUmHxApyWZ1TRbF9lfHeLipZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679329486;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XJu4zqG3QbOSaOf4atKMI3UF36bMJzTzfp3BXDoSmIc=;
        b=AhaZcTRha0Pfdz2UIiruP9XxNnJvCvOyU2+cZf7xAve9JjXEdSD/+oXmovpoNVhiu6YS7Q
        DbvfF9dZ9MAUEkBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D0A3513416;
        Mon, 20 Mar 2023 16:24:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hJ7kMs6IGGQvaAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 20 Mar 2023 16:24:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4DDDEA0719; Mon, 20 Mar 2023 17:24:46 +0100 (CET)
Date:   Mon, 20 Mar 2023 17:24:46 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.com, tudor.ambarus@linaro.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH] ext4: Fix i_disksize exceeding i_size problem in
 paritally written case
Message-ID: <20230320162446.vkqsxxcsmv4cacwa@quack3>
References: <20230317013553.1009553-1-chengzhihao1@huawei.com>
 <20230317124513.drx3wywcjnap5jme@quack3>
 <884950ac-e60a-d331-9f68-310ab81ee595@huawei.com>
 <71990726-c677-34df-d29b-a0fec1a6f68c@huawei.com>
 <20230320112038.3q2eqpv6xsmj22br@quack3>
 <48deeadf-05cd-3535-a589-907cfa252799@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48deeadf-05cd-3535-a589-907cfa252799@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 20-03-23 20:49:07, Zhihao Cheng wrote:
> [...]
> 
> > > BTW, I want send another patch as follows:
> > > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > > index bf0b7dea4900..570a687ae847 100644
> > > --- a/fs/ext4/inode.c
> > > +++ b/fs/ext4/inode.c
> > > @@ -3149,7 +3149,7 @@ static int ext4_da_write_end(struct file *file,
> > >                  return ext4_write_inline_data_end(inode, pos, len, copied,
> > > page);
> > > 
> > >          start = pos & (PAGE_SIZE - 1);
> > > -       end = start + copied - 1;
> > > +       end = start + (copied ? copied - 1 : copied);
> > > 
> > >          /*
> > >           * Since we are holding inode lock, we are sure i_disksize <=
> > > @@ -3167,7 +3167,7 @@ static int ext4_da_write_end(struct file *file,
> > >           * ext4_da_write_inline_data_end().
> > >           */
> > >          new_i_size = pos + copied;
> > > -       if (copied && new_i_size > inode->i_size &&
> > > +       if (new_i_size > inode->i_size &&
> > >              ext4_da_should_update_i_disksize(page, end))
> > >                  ext4_update_i_disksize(inode, new_i_size);
> > > 
> > > This modification handle unconsistent i_size and i_disksize imported by
> > > ea51d132dbf9 ("ext4: avoid hangs in ext4_da_should_update_i_disksize()").
> > > 
> > > Paritially written may display a fake inode size for user, for example:
> > > 
> > > 
> > > 
> > > i_disksize=1
> > > 
> > > generic_perform_write
> > > 
> > >   copied = iov_iter_copy_from_user_atomic(len) // copied = 0
> > > 
> > >   ext4_da_write_end // skip updating i_disksize
> > > 
> > >   generic_write_end
> > > 
> > >    if (pos + copied > inode->i_size) {  // 10 + 0 > 1, true
> > > 
> > >     i_size_write(inode, pos + copied);  // i_size = 10
> > > 
> > >    }
> > > 
> > > 
> > > 
> > >     0 1      10                4096
> > > 
> > >     |_|_______|_________..._____|
> > > 
> > >       |       |
> > > 
> > >      i_size  pos
> > > 
> > > 
> > > 
> > > Now, user see the i_size is 10 (i_disksize is still 1). After inode
> > > 
> > > destroyed, user will get the i_size is 1 read from disk.
> > 
> > OK, but shouldn't we rather change generic_write_end() to not increase
> > i_size if no write happened? Because that is what seems somewhat
> > problematic...
> > 
> > 								Honza
> > 
> 
> After looking through some code, I find some other places have similar
> problem:
> 1. In ext4_write_end(), i_size is updated by ext4 not generic_write_end().
> 2. The iommap framework, i_size is updated even copied is zero.
> 3. ubifs_write_end, i_size is updated even copied is zero.
> 
> It seems that fixing all places is not an easy work.

Well, yeah, probably not trivial but still desirable ;). Will you look into
that?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
