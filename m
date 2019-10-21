Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71F2CDF878
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Oct 2019 01:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbfJUXSZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Oct 2019 19:18:25 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59998 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729606AbfJUXSY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Oct 2019 19:18:24 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9LNIJid026020
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Oct 2019 19:18:19 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A6255420456; Mon, 21 Oct 2019 19:18:18 -0400 (EDT)
Date:   Mon, 21 Oct 2019 19:18:18 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 21/22] ext4: Reserve revoke credits for freed blocks
Message-ID: <20191021231818.GF24015@mit.edu>
References: <20191003215523.7313-1-jack@suse.cz>
 <20191003220613.10791-21-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003220613.10791-21-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 04, 2019 at 12:06:07AM +0200, Jan Kara wrote:
> +static inline int ext4_free_data_revoke_credits(struct inode *inode, int blocks)
> +{
> +	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA)
> +		return 0;
> +	if (!ext4_should_journal_data(inode))
> +		return 0;
> +	/*
> +	 * Data blocks in one extent are contiguous, just account for partial
> +	 * clusters at extent boundaries
> +	 */
> +	return blocks + 2*EXT4_SB(inode->i_sb)->s_cluster_ratio;
> +}

This looks *way* too conservative.  At the very least, this should be:


	return blocks + 2*(EXT4_SB(inode->i_sb)->s_cluster_ratio - 1);

Since when the cluster ratio is 1, there is no partial clusters at the
extent boundaries, and if bigalloc is enabled, and the cluster ratio
is 16, the worst case of "extra" blocks" at the boundaries would be 15.

It would probably be better to push this up to the callers, since we
can get the exact number by calculating

	(EXT4_B2C(sbi, last) - EXT4_B2C(sbi, first) + 1) * sbi->s_cluster_ratio

This is a bit more complicated in fs/ext4/indirect.c, where we
probably will need to do a min of the these two formulas.



The other thing which I wonder, looking at these, is whether it's
worth it to add a new revoke table format which uses 8 or 12 bytes,
where there is a block number followed by a 32-bit count field (e.g.,
a revoke extent).

I actually suspect that if made the format change, with the revoke
code using the revoke extent table if (a) a new journal feature flag
allows it, and (b) using the revoke extent table would be beneficial,
in the vast majority of cases, that might have addressed the problem
that you saw without having to do the strict tracking of revoke
blocks.  Of course, I'm sure it's still possible to create a worst
case file system and workload where the revoke blocks could still
overflow the journal --- but it would probably be very hard to do and
would only show up in a malicious workload.

What do you think?

					- Ted
