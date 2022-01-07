Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138C4486F51
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Jan 2022 02:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344076AbiAGBAB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Jan 2022 20:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236544AbiAGA77 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Jan 2022 19:59:59 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD10C061245;
        Thu,  6 Jan 2022 16:59:59 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z9so15937398edm.10;
        Thu, 06 Jan 2022 16:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=193b4YHjs1buOAzSFIPKTBZORcA2cD4by1MwizuSpRM=;
        b=kdBniaYQywtcRRDuNzzDVpl7lTixQ9Y1NbYlEmhfMQ2i4+aRsC1vE7CJKKX9g584zh
         ZeL+Lo6hCKp4kL+AABTpvw0/wgU0PdG/e1Yn9XcaewePQVwXm7858s6paiywqz5HBVtb
         sfcklQ3rSwXeeCWlt6xlXPXkacmQPqNzWiR27wkjPzqpiVyZNLtqUhbBRI5PMO/v863B
         fu0pc2kBoDy23xSQQZ4de7w/peDUxNPBdLtM1ciYJ98fA3UzdSMsTrmeSejriUCh/epT
         etPk4bp0MDizzZS98nVcRM9YoMztLIPOWXrRgahqL9m5pAIpqKZzMpntFvnlrOb+ElbB
         mL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=193b4YHjs1buOAzSFIPKTBZORcA2cD4by1MwizuSpRM=;
        b=wHav4z5xYXcmbYkU6uN+PE4crKiZG7dZ9mFwzA2xkFCk/BdQBNCk8/Vni4ZGaW/5Yi
         vB0eA05qBjg3v9R6vsoCYmKSMeprTLxGPfv6OrRl4TC9njIr7M0V/XLPgVEEhbELQrhX
         EqGTd7Q7P3cZPHW4NXnYbMvJ3WdikeUQIThU0iSma0DXNZyAmojeyVeBalCsW47wFiIk
         mX3jszRChEn95g05oNQEoUXbnhM6juN4G0zHPPSJlcmYEOjOrYjaFwawy2c0kWWHx7JK
         L6xtFGrT9igGalhtj3f8MFdFFdO/foGZat4n7uTp5lQ5WoQnQn0Wv53Zghuvj742mdWf
         1LdQ==
X-Gm-Message-State: AOAM53373zDa1LzOm+nEBWNXGD53Y0gK6Hl/7WlUUzbv168N5H5wHQqm
        ecZtPG0OwlhlIxFFN5nZKsnM5cOylu3on/BIWODmmFcafvw=
X-Google-Smtp-Source: ABdhPJxJBcDiJq48nZOyiyf4PNZ9r4ZiJ6Rd1Q02GkfapSXgfzOPLAW687ZRqwj1yOM2vNvSGQt923kieCZkk7Xqono=
X-Received: by 2002:a17:906:4793:: with SMTP id cw19mr51347677ejc.15.1641517197290;
 Thu, 06 Jan 2022 16:59:57 -0800 (PST)
MIME-Version: 1.0
References: <20211230062905.586150-1-luo.penghao@zte.com.cn>
 <YdZzt0LF/ajTGNXo@mit.edu> <20220106105843.comh4jk3krxppgbp@work>
In-Reply-To: <20220106105843.comh4jk3krxppgbp@work>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Thu, 6 Jan 2022 16:59:46 -0800
Message-ID: <CAD+ocbyF=9pskuSRono-hAg2mEzEmCOD30oFGYW8piQ=BjwhYw@mail.gmail.com>
Subject: Re: [PATCH linux] ext4: Delete useless ret assignment
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, cgel.zte@gmail.com,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-kernel@vger.kernel.org, luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

First of all thanks for catching this. Yeah, I think the right thing
to do here is to return the return value up to the caller. Also, I
agree with Lukas, we should only set fc_modified_inodes_size if the
allocation succeeds. Luo, would you be okay updating the patch to
include these changes?

Thanks,
Harshad

On Thu, Jan 6, 2022 at 2:58 AM Lukas Czerner <lczerner@redhat.com> wrote:
>
> On Wed, Jan 05, 2022 at 11:44:39PM -0500, Theodore Ts'o wrote:
> > On Thu, Dec 30, 2021 at 06:29:05AM +0000, cgel.zte@gmail.com wrote:
> > > From: luo penghao <luo.penghao@zte.com.cn>
> > >
> > > The assignments in these two places will be overwritten by new
> > > assignments later, so they should be deleted.
> > >
> > > The clang_analyzer complains as follows:
> > >
> > > fs/ext4/fast_commit.c
> > >
> > > Value stored to 'ret' is never read
> >
> > I suspect the right answer here is that we *should* be checking the
> > return value, and reflecting the error up to caller, if appropriate.
> >
> > Harshad, what do you think?
>
> Indeed we absolutely *must* be checking the return value and bail out
> otherwise we risk overwriting kernel memory among other possible
> problems.
>
> See ext4_fc_record_modified_inode() where we increment
> fc_modified_inodes_size before the actual reallocation which in case of
> allocation failure will leave us with elevated fc_modified_inodes_size
> and the next call to ext4_fc_record_modified_inode() can modify
> fc_modified_inodes[] out of bounds.
>
> In addition to checking the return value we should probably also move
> incrementing the fc_modified_inodes_size until after the successful
> reallocation in order to avoid such pitfalls.
>
> Thanks!
> -Lukas
>
> >
> >                                       - Ted
> >
> > >
> > > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > > Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
> > > ---
> > >  fs/ext4/fast_commit.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> > > index 8ea5a81..8d5d044 100644
> > > --- a/fs/ext4/fast_commit.c
> > > +++ b/fs/ext4/fast_commit.c
> > > @@ -1660,7 +1660,7 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
> > >             return 0;
> > >     }
> > >
> > > -   ret = ext4_fc_record_modified_inode(sb, inode->i_ino);
> > > +   ext4_fc_record_modified_inode(sb, inode->i_ino);
> > >
> > >     start = le32_to_cpu(ex->ee_block);
> > >     start_pblk = ext4_ext_pblock(ex);
> > > @@ -1785,7 +1785,7 @@ ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl,
> > >             return 0;
> > >     }
> > >
> > > -   ret = ext4_fc_record_modified_inode(sb, inode->i_ino);
> > > +   ext4_fc_record_modified_inode(sb, inode->i_ino);
> > >
> > >     jbd_debug(1, "DEL_RANGE, inode %ld, lblk %d, len %d\n",
> > >                     inode->i_ino, le32_to_cpu(lrange.fc_lblk),
> > > --
> > > 2.15.2
> > >
> > >
> >
>
