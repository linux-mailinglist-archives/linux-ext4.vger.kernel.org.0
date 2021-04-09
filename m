Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F43B35A210
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Apr 2021 17:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbhDIPdR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Apr 2021 11:33:17 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39990 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232642AbhDIPdP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Apr 2021 11:33:15 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 139FWmbm015890
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Apr 2021 11:32:48 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4806715C3B12; Fri,  9 Apr 2021 11:32:48 -0400 (EDT)
Date:   Fri, 9 Apr 2021 11:32:48 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Zhang Yi <yi.zhang@huawei.com>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca
Subject: Re: [PATCH v2] ext4: fix check to prevent false positive report of
 incorrect used inodes
Message-ID: <YHBzoLSdVDuUiXma@mit.edu>
References: <20210331121516.2243099-1-yi.zhang@huawei.com>
 <20210331122354.GH30749@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331122354.GH30749@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 31, 2021 at 02:23:54PM +0200, Jan Kara wrote:
> On Wed 31-03-21 20:15:16, Zhang Yi wrote:
> > Commit <50122847007> ("ext4: fix check to prevent initializing reserved
> > inodes") check the block group zero and prevent initializing reserved
> > inodes. But in some special cases, the reserved inode may not all belong
> > to the group zero, it may exist into the second group if we format
> > filesystem below.
> > 
> >   mkfs.ext4 -b 4096 -g 8192 -N 1024 -I 4096 /dev/sda
> > 
> > So, it will end up triggering a false positive report of a corrupted
> > file system. This patch fix it by avoid check reserved inodes if no free
> > inode blocks will be zeroed.
> > 
> > Fixes: 50122847007 ("ext4: fix check to prevent initializing reserved inodes")
> > Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> > Suggested-by: Jan Kara <jack@suse.cz>
> 
> Thanks! The patch looks good to me. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks, applied.

					- Ted
