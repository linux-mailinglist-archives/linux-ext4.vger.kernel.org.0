Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2817834B3AD
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Mar 2021 03:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhC0CIq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 26 Mar 2021 22:08:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230121AbhC0CI0 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 26 Mar 2021 22:08:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32586619BA;
        Sat, 27 Mar 2021 02:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616810905;
        bh=l/yOlcCX3Gkr9u0QB2R5IEClEOYun09kMej+gCOGGpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NWbNPi06OWT6c6PhITwS7Map6imX4QFPlIJPBYfU5W5Au3Kxg44CwKneyXBgzaC6I
         mVjZ/FcfVqsqFNbvFl/GntRDSh4vNNwBc5xxk+eTItCXCAPo918ODqZlxHwxFyjyys
         htyVSgN2MIN70ZbAAIW6yM/yAZBVc3fwOFyG5E8WJTjOgTymPXGhX9l9XWMB+2+5Ew
         TO7pDrwPPS/wzol5ka7ZVHM7jl8oeBT5oWrTJE0aMgilaEiZr0QsN1pM6+k4B3IL0T
         1pwIjEx6raiC8UzWF7qCvsJs21D0a9sYNSOIFEP+YGtsUrHl4QwTB4MG2/W03915Yh
         +/NjZ6ub9JGMQ==
Date:   Fri, 26 Mar 2021 19:08:23 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Leah Rumancik <leah.rumancik@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 1/2] ext4: wipe filename upon file deletion
Message-ID: <20210327020823.GC22091@magnolia>
References: <20210325181220.1118705-1-leah.rumancik@gmail.com>
 <A08FAD7B-899F-4B40-9881-2ACD45399471@dilger.ca>
 <CAD+ocbxp5s5QfOKheftMMyd69RaZtS9z8RBnjUqZ3siOCdfFbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD+ocbxp5s5QfOKheftMMyd69RaZtS9z8RBnjUqZ3siOCdfFbg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Mar 26, 2021 at 06:43:52PM -0700, harshad shirwadkar wrote:
> On Fri, Mar 26, 2021 at 4:08 PM Andreas Dilger <adilger@dilger.ca> wrote:
> >
> > On Mar 25, 2021, at 12:12 PM, Leah Rumancik <leah.rumancik@gmail.com> wrote:
> > >
> > > Zero out filename field when file is deleted. Also, add mount option
> > > nowipe_filename to disable this filename wipeout if desired.
> >
> > I would personally be against "wipe out entries on delete" as the default
> > behavior.  I think most users would prefer that their data is maximally
> > recoverable, rather than the minimal security benefit of erasing deleted
> > content by default.
> I understand that persistence of filenames provides recoverability
> that users might like but I feel like that may break sooner or later.
> For example, if we get directory shrinking patches[1] merged in or if
> we redesign the directory htree using generic btrees (which will
> hopefully support shrinking), this kind of recovery will become very
> hard.
> 
> Also, I was wondering if persistence of file names was by design? or
> it was there due to the way we implemented directories?

I bet it wasn't done by design -- afaict all the recovery tools are
totally opportunistic in that /if/ they find something that looks like a
directory entry, /then/ it will pick that up.  The names will eventually
get overwritten, so that's the best they can do.

(I would also wager that people don't like opt-out for new behaviors
unless you're adding it as part of a new feature...)

--D

> [1] https://patchwork.ozlabs.org/project/linux-ext4/list/?series=166560
> 
> Thanks,
> Harshad
> >
> > I think that Darrick made a good point that using the EXT4_SECRM_FL on
> > the inode gives users a good option to enable/disable this on a per
> > file or directory basis.
> >
> > > Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> > > ---
> > > fs/ext4/ext4.h  |  1 +
> > > fs/ext4/namei.c |  4 ++++
> > > fs/ext4/super.c | 11 ++++++++++-
> > > 3 files changed, 15 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > > index 826a56e3bbd2..8011418176bc 100644
> > > --- a/fs/ext4/ext4.h
> > > +++ b/fs/ext4/ext4.h
> > > @@ -1247,6 +1247,7 @@ struct ext4_inode_info {
> > > #define EXT4_MOUNT2_JOURNAL_FAST_COMMIT       0x00000010 /* Journal fast commit */
> > > #define EXT4_MOUNT2_DAX_NEVER         0x00000020 /* Do not allow Direct Access */
> > > #define EXT4_MOUNT2_DAX_INODE         0x00000040 /* For printing options only */
> > > +#define EXT4_MOUNT2_WIPE_FILENAME       0x00000080 /* Wipe filename on del entry */
> > >
> > >
> > > #define clear_opt(sb, opt)            EXT4_SB(sb)->s_mount_opt &= \
> > > diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> > > index 883e2a7cd4ab..ae6ecabd4d97 100644
> > > --- a/fs/ext4/namei.c
> > > +++ b/fs/ext4/namei.c
> > > @@ -2492,6 +2492,10 @@ int ext4_generic_delete_entry(struct inode *dir,
> > >                       else
> > >                               de->inode = 0;
> > >                       inode_inc_iversion(dir);
> > > +
> > > +                     if (test_opt2(dir->i_sb, WIPE_FILENAME))
> > > +                             memset(de_del->name, 0, de_del->name_len);
> > > +
> > >                       return 0;
> > >               }
> > >               i += ext4_rec_len_from_disk(de->rec_len, blocksize);
> > > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > > index b9693680463a..5e8737b3f171 100644
> > > --- a/fs/ext4/super.c
> > > +++ b/fs/ext4/super.c
> > > @@ -1688,7 +1688,7 @@ enum {
> > >       Opt_dioread_nolock, Opt_dioread_lock,
> > >       Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
> > >       Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
> > > -     Opt_prefetch_block_bitmaps,
> > > +     Opt_prefetch_block_bitmaps, Opt_nowipe_filename,
> > > #ifdef CONFIG_EXT4_DEBUG
> > >       Opt_fc_debug_max_replay, Opt_fc_debug_force
> > > #endif
> > > @@ -1787,6 +1787,7 @@ static const match_table_t tokens = {
> > >       {Opt_test_dummy_encryption, "test_dummy_encryption"},
> > >       {Opt_inlinecrypt, "inlinecrypt"},
> > >       {Opt_nombcache, "nombcache"},
> > > +     {Opt_nowipe_filename, "nowipe_filename"},
> > >       {Opt_nombcache, "no_mbcache"},  /* for backward compatibility */
> > >       {Opt_prefetch_block_bitmaps, "prefetch_block_bitmaps"},
> > >       {Opt_removed, "check=none"},    /* mount option from ext2/3 */
> > > @@ -2007,6 +2008,8 @@ static const struct mount_opts {
> > >       {Opt_max_dir_size_kb, 0, MOPT_GTE0},
> > >       {Opt_test_dummy_encryption, 0, MOPT_STRING},
> > >       {Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
> > > +     {Opt_nowipe_filename, EXT4_MOUNT2_WIPE_FILENAME, MOPT_CLEAR | MOPT_2 |
> > > +             MOPT_EXT4_ONLY},
> > >       {Opt_prefetch_block_bitmaps, EXT4_MOUNT_PREFETCH_BLOCK_BITMAPS,
> > >        MOPT_SET},
> > > #ifdef CONFIG_EXT4_DEBUG
> > > @@ -2621,6 +2624,10 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
> > >       } else if (test_opt2(sb, DAX_INODE)) {
> > >               SEQ_OPTS_PUTS("dax=inode");
> > >       }
> > > +
> > > +     if (!test_opt2(sb, WIPE_FILENAME))
> > > +             SEQ_OPTS_PUTS("nowipe_filename");
> > > +
> > >       ext4_show_quota_options(seq, sb);
> > >       return 0;
> > > }
> > > @@ -4161,6 +4168,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
> > >       if (def_mount_opts & EXT4_DEFM_DISCARD)
> > >               set_opt(sb, DISCARD);
> > >
> > > +     set_opt2(sb, WIPE_FILENAME);
> > > +
> > >       sbi->s_resuid = make_kuid(&init_user_ns, le16_to_cpu(es->s_def_resuid));
> > >       sbi->s_resgid = make_kgid(&init_user_ns, le16_to_cpu(es->s_def_resgid));
> > >       sbi->s_commit_interval = JBD2_DEFAULT_MAX_COMMIT_AGE * HZ;
> > > --
> > > 2.31.0.291.g576ba9dcdaf-goog
> > >
> >
> >
> > Cheers, Andreas
> >
> >
> >
> >
> >
