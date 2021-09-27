Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3566C419269
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Sep 2021 12:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbhI0Kpf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Sep 2021 06:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbhI0Kpe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Sep 2021 06:45:34 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF97C061575
        for <linux-ext4@vger.kernel.org>; Mon, 27 Sep 2021 03:43:56 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id 188so16605302vsv.0
        for <linux-ext4@vger.kernel.org>; Mon, 27 Sep 2021 03:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4OsGFx+1v6jpu5tec2wBnq7BQA6VZCKLvJXXai5+R+I=;
        b=TJ9svM3JjekZrxvUEZaux508UguDS+CMMIpXILjt3w4wM2VRKM/rhgditGpgiZoGEg
         JkVP6I29Kri/svA/r8vNqFQXpRJBvT/AUDXbSBYlTSER2e1O5OK3YaKUb9Quh2ia543j
         oohPfc7m6Y1S3k6AkGa3fGD5vbsshOEX9Zsjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4OsGFx+1v6jpu5tec2wBnq7BQA6VZCKLvJXXai5+R+I=;
        b=2gc1nZaH/smoZXDrJrKn7oh5MDnrMh6dd4zmBlqgCIAd6xNY6yZxrwf7GL+0cXps1G
         IakWtrzkpDk7CBdIF4+Y++F1pQhcUMXtG+9TM90UFIWjmXaYaRjPh5oZn5Wh3Zq9GrW6
         n5JwMw8woORaIHR/4B2HWfehBU2+oCNc5npVpc8UbSBhJtLB3E5DLQWoLNetSbl16DBr
         XXreYGWd23aBI2nIwI8pumdjv1uNNz/JL8hBtv2Jbx8NYSY+qFHSMthJPv2q4p2GpVm7
         SXoGr9QIHFT2is+5mS+k7qJaicM55mkomhfKf5tknF5nINzY70RaTKpSne398JeahyuY
         06zQ==
X-Gm-Message-State: AOAM532ToakXywxx1cNRylKF1qBRAKYf2RyH//Sl+x8J8ZxCnuXDzKS6
        5Cj+JYfQb5RHE1TmJrZueY0JshnxV/6pCDbZeuxvBg==
X-Google-Smtp-Source: ABdhPJywnCCcM52XrIrrxzlD8vgXLbYryLp1y+AvtBmqFcqfIsuXd8G1ADS/IZbVuCp50EifZQ0w8RvODhEL3/Fccj0=
X-Received: by 2002:a05:6102:34d5:: with SMTP id a21mr1057431vst.53.1632739435987;
 Mon, 27 Sep 2021 03:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210921034203.323950-1-sarthakkukreti@google.com> <C5A2A75B-F767-40AC-B500-C99D484E9E30@dilger.ca>
In-Reply-To: <C5A2A75B-F767-40AC-B500-C99D484E9E30@dilger.ca>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Mon, 27 Sep 2021 03:43:45 -0700
Message-ID: <CAG9=OMNMbF_cMr3QXFDwr6yeeCHFv++YEA=0ZAJ_7VXxE8Zrsg@mail.gmail.com>
Subject: Re: [PATCH] mke2fs: Add extended option for prezeroed storage devices
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for reviewing the patch, Andreas!

On Tue, Sep 21, 2021 at 2:39 PM Andreas Dilger <adilger@dilger.ca> wrote:
>
> On Sep 20, 2021, at 9:42 PM, Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:
> > is
> > From: Sarthak Kukreti <sarthakkukreti@chromium.org>
> >
...
> > Additionally, on thinly provisioned storage devices (like Ceph,
> > dm-thin),
>
> ... and newly-created sparse loopback files
>
Thanks for pointing that out, added to the commit message in v2.
...
> > Testing on ChromeOS (running linux kernel 4.19) with dm-thin
> > and 200GB thin logical volumes using 'mke2fs -t ext4 <dev>':
> >
> > - Time taken by mke2fs drops from 1.07s to 0.08s.
> > - Avoiding zeroing out the inode table and journal reduces the
> >  initial metadata space allocation from 0.48% to 0.01%.
> > - Lazy inode table zeroing results in a further 1.45% of logical
> >  volume space getting allocated for inode tables, even if not file
> >  data is added to the filesystem. With assume_storage_prezeroed,
> >  the metadata allocation remains at 0.01%.
>
> This seems beneficial, but I'm wondering if this could also be
> done automatically when TRIM/DISCARD is used by mke2fs to erase
> a device?
>
> One safe option to do this automatically would be to start by
> *reading* the disk blocks and check if they are all zero, and only
> switch to zero-block writes if any block is found with non-zero
> data.  That would avoid the extra space usage from zero-block
> writes in the above cases, and also work for the huge majority of
> users that won't know the "assume_storage_prezeroed" option even
> exits, though it won't necessarily reduce the runtime.
>
I agree with Ted (quoting a reply on a forked thread below) that
reading all inode table blocks on the device will slow down mke2fs a
lot depending on the storage medium and size. Maybe it can be done
instead at first mount in conjunction with lazy_itable_init ie. ext4
reads the block and only issues a zero-out if the block is not already
zero? Even so, an explicit hint would be compatible with this
approach: it avoids (unnecessarily) reading through all the inode
table blocks as long as the hint was passed at creation time.

On Wed, Sep 22, 2021 at 8:57 PM Theodore Ts'o <tytso@mit.edu> wrote:
> The problem is mke2fs really does need to care about the performance
> of discard or write same.  Users want mke2fs to be fast, especially
> during the distro installation process.  That's why we implemented the
> lazy inode table initialization feature in the first place.  So
> reading all each block from the inode table to see if it's zero might
> be slow, and so we might be better off just doing the lazy itable init
> instead.
...
> > +     if (assume_storage_prezeroed) {
> > +       if (verbose)
> > +                     printf("%s",
> > +                                    _("Assuming the storage device is prezeroed "
> > +                         "- skipping inode table and journal wipe\n"));
> > +
> > +       lazy_itable_init = 1;
> > +       itable_zeroed = 1;
> > +       zero_hugefile = 0;
> > +       journal_flags |= EXT2_MKJOURNAL_LAZYINIT;
> > +     }
>
> Indentation appears to be broken here - only 2 spaces instead of a tab.
>
> This is also missing any kind of test case.  Since a large number of
> the e2fsck test cases are using loopback filesystems created on a sparse
> file, this would both be good test cases, as well as reducing time/space
> used during testing.
>
Oops, thanks for catching that! Fixed in v2 and I added a test case
for this option. I was playing around with adding the option as a
default to tests/mke2fs.conf.in; that didn't affect the overall test
run time much (a lot of the tests seem to be dd'ing entire files and
not using sparse files).

Best
Sarthak
