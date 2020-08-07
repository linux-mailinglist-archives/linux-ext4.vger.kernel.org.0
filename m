Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D3523E6F2
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Aug 2020 07:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgHGFBT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Aug 2020 01:01:19 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57611 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725263AbgHGFBT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Aug 2020 01:01:19 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 07751B7H015516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Aug 2020 01:01:11 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E2A11420263; Fri,  7 Aug 2020 01:01:10 -0400 (EDT)
Date:   Fri, 7 Aug 2020 01:01:10 -0400
From:   tytso@mit.edu
To:     Jan Kara <jack@suse.cz>
Cc:     <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 0/6 v3] ext4: Check journal inode extents more carefully
Message-ID: <20200807050110.GS7657@mit.edu>
References: <20200728130437.7804-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728130437.7804-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 28, 2020 at 03:04:31PM +0200, Jan Kara wrote:
> Hello!
> 
> This series changes ext4 to properly check extent tree blocks of journal inode.
> Omitting these (which is a limitation of block validity checks) leads to crash
> in ext4_cache_extents() in case the extent tree of the journal inode is
> suitably corrupted.

Thanks, I've applied this series.

					- Ted
