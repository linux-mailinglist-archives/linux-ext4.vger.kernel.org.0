Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0D9280146
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Oct 2020 16:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732339AbgJAOba (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Oct 2020 10:31:30 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51693 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732099AbgJAOb3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Oct 2020 10:31:29 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 091EVOq2030955
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Oct 2020 10:31:24 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 438EF42003C; Thu,  1 Oct 2020 10:31:24 -0400 (EDT)
Date:   Thu, 1 Oct 2020 10:31:24 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] mke2fs: Warn if fs block size is incompatible with DAX
Message-ID: <20201001143124.GH23474@mit.edu>
References: <20200709144057.21333-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709144057.21333-1-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jul 09, 2020 at 04:40:57PM +0200, Jan Kara wrote:
> If we are creating filesystem on DAX capable device, warn if set block
> size is incompatible with DAX to give admin some hint why DAX might not
> be available.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Applied, thanks.

					- Ted
