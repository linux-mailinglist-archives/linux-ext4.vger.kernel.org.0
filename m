Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C006FCE4C
	for <lists+linux-ext4@lfdr.de>; Tue,  9 May 2023 21:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbjEITJh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 May 2023 15:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjEITJg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 May 2023 15:09:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0823AA9
        for <linux-ext4@vger.kernel.org>; Tue,  9 May 2023 12:09:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 54D041F892;
        Tue,  9 May 2023 19:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683659373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=17TkFvEuJkgpuRtV3B4OncliaXa+PiWn55OuU33fO5g=;
        b=AkAgwUnP8pShbYfvvBp6PF73Eoe39uIhpVXZjrfPmcSsRFjTdoNIcdzgm8VeIJhwU0E2JE
        ARx/KMXmbkeVtsUqjrYB0+E+KXU0towG6h8dJm4UWui+89TaVPOUZ8Q9NJjKrh1YeYfpBT
        A73lF0TW6pgmMXTE2Xvl7e7qVSZ3vF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683659373;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=17TkFvEuJkgpuRtV3B4OncliaXa+PiWn55OuU33fO5g=;
        b=uyVHZwb1sEa0BJYxBFuPyQNaTJhravXKiaMbaCDk+IT4mQ/PG5ICHr9hY3OE7klUBezyRH
        HQjGkiscrmuXJgBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F84E139B3;
        Tue,  9 May 2023 19:09:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2IKnB22aWmQgIAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 09 May 2023 19:09:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A18CDA074D; Tue,  9 May 2023 21:09:30 +0200 (CEST)
Date:   Tue, 9 May 2023 21:09:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     jack@suse.cz, linux-ext4@vger.kernel.org
Subject: Re: 6.4-rc1 xfstests-bld adv regressions
Message-ID: <20230509190930.wyblxwohejmd43fw@quack3>
References: <ZFqO3xVnmhL7zv1x@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFqO3xVnmhL7zv1x@debian-BULLSEYE-live-builder-AMD64>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Eric!

On Tue 09-05-23 14:20:15, Eric Whitney wrote:
> I'm seeing two test regressions on 6.4-rc1 while running the adv test case
> with kvm-xfstests.  Both tests fail with 100% reliability in 100 trial runs,
> and the failures appear to depend solely upon the fast commit mount option.
> 
> The first is generic/065, where the relevant info from 065.full is:
> 
> _check_generic_filesystem: filesystem on /dev/vdc is inconsistent
> *** fsck.ext4 output ***
> fsck from util-linux 2.36.1
> e2fsck 1.47.0 (5-Feb-2023)
> Pass 1: Checking inodes, blocks, and sizes
> Pass 2: Checking directory structure
> Pass 3: Checking directory connectivity
> Pass 4: Checking reference counts
> Pass 5: Checking group summary information
> Directories count wrong for group #16 (4294967293, counted=0).
> 
> 
> The second is generic/535, where the test output is:
> 
>      QA output created by 535
>      Silence is golden
>     +Before: 755
>     +After : 777
> 
> Both test failures bisect to:  e360c6ed7274 ("ext4: Drop special handling of
> journalled data from ext4_sync_file()").  Reverting this patch eliminates the
> test failures.  So, I thought I'd bring these to your attention.

Thanks for report! Yeah, when doing commit e360c6ed7274 I forgot about
directories which can be also fsynced and which need special treatment. I
have to think a bit what's the best way to fix this.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
