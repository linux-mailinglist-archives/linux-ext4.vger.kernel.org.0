Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7462AB4DF
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Nov 2020 11:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgKIK16 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Nov 2020 05:27:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:54662 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbgKIK15 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 9 Nov 2020 05:27:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8B05FAD8C;
        Mon,  9 Nov 2020 10:27:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 64EE31E1311; Mon,  9 Nov 2020 11:27:55 +0100 (CET)
Date:   Mon, 9 Nov 2020 11:27:55 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-doc@vger.kernel.org, Jan Kara <jack@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: filesystems: Reduce ext2.rst to one top-level
 heading
Message-ID: <20201109102755.GB21934@quack2.suse.cz>
References: <20201108004045.1378676-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201108004045.1378676-1-j.neuschaefer@gmx.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun 08-11-20 01:40:45, Jonathan Neuschäfer wrote:
> This prevents the other headings like "Options" and "Specification" from
> leaking out and being listed separately in the table of contents.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Thanks! I'll queue this fix into my tree.

								Honza

> ---
>  Documentation/filesystems/ext2.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/filesystems/ext2.rst b/Documentation/filesystems/ext2.rst
> index d83dbbb162e20..c2fce22cfd035 100644
> --- a/Documentation/filesystems/ext2.rst
> +++ b/Documentation/filesystems/ext2.rst
> @@ -1,6 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0
> 
> 
> +==============================
>  The Second Extended Filesystem
>  ==============================
> 
> --
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
