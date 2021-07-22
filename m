Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2163D2641
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Jul 2021 16:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbhGVOL5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Jul 2021 10:11:57 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36147 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232520AbhGVOLy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 22 Jul 2021 10:11:54 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 16MEqNwP014107
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jul 2021 10:52:24 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 85DA415C37C0; Thu, 22 Jul 2021 10:52:23 -0400 (EDT)
Date:   Thu, 22 Jul 2021 10:52:23 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/5] ext4: Support for checksumming from journal triggers
Message-ID: <YPmGJ12J7nRt5zQU@mit.edu>
References: <20210712154009.9290-1-jack@suse.cz>
 <20210712154009.9290-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712154009.9290-2-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jul 12, 2021 at 05:40:05PM +0200, Jan Kara wrote:
> JBD2 layer support triggers which are called when journaling layer moves
> buffer to a certain state. We can use the frozen trigger, which gets
> called when buffer data is frozen and about to be written out to the
> journal, to compute block checksums for some buffer types (similarly as
> does ocfs2). This avoids unnecessary repeated recomputation of the
> checksum (at the cost of larger window where memory corruption won't be
> caught by checksumming) and is even necessary when there are
> unsynchronized updaters of the checksummed data.
> 
> So add argument to ext4_journal_get_write_access() and
> ext4_journal_get_create_access() which describes buffer type so that
> triggers can be set accordingly. This patch is mostly only a change of
> prototype of the above mentioned functions and a few small helpers. Real
> checksumming will come later.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Looks good.  I would have preferred mention of the change to
ext4_walk_page_buffers in the commit description, but I guess this was
considered one of the "few small helpers".  :-)

The WARN_ON_ONCE change in jbd2_journal_set_triggers is a somewhat
tangentially-related unrelated change, but I think I understand why it
was made.

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

						- Ted
						
