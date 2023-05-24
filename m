Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF92170F470
	for <lists+linux-ext4@lfdr.de>; Wed, 24 May 2023 12:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjEXKno (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 May 2023 06:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjEXKnn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 May 2023 06:43:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7928B97
        for <linux-ext4@vger.kernel.org>; Wed, 24 May 2023 03:43:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 150581F45F;
        Wed, 24 May 2023 10:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684925021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mKvI0wb6sY7CJdNT3kqwZKJ0y1/boUVF9aZoUrdJ5fA=;
        b=gOA7312ZpSlRd5B/10vRQ7o3/DRExgUHJXXtEodfso3kNKteR37evChuwE1RLRb6Qrbu42
        pZleY9SjoJ1Czx96F8QK+hpl7x/xoPTCTa+ikrRNsjR+zIU9lZE+ejWmWRRRuagJoYRTmA
        SYqJ7TvGIzRt7kGOkIm2VCsuNRj0k/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684925021;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mKvI0wb6sY7CJdNT3kqwZKJ0y1/boUVF9aZoUrdJ5fA=;
        b=+A1WTHmCRqjO4WxChHBKs5kwFQOwcOGpWKW8farhkFs0iX/S0z0hgZ371tBEhQNzIOCeWD
        rZhBgCSNDPc4pLDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 06C9A133E6;
        Wed, 24 May 2023 10:43:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id t4GkAV3qbWSdKwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 24 May 2023 10:43:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 93CD3A075C; Wed, 24 May 2023 12:43:40 +0200 (CEST)
Date:   Wed, 24 May 2023 12:43:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     jack@suse.cz, linux-ext4@vger.kernel.org
Subject: Re: 6.4-rc1 xfstests-bld adv regressions
Message-ID: <20230524104340.5ypioctla3s676gm@quack3>
References: <ZFqO3xVnmhL7zv1x@debian-BULLSEYE-live-builder-AMD64>
 <20230509190930.wyblxwohejmd43fw@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509190930.wyblxwohejmd43fw@quack3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello!

Due to conferences this took a bit long. I'm sorry for that.

On Tue 09-05-23 21:09:30, Jan Kara wrote:
> On Tue 09-05-23 14:20:15, Eric Whitney wrote:
> > I'm seeing two test regressions on 6.4-rc1 while running the adv test case
> > with kvm-xfstests.  Both tests fail with 100% reliability in 100 trial runs,
> > and the failures appear to depend solely upon the fast commit mount option.
> > 
> > The first is generic/065, where the relevant info from 065.full is:
> > 
> > _check_generic_filesystem: filesystem on /dev/vdc is inconsistent
> > *** fsck.ext4 output ***
> > fsck from util-linux 2.36.1
> > e2fsck 1.47.0 (5-Feb-2023)
> > Pass 1: Checking inodes, blocks, and sizes
> > Pass 2: Checking directory structure
> > Pass 3: Checking directory connectivity
> > Pass 4: Checking reference counts
> > Pass 5: Checking group summary information
> > Directories count wrong for group #16 (4294967293, counted=0).
> > 
> > 
> > The second is generic/535, where the test output is:
> > 
> >      QA output created by 535
> >      Silence is golden
> >     +Before: 755
> >     +After : 777
> > 
> > Both test failures bisect to:  e360c6ed7274 ("ext4: Drop special handling of
> > journalled data from ext4_sync_file()").  Reverting this patch eliminates the
> > test failures.  So, I thought I'd bring these to your attention.
> 
> Thanks for report! Yeah, when doing commit e360c6ed7274 I forgot about
> directories which can be also fsynced and which need special treatment. I
> have to think a bit what's the best way to fix this.

After digging a bit in the code I understand now what has confused me. The
thing is that fastcommit does not track metadata changes on directories but
neither does it mark the filesystem as ineligible when they happen. So
ext4_fc_commit() implicitely relies on the fact that it never gets called
in any other case than fsync(2) on a regular file.

I believe we should improve fastcommit code to better handle directories
or at least not have these implicit assumptions but for now the easiest fix
is to return back the explicit full commit for non-regular files. I'll send
a patch.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
