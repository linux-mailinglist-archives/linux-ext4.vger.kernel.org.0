Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695A5523510
	for <lists+linux-ext4@lfdr.de>; Wed, 11 May 2022 16:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244421AbiEKOJj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 May 2022 10:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244423AbiEKOJh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 May 2022 10:09:37 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4939E69B5F;
        Wed, 11 May 2022 07:09:36 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24BE9Gjr002743
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 10:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652278159; bh=G8lq57C33xdM0wjJu4yfZma67g+kI57dmaN+DwjnBFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=VfgBhpdTnTp/WHZyVCzqSg2j1jHJwp4KLsOmzy+xtpRM2YUztUSbc0YRwNW74f6QL
         eqnpmmjwDJUgN3abtPmKvL7cssA7tI1bHUQS3dFFE+w6cFU6cvnyUC/1ppqd18I0pe
         NGmjm7Mkwo8GcDSDFZU2wE9dds/EE/z8Ahq1S+9uXiKyX7Nbn6itzG8zyVADzPJ4Y0
         8z05XLqXtIEHPEQug4yKUaAD2p+4RUxWwemKy+uVciYzeL9z09xviGyISRtDlnfJnV
         xGOY6+0DUpreDW7+/9oaU/gJv+vXmSkpmpI9jcruw8RBwv+N9fkordUwypKNmsvthh
         TGnSvrZCxElSg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0868615C3F0C; Wed, 11 May 2022 10:09:16 -0400 (EDT)
Date:   Wed, 11 May 2022 10:09:16 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     yebin <yebin10@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        lczerner@redhat.com
Subject: Re: [PATCH -next] ext4: fix warning in ext4_handle_inode_extension
Message-ID: <YnvDjHFAeZWEDne1@mit.edu>
References: <20220326065351.761952-1-yebin10@huawei.com>
 <20220329092810.j5ngxckygut6mxo2@quack3.lan>
 <6244482D.4090603@huawei.com>
 <20220330133015.yxfnnw564wgehjc3@quack3.lan>
 <62578B0C.9000803@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62578B0C.9000803@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 14, 2022 at 10:46:36AM +0800, yebin wrote:
> To be honest, I don't know syzkaller how to inject the NOMEM
> fault. If syzkaller rely on the memory fault injection mode provided
> by the kernel, should report null pointer access. Anyway, If inject
> a single point of IO fault, we still have to face the same
> situation.

Was this patch in response to a syzkaller report?  There wasn't a
Reported-by tag indicating that this came from syzkaller.  If it did,
and it came from syzkaller run by the syzkaller team (e.g., at
https://syzkaller.appspot.com/upstream) could you include a reference
to the syzkaller report?

> On 2022/3/30 21:30, Jan Kara wrote:
> > > Do you mean call jbd2_abort in ext4_reserve_inode_write() ?
> > Yes.
> > 
> > > If we abort journal when metadata is not guaranteed to be consistent. The
> > > mode of ‘errors=continue’ is unnecessary.
> > Well, firstly, errors=continue was always the best effort. There are no
> > guarantees which failures we are able to withstand and which not.

That's true; however, in general, if we can back out and recover from
the error, we should, so that errors=continue can work.  If we think
that continuing will result in far more file system corruption and/or
the error is from the journalling infrastructure itself, then aborting
the journal makes sense.

> > There are
> > almost 80 callsites of ext4_mark_inode_dirty() and honestly I suspect that
> > e.g. inconsistent states resulting from extent tree manipulations being
> > aborted in the middle due to ext4_ext_dirty() failing due to ENOMEM will
> > also trigger all sorts of "interesting" behavior. So that's why I'd rather
> > abort the journal than try to continue when we almost certainly now we
> > cannot.

It would not be a bad thing for us to audit all of the callers of
ext4_mark_inode_dirty() and ext4_reserve_inode_write().  We are
getting things right in at least some of the callers (for example:
ext4_mkdir).

In any case, I'll take this patch, but if this was in response to a
syzkaller report, please let me know with the syzkaller ID is, so I
can update the commit before I send a pull request to Linus.

Thanks!

							- Ted
							
