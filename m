Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBF673665
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2019 20:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbfGXSOx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 Jul 2019 14:14:53 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43069 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfGXSOw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 Jul 2019 14:14:52 -0400
Received: by mail-ot1-f65.google.com with SMTP id j11so24574419otp.10
        for <linux-ext4@vger.kernel.org>; Wed, 24 Jul 2019 11:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=40xhNbFwKutlKBWkCxc/ryKzszmoxw17iQwlQzSTy+c=;
        b=Yz2eDPuaFAmG9iytOFS/dAGSkBUZvqDmJTHBwRMLRzkTFyz5ZHnoHt8VNVAQ87/jeN
         eLXZgmKm2+3UcJHVXG65v7qrlkl/Kdq1e6gZQuaHgxAXigEm3NZ1LSgyW+m5PEtcgf5T
         cXDOb7xt1wgfYopL/FGhyyWR1OXZOyBqZC0zHkEKPogqyafhkkEqX5d5VS2EiSxuD3K9
         2Thxvl5voHMxdUP8gAuqOKZ7SXScWf07fpDL4S5TN7KtEVFPF0odNN6QO/4Q6OaIRYdo
         R9fPH2WseBNl1stn+FXrwXt1oqn24B3Ae7oyWNFRZ3+DS+nSY9XuWEZu3gmd4pcATxw6
         Nr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=40xhNbFwKutlKBWkCxc/ryKzszmoxw17iQwlQzSTy+c=;
        b=c5sDRPP+aqQH4Rbh5PgwwE3K9t6NbDEOJ5tbAPy+vdjN6YiLbZ76sedMwhL+Kf/2LY
         /j0RmTJWv1SqYzu401Q0Ai2C+t4Gq2/EX53plDdjpAPeF7NzNdKA4UHZ6kXyqDzExjjX
         H3IGSXZPLbbRr3IN1BeyZ+husibH/3+ldOlFp9q0eCx4NWzKqKNQFUPxWbI+jWpR/HAe
         afzxjz96hDKSjmYzkOXrkNeF+4N0xLHHqphqg2GVUUuouh3rBVOqmYjoFh7e5LBBXG88
         Nvejz3L8mytYUQRq9yDaD0CRV5ymsiEmokS3JDFSJz9zbgtvEND3UJkGes4LWPElkiBr
         LvGQ==
X-Gm-Message-State: APjAAAXMMfg2OrDa214Y4rxO6YXcCkqxmzwERRGcnAzF7ouz3VLftr8/
        S2CfIjDC4eLnRsHsg6I+/3ZNF+Y8dwM+sRl/V1k=
X-Google-Smtp-Source: APXvYqxsKhzRWssoFvXiARgiG1UU6y/W9+x9rzPh9OED0bpS6ucFaBXTtBc04KQNV++NohRzWOugKuNiDIRTCRA6e4Y=
X-Received: by 2002:a9d:7d82:: with SMTP id j2mr51794053otn.171.1563992091287;
 Wed, 24 Jul 2019 11:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190722040011.18892-1-harshadshirwadkar@gmail.com>
 <41522E01-D5E5-4DC6-8AD4-09E3FA19F112@dilger.ca> <20190722210235.GE16313@mit.edu>
 <7AD1A611-9BD2-4F32-9568-D0A517047EF0@dilger.ca> <CAD+ocbwCYZDrj9D=85AVaB_RLYjUFwNs1V02fRn4tHh04_k7_A@mail.gmail.com>
 <20190724061231.GA7074@magnolia> <20190724160749.GF4565@mit.edu> <20190724165637.GB7074@magnolia>
In-Reply-To: <20190724165637.GB7074@magnolia>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Wed, 24 Jul 2019 11:14:39 -0700
Message-ID: <CAD+ocbyeT7kmwfC-ixwdAr-ErRF3WQA6+BDSMTmUSL7QQSEugg@mail.gmail.com>
Subject: Re: [PATCH 01/11] ext4: add handling for extended mount options
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 24, 2019 at 9:56 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Wed, Jul 24, 2019 at 12:07:49PM -0400, Theodore Y. Ts'o wrote:
> > On Tue, Jul 23, 2019 at 11:12:31PM -0700, Darrick J. Wong wrote:
> > > On Tue, Jul 23, 2019 at 11:03:54PM -0700, harshad shirwadkar wrote:
> > > > Before I respond to your questions, I would like to explain how fast
> > > > commits differ from ijournal in a few key aspects (I will make sure to
> > > > explain it in detail in patch 00/11 and documentation):
> > >
> > > Please do; I hadn't realized there were also journal ondisk format
> > > changes, and these must be recorded in the ext4 disk format
> > > documentation.
> >
> > Actually, the changes are almost entirely in the on-disk journal
> > layer.
>
> I know.
>
> Hmm, just as a reminder -- the ext4 disk format documentation
> includes the jbd2 disk format documentation.
>
> > The addition of the feature flag is really a UI issue, and
> > worth some discussion.
> >
> > One of the goals was to make it easy to allow kernels which didn't
> > understand fast commit to be able to mount a file system which had
> > been cleanly unmounted --- but of course, if the file system needs
> > recovery, and fast commits are in the journal, we can't allow a fast
> > commit oblivious kernel (or e2fsck) from trying to replay the journal.
>
> BTW, are there patches to fix e2fsck to replay the factcommit journal?
>
> > One way to do this would be with a mount option, but that's a bit ugly
> > --- and a mount option in /etc/fstab will cause a failure if a kernel
> > which doesn't understand that mount option is booted.
> >
> > So the basic idea is to have a compat feature which means, "please use
> > fast commits if present", and then when the file system is mounted on
> > a fast-commit capable kernel, the incompat feature meaning "we're
> > using the fast commit feature".  (This is same design pattern used
> > with the HAS_JOURNAL compat feature and the NEEDS_RECOVERY incompat
> > feature.)
> >
> > The next question is whether to use the compat and incompat feature
> > flags in the jbd2 superblock, or ext4-specific compat flags.  For the
> > incompat flag, there's no reason not to use the journal incompat flag.
> > But for the compat flag, we have better infrastructure for setting and
> > clearing ext4-level compat feature flags.  Aside from that, though,
> > there's no reason why we couldn't use the s_feature_compat field in
> > the journal superblock --- in which case, *all* of the on-diks format
> > changes would purely be on the jbd2 side of the ledger.
>
> Probably better to use the journal compat flag so that the other jbd2
> users can take advantage of it ... on the other hand, the only other
> user (AFAIK) is ocfs2 and HAH.
>
> > > Every feature flag you add doubles the size of the testing matrix.
> > > If I were you I'd only want to test the (fastcommit) and (!fastcommit)
> > > scenarios.
> >
> > Sure, absolutely.  On the other hand, as the saying goes, "there comes
> > a time in any project where it's time to shoot the engineers and put
> > the d*mned thing into production".  One of the reasons why we're super
> > interested in this feature is to claw back the performance hit of
> > fde872682e17 ("ext4: force inode writes when nfsd calls
> > commit_metadata").  I fully expect that this feature is going to make
> > big difference to a number of customer workloads, so there is some
> > urgency to getting this feature into production.
> >
> > On the flip side, if we leave some performance wins on the table, it's
> > absolutely true that it makes it harder to add those optimizations
> > later, and it increases the testing load, not to mention the forwards
> > and backwards compatibility issues.  It's an engineering trade-off.
>
> <nod> I just remember hearing you complain about the size of the ext4
> testing matrix in the past and figured you would't go for adding
> fastcommit in small pieces each with new feature bits.
>
> (I guess you could have a fastcommit_version field that increments every
> time you add a new fastcommit journal item to constrain the combinatoric
> explosion...)
I agree, I was going to suggest the same. We would probably need to
add this field in all individual fast commit blocks, since we don't
have a fast commit superblock equivalent .. and changing jbd2
superblock is probably too much to ask for I guess.
>
> --D
>
> >
> >                                            - Ted
