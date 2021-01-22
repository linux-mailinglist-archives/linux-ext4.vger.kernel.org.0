Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36FBB30101A
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jan 2021 23:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbhAVTsE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jan 2021 14:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729751AbhAVTVo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jan 2021 14:21:44 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C175FC06174A;
        Fri, 22 Jan 2021 11:21:03 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id s11so7835373edd.5;
        Fri, 22 Jan 2021 11:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jPGDLWhtw1WqN3jTG3M8qUep0kdSjYnn3VbsFPVjaH8=;
        b=TBPIKXfiMvcPysXekQiPUond5fjkCL4F/n12iTBqOp3WlvKlwMMr6yXX1UZKqK/eNi
         0m2zCYixD4UGgNJB4AHUkEsHDluxNdAToYd3LhtJ6Qv/r1rItDqsdkaxbGEzWb1VPHII
         lcDm2jIXtTltoEzzurmAcXB7Pa132j6fmaCmv/zgoWVLPkeqlOIwpYoi4Z6HBaqN5qD6
         SiN8Eh4ZiJis5h8DhWK8qL0inVzHFyfCRNaJS+onXMKSfVekfaH3L+9YWQoX0QSe+FiH
         zZ16mSPzObgkcym7E1FnW2ZqMl/k2V5UNr4+E9TSEzCNVPETpvEQHG9t8iV8SqfRxteU
         Lorg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jPGDLWhtw1WqN3jTG3M8qUep0kdSjYnn3VbsFPVjaH8=;
        b=TqGOOPEmcX+/PKtMf8MfEcgVZhx7IVXl/zISYNaYI9Ue5PfDocqDtc+TJwz+NveBT0
         +uaHqLqxAwPIRRqOsRDyTH8h0aMgrBWjV49T0+rz3XsEYNGeawvT1ScuSFtHIUDK+VWF
         /iXT+3j8bCW+yOCtzEI22cTSzPzybBoSnUhf0z59mZ51YbijBL/lHOBjiUWK0ITjLWwT
         9wrOXe0zexwDArJEH/0Dnfy2MJOwTSrfs51fzTCLcusS26teP1tgjDSpcqFiyuvXqfp+
         5Z1GFjS3NoWAydtK73+/QgZejTZB01qIRlAB2MP/Hqu2bEH1Uh8Lebckt689riN+iF+e
         b6jA==
X-Gm-Message-State: AOAM530VcSJM0gzUdziWRwgYy4D4m4oqvjOnYZHCNZR8Sef4HB3HkpCY
        43w3A+fXndJS0Bj/hqCh63hs+kFWAXDmW+GB1AM=
X-Google-Smtp-Source: ABdhPJxkkOVDxbuERF9i4jR5TCXtqrxZ5rwCWEll6LdTdMkoEfROubLpTPP3N7aQfx8GWajudaBidvUufMKqbrPajNs=
X-Received: by 2002:a50:eacd:: with SMTP id u13mr4303251edp.382.1611343262454;
 Fri, 22 Jan 2021 11:21:02 -0800 (PST)
MIME-Version: 1.0
References: <20210105062857.3566-1-yangerkun@huawei.com> <X/+/3ui/TQ9LjtNZ@mit.edu>
 <CAOQ4uxh2V6LF_t8ZaAOr=CbDrY3A5d0qSR7XWVX8dStR9mME5w@mail.gmail.com> <CAJfpegsVYF2wCiMKfRUzS_MpH9UKPh8g7ucG6w9uOcQodAzRAQ@mail.gmail.com>
In-Reply-To: <CAJfpegsVYF2wCiMKfRUzS_MpH9UKPh8g7ucG6w9uOcQodAzRAQ@mail.gmail.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Fri, 22 Jan 2021 11:20:51 -0800
Message-ID: <CAD+ocbyEyeAbH1vqKieK9ENmM5k3K-WF1jMuqAzRwPfPC2Np8A@mail.gmail.com>
Subject: Re: [PATCH v3] ext4: fix bug for rename with RENAME_WHITEOUT
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, yangerkun <yangerkun@huawei.com>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, "zhangyi (F)" <yi.zhang@huawei.com>,
        lihaotian <lihaotian9@huawei.com>, lutianxiong@huawei.com,
        linfeilong <linfeilong@huawei.com>,
        fstests <fstests@vger.kernel.org>,
        Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks Amir for pointing that out. Yes we are missing fast commit
tracking in whiteout. I'll send out a fix for that.

> But I must say it would have been very hard to catch missing ext4_fc_track_*
> without specialized fs fuzzer such as the CrashMonkey generated tests.

I agree, it's been on my to-do list to run CrashMonkey tests with fast
commits. I'm curious what kind of CrashMonkey tests you ran that
helped you catch this? Were you running Overlayfs on top of Ext4 with
fast commits?

Thanks,
Harshad

On Wed, Jan 20, 2021 at 12:42 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Wed, Jan 20, 2021 at 7:57 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> > And as long as I am ranting, I'd like to point out that it is a shame
> > that whiteout
> > was not implemented as a special (constant) inode whose nlink is irrelevant
> > (or a special dirent with d_ino 0 and d_type DT_WHT for that matter).
> > It would have been a rather small RO_COMPAT on-disk change for ext4.
> > It could also be implemented in slightly more backward compat manner by
> > maintaining a valid nlink and postpone setting the RO_COMPAT flag until
> > EXT4_LINK_MAX is reached.
> >
> > As things stand now, overlayfs makes an effort to maintain a singleton
> > hardlinked whiteout inode, without being able to use it with RENAME_WHITEOUT
> > and filesystems have to take special care to journal the metadata of all
> > individual whiteout inodes, without any added value to the only user
> > (overlayfs).
> >
> > But I guess that train has left the station long ago...
>
> Not so, I believe.  Kernel internal interfaces are easy to change, and
> adding support for DT_WHT to overlayfs would mostly be a trivial
> undertaking.
>
> The big issue (as always) is userspace API's and not introducing
> DT_WHT there was a very deliberate choice.  Adding a translation layer
> from an internal whiteout representation to the userspace API also
> does not seem to be a very complex problem, but I haven't looked into
> that deeply.
>
> So AFAICS there's really nothing preventing the addition of whiteout
> objects to filesystems, other than developer dedication.
>
> Thanks,
> Miklos
