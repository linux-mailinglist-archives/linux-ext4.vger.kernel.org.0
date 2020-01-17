Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A74201412F9
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jan 2020 22:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgAQV1W (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jan 2020 16:27:22 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58709 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729235AbgAQV1V (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Jan 2020 16:27:21 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00HLQvqE015166
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jan 2020 16:26:59 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id AB7EF4207DF; Fri, 17 Jan 2020 16:26:57 -0500 (EST)
Date:   Fri, 17 Jan 2020 16:26:57 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Kai Li <li.kai4@h3c.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        gechangwei@live.cn, wang.yongd@h3c.com, wang.xibo@h3c.com
Subject: Re: [PATCH] jbd2: clear JBD2_ABORT flag before journal_reset to
 update log tail info when load journal
Message-ID: <20200117212657.GF448999@mit.edu>
References: <20200111022542.5008-1-li.kai4@h3c.com>
 <20200114103119.GE6466@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114103119.GE6466@quack2.suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jan 14, 2020 at 11:31:19AM +0100, Jan Kara wrote:
> Thanks for the patch! Just some small comments below:
> 
> On Sat 11-01-20 10:25:42, Kai Li wrote:
> > Fixes: 85e0c4e89c1b "jbd2: if the journal is aborted then don't allow update of the log tail"
> 
> This tag should come at the bottom of the changelog (close to your
> Signed-off-by).
> 
> > If journal is dirty when mount, it will be replayed but jbd2 sb
> > log tail cannot be updated to mark a new start because
> > journal->j_flags has already been set with JBD2_ABORT first
> > in journal_init_common.
> > When a new transaction is committed, it will be recorded in block 1
> > first(journal->j_tail is set to 1 in journal_reset). If emergency
> > restart again before journal super block is updated unfortunately,
> > the new recorded trans will not be replayed in the next mount.
> > It is danerous which may lead to metadata corruption for file system.
> 
> I'd slightly rephrase the text here so that it is more easily readable and
> correct some grammar mistakes. Something like:
> 
> If the journal is dirty when the filesystem is mounted, jbd2 will replay
> the journal but the journal superblock will not be updated by
> journal_reset() because JBD2_ABORT flag is still set (it was set in
> journal_init_common()). This is problematic because when a new transaction
> is then committed, it will be recorded in block 1 (journal->j_tail was set
> to 1 in journal_reset()). If unclean shutdown happens again before the
> journal superblock is updated, the new recorded transaction will not be
> replayed during the next mount (because of stale sb->s_start and
> sb->s_sequence values) which can lead to filesystem corruption.
> 
> Otherwise the patch looks good to me so feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> (again this is added to the bottom of the changelog like the 'Fixes' tag or
> 'Signed-off-by' tag).

Thanks, applied with a fixed up commit description.

		       	     	       - Ted
