Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB28E7229F5
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Jun 2023 16:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjFEOzu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Jun 2023 10:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbjFEOzt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Jun 2023 10:55:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ECF100;
        Mon,  5 Jun 2023 07:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EIjfoz6g1gSMBUIR961WfAaXS+akTFpOzeX6mFz37DM=; b=t9qPJolzjZuCqGsWmE1NXO/SiW
        RD26M548la/p6QtIIuuWUKrKX0ORTDZheJ6Q+l3LQlAtUcu8Cqs2CykyJETvnCNfecnEAwnDkwVM0
        XBJeHPo301VcryR2R8EG8lOpqV1FBoT8mE4VQAO8jz4hQtVVi2zn/NbIhzOw4s+YZLxMtDefmHNZz
        8EjfqvG7p6KzAe1MFI7mL56fGe21L4eRRBlJhwKxt4BXZEycmX7iU1SzEfHtEJ9Mf6wLaiLQz4qxm
        GsCXu5g42rE+Gp4kxktDSp6h6mn+WkuDS08ZjQWNJRuveW/DrjF2NwZa84FjGQWSNTanpqVqoliLl
        FOdb0z7Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6BcN-00C7Zq-R5; Mon, 05 Jun 2023 14:55:35 +0000
Date:   Mon, 5 Jun 2023 15:55:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Theodore Ts'o <tytso@mit.edu>, Baokun Li <libaokun1@huawei.com>,
        linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        jun.nie@linaro.org, ebiggers@kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com,
        syzbot+a158d886ca08a3fecca4@syzkaller.appspotmail.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] ext4: fix race condition between buffer write and
 page_mkwrite
Message-ID: <ZH33ZzwyLFY48tfA@casper.infradead.org>
References: <20230530134405.322194-1-libaokun1@huawei.com>
 <20230604030445.GF1128744@mit.edu>
 <20230604210821.GA1257572@mit.edu>
 <ZH1BN+H1/Sa4eLQ4@casper.infradead.org>
 <20230605091655.24vl5fjesfskt3o5@quack3>
 <20230605122141.4njwwx3mrapqhvt4@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605122141.4njwwx3mrapqhvt4@quack3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 05, 2023 at 02:21:41PM +0200, Jan Kara wrote:
> On Mon 05-06-23 11:16:55, Jan Kara wrote:
> > Yeah, I agree, that is also the conclusion I have arrived at when thinking
> > about this problem now. We should be able to just remove the conversion
> > from ext4_page_mkwrite() and rely on write(2) or truncate(2) doing it when
> > growing i_size.
> 
> OK, thinking more about this and searching through the history, I've
> realized why the conversion is originally in ext4_page_mkwrite(). The
> problem is described in commit 7b4cc9787fe35b ("ext4: evict inline data
> when writing to memory map") but essentially it boils down to the fact that
> ext4 writeback code does not expect dirty page for a file with inline data
> because ext4_write_inline_data_end() should have copied the data into the
> inode and cleared the folio's dirty flag.
> 
> Indeed messing with xattrs from the writeback path to copy page contents
> into inline data xattr would be ... interesting. Hum, out of good ideas for
> now :-|.

Is it so bad?  Now that we don't have writepage in ext4, only
writepages, it seems like we have a considerably more benign locking
environment to work in.
