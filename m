Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9A65A9ABD
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Sep 2022 16:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbiIAOpj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Sep 2022 10:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbiIAOpi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Sep 2022 10:45:38 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354665EDE6;
        Thu,  1 Sep 2022 07:45:35 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 281EjFOD004671
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Sep 2022 10:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1662043518; bh=bpdZctrJ7OUX89e0S3lWbLtS591k81nuNM5uHLftVZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=bxWbk2rUOq9nJo9jirI8Hotsuvah16gBPIibrkdVIQmDdk8S+CGmgXCYwkK2luRfK
         cqzwBAJy3TXwBIqZSa4gEdQDQLQeFqHdFF6wGJCMlo2L5RwvBU2teceH4ay09r9X9X
         y9N6XdLBmsKyOkjlJO+Ds0foEUpQpPaRtDBgI0qhYlPjmEbI1cp5K9UrAwuxUxb95h
         7XSHkHVxdWNweLKuf5q2JFc2ipLGBzKox6ZkS2uqSq4frDmglBA8LxgWJZI9VDy+cU
         KPdgMgUv1iQOm0lM96YK+Pm5Rb4gXx6Oq/s0bVuBBsJc+QbN587jLrBRsVnWJeaTQ+
         CtffHOlilmNrw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A1E7915C525C; Thu,  1 Sep 2022 10:45:15 -0400 (EDT)
Date:   Thu, 1 Sep 2022 10:45:15 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, Ye Bin <yebin10@huawei.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ext4: ensure data forced to disk when rename
Message-ID: <YxDFewyU6orvSfZX@mit.edu>
References: <20220901062657.1192732-1-yebin10@huawei.com>
 <20220901083706.mjewb45dufzxcfdk@quack3>
 <ce8666e2-c224-79f9-7770-f87b31d122e3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce8666e2-c224-79f9-7770-f87b31d122e3@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 01, 2022 at 09:19:04PM +0800, Zhang Yi wrote:
> 
> Our case is modifing a no-empty file names "data.conf" through vim, it will
> cp "data.conf" to ".data.conf.swp" firstly, overwrite rename ".data.conf.swp"
> back to "data.conf" and fsync after modifying. If we power down between rename
> and fsync, we may lose all data in the original "data.conf" and get a whole
> zero file. Before we enable dioread_nolock by defalut, the newly appending data
> may lost, but at least we will not lose the original data in the default
> data=ordered and auto_da_alloc mode. It seems that dioread_nolock breaks the
> guarantee provide by auto_da_alloc. Maybe we should add a fsync before rename
> in vim ?

What I normally recommend is to write the new contents of "data.conf"
to "data.conf.new".  Then fsync the file descriptor corresponding to
data.conf.new.  If you want to backup data.conf, you can create a hard
link of data.conf to data.conf.bak, then rename data.conf.new on top
of data.conf.

The auto_da_alloc mode is a best effort attempt to protect against bad
application programs, and it never was a guarantee that it would
*always* protect against data loss if you had a overwriting rename
racing against a power failure.  Without auto_da_alloc mode, the
window where the user might lose data if they application failed to do
the fsync() was 30 seconds.  With auto_da_alloc (and if dioread_nolock
was disabled), that window was reduced to say, a few hundred
milliseconds.  With dioread_nolock, that window was increased to
somehwere between 0 and 5 seconds (on average, 2.5 seconds) plus the
time for the write to complete (a few hundred milliseconds).

But note that your proposed patch doesn't actually really improve
things all that much.  That's because calling filemap_datawrite() only
waits for the write request to complete.  But you still need to update
the metadata before the blocks become visible after a crash.  That
requires forcing a journal commit, and waiting for that commit to
complete, which is what ext4_sync_file() does, and which is of course,
quite expensive.

We could add something to the end of ext4_convert_unwritten_io_end_vec()
where if the inode is da_alloc eligible, we trigger an asynchronous
journal commit; that is, once we converted all of the unwritten extents,
if the file has been closed after being opened with O_TRUNC, or the file has
been renamed on top of a pre-existing file and there were dirty blocks
that were flushed out when we called ext4_alloc_da_blocks(), that
ext4_convert_unwritten_io_end_vec() would then request that a journal
commit be started.   But we'd want to see what sort of performance regression
this adds, since nothing is for free, and the goal here is to paper over
buggy applications without imposing too much of a performance cost.

But it should be clear that this is *buggy* applications, and
applications SHOULD be calling fsync() before an overwriting rename()
if they care about data not being lost if there is a power failure at
an inconvenient point.   All we are trying to do here is to reduce the
probability of data loss caused by buggy applications.  There was never
any guarantees.

Cheers,

						- Ted
