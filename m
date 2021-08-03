Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D321F3DF512
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Aug 2021 20:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238645AbhHCS4v (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Aug 2021 14:56:51 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58997 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238452AbhHCS4v (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Aug 2021 14:56:51 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 173IuZQR017532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Aug 2021 14:56:35 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2F9DD15C37C1; Tue,  3 Aug 2021 14:56:35 -0400 (EDT)
Date:   Tue, 3 Aug 2021 14:56:35 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 6/9] e2fsck: Add support for handling orphan file
Message-ID: <YQmRY5ZaLxpN4ZID@mit.edu>
References: <20210712154315.9606-1-jack@suse.cz>
 <20210712154315.9606-7-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712154315.9606-7-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jul 12, 2021 at 05:43:12PM +0200, Jan Kara wrote:
> diff --git a/e2fsck/problem.h b/e2fsck/problem.h
> index 24cdcf9b90f7..0611d71f9e03 100644
> --- a/e2fsck/problem.h
> +++ b/e2fsck/problem.h
> @@ -717,6 +729,15 @@ struct problem_context {
>  #define PR_1_HTREE_CANNOT_SIPHASH		0x01008E
>  
>  
> +/* Orphan file inode is not a regular file */
> +#define PR_1_ORPHAN_FILE_BAD_MODE		0x01007F
> +
> +/* Orphan file inode is not in use, but contains data */
> +#define PR_1_ORPHAN_FILE_NOT_CLEAR		0x010080
> +
> +/* Orphan file inode is not clear */
> +#define PR_1_ORPHAN_INODE_NOT_CLEAR		0x01007F
> +

The problem codes for PR_1_ORPHAN_FILE_BAD_MODE,
PR_1_ORPHAN_FILE_NOT_CLEAR, and PR_1_ORPHAN_INODE_NOT_CLEAR overlap
with pre-existing problem codes.  This was picked up by running "make
check", either at the top-level or in the e2fsck subdirectory.  I've
fixed this up in my repo.

I've pushed out the slightly massaged e2fsprogs parallel orphan list
patches on the "pu" (proposed updates, a terminology that Junio uses
for the git repo) branch, for folks who want to experiment with the
parallel orphan list patches.

					- Ted
