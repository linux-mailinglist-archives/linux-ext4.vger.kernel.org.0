Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24143BDA26
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jul 2021 17:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbhGFP3T (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jul 2021 11:29:19 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35820 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbhGFP3N (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Jul 2021 11:29:13 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1CFE31FFA1;
        Tue,  6 Jul 2021 15:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625585194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GO8P9j/Qx1r/Fw2fHPUqY5uizkF03xwgO9/YCM/Vq6Y=;
        b=2c7N5CSt2tRA/IUy0k8+oK2li4cfQxmi468GB5YVuUDwnP52Bj2ClSK9E11UMlB3/bUSDC
        tJu5MY75SlCZ9zE3TUlMjpawXBVF1XvkVLkxHpABoGOP9O3FJKHfMNhkBFNCfRDtiWORom
        V5ppCIIxUCTpoDnrDWOajg0qYewC7Eo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625585194;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GO8P9j/Qx1r/Fw2fHPUqY5uizkF03xwgO9/YCM/Vq6Y=;
        b=yTK6sTfemmt3W4uBSFfXjuVJPsfu+42vUF82ee5E4t79lyeW+MwlfSzhmWDco2nkqXQkT3
        BiYUSW+i4ZQFdfCA==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 04C1FA3B8A;
        Tue,  6 Jul 2021 15:26:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D19C41F2CB9; Tue,  6 Jul 2021 17:26:33 +0200 (CEST)
Date:   Tue, 6 Jul 2021 17:26:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, yukuai3@huawei.com
Subject: Re: [RFC PATCH 1/4] ext4: check and update i_disksize properly
Message-ID: <20210706152633.GB17149@quack2.suse.cz>
References: <20210706024210.746788-1-yi.zhang@huawei.com>
 <20210706024210.746788-2-yi.zhang@huawei.com>
 <20210706121123.GB7922@quack2.suse.cz>
 <32946f62-631e-d752-9fcf-e89b568e2e7f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32946f62-631e-d752-9fcf-e89b568e2e7f@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 06-07-21 22:40:46, Zhang Yi wrote:
> On 2021/7/6 20:11, Jan Kara wrote:
> > On Tue 06-07-21 10:42:07, Zhang Yi wrote:
> >> After commit 3da40c7b0898 ("ext4: only call ext4_truncate when size <=
> >> isize"), i_disksize could always be updated to i_size in ext4_setattr(),
> >> and it seems that there is no other way that could appear
> >> i_disksize < i_size besides the delalloc write. In the case of delay
> > 
> > Well, there are also direct IO writes which have temporarily i_disksize <
> > i_size but when you hold i_rwsem, you're right that delalloc is the only
> > reason why you can see i_disksize < i_size AFAIK.
> > 
> >> alloc write, ext4_writepages() could update i_disksize for the new delay
> >> allocated blocks properly. So we could switch to check i_size instead
> >> of i_disksize in ext4_da_write_end() when write to the end of the file.
> > 
> > I agree that since ext4_da_should_update_i_disksize() needs to return true
> > for us to touch i_disksize, writeback has to have already allocated block
> > underlying the end of write (new_i_size position) and thus we are
> > guaranteed that writeback will also soon update i_disksize after the
> > new_i_size position. So I agree that your switch to testing i_size instead
> > of i_disksize should not have any bad effect... Thinking about this some
> > more why do we need i_disksize update in ext4_da_write_end() at all? The
> > page will be dirtied and when writeback will happen we will update
> > i_disksize to i_size. Updating i_disksize earlier brings no benefit - the user
> > will see zeros instead of valid data if we crash before the writeback
> > happened. Am I missing something guys?
> > 
> 
> Hi, Jan.
> 
> Do you remember the patch and question I asked 2 years ago[1][2]? The
> case of new_i_size > i_size && ext4_da_should_update_i_disksize() here
> means partial block append write,

Agreed.

> ext4_writepages() does not update i_disksize for this case now.

Doesn't it? Hmm, so mpage_map_and_submit_extent() certainly does make sure
we update i_size properly. But you are actually correct that
ext4_writepage() does not update i_disksize and neither does
mpage_prepare_extent_to_map() which can also writeback fully mapped pages.
Changing mpage_prepare_extent_to_map() to handle i_disksize update would be
trivial but dealing with ext4_writepage() would be difficult. So yes, let's
keep the i_disksize update in ext4_da_write_end() for now. But please add a
comment there explaining the situation. Like:

	/*
	 * Since we are holding inode lock, we are sure i_disksize <=
	 * i_size. We also know that if i_disksize < i_size, there are
	 * delalloc writes pending in the range upto i_size. If the end of
	 * the current write is <= i_size, there's no need to touch
	 * i_disksize since writeback will push i_disksize upto i_size
	 * eventually. If the end of the current write is > i_size and
	 * inside an allocated block (ext4_da_should_update_i_disksize()
	 * check), we need to update i_disksize here as neither
	 * ext4_writepage() nor certain ext4_writepages() paths not
	 * allocating blocks update i_disksize.
	 *
	 * Note that we defer inode dirtying to generic_write_end() /
	 * ext4_da_write_inline_data_end().
	 */

> And the journal data=ordered mode also
> cannot guarantee write data before metadata. So we cannot guarantee we
> cannot see zeros where data was written after crash.

Yes, but that is IMO somewhat different question.

								Honza

> 
> Thanks,
> Yi.
> 
> [1]https://lore.kernel.org/linux-ext4/20190404101823.GA22313@quack2.suse.cz/
> [2]https://lore.kernel.org/linux-ext4/20190405091258.GA1600@quack2.suse.cz/
> 
> > 
> >> we also could remove ext4_mark_inode_dirty() together because
> >> generic_write_end() will dirty the inode.
> >>
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> >> ---
> >>  fs/ext4/inode.c | 21 ++++++++-------------
> >>  1 file changed, 8 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> >> index d8de607849df..6f6a61f3ae5f 100644
> >> --- a/fs/ext4/inode.c
> >> +++ b/fs/ext4/inode.c
> >> @@ -3087,32 +3087,27 @@ static int ext4_da_write_end(struct file *file,
> >>  	 * generic_write_end() will run mark_inode_dirty() if i_size
> >>  	 * changes.  So let's piggyback the i_disksize mark_inode_dirty
> >>  	 * into that.
> >> +	 *
> >> +	 * Check i_size not i_disksize here because ext4_writepages() could
> >> +	 * update i_disksize from i_size for delay allocated blocks properly.
> >>  	 */
> >>  	new_i_size = pos + copied;
> >> -	if (copied && new_i_size > EXT4_I(inode)->i_disksize) {
> >> +	if (copied && new_i_size > inode->i_size) {
> >>  		if (ext4_has_inline_data(inode) ||
> >> -		    ext4_da_should_update_i_disksize(page, end)) {
> >> +		    ext4_da_should_update_i_disksize(page, end))
> >>  			ext4_update_i_disksize(inode, new_i_size);
> >> -			/* We need to mark inode dirty even if
> >> -			 * new_i_size is less that inode->i_size
> >> -			 * bu greater than i_disksize.(hint delalloc)
> >> -			 */
> >> -			ret = ext4_mark_inode_dirty(handle, inode);
> >> -		}
> >>  	}
> >>  
> >>  	if (write_mode != CONVERT_INLINE_DATA &&
> >>  	    ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA) &&
> >>  	    ext4_has_inline_data(inode))
> >> -		ret2 = ext4_da_write_inline_data_end(inode, pos, len, copied,
> >> +		ret = ext4_da_write_inline_data_end(inode, pos, len, copied,
> >>  						     page);
> >>  	else
> >> -		ret2 = generic_write_end(file, mapping, pos, len, copied,
> >> +		ret = generic_write_end(file, mapping, pos, len, copied,
> >>  							page, fsdata);
> >>  
> >> -	copied = ret2;
> >> -	if (ret2 < 0)
> >> -		ret = ret2;
> >> +	copied = ret;
> >>  	ret2 = ext4_journal_stop(handle);
> >>  	if (unlikely(ret2 && !ret))
> >>  		ret = ret2;
> >> -- 
> >> 2.31.1
> >>
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
