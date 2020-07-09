Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB1C21A325
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Jul 2020 17:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgGIPPz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Jul 2020 11:15:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:33286 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgGIPPz (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 9 Jul 2020 11:15:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 10217ACBF;
        Thu,  9 Jul 2020 15:15:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 111391E12C3; Thu,  9 Jul 2020 17:15:53 +0200 (CEST)
Date:   Thu, 9 Jul 2020 17:15:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: don't BUG on inconsistent journal feature
Message-ID: <20200709151553.GK25069@quack2.suse.cz>
References: <20200709095854.3651-1-jack@suse.cz>
 <20200709123655.y7p7idrqukdi2he5@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709123655.y7p7idrqukdi2he5@work>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 09-07-20 14:36:55, Lukas Czerner wrote:
> On Thu, Jul 09, 2020 at 11:58:54AM +0200, Jan Kara wrote:
> > A customer has reported a BUG_ON in ext4_clear_journal_err() hitting
> > during an LTP testing. Either this has been caused by a test setup
> > issue where the filesystem was being overwritten while LTP was mounting
> > it or the journal replay has overwritten the superblock with invalid
> > data. In either case it is preferable we don't take the machine down
> > with a BUG_ON. So handle the situation of unexpectedly missing
> > has_journal feature more gracefully by a WARN_ON_ONCE and bailing out
> > with error.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/ext4/super.c | 35 ++++++++++++++++++++++++-----------
> >  1 file changed, 24 insertions(+), 11 deletions(-)
> > 
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 330957ed1f05..d8b7222cb86c 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -68,8 +68,8 @@ static int ext4_show_options(struct seq_file *seq, struct dentry *root);
> >  static int ext4_commit_super(struct super_block *sb, int sync);
> >  static void ext4_mark_recovery_complete(struct super_block *sb,
> >  					struct ext4_super_block *es);
> > -static void ext4_clear_journal_err(struct super_block *sb,
> > -				   struct ext4_super_block *es);
> > +static int ext4_clear_journal_err(struct super_block *sb,
> > +				  struct ext4_super_block *es);
> >  static int ext4_sync_fs(struct super_block *sb, int wait);
> >  static int ext4_remount(struct super_block *sb, int *flags, char *data);
> >  static int ext4_statfs(struct dentry *dentry, struct kstatfs *buf);
> > @@ -4956,7 +4956,8 @@ static journal_t *ext4_get_journal(struct super_block *sb,
> >  	struct inode *journal_inode;
> >  	journal_t *journal;
> >  
> > -	BUG_ON(!ext4_has_feature_journal(sb));
> > +	if (WARN_ON_ONCE(!ext4_has_feature_journal(sb)))
> > +		return NULL;
> >  
> >  	journal_inode = ext4_get_journal_inode(sb, journal_inum);
> >  	if (!journal_inode)
> > @@ -4986,7 +4987,8 @@ static journal_t *ext4_get_dev_journal(struct super_block *sb,
> >  	struct ext4_super_block *es;
> >  	struct block_device *bdev;
> >  
> > -	BUG_ON(!ext4_has_feature_journal(sb));
> > +	if (WARN_ON_ONCE(!ext4_has_feature_journal(sb)))
> > +		return NULL;
> >  
> >  	bdev = ext4_blkdev_get(j_dev, sb);
> >  	if (bdev == NULL)
> > @@ -5078,7 +5080,8 @@ static int ext4_load_journal(struct super_block *sb,
> >  	int err = 0;
> >  	int really_read_only;
> >  
> > -	BUG_ON(!ext4_has_feature_journal(sb));
> > +	if (WARN_ON_ONCE(!ext4_has_feature_journal(sb)))
> > +		return -EFSCORRUPTED;
> >  
> >  	if (journal_devnum &&
> >  	    journal_devnum != le32_to_cpu(es->s_journal_dev)) {
> > @@ -5148,7 +5151,12 @@ static int ext4_load_journal(struct super_block *sb,
> >  	}
> >  
> >  	EXT4_SB(sb)->s_journal = journal;
> > -	ext4_clear_journal_err(sb, es);
> > +	err = ext4_clear_journal_err(sb, es);
> > +	if (err) {
> > +		EXT4_SB(sb)->s_journal = NULL;
> > +		jbd2_journal_destroy(journal);
> > +		return err;
> > +	}
> >  
> >  	if (!really_read_only && journal_devnum &&
> >  	    journal_devnum != le32_to_cpu(es->s_journal_dev)) {
> > @@ -5250,7 +5258,7 @@ static void ext4_mark_recovery_complete(struct super_block *sb,
> >  	journal_t *journal = EXT4_SB(sb)->s_journal;
> >  
> >  	if (!ext4_has_feature_journal(sb)) {
> > -		BUG_ON(journal != NULL);
> > +		WARN_ON_ONCE(journal != NULL);

Hi Lukas!

> If this ever happens we will hapily continue with fs operation after
> mount, or remount (remount is ro, so that is probably ok ?) without
> journal feature, but with s_journal set ? I am not quite sure what the
> consequences might be, are you sure this is ok ?

Hum, you're right we should probably fail the mount... In fact looking into
this now, we should probably also handle this situation with ext4_error() so
that filesystem gets marked as corrupted and all that. Thanks for feedback.
I'll rework the patch.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
