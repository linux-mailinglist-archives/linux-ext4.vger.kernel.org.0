Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CE21A9EB5
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Apr 2020 14:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368078AbgDOMAK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Apr 2020 08:00:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:35730 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S368070AbgDOMAF (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 15 Apr 2020 08:00:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DE4A5AF10;
        Wed, 15 Apr 2020 12:00:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 362FF1E1250; Wed, 15 Apr 2020 14:00:02 +0200 (CEST)
Date:   Wed, 15 Apr 2020 14:00:02 +0200
From:   Jan Kara <jack@suse.cz>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 2/8] fs/ext4: Disallow verity if inode is DAX
Message-ID: <20200415120002.GE6126@quack2.suse.cz>
References: <20200414040030.1802884-1-ira.weiny@intel.com>
 <20200414040030.1802884-3-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414040030.1802884-3-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 13-04-20 21:00:24, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Verity and DAX are incompatible.  Changing the DAX mode due to a verity
> flag change is wrong without a corresponding address_space_operations
> update.
> 
> Make the 2 options mutually exclusive by returning an error if DAX was
> set first.
> 
> (Setting DAX is already disabled if Verity is set first.)
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  fs/ext4/verity.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
> index dc5ec724d889..ce3f9a198d3b 100644
> --- a/fs/ext4/verity.c
> +++ b/fs/ext4/verity.c
> @@ -113,6 +113,9 @@ static int ext4_begin_enable_verity(struct file *filp)
>  	handle_t *handle;
>  	int err;
>  
> +	if (WARN_ON_ONCE(IS_DAX(inode)))
> +		return -EINVAL;
> +

Hum, one question, is there a reason for WARN_ON_ONCE()? If I understand
correctly, user could normally trigger this, couldn't he?

								Honza

>  	if (ext4_verity_in_progress(inode))
>  		return -EBUSY;
>  
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
