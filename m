Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD3128EFA
	for <lists+linux-ext4@lfdr.de>; Fri, 24 May 2019 04:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387465AbfEXCHU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 May 2019 22:07:20 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25907 "EHLO
        sender1.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731708AbfEXCHU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 May 2019 22:07:20 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1558663629; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=Vi3CK/7q2NJmaoE7M1durxoWtOk6MQT7owcQ0wr0HUk/wBIMoXcnDirXqB+BCN6VbaKmTKDEN4Y0g3PC2279X2ldmEWvSLHfyWXCrkjBnUVXeT1/QCafQI/m6wbVkO+jWuDcTmvhcy7LSVOUzOsb38/5Y6mzB7YinrVKOAKjm2s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1558663629; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To:ARC-Authentication-Results; 
        bh=QYj9ny+JDgYrQsRWseOKBXd42kYLCGLL+fweYsgL83o=; 
        b=g4J1Fz6z0VxAamNY5dBtVzpMThpL4lEG4p94xV0+AAdWLYFiNEAGVZ3dWXi6ivnQFQkQYIRAAU1UqQx4mHkfNBkvayLikbZS0+M9auW5rtIJ2VpmPFJtIFvOZ1Ac8I4VsBrmIJmtS9reKBP/jOmI+b5fbr3CjnauRGf/IqWsShQ=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=zoho.com.cn;
        spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
        dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from hades (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1558663626468140.65912124378826; Fri, 24 May 2019 10:07:06 +0800 (CST)
Message-ID: <afa54281eaf134b892d5f93d281d7ddf75bfe3a5.camel@zoho.com.cn>
Subject: Re: [PATCH] ext2: optimize ext2_xattr_get()
From:   "cgxu519@zoho.com.cn" <cgxu519@zoho.com.cn>
Reply-To: cgxu519@zoho.com.cn
To:     Jan Kara <jack@suse.cz>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
Date:   Fri, 24 May 2019 10:07:05 +0800
In-Reply-To: <20190523144612.GA18841@quack2.suse.cz>
References: <20190521082140.19992-1-cgxu519@zoho.com.cn>
         <20190523144612.GA18841@quack2.suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-ZohoCNMailClient: External
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 2019-05-23 at 16:46 +0200, Jan Kara wrote:
> On Tue 21-05-19 16:21:39, Chengguang Xu wrote:
> > Since xattr entry names are sorted, we don't have
> > to continue when current entry name is greater than
> > target.
> > 
> > Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
> 
> Thanks for the patch! If we are going to do these comparisons in multiple
> places, then please create a helper function to do the comparison (so that
> we have the same comparison in every place). Something like:
> 
> int ext2_xattr_cmp(int name_index, size_t name_len, const char *name,
> 		   struct ext2_xattr_entry *entry)
> 

Hi Jan,

Thanks for the review and advice. 

You are right we should introduce a helper to handle this part of work
and personally I think maybe implementing a helper to find target entry
will be more useful, do you think it makes sense?


Thanks,
Chengguang


