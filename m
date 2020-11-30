Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7D42C82BC
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Nov 2020 12:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgK3LAZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Nov 2020 06:00:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:55318 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbgK3LAZ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 30 Nov 2020 06:00:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 89353AD20;
        Mon, 30 Nov 2020 10:59:43 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2DA981E131B; Mon, 30 Nov 2020 11:59:43 +0100 (CET)
Date:   Mon, 30 Nov 2020 11:59:43 +0100
From:   Jan Kara <jack@suse.cz>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Jan Kara <jack@suse.cz>, Eric Biggers <ebiggers@kernel.org>,
        Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 02/12] ext4: Remove redundant sb checksum recomputation
Message-ID: <20201130105943.GI11250@quack2.suse.cz>
References: <20201127113405.26867-1-jack@suse.cz>
 <20201127113405.26867-3-jack@suse.cz>
 <301139FC-B346-4199-B26E-1FF0CB970746@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <301139FC-B346-4199-B26E-1FF0CB970746@dilger.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun 29-11-20 15:11:05, Andreas Dilger wrote:
> On Nov 27, 2020, at 4:33 AM, Jan Kara <jack@suse.cz> wrote:
> > 
> > Superblock is written out either through ext4_commit_super() or through
> > ext4_handle_dirty_super(). In both cases we recompute the checksum so it
> > is not necessary to recompute it after updating superblock free inodes &
> > blocks counters.
> 
> I searched through the code to see where s_sbh is being used, and it
> looks like there is one case that doesn't update the checksum using
> ext4_handle_dirty_super(), namely:
> 
> ext4_file_ioctl(cmd=FS_IOC_GET_ENCRYPTION_PWSALT)
> {
>                         err = ext4_journal_get_write_access(handle, sbi->s_sbh);
>                         if (err)
>                                 goto pwsalt_err_journal;
>                         generate_random_uuid(sbi->s_es->s_encrypt_pw_salt);
>                         err = ext4_handle_dirty_metadata(handle, NULL,
>                                                          sbi->s_sbh);
> 
> I don't think that is a problem with this patch, per se, but looks like
> a bug that could be hit in rare cases with fscrypt + metadata_csum.  It
> would only happen once per filesystem, and would normally be hidden by
> later superblock updates, but should probably be fixed anyway.

Yeah, good spotting. I'll write a fix for this.

> Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Thanks for review!

								Honza

> 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> > fs/ext4/super.c | 2 --
> > 1 file changed, 2 deletions(-)
> > 
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 2b08b162075c..61e6e5f156f3 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -5004,13 +5004,11 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
> > 	block = ext4_count_free_clusters(sb);
> > 	ext4_free_blocks_count_set(sbi->s_es,
> > 				   EXT4_C2B(sbi, block));
> > -	ext4_superblock_csum_set(sb);
> > 	err = percpu_counter_init(&sbi->s_freeclusters_counter, block,
> > 				  GFP_KERNEL);
> > 	if (!err) {
> > 		unsigned long freei = ext4_count_free_inodes(sb);
> > 		sbi->s_es->s_free_inodes_count = cpu_to_le32(freei);
> > -		ext4_superblock_csum_set(sb);
> > 		err = percpu_counter_init(&sbi->s_freeinodes_counter, freei,
> > 					  GFP_KERNEL);
> > 	}
> > --
> > 2.16.4
> > 
> 
> 
> Cheers, Andreas
> 
> 
> 
> 
> 


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
