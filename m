Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37C8CFD32F
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Nov 2019 04:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfKODUP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Nov 2019 22:20:15 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49538 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727065AbfKODUP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Nov 2019 22:20:15 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xAF3Jruj001765
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Nov 2019 22:19:54 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4F94B4202FD; Thu, 14 Nov 2019 22:19:53 -0500 (EST)
Date:   Thu, 14 Nov 2019 22:19:53 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Gao Xiang <gaoxiang25@huawei.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [PATCH v2] ext4: bio_alloc with __GFP_DIRECT_RECLAIM never fails
Message-ID: <20191115031953.GA30252@mit.edu>
References: <20191030161244.GB3953@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20191031092315.139267-1-gaoxiang25@huawei.com>
 <5f46684a-a435-1e15-0054-b708edfce487@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f46684a-a435-1e15-0054-b708edfce487@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Oct 31, 2019 at 05:29:58PM +0800, Chao Yu wrote:
> On 2019/10/31 17:23, Gao Xiang wrote:
> > Similar to [1] [2], bio_alloc with __GFP_DIRECT_RECLAIM flags
> > guarantees bio allocation under some given restrictions, as
> > stated in block/bio.c and fs/direct-io.c So here it's ok to
> > not check for NULL value from bio_alloc().
> > 
> > [1] https://lore.kernel.org/r/20191030035518.65477-1-gaoxiang25@huawei.com
> > [2] https://lore.kernel.org/r/20190830162812.GA10694@infradead.org
> > Cc: Theodore Ts'o <tytso@mit.edu>
> > Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> > Cc: Ritesh Harjani <riteshh@linux.ibm.com>
> > Cc: Chao Yu <yuchao0@huawei.com>
> > Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks, applied.

					- Ted
