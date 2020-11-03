Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1813F2A4BFB
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Nov 2020 17:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgKCQwi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Nov 2020 11:52:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:33086 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727901AbgKCQwi (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 3 Nov 2020 11:52:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7095AB240;
        Tue,  3 Nov 2020 16:52:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3B75E1E12FB; Tue,  3 Nov 2020 17:52:37 +0100 (CET)
Date:   Tue, 3 Nov 2020 17:52:37 +0100
From:   Jan Kara <jack@suse.cz>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz
Subject: Re: [PATCH 07/10] ext4: misc fast commit fixes
Message-ID: <20201103165237.GK3440@quack2.suse.cz>
References: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
 <20201031200518.4178786-8-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031200518.4178786-8-harshadshirwadkar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 31-10-20 13:05:15, Harshad Shirwadkar wrote:
> This patch adds a small number of misc fast commit fixes. Along with
> functional fixes such as setting the right buffer flags, there also
> typo fixes and comment additions.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Again, please don't merge logically separate fixes into one commit.

> diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
> index 00dc668e052b..10855cd230c7 100644
> --- a/fs/ext4/ext4_jbd2.h
> +++ b/fs/ext4/ext4_jbd2.h
> @@ -422,9 +422,13 @@ static inline int ext4_journal_force_commit(journal_t *journal)
>  static inline int ext4_jbd2_inode_add_write(handle_t *handle,
>  		struct inode *inode, loff_t start_byte, loff_t length)
>  {
> -	if (ext4_handle_valid(handle))
> +	if (ext4_handle_valid(handle)) {
> +		ext4_fc_track_range(handle, inode,
> +			start_byte >> inode->i_sb->s_blocksize_bits,
> +			(start_byte + length) >> inode->i_sb->s_blocksize_bits);
>  		return jbd2_journal_inode_ranged_write(handle,
>  				EXT4_I(inode)->jinode, start_byte, length);
> +	}

Why this change? A good changelog would tell me... I'm suspicious here
because ext4_jbd2_inode_add_write() gets called only in data=ordered mode
but fastcommit can run also in data=writeback mode...

I suppose this is for the mmap coverage we were speaking about. Now that
I'm speaking about it again maybe the ext4_fc_track_range() call in
ext4_map_blocks() is actually enough? I mean once we allocate blocks for a
range (either from page fault, write, or writeback of delalloc), they will
become properly tracked in ext4_map_blocks() and that's all we need? But
then I'm missing why we have so many ext4_fc_track_range() calls around the
code... Can you please explain?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
