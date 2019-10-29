Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5717E9229
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Oct 2019 22:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfJ2VgA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Oct 2019 17:36:00 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48998 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728437AbfJ2VgA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 29 Oct 2019 17:36:00 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9TLZrLY012252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Oct 2019 17:35:54 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6A96E420456; Tue, 29 Oct 2019 17:35:53 -0400 (EDT)
Date:   Tue, 29 Oct 2019 17:35:53 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Xiaohui1 Li =?utf-8?B?5p2O5pmT6L6J?= <lixiaohui1@xiaomi.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "harshadshirwadkar@gmail.com" <harshadshirwadkar@gmail.com>
Subject: Re: [PATCH v3 09/13] ext4: fast-commit commit path changes
Message-ID: <20191029213553.GD4404@mit.edu>
References: <1571900042725.99617@xiaomi.com>
 <20191024201800.GE1124@mit.edu>
 <1572349386604.43878@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1572349386604.43878@xiaomi.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 29, 2019 at 11:43:54AM +0000, Xiaohui1 Li 李晓辉 wrote:
> > We don't actually have to do this.  Strictly speaking, we only have to
> > write out the specific inode being fsync'ed, or the specific inode for
> > which ext4_nfs_commit_metdata() has been called.  For an fsync()
> > workload, especially one where for example, we might have hundreds of
> > modified inodes, all of which are fc-eligible --- for example, because
> > a kernel build is happening in the background, and a single file which
> > is being fsync'ed --- for example because the programmer has just
> > saved a source file in emacs ---- we only need to include that single
> > inode in the fast commit.  Including *all* of the inodes in the
> > i_fc_list in the fast commit, is wasted effort, especially since the
> > inodes in question will be committed within the next 5 seconds.
> 
> you said only need to include that single inode in the fast commit.
> do you mean that create a fast-commit transaction which only need to
> commit data and metadata of the specific inode ?  but in your last
> email, you says "we can't just separate out some of the handles from
> others in one transation".
> 
> so if we just only include that single inode(ie: being fsync'ed) in
> the fast commit, is it means that in the ext4 traditional way，
> metadata of this single inode being fsync'ed need to be mixed with
> other inodes not being fsync'ed (may doing buffer write) together in
> one transaction to be flushed to disk both together because of
> entagled dependencies you says in your last reply email.
> 
> but when fast-commit patches applied, how the metadata and data of
> this single inode being fsync'ed can be extracted from all files
> metadata changes during one time range ？

Did you read the iJournaling Usenix paper[1] which I referenced
earlier?  It's described in there.

[1] https://www.usenix.org/conference/atc17/technical-sessions/presentation/park

The trick is that we track whether the inode has changes which we
can't represent in the fast commit "logical journal".  In the logical
journal, we record changes since the last full commit, not as the full
physical metadata block, but just bits of the logical metadata that
have changed.  If that inode has changed in ways that we can't
represent in the fast commit journal, then we do a normal full commit.

So we avoid entangled dependencies in two ways .  First of all, we
only journal the logical change.  Hence, if there is a change in
another part of the metadata block (say, another inode in the inode
table) there won't be an issue, since we only update that one inode.
Secondly, if the inode has some entangelements either with other
inodes, or (b) changes in the inode which we can't reflect in the fast
commit log, then fall back to doing a full commit.

So basically, we only deal with the simple, common cases, where it's
easy to log changes to the fast commit log.  Now, those changes are
also logged in the normal physical commit, so once we do a full
commit, all of the entries in the fast commit log are no longer needed
--- the fast commit just contains the small, simple changes since the
last full commit.

Cheers,

						- Ted
