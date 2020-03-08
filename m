Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD0E17D0B6
	for <lists+linux-ext4@lfdr.de>; Sun,  8 Mar 2020 01:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgCHACZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 7 Mar 2020 19:02:25 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43420 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726109AbgCHACZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 7 Mar 2020 19:02:25 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02802KIt014740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 7 Mar 2020 19:02:21 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 732A942045B; Sat,  7 Mar 2020 19:02:20 -0500 (EST)
Date:   Sat, 7 Mar 2020 19:02:20 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/7] ext2fs: Update allocation info earlier in
 ext2fs_mkdir() and ext2fs_symlink()
Message-ID: <20200308000220.GF99899@mit.edu>
References: <20200213101602.29096-1-jack@suse.cz>
 <20200213101602.29096-4-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213101602.29096-4-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 13, 2020 at 11:15:58AM +0100, Jan Kara wrote:
> Currently, ext2fs_mkdir() and ext2fs_symlink() update allocation bitmaps
> and other information only close to the end of the function, in
> particular after calling to ext2fs_link(). When ext2fs_link() will
> support indexed directories, it will also need to allocate blocks and
> that would cause filesystem corruption in case allocation info isn't
> properly updated. So make sure ext2fs_mkdir() and ext2fs_symlink()
> update allocation info before calling into ext2fs_link().

I'm not sure why there would be file system corruption if the
allocation information isn't updated until later?  Can you explain more?

One problem with moving the alliocation updates earlier is that in
case of errors, they need to be undone.  To be fair, there are other
missing error handling if there are failures, but this change would
make things worse.

					- Ted
