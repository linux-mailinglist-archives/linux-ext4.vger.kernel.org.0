Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F83772257F
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Jun 2023 14:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjFEMWM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Jun 2023 08:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjFEMWJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Jun 2023 08:22:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF32EEA;
        Mon,  5 Jun 2023 05:21:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D092C1F8C1;
        Mon,  5 Jun 2023 12:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685967701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+xYIiqrQfOeCGvbrMjYIUOsP4rm9alei4PdeDzJkJKI=;
        b=p8VVrJF19JBks7boZVrB42nnbFvYwZ+5bmhw7LioiONvZQPr8LgEowiMFCkkMOO8Rs7h43
        M7s57mc7MvHTcLmhGE8sU4oKZyhJBNnjxPpR+4SCF3HXnLhT87C8q3LLj856nIgKx8XF3Z
        95taV9BK3SVpXqArhZ62DYkI8IugYy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685967701;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+xYIiqrQfOeCGvbrMjYIUOsP4rm9alei4PdeDzJkJKI=;
        b=QuAiZvJbPY0ReJb/mlmXC00Y52+59Kx0/pxUSswr72T5lQek1Go2Gv1xX0RE858/H5n+Gf
        e8W/goTtClvWiSDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD8BA139C7;
        Mon,  5 Jun 2023 12:21:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7K8+LlXTfWSQDQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 05 Jun 2023 12:21:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3CC7BA0754; Mon,  5 Jun 2023 14:21:41 +0200 (CEST)
Date:   Mon, 5 Jun 2023 14:21:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, Baokun Li <libaokun1@huawei.com>,
        linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        jun.nie@linaro.org, ebiggers@kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com,
        syzbot+a158d886ca08a3fecca4@syzkaller.appspotmail.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] ext4: fix race condition between buffer write and
 page_mkwrite
Message-ID: <20230605122141.4njwwx3mrapqhvt4@quack3>
References: <20230530134405.322194-1-libaokun1@huawei.com>
 <20230604030445.GF1128744@mit.edu>
 <20230604210821.GA1257572@mit.edu>
 <ZH1BN+H1/Sa4eLQ4@casper.infradead.org>
 <20230605091655.24vl5fjesfskt3o5@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605091655.24vl5fjesfskt3o5@quack3>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 05-06-23 11:16:55, Jan Kara wrote:
> On Mon 05-06-23 02:58:15, Matthew Wilcox wrote:
> > On Sun, Jun 04, 2023 at 05:08:21PM -0400, Theodore Ts'o wrote:
> > > On Sat, Jun 03, 2023 at 11:04:45PM -0400, Theodore Ts'o wrote:
> > > > I tried testing to see if this fixed [1], and it appears to be
> > > > triggering a lockdep warning[2] at this line in the patch:
> > > > 
> > > > [1] https://syzkaller.appspot.com/bug?extid=f4582777a19ec422b517
> > > > [2] https://syzkaller.appspot.com/x/report.txt?x=17260843280000
> > > 
> > > Looking at this more closely, the fundamental problem is by the time
> > > ext4_file_mmap() is called, the mm layer has already taken
> > > current->mm->mmap_lock, and when we try to take the inode_lock, this
> > > causes locking ordering problems with how buffered write path works,
> > > which take the inode_lock first, and then in some cases, may end up
> > > taking the mmap_lock if there is a page fault for the buffer used for
> > > the buffered write.
> > > 
> > > If we're going to stick with the approach in this patch, I think what
> > > we would need is to add a pre_mmap() function to file_operations
> > > struct, which would get called by the mmap path *before* taking
> > > current->mm->mmap_lock, so we can do the inline conversion before we
> > > take the mmap_lock.
> > > 
> > > I'm not sure how the mm folks would react to such a proposal, though.
> > > I could be seen as a bit hacky, and it's not clear that any file
> > > system other than ext4 would need something like this.  Willy, as
> > > someone who does a lot of work in both mm and fs worlds --- I'm
> > > curious what you think about this idea?
> > 
> > I'm probably missing something here, but why do we need to convert inline
> > data in page_mkwrite?  mmap() can't change i_size (stores past i_size are
> > discarded), so we should be able to simply copy the data from the page
> > cache into the inode and write the inode when it comes to writepages()
> > time.
> > 
> > Unless somebody does a truncate() or write() that expands i_size, but we
> > should be able to do the conversion then without the mmap_lock held.  No?
> > I'm not too familiar with inline data.
> 
> Yeah, I agree, that is also the conclusion I have arrived at when thinking
> about this problem now. We should be able to just remove the conversion
> from ext4_page_mkwrite() and rely on write(2) or truncate(2) doing it when
> growing i_size.

OK, thinking more about this and searching through the history, I've
realized why the conversion is originally in ext4_page_mkwrite(). The
problem is described in commit 7b4cc9787fe35b ("ext4: evict inline data
when writing to memory map") but essentially it boils down to the fact that
ext4 writeback code does not expect dirty page for a file with inline data
because ext4_write_inline_data_end() should have copied the data into the
inode and cleared the folio's dirty flag.

Indeed messing with xattrs from the writeback path to copy page contents
into inline data xattr would be ... interesting. Hum, out of good ideas for
now :-|.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
