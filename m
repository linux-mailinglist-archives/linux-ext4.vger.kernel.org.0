Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368C634D47B
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Mar 2021 18:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhC2QGs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Mar 2021 12:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhC2QGV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 29 Mar 2021 12:06:21 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0353C061756
        for <linux-ext4@vger.kernel.org>; Mon, 29 Mar 2021 09:06:20 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id g20so12920284qkk.1
        for <linux-ext4@vger.kernel.org>; Mon, 29 Mar 2021 09:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fccwtcMSjoTqsIMugSQeCl1XcxrpMMyY9MYAvxtmR4I=;
        b=aUyfH1sHDEX67xO4hGNwEbsY/BXPd/rAvXWjOtkIG9ZghcHh/qZVSl/uza/IafEGwf
         tu5hVoiKZ+nJEvcYna1uCXXv6Nptvy3lFrbjs76FkcZLO5zIBemglekp62WoLQ8ULFZ4
         pnbYCmYfXuEOEVYXjmHsU2cdQGz1Zxmg8WzWZBho868XvoprlBZcSzzMHvSNIWBYjCwz
         MXwS2KxLpXHj+VOTGo6yl/PsV8c1jpHNvK6y2hRM5CCa0BCQR3/87lvaq0lmM1vqoZst
         BxXucCLvo340lU9g2DqJE63/U7XxoZ3csUo9drAvnD0z9Prl+DKzn+ZAdYYIRjT1a8pE
         XAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fccwtcMSjoTqsIMugSQeCl1XcxrpMMyY9MYAvxtmR4I=;
        b=g8xK1A3/a8CTc2zxivgp2XOercjOWnIpaH0hR3JmiRqHhH979u7lVvfMg6EBeZVRas
         A4RcholftHkOgrQYoISSaoyK7ijxHY7x8eSCvIkkfdT4S1cp9iJWjZbPiAmAT9kZtmYQ
         /7GYNG7qSt5fdsVNjdNht5yMcOcOWpNfL9fLB71aMhl4WpayJRfsOl+DbMyzIhbbZMN8
         ZLMGVE8RRdtWeWdvFhG5MDRnqHRbBQYe2G+7y66+SvSB69C+EwD1AftI4D6mjApNbKIB
         vi72aXRvrrMl3ikc/+9I//HUzYHEpCXBwU09niovOnzwFpyofyC+nsrR1MrlNiF4Qdvh
         vOJQ==
X-Gm-Message-State: AOAM532CmQ7q86KKFvZxJf5JIRgjedWgDGluVemkHZeh27+877xiLX1e
        KGyghuwp/jqgXGo/CwGHQiI=
X-Google-Smtp-Source: ABdhPJyC21lyS8E/dFBW73CMPiqhvIfdyivXzK9BQ6seOnWv97AyH7biQ+hjauBKYwL66faiIUSfzw==
X-Received: by 2002:a05:620a:914:: with SMTP id v20mr26519436qkv.140.1617033979662;
        Mon, 29 Mar 2021 09:06:19 -0700 (PDT)
Received: from google.com ([2601:4c3:201:ed00:94a2:3853:8ddc:29d3])
        by smtp.gmail.com with ESMTPSA id z89sm11358565qtd.5.2021.03.29.09.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 09:06:19 -0700 (PDT)
Date:   Mon, 29 Mar 2021 12:06:17 -0400
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     harshad shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 1/2] ext4: wipe filename upon file deletion
Message-ID: <YGH6+VzYVVvbNn7r@google.com>
References: <20210325181220.1118705-1-leah.rumancik@gmail.com>
 <A08FAD7B-899F-4B40-9881-2ACD45399471@dilger.ca>
 <CAD+ocbxp5s5QfOKheftMMyd69RaZtS9z8RBnjUqZ3siOCdfFbg@mail.gmail.com>
 <20210327020823.GC22091@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210327020823.GC22091@magnolia>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Mar 26, 2021 at 07:08:23PM -0700, Darrick J. Wong wrote:
> On Fri, Mar 26, 2021 at 06:43:52PM -0700, harshad shirwadkar wrote:
> > On Fri, Mar 26, 2021 at 4:08 PM Andreas Dilger <adilger@dilger.ca> wrote:
> > >
> > > On Mar 25, 2021, at 12:12 PM, Leah Rumancik <leah.rumancik@gmail.com> wrote:
> > > >
> > > > Zero out filename field when file is deleted. Also, add mount option
> > > > nowipe_filename to disable this filename wipeout if desired.
> > >
> > > I would personally be against "wipe out entries on delete" as the default
> > > behavior.  I think most users would prefer that their data is maximally
> > > recoverable, rather than the minimal security benefit of erasing deleted
> > > content by default.
> > I understand that persistence of filenames provides recoverability
> > that users might like but I feel like that may break sooner or later.
> > For example, if we get directory shrinking patches[1] merged in or if
> > we redesign the directory htree using generic btrees (which will
> > hopefully support shrinking), this kind of recovery will become very
> > hard.
> > 
> > Also, I was wondering if persistence of file names was by design? or
> > it was there due to the way we implemented directories?
> 
> I bet it wasn't done by design -- afaict all the recovery tools are
> totally opportunistic in that /if/ they find something that looks like a
> directory entry, /then/ it will pick that up.  The names will eventually
> get overwritten, so that's the best they can do.
> 
> (I would also wager that people don't like opt-out for new behaviors
> unless you're adding it as part of a new feature...)
> 
> --D

What about a mount option to enable the filename wipe (with the wiping
disabled by default)?

> 
> > [1] https://patchwork.ozlabs.org/project/linux-ext4/list/?series=166560
> > 
> > Thanks,
> > Harshad
> > >
> > > I think that Darrick made a good point that using the EXT4_SECRM_FL on
> > > the inode gives users a good option to enable/disable this on a per
> > > file or directory basis.
> > >
> > > > Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> > > > ---
> > > > fs/ext4/ext4.h  |  1 +
> > > > fs/ext4/namei.c |  4 ++++
> > > > fs/ext4/super.c | 11 ++++++++++-
> > > > 3 files changed, 15 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > > > index 826a56e3bbd2..8011418176bc 100644
> > > > --- a/fs/ext4/ext4.h
> > > > +++ b/fs/ext4/ext4.h
> > > > @@ -1247,6 +1247,7 @@ struct ext4_inode_info {
> > > > #define EXT4_MOUNT2_JOURNAL_FAST_COMMIT       0x00000010 /* Journal fast commit */
> > > > #define EXT4_MOUNT2_DAX_NEVER         0x00000020 /* Do not allow Direct Access */
> > > > #define EXT4_MOUNT2_DAX_INODE         0x00000040 /* For printing options only */
> > > > +#define EXT4_MOUNT2_WIPE_FILENAME       0x00000080 /* Wipe filename on del entry */
> > > >
> > > >
> > > > #define clear_opt(sb, opt)            EXT4_SB(sb)->s_mount_opt &= \
> > > > diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> > > > index 883e2a7cd4ab..ae6ecabd4d97 100644
> > > > --- a/fs/ext4/namei.c
> > > > +++ b/fs/ext4/namei.c
> > > > @@ -2492,6 +2492,10 @@ int ext4_generic_delete_entry(struct inode *dir,
> > > >                       else
> > > >                               de->inode = 0;
> > > >                       inode_inc_iversion(dir);
> > > > +
> > > > +                     if (test_opt2(dir->i_sb, WIPE_FILENAME))
> > > > +                             memset(de_del->name, 0, de_del->name_len);
> > > > +
> > > >                       return 0;
> > > >               }
> > > >               i += ext4_rec_len_from_disk(de->rec_len, blocksize);
> > > > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > > > index b9693680463a..5e8737b3f171 100644
> > > > --- a/fs/ext4/super.c
> > > > +++ b/fs/ext4/super.c
> > > > @@ -1688,7 +1688,7 @@ enum {
> > > >       Opt_dioread_nolock, Opt_dioread_lock,
> > > >       Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
> > > >       Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
> > > > -     Opt_prefetch_block_bitmaps,
> > > > +     Opt_prefetch_block_bitmaps, Opt_nowipe_filename,
> > > > #ifdef CONFIG_EXT4_DEBUG
> > > >       Opt_fc_debug_max_replay, Opt_fc_debug_force
> > > > #endif
> > > > @@ -1787,6 +1787,7 @@ static const match_table_t tokens = {
> > > >       {Opt_test_dummy_encryption, "test_dummy_encryption"},
> > > >       {Opt_inlinecrypt, "inlinecrypt"},
> > > >       {Opt_nombcache, "nombcache"},
> > > > +     {Opt_nowipe_filename, "nowipe_filename"},
> > > >       {Opt_nombcache, "no_mbcache"},  /* for backward compatibility */
> > > >       {Opt_prefetch_block_bitmaps, "prefetch_block_bitmaps"},
> > > >       {Opt_removed, "check=none"},    /* mount option from ext2/3 */
> > > > @@ -2007,6 +2008,8 @@ static const struct mount_opts {
> > > >       {Opt_max_dir_size_kb, 0, MOPT_GTE0},
> > > >       {Opt_test_dummy_encryption, 0, MOPT_STRING},
> > > >       {Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
> > > > +     {Opt_nowipe_filename, EXT4_MOUNT2_WIPE_FILENAME, MOPT_CLEAR | MOPT_2 |
> > > > +             MOPT_EXT4_ONLY},
> > > >       {Opt_prefetch_block_bitmaps, EXT4_MOUNT_PREFETCH_BLOCK_BITMAPS,
> > > >        MOPT_SET},
> > > > #ifdef CONFIG_EXT4_DEBUG
> > > > @@ -2621,6 +2624,10 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
> > > >       } else if (test_opt2(sb, DAX_INODE)) {
> > > >               SEQ_OPTS_PUTS("dax=inode");
> > > >       }
> > > > +
> > > > +     if (!test_opt2(sb, WIPE_FILENAME))
> > > > +             SEQ_OPTS_PUTS("nowipe_filename");
> > > > +
> > > >       ext4_show_quota_options(seq, sb);
> > > >       return 0;
> > > > }
> > > > @@ -4161,6 +4168,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
> > > >       if (def_mount_opts & EXT4_DEFM_DISCARD)
> > > >               set_opt(sb, DISCARD);
> > > >
> > > > +     set_opt2(sb, WIPE_FILENAME);
> > > > +
> > > >       sbi->s_resuid = make_kuid(&init_user_ns, le16_to_cpu(es->s_def_resuid));
> > > >       sbi->s_resgid = make_kgid(&init_user_ns, le16_to_cpu(es->s_def_resgid));
> > > >       sbi->s_commit_interval = JBD2_DEFAULT_MAX_COMMIT_AGE * HZ;
> > > > --
> > > > 2.31.0.291.g576ba9dcdaf-goog
> > > >
> > >
> > >
> > > Cheers, Andreas
> > >
> > >
> > >
> > >
> > >
