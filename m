Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3972A8D57
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Nov 2020 04:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgKFDH4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Nov 2020 22:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKFDH4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Nov 2020 22:07:56 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F90EC0613CF
        for <linux-ext4@vger.kernel.org>; Thu,  5 Nov 2020 19:07:56 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id o9so5684016ejg.1
        for <linux-ext4@vger.kernel.org>; Thu, 05 Nov 2020 19:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9W5klpHXHcAK/AT1hlRkBKXzNplK9Fw9BPZJUxcLeFo=;
        b=j+HfnzIgXufZQZzWkFAqPTGbOR1G3Gxkj/nbHbqur3osod+2e2aYdOds9hDcOoKkz3
         Xbit7Y0valTNV5AgFUldh2tVc8YYO588YQAwu887eZgNW+qL4J+Yh5KaNOHxKDShGW02
         4clJsYhFHI8DEm9+jQv6yW31V/HpHlrm929X0GQ49dTHICmTi1UDmcxsnc5jMh4FB3UE
         MsdgBspnWnMNPfpNCohP4zWL8ow03ZOnW+/xXlA23qz9dRMsGXoQ8hYBXulqt2eTB3Tv
         MenDVmPYAuXHkoBpjqGY0Q4cSIUelhFKz4HWb3ow71/cczdJPBl1DJQbaparLGOODVmc
         5Dtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9W5klpHXHcAK/AT1hlRkBKXzNplK9Fw9BPZJUxcLeFo=;
        b=XlZT8jGIf7D+UplLVDG8QyDfgvJhbX+vw9QAcDE29lygQQ41uYOWswtZm81DvKv81W
         f32dyA5poK8FoPCWJGLJtvRf7MMQaoT3D7NgcKgzd9ls/SRZyKxFcfITEeHmfNF/gwZ5
         skEvVtwpfE01zBIKZGXLRNXTig8ztFG+GVVXpcbUjvfBRJFwOTpQHesxjSJ6NpPiMf98
         ArTI8yLeDt7FFLqXcR1f1lZGDLcrOLlGbMSwyLf1GpYq7isxwKvbsC3DPPxtC6HiooLW
         qf16VDj9O2cWxR/h4GqeWGBw+cLjfhoRoVAQFeAxoTZaoT7j7VbOX1RzPzR0HJSx9LnN
         +CXA==
X-Gm-Message-State: AOAM533QK0AS4vbh3rFLA7v5nlBEGJWKs4immWRQXlTygCAWfxSTA4Nd
        fGbaVBnKDUYSCaKr/tFO2G53/Wv6sPRa5xSESWk94+HMzsg=
X-Google-Smtp-Source: ABdhPJwa6cT/lYODCOlcrPB4n07zWOzXEU7cUWVx6LdS5JhxaQTO0SuDgVmAVq7FzuKORf9VViqwU3ZNLem5y/9bKTo=
X-Received: by 2002:a17:906:1317:: with SMTP id w23mr5343569ejb.120.1604632074868;
 Thu, 05 Nov 2020 19:07:54 -0800 (PST)
MIME-Version: 1.0
References: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
 <20201031200518.4178786-8-harshadshirwadkar@gmail.com> <20201103165237.GK3440@quack2.suse.cz>
In-Reply-To: <20201103165237.GK3440@quack2.suse.cz>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Thu, 5 Nov 2020 19:07:43 -0800
Message-ID: <CAD+ocbz3y0L0N=hfFoJhub1bL=GvYU7d2rtyeVaPMYChC3nbPA@mail.gmail.com>
Subject: Re: [PATCH 07/10] ext4: misc fast commit fixes
To:     Jan Kara <jack@suse.cz>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 3, 2020 at 8:52 AM Jan Kara <jack@suse.cz> wrote:
>
> On Sat 31-10-20 13:05:15, Harshad Shirwadkar wrote:
> > This patch adds a small number of misc fast commit fixes. Along with
> > functional fixes such as setting the right buffer flags, there also
> > typo fixes and comment additions.
> >
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>
> Again, please don't merge logically separate fixes into one commit.
Sure, I'll break this up.
>
> > diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
> > index 00dc668e052b..10855cd230c7 100644
> > --- a/fs/ext4/ext4_jbd2.h
> > +++ b/fs/ext4/ext4_jbd2.h
> > @@ -422,9 +422,13 @@ static inline int ext4_journal_force_commit(journal_t *journal)
> >  static inline int ext4_jbd2_inode_add_write(handle_t *handle,
> >               struct inode *inode, loff_t start_byte, loff_t length)
> >  {
> > -     if (ext4_handle_valid(handle))
> > +     if (ext4_handle_valid(handle)) {
> > +             ext4_fc_track_range(handle, inode,
> > +                     start_byte >> inode->i_sb->s_blocksize_bits,
> > +                     (start_byte + length) >> inode->i_sb->s_blocksize_bits);
> >               return jbd2_journal_inode_ranged_write(handle,
> >                               EXT4_I(inode)->jinode, start_byte, length);
> > +     }
>
> Why this change? A good changelog would tell me... I'm suspicious here
> because ext4_jbd2_inode_add_write() gets called only in data=ordered mode
> but fastcommit can run also in data=writeback mode...
>
> I suppose this is for the mmap coverage we were speaking about. Now that
> I'm speaking about it again maybe the ext4_fc_track_range() call in
> ext4_map_blocks() is actually enough? I mean once we allocate blocks for a
> range (either from page fault, write, or writeback of delalloc), they will
> become properly tracked in ext4_map_blocks() and that's all we need? But
> then I'm missing why we have so many ext4_fc_track_range() calls around the
> code... Can you please explain?
You are right. I was trying to handle the mmap case as we discussed on
the previous patch set. But as I mentioned in one of the other patches
in this series, I scanned all the callers of ext4_fc_track_range() and
realized that there were a few redundant callers of this function.
Ultimately, this function needs to get called only when blocks are
added or removed from an inode. So the places where this call remains
are - fallocate ops, ext4_map_blocks, truncate.

Thanks,
Harshad
>
>                                                                 Honza
>
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
