Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5285721BBF
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Jun 2023 03:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbjFEB63 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 4 Jun 2023 21:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjFEB61 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 4 Jun 2023 21:58:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A28AA8;
        Sun,  4 Jun 2023 18:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wC+YS5iexjcPmnd0LhKEcR1bxSk2EiG8FY9J+0419zw=; b=CdYz/lh3v8FUDJGFXRaV6b6zUf
        lr2JvPjaG9pEQstokXnlcDC6FvNTfhHdF95W1s0GpoVAJyelX4QKUxq68IFhP9NkW02GKPeGDF6Ts
        NrMuUq+XKxul8JLiql7arQ1EmOb24mK/XQz0kKISZj9bWYxKRgGYJYDC9mT9pN7UrBDit0ubNA7Tq
        63ODAapxgX29F6G/4iowbHbr9SJrDA6aQDIhcu9+qGjsgeO6kexx9wFv5VCi0xA9UfiHQ2qKUdsyM
        4mkVr50koIPD8aoe+VvnycR2T567TDhxmQzECgHuFm/UtUIauqwICYS5sz6vQRwfNTx30yxhyrY2+
        f4pst9Hw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q5zU7-00BYKK-Ft; Mon, 05 Jun 2023 01:58:15 +0000
Date:   Mon, 5 Jun 2023 02:58:15 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, jun.nie@linaro.org,
        ebiggers@kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
        yukuai3@huawei.com,
        syzbot+a158d886ca08a3fecca4@syzkaller.appspotmail.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] ext4: fix race condition between buffer write and
 page_mkwrite
Message-ID: <ZH1BN+H1/Sa4eLQ4@casper.infradead.org>
References: <20230530134405.322194-1-libaokun1@huawei.com>
 <20230604030445.GF1128744@mit.edu>
 <20230604210821.GA1257572@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230604210821.GA1257572@mit.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Jun 04, 2023 at 05:08:21PM -0400, Theodore Ts'o wrote:
> On Sat, Jun 03, 2023 at 11:04:45PM -0400, Theodore Ts'o wrote:
> > I tried testing to see if this fixed [1], and it appears to be
> > triggering a lockdep warning[2] at this line in the patch:
> > 
> > [1] https://syzkaller.appspot.com/bug?extid=f4582777a19ec422b517
> > [2] https://syzkaller.appspot.com/x/report.txt?x=17260843280000
> 
> Looking at this more closely, the fundamental problem is by the time
> ext4_file_mmap() is called, the mm layer has already taken
> current->mm->mmap_lock, and when we try to take the inode_lock, this
> causes locking ordering problems with how buffered write path works,
> which take the inode_lock first, and then in some cases, may end up
> taking the mmap_lock if there is a page fault for the buffer used for
> the buffered write.
> 
> If we're going to stick with the approach in this patch, I think what
> we would need is to add a pre_mmap() function to file_operations
> struct, which would get called by the mmap path *before* taking
> current->mm->mmap_lock, so we can do the inline conversion before we
> take the mmap_lock.
> 
> I'm not sure how the mm folks would react to such a proposal, though.
> I could be seen as a bit hacky, and it's not clear that any file
> system other than ext4 would need something like this.  Willy, as
> someone who does a lot of work in both mm and fs worlds --- I'm
> curious what you think about this idea?

I'm probably missing something here, but why do we need to convert inline
data in page_mkwrite?  mmap() can't change i_size (stores past i_size are
discarded), so we should be able to simply copy the data from the page
cache into the inode and write the inode when it comes to writepages()
time.

Unless somebody does a truncate() or write() that expands i_size, but we
should be able to do the conversion then without the mmap_lock held.  No?
I'm not too familiar with inline data.
