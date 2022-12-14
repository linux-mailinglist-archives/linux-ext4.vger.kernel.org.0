Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419BE64CFB9
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Dec 2022 19:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238882AbiLNSxN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Dec 2022 13:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238888AbiLNSxJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Dec 2022 13:53:09 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2F22A266
        for <linux-ext4@vger.kernel.org>; Wed, 14 Dec 2022 10:53:07 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2BEIqWia025765
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 13:52:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1671043955; bh=PXsiFJqJ8oqgbqWenICFQ+gyKBQKNHp783KPc0/O0nA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=CYuxsDPFTT7vFRYwWv4lhDgabezvNfLPumuo6pPbA1fqSIOd7wPD+N8E7sB8Cy9P5
         u+LqM81pK/EH9RIHUWYO8NqXJxAQzM6mjdK57aiROX5oWM3KuqZQc4sykXBpTU2I0n
         uVGXoUwtciFg5deaBLbliDiN+/rxzN2KreK9XyvfZw4CHAS2tQHGPTx0dkV4CAoXNj
         C2iziKVRBCVyb2DT7e1saQOKicX9fLJsan4j6L5ZJZe6FDXwLbbBcS+7tmqr0ecdgH
         i6MJASb+EC6+RvRMwYLwjbFAKL5os6xreVf4+4Zpa1niAd82veq2yCaFcGcy2b96AM
         u0C7wAKsqY+zg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A059515C40A2; Wed, 14 Dec 2022 13:52:32 -0500 (EST)
Date:   Wed, 14 Dec 2022 13:52:32 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Zhang Yi <yi.zhang@huawei.com>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, yi.zhang@huaweicloud.com,
        yukuai3@huawei.com
Subject: Re: [RFC PATCH] ext4: dio take shared inode lock when overwriting
 preallocated blocks
Message-ID: <Y5obcGLDZuw/NWOh@mit.edu>
References: <20221203103956.3691847-1-yi.zhang@huawei.com>
 <20221214170125.bixz46ybm76rtbzf@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214170125.bixz46ybm76rtbzf@quack3>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Dec 14, 2022 at 06:01:25PM +0100, Jan Kara wrote:
> 
> Besides some naming nits (see below) I think this should work. But I have
> to say I'm a bit uneasy about this because we will now be changing block
> mapping from unwritten to written only with shared i_rwsem. OTOH that
> happens during writeback as well so we should be fine and the gain is very
> nice.

Hmm.... when I was looking potential impacts of the change what
ext4_overwrite_io() would do, I looked at the current user of that
function in ext4_dio_write_checks().

	/*
	 * Determine whether the IO operation will overwrite allocated
	 * and initialized blocks.
	 * We need exclusive i_rwsem for changing security info
	 * in file_modified().
	 */
	if (*ilock_shared && (!IS_NOSEC(inode) || *extend ||
	     !ext4_overwrite_io(inode, offset, count))) {
		if (iocb->ki_flags & IOCB_NOWAIT) {
			ret = -EAGAIN;
			goto out;
		}
		inode_unlock_shared(inode);
		*ilock_shared = false;
		inode_lock(inode);
		goto restart;
	}

	ret = file_modified(file);
	if (ret < 0)
		goto out;

What is confusing me is the comment, "We need exclusive i_rwsem for
changing security info in file_modified().".  But then we end up
calling file_modified() unconditionally, regardless of whether we've
transitioned from a shared lock to an exclusive lock.

So file_modified() can get called either with or without the inode
locked r/w.  I realize that this patch doesn't change this
inconsistency, but it appears either the comment is wrong, or the code
is wrong.

What am I missing?

						- Ted
