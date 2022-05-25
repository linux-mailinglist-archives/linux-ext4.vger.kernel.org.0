Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B48C533BFD
	for <lists+linux-ext4@lfdr.de>; Wed, 25 May 2022 13:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbiEYLyF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 May 2022 07:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiEYLyD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 May 2022 07:54:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02AFA2069;
        Wed, 25 May 2022 04:54:01 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8C5D6219F4;
        Wed, 25 May 2022 11:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653479640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tvMgR+uCwDfZHPi0OcrtO0ddVQokfCN31onC1oK79a8=;
        b=mk9bcFQJwaVEz7GzZNTv9lnEuBlHc8stnWVAqHSPpABQ1oZ5eTtHXOrOOvMtwLvfi7btKm
        AFOdQhC77UT8Q+yHussrI7fwA/cv85O5BB3BIAGpw0+TwVLaPzEVlJrW9fpGJi5OYtAyuw
        lEnAVIiE2SmemaFTcBx2aKWZRPJAk70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653479640;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tvMgR+uCwDfZHPi0OcrtO0ddVQokfCN31onC1oK79a8=;
        b=A2xznMDVnSf8DurlZAYp98fpilJCrWJHIiV/EwptK0gn+IDLE+1O5yggzwLp1AS9U9caRA
        ytSmfjD653G03UCA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 771762C141;
        Wed, 25 May 2022 11:54:00 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1837CA0632; Wed, 25 May 2022 13:54:00 +0200 (CEST)
Date:   Wed, 25 May 2022 13:54:00 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Ye Bin <yebin10@huawei.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, jack@suse.cz
Subject: Re: [PATCH -next] ext4: fix super block checksum incorrect after
 mount
Message-ID: <20220525115400.kr3urpp3cf3hybvi@quack3.lan>
References: <20220525012904.1604737-1-yebin10@huawei.com>
 <20220525075123.rx5v7fe6ocn354wn@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220525075123.rx5v7fe6ocn354wn@riteshh-domain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 25-05-22 13:21:23, Ritesh Harjani wrote:
> On 22/05/25 09:29AM, Ye Bin wrote:
> > We got issue as follows:
> > [home]# mount  /dev/sda  test
> > EXT4-fs (sda): warning: mounting fs with errors, running e2fsck is recommended
> > [home]# dmesg
> > EXT4-fs (sda): warning: mounting fs with errors, running e2fsck is recommended
> > EXT4-fs (sda): Errors on filesystem, clearing orphan list.
> > EXT4-fs (sda): recovery complete
> > EXT4-fs (sda): mounted filesystem with ordered data mode. Quota mode: none.
> > [home]# debugfs /dev/sda
> > debugfs 1.46.5 (30-Dec-2021)
> > Checksum errors in superblock!  Retrying...
> >
> > Reason is ext4_orphan_cleanup will reset ‘s_last_orphan’ but not update
> > super block checksum.
> > To solve above issue, defer update super block checksum after ext4_orphan_cleanup.
> 
> I agree with the analysis. However after [1], I think all updates to superblock
> (including checksum computation) should be done within buffer lock.
> (lock_buffer(), unlock_buffer()).
> 
> [1]: https://lore.kernel.org/all/20201216101844.22917-4-jack@suse.cz/

So technically you're right that we should hold buffer lock all the time
from before we modify superblock buffer until we recompute the checksum (so
that we avoid writing superblock with mismatched checksum). To do this we'd
have to put checksum recomputations and superblock buffer locking into
ext4_orphan_cleanup() around setting of es->s_last_orphan (in three places
there AFAICS). A bit tedious but it would actually also fix a (theoretical)
race that someone decides to write out superblock after we set
s_last_orphan but before we set the checksum.

Overall I'm not convinced this is really necessary so I'd be OK even with
what Ye suggested. That is IMHO better than mostly pointless locking just
around checksum computation because that just makes reader wonder why is it
needed...

								Honza

> 
> With lock changes added, feel free to add -
> 
> Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>
> 
> 
> >
> >
> > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > ---
> >  fs/ext4/super.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index f9a3ad683b4a..c47204029429 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -5300,14 +5300,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
> >  		err = percpu_counter_init(&sbi->s_freeinodes_counter, freei,
> >  					  GFP_KERNEL);
> >  	}
> > -	/*
> > -	 * Update the checksum after updating free space/inode
> > -	 * counters.  Otherwise the superblock can have an incorrect
> > -	 * checksum in the buffer cache until it is written out and
> > -	 * e2fsprogs programs trying to open a file system immediately
> > -	 * after it is mounted can fail.
> > -	 */
> > -	ext4_superblock_csum_set(sb);
> >  	if (!err)
> >  		err = percpu_counter_init(&sbi->s_dirs_counter,
> >  					  ext4_count_dirs(sb), GFP_KERNEL);
> > @@ -5365,6 +5357,14 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
> >  	EXT4_SB(sb)->s_mount_state |= EXT4_ORPHAN_FS;
> >  	ext4_orphan_cleanup(sb, es);
> >  	EXT4_SB(sb)->s_mount_state &= ~EXT4_ORPHAN_FS;
> > +	/*
> > +	 * Update the checksum after updating free space/inode counters and
> > +	 * ext4_orphan_cleanup. Otherwise the superblock can have an incorrect
> > +	 * checksum in the buffer cache until it is written out and
> > +	 * e2fsprogs programs trying to open a file system immediately
> > +	 * after it is mounted can fail.
> > +	 */
> > +	ext4_superblock_csum_set(sb);
> >  	if (needs_recovery) {
> >  		ext4_msg(sb, KERN_INFO, "recovery complete");
> >  		err = ext4_mark_recovery_complete(sb, es);
> > --
> > 2.31.1
> >
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
