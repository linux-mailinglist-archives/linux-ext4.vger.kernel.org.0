Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8677A42BBC9
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Oct 2021 11:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238986AbhJMJkv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Oct 2021 05:40:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49614 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238388AbhJMJkv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 13 Oct 2021 05:40:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3168F21A63;
        Wed, 13 Oct 2021 09:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634117927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YxjEGZZ1prI96OAFnaOsXZL53xqr89Luesf5g0xwzvc=;
        b=wMOoFPoGcozMXIDZZg5MQ+yQjOhvCmgGFo5xJ+gJfe3aA2f8PT0R3kB7yKiblCZpuliiox
        3O+ac2MoOgtXpZIvrJCoT8KyDzXMxDEKOc1wBZs7wjNiYk3mde8LaMGkeoAJ2vUqpPa1Px
        WECW95hlU7ti6sjlZLCTV7Lss0izXrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634117927;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YxjEGZZ1prI96OAFnaOsXZL53xqr89Luesf5g0xwzvc=;
        b=9IZCJSmB+5AAZGerpBYokk4amIXaeOhmnTBRhxu/0ZKJ+6I6s9/5+EuDuUEJ5kv3CaQ4C1
        WRS3LwT2zUl0O9CQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 21DCDA3B85;
        Wed, 13 Oct 2021 09:38:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 268831E11B6; Wed, 13 Oct 2021 11:38:47 +0200 (CEST)
Date:   Wed, 13 Oct 2021 11:38:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     yebin <yebin10@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2 2/6] ext4: introduce last_check_time record
 previous check time
Message-ID: <20211013093847.GB19200@quack2.suse.cz>
References: <20210911090059.1876456-1-yebin10@huawei.com>
 <20210911090059.1876456-3-yebin10@huawei.com>
 <20211007123100.GG12712@quack2.suse.cz>
 <615FA55B.5070404@huawei.com>
 <615FAF27.8070000@huawei.com>
 <20211012084727.GF9697@quack2.suse.cz>
 <61657590.2050407@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61657590.2050407@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 12-10-21 19:46:24, yebin wrote:
> On 2021/10/12 16:47, Jan Kara wrote:
> > On Fri 08-10-21 10:38:31, yebin wrote:
> > > On 2021/10/8 9:56, yebin wrote:
> > > > On 2021/10/7 20:31, Jan Kara wrote:
> > > > > On Sat 11-09-21 17:00:55, Ye Bin wrote:
> > > > > > kmmpd:
> > > > > > ...
> > > > > >       diff = jiffies - last_update_time;
> > > > > >       if (diff > mmp_check_interval * HZ) {
> > > > > > ...
> > > > > > As "mmp_check_interval = 2 * mmp_update_interval", 'diff' always little
> > > > > > than 'mmp_update_interval', so there will never trigger detection.
> > > > > > Introduce last_check_time record previous check time.
> > > > > > 
> > > > > > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > > > > I think the check is there only for the case where write_mmp_block() +
> > > > > sleep took longer than mmp_check_interval. I agree that should rarely
> > > > > happen but on a really busy system it is possible and in that case
> > > > > we would
> > > > > miss updating mmp block for too long and so another node could have
> > > > > started
> > > > > using the filesystem. I actually don't see a reason why kmmpd should be
> > > > > checking the block each mmp_check_interval as you do -
> > > > > mmp_check_interval
> > > > > is just for ext4_multi_mount_protect() to know how long it should wait
> > > > > before considering mmp block stale... Am I missing something?
> > > > > 
> > > > >                                  Honza
> > > > I'm sorry, I didn't understand the detection mechanism here before. Now
> > > > I understand
> > > > the detection mechanism here.
> > > > As you said, it's just an abnormal protection. There's really no problem.
> > > > 
> > > Yeah, i did test as following steps
> > > hostA                        hostB
> > >     mount
> > >       ext4_multi_mount_protect  -> seq == EXT4_MMP_SEQ_CLEAN
> > >          delay 5s after label "skip" so hostB will see seq is
> > > EXT4_MMP_SEQ_CLEAN
> > >                         mount
> > >                         ext4_multi_mount_protect -> seq == EXT4_MMP_SEQ_CLEAN
> > >                                 run  kmmpd
> > >      run kmmpd
> > > 
> > > Actually，in this  situation kmmpd will not detect  confliction.
> > > In ext4_multi_mount_protect function we write mmp data first and wait
> > > 'wait_time * HZ'  seconds,
> > > read mmp data do check. Most of the time, If 'wait_time' is zero, it can pass
> > > check.
> > But how can be wait_time zero? As far as I'm reading the code, wait_time
> > must be at least EXT4_MMP_MIN_CHECK_INTERVAL...
> > 
> > 								Honza
>  int ext4_multi_mount_protect(struct super_block *sb,
>                                      ext4_fsblk_t mmp_block)
>  {
>          struct ext4_super_block *es = EXT4_SB(sb)->s_es;
>          struct buffer_head *bh = NULL;
>          struct mmp_struct *mmp = NULL;
>          u32 seq;
>          unsigned int mmp_check_interval =
> le16_to_cpu(es->s_mmp_update_interval);
>          unsigned int wait_time = 0;                    --> wait_time is
> equal with zero
>          int retval;
> 
>          if (mmp_block < le32_to_cpu(es->s_first_data_block) ||
>              mmp_block >= ext4_blocks_count(es)) {
>                  ext4_warning(sb, "Invalid MMP block in superblock");
>                  goto failed;
>          }
> 
>          retval = read_mmp_block(sb, &bh, mmp_block);
>          if (retval)
>                  goto failed;
> 
>          mmp = (struct mmp_struct *)(bh->b_data);
> 
>          if (mmp_check_interval < EXT4_MMP_MIN_CHECK_INTERVAL)
>                  mmp_check_interval = EXT4_MMP_MIN_CHECK_INTERVAL;
> 
>          /*
>           * If check_interval in MMP block is larger, use that instead of
>           * update_interval from the superblock.
>           */
>          if (le16_to_cpu(mmp->mmp_check_interval) > mmp_check_interval)
>                  mmp_check_interval = le16_to_cpu(mmp->mmp_check_interval);
> 
>          seq = le32_to_cpu(mmp->mmp_seq);
>          if (seq == EXT4_MMP_SEQ_CLEAN)   --> If hostA and hostB mount the
> same block device at the same time,
> --> HostA and hostB  maybe get 'seq' with the same value EXT4_MMP_SEQ_CLEAN.
>                  goto skip;

Oh, I see. Thanks for explanation. 

> ...
> skip:
>         /*
>          * write a new random sequence number.
>          */
>         seq = mmp_new_seq();
>         mmp->mmp_seq = cpu_to_le32(seq);
> 
>         retval = write_mmp_block(sb, bh);
>         if (retval)
>                 goto failed;
> 
>         /*
>          * wait for MMP interval and check mmp_seq.
>          */
>         if (schedule_timeout_interruptible(HZ * wait_time) != 0) {
> --> If seq is equal with EXT4_MMP_SEQ_CLEAN, wait_time is zero.
>                 ext4_warning(sb, "MMP startup interrupted, failing mount");
>                 goto failed;
>         }
> 
>         retval = read_mmp_block(sb, &bh, mmp_block); -->We may get the same
> data with which we wrote, so we can't detect conflict at here.

OK, I see. So the race in ext4_multi_mount_protect() goes like:

hostA				hostB

read_mmp_block()		read_mmp_block()
- sees EXT4_MMP_SEQ_CLEAN	- sees EXT4_MMP_SEQ_CLEAN
write_mmp_block()
wait_time == 0 -> no wait
read_mmp_block()
  - all OK, mount
				write_mmp_block()
				wait_time == 0 -> no wait
				read_mmp_block()
				  - all OK, mount

Do I get it right? Actually, if we passed seq we wrote in
ext4_multi_mount_protect() to kmmpd (probably in sb), then kmmpd would
notice the conflict on its first invocation but still that would be a bit
late because there would be a time window where hostA and hostB would be
both using the fs.

We could reduce the likelyhood of this race by always waiting in
ext4_multi_mount_protect() between write & read but I guess that is
undesirable as it would slow down all clean mounts. Ted?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
