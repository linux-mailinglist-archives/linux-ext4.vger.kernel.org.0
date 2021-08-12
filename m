Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5803E9BEC
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Aug 2021 03:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbhHLBZx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Aug 2021 21:25:53 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46857 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233215AbhHLBZw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Aug 2021 21:25:52 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17C1PJKG014281
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Aug 2021 21:25:19 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D9F0C15C37C1; Wed, 11 Aug 2021 21:25:18 -0400 (EDT)
Date:   Wed, 11 Aug 2021 21:25:18 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] mke2fs: warn about missing y2038 support when formatting
 fresh ext4 fs
Message-ID: <YRR4fmg2eQMWf2iO@mit.edu>
References: <20210811233253.GC3601392@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811233253.GC3601392@magnolia>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 11, 2021 at 04:32:53PM -0700, Darrick J. Wong wrote:
> +/*
> + * Returns true if the user is forcing an old format (e.g. ext2, ext3).
> + *
> + * If there is no fs_types list, the user invoked us with no explicit type and
> + * gets the default (ext4) format.  If we find the latest format (ext4) in the
> + * type list, some combination of program name and -T argument put us in ext4
> + * mode.  Anything else (ext2, ext3, hurd) and we return false.
> + */

So that's not actually quite right.  Even if the user has no explicit
type, mke2fs will assign a default type --- and it's not necessarily
ext4.  You can see what the contents of the fs_types list using the -v
option:

% /bin/rm /tmp/foo.img ; mke2fs -vq /tmp/foo.img 8m
fs_types for mke2fs.conf resolution: 'ext2', 'small'
% /bin/rm /tmp/foo.img ; mke2fs -vq -T news /tmp/foo.img 8m
fs_types for mke2fs.conf resolution: 'ext2', 'news'
% /bin/rm /tmp/foo.img ; mkfs.ext4 -vq /tmp/foo.img 8m
fs_types for mke2fs.conf resolution: 'ext4', 'small'
% /bin/rm /tmp/foo.img ; mkfs.ext4 -T huge -vq /tmp/foo.img 8m
fs_types for mke2fs.conf resolution: 'ext4', 'huge'
% /bin/rm /tmp/foo.img ; mkfs.ext4 -o hurd -vq /tmp/foo.img 8m
fs_types for mke2fs.conf resolution: 'ext2', 'small', 'hurd'

Also note that the ext2/ext3/ext4 fs_type will always be in
fs_types[0], so it's not necessary to search the entire list, as the
patch is currently doing:

> +	for (i = 0; fs_types[i]; i++)
> +		if (!strcmp(fs_types[i], "ext4"))
> +			found_ext4 = 1;


Cheers,

						- Ted

P.S.  Although I'm not aware of anyone actually doing this, if there
mke2fs is installed as mke3fs or mke4fs, that's the equivalent of
mkfs.ext3 and mkfs.ext4.  (See the logic in the parse_fs_type
function.)  Although perhaps there is some obscure distro somewhere
out there that I don't know about....
