Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56FE6EAC8B
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Oct 2019 10:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfJaJaO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 31 Oct 2019 05:30:14 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51782 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726776AbfJaJaO (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 31 Oct 2019 05:30:14 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DFFB398FA1190C937041;
        Thu, 31 Oct 2019 17:30:11 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 31 Oct
 2019 17:30:01 +0800
Subject: Re: [PATCH v2] ext4: bio_alloc with __GFP_DIRECT_RECLAIM never fails
To:     Gao Xiang <gaoxiang25@huawei.com>, Theodore Ts'o <tytso@mit.edu>,
        "Andreas Dilger" <adilger.kernel@dilger.ca>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Ritesh Harjani" <riteshh@linux.ibm.com>
References: <20191030161244.GB3953@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20191031092315.139267-1-gaoxiang25@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <5f46684a-a435-1e15-0054-b708edfce487@huawei.com>
Date:   Thu, 31 Oct 2019 17:29:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191031092315.139267-1-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2019/10/31 17:23, Gao Xiang wrote:
> Similar to [1] [2], bio_alloc with __GFP_DIRECT_RECLAIM flags
> guarantees bio allocation under some given restrictions, as
> stated in block/bio.c and fs/direct-io.c So here it's ok to
> not check for NULL value from bio_alloc().
> 
> [1] https://lore.kernel.org/r/20191030035518.65477-1-gaoxiang25@huawei.com
> [2] https://lore.kernel.org/r/20190830162812.GA10694@infradead.org
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> Cc: Ritesh Harjani <riteshh@linux.ibm.com>
> Cc: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
