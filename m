Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA2A249232
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Aug 2020 03:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgHSBPx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Aug 2020 21:15:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34487 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbgHSBPx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 Aug 2020 21:15:53 -0400
Received: from mail-vk1-f199.google.com ([209.85.221.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mauricio.oliveira@canonical.com>)
        id 1k8Chi-00005R-Df
        for linux-ext4@vger.kernel.org; Wed, 19 Aug 2020 01:15:50 +0000
Received: by mail-vk1-f199.google.com with SMTP id p2so7388506vkp.4
        for <linux-ext4@vger.kernel.org>; Tue, 18 Aug 2020 18:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B/afMS/besZkt6iwGq1A9it5nIHMYYe5ZPFtv7NO1H4=;
        b=FP6pMyCeWO/75NPp3dP/eqV0YCFoUXX3x//CSBT+Y9M3edwQZjTPVvAC2Lk1V4v4h7
         XmX2zouIUtdMtv5MK0oZW/VcfDkuKsmX7TACLlPKGJ6QpBbxKpTx0Bfa69EM319Kw9S5
         q8uuq4P2NucTKaBffZjfzn/yDJ9vrGRbU7Khqvg6UDVWx9ZiYDhvy5JHOiXK9KbM9s00
         kLr7NfYliKZYZ+r9+e68nrsylxNjuXzxChJa+KvvPnPkkd0Bhzci8dONH4FL0BZkTfS4
         iVMXM9TRw28lU3OZeAu4Msw30Erfcxefx6E8xWRT8PvIwvisbva4qOBrnzQPM77oyJ4x
         X25A==
X-Gm-Message-State: AOAM531rZ37ev+NQ8kX5tT0M8Aou7Xyq+aDTwB93QS12bqcRLZ6TbG0v
        QP6lY7mlW6dNNCFyF9eFYMXoKdw69g+0iYgS7bwxhYGVWEEsb1Mpvtt+mEbUZLlIgtrouEZFRMK
        tAD6RD2aKHSuDqOxGgiR9uxxhj8zkxfQ/wwV1B0RRpipTO8IuWiwe5hU=
X-Received: by 2002:a05:6102:209d:: with SMTP id h29mr12910322vsr.212.1597799749259;
        Tue, 18 Aug 2020 18:15:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOK89bNhQvbWdpXx1dHVGOD5+ze3xSrnWnXyquL0eE9qV2RfOTANkZsJX46a6mWIV8lMeTlbNPaz7ct29vGVs=
X-Received: by 2002:a05:6102:209d:: with SMTP id h29mr12910305vsr.212.1597799748679;
 Tue, 18 Aug 2020 18:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200810010210.3305322-1-mfo@canonical.com> <20200810010210.3305322-2-mfo@canonical.com>
 <20200818143844.GB1902@quack2.suse.cz>
In-Reply-To: <20200818143844.GB1902@quack2.suse.cz>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Tue, 18 Aug 2020 22:15:37 -0300
Message-ID: <CAO9xwp1hjSFYjSYdvjAJ8bs24=Vyc3Uk3RtmGz0_HiHDW_SVCw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/5] jbd2: test case for ext4 data=journal/mmap()
 journal corruption
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>,
        Mauricio Faria de Oliveira <mauricio.foliveira@gmail.com>,
        Jan Kara <jack@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Aug 18, 2020 at 11:38 AM Jan Kara <jack@suse.cz> wrote:
>
> On Sun 09-08-20 22:02:04, Mauricio Faria de Oliveira wrote:
> > This checks during journal commit, right after calculating the
> > checksum of a buffer head, whether its contents match the 'BUG'
> > string (the cookie string in the test case userspace part.)
> >
> > If so, it sleeps 5 seconds for such contents to change (i.e.,
> > so that the actual checksum changes from what was calculated.)
> >
> > And if it changed, set a flag to panic after committing to disk.
> >
> > Then, on filesystem remount/journal recovery there is an invalid
> > checksum error, and recovery fails:
> >
> >   $ sudo mount -o data=journal,journal_checksum $DEV $MNT
> >   [ 100.832223] EXT4-fs: Warning: mounting with data=journal disables
> >   delayed allocation, dioread_nolock, and O_DIRECT support!
> >   [ 100.837488] JBD2: Invalid checksum recovering data block 8706 in log
> >   [ 100.842010] JBD2: recovery failed
> >   [ 100.843045] EXT4-fs (loop0): error loading journal
> >   mount: /ext4: can't read superblock on /dev/loop0.
>
> Nice to have this for testing but when you'll do some "official"
> submission, just send this patch separately so that it's clear shouldn't be
> included in the kernel...
>

Yup, absolutely. :) I forgot to make its subject line different as in
other test-case parts.

>                                                                 Honza
>
> > ---
> >  fs/jbd2/commit.c | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >
> > diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> > index 6d2da8ad0e6f..51f713089e35 100644
> > --- a/fs/jbd2/commit.c
> > +++ b/fs/jbd2/commit.c
> > @@ -26,6 +26,11 @@
> >  #include <linux/bitops.h>
> >  #include <trace/events/jbd2.h>
> >
> > +#include <linux/printk.h>
> > +#include <linux/delay.h>
> > +
> > +static journal_t *force_panic;
> > +
> >  /*
> >   * IO end handler for temporary buffer_heads handling writes to the journal.
> >   */
> > @@ -331,14 +336,35 @@ static void jbd2_block_tag_csum_set(journal_t *j, journal_block_tag_t *tag,
> >       __u32 csum32;
> >       __be32 seq;
> >
> > +     // For the testcase
> > +     __u32 csum32_later;
> > +     __u8 *bh_data;
> > +
> >       if (!jbd2_journal_has_csum_v2or3(j))
> >               return;
> >
> >       seq = cpu_to_be32(sequence);
> >       addr = kmap_atomic(page);
> >       csum32 = jbd2_chksum(j, j->j_csum_seed, (__u8 *)&seq, sizeof(seq));
> > +     csum32_later = csum32; // Copy csum32 to check again later
> >       csum32 = jbd2_chksum(j, csum32, addr + offset_in_page(bh->b_data),
> >                            bh->b_size);
> > +
> > +     // Check for testcase cookie 'BUG' in the buffer_head data.
> > +     bh_data = addr + offset_in_page(bh->b_data);
> > +     if (bh_data[0] == 'B' &&
> > +         bh_data[1] == 'U' &&
> > +         bh_data[2] == 'G') {
> > +             pr_info("TESTCASE: Cookie found. Waiting 5 seconds for changes.\n");
> > +             msleep(5000);
> > +             pr_info("TESTCASE: Cookie eaten. Resumed.\n");
> > +     }
> > +
> > +     // Check the checksum again for changes/panic after commit.
> > +     csum32_later = jbd2_chksum(j, csum32_later, addr + offset_in_page(bh->b_data), bh->b_size);
> > +     if (csum32 != csum32_later)
> > +             force_panic = j;
> > +
> >       kunmap_atomic(addr);
> >
> >       if (jbd2_has_feature_csum3(j))
> > @@ -885,6 +911,9 @@ void jbd2_journal_commit_transaction(journal_t *journal)
> >               blkdev_issue_flush(journal->j_dev, GFP_NOFS);
> >       }
> >
> > +     if (force_panic == journal)
> > +             panic("TESTCASE: checksum changed; commit record done; panic!\n");
> > +
> >       if (err)
> >               jbd2_journal_abort(journal, err);
> >
> > --
> > 2.17.1
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR



-- 
Mauricio Faria de Oliveira
