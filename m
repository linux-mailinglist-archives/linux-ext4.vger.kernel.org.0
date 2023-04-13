Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084846E0D69
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Apr 2023 14:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjDMM0c (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Apr 2023 08:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjDMM0b (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 13 Apr 2023 08:26:31 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1129359A;
        Thu, 13 Apr 2023 05:26:30 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PxzHb4hLkznbsH;
        Thu, 13 Apr 2023 20:22:51 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 20:26:27 +0800
Message-ID: <d232ab9c-4268-1fc1-5265-64b69e273eca@huawei.com>
Date:   Thu, 13 Apr 2023 20:26:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3 2/8] ext4: add a new helper to check if es must be kept
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <ritesh.list@gmail.com>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <yukuai3@huawei.com>,
        Baokun Li <libaokun1@huawei.com>
References: <20230412124126.2286716-1-libaokun1@huawei.com>
 <20230412124126.2286716-3-libaokun1@huawei.com>
 <20230412185300.rpfwdlxeiptqaxes@quack3>
 <22b3bfef-7a47-036d-125b-180040a0c743@huawei.com>
 <20230413103447.br5wgi6zhaaarcaz@quack3>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230413103447.br5wgi6zhaaarcaz@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/4/13 18:34, Jan Kara wrote:
> On Thu 13-04-23 10:00:56, Baokun Li wrote:
>> Can you please help review the remaining patches for any problems?
>> If you have any suggestions, I'll fix them together and post another version
>> of v4.
> Yes, I've got a bit stuck thinking about the GFP_NOFAIL problem and how to
> best solve it. It will require some changes but most of the patchset can
> stay I believe.
>
> 								Honza

OK! Thank you so much! That's a tricky one indeed.

-- 
With Best Regards,
Baokun Li
.
