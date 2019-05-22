Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D992260BB
	for <lists+linux-ext4@lfdr.de>; Wed, 22 May 2019 11:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfEVJu6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 May 2019 05:50:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:54636 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728406AbfEVJu6 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 22 May 2019 05:50:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7E199AF11;
        Wed, 22 May 2019 09:50:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 311A01E3C69; Wed, 22 May 2019 11:50:57 +0200 (CEST)
Date:   Wed, 22 May 2019 11:50:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@zoho.com.cn>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext2: strengthen value length check in ext2_xattr_set()
Message-ID: <20190522095057.GH17019@quack2.suse.cz>
References: <20190522082846.22296-1-cgxu519@zoho.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522082846.22296-1-cgxu519@zoho.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 22-05-19 16:28:46, Chengguang Xu wrote:
> Actually maximum length of a valid entry value is not
> ->s_blocksize because header, last entry and entry
> name will also occupy some spaces. This patch
> strengthens the value length check and return -ERANGE
> when the length is larger than allowed maximum length.
> 
> Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>

Thanks for the patch! But what's the point of this change? We would return
ERANGE instead of ENOSPC? I don't think that's serious enough to warrant
changing existing behavior...

> @@ -423,7 +423,10 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
>  	if (name == NULL)
>  		return -EINVAL;
>  	name_len = strlen(name);
> -	if (name_len > 255 || value_len > sb->s_blocksize)
> +	max_len = sb->s_blocksize - sizeof(struct ext2_xattr_header)
> +			- sizeof(__u32);
> +	if (name_len > 255 ||
> +	    EXT2_XATTR_LEN(name_len) + EXT2_XATTR_SIZE(value_len) > max_len)
>  		return -ERANGE;
>  	down_write(&EXT2_I(inode)->xattr_sem);
>  	if (EXT2_I(inode)->i_file_acl) {

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
