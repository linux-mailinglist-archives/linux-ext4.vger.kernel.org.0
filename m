Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25F45DEDF1
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Oct 2019 15:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfJUNkC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Oct 2019 09:40:02 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45609 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728995AbfJUNkB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Oct 2019 09:40:01 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x9LDduu3004709
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Oct 2019 09:39:57 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2CC60420458; Mon, 21 Oct 2019 09:39:56 -0400 (EDT)
Date:   Mon, 21 Oct 2019 09:39:56 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 07/22] ext4: Avoid unnecessary revokes in
 ext4_alloc_branch()
Message-ID: <20191021133956.GB4675@mit.edu>
References: <20191003215523.7313-1-jack@suse.cz>
 <20191003220613.10791-7-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003220613.10791-7-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 04, 2019 at 12:05:53AM +0200, Jan Kara wrote:
> Error cleanup path in ext4_alloc_branch() calls ext4_forget() on freshly
> allocated indirect blocks with 'metadata' set to 1. This results in
> generating revoke records for these blocks. However this is unnecessary
> as the freed blocks are only allocated in the current transaction and
> thus they will never be journalled. Make this cleanup path similar to
> e.g. cleanup in ext4_splice_branch() and use ext4_free_blocks() to
> handle block forgetting by passing EXT4_FREE_BLOCKS_FORGET and not
> EXT4_FREE_BLOCKS_METADATA to ext4_free_blocks(). This also allows
> allocating transaction not to reserve any credits for revoke records.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Looks good, you can add:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

