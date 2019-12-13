Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B56711E2D4
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2019 12:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfLMLcj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Dec 2019 06:32:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:60698 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725946AbfLMLcj (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 13 Dec 2019 06:32:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BCBC7AF21;
        Fri, 13 Dec 2019 11:32:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 572651E0CAF; Fri, 13 Dec 2019 12:32:37 +0100 (CET)
Date:   Fri, 13 Dec 2019 12:32:37 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     miaoxie@huawei.com, linux-ext4@vger.kernel.org
Subject: Re: [bug report] ext4, project: expand inode extra size if possible
Message-ID: <20191213113237.GF15474@quack2.suse.cz>
References: <20191202094103.rgqihwzoxxy676fj@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202094103.rgqihwzoxxy676fj@kili.mountain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 02-12-19 12:41:04, Dan Carpenter wrote:
> Hello Miao Xie,
> 
> The patch c03b45b853f5: "ext4, project: expand inode extra size if
> possible" from Aug 6, 2017, leads to the following static checker
> warning:
> 
>     fs/ext4/inode.c:5708 ext4_expand_extra_isize()
>     warn: inconsistent returns 'EXT4_I(inode)->xattr_sem'.
>       Locked on  : 5708
>       Unlocked on: 5708
> 
> fs/ext4/inode.c
>   5681          handle = ext4_journal_start(inode, EXT4_HT_INODE,
>   5682                                      EXT4_DATA_TRANS_BLOCKS(inode->i_sb));
>   5683          if (IS_ERR(handle)) {
>   5684                  error = PTR_ERR(handle);
>   5685                  brelse(iloc->bh);
>   5686                  return error;
>   5687          }
>   5688  
>   5689          ext4_write_lock_xattr(inode, &no_expand);
>   5690  
>   5691          BUFFER_TRACE(iloc->bh, "get_write_access");
>   5692          error = ext4_journal_get_write_access(handle, iloc->bh);
>   5693          if (error) {
>   5694                  brelse(iloc->bh);
>   5695                  goto out_stop;
> 
> Shouldn't this goto the ext4_write_unlock_xattr()?

Yes, it should AFAICT. Thanks for spotting this. Care to send a patch?

								Honza

> 
>   5696          }
>   5697  
>   5698          error = __ext4_expand_extra_isize(inode, new_extra_isize, iloc,
>   5699                                            handle, &no_expand);
>   5700  
>   5701          rc = ext4_mark_iloc_dirty(handle, inode, iloc);
>   5702          if (!error)
>   5703                  error = rc;
>   5704  
>   5705          ext4_write_unlock_xattr(inode, &no_expand);
>   5706  out_stop:
>   5707          ext4_journal_stop(handle);
>   5708          return error;
>   5709  }
> 
> 
> regards,
> dan carpenter
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
