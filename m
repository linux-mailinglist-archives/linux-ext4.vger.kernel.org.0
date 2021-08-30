Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6703FB5A3
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Aug 2021 14:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237266AbhH3MGo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Aug 2021 08:06:44 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53932 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236625AbhH3MGf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 Aug 2021 08:06:35 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17UC5Yfr003951
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Aug 2021 08:05:35 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 68C7015C3E6B; Mon, 30 Aug 2021 08:05:34 -0400 (EDT)
Date:   Mon, 30 Aug 2021 08:05:34 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Denis Efremov <efremov@linux.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: change EXT4_IOC_GETSTATE ioctl to _IOR
Message-ID: <YSzJjtUtXRxeXSwl@mit.edu>
References: <20210830100508.56004-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830100508.56004-1-efremov@linux.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 30, 2021 at 01:05:08PM +0300, Denis Efremov wrote:
> EXT4_IOC_GETSTATE is only used to read the state flags from the kernel.
> 
> Fixes: 1ad3ea6e0a69 ("ext4: add a new ioctl EXT4_IOC_GETSTATE")
> Signed-off-by: Denis Efremov <efremov@linux.com>

NACK.  This will break ABI compatibility, which is way important than
getting the ioctl encoding incorrect.

If you really care, I suppose we could add an EXT4_IOC_GETSTATE_OLD
for the old value, and then support EXT4_IOC_GETSTATE and
EXT4_IOC_GETSTATE_OLD for a decade or two until all of the binaries in
the world get recompiled.

Is it worth it?  Eh....

						- Ted
						
