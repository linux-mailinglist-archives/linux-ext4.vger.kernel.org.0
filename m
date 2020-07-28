Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07531230ABB
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jul 2020 14:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbgG1M4o (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Jul 2020 08:56:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:35466 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729234AbgG1M4o (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 28 Jul 2020 08:56:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 163D2AD3A;
        Tue, 28 Jul 2020 12:56:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 941B51E12C7; Tue, 28 Jul 2020 14:56:42 +0200 (CEST)
Date:   Tue, 28 Jul 2020 14:56:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     luomeng <luomeng12@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>
Subject: Re: [PATCH 3/6] ext4: Check journal inode extents more carefully
Message-ID: <20200728125642.GA23568@quack2.suse.cz>
References: <20200727114429.1478-1-jack@suse.cz>
 <20200727114429.1478-4-jack@suse.cz>
 <ec26732c-d219-8219-e7d6-63dab7aee03d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec26732c-d219-8219-e7d6-63dab7aee03d@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 28-07-20 17:10:28, luomeng wrote:
> 在 2020/7/27 19:44, Jan Kara 写道:
> > -int ext4_data_block_valid(struct ext4_sb_info *sbi, ext4_fsblk_t start_blk,
> > +int ext4_inode_block_valid(struct inode *inode, ext4_fsblk_t start_blk,
> >   			  unsigned int count)
> >   {
> >   	struct ext4_system_blocks *system_blks;
> > @@ -344,8 +346,8 @@ int ext4_data_block_valid(struct ext4_sb_info *sbi, ext4_fsblk_t start_blk,
> >   	 */
> >   	rcu_read_lock();
> >   	system_blks = rcu_dereference(sbi->system_blks);
> Because of a change in the function parameters，there is no 'sbi' declared.
> So there will be a compile error:
> 
>   fs/ext4/block_validity.c: In function ‘ext4_inode_block_valid’:
>   fs/ext4/block_validity.c:345:32: error: ‘sbi’ undeclared (first use
> in this function)
>   system_blks = rcu_dereference(sbi->system_blks);

Hum, right. It gets fixed up in the following patch but since this patch is
marked for stable, we better fix it. Thanks for noticing!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
