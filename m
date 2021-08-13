Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABF63EB915
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Aug 2021 17:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242282AbhHMPVp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Aug 2021 11:21:45 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57030 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S242717AbhHMPSp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 13 Aug 2021 11:18:45 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17DFI2NT022622
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Aug 2021 11:18:02 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E2F0415C37C1; Fri, 13 Aug 2021 11:18:01 -0400 (EDT)
Date:   Fri, 13 Aug 2021 11:18:01 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     yangerkun <yangerkun@huawei.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, yukuai3@huawei.com
Subject: Re: [PATCH] ext4: stop return ENOSPC from ext4_issue_zeroout
Message-ID: <YRaNKc2PvM+Eyzmp@mit.edu>
References: <20210804125044.2480435-1-yangerkun@huawei.com>
 <20210804133529.GE4578@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804133529.GE4578@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 04, 2021 at 03:35:29PM +0200, Jan Kara wrote:
> On Wed 04-08-21 20:50:44, yangerkun wrote:
> > Our testcase(briefly described as fsstress on dm thin-provisioning which
> > ext4 see volume size with 100G but actual size 10G) trigger a hungtask
> > bug since ext4_writepages fall into a infinite loop:
> > 
> > Got ENOSPC with follow stack:
> > ...
> > ext4_ext_map_blocks
> >   ext4_ext_convert_to_initialized
> >     ext4_ext_zeroout
> >       ext4_issue_zeroout
> >         ...
> >         submit_bio_wait <-- bio to thinpool will return ENOSPC
> > 
> 
> Thanks for the patch. As a quick fix for the problem this is probably fine.
> But longer term we might need to implement a configurable behavior for this
> because just dropping data on the floor (which is what would happen here)
> need not be what sysadmin wants and blocking until space is provisioned may be
> actually a preferable behavior. Anyway for now feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Hmm, I wonder if this would be a better fix.  (Not yet tested, may fry
your file system, etc....)   What do folks think?

						- Ted

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 92ad64b89d9b..501516cadc1b 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3569,7 +3569,7 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
 				split_map.m_len - ee_block);
 			err = ext4_ext_zeroout(inode, &zero_ex1);
 			if (err)
-				goto out;
+				goto fallback;
 			split_map.m_len = allocated;
 		}
 		if (split_map.m_lblk - ee_block + split_map.m_len <
@@ -3583,7 +3583,7 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
 						      ext4_ext_pblock(ex));
 				err = ext4_ext_zeroout(inode, &zero_ex2);
 				if (err)
-					goto out;
+					goto fallback;
 			}
 
 			split_map.m_len += split_map.m_lblk - ee_block;
@@ -3592,6 +3592,7 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
 		}
 	}
 
+fallback:
 	err = ext4_split_extent(handle, inode, ppath, &split_map, split_flag,
 				flags);
 	if (err > 0)
