Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D873290C8
	for <lists+linux-ext4@lfdr.de>; Fri, 24 May 2019 08:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388548AbfEXGLs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 May 2019 02:11:48 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25905 "EHLO
        sender1.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387622AbfEXGLs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 24 May 2019 02:11:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1558678298; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=h9jHgxWWmFbfd51g7hKg9mCE4jsglUYIZO/L9Z1RwZRVGoM0nfzuSbQr0v3UpFbOqbNKE1qOjN+VlXJZaxCBtJt6/gw5BUFKtz5vSoIrpwzkzqpSDU9WgD3VHvjHS2py+f88Mb5bRO0HqK255AQNXdHXx8YAVcL/rq7zqvVh7rI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1558678298; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To:ARC-Authentication-Results; 
        bh=IZvx1idZR6YnyxFCyGvvLdlKejNNLu01tUGCbO7S7Ys=; 
        b=pM7gsCsA1/AtgVSV0Mr2mCR6rvaulbCWtcySOoyztCuMqmXYdXx20eAHZtKb4PPeckK53JfiM0LASJbmnIHLSliUFziCA7TwCLBbjRwM2K91idmZ9zz2RwOgXYUZqR1wAXVGTxXjIIRTE0Df/qZ4ylfPbuN9dWqULqI82vrqpSA=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=zoho.com.cn;
        spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
        dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from hades (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1558678296025209.95962119011915; Fri, 24 May 2019 14:11:36 +0800 (CST)
Message-ID: <02e827aededb5b925ec74d1e38d6dfd71f165203.camel@zoho.com.cn>
Subject: Re: [PATCH] ext2: strengthen value length check in ext2_xattr_set()
From:   "cgxu519@zoho.com.cn" <cgxu519@zoho.com.cn>
Reply-To: cgxu519@zoho.com.cn
To:     Jan Kara <jack@suse.cz>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
Date:   Fri, 24 May 2019 14:11:34 +0800
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

Instead of adding the check here, I propose to change value
size limit check in ext2_xattr_entry_valid().

size = le32_to_cpu(entry->e_value_size);
if (size > end_offs ||
    le16_to_cpu(entry->e_value_offs) + size > end_offs)

Change to

size = EXT2_XATTR_SIZE(le32_to_cpu(entry->e_value_size));
if (size >= end_offs - sizeof(struct ext2_xattr_header) - sizeof(__u32) ||
    le16_to_cpu(entry->e_value_offs) + size > end_offs)


Will you agree this change?



Thanks,
Chengguang


