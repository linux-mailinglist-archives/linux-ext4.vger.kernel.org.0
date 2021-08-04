Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46AF53E0877
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Aug 2021 21:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhHDTE2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Aug 2021 15:04:28 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41524 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230063AbhHDTE2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Aug 2021 15:04:28 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 174J4An8017769
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Aug 2021 15:04:11 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8885715C37C1; Wed,  4 Aug 2021 15:04:10 -0400 (EDT)
Date:   Wed, 4 Aug 2021 15:04:10 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 8/9] mke2fs: Add orphan_file feature into mke2fs.conf
Message-ID: <YQrkqslPB8oRrgwA@mit.edu>
References: <20210712154315.9606-1-jack@suse.cz>
 <20210712154315.9606-9-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712154315.9606-9-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jul 12, 2021 at 05:43:14PM +0200, Jan Kara wrote:
> Enable orphan_file feature by default in larger filesystems. Since the
> feature is COMPAT, older kernels will just ignore it and happily work
> with the filesystem as well.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

We'll need to decide whether we want to enable this by default, at
least initially.  The general practice has been to not enable new
kernel functionality right away by default.  It's true that older
kernels will ignore the feature if they aren't orphan_file aware;
however, we if have a file system which is created with orphan_file
eanbled, but that file system with the orphan_file feature is made
available to a system which is running an orphan_file-aware kernel,
but the distro hadn't picked up the a version e2fsprogs which is
orphan_file-aware.  This might happen if the file system was created
on one system, and then it gets connected to an system w/o a new
version of e2fsprogs (e.g. via fibre channel, iscsi, AWS EBS, GCE PD,
etc), then could be a surprise to the user.  So that's something for
us to discuss.

In the shorter term, there's another problem I've notied, which is if
we add this to mke2fs.conf, and the user runs:

	mke2fs -t ext4 -O ^has_journal foo.img 1G

mke2fs will fail mid-way through the mkfs process with the error
message, "mke2fs: cannot set orphan_file flag without a journal".
This represents a regression, and if we don't want to drop orphan_file
from the default feature set in mke2fs.conf, I think we'll need to
check for the case where the file system doesn't have a journal, and
only fail when the user has explicitly requested orphan_file on the
command line.  But if orphan_file is a default as defined in
mke2fs.conf, and the journal is not present for whatever reaseon, we
need to silently disable the orphan_file feature.

(Also note that to avoid user confusion, we should refer to
orphan_file as a "feature" instead of a "flag".  Even for things like
"orphan_present" or "recovery_needed" it is probably clearer to call
them features, simply because it makes it easier for system
adminsitrators and developers to be able to find the "flag" location.)

Cheers,

					- Ted
