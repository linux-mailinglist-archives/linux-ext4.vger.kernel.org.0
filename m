Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91ADE28C5A4
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Oct 2020 02:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgJMA1Y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Oct 2020 20:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgJMA1Y (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Oct 2020 20:27:24 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA8BC0613D0
        for <linux-ext4@vger.kernel.org>; Mon, 12 Oct 2020 17:27:24 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id e22so25827456ejr.4
        for <linux-ext4@vger.kernel.org>; Mon, 12 Oct 2020 17:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FT9vhFtD0b32PwedQ+Aeqzp1ZFHCGQ6JyNtASOi3t8U=;
        b=owG35M54HrCL3mKE9Pm9KuKY9CbOSiTgDb8eBc0jVAkLzXJUxTs20Jff/zuiVsadvK
         GYUcku8I5QrkH0GDv7GalgnOMbpkxPE+2r5aJRyCDrlhoB42z0YILKsckqlodXYzyQ33
         tdBL6lTgBMMtbvUmsudMSnrJ0O6zoJQ48gchpibuW54r2u8PxBxW/bVmb1GL7z+TAV05
         65xwI80MEEtwS1OOR1jxqKz4CbyCpbZdhfUXJEJpZKlbbqysN2i/xFvjO8XIO5QQbwkY
         AJACJ6Z6R7Mz6F2TGqtVZc51IOxYgBJxK3+gEL3MP/0qTELJXv+trO7nU2C6IAiu3Ef9
         1l6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FT9vhFtD0b32PwedQ+Aeqzp1ZFHCGQ6JyNtASOi3t8U=;
        b=NaiyF6AlLcFQy98rXfc+abC5K/xO0il+1UeWy79bUDLV1X1KB4jTUq/siaR/qIWbA/
         uT8SiYSebWXyCyjUhWPVsArj3pW8hQZK0QaxY/CEy/fi4DpeYn9+UDvNbcdKyI/Km36N
         SzdfTfYSKqS8hPKjBzbhVQAHer/3Jo+vRKdBm0wOSaKTpVQfqszo9IOcgUZFHn5+4pLj
         uOYm92gC7tJCLkq1fhqP6J52k/MXH8eweH25Ha1v/3yXGIXjrHpU1UkqaYh8tZAIA3PM
         pwMxRyOjl7PGyF+RA+YqShU4So+sV/fWf+EzapvX0lMlnPeqK4HEYbBQeX4yIFQuzhdb
         jMPg==
X-Gm-Message-State: AOAM5323ML/JzTjX4X1txsZVvoJHD4UlQ4XurbdoDZKR11jHS2wtSBH3
        pqGiIQeca5reYe7My0PMaCtsm8LtlXETh7wQbh4=
X-Google-Smtp-Source: ABdhPJzBk0qeDfOblhxBALVR0E7luu03r2Ju5Em2Qu02KICQ1xgPDZPILR3cWNl3iW7kE9XaP9dU+nThZW1STmtBrpo=
X-Received: by 2002:a17:907:20d6:: with SMTP id qq22mr30246364ejb.187.1602548842667;
 Mon, 12 Oct 2020 17:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200919005451.3899779-1-harshadshirwadkar@gmail.com>
 <20200919005451.3899779-6-harshadshirwadkar@gmail.com> <20201009191407.GO235506@mit.edu>
In-Reply-To: <20201009191407.GO235506@mit.edu>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 12 Oct 2020 17:27:11 -0700
Message-ID: <CAD+ocbzy_EKUV-m=_GOTKHYXxO_ffJnpem69jFVbmBygv1b5DQ@mail.gmail.com>
Subject: Re: [PATCH v9 5/9] ext4: main fast-commit commit path
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 9, 2020 at 12:14 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Fri, Sep 18, 2020 at 05:54:47PM -0700, Harshad Shirwadkar wrote:
> >  fs/jbd2/commit.c            |   42 ++
> >  fs/jbd2/journal.c           |  119 +++-
>
> Why are these changes here instead of the previous commit (jbd2: add
> fast commit machinery)?
Makes sense, Ill move these functions to the previous commit.
>
> > diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> > index ba35ecb18616..dadd9994e74b 100644
> > --- a/fs/jbd2/commit.c
> > +++ b/fs/jbd2/commit.c
> > @@ -202,6 +202,47 @@ static int journal_submit_inode_data_buffers(struct address_space *mapping,
> >       return ret;
> >  }
> >
> > +/* Send all the data buffers related to an inode */
> > +int jbd2_submit_inode_data(journal_t *journal, struct jbd2_inode *jinode)
> > +{
> > +     struct address_space *mapping;
> > +     loff_t dirty_start;
> > +     loff_t dirty_end;
> > +     int ret;
> > +
> > +     if (!jinode)
> > +             return 0;
> > +
> > +     dirty_start = jinode->i_dirty_start;
> > +     dirty_end = jinode->i_dirty_end;
> > +
> > +     if (!(jinode->i_flags & JI_WRITE_DATA))
> > +             return 0;
> > +
> > +     dirty_start = jinode->i_dirty_start;
> > +     dirty_end = jinode->i_dirty_end;
>
> Why is dirty_start and dirty_end initialized twice?
Thanks for catching this. I'll fix this in V10.
>
> Also, this is going to conflcit with Mauricio's data=journal patches,
> which you'll notice when you rebase these patches on the current dev branch.
Thanks for the heads up.
- Harshad
>
> (The dev branch temporarily had your v9 patches merged in, so we could
> get the test bots to comment on your changes, but I've since pulled
> the fc patches back out.)
>
>                                         - Ted
