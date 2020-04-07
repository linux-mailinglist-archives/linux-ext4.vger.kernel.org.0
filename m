Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B09271A075E
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Apr 2020 08:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgDGGfo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Apr 2020 02:35:44 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33996 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgDGGfo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Apr 2020 02:35:44 -0400
Received: by mail-ot1-f66.google.com with SMTP id m2so2024222otr.1
        for <linux-ext4@vger.kernel.org>; Mon, 06 Apr 2020 23:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=efJOUkBV33ONhtFepVReOr3eUF/DdvSoYtm+h6xx1aw=;
        b=LC6gN1eF27hWB2hWZtRzvpCXnrtkFIM/tBgOM9RnPHhbByr1gpNINvDAOZTKAVcNsZ
         8kgRFkjzuSjwlO8P3Z8SamJLw0BwaRGBYxJ5VieAd5ItXjRdFIc7xzzn6/mMrwddCOcN
         ItWNovR7in/G4JfCgHSMba5ru0lQDc0msubEO9RmViow86WvXT/b1OyexVOE93fZmHlq
         DvhbQgKlJHI+nT1qvZsEaxf0Uo7use2zm8AsKiWGppBtr0xALXd88swAAk1y8U7+HRr9
         HTsx56TDKuWcHLN0YffKvSukKcrkvtKleRxLLrwU22788Kf84TI6cXLhStzQX6sp7Dax
         JCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=efJOUkBV33ONhtFepVReOr3eUF/DdvSoYtm+h6xx1aw=;
        b=NKf565mZgmbdCIgjyNB3xgaUHXWpoELXmynM4dJZWvWbbEWQYQcpuE/Whc1pvJmP/o
         HPHy6RUQ5zqbG7SfH1CbsMb+NBCIYcAe2jo+gTAQMJ1UDqZhryGlXKCv7hnqjyyrLpvN
         iMatlA1KDzfXZ5SYs0vqj2ySJOwjRFLNJEdyo6x57mi76EaqDghvR6SePiX8N61NLJoS
         8ioVlDXA53gOP+qgSRSJpgtRcMNvgIXcZm5CVFwbPsfWp5I+gKN7lxuHvI2iD2jCiehs
         LW4aD7bj9JuyrSpPOUuGGUK6KghFDkGp8o4Yf8Jc9nzS5EgBdbv6OewPtn4LY5Me/4Ws
         TARA==
X-Gm-Message-State: AGi0PubdWNBqH0n+rFWc09bRGN4FOh0LdDq3HArEv07l0Q0NXioDqr9Q
        kEWADjI8pAToM7BxFQE/p7D8d0zkem3l3D/Rzz80jdgH
X-Google-Smtp-Source: APiQypLgfqWGROmYRoHJ/dTY3HdAGNYwIqOxHdwPSqerjOPsOb3pW8ZfwroNkjjDdSVLM+prJeil1AjK08M73uMkqwo=
X-Received: by 2002:a05:6830:1aee:: with SMTP id c14mr353012otd.141.1586241342976;
 Mon, 06 Apr 2020 23:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200325093728.204211-1-harshadshirwadkar@gmail.com> <34AB07FF-1872-46EB-B7B6-5CE24EFB39C6@dilger.ca>
In-Reply-To: <34AB07FF-1872-46EB-B7B6-5CE24EFB39C6@dilger.ca>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 6 Apr 2020 23:35:32 -0700
Message-ID: <CAD+ocbwDor6uoQzuP+DrER8XXsoYZWzud5yo74pG=k20-ysOyQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ext4: return lblk from ext4_find_entry
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Mar 28, 2020 at 4:24 PM Andreas Dilger <adilger@dilger.ca> wrote:
>
> On Mar 25, 2020, at 3:37 AM, Harshad Shirwadkar <harshadshirwadkar@gmail.com> wrote:
> >
> > This patch makes ext4_find_entry and related routines to return
> > logical block address of the dirent block. This logical block address
> > is used in the directory shrinking code to perform reverse lookup and
> > verify that the lookup was successful.
> >
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> > ---
> > fs/ext4/namei.c | 54 +++++++++++++++++++++++++++++--------------------
> > 1 file changed, 32 insertions(+), 22 deletions(-)
>
> Would it make sense to add the "lblk" field to struct ext4_renament,
> rather than adding an extra argument for all of these functions?

ext4_renament is only available in ext4_rename_delete(), for other
callers we still need a way to use lblk. So, I am not sure if adding
lblk to ext4_renament is helpful. Am I missing something here?


>
> Otherwise, the patch looks OK.
>
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
>
> > static void ext4_rename_delete(handle_t *handle, struct ext4_renament *ent,
> > -                            int force_reread)
> > +                            int force_reread, ext4_lblk_t lblk)
> > {
> >       int retval;
> >       /*
> > @@ -3593,7 +3600,8 @@ static void ext4_rename_delete(handle_t *handle, struct ext4_renament *ent,
> >               retval = ext4_find_delete_entry(handle, ent->dir,
> >                                               &ent->dentry->d_name);
> >       } else {
> > -             retval = ext4_delete_entry(handle, ent->dir, ent->de, ent->bh);
> > +             retval = ext4_delete_entry(handle, ent->dir, ent->de, ent->bh,
> > +                                        lblk);
> >               if (retval == -ENOENT) {
> >                       retval = ext4_find_delete_entry(handle, ent->dir,
> >                                                       &ent->dentry->d_name);
> > @@ -3679,6 +3687,7 @@ static int ext4_rename(struct inode *old_dir, struct dentry *old_dentry,
> >       struct inode *whiteout = NULL;
> >       int credits;
> >       u8 old_file_type;
> > +     ext4_lblk_t lblk;
> >
> >       if (new.inode && new.inode->i_nlink == 0) {
> >               EXT4_ERROR_INODE(new.inode,
> > @@ -3706,7 +3715,8 @@ static int ext4_rename(struct inode *old_dir, struct dentry *old_dentry,
> >                       return retval;
> >       }
> >
> > -     old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de, NULL);
> > +     old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de, NULL,
> > +                              &lblk);
> >       if (IS_ERR(old.bh))
> >               return PTR_ERR(old.bh);
> >       /*
> > @@ -3720,7 +3730,7 @@ static int ext4_rename(struct inode *old_dir, struct dentry *old_dentry,
> >               goto end_rename;
> >
> >       new.bh = ext4_find_entry(new.dir, &new.dentry->d_name,
> > -                              &new.de, &new.inlined);
> > +                              &new.de, &new.inlined, NULL);
> >       if (IS_ERR(new.bh)) {
> >               retval = PTR_ERR(new.bh);
> >               new.bh = NULL;
> > @@ -3817,7 +3827,7 @@ static int ext4_rename(struct inode *old_dir, struct dentry *old_dentry,
> >               /*
> >                * ok, that's it
> >                */
> > -             ext4_rename_delete(handle, &old, force_reread);
> > +             ext4_rename_delete(handle, &old, force_reread, lblk);
> >       }
> >
> >       if (new.inode) {
> > @@ -3900,7 +3910,7 @@ static int ext4_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
> >               return retval;
> >
> >       old.bh = ext4_find_entry(old.dir, &old.dentry->d_name,
> > -                              &old.de, &old.inlined);
> > +                              &old.de, &old.inlined, NULL);
> >       if (IS_ERR(old.bh))
> >               return PTR_ERR(old.bh);
> >       /*
> > @@ -3914,7 +3924,7 @@ static int ext4_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
> >               goto end_rename;
> >
> >       new.bh = ext4_find_entry(new.dir, &new.dentry->d_name,
> > -                              &new.de, &new.inlined);
> > +                              &new.de, &new.inlined, NULL);
> >       if (IS_ERR(new.bh)) {
> >               retval = PTR_ERR(new.bh);
> >               new.bh = NULL;
> > --
> > 2.25.1.696.g5e7596f4ac-goog
> >
>
>
> Cheers, Andreas
>
>
>
>
>
