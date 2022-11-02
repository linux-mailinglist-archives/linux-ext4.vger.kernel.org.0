Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2106861594E
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Nov 2022 04:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiKBDJO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Nov 2022 23:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiKBDIf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Nov 2022 23:08:35 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B58248CD
        for <linux-ext4@vger.kernel.org>; Tue,  1 Nov 2022 20:08:01 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id g10so4400656qkl.6
        for <linux-ext4@vger.kernel.org>; Tue, 01 Nov 2022 20:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OFb4RMXv2R2C6XS2iBT8tAoikrab4gKj323FAXgLA/Y=;
        b=sPrbTK80O7W6eAjfc6L/nN1vQz18elBePPz7Fchn7Qj9Ud0iCW5GuBVC8Mcp3XyWNp
         ZPnM5SpZxKKMfglXwP+1GMuL63MEnCxXnYK+y006thkE3gs35dbzlMdWMiXZmyu9dX+m
         CM4D4O2qxIU4p3yS/iTEvJ42zez36oTMi7He+N5EhroN5tSEEuJ8/miw2mERlkxkAwOL
         7QQpiqWFyyeUrCfMelaEnxI6x/2ng94bpAmghcu56zGWxH5bq1UZ+HZA4BuSGAxukENl
         qHbT1yKJm+UfaM8kuH5kLffesgYO0I5OhAwVidmROdZguwnmW98zZ+bOSZcrd8sZtzFp
         RUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFb4RMXv2R2C6XS2iBT8tAoikrab4gKj323FAXgLA/Y=;
        b=6dIbDndflfJX9xN3DMrrhrAIyj+6X97/BwRYoUgpr+u5nG351QdI+C6AdeMtHkzJRc
         e62zmJwphJ3DLWIuM3kMFZZ3RO3goyWOa/FtunM7SchdjqGoAN4DF5p2txALXL4nta+o
         3Bpwg0RmASEiZ4Sw+JHzgK2/cTInxINYhlCtiLszAcLhy+9G3jg98br2vkgiUbtUnMmL
         iXVyH1B015gS+ies9lq1Ey3IkE9whITZGnScUnOR7iEJiXtbhH7IjzXdnBEY2phX/D9G
         m9jd6PysWq0SYhl5i8+jh/CPjUXOSlEPlGcrVfpMr96h5KQpK9qJ86KwC2v5ySsHmbsH
         yrOg==
X-Gm-Message-State: ACrzQf1HWxDk4jqfAnUVMXffi1J2KBorL+YCGM0hO73CMWotLudRHRJz
        95CUTX/HWVwjosp5y2LveCk9iw1/u6y0eg==
X-Google-Smtp-Source: AMsMyM51exwbLUpSbxxb6bjrbhvpyt5wMijnRVPZRpxLE+rrqb8FAohbKllFUDgeQ+oFcNHt/gTGdw==
X-Received: by 2002:a37:a853:0:b0:6f9:da0d:e11 with SMTP id r80-20020a37a853000000b006f9da0d0e11mr15722579qke.174.1667358480187;
        Tue, 01 Nov 2022 20:08:00 -0700 (PDT)
Received: from google.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id r1-20020a05620a298100b006fa5815b88dsm633216qkp.88.2022.11.01.20.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 20:07:59 -0700 (PDT)
Date:   Wed, 2 Nov 2022 03:07:55 +0000
From:   Matt Bobrowski <repnop@google.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: General Filesystem Question - Interesting Unexplainable
 Observation
Message-ID: <Y2HfC3VmWB/iadLU@google.com>
References: <CAJBvgGfv9zsE4PEnuuVqKhiKfpbrxk=kXG4pp5AAMOXyVc5-bQ@mail.gmail.com>
 <20221031112237.kgr64levqo3dxoj5@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031112237.kgr64levqo3dxoj5@quack3>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hey Jan,

Thanks for getting back to me.

On Mon, Oct 31, 2022 at 12:22:37PM +0100, Jan Kara wrote:
> Hi Matthew!
> 
> [added ext4 mailing list to CC, maybe others have more ideas]
> 
> On Fri 28-10-22 23:23:14, Matt Bobrowski wrote:
> > Just had a general question in regards to some recent filesystem (ext4)
> > behaviour I've recently observed, which kind of made my eyebrows raise a
> > little and I wanted to understand why this was happening.
> > 
> > We have an application (single threaded process) that basically performs
> > the following sequence of filesystem operations using buffered I/O:
> > 
> > ---
> > fd = open("dir/tmp/filename.new", O_WRONLY | O_CREAT | O_TRUNC, 0400);
> > ...
> > write(fd, buf, sizeof(buf));
> > ...
> > rename("dir/tmp/filename.new", "dir/new/filename");
> > ---
> > 
> > At times, I see the "dir/new/filename" file size reporting 0 bytes, despite
> > sizeof(buf) written to "dir/tmp/filename.new" always guaranteed to be > 0
> > and the result of the write reported as being successful. This is the part
> > I cannot come up with a valid explanation for (yet).
> 
> So by "file size reporting 0 bytes" do you mean that
> stat("dir/new/filename") from a concurrent process returns file size 0
> sometimes?

Not quite, meaning that stat("dir/new/filename") is reporting 0 bytes
long after the write(2) operation had occurred. IOW, I'm seeing 0 byte
files laying around when they well and truly should have had bytes
written out to them (before a write(2) is issued we check to make sure
that the supplied buffer actually has something in it) i.e. manually
stat'ing them in a shell.

> Or do you refer to a situation after an unclean filesystem
> shutdown?

It could very well be from an unclean shutdown, but it's really hard
to say whether this is the culprit or not.

> > Understandably,
> > there's no fsync being currently performed post calling write, which I
> > think needs to be corrected, but I also can't see how not using fsync post
> > write would result in the file size for "dir/new/filename" being reported
> > as 0 bytes? One of the things that crossed my mind was that the rename
> > operation was possibly being committed prior to the dirty pages from the
> > pagecache being flushed, but regardless I don't see how a rename would
> > result in the data blocks associated to the write not ever being committed
> > for the same underlying inode?
> > 
> > What are your thoughts? Any plausible explanation why I might be seeing
> > this odd behaviour?
> 
> Ext4 uses delayed allocation. That means that write(2) just stores data in
> the page cache but no blocks are allocated yet. So indeed rename(2) can be
> fully committed in the journal before any of the data gets to persistent
> storage. That being said ext4 has a workaround for buggy applications (can
> be disabled with "noauto_da_alloc" mount option) that starts data writeback
> before rename is done so at least in data=ordered mode you should not see 0
> length files after a crash with the above scheme.

Right, we are using buffered I/O after all... However, even if the
rename(2) operation took place and was fully committed to the journal
before the dirty pages associated to the prior write(2) had been
written back, I wouldn't expect the data to be missing? IOW, the
write(2) and rename(2) operations are taking effect on the same
backing inode, no?

/M
