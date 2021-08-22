Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEFA3F41CC
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Aug 2021 23:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbhHVVw7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 22 Aug 2021 17:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbhHVVw7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 22 Aug 2021 17:52:59 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD35C061575
        for <linux-ext4@vger.kernel.org>; Sun, 22 Aug 2021 14:52:17 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id m21so17215654qkm.13
        for <linux-ext4@vger.kernel.org>; Sun, 22 Aug 2021 14:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dblXQo8q61DiE1I7kok1B4vnI3vhak1vFiBg/hATIYQ=;
        b=FlYyjMCGBIwnRDDZjIGKdJ5NrvqtaqKSxvuynq2WUqKWx8IlGG0IQhtmsOnJjJapIv
         96rJgeeoBmxP3pX6guo0IhjuGMP4wwW70ZCw0ZYkRmEcCaBz/CXTddTx+4/VJMmculdg
         lF2g2UMU4sZhIjfc9PsMW+64S6C7vtUQtmozAU9WZ/NFjUMKYUYFnk9wkSoLAhRGSEuL
         r7AhHXrCtFI4ipiM8FFchFI5gMTEpvycXebPMtWv8kMzMvyPLuZfGhn1gUEWx49Ch6Kn
         0GqaZNnxeJm2dckB70BTKf0c123paST93g/XX/ZVla7XNIZcVUn6WFZbaLukHxrikbTe
         9s6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dblXQo8q61DiE1I7kok1B4vnI3vhak1vFiBg/hATIYQ=;
        b=TiVTog8zdP99vdNHznv/VZFCRixpzI1hhRsNZig20AMNpwoviuWnQmOhB+O+OBKGzL
         BL1hqrECevqe+l/IQD4p+6OzuTvqbfXIIeUYLZCdWgXJaDsGk4+gMXfIu+6WWIWYxKUH
         lRhCt20EL9vCySODm3dt/2Ye5MampCCPW4aLs+LcPzRnT8Z7xhGLcR3EWseEWXT8JJ+U
         MSRIDcM6VnUtu278KiKpr4Fxwuj0FV19QZSnN3exlRZ2pDMe1rc6awKtFTvDW5aWH41X
         qfTsb8241LLnRImVr8qoDNe/dG0kTXlWyTvaavQ/K/UobO0sXI1wwV0rfPyx7hqCyYgS
         du8w==
X-Gm-Message-State: AOAM533tOe4z8xle+mZUdK0TZrBeFsu2roZzXZJbxwA4gb/e/Ro/iPrp
        EdoRxmCIffnt96tZJe8DftA=
X-Google-Smtp-Source: ABdhPJznqrwNbitAKuZduWp7SDzF7YGPXvsy6abMf+jH+Am+UpfLw6TZJH3jhWo98IAjWIncYh8YuA==
X-Received: by 2002:a37:9f48:: with SMTP id i69mr19636054qke.142.1629669136717;
        Sun, 22 Aug 2021 14:52:16 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id g20sm7200246qki.73.2021.08.22.14.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Aug 2021 14:52:16 -0700 (PDT)
Date:   Sun, 22 Aug 2021 17:52:14 -0400
From:   Eric Whitney <enwlinux@gmail.com>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     Eric Whitney <enwlinux@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: fix reserved space counter leakage
Message-ID: <20210822215214.GA12669@localhost.localdomain>
References: <20210819091351.19297-1-jefflexu@linux.alibaba.com>
 <20210820164556.GA30851@localhost.localdomain>
 <c7a95109-e468-cd25-1042-20e0779a87d4@linux.alibaba.com>
 <e33bc4a3-4378-364e-c834-8bb479872fa4@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e33bc4a3-4378-364e-c834-8bb479872fa4@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Joseph Qi <joseph.qi@linux.alibaba.com>:
> 
> 
> On 8/22/21 9:06 PM, Joseph Qi wrote:
> > 
> > 
> > On 8/21/21 12:45 AM, Eric Whitney wrote:
> >> * Jeffle Xu <jefflexu@linux.alibaba.com>:
> >>> When ext4_es_insert_delayed_block() returns error, e.g., ENOMEM,
> >>> previously reserved space is not released as the error handling,
> >>> in which case @s_dirtyclusters_counter is left over. Since this delayed
> >>> extent failes to be inserted into extent status tree, when inode is
> >>> written back, the extra @s_dirtyclusters_counter won't be subtracted and
> >>> remains there forever.
> >>>
> >>> This can leads to /sys/fs/ext4/<dev>/delayed_allocation_blocks remains
> >>> non-zero even when syncfs is executed on the filesystem.
> >>>
> >>
> >> Hi:
> >>
> >> I think the fix below looks fine.  However, this comment doesn't look right
> >> to me.  Are you really seeing delayed_allocation_blocks values that remain
> >> incorrectly elevated across last closes (or across file system unmounts and
> >> remounts)?  s_dirtyclusters_counter isn't written out to stable storage -
> >> it's an in-memory only variable that's created when a file is first opened
> >> and destroyed on last close.
> >>
> > 
> > Actually we've encountered a real case in our production environment,
> > which has about 20G space lost (df - du = ~20G).
> > After some investigation, we've confirmed that it cause by leaked
> > s_dirtyclusters_counter (~5M), and even we do manually sync, it remains.
> > Since there is no error messages, we've checked all logic around
> > s_dirtyclusters_counter and found this. Also we can manually inject
> > error and reproduce the leaked s_dirtyclusters_counter.
> > 

Sure - as I noted, the fix looks good - I agree that you could see inaccurate
s_dirtyclusters_counter (and i_reserved_data_blocks) values.  This is a good
catch and a good fix.  It's the comment I find misleading / inaccurate, and
I'd like to see that improved for the sake of developers reading commit
histories in the future.

Also, Gao Xiang's idea of checking i_reserved_data_blocks in the inode evict
path sounds good to me - I'd considered doing that in the past but never
actually did it.

> 
> BTW, it's a runtime lost, but not about on-disk.
> If umount and then mount it again, it becomes normal. But
> application also should be restarted...

And this is where the comment could use a little help.  "when inode is
written back, the extra @s_dirtyclusters_counter won't be subtracted and
remains there forever" suggests to me that s_dirtyclusters_counter is
being persisted on stable storage.  But as you note, simply umounting and
remounting the filesystem clears up the problem.  (And in my rush to get
my feedback out earlier I incorrectly stated that s_dirtyclusters_counter
would get created and destroyed on first open and last close - that's
i_reserved_data_blocks, of course.)

So, in order to speed things along, please allow me to suggest some edits
for the commit comment:

When ext4_insert_delayed block receives and recovers from an error from
ext4_es_insert_delayed_block(), e.g., ENOMEM, it does not release the
space it has reserved for that block insertion as it should.  One effect
of this bug is that s_dirtyclusters_counter is not decremented and remains
incorrectly elevated until the file system has been unmounted.  This can
result in premature ENOSPC returns and apparent loss of free space.

Another effect of this bug is that /sys/fs/ext4/<dev>/delayed_allocation_blocks
can remain non-zero even after syncfs has been executed on the filesystem.

Does that sound right?

Regards,
Eric

> 
> Thanks,
> Joseph
