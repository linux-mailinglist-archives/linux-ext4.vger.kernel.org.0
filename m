Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0A0FD33B
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Nov 2019 04:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKODVw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Nov 2019 22:21:52 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2086 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726533AbfKODVw (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 14 Nov 2019 22:21:52 -0500
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 0364F1DEFC3323A7AAC6;
        Fri, 15 Nov 2019 11:21:48 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 15 Nov 2019 11:21:47 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Fri, 15 Nov 2019 11:21:47 +0800
Date:   Fri, 15 Nov 2019 11:24:16 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
CC:     Chao Yu <yuchao0@huawei.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [PATCH v2] ext4: bio_alloc with __GFP_DIRECT_RECLAIM never fails
Message-ID: <20191115032416.GA156858@architecture4>
References: <20191030161244.GB3953@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20191031092315.139267-1-gaoxiang25@huawei.com>
 <5f46684a-a435-1e15-0054-b708edfce487@huawei.com>
 <20191115031953.GA30252@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191115031953.GA30252@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme706-chm.china.huawei.com (10.1.199.102) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted,

On Thu, Nov 14, 2019 at 10:19:53PM -0500, Theodore Y. Ts'o wrote:
> On Thu, Oct 31, 2019 at 05:29:58PM +0800, Chao Yu wrote:
> > On 2019/10/31 17:23, Gao Xiang wrote:
> > > Similar to [1] [2], bio_alloc with __GFP_DIRECT_RECLAIM flags
> > > guarantees bio allocation under some given restrictions, as
> > > stated in block/bio.c and fs/direct-io.c So here it's ok to
> > > not check for NULL value from bio_alloc().
> > > 
> > > [1] https://lore.kernel.org/r/20191030035518.65477-1-gaoxiang25@huawei.com
> > > [2] https://lore.kernel.org/r/20190830162812.GA10694@infradead.org
> > > Cc: Theodore Ts'o <tytso@mit.edu>
> > > Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> > > Cc: Ritesh Harjani <riteshh@linux.ibm.com>
> > > Cc: Chao Yu <yuchao0@huawei.com>
> > > Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> > 
> > Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks, applied.
> 
> 					- Ted

Thanks for considering this. Have a nice day.

Thanks,
Gao Xiang

