Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAA649D242
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Aug 2019 17:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732805AbfHZPDw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Aug 2019 11:03:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:41168 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727031AbfHZPDv (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 26 Aug 2019 11:03:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C6784B07B;
        Mon, 26 Aug 2019 15:03:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 479291E3DA1; Mon, 26 Aug 2019 17:03:50 +0200 (CEST)
Date:   Mon, 26 Aug 2019 17:03:50 +0200
From:   Jan Kara <jack@suse.cz>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        jack@suse.cz, adilger.kernel@dilger.ca
Subject: Re: [PATCH v5] ext4: fix potential use after free in system zone via
 remount with noblock_validity
Message-ID: <20190826150350.GH10614@quack2.suse.cz>
References: <1565869639-105420-1-git-send-email-yi.zhang@huawei.com>
 <20190825034000.GE5163@mit.edu>
 <20190826025612.GB4918@mit.edu>
 <33767946-1e6f-5165-94b3-46e2da15172f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33767946-1e6f-5165-94b3-46e2da15172f@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 26-08-19 16:31:41, zhangyi (F) wrote:
> On 2019/8/26 10:56, Theodore Y. Ts'o Wrote:
> > I added a missing rcu_read_lock() to prevent a suspicious RCU
> > warning when CONFIG_PROVE_RCU is enabled:
> > 
> > diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
> > index 003dc1dc2da3..f7bc914a74df 100644
> > --- a/fs/ext4/block_validity.c
> > +++ b/fs/ext4/block_validity.c
> > @@ -330,11 +330,13 @@ void ext4_release_system_zone(struct super_block *sb)
> >  {
> >  	struct ext4_system_blocks *system_blks;
> >  
> > +	rcu_read_lock();
> >  	system_blks = rcu_dereference(EXT4_SB(sb)->system_blks);
> >  	rcu_assign_pointer(EXT4_SB(sb)->system_blks, NULL);
> >  
> >  	if (system_blks)
> >  		call_rcu(&system_blks->rcu, ext4_destroy_system_zone);
> > +	rcu_read_unlock();
> >  }
> >  
> >  int ext4_data_block_valid(struct ext4_sb_info *sbi, ext4_fsblk_t start_blk,
> > 
> 
> Hi Ted，
> Sorry about missing this warning, I think switch to use:
>   system_blks = rcu_dereference_raw(EXT4_SB(sb)->system_blks);
> or
>   system_blks = rcu_dereference_protected(EXT4_SB(sb)->system_blks, true);
> is enough to fix this waring, am I missing something?

Proper fix for this is actually using:

 system_blks = rcu_dereference_protected(EXT4_SB(sb)->system_blks,
					 lockdep_is_held(&sb->s_umount));

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
