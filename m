Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A465337857
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Mar 2021 16:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbhCKPoD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Mar 2021 10:44:03 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49485 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234382AbhCKPna (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 Mar 2021 10:43:30 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 12BFhFIM000793
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Mar 2021 10:43:17 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8FB0815C3AA0; Thu, 11 Mar 2021 10:43:15 -0500 (EST)
Date:   Thu, 11 Mar 2021 10:43:15 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, yangerkun@huawei.com
Subject: Re: [PATCH v1 1/2] ext4: find old entry again if failed to rename
 whiteout
Message-ID: <YEo6k8kg3zF7avId@mit.edu>
References: <20210303131703.330415-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303131703.330415-1-yi.zhang@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 03, 2021 at 09:17:02PM +0800, zhangyi (F) wrote:
> If we failed to add new entry on rename whiteout, we cannot reset the
> old->de entry directly, because the old->de could have moved from under
> us during make indexed dir. So find the old entry again before reset is
> needed, otherwise it may corrupt the filesystem as below.
> 
>   /dev/sda: Entry '00000001' in ??? (12) has deleted/unused inode 15. CLEARED.
>   /dev/sda: Unattached inode 75
>   /dev/sda: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.
>
>   ....
>
> +	/*
> +	 * old->de could have moved from under us during make indexed dir,
> +	 * so the old->de may no longer valid and need to find it again
> +	 * before reset old inode info.
> +	 */
> +	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de, NULL);
> +	if (IS_ERR(old.bh))
> +		retval = PTR_ERR(old.bh);
> +	if (!old.bh)
> +		retval = -ENOENT;
> +	if (retval) {
> +		ext4_std_error(old.dir->i_sb, retval);


So if the directory entry may have been deleted out from under us, an
ENOENT failure might happen under normal circumstances, shouldn't it?

In that case, ext4_std_error() will declare that the file system is
inconsistent, potentially resulting in the file system to be remounted
read-only, or causing the system to panic.  So calling
ext4_std_error() needs to be done carefully.

Are we sure that calling ext4_std_error() is the right thing to do in
the case where ext4_find_entry() returns ENOENT?

							- Ted
