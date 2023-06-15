Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC35732397
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jun 2023 01:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239840AbjFOX0I (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Jun 2023 19:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240517AbjFOXZz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Jun 2023 19:25:55 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E88B2D67
        for <linux-ext4@vger.kernel.org>; Thu, 15 Jun 2023 16:25:26 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-54fba092ef5so153961a12.2
        for <linux-ext4@vger.kernel.org>; Thu, 15 Jun 2023 16:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1686871455; x=1689463455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JheLVD7TgrrvPlKIUUj5StkKxZqSq86+H9+pZtscafQ=;
        b=Lr3zDrvg2YjLbg3wAQHAeQdra8CjJ+8zvzS/D1LsCH8dUK4gEAlyx3fK6Lg92tUKyV
         DA0u9/ttDd/fo4+MWQB1byPxmwICujA1bPmNPkCKf+2mc2toD/KHIY/50jB4gfhrs1pp
         VjplEv4s/j0PdsCtMu5X2Yy1KWyLM9fSBoCJVP6SnMYLiYzDtS5EPOa9YobyjTRTltnX
         1F81vewiLpjmqN7kneuUF835bmjj9UtxBlfLEZIrSy9EkUbnpyBPdp4geNyGZ2Gks8OE
         3rc/7EfmOPDTwUmOm34+UtkjxAoo3jFKAlMPudGHc/zvR5qRusPLZmwwMWC2ufKPlxZ8
         kJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686871455; x=1689463455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JheLVD7TgrrvPlKIUUj5StkKxZqSq86+H9+pZtscafQ=;
        b=Bhzxt3ovZB5VCbjRLKFtAlCMaqzuRSlfcl1+VCb2j1cnf6XWSpRwYO6QGGHG3CjJsn
         gdqzd+jFQVP3rHa2gJz5mXNGoB5CZhoJEZ6vibGkno3kFbyagclWmgn90ra7/NjbLbus
         Y+ubfyPyQyQX1U3/yG/tS5B+9DpMXyNhdM4RL01fL7N4No/eVn+AnobstZBzwgUgPoje
         flaYg8O34ZXm2R8t1t29+SMO3Kvw2noyQWUy0QpdjRXUN4D7541jzowCnPKqpv3uuhvn
         UWamg7tf0BUF7KNMe1E9hIzfVxtNO1PXG5M7vOoWhE2+RmkEQ+3OjLbi7h5SsWfshEH6
         R46g==
X-Gm-Message-State: AC+VfDzZvkIWOK0gLhp8KbZMJJhlJ+vozmxFkRH3LBpLFwWfw08f9JI2
        3iEhhWuC0E9ENNd1P2zRACUz/g==
X-Google-Smtp-Source: ACHHUZ78m4fIR3MUtoAd0hJNcioMO/s+jSbBSiDI5uOxzi/4tfw/TgO7KEDvR1BzVFf3efA8dahY2A==
X-Received: by 2002:a17:903:32c1:b0:1ab:7fb:aac1 with SMTP id i1-20020a17090332c100b001ab07fbaac1mr531142plr.24.1686871455650;
        Thu, 15 Jun 2023 16:24:15 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id j3-20020a17090276c300b001ac7af58b66sm14509724plt.224.2023.06.15.16.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 16:24:15 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q9wK4-00CFk8-1K;
        Fri, 16 Jun 2023 09:24:12 +1000
Date:   Fri, 16 Jun 2023 09:24:12 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Aleksandr Nogikh <nogikh@google.com>, adilger.kernel@dilger.ca,
        jack@suse.com, linux-ext4@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+af5e10f73dbff48f70af@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [ext4?] UBSAN: shift-out-of-bounds in ext2_fill_super
 (2)
Message-ID: <ZIudnDI5JZU+4w42@dread.disaster.area>
References: <00000000000079134b05fdf78048@google.com>
 <20230613180103.GC18303@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613180103.GC18303@mit.edu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jun 13, 2023 at 02:01:03PM -0400, Theodore Ts'o wrote:
> I wonder if we should have a separate syzkaller subsystem for ext2 (as
> distinct from ext4)?  The syz reproducer seems to know that it should
> be mounting using ext2, but also calls it an ext4 file system, which
> is a bit weird.  I'm guessing there is something specific about the
> syzkaller internals which might not make this be practical, but I
> thought I should ask.
> 
> From the syz reproducer:
> 
> syz_mount_image$ext4(&(0x7f0000000100)='ext2\x00', ...)
> 
> More generally, there are a series of changes that were made to make
> ext4 to make it more robust against maliciously fuzzed superblocks,
> but we haven't necessarily made sure the same analogous changes have
> been made to ext2.  I'm not sure how critical this is in practice,
> since most distributions don't actually compile fs/ext2 and instead
> use CONFIG_EXT4_USE_FOR_EXT2 instead.  However, while we maintain ext2
> as a sample "simple" modern file system, I guess we should try to make
> sure we do carry those fixes over.

Hmmmm.

Modern filesystems are crash resilient, based on extents and are
using/moving to folios+iomap - calling a non-journalled, indirect
block indexed, bufferhead based code base (that nobody is really
using in production) "modern" seems like a real stretch.

I have my doubts that maintaining fs/ext2 is providing much benefit
to anyone.  The code base is in the git history if anyone wants to
study it, so it's not like we have to keep it active in the tree for
it to remain a code base that people can learn from.

Therefore, given the current push to sideline/remove bufferheads
from the kernel, should we simply deprecate fs/ext2 and then remove
it in a year or two like we're doing with reiser to reduce our
future maintenance and/or conversion burden?

Or just remove it right now and simply make CONFIG_FS_EXT2 select
CONFIG_EXT4_USE_FOR_EXT2?

/Devil's Advocate

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
