Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7C45066F7
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Apr 2022 10:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbiDSIeH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Apr 2022 04:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236306AbiDSIeG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Apr 2022 04:34:06 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D151D6B;
        Tue, 19 Apr 2022 01:31:24 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KjH362C2RzCqx1;
        Tue, 19 Apr 2022 16:26:58 +0800 (CST)
Received: from [10.108.234.194] (10.108.234.194) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Apr 2022 16:31:22 +0800
Message-ID: <5cfcdf43-d33d-c3e2-93c1-feee152cbbec@huawei.com>
Date:   Tue, 19 Apr 2022 16:31:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] ext4, doc: Fix incorrect h_reserved size
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>
CC:     <linux-ext4@vger.kernel.org>, <linux-doc@vger.kernel.org>
References: <34889f32-7dd9-125e-2f7a-734faa395d20@huawei.com>
 <87ee1x2yn3.fsf@meer.lwn.net>
From:   "wangjianjian (C)" <wangjianjian3@huawei.com>
In-Reply-To: <87ee1x2yn3.fsf@meer.lwn.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.108.234.194]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

 >>So this patch looks whitespace-damaged, please be sure that you can send
 >> applyable patches to the list.
Thanks for the notice.

 >> Beyond that, though, while you're in the neighborhood, please fix the
 >> unnecessary underscore escaping (i.e. s/\_/_/).
Sure. Let me fix it.

Thanks,
