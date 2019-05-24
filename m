Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11DD329400
	for <lists+linux-ext4@lfdr.de>; Fri, 24 May 2019 10:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389582AbfEXI6u (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 May 2019 04:58:50 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25989 "EHLO
        sender1.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389281AbfEXI6u (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 24 May 2019 04:58:50 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1558688320; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=M45pSQbZZBgP7jBvyH778C4VcljIjAJn13eP8km7uUI6UxlB0z2K8vW6MsuBI1Ctx+NRcWMykMYXlB0092EGVRj5MR9pVK43OCAu3xMP3szThX/za5DD0BGXjATKfrJl9z6TH06u7n7OO6O8sEoV+fuTxFd9RdSIIVzDoC1i5/U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1558688320; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To:ARC-Authentication-Results; 
        bh=QsUDYSIU1/wMaLBVBuvuoeLQg3RyvyMrM68dah2MBjo=; 
        b=AeMJkBhyko2wsYjJS1oOf0JUe0/XVDSiATRj4v2TitftXziobiP3HCTEhpVcRRJSQJYD2CzG32m6yePm2CeRMSD7D87oItUWXqcJImATTvG3Nc1W14ihKUvWewrW2PIjdM+xEAEcrUTX+p4b6as7vngzfFn9aW8vdQConKfnP7c=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=zoho.com.cn;
        spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
        dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from hades (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1558688318686511.40783088255955; Fri, 24 May 2019 16:58:38 +0800 (CST)
Message-ID: <db947cce565d9ae766906d6f131cd9e2cf58cb7f.camel@zoho.com.cn>
Subject: Re: [PATCH] ext2: optimize ext2_xattr_get()
From:   "cgxu519@zoho.com.cn" <cgxu519@zoho.com.cn>
Reply-To: cgxu519@zoho.com.cn
To:     Jan Kara <jack@suse.cz>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
Date:   Fri, 24 May 2019 16:58:37 +0800
In-Reply-To: <20190524080740.GA28972@quack2.suse.cz>
References: <20190521082140.19992-1-cgxu519@zoho.com.cn>
         <20190523144612.GA18841@quack2.suse.cz>
         <afa54281eaf134b892d5f93d281d7ddf75bfe3a5.camel@zoho.com.cn>
         <20190524080740.GA28972@quack2.suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-ZohoCNMailClient: External
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, 2019-05-24 at 10:07 +0200, Jan Kara wrote:
> On Fri 24-05-19 10:07:05, cgxu519@zoho.com.cn wrote:
> > On Thu, 2019-05-23 at 16:46 +0200, Jan Kara wrote:
> > > On Tue 21-05-19 16:21:39, Chengguang Xu wrote:
> > > > Since xattr entry names are sorted, we don't have
> > > > to continue when current entry name is greater than
> > > > target.
> > > > 
> > > > Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
> > > 
> > > Thanks for the patch! If we are going to do these comparisons in multiple
> > > places, then please create a helper function to do the comparison (so that
> > > we have the same comparison in every place). Something like:
> > > 
> > > int ext2_xattr_cmp(int name_index, size_t name_len, const char *name,
> > > 		   struct ext2_xattr_entry *entry)
> > > 
> > 
> > Hi Jan,
> > 
> > Thanks for the review and advice. 
> > 
> > You are right we should introduce a helper to handle this part of work
> > and personally I think maybe implementing a helper to find target entry
> > will be more useful, do you think it makes sense?
> 
> It makes sense but ext2_xattr_set() also computes min_offs and last during
> the search so using the search function in that case won't be a readbility
> win I guess. So I'm not sure the search function pays off in the end.

Yes, I noticed that too, I plan to set min_offs pointer as function parameter
so that we can seperate different search modes based on it.

Thanks,
Chengguang


