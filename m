Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1134B5A46C6
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Aug 2022 12:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiH2KHE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Aug 2022 06:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiH2KHC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 29 Aug 2022 06:07:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924E95FADA;
        Mon, 29 Aug 2022 03:06:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0992F219DD;
        Mon, 29 Aug 2022 10:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661767618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F3jbrbr7lCpBnUCttSs3SxHmODTqTPlam9vJ2wqjxmo=;
        b=g6vv7cbJI/hDUtRHAsQCRfqv/oiY4Y38/8nLLMeItHdzB6f2//dWsrPrWVfjktyWfhkCsU
        mPvHvs0/9knDFHQbvFFL5qNhmN4NSWsI21pP679XVweCZPFk1dth+rn1uS8dXnmqGcJ4jO
        ZZ6Cv5Y1K8roE+H/MWXkuD9QuJIVdCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661767618;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F3jbrbr7lCpBnUCttSs3SxHmODTqTPlam9vJ2wqjxmo=;
        b=WlP9kpuvG33PdNVMtLqxvYwxE7ykeAh7d78mzDtrro0m1/OnWDMOh53DIxqRZznwuCt0tF
        yokCnLolrFp0krCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D280F133A6;
        Mon, 29 Aug 2022 10:06:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QiaWM8GPDGPmOwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 29 Aug 2022 10:06:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 47BE5A066D; Mon, 29 Aug 2022 12:06:57 +0200 (CEST)
Date:   Mon, 29 Aug 2022 12:06:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Yang Xu <xuyang2018.jy@fujitsu.com>, fstests@vger.kernel.org,
        jack@suse.cz, oliver.sang@intel.com, lkp@intel.com,
        linux-ext4@vger.kernel.org, tytso@mit.edu, lczerner@redhat.com
Subject: Re: [PATCH] ext4/053: Remove nouser_xattr test
Message-ID: <20220829100657.wunvx2twhjzuqckk@quack3>
References: <1660705823-2172-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220828024858.cf5awn2uksbpchb3@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220828024858.cf5awn2uksbpchb3@zlang-mailbox>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun 28-08-22 10:48:58, Zorro Lang wrote:
> On Wed, Aug 17, 2022 at 11:10:23AM +0800, Yang Xu wrote:
> > Plan to remove noacl and nouser_xattr mount option in kernel because they
> > are deprecated[1]. So remove nouser_xattr test in here.
> 
> What's the [1]?
> 
> We'd better to be careful when we want to remove a testing coverage. I'm not
> sure if they've decided to removed this mount option, the ext4/053 is an
> important test case for ext4, so I'd like to hear their opinion.

Yes, the option is long deprecated and we want to remove it from ext4. But
I think you might want to see official ack from Ted as a maintainer on this
:). Ted?

								Honza

> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> > ---
> >  tests/ext4/053 | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/tests/ext4/053 b/tests/ext4/053
> > index 555e474e..5d2c478a 100755
> > --- a/tests/ext4/053
> > +++ b/tests/ext4/053
> > @@ -439,7 +439,6 @@ for fstype in ext2 ext3 ext4; do
> >  	mnt oldalloc removed
> >  	mnt orlov removed
> >  	mnt -t user_xattr
> > -	mnt nouser_xattr
> >  
> >  	if _has_kernel_config CONFIG_EXT4_FS_POSIX_ACL; then
> >  		mnt -t acl
> > -- 
> > 2.27.0
> > 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
