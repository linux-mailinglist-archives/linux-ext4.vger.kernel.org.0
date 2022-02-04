Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676654A987D
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Feb 2022 12:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358443AbiBDLgl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Feb 2022 06:36:41 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:39036 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358414AbiBDLgl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Feb 2022 06:36:41 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 622471F382;
        Fri,  4 Feb 2022 11:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643974600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fh0nJEwY/ujB8Cpe3jBB+d5pDmtJZ4609jxDunh4lko=;
        b=eujVGgZ7usIAItUPD7ygn7S7Lz7RyNo0y98cTXMV7aRHRkNfCsTFmtyIc3XWTTFMakY4LE
        Y33RGrg4GpBOvP9F/yZVpWIOZ3yH0/1oBIfIL+vWpqYDMwUe93/AB53XJmodpeX5NaG8wY
        lznTRmE5LyIjfVgWRbv9k4Q81A4talQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643974600;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fh0nJEwY/ujB8Cpe3jBB+d5pDmtJZ4609jxDunh4lko=;
        b=Z1fxWkq5GEyZPTA9etiNG0V1dsYHgjJRICAxfEkcBYLElyFXtH7pzk0XHqVq2HGMkPAYQj
        JAftqJFlvaxNxQCw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4BF87A3B85;
        Fri,  4 Feb 2022 11:36:40 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BC1D9A05B6; Fri,  4 Feb 2022 12:36:39 +0100 (CET)
Date:   Fri, 4 Feb 2022 12:36:39 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Xin Yin <yinxin.x@bytedance.com>, harshadshirwadkar@gmail.com,
        tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: Re: [External] Re: [PATCH 1/2] ext4: use ext4_ext_remove_space() for
 fast commit replay delete range
Message-ID: <20220204113639.gxz2giovjegnf62g@quack3.lan>
References: <20211223032337.5198-1-yinxin.x@bytedance.com>
 <20211223032337.5198-2-yinxin.x@bytedance.com>
 <20220201203359.owrnrfqydjloy7oq@riteshh-domain>
 <CAK896s4=o9cFFnh0KzhbXSSjWiDFoTqNx0ATzGNH8rxj19+1aw@mail.gmail.com>
 <20220203211416.5jjdkk7pdaahignw@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203211416.5jjdkk7pdaahignw@riteshh-domain>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 04-02-22 02:44:16, Ritesh Harjani wrote:
> Ok, so I now know why the inode->i_size is 0 during replay phase (for file foo).
> This is because inode->i_disksize is not really updated until after the
> ext4_writepages() kicks in, which in this case, won't happen (for file foo)
> when we are doing fsync on file bar. And hence fsync on file bar won't also
> not ensure the delalloc blocks for file foo get's written out.
> 
> In fact this above information was something that I was assuming it all
> wrong.  Earlier I was of the opinion that fast_commit still pushes _all_
> the dirty pagecache data of other files to disk too (which is incorrect)
> and the only performance gains happens via less writes to disk (since we
> write less metadata on disk).
> 
> But I think what really happens is - In case of fast_commit when fsync is
> called on any file (say bar), apart from that file's (bar) dirty data, it
> only writes the necessary required metadata information of the blocks of
> others files (in this case file foo) which are already allocated.  (which
> in this case was due to fzero operation).  It does not actually allocate
> the delalloc blocks due to buffered writes of any other file (other than
> for file on which fsync is called).

Yes, but that is exactly what also happens for normal commit. I.e. even
without fastcommits, if we fsync(2), we will flush out data for that file
but for all the other files, buffered data still stays in delalloc state in
the page cache. Following journal commit will thus write all metadata (and
wait for data) of the fsynced files but not for any other file that has
only delalloc blocks. If writeback of some other file also happened before
we commit, then yes, we include all the changes to the commit as well.

> This happens in
> ext4_fc_perform_commit() -> ext4_fc_submit_inode_data_all() ->
> jbd2_submit_inode_data -> jbd2_journal_submit_inode_data_buffers() ->
> generic_writepages() -> using writepage() which won't do block allocation for
> delalloc blocks.
> 
> So that above is what should give the major performance boost with fast_commit
> in case of multiple file writes doing fsync. :)
> 
> @Jan/Harshad - could you please confirm if above is correct?

What you describe is correct but not special to fastcommit. As I mentioned
on the call yesterday, fastcommit is currently beneficial only because the
logical logging it does ends up writing much less blocks to the journal.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
