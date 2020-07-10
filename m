Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A6621B7D4
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Jul 2020 16:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgGJOIi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Jul 2020 10:08:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:47570 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbgGJOIg (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 10 Jul 2020 10:08:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 73467AD87;
        Fri, 10 Jul 2020 14:08:35 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 187D81E12C9; Fri, 10 Jul 2020 16:08:35 +0200 (CEST)
Date:   Fri, 10 Jul 2020 16:08:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] ext4: don't BUG on inconsistent journal feature
Message-ID: <20200710140835.GD8447@quack2.suse.cz>
References: <20200709154104.25917-1-jack@suse.cz>
 <20200710073536.gn2c6pcevsa434sb@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710073536.gn2c6pcevsa434sb@work>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 10-07-20 09:35:36, Lukas Czerner wrote:
> On Thu, Jul 09, 2020 at 05:41:04PM +0200, Jan Kara wrote:
> > A customer has reported a BUG_ON in ext4_clear_journal_err() hitting
> > during an LTP testing. Either this has been caused by a test setup
> > issue where the filesystem was being overwritten while LTP was mounting
> > it or the journal replay has overwritten the superblock with invalid
> > data. In either case it is preferable we don't take the machine down
> > with a BUG_ON. So handle the situation of unexpectedly missing
> > has_journal feature more gracefully. We issue warning and fail the mount
> > in the cases where the race window is narrow and the failed check is
> > most likely a programming error. In cases where fs corruption is more
> > likely, we do full ext4_error() handling before failing mount / remount.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/ext4/super.c | 66 ++++++++++++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 47 insertions(+), 19 deletions(-)
> > 
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 330957ed1f05..2c8f74f741f4 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -66,10 +66,10 @@ static int ext4_load_journal(struct super_block *, struct ext4_super_block *,
> >  			     unsigned long journal_devnum);
> >  static int ext4_show_options(struct seq_file *seq, struct dentry *root);
> >  static int ext4_commit_super(struct super_block *sb, int sync);
> > -static void ext4_mark_recovery_complete(struct super_block *sb,
> > +static int ext4_mark_recovery_complete(struct super_block *sb,
> >  					struct ext4_super_block *es);
> > -static void ext4_clear_journal_err(struct super_block *sb,
> > -				   struct ext4_super_block *es);
> > +static int ext4_clear_journal_err(struct super_block *sb,
> > +				  struct ext4_super_block *es);
> >  static int ext4_sync_fs(struct super_block *sb, int wait);
> >  static int ext4_remount(struct super_block *sb, int *flags, char *data);
> >  static int ext4_statfs(struct dentry *dentry, struct kstatfs *buf);
> > @@ -4770,7 +4770,9 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
> >  	EXT4_SB(sb)->s_mount_state &= ~EXT4_ORPHAN_FS;
> >  	if (needs_recovery) {
> >  		ext4_msg(sb, KERN_INFO, "recovery complete");
> > -		ext4_mark_recovery_complete(sb, es);
> > +		err = ext4_mark_recovery_complete(sb, es);
> > +		if (err)
> > +			goto failed_mount8;
> 
> failed_mount8 is in #ifdef CONFIG_QUOTA so it probably needs to be moved
> out of the ifdef block.
> 
> Other than that it looks good to me, so with that change you can add
> 
> Reviewed-by: Lukas Czerner <lczerner@redhat.com>

Thanks for review! I've sent out v3 with you tag and the compilation
failure fixed up.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
