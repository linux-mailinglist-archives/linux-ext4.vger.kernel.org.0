Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08022DBA4C
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Dec 2020 06:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725550AbgLPFFL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Dec 2020 00:05:11 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38937 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725274AbgLPFFL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Dec 2020 00:05:11 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BG54LGL027625
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Dec 2020 00:04:22 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C1DDE420280; Wed, 16 Dec 2020 00:04:21 -0500 (EST)
Date:   Wed, 16 Dec 2020 00:04:21 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 03/12] ext4: Standardize error message in
 ext4_protect_reserved_inode()
Message-ID: <X9mVVasZp9oFE/hd@mit.edu>
References: <20201127113405.26867-1-jack@suse.cz>
 <20201127113405.26867-4-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127113405.26867-4-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Nov 27, 2020 at 12:33:56PM +0100, Jan Kara wrote:
> We use __ext4_error() when ext4_protect_reserved_inode() finds
> filesystem corruption. However EXT4_ERROR_INODE_ERR() is perfectly
> capable of reporting all the needed information. So just use that.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Thanks, applied.

					- Ted
