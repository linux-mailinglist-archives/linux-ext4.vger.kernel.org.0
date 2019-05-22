Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B62B262CE
	for <lists+linux-ext4@lfdr.de>; Wed, 22 May 2019 13:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfEVLN7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 May 2019 07:13:59 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25728 "EHLO
        sender1.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728406AbfEVLN7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 May 2019 07:13:59 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1558523627; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=NwFcnV4DyUZrflW1hkGH6ioplGzYIhODVZ42X9z7QJUThGImnKyzkXpbuwfE1J/rWzJsM0q/Sp1PtVK+RkqY2kjOodnOYQzGS93WHKqdD3zx8cengQFsyGfUiV5BIn32jlchMJ3ceM4KtYSJ4ESn5Urf+73LklDdl7wx3y7nN8k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1558523627; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To:ARC-Authentication-Results; 
        bh=Aq2Y4JW4WDXbp4+j1+i3PQYY6L6F/VBRxHSo3hvsLQI=; 
        b=pG0Fgma/ZpKiNu5vOTh5jDZ/jqrJICSxDGHmBzAcrRnMOOH/CItWte15m76IYDsIQp2Kj6HNbcqTqYS4+WFykakMhUynJQ/IaAYX/PdY3oehto8hjApb8wPFq9a5guo06o9tGs7yPerTqC2WHXEfxfli4RZBTb6STgZc2XZ4j1E=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=zoho.com.cn;
        spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
        dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from hades (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 155852362380062.582868141699464; Wed, 22 May 2019 19:13:43 +0800 (CST)
Message-ID: <9777b34af1f4d3a79f8f6b1bdc1144e83d737086.camel@zoho.com.cn>
Subject: Re: [PATCH] ext2: strengthen value length check in ext2_xattr_set()
From:   "cgxu519@zoho.com.cn" <cgxu519@zoho.com.cn>
Reply-To: cgxu519@zoho.com.cn
To:     Jan Kara <jack@suse.cz>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
Date:   Wed, 22 May 2019 19:13:43 +0800
In-Reply-To: <20190522095057.GH17019@quack2.suse.cz>
References: <20190522082846.22296-1-cgxu519@zoho.com.cn>
         <20190522095057.GH17019@quack2.suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-ZohoCNMailClient: External
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 2019-05-22 at 11:50 +0200, Jan Kara wrote:
> On Wed 22-05-19 16:28:46, Chengguang Xu wrote:
> > Actually maximum length of a valid entry value is not
> > ->s_blocksize because header, last entry and entry
> > name will also occupy some spaces. This patch
> > strengthens the value length check and return -ERANGE
> > when the length is larger than allowed maximum length.
> > 
> > Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
> 
> Thanks for the patch! But what's the point of this change? We would return
> ERANGE instead of ENOSPC? I don't think that's serious enough to warrant
> changing existing behavior...

Hi Jan,

Thanks for the review. 

The motivation is seprating error situations of ENOSPC/ERANGE
because ENOSPC is giving a hint that we can save an EA entry
(name+value > allowed maximum length) by deleting some existing
entries. However, as you has pointed out, I also think the
difference is not so important because some EA entries
(like security index) is invisible for user...

Thanks,
Chengguang


> 
> > @@ -423,7 +423,10 @@ ext2_xattr_set(struct inode *inode, int name_index,
> > const char *name,
> >  	if (name == NULL)
> >  		return -EINVAL;
> >  	name_len = strlen(name);
> > -	if (name_len > 255 || value_len > sb->s_blocksize)
> > +	max_len = sb->s_blocksize - sizeof(struct ext2_xattr_header)
> > +			- sizeof(__u32);
> > +	if (name_len > 255 ||
> > +	    EXT2_XATTR_LEN(name_len) + EXT2_XATTR_SIZE(value_len) > max_len)
> >  		return -ERANGE;
> >  	down_write(&EXT2_I(inode)->xattr_sem);
> >  	if (EXT2_I(inode)->i_file_acl) {
> 
> 								Honza
> 



