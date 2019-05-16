Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C91B51FDFC
	for <lists+linux-ext4@lfdr.de>; Thu, 16 May 2019 05:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfEPDRu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 May 2019 23:17:50 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40987 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726218AbfEPDRu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 May 2019 23:17:50 -0400
Received: from callcc.thunk.org (168-215-239-3.static.ctl.one [168.215.239.3] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4G3Hc1v014818
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 May 2019 23:17:41 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id AF305420024; Wed, 15 May 2019 23:17:37 -0400 (EDT)
Date:   Wed, 15 May 2019 23:17:37 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Liu Song <fishland@aliyun.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, liu.song11@zte.com.cn
Subject: Re: [PATCH] ext4: always set inode of deleted entry to zero
Message-ID: <20190516031737.GA24832@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Liu Song <fishland@aliyun.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        liu.song11@zte.com.cn
References: <20190515140000.3611-1-fishland@aliyun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515140000.3611-1-fishland@aliyun.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 15, 2019 at 10:00:00PM +0800, Liu Song wrote:
> Although the deleted entry can not be seen by changing
> the rec_len of the parent directory entry. However we
> can piggyback set the entry's inode to 0. There is no
> harm and an entry with an inode of 0 means that the
> entry has been deleted and more reliable.
> 
> Signed-off-by: Liu Song <liu.song11@zte.com.cn>

What are the circumstances where this is "more reliable"?  In other
words, what problem are you trying to solve?  The fact that we don't
zero the inode number, but simply make the directory entry "disappear"
if possible is actually deliberate.

The goal was to give careless sytem administrators one last saving
throw (sorry, American English figure of speach; see [1] for an
explanation) against accidental mistakes, ifh they can shutdown their
system fast enough.

[1] https://en.wikipedia.org/wiki/Saving_throw

This doesn't actually work all that well these days, admittedly
because of how ext4_truncate works.  (See the debugfs man page for
lsdel for more details.)  However, I've always had the thought that if
someone wanted to implement a hack where all of the bitmap blocks that
would need to be zero could fit in a transaction, we wouldn't need to
update the extent tree blocks and indirect blocks, and could
significantly simplify the how many blocks might need to be modified
when deleting a file --- and make lsdel something that could work in
emergency circumstances again.

						- Ted
