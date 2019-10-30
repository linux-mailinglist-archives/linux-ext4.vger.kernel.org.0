Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22B3FE95DE
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Oct 2019 06:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfJ3FNM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Oct 2019 01:13:12 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36905 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfJ3FNM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Oct 2019 01:13:12 -0400
Received: by mail-oi1-f196.google.com with SMTP id y194so921422oie.4
        for <linux-ext4@vger.kernel.org>; Tue, 29 Oct 2019 22:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JB3vUDBDhDVaso771SA9fR4wLZSqaQMyCnURuqv8m5E=;
        b=uK3aDSr6DKxTohPVzMikIVCGtoOSroDkTuDTTUghrdJPlWPcEfJ8mHMy3yGdlBaNTj
         FQf8dV94ECcXpjZVukIi9XGmud1hh24VSLU3ZrOq9siz7F1IAfgS5izncf+bRrO1jXhv
         AXwpNh1irO+jURr273P/7sSsWkP8euq6yP+Kp3l8P4zIVOpwKlmva+w5SJqqnIGdSv9F
         8dJpBUIT1TWuI7+pIWb7c0tSZnrsReB5uQyCPhBCSqnD/ZaQ22kOk535edaAqp5rNaJx
         vUFTWkhkQa+ADaI96P+Yz7D40TgM2Bfj4CUpDA2H/aDeWj/dwSEKMyzTzzlS8XuOjF9A
         bexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JB3vUDBDhDVaso771SA9fR4wLZSqaQMyCnURuqv8m5E=;
        b=hnOJVqEdq4bl4aSyTs43rHnRlZfmqmO5/4N0EsDiRdJR8E+BFFnmah4/Uq5deDGawK
         pReR1hhJjquOPhKgFSrRWL1KWlytrMgSBpoci6JsseNfN2qm6Sczokh2Qi8JBXqNejmK
         l0TDZr0iliJevvaIz6ykQOE7zQeCDjX14B2Re9nLO26eTftBsQ0hXOukJ6j0yhCz2Xk4
         At9jdwtdrVAwjNT+8vIDQ/UfcLq2mtCCHgFUomdMsnS6DY4PgrR0jwL1IKBXu5jMULSW
         CNHRh2O/zpszVi2a/mUFRoyINs5GLQpihpt4pwep8/3TUPxw1IVhRZI/UVVLt8ySQp/t
         brvA==
X-Gm-Message-State: APjAAAUQB2Bkpc5Tajl4C4dEKlAnlQUm0YIpozaaG8OGf3pH2/qP27Zd
        xvHU95RAcaLaL35RPuVq8VVFl/3aq5cBPSF9UGPrcKml
X-Google-Smtp-Source: APXvYqxUhj0Dp/R+WOHgRhdOXMF0TO2VwAMZBbkswAyC7aeMIdWSMbIFkZ5nLTYYSaGnbodunxFf0ndqQ+GYTcmQ0pI=
X-Received: by 2002:a05:6808:317:: with SMTP id i23mr7208000oie.17.1572412390678;
 Tue, 29 Oct 2019 22:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
 <20191001074101.256523-9-harshadshirwadkar@gmail.com> <20191016213655.GH11103@mit.edu>
In-Reply-To: <20191016213655.GH11103@mit.edu>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Tue, 29 Oct 2019 22:12:59 -0700
Message-ID: <CAD+ocbyyGoJM8tvaXKaSJTNzXHUs=YpXGNLuk1ZhPt+PpSk=Zw@mail.gmail.com>
Subject: Re: [PATCH v3 08/13] ext4: fast-commit commit range tracking
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for this, I'll remove these calls and add calls in ext4_map_blocks.

On Wed, Oct 16, 2019 at 2:36 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Tue, Oct 01, 2019 at 12:40:57AM -0700, Harshad Shirwadkar wrote:
> > With this patch, we track logical range of file offsets that need to
> > be committed using fast commit. This allows us to find file extents
> > that need to be committed during the commit time.
>
> We don't actually need to track when data is modified in the page
> cache, which is what this commit is actually doing.  We only need to
> track newly allocated blocks, at granularity of the logical block
> number.
>
> That's because we only need to force out newly allocated blocks to
> make sure we don't reveal stale data when we are in data=ordered mode.
> And it also follows that we don't need to track logical block ranges
> and submit inode data in data=writeback or data=journalled mode.
>
> In the case where the user has actually called fsync() on the the
> inode, we do a data integrity writeback in ext4_sync_file, and that's
> independent on the fast commit code.
>
> But if the file is being modified using buffered writes, or if an
> already allocated block is changed, and the file has *not* been
> changed, we don't need to write out those blocks on a fast commit.
> For example, in the case where we are the fast commit is being
> initiated via ext4_nfs_commit_metadata() -> ext4_write_inode(), we
> only care about submitting data for the newly allocated blocks.  And
> that's what we want to track here.
>
> Hence, all of the callers of ext4_fc_update_commit_range() here are in
> the wrong place.  (Also, they are calling ext4_fc_update_commit_range
> with byte offsets, when the function is expecting logical block
Thanks for pointing that out. My code as of now works with logical
file offsets instead of logical block offsets. So I should have used
file offset type instead of logical block type for arguments of
ext4_fc_update_commit_range. But it makes sense to just use logical
block offsets everywhere. I'll fix this in next version.

> numbers, but that really matter, since the existing call sites need to
> be all removed and replaced with new ones in ext4_map_blocks().
>
>                                      - Ted
