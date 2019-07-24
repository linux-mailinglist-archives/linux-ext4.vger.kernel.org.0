Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3B6F727BF
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2019 08:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfGXGEH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 Jul 2019 02:04:07 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38250 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfGXGEH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 Jul 2019 02:04:07 -0400
Received: by mail-ot1-f67.google.com with SMTP id d17so46697768oth.5
        for <linux-ext4@vger.kernel.org>; Tue, 23 Jul 2019 23:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l+dXkgKLy4qKjpARbHdtxqJHfDmq5a8QFJrNMBnvBjQ=;
        b=K6T18jKu8LasjiieiNq0AJUG4nkkY9jDNkwcFa0EQyR4eT3ED/Ggd6IvcOwTeglBv4
         XIMvhr09Ygb9KD+7rjJQL/FODqqkghaZtdf4tVqpTgeKFA5C33oiGhW/Z0ogPA+EO3iw
         ECmAtDz5ncaWkLGuDlODwSjfwbxUVweBUBEz2RWgMUmfNkKNVvsNMklDoUgzuNIC7eIe
         k+E97djmZb4l7wz0/+kiQUvwqCkEQtIIRGPgDxHwePEvBJ8CU4WUTQlKQEBeK7sNKe69
         WKzhdtgRGfC8UO+lZ/55ExNhgzFKlrmhd3TUYT9ZSjgpLupuKeMnXUO4A1sjwa6ZG2s9
         yadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l+dXkgKLy4qKjpARbHdtxqJHfDmq5a8QFJrNMBnvBjQ=;
        b=jfRDpWMuDpkPEUmTg9BRlWS0XguXUK3VJsLTQdgki3WWi6RdnlkZHjzKMOlhagugCG
         3YZa9S0ptgBNOc2R8IFxxWttwgX3mbMBujOPBJeTZ6WsD7che6kg4FJW+gHF/FYPgmNi
         UCxLHP+/iNLVGDLluWtcElgXptN9RnimBjaOU72RRveB7j8D/3FG7751eMPP+ybndwK9
         5DkD4+M0Q58SBzdGEOr5pPFXREikB0jw3FKRpvGO1D9qC3XyavpzU6u3hc/GhvfE3M4T
         MQ/h+PPbn11GKL69jkSI/hlozdZM2jf0sTdEPDDZS9XGgC0gNjQ28OT16I9I73jNuEP7
         wjaQ==
X-Gm-Message-State: APjAAAXce5o9lFCbKqZCaD9J3wYtzArBNPriN5xTXmGWfmjWakAnOAkj
        f288OBwxu23A7yEg9e7tX7IIR4mdEQ95QW8c2/A=
X-Google-Smtp-Source: APXvYqzXO069QZ1vq225i0oHXEZdhlrPTQJrO5P+nKRgdQbuHt0lliY80z1VDfW+N5UltkjIdBKfPVjUUSJqn9zQAgY=
X-Received: by 2002:a9d:6385:: with SMTP id w5mr53682325otk.227.1563948245646;
 Tue, 23 Jul 2019 23:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190722040011.18892-1-harshadshirwadkar@gmail.com>
 <41522E01-D5E5-4DC6-8AD4-09E3FA19F112@dilger.ca> <20190722210235.GE16313@mit.edu>
 <7AD1A611-9BD2-4F32-9568-D0A517047EF0@dilger.ca>
In-Reply-To: <7AD1A611-9BD2-4F32-9568-D0A517047EF0@dilger.ca>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Tue, 23 Jul 2019 23:03:54 -0700
Message-ID: <CAD+ocbwCYZDrj9D=85AVaB_RLYjUFwNs1V02fRn4tHh04_k7_A@mail.gmail.com>
Subject: Re: [PATCH 01/11] ext4: add handling for extended mount options
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Before I respond to your questions, I would like to explain how fast
commits differ from ijournal in a few key aspects (I will make sure to
explain it in detail in patch 00/11 and documentation):

- Instead of storing extent blocks in a fast commit block, we only
store extents that were modified in a particular fast commit
transaction in tag-length-value format.

- Whenever the fast commit information (inode structure + changed
extents in TLV format) exceeds one block, we fall back to full commit.
Thus at this point, the number of blocks we write per fast commit
transaction is either the total number of files changed (if fast
commit was successfully performed) or the number of blocks that would
be written by a full commit transaction.

- To reduce complexity, there is no support for per-core fast commit areas.

Current design of fast commits is such that we try to perform fast
commits whenever possible but either if it's impossible to record file
system changes by fast commits or if we haven't yet added support for
dealing with a particular type of file system change, we fall back to
full commits. Whenever we later add more features to fast commits, we
probably would need more on-disk format changes for the fast commit
blocks and that would mean we burn feature flags. So, my guess is that
we would need to make a few judgement calls on whether we want to
exclude a few fast commit features, keep the patch series simple and
potentially burn feature flags later OR we save feature flags by
implementing those fast commit features.

On Tue, Jul 23, 2019 at 2:59 PM Andreas Dilger <adilger@dilger.ca> wrote:
>
> On Jul 22, 2019, at 3:02 PM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >
> > On Mon, Jul 22, 2019 at 12:15:11PM -0600, Andreas Dilger wrote:
> >> Unless I missed it, this patch series needs a 00/11 email that describes
> >> *what* "fast commit" is, and why we want it.  This should include some
> >> benchmark results, since (I'd assume) that the "fast" part of the feature
> >> name implies a performance improvement?
> >
> > For background, it's a simplified version of the scheme proposed by
> > Park and Shin, in their paper, "iJournaling: Fine-Grained Journaling
> > for Improving the Latency of Fsync System Call"[1]
> >
> > [1] https://www.usenix.org/conference/atc17/technical-sessions/presentation/park
> >
> > I agree we should have a cover letter for this patch series.  Also, we
> > should add documentation to Documentation/filesystems/journaling.rst
> > about this feature; what it does, how it works, its basic on-disk
> > format changes, etc.
>
> Thanks for the link, I hadn't read that paper previously.  From reading the
> paper, it seems there are some things that should be addressed before the
> patch is committed to the tree in order to maintain proper disk format
> compatibility:
> - the ijournal header shows a 256-byte inode.  In Lustre today (and also
>   Samba and other xattr-intensive workloads) 512- or 1024-byte inodes are used
>   in order to store more xattrs within the inode, so the size of the inode
>   data in the ijournal header needs to match the actual inode size of the
>   filesystem and not be a fixed size.  What if the inode size == blocksize?

Okay, I agree. This is one of such questions where we need to decide
whether to exclude this fast commit feature request for now or not. I
think whether or not we actually support 512 or 1024 byte inodes in
this patch series, we definitely shouldn't assume in the fast commit
header that inodes are of a fixed size. I will fix it. Supporting
bigger inodes doesn't sound like it would result in big change in the
patch series. But I would like to know whether you think it's okay to
wait or not.

> - the ijournal header also shows a 4-byte inode number.  It would be prudent
>   to reserve space for 64-bit inode numbers, or at least have some mechanism
>   (flag) to indicate that a 64-bit inode is stored instead of a 32-bit inode.

Noted, will change that.

> - if there are many cores in a system, say 96, how much space will be used
>   from the journal file by the per-core ijournal?
> - what happens if multiple threads are writing to the same file with ijournal
>   and per-core ijournal areas?  Will the same inode information be recorded
>   in multiple ijournal areas?

As mentioned above, at least for now we keep it simple by not having
per-core fast commit areas.

Thanks,
Harshad

>
> Cheers, Andreas
>
>
>
>
>
