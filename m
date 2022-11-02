Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF5F616506
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Nov 2022 15:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbiKBOWz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Nov 2022 10:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiKBOWb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Nov 2022 10:22:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C06C2B615
        for <linux-ext4@vger.kernel.org>; Wed,  2 Nov 2022 07:22:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D8A701F381;
        Wed,  2 Nov 2022 14:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667398940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X+1KXTNnC61mrCvitb5W6ztR8MRi3ezMd2tIbSxk0LY=;
        b=Jm+qWWVGdo5bRilidcxZiUQde4+5jfHgutkNp9/HFAJtSWySEPpqO7JnduDInOOYMsThUI
        f5cV3lvbVsxJNkvfuXKGWzxFnqtrmEAtvX1r9xYEtA5Aw1BzpZnqYsmESRJEFMkZsPM0vg
        oD+kiXtFUxSC713FDw/se4GLqXCy7s4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667398940;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X+1KXTNnC61mrCvitb5W6ztR8MRi3ezMd2tIbSxk0LY=;
        b=p5civxZNivLrWCrJYWQShw61zXGTyMyDlXYsZzrQ7AmdjtXZXfdJlKGgKPb4wJOEvXPPIP
        MPmlKSWScEqKXlBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA23F13AE0;
        Wed,  2 Nov 2022 14:22:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xwxWMRx9YmO3VwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 02 Nov 2022 14:22:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 57861A0700; Wed,  2 Nov 2022 15:22:20 +0100 (CET)
Date:   Wed, 2 Nov 2022 15:22:20 +0100
From:   Jan Kara <jack@suse.cz>
To:     Matt Bobrowski <repnop@google.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: General Filesystem Question - Interesting Unexplainable
 Observation
Message-ID: <20221102142220.gphjkgbb4aaplrvy@quack3>
References: <CAJBvgGfv9zsE4PEnuuVqKhiKfpbrxk=kXG4pp5AAMOXyVc5-bQ@mail.gmail.com>
 <20221031112237.kgr64levqo3dxoj5@quack3>
 <Y2HfC3VmWB/iadLU@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2HfC3VmWB/iadLU@google.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Matt!

On Wed 02-11-22 03:07:55, Matt Bobrowski wrote:
> On Mon, Oct 31, 2022 at 12:22:37PM +0100, Jan Kara wrote:
> > Hi Matthew!
> > 
> > [added ext4 mailing list to CC, maybe others have more ideas]
> > 
> > On Fri 28-10-22 23:23:14, Matt Bobrowski wrote:
> > > Just had a general question in regards to some recent filesystem (ext4)
> > > behaviour I've recently observed, which kind of made my eyebrows raise a
> > > little and I wanted to understand why this was happening.
> > > 
> > > We have an application (single threaded process) that basically performs
> > > the following sequence of filesystem operations using buffered I/O:
> > > 
> > > ---
> > > fd = open("dir/tmp/filename.new", O_WRONLY | O_CREAT | O_TRUNC, 0400);
> > > ...
> > > write(fd, buf, sizeof(buf));
> > > ...
> > > rename("dir/tmp/filename.new", "dir/new/filename");
> > > ---
> > > 
> > > At times, I see the "dir/new/filename" file size reporting 0 bytes, despite
> > > sizeof(buf) written to "dir/tmp/filename.new" always guaranteed to be > 0
> > > and the result of the write reported as being successful. This is the part
> > > I cannot come up with a valid explanation for (yet).
> > 
> > So by "file size reporting 0 bytes" do you mean that
> > stat("dir/new/filename") from a concurrent process returns file size 0
> > sometimes?
> 
> Not quite, meaning that stat("dir/new/filename") is reporting 0 bytes
> long after the write(2) operation had occurred. IOW, I'm seeing 0 byte
> files laying around when they well and truly should have had bytes
> written out to them (before a write(2) is issued we check to make sure
> that the supplied buffer actually has something in it) i.e. manually
> stat'ing them in a shell.

I see. So inode got written with 0 size to the disk.

> > Or do you refer to a situation after an unclean filesystem
> > shutdown?
> 
> It could very well be from an unclean shutdown, but it's really hard
> to say whether this is the culprit or not.

I see, ok.

> > > Understandably,
> > > there's no fsync being currently performed post calling write, which I
> > > think needs to be corrected, but I also can't see how not using fsync post
> > > write would result in the file size for "dir/new/filename" being reported
> > > as 0 bytes? One of the things that crossed my mind was that the rename
> > > operation was possibly being committed prior to the dirty pages from the
> > > pagecache being flushed, but regardless I don't see how a rename would
> > > result in the data blocks associated to the write not ever being committed
> > > for the same underlying inode?
> > > 
> > > What are your thoughts? Any plausible explanation why I might be seeing
> > > this odd behaviour?
> > 
> > Ext4 uses delayed allocation. That means that write(2) just stores data in
> > the page cache but no blocks are allocated yet. So indeed rename(2) can be
> > fully committed in the journal before any of the data gets to persistent
> > storage. That being said ext4 has a workaround for buggy applications (can
> > be disabled with "noauto_da_alloc" mount option) that starts data writeback
> > before rename is done so at least in data=ordered mode you should not see 0
> > length files after a crash with the above scheme.
> 
> Right, we are using buffered I/O after all... However, even if the
> rename(2) operation took place and was fully committed to the journal
> before the dirty pages associated to the prior write(2) had been
> written back, I wouldn't expect the data to be missing? IOW, the
> write(2) and rename(2) operations are taking effect on the same
> backing inode, no?

No. Because inode size changes as well as block allocation changes get
added to the journal only once the writeback happens. So until writeback
starts, rename(2) and write(2) can be arbitratily reordered (or you can
even see only part of the write being completed).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
