Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C99609F48
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Oct 2022 12:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJXKqh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Oct 2022 06:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJXKqh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Oct 2022 06:46:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A328175BF
        for <linux-ext4@vger.kernel.org>; Mon, 24 Oct 2022 03:46:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EC8F822166;
        Mon, 24 Oct 2022 10:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666608394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2FvHy61zNNsqFHsuY2jmJJqiKx6vhdiyCJYsyr/Sidg=;
        b=eXh+WShiPYnDYKYQ6u0ryuOLEHmYI/11W0LGpSdT/qPMlMT2v29xXszs6xSMlSNSiDHI2h
        p+5E6QVsFp8r5oMF+YrgxSeS37vQzJ9lxoqL94bTLf+KKIvRvtzNbRrnPqrKtmUv7lODjn
        OFS5f7KixEhDDzWFRImFbBLWSa3X/vw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666608394;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2FvHy61zNNsqFHsuY2jmJJqiKx6vhdiyCJYsyr/Sidg=;
        b=ifyagaWfmcOvEz4qUSEN+bMJaHFbO1WYNzZpEcj3UkbGGH6tY419BT6Z0eO8cyKZ/I/NON
        sW49orQPm2Yc7aDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3AFD313357;
        Mon, 24 Oct 2022 10:46:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vuZVDgptVmOAHgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 24 Oct 2022 10:46:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2A7AFA06F6; Mon, 24 Oct 2022 12:46:28 +0200 (CEST)
Date:   Mon, 24 Oct 2022 12:46:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     Thilo Fromm <t-lo@linux.microsoft.com>
Cc:     Jan Kara <jack@suse.cz>, Ye Bin <yebin10@huawei.com>,
        jack@suse.com, tytso@mit.edu, linux-ext4@vger.kernel.org,
        regressions@lists.linux.dev,
        Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Subject: Re: [syzbot] possible deadlock in jbd2_journal_lock_updates
Message-ID: <20221024104628.ozxjtdrotysq2haj@quack3>
References: <20220929082716.5urzcfk4hnapd3cr@quack3>
 <d8b18ba8-ea12-b617-6b5e-455a1d7b5e21@linux.microsoft.com>
 <20221004063807.GA30205@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20221004091035.idjgo2xyscf6ovnv@quack3>
 <eeb17fca-4e79-b39f-c394-a6fa6873eb26@linux.microsoft.com>
 <20221005151053.7jjgc7uhvquo6a5n@quack3>
 <20221010142410.GA1689@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <2ede5fce-7077-6e64-93a9-a7d993bc498f@linux.microsoft.com>
 <20221014132543.i3aiyx4ent4qwy4i@quack3>
 <d30f4e74-aa75-743d-3c89-80ec61d67c6c@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d30f4e74-aa75-743d-3c89-80ec61d67c6c@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 21-10-22 12:23:41, Thilo Fromm wrote:
> Hello Honza,
> 
> > > Just want to make sure this does not get lost - as mentioned earlier,
> > > reverting 51ae846cff5 leads to a kernel build that does not have this issue.
> > 
> > Yes, I'm aware of this and still cannot quite wrap my head how it could be
> > given the stacktraces I see :) They do not seem to come anywhere near that
> > code...
> 
> Just reaching out to let folks know that we see more reports on this issue
> coming in for kernels >=5.15.63, see
> https://github.com/flatcar/Flatcar/issues/847#issuecomment-1286523602.

Yeah, I was pondering about this for some time but still I have no clue who
could be holding the buffer lock (which blocks the task holding the
transaction open) or how this could related to the commit you have
identified. I have two things to try:

1) Can you please check whether the deadlock reproduces also with 6.0
kernel? The thing is that xattr handling code in ext4 has there some
additional changes, commit 307af6c8793 ("mbcache: automatically delete
entries from cache on freeing") in particular. 

2) I have created a debug patch (against 5.15.x stable kernel). Can you
please reproduce the failure with it and post the output of "echo w
>/proc/sysrq-trigger" and also the output the debug patch will put into the
kernel log? It will dump the information about buffer lock owner if we
cannot get the lock for more than 32 seconds.

Thanks for your help and patience.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
