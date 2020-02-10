Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD4941572E1
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Feb 2020 11:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgBJKc0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Feb 2020 05:32:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:49244 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbgBJKc0 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 10 Feb 2020 05:32:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 18021B196;
        Mon, 10 Feb 2020 10:32:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3BCBE1E0E2C; Mon, 10 Feb 2020 11:24:50 +0100 (CET)
Date:   Mon, 10 Feb 2020 11:24:50 +0100
From:   Jan Kara <jack@suse.cz>
To:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz
Subject: Re: [PATCH] ext4: start to support iopoll method
Message-ID: <20200210102450.GF12923@quack2.suse.cz>
References: <20200207120758.2411-1-xiaoguang.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207120758.2411-1-xiaoguang.wang@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 07-02-20 20:07:58, Xiaoguang Wang wrote:
> Since commit "b1b4705d54ab ext4: introduce direct I/O read using
> iomap infrastructure", we can easily make ext4 support iopoll
> method, just use iomap_dio_iopoll().
> 
> Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/file.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 5f225881176b..0d624250a62b 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -872,6 +872,7 @@ const struct file_operations ext4_file_operations = {
>  	.llseek		= ext4_llseek,
>  	.read_iter	= ext4_file_read_iter,
>  	.write_iter	= ext4_file_write_iter,
> +	.iopoll		= iomap_dio_iopoll,
>  	.unlocked_ioctl = ext4_ioctl,
>  #ifdef CONFIG_COMPAT
>  	.compat_ioctl	= ext4_compat_ioctl,
> -- 
> 2.17.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
