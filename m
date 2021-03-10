Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593D33344DD
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Mar 2021 18:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbhCJRL6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 10 Mar 2021 12:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhCJRLo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 10 Mar 2021 12:11:44 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F08FC061760
        for <linux-ext4@vger.kernel.org>; Wed, 10 Mar 2021 09:11:44 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id e6so11813478pgk.5
        for <linux-ext4@vger.kernel.org>; Wed, 10 Mar 2021 09:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DGCRRcoBl1JSCG2pHaWjxo+ndY15Ok8UAeqwV/B8DMk=;
        b=msH3WGX5AkSPibn+nZ/j1FEqp/QPYjCIKRQU/D1UN8nMRxdr0qBnUvqOlQ5bovZXKN
         mqM3B4rN+NHDVFaBJgoROREe7Fz8o05Uu4j91Tno6487e7TaesGGLRDtD5YX01K9MjbV
         p4ySyGz8Y5SXI2c8wu/LwQAKFTavby+VoV6tT6GvvS8HS81RPsJJLaU63ejrF+GyuwPq
         LWTthrs05ZYBqcc2Wco9NGikH/I9MoMIuwyb4oWSDk+mUofn014iLeqmvAFAvne7/CbI
         r49e+0fuCMNBPNsa+VfGwwXoI8Oka38dKew92A9u6COBmrnJyuB+WtJ5UOaJ16eIWew2
         ep6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DGCRRcoBl1JSCG2pHaWjxo+ndY15Ok8UAeqwV/B8DMk=;
        b=jAqiKGgrCpEzN4MfUzwASLkKq2hYgIsULGx7oiW2D0HCqioAilkK9/xcLM16JfNAfi
         yf4Gu0il09ki8lQZ0jqEADvS4x1r+AFGC5C/q7NcfX/L1hea1IJy0IFEdKVXcSmIyJW8
         C9SG6d+8YNE0HV8nRq1+ob547+sDsMYKAxCxXbAc1k1rcmAaU1Zk6j0RlWdF5+xZV5qW
         CXnaYrLgaloV9iX68okRNlSt68ohrVAvTPBp4mP+bvJFNvhvSBQuUkh4nOVatNHCM8SG
         QzGdh+RaoD/Ri5rGL0nWWbA4l1D7StaUmn+aJSOaGo1/v9POKYx9VHWDuOc8xg6VW3ek
         GZig==
X-Gm-Message-State: AOAM530L+cLQIvIICd+JKjiqzgLZ5g7KQGc02OzKPQ8FMZDaW5IRsW6C
        cRcutlBZtFtymfNolnJpNQfyTre0YSmZHFFS+bI=
X-Google-Smtp-Source: ABdhPJzHv2TM28dXR5tAVLRDC2FgaXK6+tRkj45K/JZkU0pKbGnDPzM24s0UO/OCziDHqLq6gRtu2J2KiPgaAthL//s=
X-Received: by 2002:a65:4785:: with SMTP id e5mr3737813pgs.0.1615396304149;
 Wed, 10 Mar 2021 09:11:44 -0800 (PST)
MIME-Version: 1.0
References: <CALCFxS7EwQbF47GNgaiuOVrw0n=OQBzHTH6JpoeiZ=tb1CYB1g@mail.gmail.com>
 <YEaZ4RL3ZfXB8jdw@mit.edu> <54EF20C1-1BBF-4BC4-95CA-5FEEFEDE7F2F@dilger.ca>
In-Reply-To: <54EF20C1-1BBF-4BC4-95CA-5FEEFEDE7F2F@dilger.ca>
From:   George Goffe <grgoffe@gmail.com>
Date:   Wed, 10 Mar 2021 09:11:06 -0800
Message-ID: <CALCFxS4inTPkUt5OJhxEt+h2shobMOFnJ65OkfB-ouwW2rcNmQ@mail.gmail.com>
Subject: Re: Scrubbing filenames from meta-data dump of ext4 filesystems
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Andreas,

Thank you for all your help!

Best regards,

George...

On Tue, Mar 9, 2021 at 12:37 AM Andreas Dilger <adilger@dilger.ca> wrote:
>
> On Mar 8, 2021, at 2:40 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> >
> > On Mon, Mar 08, 2021 at 12:01:46PM -0800, George Goffe wrote:
> >> Howdy,
> >>
> >> I'm helping to shoot a bug on a Fedora Core 35 system and have been
> >> requested to provide a meta-data dump of the problem filesystem. The
> >> filenames are restricted so I need to scrub this file  before sending
> >> it.
> >>
> >> Does ext4 have a facility whereby I can scrub the filenames from the dump?
> >
> > Yes, please see the following excerpt from the e2image man page:
> >
> >    This will only send the metadata information, without any data
> >    blocks.  However, the filenames in the directory blocks can still
> >    reveal information about the contents of the filesystem that the
> >    bug reporter may wish to keep confidential.  To address this
> >    concern, the -s option can be specified.  This will cause e2image
> >    to scramble directory entries and zero out any unused portions of
> >    the directory blocks before writing the image file.  However, the
> >    -s option will prevent analysis of problems related to hash-tree
> >    indexed directories.
>
> I had actually looked for this option in the e2image man page in order
> to reply to this email, but I couldn't find it and wondered if I had
> mis-remembered the existence of this functionality.
>
> I've pushed a patch that reorganizes the e2image man page to list all
> of the options explicitly in a separate OPTIONS section, rather than
> putting them inline in the text, which makes it hard to find them.
>
> Cheers, Andreas
>
> > The -s option can be used with the -r and -Q options to e2image, for
> > creating raw and qcow2 image dumps, respectively.  Because the
> > filenames have been scrambled, this will invalidate the hash-tree
> > indexes for the directory, so e2fsck will complain about this.  But
> > for some kinds of corruption, the -s option can provide data when the
> > customer would otherwise not be willing to provide a metadata-only
> > dump of the file system.
> >
> > Hope this helps,
> >
> >                               - Ted
>
>
> Cheers, Andreas
>
>
>
>
>


-- 
It's not what you know that hurts you, it's what you KNOW that AINT
so. WIll Rodgers
