Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B23A6F1198
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Apr 2023 08:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjD1GIa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Apr 2023 02:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjD1GI3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Apr 2023 02:08:29 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD2C2735
        for <linux-ext4@vger.kernel.org>; Thu, 27 Apr 2023 23:08:27 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Q72B45rjqz18KVT;
        Fri, 28 Apr 2023 14:04:28 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm100004.china.huawei.com (7.192.105.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 28 Apr 2023 14:08:23 +0800
Subject: Re: [PATCH 3/3] ext4: clean up error handling in __ext4_fill_super()
To:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
CC:     Andreas Dilger <adilger@dilger.ca>
References: <20230428031602.242297-1-tytso@mit.edu>
 <20230428031602.242297-4-tytso@mit.edu>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <674b4a87-6367-46c9-61de-af3b3db2de66@huawei.com>
Date:   Fri, 28 Apr 2023 14:08:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230428031602.242297-4-tytso@mit.edu>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm100004.china.huawei.com (7.192.105.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/4/28 11:16, Theodore Ts'o wrote:
> There were two ways to return an error code; one was via setting the
> 'err' variable, and the second, if err was zero, was via the 'ret'
> variable.  This was both confusing and fragile, and when code was
> factored out of __ext4_fill_super(), some of the error codes returned
> by the original code was replaced by -EINVAL, and in one case, the
> error code was placed by 0, triggering a kernel null pointer
> dereference.
> 
> Clean this up by removing the 'ret' variable, leaving only one way to
> setfthe error code to be returned, and restore the errno codes that

setfthe -> set the? Otherwise looks good to me:

Reviewed-by: Jason Yan <yanaijie@huawei.com>
