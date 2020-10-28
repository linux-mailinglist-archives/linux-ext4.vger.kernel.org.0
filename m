Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DF829D3FA
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Oct 2020 22:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgJ1VdT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Oct 2020 17:33:19 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56515 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725942AbgJ1VdO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Oct 2020 17:33:14 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 09S3ceIO021057
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Oct 2020 23:38:40 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E94A7420107; Tue, 27 Oct 2020 23:38:39 -0400 (EDT)
Date:   Tue, 27 Oct 2020 23:38:39 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Luo Meng <luomeng12@huawei.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, jack@suse.cz
Subject: Re: [PATCH] ext4: fix invalid inode checksum
Message-ID: <20201028033839.GK5691@mit.edu>
References: <20201020013631.3796673-1-luomeng12@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020013631.3796673-1-luomeng12@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 20, 2020 at 09:36:31AM +0800, Luo Meng wrote:
> During the stability test, there are some errors:
>   ext4_lookup:1590: inode #6967: comm fsstress: iget: checksum invalid.
> 
> If the inode->i_iblocks too big and doesn't set huge file flag, checksum
> will not be recalculated when update the inode information to it's buffer.
> If other inode marks the buffer dirty, then the inconsistent inode will
> be flushed to disk.
> 
> Fix this problem by checking i_blocks in advance.
> 
> Signed-off-by: Luo Meng <luomeng12@huawei.com>

Thanks, this has been applied.

					- Ted
