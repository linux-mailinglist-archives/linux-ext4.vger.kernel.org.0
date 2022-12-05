Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FDA643689
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Dec 2022 22:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiLEVKz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Dec 2022 16:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiLEVKy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Dec 2022 16:10:54 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22838CF9
        for <linux-ext4@vger.kernel.org>; Mon,  5 Dec 2022 13:10:53 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2B5LAlI9005230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Dec 2022 16:10:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1670274649; bh=6jcMMAfJcjtqEGkSkydhoApZ0ELUrGZ/x3/QJFaQuDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=VORGXMbsg0/TVwc4/0ANW6/tFMksdeUxMFVR4vnjk7ReIL6XKlrsIoGjeV3o40GpZ
         n1I+VoPP623g7Js1qGG57dZ8pg21ZX5K3EsIflOqddjvton7HO7G+2Hcs+qM8IEXw4
         8kDHnLYOWuJvqm/x29PzPp+7pev+ruHRSrgJEXHcSsop3wMM3/mexsOeD4DxmstAIa
         xF1EanD8ngCnlBT7WH2FZ67wfzt4SGN8AuPMoRDEbfdu/f5o+vCSisgoQc0g6IXUQl
         qSeFneOysgUwSJmaXUL/4X3VLmyZqu7loRzSlJiePDOvXdvi56XXjQma4KSTeXjdWz
         GrWcDTkue7ceA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7F91E15C3489; Mon,  5 Dec 2022 16:10:47 -0500 (EST)
Date:   Mon, 5 Dec 2022 16:10:47 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ivan Zahariev <famzah@icdsoft.com>
Cc:     linux-ext4@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: kernel BUG at fs/ext4/inode.c:1914 - page_buffers()
Message-ID: <Y45eV/nA2tj8C94W@mit.edu>
References: <c9e47bc3-3c5f-09ae-9dcc-eb5957d78b1b@icdsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c9e47bc3-3c5f-09ae-9dcc-eb5957d78b1b@icdsoft.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 23, 2022 at 04:48:01PM +0200, Ivan Zahariev wrote:
> Hello,
> 
> Starting with kernel 5.15 for the past eight months we have a total of 12
> kernel panics at a fleet of 1000 KVM/Qemu machines which look the following
> way:
> 
>     kernel BUG at fs/ext4/inode.c:1914
> 
> Switching from kernel 4.14 to 5.15 almost immediately triggered the problem.
> Therefore we are very confident that userland activity is more or less the
> same and is not the root cause. The kernel function which triggers the BUG
> is __ext4_journalled_writepage(). In 5.15 the code for
> __ext4_journalled_writepage() in "fs/ext4/inode.c" is the same as the
> current kernel "master". The line where the BUG is triggered is:
> 
>     struct buffer_head *page_bufs = page_buffers(page)
	...
> 
> Back to the problem! 99% of the difference between 4.14 and the latest
> kernel for __ext4_journalled_writepage() in "fs/ext4/inode.c" comes from the
> following commit: https://github.com/torvalds/linux/commit/5c48a7df91499e371ef725895b2e2d21a126e227
> 
> Is it safe that we revert this patch on the latest 5.15 kernel, so that we
> can confirm if this resolves the issue for us?

No, it's not safe to revert this patch; this fixes a potential
use-after-free bug identified by Syzkaller (and use-after-frees can
sometimes be leveraged into security volunerabilities.

I have not tested this change yet, but looking at the code and the
change made in patch yet, this *might* be a possible fix:

	size = i_size_read(inode);
-	if (page->mapping != mapping || page_offset(page) > size) {
+	if (page->mapping != mapping || page_offset(page) >= size) {
		/* The page got truncated from under us */
		ext4_journal_stop(handle);
		ret = 0;
		goto out;
	}

Is it fair to say that your workload is using data=journaled and is
frequently truncating that might have been recently modified (hence
triggering the race between truncate and journalled writepages)?

I wonder if you could come up with a more reliable reproducer so we
can test a particular patch.

Thanks,

					- Ted


