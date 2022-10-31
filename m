Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6352613469
	for <lists+linux-ext4@lfdr.de>; Mon, 31 Oct 2022 12:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiJaLWl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 31 Oct 2022 07:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJaLWk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 31 Oct 2022 07:22:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46756E080
        for <linux-ext4@vger.kernel.org>; Mon, 31 Oct 2022 04:22:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E303C336EA;
        Mon, 31 Oct 2022 11:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667215357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=86YO1WYsCTGWKhmbpqlB8wnmy4qijgS6aefbvbphChE=;
        b=AXMDLBsJJbkRT1CX8Rn4xJh1T5EtcEZGzWp5RaoBqNAzyE9I8qxGa5+GFjwxNgGzFwK8H3
        d9UFJIAv5Nb6pIjVjgft94XtxILoA1AoeV4ub0m+r9/1TE1LybDVepc/9KMcTcKJ5B1Tqz
        AmaWNMokpJyqjru474aQ1HN6Qv1R8a4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667215357;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=86YO1WYsCTGWKhmbpqlB8wnmy4qijgS6aefbvbphChE=;
        b=YOEbUCyzNevCmOy+Wp0U+j6b+hCtYxxEBnlGem67xLIYSkWOZWVUcwIi5Dmn414xERTDgN
        fEJsow/ydGThmhCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D670A13AAD;
        Mon, 31 Oct 2022 11:22:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rXBRNP2vX2OsGAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 31 Oct 2022 11:22:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 65760A070B; Mon, 31 Oct 2022 12:22:37 +0100 (CET)
Date:   Mon, 31 Oct 2022 12:22:37 +0100
From:   Jan Kara <jack@suse.cz>
To:     Matt Bobrowski <repnop@google.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: General Filesystem Question - Interesting Unexplainable
 Observation
Message-ID: <20221031112237.kgr64levqo3dxoj5@quack3>
References: <CAJBvgGfv9zsE4PEnuuVqKhiKfpbrxk=kXG4pp5AAMOXyVc5-bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJBvgGfv9zsE4PEnuuVqKhiKfpbrxk=kXG4pp5AAMOXyVc5-bQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Matthew!

[added ext4 mailing list to CC, maybe others have more ideas]

On Fri 28-10-22 23:23:14, Matt Bobrowski wrote:
> Just had a general question in regards to some recent filesystem (ext4)
> behaviour I've recently observed, which kind of made my eyebrows raise a
> little and I wanted to understand why this was happening.
> 
> We have an application (single threaded process) that basically performs
> the following sequence of filesystem operations using buffered I/O:
> 
> ---
> fd = open("dir/tmp/filename.new", O_WRONLY | O_CREAT | O_TRUNC, 0400);
> ...
> write(fd, buf, sizeof(buf));
> ...
> rename("dir/tmp/filename.new", "dir/new/filename");
> ---
> 
> At times, I see the "dir/new/filename" file size reporting 0 bytes, despite
> sizeof(buf) written to "dir/tmp/filename.new" always guaranteed to be > 0
> and the result of the write reported as being successful. This is the part
> I cannot come up with a valid explanation for (yet).

So by "file size reporting 0 bytes" do you mean that
stat("dir/new/filename") from a concurrent process returns file size 0
sometimes? Or do you refer to a situation after an unclean filesystem
shutdown?

> Understandably,
> there's no fsync being currently performed post calling write, which I
> think needs to be corrected, but I also can't see how not using fsync post
> write would result in the file size for "dir/new/filename" being reported
> as 0 bytes? One of the things that crossed my mind was that the rename
> operation was possibly being committed prior to the dirty pages from the
> pagecache being flushed, but regardless I don't see how a rename would
> result in the data blocks associated to the write not ever being committed
> for the same underlying inode?
> 
> What are your thoughts? Any plausible explanation why I might be seeing
> this odd behaviour?

Ext4 uses delayed allocation. That means that write(2) just stores data in
the page cache but no blocks are allocated yet. So indeed rename(2) can be
fully committed in the journal before any of the data gets to persistent
storage. That being said ext4 has a workaround for buggy applications (can
be disabled with "noauto_da_alloc" mount option) that starts data writeback
before rename is done so at least in data=ordered mode you should not see 0
length files after a crash with the above scheme.

WRT concurrent process seeing 0 file length, I would not have a great
explanation for that because once data is written to the inode,
inode->i_size is set to the final inode size which is what stat(2) reports.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
