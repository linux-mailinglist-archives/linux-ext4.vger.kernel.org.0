Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0700C733528
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jun 2023 17:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjFPPt5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Jun 2023 11:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjFPPt4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Jun 2023 11:49:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845682967
        for <linux-ext4@vger.kernel.org>; Fri, 16 Jun 2023 08:49:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3BEDF1F749;
        Fri, 16 Jun 2023 15:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686930594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hicNHehwltG1cUZJBmiwYK9Ajkuzo+7q9132g1mRXFQ=;
        b=jhW//RGAfR92YJm4X1CxCOlFuiiWeXkS4QSdsR2Zbg+2Hd338CEnXl+SJ9iwtY9rHZzn8m
        yYc8cQRvZBywat0fITGthmPuwwCg91hJ1WbstH236aWqMRnHHQ5lko4YN5S68WlUrPsrtO
        JMvSNJcvpUGcW+ofG1UbxC4XSJPusaM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686930594;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hicNHehwltG1cUZJBmiwYK9Ajkuzo+7q9132g1mRXFQ=;
        b=Clz8lH0+vTC6uNdRjbrksGNS4qAIK4eNF5u9qmMKMCU9JYxkrvapKyJdjm17Be+drKPVyO
        Z+wr+V+4QI0PDlBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 29F0E138E8;
        Fri, 16 Jun 2023 15:49:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Vt03CqKEjGTYCgAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Jun 2023 15:49:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 788C7A0755; Fri, 16 Jun 2023 17:49:53 +0200 (CEST)
Date:   Fri, 16 Jun 2023 17:49:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Aleksandr Nogikh <nogikh@google.com>, adilger.kernel@dilger.ca,
        jack@suse.com, linux-ext4@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+af5e10f73dbff48f70af@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [ext4?] UBSAN: shift-out-of-bounds in ext2_fill_super
 (2)
Message-ID: <20230616154953.etu5cg3se3sucem6@quack3>
References: <00000000000079134b05fdf78048@google.com>
 <20230613180103.GC18303@mit.edu>
 <ZIudnDI5JZU+4w42@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIudnDI5JZU+4w42@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 16-06-23 09:24:12, Dave Chinner wrote:
> On Tue, Jun 13, 2023 at 02:01:03PM -0400, Theodore Ts'o wrote:
> > I wonder if we should have a separate syzkaller subsystem for ext2 (as
> > distinct from ext4)?  The syz reproducer seems to know that it should
> > be mounting using ext2, but also calls it an ext4 file system, which
> > is a bit weird.  I'm guessing there is something specific about the
> > syzkaller internals which might not make this be practical, but I
> > thought I should ask.
> > 
> > From the syz reproducer:
> > 
> > syz_mount_image$ext4(&(0x7f0000000100)='ext2\x00', ...)
> > 
> > More generally, there are a series of changes that were made to make
> > ext4 to make it more robust against maliciously fuzzed superblocks,
> > but we haven't necessarily made sure the same analogous changes have
> > been made to ext2.  I'm not sure how critical this is in practice,
> > since most distributions don't actually compile fs/ext2 and instead
> > use CONFIG_EXT4_USE_FOR_EXT2 instead.  However, while we maintain ext2
> > as a sample "simple" modern file system, I guess we should try to make
> > sure we do carry those fixes over.
> 
> Hmmmm.
> 
> Modern filesystems are crash resilient, based on extents and are
> using/moving to folios+iomap - calling a non-journalled, indirect
> block indexed, bufferhead based code base (that nobody is really
> using in production) "modern" seems like a real stretch.

Yeah, modern is a stretch. But I guess what Ted meant is that we try to
keep ext2 reasonably uptodate with various infrastructure changes. We have
now queued conversion of ext2 direct IO path to iomap and are looking into
converting buffered IO path to iomap as a sample to get experience for ext4
conversion and also conversion of other "simple" filesystems.

> I have my doubts that maintaining fs/ext2 is providing much benefit
> to anyone.  The code base is in the git history if anyone wants to
> study it, so it's not like we have to keep it active in the tree for
> it to remain a code base that people can learn from.
> 
> Therefore, given the current push to sideline/remove bufferheads
> from the kernel, should we simply deprecate fs/ext2 and then remove
> it in a year or two like we're doing with reiser to reduce our
> future maintenance and/or conversion burden?

That's a fair remark and if there is a general sentiment that ext2 codebase
is not really useful, I certainly won't mind having one less fs to
maintain. I'd just note that having ext2 in git history will not provide
very useful insight into how various current infrastructure changes could
be implemented for simple filesystems.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
